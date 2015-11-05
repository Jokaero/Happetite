<?php
class Advmenusystem_Form_Admin_Menu_ItemCoreMainCreate extends Engine_Form
{
  public function init()
  {
  	$view = Zend_Registry::get('Zend_View');
    $view->headScript()->appendFile(Zend_Registry::get('StaticBaseUrl') . 'application/modules/Advmenusystem/externals/scripts/jscolor.js');
    $this
      ->setTitle('Create Core Main Menu Item')
      ->setAttrib('class', 'global_form_popup')
      ;

    $this->addElement('Text', 'label', array(
      'label' => 'Label',
      'required' => true,
      'allowEmpty' => false,
    ));
	
	$styles = array(
			"standard"	=> 'Standard Hierarchical Navigation Menu',
			"multi"	=> 'Multi Column Menu',
			"mixed"	=> 'Mixed Menu',
			"content"	=> 'Main Menu with Content',
			);
			
	$this->addElement('Select', 'style', array(
	  'label' => 'Style',
	  'multiOptions' => $styles,
	  'onchange' => 'loadDropBox()',
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
    
     // Get available files
    $logoOptions = array('' => 'Text-only (No images)');
    $imageExtensions = array('gif', 'jpg', 'jpeg', 'png');

    $it = new DirectoryIterator(APPLICATION_PATH . '/public/admin/');
    foreach( $it as $file ) {
      if( $file->isDot() || !$file->isFile() ) continue;
      $basename = basename($file->getFilename());
      if( !($pos = strrpos($basename, '.')) ) continue;
      $ext = strtolower(ltrim(substr($basename, $pos), '.'));
      if( !in_array($ext, $imageExtensions) ) continue;
      $logoOptions['public/admin/' . $basename] = $basename;
    }

    $this->addElement('Select', 'icon', array(
      'label' => 'Menu Icon',
      'multiOptions' => $logoOptions,
    ));
    
	 $this->addElement('Select', 'hover_active_icon', array(
      'label' => 'Menu Hover/Active Icon',
      'multiOptions' => $logoOptions,
    ));
	
 	$this->addElement('Text', 'main_menu_background_color', array(
      'label' => 'Background Color',
      'class' => 'color',   
      'allowEmpty' => false,
      'value' => "transparent",
    ));
	$this->addElement('Text', 'main_menu_text_color', array(
      'label' => 'Text Color',
      'class' => 'color',   
      'allowEmpty' => false,
      'value' => "transparent",
    )); 
	$this->addElement('Text', 'main_menu_hover_color', array(
      'label' => 'Hover Color',
      'class' => 'color',   
      'allowEmpty' => false,
      'value' => "transparent",
    ));  
	
	$this->addElement('Heading', 'separator', array(
		  'label' => 'Multi Column Menu Options',
		  'decorators' => array(
                'ViewHelper',
                array('Label', array('tag' => 'span')),
                array('HtmlTag2', array('class' => 'multicolumn_title'))
            ),
		));
	
	$this->addElement('Text', 'background_multicolumn_color', array(
      'label' => 'Dropdown Background Color',
      'class' => 'color',   
      'allowEmpty' => false,
      'value' => "transparent",
    ));     
	
	$this->addElement('Select', 'background_multicolumn_image', array(
      'label' => 'Dropdown Background Image',
      'multiOptions' => $logoOptions,
    ));
	
	$this->addElement('Checkbox', 'login', array(
      'label' => 'Registered user',
      'checkedValue' => '1',
      'uncheckedValue' => '0',
      'checked' => true,
    ));
	
	$this->addElement('Checkbox', 'logout', array(
      'label' => 'Guest',
      'checkedValue' => '1',
      'uncheckedValue' => '0',
      'checked' => true,
    ));
	
    $this->addElement('Checkbox', 'target', array(
      'label' => 'Open in a new window?',
      'checkedValue' => '_blank',
      'uncheckedValue' => '',
      'checked' => true,
    ));

    $this->addElement('Checkbox', 'enabled', array(
      'label' => 'Enabled?',
      'checkedValue' => '1',
      'uncheckedValue' => '0',
      'checked' => true,
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