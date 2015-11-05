<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: MemberController.php 10175 2014-04-22 18:13:34Z lucas $
 * @author     Sami
 */

/**
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @author     Sami
 */
class Event_MemberController extends Core_Controller_Action_Standard
{
  public function init()
  {
    if( 0 !== ($event_id = (int) $this->_getParam('event_id')) &&
        null !== ($event = Engine_Api::_()->getItem('event', $event_id)) )
    {
      Engine_Api::_()->core()->setSubject($event);
    }

    //$this->_helper->requireUser();
    $this->_helper->requireSubject('event');
    /*
    $this->_helper->requireAuth()->setAuthParams(
      null,
      null,
      null
      //'edit'
    );
     *
     */
  }


  public function joinAction()
  {
    return false;
    
    // Check resource approval
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = Engine_Api::_()->core()->getSubject();

    // Check auth
    if( !$this->_helper->requireUser()->isValid() ) return;
    if( !$this->_helper->requireSubject()->isValid() ) return;
    if( !$this->_helper->requireAuth()->setAuthParams($subject, $viewer, 'view')->isValid() ) return;

    if( $subject->membership()->isResourceApprovalRequired() ) {
      $row = $subject->membership()->getReceiver()
        ->select()
        ->where('resource_id = ?', $subject->getIdentity())
        ->where('user_id = ?', $viewer->getIdentity())
        ->query()
        ->fetch(Zend_Db::FETCH_ASSOC, 0);
        ;
      if (empty($row)) {
        // has not yet requested an invite
        return $this->_helper->redirector->gotoRoute(array('action' => 'request', 'format' => 'smoothbox'));
      } elseif ($row['user_approved'] && !$row['resource_approved']) {
        // has requested an invite; show cancel invite page
        return $this->_helper->redirector->gotoRoute(array('action' => 'cancel', 'format' => 'smoothbox'));
      }
    }

    // Make form
    $this->view->form = $form = new Event_Form_Member_Join();

    // Process form
    if( $this->getRequest()->isPost() && $form->isValid($this->getRequest()->getPost()) )
    {
      $viewer = Engine_Api::_()->user()->getViewer();
      $subject = Engine_Api::_()->core()->getSubject();
      $db = $subject->membership()->getReceiver()->getTable()->getAdapter();
      $db->beginTransaction();

      try
      {
        $membership_status = $subject->membership()->getRow($viewer)->active;
        
        $subject->membership()
          ->addMember($viewer)
          ->setUserApproved($viewer)
          ;

        $row = $subject->membership()
          ->getRow($viewer);

        $row->rsvp = $form->getValue('rsvp');
        $row->save();

        // Add activity if membership status was not valid from before
        if (!$membership_status){
          $activityApi = Engine_Api::_()->getDbtable('actions', 'activity');
          $action = $activityApi->addActivity($viewer, $subject, 'event_join');
        }
        
        $db->commit();
      }
      catch( Exception $e )
      {
        $db->rollBack();
        throw $e;
      }

      return $this->_forward('success', 'utility', 'core', array(
        'messages' => array(Zend_Registry::get('Zend_Translate')->_('Event joined')),
        'layout' => 'default-simple',
        'parentRefresh' => true,
      ));
    }
  }

  public function requestAction()
  {
    // Check resource approval
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = Engine_Api::_()->core()->getSubject();
    
    // @deprecated, but super custom auth throw the smoothbox
    //// check auth
    //if (!$viewer->getIdentity()) {
    //  
    //  $session = new Zend_Session_Namespace('Redirect');
    //  $session->route = 'default';
    //  $session->params = array(
    //    'redirect' => Zend_Controller_Front::getInstance()->getRouter()->assemble(array(
    //                    'module' => 'event',
    //                    'controller' => 'member',
    //                    'action' => 'request',
    //                    'event_id' => $subject->getIdentity(),
    //                    'format' => 'smoothbox',
    //                    'force_refresh' => true,
    //                  ), 'default', true),
    //  );
    //  
    //  return $this->_helper->redirector->gotoRoute(array('format' => 'smoothbox'), 'user_login', true);
    //  
    //}
    //
    //// if exist when user press Cancel FORCE refresh page
    //$this->view->forceRefresh = $forceRefresh = $this->_getParam('force_refresh', false);
    
    // Check auth
    if( !$this->_helper->requireUser()->isValid() ) return;
    if( !$this->_helper->requireSubject()->isValid() ) return;
    if( !$this->_helper->requireAuth()->setAuthParams($subject, $viewer, 'view')->isValid() ) return;
    
    // Make form
    $this->view->form = $form = new Event_Form_Member_Request(array(
      'forceRefresh' => $forceRefresh,
    ));

    // Process form
    if( $this->getRequest()->isPost() && $form->isValid($this->getRequest()->getPost()) )
    {
      $db = $subject->membership()->getReceiver()->getTable()->getAdapter();
      $db->beginTransaction();

      try
      {
        $subject->membership()->addMember($viewer)->setUserApproved($viewer);

        // Set date
        $row = $subject->membership()
          ->getRow($viewer);

        $row->datetime = $row->rsvp_update = date('Y-m-d H:i:s');
        $row->save();
        
        // Add notification
        //$notifyApi = Engine_Api::_()->getDbtable('notifications', 'activity');
        //$notifyApi->addNotification($subject->getOwner(), $viewer, $subject, 'event_approve');
        
        // Send message to host
        $limitDate = new Zend_Date(time() + 86400);
        $limitDate->setTimezone($subject->getOwner()->timezone);
        $message = Zend_Registry::get('Zend_Translate')->_('You have a new applicant for your Class %1$s. Please go to the %2$s and approve/reject the applicant within the next 24 hours, i.e. until %3$s.');
        $message = sprintf($message,
          '<a href="' . $subject->getHref() . '">' . $subject->getTitle() . '</a>',
          '<a href="' . $subject->getHref() . '">class page</a>',
          $this->view->locale()->toDateTime($limitDate)
        );
        $conversation = Engine_Api::_()->getItemTable('messages_conversation')
          ->send($subject->getOwner(), $subject->getOwner(), Zend_Registry::get('Zend_Translate')->translate('EVENT_HOST_USER_ACCEPT_SUBJECT'), $message, null, true);
        
        // Send notification
        Engine_Api::_()->getDbtable('notifications', 'activity')->addNotification(
          $subject->getOwner(), $viewer, $subject, 'message_system_new_request', array(
            'conversation' => $this->view->htmlLink($conversation->getHref(), $this->view->translate('message')),
            'limit_date' => $this->view->locale()->toDateTime($limitDate)
          )
        );

        $db->commit();
      }
      catch( Exception $e )
      {
        $db->rollBack();
        throw $e;
      }
      
      return $this->_forward('success', 'utility', 'core', array(
        'messages' => array(Zend_Registry::get('Zend_Translate')->_('Success.')),
        'layout' => 'default-simple',
        'parentRedirect' => Zend_Controller_Front::getInstance()->getRouter()->assemble(array('action' => 'guest-share', 'event_id' => $subject->getIdentity()), 'event_steps', true),
      ));
    }
  }

  public function cancelAction()
  {
    // Check auth
    if( !$this->_helper->requireUser()->isValid() ) return;
    if( !$this->_helper->requireSubject()->isValid() ) return;

    // Make form
    $this->view->form = $form = new Event_Form_Member_Cancel();
    
    // Process form
    if( $this->getRequest()->isPost() && $form->isValid($this->getRequest()->getPost()) ) {
      $user_id = $this->_getParam('user_id');
      $viewer = Engine_Api::_()->user()->getViewer();
      $subject = Engine_Api::_()->core()->getSubject();
      if( !$subject->authorization()->isAllowed($viewer, 'invite') &&
          $user_id != $viewer->getIdentity() &&
          $user_id ) {
        return;
      }

      if( $user_id ) {
        $user = Engine_Api::_()->getItem('user', $user_id);
        if( !$user ) {
          return;
        }
      } else {
        $user = $viewer;
      }
      
      $row = $subject->membership()
        ->getRow($user);
      
      $admins = Engine_Api::_()->user()->getSuperAdmins();
      $admin = $admins->current();
      
      $subject = Engine_Api::_()->core()->getSubject('event');
      $db = $subject->membership()->getReceiver()->getTable()->getAdapter();
      $db->beginTransaction();
      try
      {
        // Remove the notification?
        $notification = Engine_Api::_()->getDbtable('notifications', 'activity')->getNotificationByObjectAndType(
          $subject->getOwner(), $subject, 'event_approve');
        if( $notification ) {
          $notification->delete();
        }
        
        if ($row->rsvp == 3 and $subject->starttime > date('Y-m-d H:i:s', time() + 86400 * 2)) {
          // Send message to host
          $message = Zend_Registry::get('Zend_Translate')->_('Guest has paid but cancelled early. You have recently accepted %1$s to the class %2$s. %1$s has cancelled his attendance. Since he cancelled early enough, we will refund his money and you’re free to accept another guest instead.%3$s');
          $message = sprintf($message,
            '<a href="' . $user->getHref() . '">' . $user->getTitle() . '</a>',
            '<a href="' . $subject->getHref() . '">' . $subject->getTitle() . '</a>',
            Zend_Registry::get('Zend_Translate')->_('CANCEL_REASON_GUEST_' . $form->getValue('reason'))
          );
          $conversation = Engine_Api::_()->getDbTable('conversations', 'messages')
            ->send($subject->getOwner(), $subject->getOwner(), Zend_Registry::get('Zend_Translate')->_('EVENT_USER_CANCELED_HOST_MORE48_SUBJECT'), $message, null, true);
          
          // Send notification to host
          Engine_Api::_()->getDbtable('notifications', 'activity')->addNotification(
            $subject->getOwner(), $user, $conversation, 'message_system_new'
          );
          
          // Send message to admin
          $message = Zend_Registry::get('Zend_Translate')->_('Guest has paid for class %1$s but cancelled and gets refunded. Please go to the admin panel (%2$s) to refund his money.%3$s');
          $message = sprintf($message,
            '<a href="' . $subject->getHref() . '">' . $subject->getTitle() . '</a>',
            '<a href="' . $this->view->url(array('module' => 'event', 'controller' => 'manage'), 'admin_default', true) . '">link</a>',
            $form->getValue('bank_info')
          );
          $conversation = Engine_Api::_()->getDbTable('conversations', 'messages')
            ->send($admin, $admin, Zend_Registry::get('Zend_Translate')->translate('EVENT_USER_CANCELED_ADMIN_LESS48_SUBJECT'), $message, null, true);
          
          // Send notification to host
          Engine_Api::_()->getDbtable('notifications', 'activity')->addNotification(
            $admin, $user, $conversation, 'message_system_new'
          );
          
          $row->rsvp = 4;
          $row->active = false;
          $row->rsvp_update = date('Y-m-d H:i:s');
          $row->save();
        } else if ($row->rsvp == 3 and $subject->starttime <= date('Y-m-d H:i:s', time() + 86400 * 2)) {
          // Send message to host
          $message = Zend_Registry::get('Zend_Translate')->_('Guest has paid but cancelled late. You have recently accepted %1$s to the class %2$s. Unfortunately %3$s has cancelled his attendance. Since he cancelled in such a short notice, you will still receive your money.%4$s');
          $message = sprintf($message,
            '<a href="' . $user->getHref() . '">' . $user->getTitle() . '</a>',
            '<a href="' . $subject->getHref() . '">' . $subject->getTitle() . '</a>',
            '<a href="' . $user->getHref() . '">' . $user->getTitle() . '</a>',
            Zend_Registry::get('Zend_Translate')->_('CANCEL_REASON_GUEST_' . $form->getValue('reason'))
          );
          $conversation = Engine_Api::_()->getDbTable('conversations', 'messages')
            ->send($subject->getOwner(), $subject->getOwner(), Zend_Registry::get('Zend_Translate')->translate('EVENT_USER_CANCELED_HOST_LESS48_SUBJECT'), $message, null, true);
          
          // Send notification to host
          Engine_Api::_()->getDbtable('notifications', 'activity')->addNotification(
            $subject->getOwner(), $user, $conversation, 'message_system_new'
          );
          
          // Send message to member
          $message = Zend_Registry::get('Zend_Translate')->_('Your cancellation was late. You have recently booked the class %1$s. Unfortunately your cancellation was on short notice and your money will be paid to the host nevertheless.');
          $message = sprintf($message, '<a href="' . $subject->getHref() . '">' . $subject->getTitle() . '</a>');
          $conversation = Engine_Api::_()->getDbTable('conversations', 'messages')
            ->send($user, $user, Zend_Registry::get('Zend_Translate')->translate('EVENT_USER_CANCELED_USER_LESS48_SUBJECT'), $message, null, true);
          
          // Send notification to member
          Engine_Api::_()->getDbtable('notifications', 'activity')->addNotification(
            $user, $user, $conversation, 'message_system_new'
          );
          
          // canceled late
          $row->rsvp = 9;
          $row->active = false;
          $row->rsvp_update = date('Y-m-d H:i:s');
          $row->save();
          
        } else if ($row->rsvp == 0) { // user cancelled attendance before approvement
          // Send message to host
          $message = Zend_Registry::get('Zend_Translate')->_('Unfortunately %1$s has cancelled his request for attendance in class %2$s before your approvement.');
          $message = sprintf($message,
            '<a href="' . $user->getHref() . '">' . $user->getTitle() . '</a>',
            '<a href="' . $subject->getHref() . '">' . $subject->getTitle() . '</a>'
          );
          $conversation = Engine_Api::_()->getDbTable('conversations', 'messages')
            ->send($subject->getOwner(), $subject->getOwner(), Zend_Registry::get('Zend_Translate')->translate('EVENT_USER_CANCELED_HOST_LESS48_SUBJECT'), $message, null, true);
          
          // Send notification to host
          Engine_Api::_()->getDbtable('notifications', 'activity')->addNotification(
            $subject->getOwner(), $user, $conversation, 'message_system_new'
          );
          
          // Remove membership
          $subject->membership()->removeMember($user);
          
        } else if ($row->rsvp == 1 or $row->rsvp == 2) { // guest cancelled attendance after approve but before he pays
          // Send message to host
          $message = Zend_Registry::get('Zend_Translate')->_('Unfortunately %1$s has cancelled his request for attendance in class %2$s before your approvement.');
          $message = sprintf($message,
            '<a href="' . $user->getHref() . '">' . $user->getTitle() . '</a>',
            '<a href="' . $subject->getHref() . '">' . $subject->getTitle() . '</a>'
          );
          $conversation = Engine_Api::_()->getDbTable('conversations', 'messages')
            ->send($subject->getOwner(), $subject->getOwner(), Zend_Registry::get('Zend_Translate')->translate('EVENT_USER_CANCELED_HOST_LESS48_SUBJECT'), $message, null, true);
          
          // Send notification to host
          Engine_Api::_()->getDbtable('notifications', 'activity')->addNotification(
            $subject->getOwner(), $user, $conversation, 'message_system_new'
          );
          
          // canceled
          $row->rsvp = 8;
          $row->rsvp_update = date('Y-m-d H:i:s');
          $row->save();
          
        } else {
          if ($row->rsvp) {
            // Send message to host
            $message = Zend_Registry::get('Zend_Translate')->_('You have recently accepted %1$s to attend the class %2$s. He has cancelled his attendance.%3$s');
            $message = sprintf($message,
              '<a href="' . $user->getHref() . '">' . $user->getTitle() . '</a>',
              '<a href="' . $subject->getHref() . '">' . $subject->getTitle() . '</a>',
              Zend_Registry::get('Zend_Translate')->_('CANCEL_REASON_GUEST_' . $form->getValue('reason'))
            );
            $conversation = Engine_Api::_()->getDbTable('conversations', 'messages')
              ->send($subject->getOwner(), $subject->getOwner(), Zend_Registry::get('Zend_Translate')->translate('EVENT_USER_CANCELED_HOST_SUBJECT'), $message, null, true);
            
            // Send notification
            Engine_Api::_()->getDbtable('notifications', 'activity')->addNotification(
              $subject->getOwner(), $user, $conversation, 'message_system_new'
            );
          }
          
          // Remove message
          $subject->membership()->removeMember($user);
        }

        $db->commit();
      }
      catch( Exception $e )
      {
        $db->rollBack();
        throw $e;
      }

      return $this->_forward('success', 'utility', 'core', array(
        'messages' => array(Zend_Registry::get('Zend_Translate')->_('Your invite request has been cancelled.')),
        'layout' => 'default-simple',
        'parentRefresh' => true,
      ));
    }
  }

  public function leaveAction()
  {
    // Check auth
    if( !$this->_helper->requireUser()->isValid() ) return;
    if( !$this->_helper->requireSubject()->isValid() ) return;
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = Engine_Api::_()->core()->getSubject();

    if( $subject->isOwner($viewer) ) return;

    // Make form
    $this->view->form = $form = new Event_Form_Member_Leave();

    // Process form
    if( $this->getRequest()->isPost() && $form->isValid($this->getRequest()->getPost()) )
    {
      $db = $subject->membership()->getReceiver()->getTable()->getAdapter();
      $db->beginTransaction();

      try
      {
        $subject->membership()->removeMember($viewer);
        $db->commit();
      }
      catch( Exception $e )
      {
        $db->rollBack();
        throw $e;
      }

      return $this->_forward('success', 'utility', 'core', array(
        'messages' => array(Zend_Registry::get('Zend_Translate')->_('Event left')),
        'layout' => 'default-simple',
        'parentRefresh' => true,
      ));
    }
  }
  
  public function acceptAction()
  {
    // Check auth
    if( !$this->_helper->requireUser()->isValid() ) return;
    if( !$this->_helper->requireSubject('event')->isValid() ) return;

    // Make form
    $this->view->form = $form = new Event_Form_Member_Join();

    // Process form
    if( !$this->getRequest()->isPost() )
    {
      $this->view->status = false;
      $this->view->error = true;
      $this->view->message = Zend_Registry::get('Zend_Translate')->_('Invalid Method');
      return;
    }

    if( !$form->isValid($this->getRequest()->getPost()) )
    {
      $this->view->status = false;
      $this->view->error = true;
      $this->view->message = Zend_Registry::get('Zend_Translate')->_('Invalid Data');
      return;
    }

    // Process form
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = Engine_Api::_()->core()->getSubject();
    $db = $subject->membership()->getReceiver()->getTable()->getAdapter();
    $db->beginTransaction();

    try
    {
      $membership_status = $subject->membership()->getRow($viewer)->active;

      $subject->membership()->setUserApproved($viewer);

      $row = $subject->membership()
        ->getRow($viewer);

      $row->rsvp = $form->getValue('rsvp');
      $row->save();

      // Set the request as handled
      $notification = Engine_Api::_()->getDbtable('notifications', 'activity')->getNotificationByObjectAndType(
        $viewer, $subject, 'event_invite');
      if( $notification )
      {
        $notification->mitigated = true;
        $notification->save();
      }

      // Add activity
      if (!$membership_status){
        $activityApi = Engine_Api::_()->getDbtable('actions', 'activity');
        $action = $activityApi->addActivity($viewer, $subject, 'event_join');
      }
      $db->commit();
    }
    catch( Exception $e )
    {
      $db->rollBack();
      throw $e;
    }
    
    $this->view->status = true;
    $this->view->error = false;

    $message = Zend_Registry::get('Zend_Translate')->_('You have accepted the invite to the event %s');
    $message = sprintf($message, $subject->__toString());
    $this->view->message = $message;

    if( $this->_helper->contextSwitch->getCurrentContext() == "smoothbox" ) {
      return $this->_forward('success', 'utility', 'core', array(
        'messages' => array(Zend_Registry::get('Zend_Translate')->_('Event invite accepted')),
        'layout' => 'default-simple',
        'parentRefresh' => true,
      ));
    }
  }

  public function rejectAction()
  {
    // Check auth
    if( !$this->_helper->requireUser()->isValid() ) return;
    if( !$this->_helper->requireSubject('event')->isValid() ) return;

    // Make form
    $this->view->form = $form = new Event_Form_Member_Reject();

    // Process form
    if( !$this->getRequest()->isPost() )
    {
      $this->view->status = false;
      $this->view->error = true;
      $this->view->message = Zend_Registry::get('Zend_Translate')->_('Invalid Method');
      return;
    }

    if( !$form->isValid($this->getRequest()->getPost()) )
    {
      $this->view->status = false;
      $this->view->error = true;
      $this->view->message = Zend_Registry::get('Zend_Translate')->_('Invalid Data');
      return;
    }

    // Process form
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = Engine_Api::_()->core()->getSubject();
    $db = $subject->membership()->getReceiver()->getTable()->getAdapter();
    $db->beginTransaction();

    try
    {
      $subject->membership()->removeMember($viewer);

      // Set the request as handled
      $notification = Engine_Api::_()->getDbtable('notifications', 'activity')->getNotificationByObjectAndType(
        $viewer, $subject, 'event_invite');
      if( $notification )
      {
        $notification->mitigated = true;
        $notification->save();
      }
      
      $db->commit();
    }
    catch( Exception $e )
    {
      $db->rollBack();
      throw $e;
    }

    $this->view->status = true;
    $this->view->error = false;
    $message = Zend_Registry::get('Zend_Translate')->_('You have ignored the invite to the event %s');
    $message = sprintf($message, $subject->__toString());
    $this->view->message = $message;

    if( $this->_helper->contextSwitch->getCurrentContext() == "smoothbox" ) {
      return $this->_forward('success', 'utility', 'core', array(
        'messages' => array(Zend_Registry::get('Zend_Translate')->_('Event invite rejected')),
        'layout' => 'default-simple',
        'parentRefresh' => true,
      ));
    }
  }

  public function removeAction()
  {
    // Check auth
    if( !$this->_helper->requireUser()->isValid() ) return;
    if( !$this->_helper->requireSubject()->isValid() ) return;
    
    // Get user
    if( 0 === ($user_id = (int) $this->_getParam('user_id')) ||
        null === ($user = Engine_Api::_()->getItem('user', $user_id)) )
    {
      return $this->_helper->requireSubject->forward();
    }

    $event = Engine_Api::_()->core()->getSubject();

    if( !$event->membership()->isMember($user) ) {
      throw new Event_Model_Exception('Cannot remove a non-member');
    }

    // Make form
    $this->view->form = $form = new Event_Form_Member_Remove();

    // Process form
    if( $this->getRequest()->isPost() && $form->isValid($this->getRequest()->getPost()) )
    {
      $db = $event->membership()->getReceiver()->getTable()->getAdapter();
      $db->beginTransaction();

      try
      {
        // Remove membership
        //$event->membership()->removeMember($user);
        
        // rejected rsvp
        $membership = $event->membership()->getMemberInfo($user);
        
        $membership->rsvp = 7;
        $membership->rsvp_update = date('Y-m-d H:i:s');
        $membership->save();

        // Remove the notification?
        $notification = Engine_Api::_()->getDbtable('notifications', 'activity')->getNotificationByObjectAndType(
          $event->getOwner(), $event, 'event_approve');
        if( $notification ) {
          $notification->delete();
        }
        
        // Send message to member
        $message = Zend_Registry::get('Zend_Translate')->_('You have recently applied to the class %1$s. Unfortunately %2$s could not accept you for this class, there can be multiple reasons for that, mostly because the class is already fully booked or you would not fit into the group %2$s is trying to invite. But don’t be discouraged, there are many more classes out there for you to join.%3$s');
        $message = sprintf($message,
          '<a href="' . $event->getHref() . '">' . $event->getTitle() . '</a>',
          '<a href="' . $event->getOwner()->getHref() . '">' . $event->getOwner()->getTitle() . '</a>',
          Zend_Registry::get('Zend_Translate')->_('CANCEL_REASON_ADMIN_' . $form->getValue('reason'))
        );
        $conversation = Engine_Api::_()->getItemTable('messages_conversation')
          ->send($user, $user, Zend_Registry::get('Zend_Translate')->translate('EVENT_HOST_USER_REJECT_SUBJECT'), $message, null, true);
        
        // Send notification
        $admin = Engine_Api::_()->user()->getSuperAdmins()->current();
        Engine_Api::_()->getDbtable('notifications', 'activity')->addNotification(
          $user, $admin, $conversation, 'message_system_new'
        );

        $db->commit();
      }
      catch( Exception $e )
      {
        $db->rollBack();
        throw $e;
      }

      return $this->_forward('success', 'utility', 'core', array(
        'messages' => array(Zend_Registry::get('Zend_Translate')->_('Event member removed.')),
        'layout' => 'default-simple',
        'parentRefresh' => true,
      ));
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
    
    // Prepare friends
    $friendsTable = Engine_Api::_()->getDbtable('membership', 'user');
    $friendsIds = $friendsTable->select()
        ->from($friendsTable, 'user_id')
        ->where('resource_id = ?', $viewer->getIdentity())
        ->where('active = ?', true)
        ->limit(100)
        ->query()
        ->fetchAll(Zend_Db::FETCH_COLUMN);
    if( !empty($friendsIds) ) {
      $friends = Engine_Api::_()->getItemTable('user')->find($friendsIds);
    } else {
      $friends = array();
    }
    $this->view->friends = $friends;

    // Prepare form
    $this->view->form = $form = new Event_Form_Invite();

    $count = 0;
    foreach( $friends as $friend ) {
      if( $event->membership()->isMember($friend, null) ) {
        continue;
      }
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


  public function approveAction()
  {
    // Check auth
    if( !$this->_helper->requireUser()->isValid() ) return;
    if( !$this->_helper->requireSubject('event')->isValid() ) return;

    // Get user
    if( 0 === ($user_id = (int) $this->_getParam('user_id')) ||
        null === ($user = Engine_Api::_()->getItem('user', $user_id)) )
    {
      return $this->_helper->requireSubject->forward();
    }
    
    $subject = Engine_Api::_()->core()->getSubject();
    $viewer = Engine_Api::_()->user()->getViewer();
    
    // accepted guest count
    $guestCount = $subject->getMemberCount(array(1, 2));
    
    // check max users count
    $isUsersMoreThanMax = false;
    
    if ($subject->max_users != 0 and $guestCount >= $subject->max_users) {
      $isUsersMoreThanMax = true;
    }
    
    $params = array(
      'isUsersMoreThanMax' => $isUsersMoreThanMax,
    );
    
    // Make form
    $this->view->form = $form = new Event_Form_Member_Approve(array(
      'params' => $params,
    ));

    // Process form
    if( $this->getRequest()->isPost() && $form->isValid($this->getRequest()->getPost()) )
    {
      // check if pressed reject button
      if (isset($_POST['reject'])) {
        $rejectUrl = Zend_Controller_Front::getInstance()->getRouter()
          ->assemble(array('action' => 'remove', 'event_id' => $subject->getIdentity(), 'user_id' => $user_id, 'format' => 'smoothbox'), 'event_extended');
          
        return $this->_forward('success', 'utility', 'core', array(
          'redirect' => $rejectUrl,
          'format'=> 'smoothbox',
          'messages' => array(Zend_Registry::get('Zend_Translate')->_("Redirecting..."))
        ));
      }
      
      $viewer = Engine_Api::_()->user()->getViewer();
      $db = $subject->membership()->getReceiver()->getTable()->getAdapter();
      $db->beginTransaction();

      try
      {
        
        $classStarttime = strtotime($subject->starttime);
        $approveTime = strtotime(date('Y-m-d H:i:s'));
        $interval = $classStarttime - $approveTime;
        
        //@todo after paid$subject->membership()->setResourceApproved($user);
        $row = $subject->membership()
          ->getRow($user);

        $row->rsvp = 1;
        $row->rsvp_update = date('Y-m-d H:i:s');
        
        if ($interval < 345600) {
          $row->is_approved_late = 1;
        }
        
        $row->save();

        //Engine_Api::_()->getDbtable('notifications', 'activity')
        //  ->addNotification($user, $viewer, $subject, 'event_accepted');
        
        // Get Super Admin
        $admin = Engine_Api::_()->user()->getSuperAdmins()->current();
        
        $sitePercent = Engine_Api::_()->getApi('settings', 'core')->getSetting('event_percent', 10);
        $sitePercent = ceil($subject->price * (1 + $sitePercent / 100));
        
        // if guest was approved less then 4 days to start a class
        if ($interval < 345600) {
          $limitDate = new Zend_Date(time() + 86400); // 1 day
          $message = Zend_Registry::get('Zend_Translate')->_('You have recently applied to the class %1$s. %2$s has accepted your request and would be happy to welcoming you to his event. All that is left is the payment. Please click the link below in order to pay the full amount of %3$s. %4$s. Note, since you applied on a rather short note, you only have until %5$s to pay for the class.');
        } else {
          $limitDate = new Zend_Date(time() + 86400 * 4); // 345600 seconds or 4 days
          $message = Zend_Registry::get('Zend_Translate')->_('You have recently applied to the class %1$s. %2$s has accepted your request and would be happy to welcoming you to his event. All that is left is the payment. Please click the link below in order to pay the full amount of %3$s. %4$s You have time until %5$s');
        }
        
        // Send message to member
        $limitDate->setTimezone($user->timezone);
        $message = sprintf($message,
          '<a href="' . $subject->getHref() . '">' . $subject->getTitle() . '</a>',
          '<a href="' . $subject->getOwner()->getHref() . '">' . $subject->getOwner()->getTitle() . '</a>',
          $sitePercent . ' ' . $subject->currency,
          '<a href="' . $this->view->url(array('id' => $subject->getIdentity(), 'format' => 'smoothbox'), 'event_payment', false) . '" class="smoothbox">' . Zend_Registry::get('Zend_Translate')->_('Pay Now') . '</a>',
          $this->view->locale()->toDateTime($limitDate)
        );
        $conversation = Engine_Api::_()->getItemTable('messages_conversation')
          ->send($user, $user, Zend_Registry::get('Zend_Translate')->translate('EVENT_USER_HOST_ACCEPTED_PAYNOW_SUBJECT'), $message, null, true);
        
        // Send notification
        Engine_Api::_()->getDbtable('notifications', 'activity')->addNotification(
          $user, $admin, $subject, 'message_system_new_approve', array(
            'conversation' => $this->view->htmlLink($conversation->getHref(), $this->view->translate('message')),
            'limit_date' => $this->view->locale()->toDateTime($limitDate)
          )
        );

        $db->commit();
      }
      catch( Exception $e )
      {
        $db->rollBack();
        throw $e;
      }

      return $this->_forward('success', 'utility', 'core', array(
        'messages' => array(Zend_Registry::get('Zend_Translate')->_('Event request approved')),
        'layout' => 'default-simple',
        'parentRefresh' => true,
      ));
    }
  }
}