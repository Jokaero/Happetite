<?php
class SocialConnect_Form_Confirm extends Engine_Form
{
  public function init()
  {
    $this->setTitle('Delete Linking')->setAttrib('class','global_form_popup');
	
	$this->setDescription('Are you sure you want to delete linking?')
		->setAction ( Zend_Controller_Front::getInstance ()->getRouter ()->assemble ( array () ) )
		->setMethod ( 'POST' );
    // Buttons
    $this->addElement('Button', 'submit', array(
      'label' => 'Delete Linking',
      'type' => 'submit',
      'decorators' => array('ViewHelper')
    ));
	
    $this->addElement('Cancel', 'cancel', array(
      'label' => 'cancel',
      'link' => true,
      'prependText' => Zend_Registry::get('Zend_Translate')->_('or '),
      'href' => '',
      'onclick' => 'parent.Smoothbox.close()',
      'decorators' => array(
        'ViewHelper'
      )
    ));
    $this->addDisplayGroup(array('submit', 'cancel'), 'buttons');
    $button_group = $this->getDisplayGroup('buttons');
  }
}