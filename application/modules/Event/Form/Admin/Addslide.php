<?php

class Event_Form_Admin_Addslide extends Engine_Form
{
    public function init()
    {
        $this->setTitle('Add New Slide')
            ->setAttrib('id', 'slide_create_form')
            ->setMethod("POST")
            ->setAction(Zend_Controller_Front::getInstance()->getRouter()->assemble(array()));
            
        $this->addElement('Textarea', 'description', array(
            'label' => 'Slide Description',
            'maxlength' => '10000',
            'filters' => array(
              'StripTags',
              new Engine_Filter_Censor(),
              new Engine_Filter_EnableLinks(),
              new Engine_Filter_StringLength(array('max' => 10000)),
            ),
        ));
        
        $this->addElement('File', 'photo', array(
            'label' => 'Main Photo',
            'required' => true,
        ));
        
        $this->photo->addValidator('Extension', false, 'jpg,png,gif,jpeg');
        
        $this->addElement('Button', 'submit', array(
            'label' => 'Save Changes',
            'type' => 'submit',
            'ignore' => true,
            'decorators' => array(
              'ViewHelper',
            ),
        ));
        
    }
}