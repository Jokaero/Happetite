<?php

class Core_Form_Admin_Widget_RichText extends Engine_Form
{
  public function init()
  {
    $this
      ->setAttrib('class', 'global_form_popup')
      ->setAction($_SERVER['REQUEST_URI'])
      ;

    $this->addElement('Text', 'title', array(
      'label' => 'Title',
      'order' => -100,
    ));

    $this->addElement('TinyMce', 'data', array(
      'label' => 'Content',
      'editorOptions' => array(
        'toolbar1' => array('bold', 'italic', 'underline', 'strikethrough', '|', 'fontselect', 'fontsizeselect', 'forecolor', '|', 'bullist', 'numlist', 'outdent', 'indent', '|', 'alignleft', 'aligncenter', 'alignright', 'alignjustify', '|', 'link', 'image'),
	'plugins' => array('textcolor', 'link', 'image'),
      )
    ));

    $this->addElement('Hidden', 'name', array(
      'order' => 100005,
    ));

    $this->addElement('Button', 'execute', array(
      'label' => 'Save Changes',
      'type' => 'submit',
      'order' => 100006,
      'ignore' => true,
      'decorators' => array('ViewHelper'),
    ));
    
    $this->addElement('Cancel', 'cancel', array(
      'label' => 'cancel',
      'link' => true,
      'prependText' => ' or ',
      'onclick' => 'parent.Smoothbox.close();',
      'ignore' => true,
      'order' => 100007,
      'decorators' => array('ViewHelper'),
    ));

     $this->addDisplayGroup(array('execute', 'cancel'), 'buttons', array(
      'order' => 100008,
    ));
  }
}