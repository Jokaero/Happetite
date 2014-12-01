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
class Event_Form_Admin_Pay extends Engine_Form
{
  protected $_user = null;
  protected $_event = null;
  
  public function setEvent(Event_Model_Event $event)
  {
    $this->_event = $event;
  }
  
  public function getEvent()
  {
    return $this->_event;
  }
  
  public function setUser(User_Model_User $user)
  {
    $this->_user = $user;
  }
  
  public function getUser()
  {
    return $this->_user;
  }
  
  public function init()
  {
    $this
      ->setTitle('Pay to Host')
      //->setDescription('Are you sure you want to cancel this class?')
      ->setAttrib('class', 'global_form_popup')
      ->setMethod('POST')
      ->setAction($_SERVER['REQUEST_URI'])
      ;

    //$this->addElement('Hash', 'token');

    $locale = Zend_Registry::get('Zend_Translate')->getLocale();
    $territories = Zend_Locale::getTranslationList('territory', $locale, 2);
    $countryCode = $this->getEvent()->bank_country;
    
    if (!empty($countryCode) and !empty($territories[$countryCode])) {
      $country = $territories[$countryCode];
    } else {
      $country = Zend_Registry::get('Zend_Translate')->_('No Country');
    }
    
    $content = Zend_Registry::get('Zend_View')
      ->translate('ADMIN_FORM_PAY_HOST_INFO %1$s %2$s %3$s %4$s %5$s',
        $this->getEvent()->bank_iban,
        $this->getEvent()->bank_bic,
        $this->getEvent()->bank_name,
        $this->getEvent()->bank_address,
        $country
    );
    
    $this->addElement('Dummy', 'host_info', array(
      'content' => nl2br($content),
    ));
    
    $this->getElement('host_info')->removeDecorator('label');
    
    $this->addElement('Button', 'submit', array(
      'label' => 'Pay',
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