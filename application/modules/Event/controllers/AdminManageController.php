<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: AdminManageController.php 9747 2012-07-26 02:08:08Z john $
 * @author     Jung
 */

/**
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Event_AdminManageController extends Core_Controller_Action_Admin
{
  public function indexAction()
  {
    $this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
      ->getNavigation('event_admin_main', array(), 'event_admin_main_manage');

    // Filter form init
    $this->view->formFilter = $formFilter = new Event_Form_Admin_Filter_Classes();
    
    // If send form
    if ($this->getRequest()->isPost()) {
      $values = $this->getRequest()->getPost();
      
      foreach ($values as $key => $value) {
        if ($key == 'delete_' . $value)
        {
          $event = Engine_Api::_()->getItem('event', $value);
          $event->delete();
        }
      }
    }

    // Process form
    $values = array();
    if( $formFilter->isValid($this->_getAllParams()) ) {
      $values = $formFilter->getValues();
    }
    
    foreach( $values as $key => $value ) {
      if( null === $value ) {
        unset($values[$key]);
      }
    }
    
    $this->view->assign($values);
    $values['order'] = 'event_id DESC';
    
    $page = $this->_getParam('page', 1);
    
    if (isset($values['is_action']) and $values['is_action'] != -1) {
      $eventTable = Engine_Api::_()->getItemTable('event');
      $select = $eventTable->getEventSelect($values);
      $paginator = array();
      
      foreach($eventTable->fetchAll($select) as $event) {
        if ($values['is_action'] == 1 and $event->is_action > 0
            or $values['is_action'] == 0 and $event->is_action == 0) {
          $paginator[] = $event;
        }
      }
      
      $paginator = Zend_Paginator::factory($paginator);
      
    } else {
      $paginator = Engine_Api::_()->getItemTable('event')->getEventPaginator($values);
    }
    
    $this->view->paginator = $paginator;
    $this->view->paginator->setItemCountPerPage(25);
    $this->view->paginator->setCurrentPageNumber($page);
  }
  
  
  public function usersAction()
  {
    $this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
      ->getNavigation('event_admin_main', array(), 'event_admin_main_manage_users');
    
    // Filter form init
    $this->view->formFilter = $formFilter = new Event_Form_Admin_Filter_Users();
    
    // Process form
    $values = array();
    if( $formFilter->isValid($this->_getAllParams()) ) {
      $values = $formFilter->getValues();
    }
    
    foreach( $values as $key => $value ) {
      if( null === $value ) {
        unset($values[$key]);
      }
    }
    
    $this->view->assign($values);
    
    $values = array_merge(
      $values,
      array(
        'group' => 'user_id'
      )
    );
    
    $table = Engine_Api::_()->getDbTable('membership', 'event');
    $members = $table->getAllMembers($values, null);
    
    $this->view->paginator = $paginator = Zend_Paginator::factory($members);
    $paginator->setItemCountPerPage(25);
    $paginator->setCurrentPageNumber((int) $this->_getParam('page'));
  }
  
  
  public function coursesUsersAction()
  {
    $event = Engine_Api::_()->getItem('event', $this->_getParam('event_id'));
    
    if (empty($event)) {
      $this->_redirectCustom(array('route' => 'admin_default', 'module' => 'event', 'controller' => 'manage'));
    }
    
    $this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
      ->getNavigation('event_admin_main', array(), 'event_admin_main_manage');
    
    // Filter form init
    $this->view->formFilter = $formFilter = new Event_Form_Admin_Filter_CoursesUsers();
    $formFilter->removeElement('course');
    
    // Process form
    $values = array();
    if( $formFilter->isValid($this->_getAllParams()) ) {
      $values = $formFilter->getValues();
    }
    
    foreach( $values as $key => $value ) {
      if( null === $value ) {
        unset($values[$key]);
      }
    }
    
    $this->view->assign($values);
    
    $values = array_merge(
      array('event_id' => $event->getIdentity()),
      $values
    );
    
    $table = Engine_Api::_()->getDbTable('membership', 'event');
    $members = $table->getAllMembers($values, null);
    
    $this->view->paginator = $paginator = Zend_Paginator::factory($members);
    $paginator->setItemCountPerPage(25);
    $paginator->setCurrentPageNumber((int) $this->_getParam('page'));
  }
  
  
  public function usersCoursesAction()
  {
    $user = Engine_Api::_()->getItem('user', $this->_getParam('user_id'));
    
    if (empty($user) or !$user->getIdentity()) {
      $this->_redirectCustom(array('route' => 'admin_default', 'module' => 'event', 'controller' => 'manage', 'action' => 'users'));
    }
    
    $this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
      ->getNavigation('event_admin_main', array(), 'event_admin_main_manage_users');
    
    // Filter form init
    $this->view->formFilter = $formFilter = new Event_Form_Admin_Filter_CoursesUsers();
    $formFilter->removeElement('user');
    
    // Process form
    $values = array();
    if( $formFilter->isValid($this->_getAllParams()) ) {
      $values = $formFilter->getValues();
    }
    
    foreach( $values as $key => $value ) {
      if( null === $value ) {
        unset($values[$key]);
      }
    }
    
    $this->view->assign($values);
    
    $values = array_merge(
      array('user_id' => $user->getIdentity()),
      $values
    );
    
    $table = Engine_Api::_()->getDbTable('membership', 'event');
    $members = $table->getAllMembers($values, null);
    
    $this->view->paginator = $paginator = Zend_Paginator::factory($members);
    $paginator->setItemCountPerPage(25);
    $paginator->setCurrentPageNumber((int) $this->_getParam('page'));
  }
  
  
  public function userRefundAction()
  {
    $user = Engine_Api::_()->getItem('user', $this->_getParam('user_id'));
    $event = Engine_Api::_()->getItem('event', $this->_getParam('event_id'));
    
    // In smoothbox
    $this->_helper->layout->setLayout('admin-simple');
    
    if (empty($event) or !$user->getIdentity()) {
      return $this->_forward('success', 'utility', 'core', array(
          'smoothboxClose' => true,
          'parentRefresh' => false,
          'messages' => array(Zend_Registry::get('Zend_Translate')->_('An error has occurred.'))
      ));
    }
    
    // Get Transaction
    $transactionTable = Engine_Api::_()->getItemTable('event_transaction');
    $transaction = $transactionTable->fetchRow(array(
      'user_id = ?' => $user->getIdentity(),
      'event_id = ?' => $event->getIdentity(),
    ));
    
    if (empty($transaction)) {
      return $this->_forward('success', 'utility', 'core', array(
          'smoothboxClose' => true,
          'parentRefresh' => false,
          'messages' => array(Zend_Registry::get('Zend_Translate')->_('An error has occurred.'))
      ));
    }
    
    // Test status transaction
    $btTransaction = Braintree_Transaction::find($transaction->tid);
    
    if (empty($btTransaction) or empty($btTransaction->status)) {
      return $this->_forward('success', 'utility', 'core', array(
          'smoothboxClose' => true,
          'parentRefresh' => false,
          'messages' => array(Zend_Registry::get('Zend_Translate')->_('An error has occurred.'))
      ));
    }
    
    if ($btTransaction->status != 'settled' and $btTransaction->status != 'settling') {
      return $this->_forward('success', 'utility', 'core', array(
        'smoothboxClose' => 5000,
        'parentRefresh' => false,
        'messages' => array(Zend_Registry::get('Zend_Translate')->_('You can\'t refund payment until after payment has been settled in Braintree. Typically they settle payments once per 24 hours.'))
      ));
    }
    
    $this->view->form = $form = new Event_Form_Admin_Refund();
    
    if( !$this->getRequest()->isPost() ) {
      return;
    }
    
    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }
    
    $db = Engine_Api::_()->getItemTable('event_transaction')->getAdapter();
    $db->beginTransaction();
    
    try {
      $result = Engine_Api::_()->getItemTable('event_transaction')->refundTransaction($user, $event);
      $db->commit();
      
      if ($result === true) {
        return $this->_forward('success', 'utility', 'core', array(
          'smoothboxClose' => true,
          'parentRedirect' => Zend_Controller_Front::getInstance()->getRouter()->assemble(array('action' => 'success', 'id' => $event->getIdentity()), 'event_payment', true),
          'messages' => array(Zend_Registry::get('Zend_Translate')->_('Thank you for your payment.'))
        ));
      } else if (!empty($result['error'])) {
        $message = $result['error'];
        $form->addErrors($message);
        return;
      
      } else {
        $message = Zend_Registry::get('Zend_Translate')->_('An error has occurred.');
        $form->addError($message);
        return;
      }
      
    } catch( Exception $e ) {
      $db->rollBack();
      $message = Zend_Registry::get('Zend_Translate')->_('An error has occurred.');
    }
    
    return $this->_forward('success', 'utility', 'core', array(
      'smoothboxClose' => true,
      'parentRefresh' => false,
      'messages' => array($message)
    ));
  }
  
  
  public function transactionsAction()
  {
    $this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
      ->getNavigation('event_admin_main', array(), 'event_admin_main_manage_transactions');
    
    // Filter form init
    $this->view->formFilter = $formFilter = new Event_Form_Admin_Filter_Transactions();
    
    // Process form
    $values = array();
    if( $formFilter->isValid($this->_getAllParams()) ) {
      $values = $formFilter->getValues();
    }
    
    foreach( $values as $key => $value ) {
      if( null === $value ) {
        unset($values[$key]);
      }
    }
    
    $this->view->assign($values);
    
    $values = array_merge($values, array(
      'event_id' => $this->_getParam('event_id'),
      'user_id'  => $this->_getParam('user_id')
    ));
    
    $table = Engine_Api::_()->getDbTable('transactions', 'event');
    $this->view->paginator = $paginator = $table->getTransactionPaginator($values);
    $paginator->setItemCountPerPage(25);
    $paginator->setCurrentPageNumber((int) $this->_getParam('page'));
  }
  
  public function detailTransactionAction()
  {
    $transaction_id = $this->_getParam('transaction_id');
    $transaction = Engine_Api::_()->getItem('event_transaction', $transaction_id);
    $this->view->transaction = $transaction;
    $this->view->event = $transaction->getEvent();
    $this->view->user = $transaction->getOwner();
  }
  
  public function editTransactionAction()
  {
    $transaction_id = $this->_getParam('transaction_id');
    $transaction = Engine_Api::_()->getItem('event_transaction', $transaction_id);
    $this->view->transaction = $transaction;
    $this->view->event = $event = $transaction->getEvent();
    $this->view->user = $user = $transaction->getOwner();
    
    // In smoothbox
    $this->_helper->layout->setLayout('admin-simple');
    
    $this->view->form = $form = new Event_Form_Admin_Transaction();
    
    if( !$this->getRequest()->isPost() ) {
      $form->transaction_status->setValue($transaction->status);
      return;
    }
    
    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }
    
    $values = $form->getValues();
    
    $db = $transaction->getTable()->getAdapter();
    $db->beginTransaction();
    
    try {
      $row = $event->membership()->getRow($user);
      
      if (!empty($row)) {
        // Change status to Paid
        if ($values['transaction_status'] == 'completed') {
          $event->membership()->setResourceApproved($user);
          $row->rsvp = 3;
        
        // Change status to Refaunded
        } else if ($values['transaction_status'] == 'refunded') {
          $row->active = false;
          $row->resource_approved = false;
          $row->rsvp = 4;
        
        // Change status to Other
        } else {
          $row->active = false;
          $row->resource_approved = false;
          $row->rsvp = 1;
        }
        
        $row->rsvp_update = date('Y-m-d H:i:s');
        $row->save();
      }
      
      if ($values['transaction_status'] == 'refunded' and $transaction->price > 0
          or $values['transaction_status'] != 'refunded' and $transaction->price < 0) {
        $transaction->price *= -1;
      }
      
      $transaction->status = $form->getValue('transaction_status');
      $transaction->modified_date = date('Y-m-d H:i:s');
      $transaction->save();
      
      $db->commit();
      $message = Zend_Registry::get('Zend_Translate')->_('Success.');
    } catch( Exception $e ) {
      $db->rollBack();
      $message = Zend_Registry::get('Zend_Translate')->_('An error has occurred.');
    }
    
    return $this->_forward('success', 'utility', 'core', array(
        'smoothboxClose' => true,
        'parentRefresh' => true,
        'messages' => array($message)
    ));
  }
  
  public function payHostAction()
  {
    $user = Engine_Api::_()->getItem('user', $this->_getParam('user_id'));
    $event = Engine_Api::_()->getItem('event', $this->_getParam('event_id'));
    
    $this->view->form = $form = new Event_Form_Admin_Pay(array(
      'user' => $user,
      'event' => $event
    ));
    
    if( !$this->getRequest()->isPost() ) {
      return;
    }
    
    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }
    
    $membersTable = Engine_Api::_()->getDbTable('membership', 'event');
    $values = array('event_id' => $event->getIdentity());
    $members = $membersTable->getAllMembers($values, null);
    
    foreach($members as $member) {
      if ($member->rsvp != 4) {
        continue;
      }
      
      return $this->_forward('success', 'utility', 'core', array(
          'smoothboxClose' => 7000,
          'parentRefresh' => false,
          'messages' => array(Zend_Registry::get('Zend_Translate')
            ->_("At first you need to refund money to users who cancelled their attendance, after that you'll be able to pay money to host."))
      ));
    }
    
    $price = Engine_Api::_()->getItemTable('event_transaction')
      ->getPayment($user, $event, array('currency' => false));
    $datetime = date('Y-m-d H:i:s');
    
    $userStatus = Zend_Registry::get('Zend_Translate')->_('Guest');
    if ($event->isOwner($user)) {
      $userStatus = Zend_Registry::get('Zend_Translate')->_('Owner');
    }
    
    $values = array(
      'event_id' => $event->getIdentity(),
      'event_title' => $event->getTitle(),
      'user_id' => $user->getIdentity(),
      'user_title' => $user->getTitle(),
      'user_status' => $userStatus,
      'status' => 'completed',
      'price' => $price,
      'currency' => $event->currency,
      'creation_date' => $datetime,
      'modified_date' => $datetime,
    );
    
    $transactionTable = Engine_Api::_()->getItemTable('event_transaction');
    $db = $transactionTable->getAdapter();
    $db->beginTransaction();
    
    try {
      $transaction = $transactionTable->createRow();
      $transaction->setFromArray($values);
      $transaction->save();
      
      $event->status = 'closed';
      $event->save();
      
      $db->commit();
      $message = Zend_Registry::get('Zend_Translate')->_('Success.');
    } catch( Exception $e ) {
      $db->rollBack();
      $message = Zend_Registry::get('Zend_Translate')->_('An error has occurred.');
    }
    
    return $this->_forward('success', 'utility', 'core', array(
      'smoothboxClose' => true,
      'parentRefresh' => true,
      'messages' => array($message)
    ));
  }
  
  public function exportTransactionsAction()
  {
    $filename = "export_" . date("Y-m-d") . ".csv";
    $now = gmdate("D, d M Y H:i:s");
    header("Expires: Tue, 03 Jul 2001 06:00:00 GMT");
    header("Cache-Control: max-age=0, no-cache, must-revalidate, proxy-revalidate");
    header("Last-Modified: {$now} GMT");

    // force download  
    header("Content-Type: application/force-download");
    header("Content-Type: application/octet-stream");
    header("Content-Type: application/download");

    // disposition / encoding on response body
    header("Content-Disposition: attachment;filename={$filename}");
    header("Content-Transfer-Encoding: binary");
    
    $transactions = Engine_Api::_()->getItemTable('event_transaction')->fetchAll();
    
    ob_start();
    $df = fopen("php://output", 'w');
    
    fputcsv($df, array('transaction_id', 'event_id', 'user_id', 'status', 'price',
      'currency', 'creation_date', 'modified_date', 'tid', 'ttype'
    ));
    
    foreach($transactions as $transaction) {
      fputcsv($df, $transaction->toArray());
    }
    
    exit;
  }
  
  public function deleteAction()
  {
    // In smoothbox
    $this->_helper->layout->setLayout('admin-simple');
    $id = $this->_getParam('id');
    $this->view->event_id=$id;
    // Check post
    if( $this->getRequest()->isPost())
    {
      $db = Engine_Db_Table::getDefaultAdapter();
      $db->beginTransaction();

      try
      {
        $event = Engine_Api::_()->getItem('event', $id);
        $event->delete();
        $db->commit();
      }

      catch( Exception $e )
      {
        $db->rollBack();
        throw $e;
      }

      $this->_forward('success', 'utility', 'core', array(
          'smoothboxClose' => 10,
          'parentRefresh'=> 10,
          'messages' => array('')
      ));
    }
    // Output
    $this->renderScript('admin-manage/delete.tpl');
  }
}