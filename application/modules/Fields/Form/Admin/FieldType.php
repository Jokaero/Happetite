<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Fields
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: FieldType.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Fields
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @author     John
 */
class Fields_Form_Admin_FieldType extends Engine_Form
{
  public function init()
  {
    $this->setMethod('GET')
      ->setAttrib('class', 'global_form_smoothbox')
      ->setTitle('Edit Profile Question');

    // Add type
    $categories = Engine_Api::_()->fields()->getFieldInfo('categories');
    $types = Engine_Api::_()->fields()->getFieldInfo('fields');
    $fieldByCat = array();
    $availableTypes = array('' => '');
    foreach( $types as $fieldType => $info ) {
      $fieldByCat[$info['category']][$fieldType] = $info['label'];
    }
    foreach( $categories as $catType => $categoryInfo ) {
      $label = $categoryInfo['label'];
      $availableTypes[$label] = $fieldByCat[$catType];
    }

    $this->addElement('Select', 'type', array(
      'label' => 'Question Type',
      'required' => true,
      'allowEmpty' => false,
      'multiOptions' => $availableTypes,
      /* 'multiOptions' => array(
        'text' => 'Text Field',
        'textarea' => 'Multi-line Textbox',
        'select' => 'Pull-down Select Box',
        'radio' => 'Radio Buttons',
        'checkbox' => 'Checkboxes',
        'date' => 'Date Field'
      ) */
      'onchange' => 'this.getParent("form").submit();',
    ));
  }
}