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
  protected $_event;
  
  public function setEvent($event)
  {
    $this->_event = $event;
  }
  
  public function getEvent()
  {
    return $this->_event;
  }
  
  public function init()
  {
    $this
    //->setDescription('Are you sure you want to cancel this class?')
      ->setAttrib('class', 'global_form_popup payment_form')
      ->setMethod('POST')
      ->setAction($_SERVER['REQUEST_URI'])
      ;
    
    $this->addElement('Dummy', 'pay_logo', array(
      'description' => '<div class="dummy_pay_logo"></div>',
      'decorators' => array(
        'ViewHelper', array(
          'description', array('placement' => 'APPEND', 'escape' => false)
      )),
    ));
    
    $this->addElement('Radio', 'card_type', array(
      'label' => 'Card Type',
      'required' => true,
      'allowEmpty' => false,
      'multiOptions' => array(
        0 => '',
        1 => '',
      ),
      'value' => 0,
      'decorators' => array(
          'ViewHelper',
          array('Label', array('tag' => null, 'placement' => 'PREPEND')),
          array('HtmlTag', array('tag' => 'div', 'class' => 'radiobutton_card_type')),
        ),
    ));
    
    $this->addElement('Text', 'card_number', array(
      'label' => 'Card Number',
      'allowEmpty' => false,
      'required' => true,
      'validators' => array(
        array('NotEmpty', true),
        array('StringLength', false, array(16, 16)),
      ),
       'decorators' => array(
          'ViewHelper',
          array('Label', array('tag' => null, 'placement' => 'PREPEND')),
          array('HtmlTag', array('tag' => 'div', 'class' => 'card_number')),
        ),
    ));
    
    $this->addElement('Text', 'cardholder_name', array(
      'label' => 'Full Name',
      'allowEmpty' => false,
      'required' => true,
      'validators' => array(
        array('NotEmpty', true),
        array('StringLength', false, array(3, 255)),
      ),
      'decorators' => array(
          'ViewHelper',
          array('Label', array('tag' => null, 'placement' => 'PREPEND')),
          array('HtmlTag', array('tag' => 'div', 'class' => 'cardholder_name')),
        ),
    ));
    
    $this->addElement('Select', 'card_expiration_month', array(
      'label' => 'Expiration',
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
        array('HtmlTag', array('tag' => 'span', 'class' => 'card_expiration_month')),
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
      'decorators' => array(
          'ViewHelper',
          array('Label', array('tag' => null, 'placement' => 'PREPEND')),
          array('HtmlTag', array('tag' => 'div', 'class' => 'cvv_number')),
        ),
    ));
    
    $this->addElement('Dummy', 'explanation', array(
      'description' => '<a class="explanation_link" id="explanation_link">Explanation</div>',
      'decorators' => array(
        'ViewHelper', array(
          'description', array('placement' => 'APPEND', 'escape' => false)
      )),
    ));
    
     $this->addDisplayGroup(array(
      'cvv',
      'explanation'
    ), 'cvv_explanation');
     
     
     $this->addElement('Dummy', 'amount', array(
      'label' => 'Amount:',
      'content' => $this->getEvent()
    ));
     
    
     $this->addElement('Cancel', 'cancel', array(
      'label' => 'cancel',
      'link' => true,
      'href' => '',
      'onclick' => 'parent.Smoothbox.close();',
      'decorators' => array(
        'ViewHelper'
      ),
    ));
    
    $this->addElement('Button', 'submit', array(
      'ignore' => true,
      'decorators' => array('ViewHelper'),
      'type' => 'submit'
    ));

   

    $this->addDisplayGroup(array(
      'cancel',
      'submit'      
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