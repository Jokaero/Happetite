<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Controller.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Event_Widget_ProfileInfoController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    // Don't render this if not authorized
    $viewer = Engine_Api::_()->user()->getViewer();
    if( !Engine_Api::_()->core()->hasSubject() ) {
      return $this->setNoRender();
    }

    // Get subject and check auth
    $subject = Engine_Api::_()->core()->getSubject('event');
    if( !$subject->authorization()->isAllowed($viewer, 'view') ) {
      return $this->setNoRender();
    }

    $this->view->subject = $subject;
    
    $sitePercent = Engine_Api::_()->getApi('settings', 'core')
      ->getSetting('event_percent', 10);
    $this->view->price = ceil($subject->price * (1 + $sitePercent / 100));
    
    // left places
    $membershipTable = Engine_Api::_()->getDbTable('membership', 'event');
    
    $select = $membershipTable->select()
      ->from($membershipTable->info('name'), 'COUNT(user_id) as count')
      ->where('resource_id = ?', $subject->getIdentity())
      ->where('rsvp IN (?)', array(1, 2, 3)) // accepted, accepted_after_remind, paid statuses
      ;
    
    $bookedPlaces = $membershipTable->fetchRow($select);
    $this->view->bookedPlacesCount = $bookedPlacesCount = $bookedPlaces->count;
  }
}