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
class Event_Widget_EventCoverPhotoController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    $subject = Engine_Api::_()->core()->getSubject();
		
		if (!($subject instanceof Event_Model_Event)) {
			return $this->setNoRender();
		}
		
  }
}
