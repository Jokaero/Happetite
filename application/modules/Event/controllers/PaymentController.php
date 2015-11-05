<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: IndexController.php 10264 2014-06-06 22:08:42Z lucas $
 * @author     Sami
 */

/**
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @author     Sami
 */
class Event_PaymentController extends Core_Controller_Action_Standard
{
  public function payAction()
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $event = Engine_Api::_()->getItem('event', (int) $this->_getParam('id'));
    
    if (empty($viewer) or empty($event)) {
      return $this->_forward('success', 'utility', 'core', array(
          'smoothboxClose' => true,
          'parentRefresh' => false,
          'messages' => array(Zend_Registry::get('Zend_Translate')->_('An error has occurred.'))
      ));
    }
    
    $membership = $event->membership()->getRow($viewer);
    
    if (empty($membership) or !in_array($membership->rsvp, array(1, 2)) or $event->status != 'open') {
      return $this->_forward('success', 'utility', 'core', array(
          'smoothboxClose' => 5000,
          'parentRefresh' => false,
          'messages' => array(Zend_Registry::get('Zend_Translate')->_('You can\'t pay for this class as you\'re not accepted for it anymore'))
      ));
    }
     
    $sitePercent = Engine_Api::_()->getApi('settings', 'core')
      ->getSetting('event_percent', 10);
    $form_price = ceil($event->price * (1 + $sitePercent / 100));

    $this->view->form = $form = new Event_Form_Payment(array('event' => $form_price . ' ' . $event->currency));
    
    if( !$this->getRequest()->isPost() ) {
        return;
    }
    
    if( !$form->isValid($this->getRequest()->getPost()) ) {
        return;
    }
    
    $values = array(
      'card' => $form->getValues(),
      'user' => $viewer,
      'event' => $event
    );
    
    if ($values['card']['card_type'] == 1) {
      $valid_card = new Zend_Validate_CreditCard(
        Zend_Validate_CreditCard::MASTERCARD
      );
      
      if (!$valid_card->isValid($values['card']['card_number'])) {
        $message = Zend_Registry::get('Zend_Translate')->_('Credit card number you have entered does not match card type you selected.');
        $form->addError($message);
        return;
      }
    } else {
      $valid_card = new Zend_Validate_CreditCard(
          Zend_Validate_CreditCard::VISA
      );
      
      if (!$valid_card->isValid($values['card']['card_number'])) {
        $message = Zend_Registry::get('Zend_Translate')->_('Credit card number you have entered does not match card type you selected.');
        $form->addError($message);
        return;
      }
    }
    
    $transactionTable = Engine_Api::_()->getItemTable('event_transaction');
    $db = $transactionTable->getAdapter();
    $db->beginTransaction();
    
    try {
      $result = $transactionTable->createTransaction($values);
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
  
  public function successAction()
  {
    $this->view->subject = $event = Engine_Api::_()->getItem('event', (int) $this->_getParam('id'));
  }
}
