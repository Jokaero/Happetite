<?php
class Advmenusystem_Form_Admin_Menu_ItemCreate extends Engine_Form
{
  public function init()
  {
    $this
      ->setTitle('Create Menu Item')
      ->setAttrib('class', 'global_form_popup')
      ;

    $this->addElement('Text', 'label', array(
      'label' => 'Label',
      'required' => true,
      'allowEmpty' => false,
    ));
	
    $this->addElement('Text', 'uri', array(
      'label' => 'URL',
      'required' => true,
      'allowEmpty' => false,
      'style' => 'width: 300px',
      //'validators' => array(
      //  array('NotEmpty', true),
      //)
    ));
    
    $this->addElement('Text', 'icon', array(
      'label' => 'Icon',
      'description' => 'Note: Not all menus support icons.',
      'style' => 'width: 500px',
    ));
    
    $this->addElement('Checkbox', 'submenu', array(
      'label' => 'Is sub Menu?',
      'checkedValue' => '1',
      'uncheckedValue' => '0',
    ));
    
    $this->addElement('Checkbox', 'target', array(
      'label' => 'Open in a new window?',
      'checkedValue' => '_blank',
      'uncheckedValue' => '',
    ));

    $this->addElement('Checkbox', 'enabled', array(
      'label' => 'Enabled?',
      'checkedValue' => '1',
      'uncheckedValue' => '0',
    ));

    // Buttons
    $this->addElement('Button', 'submit', array(
      'label' => 'Create Menu Item',
      'type' => 'submit',
      'ignore' => true,
      'decorators' => array('ViewHelper')
    ));

    $this->addElement('Cancel', 'cancel', array(
      'label' => 'cancel',
      'link' => true,
      'prependText' => ' or ',
      'href' => '',
      'onclick' => 'parent.Smoothbox.close();',
      'decorators' => array(
        'ViewHelper'
      )
    ));
    
    $this->addDisplayGroup(array('submit', 'cancel'), 'buttons');
  }
}