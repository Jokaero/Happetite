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
    
    if (empty($membership) or $membership->rsvp != 1 or $event->status != 'open') {
      return $this->_forward('success', 'utility', 'core', array(
          'smoothboxClose' => true,
          'parentRefresh' => false,
          'messages' => array(Zend_Registry::get('Zend_Translate')->_('An error has occurred.'))
      ));
    }
    
    $this->view->form = $form = new Event_Form_Payment();
    
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
