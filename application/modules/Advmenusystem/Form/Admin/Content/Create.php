<?php
class Advmenusystem_Form_Admin_Content_Create extends Engine_Form
{
  public function init()
  {
    $this
      ->setTitle('Create Menu Content')
      ->setAttrib('class', 'global_form_popup')
      ;
	$this->addElement('Select', 'parent', array(
		  'label' => 'Menu Item',
	));
	
    $this->addElement('Text', 'title', array(
      'label' => 'Title',
      'required' => true,
      'allowEmpty' => false,
      'filters' => array(
        new Engine_Filter_Censor(),
        'StripTags'
      ),
    ));
	
    $this->addElement('Text', 'url', array(
      'label' => 'URL',
      'required' => true,
      'allowEmpty' => false,
      'style' => 'width: 300px',
    ));
    
	$this -> addElement('File', 'photo', array('label' => 'Content Photo', ));
	$this -> photo -> addValidator('Extension', false, 'jpg,png,gif,jpeg');
	
   $this->addElement('Text', 'order', array(
      'label' => 'Order',
      'required' => true,
      'allowEmpty' => false,
    ));

    $this->addElement('Checkbox', 'enabled', array(
      'label' => 'Enabled?',
      'checkedValue' => '1',
      'uncheckedValue' => '0',
    ));

    // Buttons
    $this->addElement('Button', 'submit', array(
      'label' => 'Create Menu Content',
      'type' => 'submit',
      'onclick' => 'removeSubmit()',
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
	
public function saveValues()
   {

    $values = $this->getValues();
	
     $params['title'] = $values['title'];
	 $params['url'] = $values['url'];
     $content = Engine_Api::_() -> getDbtable('contents', 'advmenusystem') -> createRow();
	 $content-> parent_id = substr($values['parent'], 2);
	 $content-> level  = substr($values['parent'], 0, 1);
	 $content-> order = $values['order'];
	 $content-> enabled = $values['enabled'];
	 $content-> params = json_encode($params);
     $content->save();
    
    if (!empty($values['photo']))
		$content -> setPhoto($this -> photo);
    return $content;
  }
}

