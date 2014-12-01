<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Fields
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Type.php 9772 2012-08-30 22:25:06Z matthew $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Fields
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @author     John
 */
class Fields_Form_Admin_Type extends Engine_Form
{
  public function init()
  {
    
    // Get list of Member Types
    $db = Engine_Db_Table::getDefaultAdapter();
    $member_type_result = $db->select('option_id, label')
            ->from('engine4_user_fields_options')
            ->query()
            ->fetchAll();
    $member_type_count = count($member_type_result);
    $member_type_array = array( 'null' => 'No, Create Blank Profile Type' );
    for( $i = 0; $i < $member_type_count; $i++) {
      $member_type_array[$member_type_result[$i]['option_id']] = $member_type_result[$i]['label']; 
    }
        
    $this->setMethod('POST')
      ->setAttrib('class', 'global_form_smoothbox');
    
    // Add label
    $this->addElement('Text', 'label', array(
      'label' => 'Profile Type Label',
      'required' => true,
      'allowEmpty' => false,
    ));

    // Duplicate Existing
    $this->addElement('Select', 'duplicate', array(
      'label' => 'Duplicate Existing Profile Type?',
      'required' => true,
      'allowEmpty' => false,
      'multiOptions' => $member_type_array,
    ));


    // Add submit
    $this->addElement('Button', 'submit', array(
      'label' => 'Add Profile Type',
      'type' => 'submit',
      'decorators' => array(
        'ViewHelper',
      ),
    ));

    // Add cancel
    $this->addElement('Cancel', 'cancel', array(
      'label' => 'cancel',
      'link' => true,
      'onclick' => 'parent.Smoothbox.close();',
      'prependText' => ' or ',
      'decorators' => array(
        'ViewHelper',
      ),
    ));

    $this->addDisplayGroup(array('submit', 'cancel'), 'buttons');
  }
}