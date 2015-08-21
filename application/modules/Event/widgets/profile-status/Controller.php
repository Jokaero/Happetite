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
class Event_Widget_ProfileStatusController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    // Don't render this if not authorized
    $viewer = Engine_Api::_()->user()->getViewer();
    if( !Engine_Api::_()->core()->hasSubject() ) {
      return $this->setNoRender();
    }

    // Get subject and check auth
    $subject = Engine_Api::_()->core()->getSubject('event');
    //if( !$subject->authorization()->isAllowed($viewer, 'view') ) {
    //  return $this->setNoRender();
    //}

    $this->view->event = $subject;
    
    // Colored title if more than 1 word(50% black/50% orange words)
    $eventTitle = $subject->getTitle();
    
    $eventTitleArray = explode(' ', $eventTitle);
    $count = count($eventTitleArray);
    
    if ($count > 1) {
      $middleIndex = ceil($count / 2);
      $styledTitle = '';
      
      // concatinate title back
      for ($i = 0; $i < $count; $i++) {
        
        // get first wrap 
        if ($i == 0) {
          $styledTitle .= '<span class="first_part">';
        }
        
        // add word
        $styledTitle .= $eventTitleArray[$i];
        
        // get some space between words
        if ($i != $count - 1) {
          $styledTitle .= ' ';
        }
        
        // get first wrap end and get last wrap 
        if ($i == $middleIndex - 1) {
          $styledTitle .= '</span>';
          $styledTitle .= '<span class="last_part">';
        }
        
        // get last wrap end
        if ($i == $count - 1) {
          $styledTitle .= '</span>';
        }
      }
    }
    
    $this->view->eventTitle = (!empty($styledTitle)) ? $styledTitle : $eventTitle;
  }
}