<?php
class Advmenusystem_Form_Admin_Content_Search extends Engine_Form {
  public function init()
  {
    $this->clearDecorators()
         ->addDecorator('FormElements')
         ->addDecorator('Form')
         ->addDecorator('HtmlTag', array('tag' => 'div', 'class' => 'search'))
         ->addDecorator('HtmlTag2', array('tag' => 'div', 'class' => 'clear'));

    $this->setAttribs(array(
                'id' => 'filter_form',
                'class' => 'global_form_box',
                'method'=>'GET',
                'action' => Zend_Controller_Front::getInstance() -> getRouter() -> assemble(array('module' => 'advmenusystem', 'controller' => 'contents', 'action' => 'index'), 'admin_default', true)
            ));

    //Feature Filter
    $this->addElement('Select', 'filter', array(
      'label' => 'Filter By Menu',
      'multiOptions' => array('all' => 'All Menu')
    ));

	$this->addElement('Hidden', 'search_filter', array(
      'value' => '1',
    ));    
    
     // Buttons
    $this->addElement('Button', 'search_button', array(
      'label' => 'Search',
      'type' => 'submit',
      'value' => 'search_button'
    ));

    $this->search_button->clearDecorators()
            ->addDecorator('ViewHelper')
            ->addDecorator('HtmlTag', array('tag' => 'div', 'class' => 'buttons'))
            ->addDecorator('HtmlTag2', array('tag' => 'div'));
  }
}