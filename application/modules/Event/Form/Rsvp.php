<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Rsvp.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Event_Form_Rsvp extends Engine_Form
{
  public function init()
  {
    $this
      ->setMethod('POST')
      ->setAction($_SERVER['REQUEST_URI'])
      ;

    $this->addElement('Radio', 'rsvp', array(
      'multiOptions' => array(
        2 => 'Attending',
        1 => 'Maybe Attending',
        0 => 'Not Attending',
        //3 => 'Awaiting Reply',
      ),
    ));
  }
}