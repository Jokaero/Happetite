<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Controller.php 10102 2013-10-25 14:33:25Z ivan $
 * @author     John Boehr <john@socialengine.com>
 */

/**
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Event_Widget_MoreClassesController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
	$viewer = Engine_Api::_()->user()->getViewer();
    if( !Engine_Api::_()->core()->hasSubject() ) {
      return $this->setNoRender();
    }
	
	$subject = Engine_Api::_()->core()->getSubject('event');
    
	if( !$subject->authorization()->isAllowed($viewer, 'view') ) {
      return $this->setNoRender();
    }
	
	$eventTable = Engine_Api::_()->getDbtable('events', 'event');
	$this->view->event = $event = Engine_Api::_()->core()->getSubject();
	$host = $event->getParent();
	$hostName = $host->getTitle();
	$this->getElement()->setTitle('More Classes From ' . $hostName);
	$request = Zend_Controller_Front::getInstance()->getRequest();
	$page = $request->getParam('page');
	
	$this->view->eventsPaginator = $eventPaginator = $eventTable->getEventPaginator(array('owner' => $host));
	$eventPaginator->setItemCountPerPage(3);
    $eventPaginator->setCurrentPageNumber($page);
	if (count($eventPaginator) == 0) {
	  return $this->setNoRender();
	}

  }
}
