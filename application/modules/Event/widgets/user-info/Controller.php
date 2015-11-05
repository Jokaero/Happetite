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
class Event_Widget_UserInfoController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
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
    
    // ~~~ My classes ~~~
    $tableEvents = Engine_Api::_()->getDbtable('events', 'event');
    $itemCountPerPage = 3;
    
    // Classes user host
    $params = array(
      'owner' => $subject,
      //'past' => false,
      'limit' => 3,
      'order' => 'endtime DESC',
    );
    
    $selectHosted = $tableEvents->getEventSelect($params);
    
    // Get paginator
    $this->view->paginatorHosted = $paginatorHosted = Zend_Paginator::factory($selectHosted);
    
    // Set item count per page and current page number
    $paginatorHosted->setItemCountPerPage($itemCountPerPage);
    
    $this->view->eventHosted = true;
    
    // Do not render if nothing to show
    if( $paginatorHosted->getTotalItemCount() <= 0 ) {
      $this->view->eventHosted = false;
    }
    
    // is allowed to show link to join class
    //$allowedEventsIds = Engine_Api::_()->event()->getEventAllowedIds($subject);
    //$this->view->allowedEventsIds = $allowedEventsIds;
    // ~~~ end of My classes
    
    
    
    // ~~~ My Recipes
    // @todo newrosoft my recipes
    // ~~~ end of My Recipes
    
    
    
    
    // ~~~ My Reviews
    
    $values = array(
      'user' => $subject,
      'limit' => 3,
      'order' => 'recent',
      'search' => 1,
    );
    
    $this->view->paginatorReview = $paginatorReview = Engine_Api::_()->review()->getReviewsPaginator($values);
    
    
    // ~~~ end of My Reviews
    
    
    
    
  }

}