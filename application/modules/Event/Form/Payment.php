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
class Event_Form_Payment extends Engine_Form
{
  public function init()
  {
    $this
      ->setTitle('Payment')
      //->setDescription('Are you sure you want to cancel this class?')
      ->setAttrib('class', 'global_form_popup')
      ->setMethod('POST')
      ->setAction($_SERVER['REQUEST_URI'])
      ;

    $this->addElement('Text', 'card_number', array(
      'label' => 'Card Number',
      'allowEmpty' => false,
      'required' => true,
      'validators' => array(
        array('NotEmpty', true),
        array('StringLength', false, array(16, 16)),
      ),
    ));
    
    $this->addElement('Select', 'card_expiration_month', array(
      'label' => 'Expires',
      'allowEmpty' => false,
      'required' => true,
      'validators' => array(
        array('NotEmpty', true),
        array('StringLength', false, array(2, 2)),
      ),
      'multiOptions' => array(
        '01' => '01',
        '02' => '02',
        '03' => '03',
        '04' => '04',
        '05' => '05',
        '06' => '06',
        '07' => '07',
        '08' => '08',
        '09' => '09',
        '10' => '10',
        '11' => '11',
        '12' => '12',
      ),
      'decorators' => array(
        'ViewHelper',
        array('Label', array('tag' => null, 'placement' => 'PREPEND')),
      ),
    ));
    
    $yearNow = date('Y');
    $this->addElement('Select', 'card_expiration_year', array(
      'allowEmpty' => false,
      'required' => true,
      'validators' => array(
        array('NotEmpty', true),
        array('StringLength', false, array(4, 4)),
      ),
      'multiOptions' => array(
        $yearNow     => $yearNow,
        $yearNow + 1 => $yearNow + 1,
        $yearNow + 2 => $yearNow + 2,
        $yearNow + 3 => $yearNow + 3,
        $yearNow + 4 => $yearNow + 4,
        $yearNow + 5 => $yearNow + 5,
        $yearNow + 6 => $yearNow + 6,
        $yearNow + 7 => $yearNow + 7,
        $yearNow + 8 => $yearNow + 8,
        $yearNow + 9 => $yearNow + 9,
      ),
      'decorators' => array('ViewHelper'),
    ));
    
    $this->addDisplayGroup(array(
      'card_expiration_month',
      'card_expiration_year'
    ), 'expires');
    
    $this->addElement('Text', 'cardholder_name', array(
      'label' => 'Name On Card',
      'allowEmpty' => false,
      'required' => true,
      'validators' => array(
        array('NotEmpty', true),
        array('StringLength', false, array(3, 255)),
      ),
    ));
    
    $this->addElement('Image', 'cvv_image', array(
      'src' => 'application/modules/Event/externals/images/CVV2_back.gif',
      'decorators' => array(
        'ViewHelper',
        array('HtmlTag', array('tag' => 'div', 'class' => 'block_cvv_image')),
      ),
    ));
    
    $this->addElement('Text', 'cvv', array(
      'label' => 'CVV2 Number',
      'allowEmpty' => false,
      'required' => true,
      'validators' => array(
        array('NotEmpty', true),
        array('StringLength', false, array(3, 255)),
      ),
    ));
    
    $this->addElement('Button', 'submit', array(
      'label' => 'Pay Now',
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
  
  public function isValid($data)
  {
    $result = parent::isValid($data);
    
    if (empty($result)) {
      return;
    }
    
    $cardDateExpiration = strtotime($data['card_expiration_year'] . '-' . $data['card_expiration_month'] . '-00');
    $nowDate = strtotime(date('Y-m') . '-00');
    
    if (($cardDateExpiration - $nowDate) < 0) {
      $this->addError('Your credit card has expired');
      return false;
    }
    
    return true;
  }
}