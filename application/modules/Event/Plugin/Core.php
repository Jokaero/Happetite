<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Core.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Event_Plugin_Core
{
  public function onStatistics($event)
  {
    $table = Engine_Api::_()->getItemTable('event');
    $select = new Zend_Db_Select($table->getAdapter());
    $select->from($table->info('name'), 'COUNT(*) AS count');
    $event->addResponse($select->query()->fetchColumn(0), 'event');
  }

  public function onUserDeleteBefore($event)
  {
    $payload = $event->getPayload();
    if( $payload instanceof User_Model_User ) {
      // Delete posts
      $postTable = Engine_Api::_()->getDbtable('posts', 'event');
      $postSelect = $postTable->select()->where('user_id = ?', $payload->getIdentity());
      foreach( $postTable->fetchAll($postSelect) as $post ) {
        //$post->delete();
      }

      // Delete topics
      $topicTable = Engine_Api::_()->getDbtable('topics', 'event');
      $topicSelect = $topicTable->select()->where('user_id = ?', $payload->getIdentity());
      foreach( $topicTable->fetchAll($topicSelect) as $topic ) {
        //$topic->delete();
      }

      // Delete photos
      $photoTable = Engine_Api::_()->getDbtable('photos', 'event');
      $photoSelect = $photoTable->select()->where('user_id = ?', $payload->getIdentity());
      foreach( $photoTable->fetchAll($photoSelect) as $photo ) {
        $photo->delete();
      }
      
      // Delete memberships
      $membershipApi = Engine_Api::_()->getDbtable('membership', 'event');
      foreach( $membershipApi->getMembershipsOf($payload, null) as $event ) {
        $membershipApi->removeMember($event, $payload);
      }

      // Delete events
      $eventTable = Engine_Api::_()->getDbtable('events', 'event');
      $eventSelect = $eventTable->select()->where('user_id = ?', $payload->getIdentity());
      foreach( $eventTable->fetchAll($eventSelect) as $event ) {
        $event->delete();
      }
    }
  }

  public function addActivity($event)
  {
    $payload = $event->getPayload();
    $subject = $payload['subject'];
    $object = $payload['object'];

    // Only for object=event
    if( $object instanceof Event_Model_Event &&
        Engine_Api::_()->authorization()->context->isAllowed($object, 'member', 'view') ) {
      $event->addResponse(array(
        'type' => 'event',
        'identity' => $object->getIdentity()
      ));
    }
  }

  public function getActivity($event)
  {
    // Detect viewer and subject
    $payload = $event->getPayload();
    $user = null;
    $subject = null;
    if( $payload instanceof User_Model_User ) {
      $user = $payload;
    } else if( is_array($payload) ) {
      if( isset($payload['for']) && $payload['for'] instanceof User_Model_User ) {
        $user = $payload['for'];
      }
      if( isset($payload['about']) && $payload['about'] instanceof Core_Model_Item_Abstract ) {
        $subject = $payload['about'];
      }
    }
    if( null === $user ) {
      $viewer = Engine_Api::_()->user()->getViewer();
      if( $viewer->getIdentity() ) {
        $user = $viewer;
      }
    }
    if( null === $subject && Engine_Api::_()->core()->hasSubject() ) {
      $subject = Engine_Api::_()->core()->getSubject();
    }

    // Get feed settings
    $content = Engine_Api::_()->getApi('settings', 'core')
      ->getSetting('activity.content', 'everyone');

    // Get event memberships
    if( $user ) {
      $data = Engine_Api::_()->getDbtable('membership', 'event')->getMembershipsOfIds($user);
      if( !empty($data) && is_array($data) ) {
        $event->addResponse(array(
          'type' => 'event',
          'data' => $data,
        ));
      }
    }
  }
  
  public function onRenderLayoutDefault($event)
  {
    // @deprecated
    //$view = $event->getPayload();
    //
    //if (!($view instanceof Zend_View)) {
    //  return;
    //}
    //
    //$headScript = new Zend_View_Helper_HeadScript();
    //
    //// sign in/sign up in smoothbox
    //$headScript->appendFile('application/modules/Event/externals/scripts/auth.js');
    
  }
  
  public function onUserCreateAfter($event)
	{
		$payload = $event->getPayload();
		if ($payload instanceof User_Model_User) {
			$notificationSettings = Engine_Api::_()->getDbtable('notificationSettings', 'activity');
      
      $data = array(
        'user_id' => $payload->getIdentity(),
        'type' => 'message_new',
        'email' => 0,
      );
      
      $notificationSettings->insert($data);
		}

	}
  
}