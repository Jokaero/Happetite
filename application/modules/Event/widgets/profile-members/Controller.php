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
class Event_Widget_ProfileMembersController extends Engine_Content_Widget_Abstract
{
  protected $_childCount;
  
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
    
    // Get params
    $this->view->page = $page = $this->_getParam('page', 1);
    $this->view->search = $search = $this->_getParam('search');

    // Prepare data
    $this->view->event = $event = Engine_Api::_()->core()->getSubject();
    
    $members = null;
    
    $params = array();
    
    if ($viewer->getIdentity()) {
      $params['viewer'] = $viewer->getIdentity();
    }
    
    // search
    if ($search) {
      $params['search'] = $search;
      $params['rsvps'] = array(1, 2, 3);
    }
    
    // not host
    if (!$event->isOwner($viewer)) {
      $params['user_not_host'] = true;
    }
    
    // not admin
    if (!$viewer->isAdmin()) {
      $params['user_not_admin'] = true;
    }
    
    $select = Engine_Api::_()->event()->getEventUsersSelect($event, $params);
    
    $this->view->members = $members = Zend_Paginator::factory($select);

    $paginator = $members;

    // Set item count per page and current page number
    $paginator->setItemCountPerPage($this->_getParam('itemCountPerPage', 10));
    $paginator->setCurrentPageNumber($this->_getParam('page', $page));

    // Do not render if nothing to show
    if( $paginator->getTotalItemCount() <= 0 && '' == $search ) {
      return $this->setNoRender();
    }

    // Add count to title if configured
    if( $this->_getParam('titleCount', false) && $paginator->getTotalItemCount() >= 0 ) {
      
      $params = array(
        'count' => true,
        'rsvps' => array(1, 2, 3),
      );
      
      // search
      if ($search) {
        $params['search'] = $search;
      }
      
      $select = Engine_Api::_()->event()->getEventUsersSelect($event, $params);
      
      $result = Engine_Api::_()->getDbTable('membership', 'event')->fetchRow($select);
      
      $guestCount = $result->count;
      
      $this->view->guestCount = $guestCount;
      $this->_childCount = $guestCount;
      
    }
  }

  public function getChildCount()
  {
    return $this->_childCount;
  }
}