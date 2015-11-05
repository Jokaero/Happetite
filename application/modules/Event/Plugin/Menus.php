<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Menus.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Event_Plugin_Menus
{
  public function canCreateEvents()
  {
    // Must be logged in
    $viewer = Engine_Api::_()->user()->getViewer();
    if( !$viewer || !$viewer->getIdentity() ) {
      return false;
    }

    // Must be able to create events
    if( !Engine_Api::_()->authorization()->isAllowed('event', $viewer, 'create') ) {
      return false;
    }

    return true;
  }

  public function canViewEvents()
  {
    $viewer = Engine_Api::_()->user()->getViewer();

    // Must be able to view events
    if( !Engine_Api::_()->authorization()->isAllowed('event', $viewer, 'view') ) {
      return false;
    }

    return true;
  }

  public function onMenuInitialize_EventMainManage()
  {
    $viewer = Engine_Api::_()->user()->getViewer();

    if( !$viewer->getIdentity() )
    {
      return false;
    }

    return true;
    /*
    return array(
      'label' => 'My Events',
      'route' => 'event_general',
      'params' => array(
        'action' => 'manage',
      )
    );
     *
     */
  }

  public function onMenuInitialize_EventMainCreate()
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    
    if( !$viewer->getIdentity() )
    {
      return false;
    }

    if( !Engine_Api::_()->authorization()->isAllowed('event', null, 'create') )
    {
      return false;
    }

    return true;
    /*
    return array(
      'label' => 'Create New Event',
      'route' => 'event_general',
      'params' => array(
        'action' => 'create',
      )
    );
     * 
     */
  }
  
  public function onMenuInitialize_EventProfileEdit()
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = Engine_Api::_()->core()->getSubject();
    if( $subject->getType() !== 'event' )
    {
      throw new Event_Model_Exception('Whoops, not a event!');
    }
    
    if ($subject->status == 'closed' or $subject->status == 'finished'
        or $subject->status == 'canceled' or $subject->status == 'verified') {
      return false;
    }

    
    if( !$viewer->getIdentity() || !$subject->authorization()->isAllowed($viewer, 'edit') )
    {
      return false;
    }

    if( !$subject->authorization()->isAllowed($viewer, 'edit') )
    {
      return false;
    }
    
    return array(
      'label' => 'Edit Event Details',
      'icon' => 'application/modules/Event/externals/images/edit.png',
      'route' => 'event_specific',
      'params' => array(
        'controller' => 'event',
        'action' => 'edit',
        'event_id' => $subject->getIdentity(),
        'ref' => 'profile'
      )
    );
  }

  public function onMenuInitialize_EventProfileStyle()
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = Engine_Api::_()->core()->getSubject();
    if( $subject->getType() !== 'event' )
    {
      throw new Event_Model_Exception('Whoops, not a event!');
    }

    if( !$viewer->getIdentity() || !$subject->authorization()->isAllowed($viewer, 'edit') )
    {
      return false;
    }

    if( !$subject->authorization()->isAllowed($viewer, 'style') )
    {
      return false;
    }

    return array(
      'label' => 'Edit Event Style',
      'icon' => 'application/modules/Event/externals/images/style.png',
      'class' => 'smoothbox',
      'route' => 'event_specific',
      'params' => array(
        'action' => 'style',
        'event_id' => $subject->getIdentity(),
        'format' => 'smoothbox',
      )
    );
  }

  public function onMenuInitialize_EventProfileMember()
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = Engine_Api::_()->core()->getSubject();
    if( $subject->getType() !== 'event' ) {
      throw new Event_Model_Exception('Whoops, not a event!');
    }
    
    //if( !$viewer->getIdentity() ) {
    //  return false;
    //}
    
    // event is out of date
    if ($subject->endtime < date('Y-m-d H:i:s', time()) and $subject->status != 'canceled') {
      return array(
        'label' => 'Class already took place',
        'icon' => 'application/modules/Event/externals/images/post/close.png',
        'uri' => 'javascript:void(0);',
        'style' => 'cursor:default; pointer-events:none;',
        'class' => 'event_ended',
      );
    }
    
    // event is closed
    if ($subject->status == 'canceled') {
      return array(
        'label' => 'Class has been canceled',
        'icon' => 'application/modules/Event/externals/images/post/close.png',
        'uri' => 'javascript:void(0);',
        'style' => 'cursor:default; pointer-events:none;',
        'class' => 'event_canceled',
      );
    }
    
    $row = $subject->membership()->getRow($viewer);

    // Not yet associated at all
    if( null === $row ) {
      
      $maxUsers = (int) @$subject->max_users;
      $eventMembershipTable = Engine_Api::_()->getDbTable('membership', 'event');
      $select = $eventMembershipTable->select()
        ->where('resource_id = ?', $subject->getIdentity())
        ->where('rsvp IN (?)', array(1, 2, 3));
      $membersCount = count($eventMembershipTable->fetchAll($select));
        
      if ($maxUsers > 0 and ($membersCount) >= $maxUsers) {
        return;
      }
      
      if( $subject->membership()->isResourceApprovalRequired() ) {
        if (!$viewer->getIdentity()) {
          return array(
            'label' => 'Join Event', // Request Invite
            'icon' => 'application/modules/Event/externals/images/member/join.png',
            'uri' => 'javascript:void(0);',
            'onclick' => "advancedMenuUserLoginOrSignUp('login', '', ''); return false;",
            'class' => 'join_link not_auth'
          );
        } else {
          return array(
            'label' => 'Join Event', // Request Invite
            'icon' => 'application/modules/Event/externals/images/member/join.png',
            'class' => 'smoothbox join_link',
            'route' => 'event_extended',
            'params' => array(
              'controller' => 'member',
              'action' => 'request',
              'event_id' => $subject->getIdentity(),
            ),
          );
        }
      } else {
        return array(
          'label' => 'Join Event',
          'icon' => 'application/modules/Event/externals/images/member/join.png',
          'class' => 'smoothbox join_link',
          'route' => 'event_extended',
          'params' => array(
            'controller' => 'member',
            'action' => 'join',
            'event_id' => $subject->getIdentity()
          ),
        );
      }
    }

    // Full member
    // @todo consider owner
    else if( $row->active ) {
      if( !$subject->isOwner($viewer) ) {
        return array(
          'label' => 'Cancel Invite Request',
          'icon' => 'application/modules/Event/externals/images/member/leave.png',
          'class' => 'smoothbox',
          'route' => 'event_extended',
          'params' => array(
            'controller' => 'member',
            'action' => 'cancel', // @todo original (action => leave)
            'event_id' => $subject->getIdentity()
          ),
        );
      } else {
        return false;
      }
    } else if( !$row->resource_approved && $row->user_approved ) {
      $label = 'Cancel Invite Request';
      $title = '';
      
      if ($row->rsvp == 0) {
        $label = 'Withdraw Application';
        $title = 'Application Pending';
      }
      
      // if refund or canceled late
      if ($row->rsvp == 4 or $row->rsvp == 9) {
        return false;
      }
      
      // if refunded, timed out, rejected, canceled, not paid
      if ($row->rsvp == 5
          or $row->rsvp == 6
          or $row->rsvp == 7
          or $row->rsvp == 8
          or $row->rsvp == 11) {
        return array(
          'label' => 'Join Event', // Request Invite
          'icon' => 'application/modules/Event/externals/images/member/join.png',
          'class' => 'smoothbox join_link',
          'route' => 'event_extended',
          'params' => array(
            'controller' => 'member',
            'action' => 'request',
            'event_id' => $subject->getIdentity(),
          ),
        );
      }
      
      return array(
        'label' => $label,
        'icon' => 'application/modules/Event/externals/images/member/cancel.png',
        'title' => $title,
        'class' => 'smoothbox',
        'route' => 'event_extended',
        'params' => array(
          'controller' => 'member',
          'action' => 'cancel',
          'event_id' => $subject->getIdentity()
        ),
      );
    } else if( !$row->user_approved && $row->resource_approved ) {
      return array(
        array(
          'label' => 'Accept Event Invite',
          'icon' => 'application/modules/Event/externals/images/member/accept.png',
          'class' => 'smoothbox',
          'route' => 'event_extended',
          'params' => array(
            'controller' => 'member',
            'action' => 'accept',
            'event_id' => $subject->getIdentity()
          ),
        ), array(
          'label' => 'Ignore Event Invite',
          'icon' => 'application/modules/Event/externals/images/member/reject.png',
          'class' => 'smoothbox',
          'route' => 'event_extended',
          'params' => array(
            'controller' => 'member',
            'action' => 'reject',
            'event_id' => $subject->getIdentity()
          ),
        )
      );
    }

    else
    {
      throw new Event_Model_Exception('An error has occurred.');
    }


    return false;
  }

  public function onMenuInitialize_EventProfileReport()
  {
    return false;
  }

  public function onMenuInitialize_EventProfileInvite()
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = Engine_Api::_()->core()->getSubject();
    if( $subject->getType() !== 'event' )
    {
      throw new Event_Model_Exception('This event does not exist.');
    }
    if( !$subject->authorization()->isAllowed($viewer, 'invite') )
    {
      return false;
    }
    
    if ($subject->status != 'open') {
      return false;
    }
    
    $maxUsers = (int) @$subject->max_users;
    $membersCount = $subject->membership()->getMemberCount();
    
    if ($maxUsers > 0 and ($membersCount - 1) >= $maxUsers) {
      return;
    }

    return array(
      'label' => 'Invite Guests',
      'icon' => 'application/modules/Event/externals/images/member/invite.png',
      'class' => 'smoothbox',
      'route' => 'event_extended',
      'params' => array(
        //'module' => 'event',
        'controller' => 'member',
        'action' => 'invite',
        'event_id' => $subject->getIdentity(),
        'format' => 'smoothbox',
      ),
    );
  }

  public function onMenuInitialize_EventProfileShare()
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = Engine_Api::_()->core()->getSubject();
    if( $subject->getType() !== 'event' )
    {
      throw new Event_Model_Exception('This event does not exist.');
    }

    if( !$viewer->getIdentity() )
    {
      return false;
    }
    
    return array(
      'label' => 'Share This Event',
      'icon' => 'application/modules/Event/externals/images/share.png',
      'class' => 'smoothbox',
      'route' => 'default',
      'params' => array(
        'module' => 'activity',
        'controller' => 'index',
        'action' => 'share',
        'type' => $subject->getType(),
        'id' => $subject->getIdentity(),
        'format' => 'smoothbox',
      ),
    );
  }

  public function onMenuInitialize_EventProfileMessage()
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = Engine_Api::_()->core()->getSubject();
    if( $subject->getType() !== 'event' )
    {
      throw new Event_Model_Exception('This event does not exist.');
    }

    if( !$viewer->getIdentity() || !$subject->isOwner($viewer))
    {
      return false;
    }

    return array(
      'label' => 'Message Members',
      'icon' => 'application/modules/Messages/externals/images/send.png',
      'route' => 'messages_general',
      'params' => array(
        'action' => 'compose',
        'to' => $subject->getIdentity(),
        'multi' => 'event'
      )
    );
  }

  public function onMenuInitialize_EventProfileDelete()
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = Engine_Api::_()->core()->getSubject();
    if( $subject->getType() !== 'event' ) {
      throw new Event_Model_Exception('This event does not exist.');
    } else if( !$subject->authorization()->isAllowed($viewer, 'delete') ) {
      return false;
    }
    
    // Payment members
    $membershipTable = Engine_Api::_()->getDbTable('membership', 'event');
    $select = $membershipTable->select()
      ->where('rsvp = ?', '3');
    
    if (count($membershipTable->fetchAll($select)) > 0 or $subject->status != 'open') {
      return false;
    }

    return array(
      'label' => 'Delete Event',
      'icon' => 'application/modules/Event/externals/images/delete.png',
      'class' => 'smoothbox',
      'route' => 'event_specific',
      'params' => array(
        'action' => 'delete',
        'event_id' => $subject->getIdentity(),
        //'format' => 'smoothbox',
      ),
    );
  }
  
  public function onMenuInitialize_EventProfileCancel()
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = Engine_Api::_()->core()->getSubject();
    if( $subject->getType() !== 'event' ) {
      throw new Event_Model_Exception('This event does not exist.');
    } else if( !$subject->authorization()->isAllowed($viewer, 'edit') or !$subject->isOwner($viewer) ) {
      return false;
    }
    
    if ($subject->status != 'open') {
      return false;
    }

    return array(
      'label' => 'Cancel Class',
      'icon' => 'application/modules/Event/externals/images/door_in.png',
      'class' => 'smoothbox',
      'route' => 'event_specific',
      'params' => array(
        'action' => 'cancel',
        'event_id' => $subject->getIdentity(),
        //'format' => 'smoothbox',
      ),
    );
  }
  
  public function onMenuInitialize_EventProfilePayment()
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = Engine_Api::_()->core()->getSubject();
    
    if( $subject->getType() !== 'event' ) {
      throw new Event_Model_Exception('This event does not exist.');
    }
    
    $row = $subject->membership()->getRow($viewer);
    
    if (empty($row) or $row->rsvp != 1 or $subject->isOwner($viewer) or $subject->status != 'open') {
      return false;
    }
    
    return array(
      'label' => 'Pay Now',
      'icon' => 'application/modules/Event/externals/images/money.png',
      'class' => 'smoothbox',
      'route' => 'event_payment',
      'params' => array(
        'id' => $subject->getIdentity(),
        'format' => 'smoothbox',
      ),
    );
  }
  
  public function onMenuInitialize_EventProfileMembersFull()
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = Engine_Api::_()->core()->getSubject();
    
    if( $subject->getType() !== 'event' ) {
      throw new Event_Model_Exception('This event does not exist.');
    } else if( !$subject->authorization()->isAllowed($viewer, 'edit') or !$subject->isOwner($viewer) ) {
      return false;
    }
    
    if (!empty($subject->max_users) or !$subject->isOwner($viewer)
        or $subject->status != 'open') {
      return;
    }
    
    return array(
      'label' => 'Mark class as fully booked',
      'icon' => 'application/modules/Event/externals/images/group_link.png',
      'class' => 'smoothbox',
      'route' => 'event_specific',
      'params' => array(
        'action' => 'members-full',
        'event_id' => $subject->getIdentity(),
        'format' => 'smoothbox',
      ),
    );
  }
  
  public function onMenuInitialize_EventProfileMembersFinish()
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = Engine_Api::_()->core()->getSubject();
    
    if( $subject->getType() !== 'event' ) {
      throw new Event_Model_Exception('This event does not exist.');
    } else if( !$subject->authorization()->isAllowed($viewer, 'edit') or !$subject->isOwner($viewer) ) {
      return false;
    }
    
    if ($subject->status != 'finished') {
      return;
    }
    
    return array(
      'label' => 'Mark class as finished',
      'icon' => 'application/modules/Event/externals/images/tick.png',
      'class' => 'smoothbox',
      'route' => 'event_specific',
      'params' => array(
        'action' => 'finish',
        'event_id' => $subject->getIdentity(),
        'format' => 'smoothbox',
      ),
    );
  }
}