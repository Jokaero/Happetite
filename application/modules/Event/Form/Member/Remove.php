<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Remove.php 9747 2012-07-26 02:08:08Z john $
 * @author     Sami
 */

/**
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @author     Sami
 */
class Event_Form_Member_Remove extends Engine_Form
{
  public function init()
  {
    $this
      ->setTitle('Remove Member')
      ->setDescription('Are you sure you want to remove this member from the event?')
      ->setAction($_SERVER['REQUEST_URI'])
      ;

    $this->addElement('Select', 'reason', array(
      //'label' => 'Rejection Reason',
      'description' => 'Here you can optionally give a reason for the rejection to the guest.',
      'multiOptions' => array(
        '' => 'Select Reason',
        1 => 'Reason 1',
        2 => 'Reason 2',
        3 => 'Reason 3',
      )
    ));
    
    $this->addElement('Button', 'submit', array(
      'type' => 'submit',
      'ignore' => true,
      'decorators' => array('ViewHelper'),
      'label' => 'Remove Member',
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