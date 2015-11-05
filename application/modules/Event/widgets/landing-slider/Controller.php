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
class Event_Widget_LandingSliderController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    $slidesTable = Engine_Api::_()->getDbtable('slides', 'event');
    $this->view->slides = $slides = $slidesTable->fetchAll();
    
  }
}
