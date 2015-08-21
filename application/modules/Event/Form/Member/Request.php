<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Request.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Event_Form_Member_Request extends Engine_Form
{
  
  protected $_forceRefresh;
  
  protected function setForceRefresh($forceRefresh)
  {
    $this->_forceRefresh = $forceRefresh;
  }
  
  protected function getForceRefresh()
  {
    return $this->_forceRefresh;
  }
  
  public function init()
  {
    $this
      ->setTitle('Request Event Membership')
      ->setDescription('Would you like to request membership in this Event?')
      ->setMethod('POST')
      ->setAction($_SERVER['REQUEST_URI'])
      ;

    //$this->addElement('Hash', 'token');

    $this->addElement('Button', 'submit', array(
      'label' => 'Send Request',
      'ignore' => true,
      'decorators' => array('ViewHelper'),
      'type' => 'submit'
    ));
    
    $onClick = 'parent.Smoothbox.close();';
    
    if ($this->getForceRefresh()) {
      $onClick = 'parent.window.location = parent.window.location;';
    }
    
    $this->addElement('Cancel', 'cancel', array(
      'prependText' => ' or ',
      'label' => 'cancel',
      'link' => true,
      'href' => '',
      'onclick' => $onClick,
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