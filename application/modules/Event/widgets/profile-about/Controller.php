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
class Event_Widget_ProfileAboutController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
	// Don't render this if not authorized
    $viewer = Engine_Api::_()->user()->getViewer();
    if( !Engine_Api::_()->core()->hasSubject() ) {
      return $this->setNoRender();
    }

    // Get subject and check auth
    $subject = Engine_Api::_()->core()->getSubject('user');
    if( !$subject->authorization()->isAllowed($viewer, 'view') ) {
      return $this->setNoRender();
    }
    
    $element = $this->getElement();
    $element->removeDecorator('Title');

    $this->view->aboutme = null;
    $field = Engine_Api::_()->fields()->getField(13, $subject)->getValue($subject);
    
    if (!empty($field) and !empty($field->value)) {
        $this->view->aboutme = $field->value;
    }
  }
}
