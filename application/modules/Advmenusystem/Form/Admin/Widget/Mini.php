<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.net/license/
 * @version    $Id: ItemCreate.php 7244 2010-09-01 01:49:53Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.net/license/
 */
class Advmenusystem_Form_Admin_Widget_Mini extends Core_Form_Admin_Widget_Standard
{
  public function init()
  {
  	$view = Zend_Registry::get('Zend_View');
    $view->headScript()->appendFile(Zend_Registry::get('StaticBaseUrl') . 'application/modules/Advmenusystem/externals/scripts/jscolor.js');
     $this
      ->setDescription('Please go to File & Media Manager to upload image.')
	  -> addNotice("If you do not want to set color in color textbox, please kindly copy `transparent` and paste it into color textbox.");
      ;

    $this->addElement('Text', 'title', array(
    	'label' => 'Title',
		'readonly' => true,    
	 )); 
	
	$this->addElement('Radio', 'design_type',array(
		'label' => 'Select the design type for the tabs in mini menu.
				Note: Not all menus support icons. 
				Also, you will be able to configure the icon only for the tab you add.',
		'multiOptions' => array(
				'icon' => 'Icon Type.',
				'title' => 'Title Type.',
		),
		'value' => 'icon',
	));
    
	$this->addElement('Text', 'title_color', array(
				      'label' => 'Title color (Title Type)',
				      'class' => 'color',   
				      'allowEmpty' => false,
				      'value' => '#000000'
	));
	
	$this->addElement('Text', 'hover_color', array(
				      'label' => 'Hover color (Title Type)',
				      'class' => 'color',   
				      'allowEmpty' => false,
				      'value' => '#5FAEDB'
	));
	
	$server_array = explode("/", $_SERVER['PHP_SELF']);
	$server_array_mod = array_pop($server_array);
	if ($server_array[count($server_array) - 1] == "admin")
	{
		$server_array_mod = array_pop($server_array);
	}
	$server_info = implode("/", $server_array);
	$url = ( _ENGINE_SSL ? 'https://' : 'http://' )
        . $_SERVER['HTTP_HOST'].$server_info.'/application/modules/Advmenusystem/externals/images/notification_inbox_updates.png';
	
	$this->addElement('Text', 'notification_icons', array(
      'label' => 'Notification icons',      
      'allowEmpty' => false,
      'value' => $url,
    )); 
	
	$this -> addElement('Text', 'number_item_show', array(
			'label' =>  'Number of Friend Requests, Messages and Notifications to show',
			'value' => '10',
			'required' => true,
			'validators' => array(
					array('Between',true,array(1,20)),
			),
	));		
	
	$this -> addElement('Text', 'width_searchbox', array(
			'label' =>  'Enter width for searchbox',
			'value' => '275px',
			'required' => true,
	));	
	
	$this->addElement('Radio', 'lightbox_signin',array(
			'label' => 'Enable lightbox for Sign In?',
			'multiOptions' => array(
					1 => 'Yes.',
					0 => 'No.',
			),
			'value' => 1,
	));		
	
	$this->addElement('Radio', 'lightbox_signup',array(
			'label' => 'Enable lightbox for Sign Up?',
			'multiOptions' => array(
					1 => 'Yes.',
					0 => 'No.',
			),
			'value' => 1,
	));		
	
    
  }
}