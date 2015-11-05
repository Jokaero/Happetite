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
class Event_Widget_ProfileMyEventsController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    $type = $this->_getParam('type', null);
    
    // Don't render this if not authorized
    $viewer = Engine_Api::_()->user()->getViewer();
    if( !Engine_Api::_()->core()->hasSubject() ) {
      return $this->setNoRender();
    }

    // Get subject and check auth
    $subject = Engine_Api::_()->core()->getSubject();
    if( !$subject->authorization()->isAllowed($viewer, 'view') ) {
      return $this->setNoRender();
    }
    
    if( !($subject instanceof User_Model_User) ) {
      return $this->setNoRender();
    }
    
    $tableEvents = Engine_Api::_()->getDbtable('events', 'event');
    $itemCountPerPage = 3;
    
    // Classes user host
    $params = array(
      'owner' => $subject,
      'future' => true,
    );
    
    $selectHosted = $tableEvents->getEventSelect($params);
    
    // Get paginator
    $this->view->paginatorHosted = $paginatorHosted = Zend_Paginator::factory($selectHosted);
    
    // Set item count per page and current page number
    $paginatorHosted->setItemCountPerPage($itemCountPerPage);
    
    // check what's type is come
    if ($type == 'hosted') {
      $paginatorHosted->setCurrentPageNumber($this->_getParam('page', 1));
    }
    
    $this->view->eventHosted = true;
    
    // Do not render if nothing to show
    if( $paginatorHosted->getTotalItemCount() <= 0 ) {
      $this->view->eventHosted = false;
    }
    
    // Classes user attend
    $params = array(
      'user_id_joined' => $subject->getIdentity(),
      'rsvps' => array(1, 2, 3),
      'future' => true,
    );
    
    $selectAttend = $tableEvents->getEventSelect($params);
    
    // Get paginator
    $this->view->paginatorAttend = $paginatorAttend = Zend_Paginator::factory($selectAttend);
    
    // Set item count per page and current page number
    $paginatorAttend->setItemCountPerPage($itemCountPerPage);
    
    // check what's type is come
    if ($type == 'attend') {
      $paginatorAttend->setCurrentPageNumber($this->_getParam('page', 1));
    }
    
    $this->view->eventAttend = true;
    
    // Do not render if nothing to show
    if( $paginatorAttend->getTotalItemCount() <= 0 ) {
      $this->view->eventAttend = false;
    }
    
    // Classes that user hosted or attended in the past
    $params = array(
      'user_id_joined' => $subject->getIdentity(),
      'rsvps' => array(1, 2, 3, 10),
      'past' => true,
    );
    
    $selectPast = $tableEvents->getEventSelect($params);
    
    // Get paginator
    $this->view->paginatorPast = $paginatorPast = Zend_Paginator::factory($selectPast);
    
    // Set item count per page and current page number
    $paginatorPast->setItemCountPerPage($itemCountPerPage);
    
    // check what's type is come
    if ($type == 'past') {
      $paginatorPast->setCurrentPageNumber($this->_getParam('page', 1));
    }
    
    $this->view->eventPast = true;
    
    // Do not render if nothing to show
    if( $paginatorPast->getTotalItemCount() <= 0 ) {
      $this->view->eventPast = false;
    }
    
    // get all paginators to the array
    $this->view->content = $content = array(
      'hosted' => $paginatorHosted,
      'attend' => $paginatorAttend,
      'past' => $paginatorPast,
    );
    
    // is allowed to show link to join class
    //$allowedEventsIds = Engine_Api::_()->event()->getEventAllowedIds($viewer);
    //$this->view->allowedEventsIds = $allowedEventsIds;
  }

}