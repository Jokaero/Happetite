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
class Event_Form_Member_Cancel extends Engine_Form
{
  public function init()
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = Engine_Api::_()->core()->getSubject();
    
    if( $subject->getType() !== 'event' ) {
      return;
    }
    
    $membershipTable = Engine_Api::_()->getDbTable('membership', 'event');
    $select = $membershipTable->select()
      ->where('resource_id = ?', $subject->getIdentity())
      ->where('user_id = ?', $viewer->getIdentity());
    $membership = $membershipTable->fetchRow($select);
    
    $this
      ->setTitle('Cancel Invite Request')
      ->setDescription('Are you sure u want to withdraw your class application?')
      ->setMethod('POST')
      ->setAction($_SERVER['REQUEST_URI'])
      ;

    //$this->addElement('Hash', 'token');
    
    if ($membership and $membership->rsvp == 3 and strtotime($subject->starttime) - 86400 * 2 >= time()) {
      $this->setDescription('Are you sure u want to withdraw your class participation? We will refund your money (except the service fee). Please provide us your bank account information.');
    } else if ($membership and $membership->rsvp == 3 and strtotime($subject->starttime) - 86400 * 2 < time()) {
      $this->setDescription('Are you sure u want to withdraw your class participation? Since it’s less than 48h before the class, we can’t refund you the money.');
    }
    
    if ($membership and $membership->rsvp) {
      $this->addElement('Select', 'reason', array(
        //'label' => 'Rejection Reason',
        'description' => 'Here you can optionally give a reason for the cancellation of your attendance.',
        'multiOptions' => array(
          '' => 'Select Reason',
          1 => 'Reason 1',
          2 => 'Reason 2',
          3 => 'Reason 3',
        )
      ));
      
      if ($membership->rsvp == 3 and strtotime($subject->starttime) - 86400 * 2 >= time()) {
        $this->addElement('Textarea', 'bank_info', array(
          'label' => 'Bank Account Information',
          'allowEmpty' => false,
          'required' => true,
          'validators' => array(
            array('NotEmpty', true),
            array('StringLength', false, array(1, 255)),
          ),
          'filters' => array(
            'StripTags',
            new Engine_Filter_Censor(),
          ),
        ));
      }
    }
    

    $this->addElement('Button', 'submit', array(
      'label' => 'Cancel Request',
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