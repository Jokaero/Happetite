<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Controller.php 9989 2013-03-20 01:13:58Z john $
 * @author     John Boehr <john@socialengine.com>
 */

/**
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Event_Widget_EventOwnerController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    if( !Engine_Api::_()->core()->hasSubject() ) {
      return $this->setNoRender();
    }
		
		$subject = Engine_Api::_()->core()->getSubject();
		$showPhoto = true;
		
		if ($subject instanceof User_Model_User) {
			$user = $subject;
			$showPhoto = false;
		} elseif ($subject instanceof Event_Model_Event) {
			$user = $subject->getOwner();
		} else {
			return $this->setNoRender();
		}
		
		$this->view->showPhoto = $showPhoto;
		$this->view->user = $user;
		
		// ~~~ Review Rating ~~~
    if( !Engine_Api::_()->authorization()->isAllowed('review', $user, 'reviewed') ) {
      return $this->setNoRender();
    }    
    
    if ($viewer->getIdentity()) {
      $this->view->user_review = Engine_Api::_()->review()->getOwnerReviewForUser($viewer, $user);
      $this->view->can_review = Engine_Api::_()->authorization()->getPermission($viewer->level_id, 'review', 'create');
    }
    
    $this->view->total_review = Engine_Api::_()->review()->getUserReviewCount($user);
    $this->view->average_rating = Engine_Api::_()->review()->getUserAverageRating($user);
    $this->view->total_recommend = Engine_Api::_()->review()->getUserRecommendCount($user);
		
  }
}
