<?php
class Advmenusystem_Form_Admin_Style extends Engine_Form
{
	protected $_style;
	
	public function getStyle()
	{
		return $this -> _style;
	}
	public function setStyle($style)
	{
		$this -> _style = $style;
	}
	
  public function init()
  {

	$arr_menuBar['flat'] = array(
		array('Background Color', 'background_color', 'color', '#f7f8f8'),
		array('Text Color', 'text_color', 'color', '#777'),
		array('Active/Hover Background Color', 'active_hover_background_color', 'color', '#1E88B9'),
		array('Hover Text Color', 'hover_text_color', 'color' ,'#FFFFFF'),
		array('Separated Line', 'separated_line', 'select'),
		array('Top Border Size', 'top_border_size', 'size', '2px'),
		array('Top Border Color', 'top_border_color', 'color', '#1E88B9'),
		array('Bottom Border Size', 'bottom_border_size', 'size', '2px'),
		array('Bottom Border Color', 'bottom_border_color', 'color','#EEEEEE'),
		array('Main Menu Drop Down', 'head_drop_down', 'dummy'),
		array('Left/Right Border Size', 'dropdown_left_right_border_size', 'size', '0px'),
		array('Left/Right Border Color', 'dropdown_left_right_border_color', 'color', '#F6F7F7'),
		array('Bottom Border Size', 'dropdown_bottom_border_size', 'size', '3px'),
		array('Bottom Border Color', 'dropdown_bottom_border_color', 'color', '#5a5e61'),
	);
	
	$arr_menuBar['metro'] = array(
		array('Background Color', 'background_color', 'color', '#1DACD6'),
		array('Text Color', 'text_color', 'color', '#FFFFFF'),
		array('Main Menu Drop Down', 'head_drop_down', 'dummy'),
		array('Top Border Size', 'dropdown_bottom_border_size', 'size', '3px'),
		array('Top Border Color', 'dropdown_bottom_border_color', 'color', '#1DACD6'),
		array('Left/Right/Bottom Border Size', 'dropdown_left_right_bottom_border_size', 'size', '1px'),
		array('Left/Right/Bottom Border Color', 'dropdown_left_right_border_bottom_color', 'color', '#1DACD6'),
	);
	
	$arr_menuBar['simple'] = array(
		array('Background Color', 'background_color', 'color' ,'#5483AB'),
		array('Text Color', 'text_color', 'color', '#FFFFFF'),
		array('Active/Hover Background Color', 'active_hover_background_color', 'color', '#324F67'),
		array('Hover Text Color', 'hover_text_color', 'color', '#E3E6E8'),
		array('Separated Line', 'separated_line', 'select'),
		array('Main Menu Drop Down', 'head_drop_down', 'dummy'),
		array('Border Size', 'dropdown_border_size', 'size', '1px' ),
		array('Border Color', 'dropdown_border_color', 'color', '#D6D6D6'),
	);
	
	$arr_menuBar['special'] = array(
		array('Background Color', 'background_color', 'color','#34495E'),
		array('Text Color', 'text_color', 'color', '#FFFFFF'),
		array('Background Icon Color', 'background_icon_color', 'color', '#29C0A1'),
		array('Hover Background Icon Color', 'hover_background_icon_color', 'color', '#EE1731'),
		array('Main Menu Drop Down', 'head_drop_down', 'dummy'),
		array('Border Size', 'dropdown_border_size', 'size', '2px'),
		array('Border Color', 'dropdown_border_color', 'color', '#384D61'),
	);
	
	$arr_menuBar['white'] = array(
		array('Text Color', 'text_color', 'color','#777777'),
		array('Active/Hover Border Color', 'active_hover_border_color', 'color', '#E74C3C'),
		array('Hover Text Color', 'hover_text_color', 'color','#E74C3C'),
		array('Separated Line', 'separated_line', 'select'),
		array('Main Menu Drop Down', 'head_drop_down', 'dummy'),
		array('Border Size', 'dropdown_border_size', 'size', '3px'),
		array('Border Color', 'dropdown_border_color', 'color', '#555555'),
	);
	
  	$view = Zend_Registry::get('Zend_View');
	$view->headScript()->appendFile(Zend_Registry::get('StaticBaseUrl') . 'application/modules/Advmenusystem/externals/scripts/jscolor.js');
    $this
      ->setTitle('Style Settings')
      ->setDescription('These settings affect all theme in your community.')
	  ->setAttrib('style',"width: 900px")
	  ->setAttrib('id',"style_setting_form");
	 
	
	//Change menu bar style 
	
	$this->addElement('dummy', 'head_menu_bar',array(
      'label'=>'Main Menu Style',
     ));
	
	$this->addElement('Select', 'main_menu_style', array(
      'label' => 'Main Menu Style',
      'onchange' => "$('style_setting_form').submit()",
    ));
	
	$this -> addElement('dummy', 'img_guild', array(
			'decorators' => array( array(
				'ViewScript',
				array(
					'viewScript' => '_img_guild.tpl',
					'style'=>$this -> _style,
					'class' => 'form element',
				)
			)), 
		));  
		
	//Change style for Main Menu drop down

 	foreach($arr_menuBar[$this -> _style] as $form_item)
	{
		switch ($form_item[2]) {
			
			case 'color':
				 $this->addElement('Text', $form_item[1], array(
				      'label' => $form_item[0],
				      'class' => 'color',   
				      'allowEmpty' => false,
				      'value' => $form_item[3],
				    ));
				break;
				
			case 'select':
				 $this->addElement('Select', $form_item[1], array(
				      'label' => $form_item[0],
				      'multiOptions' => array(
							      			'none' => 'none',
				 							'solid' => 'Solid',
							      			'dotted'  => 'Dot',
							      			'dashed' => 'Dash',
					  ),
					  'value' => 'solid'
				   ));	
				break;
				
			case 'size':
				 $this->addElement('Text', $form_item[1], array(
			      'label' => $form_item[0],      
			      'allowEmpty' => false,
			      'value' => (isset($form_item[3])) ? $form_item[3] : "0px",
			    )); 
				break;	
			
			case 'dummy':
				$this->addElement('dummy', $form_item[1], array(
			      'label' => $form_item[0],      
			    )); 
				break;
				
			default:
				
				break;
		}
	}
			
    // Add submit button
    $this->addElement('Button', 'save_change', array(
      'label' => 'Save Changes',
      'type' => 'submit',
      'ignore' => true,
      'decorators' => array(
        'ViewHelper'
      )
    ));
	// Clear submit button
    $this->addElement('Button', 'clear', array(
      'label' => 'Set Default',
      'type' => 'submit',
      'ignore' => true,
      'decorators' => array(
        'ViewHelper'
      )
    ));
	
	$this->addDisplayGroup(array('save_change', 'clear'), 'buttons', array(
      'decorators' => array(
        'FormElements',
        'DivDivDivWrapper',
      ),
    ));
  }
}