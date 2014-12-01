<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Prefetch.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Event_Plugin_Task_RefreshStatus extends Core_Plugin_Task_Abstract
{
  public function execute()
  {
    //$log = Zend_Registry::get('Zend_Log');
    //$log->log('test!!!', Zend_Log::DEBUG);
    
    $eventTable = Engine_Api::_()->getItemTable('event');
    $eventMembershipTable = Engine_Api::_()->getDbTable('membership', 'event');
    $conversationTable = Engine_Api::_()->getItemTable('messages_conversation');
    
    // Get Super Admin
    $admin = Engine_Api::_()->user()->getSuperAdmins()->current();
    
    
    // ~~~ Check finished events ~~~
    $select = $eventTable->select()
      ->where('endtime <= ?', date('Y-m-d H:i:s'))
      ->where('status = ?', 'open');
    
    foreach($eventTable->fetchAll($select) as $event) {
      // Send message to host
      $message = Zend_Registry::get('Zend_Translate')->_('You have just recently held the Class %1$s. Please confirm that the class has successfully taken place by clicking the button below.%2$s');
      $message = sprintf($message,
        '<a href="' . $event->getHref() . '">' . $event->getTitle() . '</a>',
        '<a href="' . Zend_Controller_Front::getInstance()->getRouter()->assemble(array('action' => 'finish', 'event_id' => $event->getIdentity(), 'format' => 'smoothbox'), 'event_specific') . '" class="smoothbox">'
          . Zend_Registry::get('Zend_Translate')->_('Mark class as finished') . '</a>'
      );
      $conversation = $conversationTable->send($event->getOwner(), $event->getOwner(), Zend_Registry::get('Zend_Translate')->translate('EVENT_HOST_FINISH_SUBJECT'), $message, null, true);
      
      // Send notification
      Engine_Api::_()->getDbtable('notifications', 'activity')->addNotification(
        $event->getOwner(), $admin, $conversation, 'message_system_new'
      );
      
      $event->status = 'finished';
      $event->save();
    }
    
    
    // ~~~ Remove request within 24h ~~~
    $select = $eventMembershipTable->select()
      ->where('rsvp = ?', '0')
      ->where('datetime <= ?', date('Y-m-d H:i:s', time() - 86340));
    
    foreach ($eventMembershipTable->fetchAll($select) as $membership) {
      $event = Engine_Api::_()->getItem('event', $membership->resource_id);
      $user = Engine_Api::_()->getItem('user', $membership->user_id);
      
      if ($event and $user) {
        // Send message to host
        $message = Zend_Registry::get('Zend_Translate')->_('You have recently applied to the class %1$s. Unfortunately %2$s was not able to react to your application within 24 hours, you are most welcome to try and apply again to this class or choose any other class you desire to join.');
        $message = sprintf($message, '<a href="' . $event->getHref() . '">' . $event->getTitle() . '</a>', '<a href="' . $event->getOwner()->getHref() . '">' . $event->getOwner()->getTitle() . '</a>');
        $conversation = $conversationTable->send($user, $user, Zend_Registry::get('Zend_Translate')->translate('EVENT_SYSTEM_USER_TIMEOUT_SUBJECT'), $message, null, true);
        
        // Send notification
        Engine_Api::_()->getDbtable('notifications', 'activity')->addNotification(
          $user, $admin, $conversation, 'message_system_new'
        );
      }
      
      $membership->delete();
    }
    
    
    // ~~~ About to time out  ~~~
    $select = $eventMembershipTable->select()
      ->where('rsvp = ?', '1')
      ->where('datetime <= ?', date('Y-m-d H:i:s', time() - 259200));
    
    foreach ($eventMembershipTable->fetchAll($select) as $membership) {
      $event = Engine_Api::_()->getItem('event', $membership->resource_id);
      $user = Engine_Api::_()->getItem('user', $membership->user_id);
      
      // Send message to member
      $message = Zend_Registry::get('Zend_Translate')->_('Dear %1$s, you were accepted for the class %2$s. We would like to kindly remind you to pay the class fee of %3$s by %4$s.');
      $message = sprintf($message,
        $user->getTitle(),
        '<a href="' . $event->getHref() . '">' . $event->getTitle() . '</a>',
        $event->price . ' ' . $event->currency,
        date('m.d.Y', time() + 86400)
      );
      $conversation = $conversationTable->send($user, $user, Zend_Registry::get('Zend_Translate')->translate('EVENT_SYSTEM_USER_ABOUT_TIMEOUT_SUBJECT'), $message, null, true);
      
      // Send notification
      Engine_Api::_()->getDbtable('notifications', 'activity')->addNotification(
        $user, $admin, $conversation, 'message_system_new'
      );
      
      $membership->rsvp = 2;
      $membership->rsvp_update = date('Y-m-d H:i:s');
      $membership->save();
    }
    
    
    // ~~~ Timed Out ~~~
    $select = $eventMembershipTable->select()
      ->where('rsvp = ?', '2')
      ->where('datetime <= ?', date('Y-m-d H:i:s', time() - 345600));
    
    foreach ($eventMembershipTable->fetchAll($select) as $membership) {
      $event = Engine_Api::_()->getItem('event', $membership->resource_id);
      $user = Engine_Api::_()->getItem('user', $membership->user_id);
      
      // Send message to member
      $message = Zend_Registry::get('Zend_Translate')->_('Dear %1$s, you were accepted for the class %2$s. Unfortunately we have not received the payment of the class fee so far. If you still would like to join the class, you will have to apply again. You are most welcome to apply for any other class you desire to join.');
      $message = sprintf($message, $user->getTitle(), '<a href="' . $event->getHref() . '">' . $event->getTitle() . '</a>');
      $conversation = $conversationTable->send($user, $user, Zend_Registry::get('Zend_Translate')->translate('EVENT_SYSTEM_USER_PAID_TIMEOUT_SUBJECT'), $message, null, true);
      
      // Send notification
      Engine_Api::_()->getDbtable('notifications', 'activity')->addNotification(
        $user, $admin, $conversation, 'message_system_new'
      );
      
      // Send message to host
      $message = Zend_Registry::get('Zend_Translate')->_('You have recently accepted %1$s to the class %2$s. Unfortunately %1$s has not paid within the given timeframe of three days. He was notified that he has not paid and that he has to apply for the class again if he still wants to join.');
      $message = sprintf($message, '<a href="' . $user->getHref() . '">' . $user->getTitle() . '</a>', '<a href="' . $event->getHref() . '">' . $event->getTitle() . '</a>');
      $conversation = $conversationTable->send($event->getOwner(), $event->getOwner(), Zend_Registry::get('Zend_Translate')->translate('EVENT_SYSTEM_USER_PAID_TIMEOUT_SUBJECT'), $message, null, true);
      
      // Send notification
      Engine_Api::_()->getDbtable('notifications', 'activity')->addNotification(
        $event->getOwner(), $admin, $conversation, 'message_system_new'
      );
      
      $membership->delete();
    }
  }
}