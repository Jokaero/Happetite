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
    $select = $event->membership()->getMembersSelect(null);
    if( $search ) {
      $userTable = Engine_Api::_()->getItemTable('user');
      $userTableName = $userTable->info('name');
      $membershipTableName = $select->getTable()->info('name');
      
      $select
        ->from($membershipTableName)
        ->joinLeft($userTableName, "$userTableName.user_id = $membershipTableName.user_id", null)
        ->where('displayname LIKE ?', '%' . $search . '%');
    }
    
    if (!$event->isOwner($viewer) and !$viewer->isAdmin()) {
      $select->where("rsvp = '3' OR user_id IN ('"
                     . $event->getOwner()->getIdentity() . "', '"
                     . $viewer->getIdentity() . "')");
    }
    
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
    if( $this->_getParam('titleCount', false) && $paginator->getTotalItemCount() > 0 ) {
      $this->_childCount = $paginator->getTotalItemCount() - 1;
    }
  }

  public function getChildCount()
  {
    return $this->_childCount;
  }
}