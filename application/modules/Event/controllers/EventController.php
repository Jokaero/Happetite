<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: EventController.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Event_EventController extends Core_Controller_Action_Standard
{
  public function init()
  {
    $id = $this->_getParam('event_id', $this->_getParam('id', null));
    if( $id )
    {
      $event = Engine_Api::_()->getItem('event', $id);
      if( $event )
      {
        Engine_Api::_()->core()->setSubject($event);
      }
    }
  }
  
  public function editAction()
  {
    $event_id = $this->getRequest()->getParam('event_id');
    $event = Engine_Api::_()->getItem('event', $event_id);
    $viewer = Engine_Api::_()->user()->getViewer();
    if( !($this->_helper->requireAuth()->setAuthParams(null, null, 'edit')->isValid() || $event->isOwner($viewer)) ) {
      return;
    }
    
    if ($event->status == 'closed' or $event->status == 'finished' or $event->status == 'canceled' or $event->status == 'verified') {
      if( !($this->_helper->requireAuth()->setAuthParams(null, null, 'comment')->isValid() || $event->isOwner($viewer)) ) {
        return;
      } 
    }
    
    // Create form
    $event = Engine_Api::_()->core()->getSubject();
    $this->view->form = $form = new Event_Form_Edit(array('parent_type'=>$event->parent_type, 'parent_id'=>$event->parent_id));

    // Populate with categories
    $categories = Engine_Api::_()->getDbtable('categories', 'event')->getCategoriesAssoc();
    asort($categories, SORT_LOCALE_STRING);
    
    $categoryOptions = array('' => '');
    foreach( $categories as $k => $v ) {
      $categoryOptions[$k] = $v;
    }
    if (sizeof($categoryOptions) <= 1) {
      $form->removeElement('category_id');
    } else {
      $form->category_id->setMultiOptions($categoryOptions);
    }

    $membersCount = count(Engine_Api::_()->getDbTable('membership', 'event')
        ->getAllMembers(array(
      'event_id' => $event->getIdentity(),
      'status' => '0,1,2,3'
    ), null));
    
    if( !$this->getRequest()->isPost() ) {
      // Populate auth
      $auth = Engine_Api::_()->authorization()->context;

      if( $event->parent_type == 'group' ) {
        $roles = array('owner', 'member', 'parent_member', 'registered', 'everyone');
      } else {
        $roles = array('owner', 'member', 'owner_member', 'owner_member_member', 'owner_network', 'registered', 'everyone');
      }

      foreach( $roles as $role ) {
        if( isset($form->auth_view->options[$role]) && $auth->isAllowed($event, $role, 'view') ) {
          $form->auth_view->setValue($role);
        }
        if( isset($form->auth_comment->options[$role]) && $auth->isAllowed($event, $role, 'comment') ) {
          $form->auth_comment->setValue($role);
        }
        if( isset($form->auth_photo->options[$role]) && $auth->isAllowed($event, $role, 'photo') ) {
          $form->auth_photo->setValue($role);
        }
      }
      $form->auth_invite->setValue($auth->isAllowed($event, 'member', 'invite'));
      $form->populate($event->toArray());

      // Convert and re-populate times
      $start = strtotime($event->starttime);
      $end = strtotime($event->endtime);
      $oldTz = date_default_timezone_get();
      date_default_timezone_set($viewer->timezone);
      $start = date('Y-m-d H:i:s', $start);
      $end = date('Y-m-d H:i:s', $end);
      date_default_timezone_set($oldTz);

      $form->populate(array(
        'starttime' => $start,
        'duration' => (strtotime($end) - strtotime($start)) / 3600,
      ));
      
      if ($membersCount or $event->status != 'open') {
        $form->removeElement('starttime');
        $form->removeElement('duration');
      }
      
      return;
    }
    
    if ($membersCount or $event->status != 'open') {
      $form->removeElement('starttime');
      $form->removeElement('duration');
    }

    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }

    // Process
    $values = $form->getValues();

    if (!$membersCount) {
      // Convert times
      $values['endtime'] = date('Y-m-d H:i:s', strtotime($form->getValue('starttime')) + $form->getValue('duration') * 3600);
      $oldTz = date_default_timezone_get();
      date_default_timezone_set($viewer->timezone);
      $start = strtotime($values['starttime']);
      $end = strtotime($values['endtime']);
      date_default_timezone_set($oldTz);
      //$values['currency'] =  'CHF';
      $values['starttime'] = date('Y-m-d H:i:s', $start);
      $values['endtime'] = date('Y-m-d H:i:s', $end);
    }
    
    $values['search'] = 1;
    $values['approval'] = 0;
    $values['auth_invite'] = 1;
    $values['approval'] = 1;
    
    // Check parent
    if( !isset($values['host']) && $event->parent_type == 'group' && Engine_Api::_()->hasItemType('group') ) {
     $group = Engine_Api::_()->getItem('group', $event->parent_id);
     $values['host']  = $group->getTitle();
    } else {
      $values['host']  = $viewer->getTitle();
    }
    
    $photo = $form->photo->getFileInfo();
    
    if (!empty($photo['photo']['tmp_name'])) {
      $values['photo_obj'] = $photo['photo'];
    }
    
    $_SESSION['event_values'] = $values;
   
    return $this->_helper->redirector->gotoRoute(array('action' => 'edit-bank', 'event_id' => $event->getIdentity()), 'event_specific', true);
  }
  
  public function editBankAction()
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    
    $event_id = $this->_getParam('event_id', 0);
    
    if ($event_id <= 0) {
      return;
    }
    
    $event = Engine_Api::_()->getItem('event', $event_id);
    
    $eventDataArray = array();
    foreach ($event as $key => $value) {
      $eventDataArray[$key] = $value;
    }
    
    $values = $_SESSION['event_values'];
    $form = $this->view->form = new Event_Form_Bank();
    $form->populate($eventDataArray);
    
    if( !$this->getRequest()->isPost() ) {
      return;
    }

    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }
    
    $bankValue = $form->getValues();
    
    // Check IBAN number
    $IBAN_number = !empty($bankValue['bank_iban']) ? $bankValue['bank_iban'] : '';
    
    if ($IBAN_number) {
      $IBAN_number = str_replace(' ', '', $IBAN_number);
      
      if (!preg_match('/[a-zA-Z]{2}[0-9]{2}[a-zA-Z0-9]{4}[0-9]{7}([a-zA-Z0-9]?){0,16}/', $IBAN_number)) {
        return $form->addError(Zend_Registry::get('Zend_Translate')->_("IBAN number you have entered is incorrect, please enter a correct IBAN number and try again!"));
      }
    }
    
    $values = array_merge($bankValue, $values);
    
    // Process
    $db = Engine_Api::_()->getItemTable('event')->getAdapter();
    $db->beginTransaction();

    try
    {
      // Set event info
      $event->setFromArray($values);
      $event->save();

      if( !empty($values['photo_obj']) ) {
        $event->setPhoto($values['photo_obj']);
      }

      // Process privacy
      $auth = Engine_Api::_()->authorization()->context;

      if( $event->parent_type == 'group' ) {
        $roles = array('owner', 'member', 'parent_member', 'registered', 'everyone');
      } else {
        $roles = array('owner', 'member', 'owner_member', 'owner_member_member', 'owner_network', 'registered', 'everyone');
      }
      
      if( empty($values['auth_view']) ) {
        $values['auth_view'] = 'everyone';
      }

      if( empty($values['auth_comment']) ) {
        $values['auth_comment'] = 'everyone';
      }

      $viewMax = array_search($values['auth_view'], $roles);
      $commentMax = array_search($values['auth_comment'], $roles);
      $photoMax = array_search($values['auth_photo'], $roles);

      foreach( $roles as $i => $role ) {
        $auth->setAllowed($event, $role, 'view',    ($i <= $viewMax));
        $auth->setAllowed($event, $role, 'comment', ($i <= $commentMax));
        $auth->setAllowed($event, $role, 'photo',   ($i <= $photoMax));
      }

      $auth->setAllowed($event, 'member', 'invite', $values['auth_invite']);
      
      // Commit
      $db->commit();
    }

    catch( Engine_Image_Exception $e )
    {
      $db->rollBack();
      $form->addError(Zend_Registry::get('Zend_Translate')->_('The image you selected was too large.'));
    }

    catch( Exception $e )
    {
      $db->rollBack();
      throw $e;
    }


    $db->beginTransaction();
    try {
      // Rebuild privacy
      $actionTable = Engine_Api::_()->getDbtable('actions', 'activity');
      foreach( $actionTable->getActionsByObject($event) as $action ) {
        $actionTable->resetActivityBindings($action);
      }

      $db->commit();
    }
    catch( Exception $e )
    {
      $db->rollBack();
      throw $e;
    }

    // Redirect
    if( $this->_getParam('ref') === 'profile' ) {
      $this->_redirectCustom($event);
    } else {
      $this->_redirectCustom(array('route' => 'event_general', 'action' => 'manage'));
    }
  }
  

  public function inviteAction()
  {

    if( !$this->_helper->requireUser()->isValid() ) return;
    if( !$this->_helper->requireSubject('event')->isValid() ) return;
    // @todo auth

    // Prepare data
    $viewer = Engine_Api::_()->user()->getViewer();
    $this->view->event = $event = Engine_Api::_()->core()->getSubject();
    $this->view->friends = $friends = $viewer->membership()->getMembers();

    // Prepare form
    $this->view->form = $form = new Event_Form_Invite();

    $count = 0;
    foreach( $friends as $friend )
    {
      if( $event->membership()->isMember($friend, null) ) continue;
      $form->users->addMultiOption($friend->getIdentity(), $friend->getTitle());
      $count++;
    }
    $this->view->count = $count;
    // Not posting
    if( !$this->getRequest()->isPost() )
    {
      return;
    }
    if( !$form->isValid($this->getRequest()->getPost()) )
      {
      return;
    }

   // Process
    $table = $event->getTable();
    $db = $table->getAdapter();
    $db->beginTransaction();

    try
    {
      $usersIds = $form->getValue('users');
      
      $notifyApi = Engine_Api::_()->getDbtable('notifications', 'activity');
      foreach( $friends as $friend )
      {
        if( !in_array($friend->getIdentity(), $usersIds) )
        {
          continue;
        }

        $event->membership()->addMember($friend)
          ->setResourceApproved($friend);

        $notifyApi->addNotification($friend, $viewer, $event, 'event_invite');
      }


      $db->commit();
    }

    catch( Exception $e )
    {
      $db->rollBack();
      throw $e;
    }
    
    return $this->_forward('success', 'utility', 'core', array(
      'messages' => array(Zend_Registry::get('Zend_Translate')->_('Members invited')),
      'layout' => 'default-simple',
      'parentRefresh' => true,
    ));
  }

 public function styleAction()
  {
    if( !$this->_helper->requireAuth()->setAuthParams(null, null, 'edit')->isValid() ) return;
    if( !$this->_helper->requireAuth()->setAuthParams(null, null, 'style')->isValid() ) return;
    
    $user = Engine_Api::_()->user()->getViewer();
    $event = Engine_Api::_()->core()->getSubject('event');

    // Make form
    $this->view->form = $form = new Event_Form_Style();

    // Get current row
    $table = Engine_Api::_()->getDbtable('styles', 'core');
    $select = $table->select()
      ->where('type = ?', 'event')
      ->where('id = ?', $event->getIdentity())
      ->limit(1);

    $row = $table->fetchRow($select);

    // Check post
    if( !$this->getRequest()->isPost() )
    {
      $form->populate(array(
        'style' => ( null === $row ? '' : $row->style )
      ));
      return;
    }

    if( !$form->isValid($this->getRequest()->getPost()) )
    {
      return;
    }

    // Cool! Process
    $style = $form->getValue('style');

    // Save
    if( null == $row )
    {
      $row = $table->createRow();
      $row->type = 'event';
      $row->id = $event->getIdentity();
    }

    $row->style = $style;
    $row->save();

    $this->view->draft = true;
    $this->view->message = Zend_Registry::get('Zend_Translate')->_('Your changes have been saved.');
    $this->_forward('success', 'utility', 'core', array(
        'smoothboxClose' => true,
        'parentRefresh' => false,
        'messages' => array(Zend_Registry::get('Zend_Translate')->_('Your changes have been saved.'))
    ));
  }


  public function deleteAction()
  {

    $viewer = Engine_Api::_()->user()->getViewer();
    $event = Engine_Api::_()->getItem('event', $this->getRequest()->getParam('event_id'));
    if( !$this->_helper->requireAuth()->setAuthParams($event, null, 'delete')->isValid()) return;

    // In smoothbox
    $this->_helper->layout->setLayout('default-simple');
    
    // Make form
    $this->view->form = $form = new Event_Form_Delete();

    if( !$event )
    {
      $this->view->status = false;
      $this->view->error = Zend_Registry::get('Zend_Translate')->_("Event doesn't exists or not authorized to delete");
      return;
    }

    if( !$this->getRequest()->isPost() )
    {
      $this->view->status = false;
      $this->view->error = Zend_Registry::get('Zend_Translate')->_('Invalid request method');
      return;
    }

    $db = $event->getTable()->getAdapter();
    $db->beginTransaction();

    try
    {
      $event->delete();
      $db->commit();
    }
    catch( Exception $e )
    {
      $db->rollBack();
      throw $e;
    }

    $this->view->status = true;
    $this->view->message = Zend_Registry::get('Zend_Translate')->_('The selected event has been deleted.');
    return $this->_forward('success' ,'utility', 'core', array(
      'parentRedirect' => Zend_Controller_Front::getInstance()->getRouter()->assemble(array('action' => 'manage'), 'event_general', true),
      'messages' => Array($this->view->message)
    ));
  }
  
  public function cancelAction()
  {
    $event_id = $this->getRequest()->getParam('event_id');
    $event = Engine_Api::_()->getItem('event', $event_id);
    $viewer = Engine_Api::_()->user()->getViewer();
    
    if( !$event->isOwner($viewer) ) {
      return;
    }
    
    // In smoothbox
    $this->_helper->layout->setLayout('default-simple');
    
    $this->view->form = $form = new Event_Form_Cancel();
    
    if( !$this->getRequest()->isPost() ) {
        return;
    }
    
    if( !$form->isValid($this->getRequest()->getPost()) ) {
        return;
    }
    
    $event = Engine_Api::_()->core()->getSubject();
    
    $db = $event->getTable()->getAdapter();
    $db->beginTransaction();
    
    try {
        // Send notify to members and change members status to refaund (if member paid)
        $membershipTable = Engine_Api::_()->getDbTable('membership', 'event');
        $conversationTable = Engine_Api::_()->getDbTable('conversations', 'messages');
        
        $admins = Engine_Api::_()->user()->getSuperAdmins();
        $admin = $admins->current();
        
        $memberships = $membershipTable->fetchAll(array(
          'resource_id = ?' => $event->getIdentity(),
          'user_id <> ?' => $event->getOwner()->getIdentity()
        ));
        
        $membersPaidCount = 0;
        $membersCount = count($memberships);
        
        foreach($memberships as $membership) {
          $member = Engine_Api::_()->getItem('user', $membership->user_id);
          if (!empty($member) and $member instanceof User_Model_User) {
            
            // Change status
            if ($membership->rsvp == 3) {
              $membersPaidCount ++ ;
              $membership->rsvp_update = date('Y-m-d H:i:s');
              $membership->rsvp = 4;
              $membership->save();
            }
            
            // Send message
            $message = Zend_Registry::get('Zend_Translate')->_('Host has cancelled the Event. You have recently applied for the class %1$s. Unfortunately %2$s has cancelled the class. There are several reasons why this might have happened. We hope you are able to enjoy another class with Happetite.%3$s');
            $message = sprintf($message,
              '<a href="' . $event->getHref() . '">' . $event->getTitle() . '</a>',
              '<a href="' . $event->getOwner()->getHref() . '">' . $event->getOwner()->getTitle() . '</a>',
              Zend_Registry::get('Zend_Translate')->_('CANCEL_REASON_HOST_' . $form->getValue('reason'))
            );
            $conversation = $conversationTable->send($member, $member, Zend_Registry::get('Zend_Translate')->translate('EVENT_HOST_CANCELED_MEMBER_SUBJECT'), $message, null, true);
            
            // Send notification
            Engine_Api::_()->getDbtable('notifications', 'activity')->addNotification(
              $member, $admin, $conversation, 'message_system_new'
            );
          }
        }
        
        // Send notify to admins, money back
        if ($membersPaidCount > 0) {
          $message = Zend_Registry::get('Zend_Translate')->_('The Class %1$s has been cancelled. Please start the refund process.');
          $message = sprintf($message, '<a href="' . $event->getHref() . '">' . $event->getTitle() . '</a>');
          $conversation = $conversationTable->send($admin, $admin, Zend_Registry::get('Zend_Translate')->translate('EVENT_HOST_CANCELED_ADMIN_SUBJECT'), $message, null, true);
          
          // Send notification
          Engine_Api::_()->getDbtable('notifications', 'activity')->addNotification(
            $admin, $member, $conversation, 'message_system_new'
          );
        }
        
        // Change event status
        $event->status = 'canceled';
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
  
  public function membersFullAction()
  {
    $event_id = $this->getRequest()->getParam('event_id');
    $event = Engine_Api::_()->getItem('event', $event_id);
    $viewer = Engine_Api::_()->user()->getViewer();
    
    if( !$event->isOwner($viewer) ) {
      return;
    }
    
    // In smoothbox
    $this->_helper->layout->setLayout('default-simple');
    
    $membershipTable = Engine_Api::_()->getDbTable('membership', 'event');
    $select = $membershipTable->select()
      ->where('resource_id = ?', $event->getIdentity())
      ->where('rsvp IN (?)', array(1, 2, 3));
    $membersCount = count($membershipTable->fetchAll($select));
    
    // Members for remove
    $select = $membershipTable->select()
      ->where('resource_id = ?', $event->getIdentity())
      ->where('rsvp = ?', 0);
    $removeMemberships = $membershipTable->fetchAll($select);
    
    $db = $event->getTable()->getAdapter();
    $db->beginTransaction();
    
    try {
        if ($membersCount) {
          $event->max_users = $membersCount;
          $event->save();
        }
        
        foreach($removeMemberships as $membership) {
          $user = Engine_Api::_()->getItem('user', $membership->user_id);
          // Send message to member
          $message = Zend_Registry::get('Zend_Translate')->_('You have recently applied to the class %1$s. Unfortunately %2$s could not accept you for this class, there can be multiple reasons for that, mostly because the class is already fully booked or you would not fit into the group %2$s is trying to invite. But don’t be discouraged, there are many more classes out there for you to join.%3$s');
          $message = sprintf($message,
            '<a href="' . $event->getHref() . '">' . $event->getTitle() . '</a>',
            '<a href="' . $event->getOwner()->getHref() . '">' . $event->getOwner()->getTitle() . '</a>',
            Zend_Registry::get('Zend_Translate')->_('CANCEL_REASON_ADMIN_')
          );
          $conversation = Engine_Api::_()->getItemTable('messages_conversation')
            ->send($user, $user, Zend_Registry::get('Zend_Translate')->translate('EVENT_HOST_USER_REJECT_SUBJECT'), $message, null, true);
          
          // Send notification
          $admin = Engine_Api::_()->user()->getSuperAdmins()->current();
          Engine_Api::_()->getDbtable('notifications', 'activity')->addNotification(
            $user, $admin, $conversation, 'message_system_new'
          );
          
          $event->membership()->removeMember($user);
        }
        
        $db->commit();
        
        $message = Zend_Registry::get('Zend_Translate')->_('Success.');
    } catch( Exception $e ) {
        $db->rollBack();
        
        $message = Zend_Registry::get('Zend_Translate')->_('An error has occurred.');
        return;
    }
    
    return $this->_forward('success', 'utility', 'core', array(
        'smoothboxClose' => true,
        'parentRefresh' => true,
        'messages' => array($message)
    ));
  }
  
  public function finishAction()
  {
    $event_id = $this->getRequest()->getParam('event_id');
    $event = Engine_Api::_()->getItem('event', $event_id);
    $viewer = Engine_Api::_()->user()->getViewer();
    $admin = Engine_Api::_()->user()->getSuperAdmins()->current();
    
    if( !$event->isOwner($viewer) or $event->status != 'finished') {
      return $this->_forward('success', 'utility', 'core', array(
          'smoothboxClose' => true,
          'parentRefresh' => false,
          'messages' => array(Zend_Registry::get('Zend_Translate')->_('An error has occurred.'))
      ));
    }
    
    // In smoothbox
    $this->_helper->layout->setLayout('default-simple');
    
    $db = Engine_Api::_()->getItemTable('event')->getAdapter();
    $db->beginTransaction();
    
    try {
        // Send message to host
        $message = Zend_Registry::get('Zend_Translate')->_('The class %1$s led by %2$s has successfully ended and has been verified by the host. Please go to the admin panel (%3$s) and pay the host.');
        $message = sprintf($message,
          '<a href="' . $event->getHref() . '">' . $event->getTitle() . '</a>',
          '<a href="' . $event->getOwner()->getHref() . '">' . $event->getOwner()->getTitle() . '</a>',
          '<a href="' . $this->view->url(array('module' => 'event', 'controller' => 'manage'), 'admin_default', true) . '">link</a>'
        );
        $conversation = Engine_Api::_()->getItemTable('messages_conversation')
          ->send($admin, $admin, Zend_Registry::get('Zend_Translate')->translate('EVENT_HOST_ADMIN_VERIFIED_SUBJECT'), $message, null, true);
        
        // Send notification
        Engine_Api::_()->getDbtable('notifications', 'activity')->addNotification(
          $admin, $viewer, $conversation, 'message_system_new'
        );
        
        
        $event->status = 'verified';
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
}