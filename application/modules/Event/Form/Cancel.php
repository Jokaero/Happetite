<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Cancel.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Event_Form_Cancel extends Engine_Form
{
  public function init()
  {
    $this
      ->setTitle('Cancel Class')
      ->setDescription('Are you sure you want to cancel this class?')
      ->setAttrib('class', 'global_form_popup')
      ->setMethod('POST')
      ->setAction($_SERVER['REQUEST_URI'])
      ;

    //$this->addElement('Hash', 'token');

    $this->addElement('Select', 'reason', array(
      //'label' => 'Rejection Reason',
      'description' => 'Here you can optionally give a reason for the cancellation of the class.',
      'multiOptions' => array(
        '' => 'Select Reason',
        1 => 'Reason 1',
        2 => 'Reason 2',
        3 => 'Reason 3',
      )
    ));
    
    $this->addElement('Button', 'submit', array(
      'label' => 'Cancel Class',
      'ignore' => true,
      'decorators' => array('ViewHelper'),
      'type' => 'submit'
    ));

    $this->addElement('Cancel', 'cancel', array(
      'prependText' => ' or ',
      'label' => 'cancel',
      'link' => true,
      'href' => '',
      'onclick' => 'parent.Smoothbox.close();',
      'decorators' => array(
        'ViewHelper'
      ),
    ));

    $this->addDisplayGroup(array(
      'submit',
      'cancel'
    ), 'buttons');
  }
}