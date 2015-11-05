<?php

class Event_Model_DbTable_Transactions extends Engine_Db_Table
{
  protected $_rowClass = "Event_Model_Transaction";
  
  public function getTransactionPaginator($params = array())
  {
    return Zend_Paginator::factory($this->getTransactionSelect($params));
  }
  
  public function getTransactionSelect($params = array())
  {
    $transactionTableName = $this->info('name');
    $userTable = Engine_Api::_()->getItemTable('user');
    $userTableName = $userTable->info('name');
    $eventTable = Engine_Api::_()->getItemTable('event');
    $eventTableName = $eventTable->info('name');
    
    $select = $this->select()
      ->from($transactionTableName)
      ->joinLeft($userTableName, "$userTableName.user_id = $transactionTableName.user_id", null)
      ->joinLeft($eventTableName, "$eventTableName.event_id = $transactionTableName.event_id", null);
    
    if (!empty($params['event_id'])) {
      $select->where("$transactionTableName.event_id = ?", $params['event_id']);
    }
    
    if (!empty($params['user_id'])) {
      $select->where("$transactionTableName.user_id = ?", $params['user_id']);
    }
    
    if (!empty($params['user'])) {
      $select->where("$userTableName.displayname LIKE ?", '%' . $params['user'] . '%');
    }
    
    if (!empty($params['course'])) {
      $select->where("$eventTableName.title LIKE ?", '%' . $params['course'] . '%');
    }
    
    if (!empty($params['status'])) {
      $select->where("$transactionTableName.status = ?", $params['status']);
    }
    
    if (!empty($params['order'])) {
      $select->order($params['order']);
    } else {
      $select->order('transaction_id DESC');
    }
    
    //echo '<pre>'; print_r( (string)$select ); echo '</pre>'; exit;
    return $select;
  }
  
  /*
   * Create transaction
   * 
   * @param array $params
   * @return array|bool
   */
  public function createTransaction($params)
  {
    // @todo Params testing
    
    // Get data
    $event = $params['event'];
    $user = $params['user'];
    $sitePercent = Engine_Api::_()->getApi('settings', 'core')
      ->getSetting('event_percent', 10);
    
    // Calculate full price
    $fullPrice = ceil($event->price * (1 + $sitePercent / 100));
    $priceServiceFee = $fullPrice - $event->price;
    
    $userStatus = Zend_Registry::get('Zend_Translate')->_('Guest');
    if ($event->isOwner($user)) {
      $userStatus = Zend_Registry::get('Zend_Translate')->_('Owner');
    }
    
    // Create transaction
    $transaction = $this->createRow();
    $transaction->setFromArray(array(
      'event_id'      => $event->getIdentity(),
      'event_title'   => $event->getTitle(),
      'user_id'       => $user->getIdentity(),
      'user_title'    => $user->getTitle(),
      'user_status'   => $userStatus,
      'status'        => 'pending',
      'price'         => $fullPrice,
      'price_service_fee' => $priceServiceFee,
      'currency'      => $event->currency,
      'creation_date' => date('Y-m-d H:i:s'),
      'modified_date' => date('Y-m-d H:i:s')
    ));
    $transaction->save();
    
    // Get merchant account id
    $settings = Engine_Api::_()->getApi('settings', 'core');
    $merchantAccountId = $settings->getSetting('merchant_account_' . strtolower($event->currency));
    
    // Send Request
    $result = Braintree_Transaction::sale(array(
      'amount'      => $fullPrice,
      'orderId'     => $transaction->getIdentity(),
      'merchantAccountId' => $merchantAccountId,
      'creditCard'  => array(
        'number'          => $params['card']['card_number'],
        'expirationMonth' => $params['card']['card_expiration_month'],
        'expirationYear'  => $params['card']['card_expiration_year'],
        'cardholderName'  => $params['card']['cardholder_name'],
        'cvv'             => $params['card']['cvv'],
      )
    ));
    
    if (empty($result->success) and !empty($result->errors)) {
      $transaction->delete();
      
      $return = array(
        'status' => false,
        'error' => '',
      );
      
      foreach($result->errors->deepAll() as $error) {
        $return['error'][] = $error->code . ": " . $error->message;
      }
      
      return $return;
    } else if (empty($result->success)) {
      $transaction->delete();
      
      return array(
        'status' => false,
        'error' => Zend_Registry::get('Zend_Translate')->_('An error has occurred.'),
      );
    }
    
    // Submitting transaction for settlement
    $settlementResult = Braintree_Transaction::submitForSettlement($result->transaction->id);
    
    // Success transaction
    if (!empty($settlementResult) and $settlementResult->success == 1) { // @todo Add currency test
      
      // Change transaction status
      $transaction->setFromArray(array(
        'status'        => 'completed',
        'currency'      => $result->transaction->currencyIsoCode,
        'creation_date' => date('Y-m-d H:i:s'),
        'modified_date' => date('Y-m-d H:i:s'),
        'tid'           => $result->transaction->id,
        'ttype'         => $result->transaction->type,
        'tstatus'       => $result->transaction->status
      ));
      $transaction->save();
      
      // Change member status
      $event->membership()->setResourceApproved($user);
      $row = $event->membership()->getRow($user);
      $row->rsvp_update = date('Y-m-d H:i:s');
      $row->rsvp = 3;
      $row->save();
      
      // Send message to member
      $admin = Engine_Api::_()->user()->getSuperAdmins()->current();
      $message = Zend_Registry::get('Zend_Translate')->_('Thank you for your payment. You are now fully approved for the class %s.');
      $message = sprintf($message,
        '<a href="' . $event->getHref() . '">' . $event->getTitle() . '</a>'
      );
      $conversation = Engine_Api::_()->getItemTable('messages_conversation')
        ->send($user, $user, Zend_Registry::get('Zend_Translate')->translate('EVENT_USER_USER_PAID_SUBJECT'), $message, null, true);
      
      // Send notification
      Engine_Api::_()->getDbtable('notifications', 'activity')->addNotification(
        $user, $admin, $conversation, 'message_system_new'
      );
      
      
      return true;
    } else if (!empty($settlementResult) and !$settlementResult->success) { // @todo Test status
      $transaction->delete();
      
      $return = array(
        'status' => false,
        'error' => '',
      );
      
      foreach($settlementResult->errors->deepAll() as $error) {
        $return['error'][] = $error->message;
      }
      
      return $return;
      
    } else {
      $transaction->delete();
      
      return array(
        'status' => false,
        'error' => Zend_Registry::get('Zend_Translate')->_('An error has occurred.'),
      );
    }
    
    return false;
  }
  
  public function refundTransaction(User_Model_User $user, Event_Model_Event $event, $params = array())
  {
    // Get Transaction
    $transaction = $this->fetchRow(array(
      'user_id = ?' => $user->getIdentity(),
      'event_id = ?' => $event->getIdentity(),
    ));
    
    if (empty($transaction)) {
      return false;
    }
    
    if ((int) $transaction->price_service_fee) {
      $refundPriceServiceFee = $transaction->price_service_fee;
      $refundPrice = ($transaction->price - $transaction->price_service_fee);
    } else {
      $refundPriceServiceFee = ($transaction->price - $event->price);
      $refundPrice = $event->price;
    }
    
    $userStatus = Zend_Registry::get('Zend_Translate')->_('Guest');
    if ($event->isOwner($user)) {
      $userStatus = Zend_Registry::get('Zend_Translate')->_('Owner');
    }
    
    $refundTransaction = $this->createRow();
    $refundTransaction->setFromArray(array(
      'event_id' => $event->getIdentity(),
      'event_title' => $event->getTitle(),
      'user_id' => $user->getIdentity(),
      'user_title' => $user->getTitle(),
      'user_status' => $userStatus,
      'status' => 'pending',
      'price' => $refundPrice * (-1),
      'price_service_fee' => $refundPriceServiceFee * (-1),
      'currency' => $transaction->currency,
      'creation_date' => date('Y-m-d H:i:s'),
      'modified_date' => date('Y-m-d H:i:s')
    ));
    $refundTransaction->save();
    
    // Send Request
    $result = Braintree_Transaction::refund($transaction->tid, $refundPrice);
    
    if ($result and $result->success == 1) {
      $refundTransaction->tid = $result->transaction->id;
      $refundTransaction->ttype = $result->transaction->type;
      $refundTransaction->modified_date = date('Y-m-d H:i:s');
      $refundTransaction->status = 'completed';
      $refundTransaction->save();
      
      // Change status
      $event->membership()->removeMember($user);
      
      // @todo Send message to ... (No in Spec)
      
      return true;
    } else if ($result and $result->success != 1) {
      $refundTransaction->delete();
      
      $return = array(
        'status' => false,
        'error' => '',
      );
      
      foreach($result->errors->deepAll() as $error) {
        $return['error'][] = $error->code . ": " . $error->message;
      }
      
      return $return;
      
    } else {
      $transaction->delete();
      
      return array(
        'status' => false,
        'error' => Zend_Registry::get('Zend_Translate')->_('An error has occurred.'),
      );
    }
    
  }
  
  public function getPayment(User_Model_User $user, Event_Model_Event $event, $params = array())
  {
    $sitePercent = Engine_Api::_()->getApi('settings', 'core')
      ->getSetting('event_percent', 10) + 100;
    
    $select = $this->select()
      ->from($this, array('payment' => 'SUM(price)', 'currency'))
      ->where('user_id = ?', $user->getIdentity())
      ->where('event_id = ?', $event->getIdentity());
    
    if (!$event->isOwner($user)) {
      return ceil(@$this->fetchRow($select)->payment)
        . ' ' . @$this->fetchRow($select)->currency;
    } else {
      $payment = ceil(@$this->fetchRow($select)->payment);
      
      $select = $this->select()
        ->from($this, array('payment' => "(SUM(price) * 100) / $sitePercent", 'currency'))
        ->where('user_id <> ?', $user->getIdentity())
        ->where('event_id = ?', $event->getIdentity());
      $membersPayment = ceil(@$this->fetchRow($select)->payment);
      
      $payment = ceil(abs($payment) - $membersPayment);
      
      if (isset($params['currency']) and $params['currency'] == false) {
        return $payment;
      }
      
      return $payment . ' ' . $event->currency;
    }
  }
}