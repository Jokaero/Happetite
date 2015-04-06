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
class Event_Widget_ProfileMembersSliderCoreController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    // Get render if not Event Profile
    $subject = Engine_Api::_()->core()->getSubject();
    
    if( !($subject instanceof Event_Model_Event) ) {
      return $this->setNoRender();
    }
    
  }
}