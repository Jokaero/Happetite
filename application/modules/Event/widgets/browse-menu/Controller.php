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
class Event_Widget_BrowseMenuController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    // Get navigation
    $this->view->navigation = $navigation = Engine_Api::_()
      ->getApi('menus', 'core')
      ->getNavigation('event_main', array());
      
    $p = Zend_Controller_Front::getInstance()->getRequest()->getParams();
    $active = $navigation->findOneBy('active', true);
    if( empty($active) || $active->getRoute() !== 'event_general' ) {
      $filter = !empty($p['filter']) ? $p['filter'] : 'future';
      if( $filter != 'past' && $filter != 'future' ) $filter = 'future';
    
      foreach( $navigation->getPages() as $page ) {
        if( ($page->label == "Upcoming Events" && $filter == "future") || 
            ($page->route == "event_past" && $filter == "past")) {
          $page->active = true;
        }
      }
      
    }
        
    if ( $p['parent_type'] != NULL ){    
		$this->view->parent_type = $p['parent_type'];
	}
    
    if( count($this->view->navigation) == 1 ) {
      $this->view->navigation = null;
    }
  }
}
