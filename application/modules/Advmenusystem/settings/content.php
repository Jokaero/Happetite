<?php
/**
 * YouNet
 *
 * @category   Application_Extensions
 * @package    Groupbuy
 * @copyright  Copyright 2011 YouNet Developments
 * @license    http://www.modules2buy.com/
 * @version    $Id: content.php
 * @author     Minh Nguyen
 */
return array(
	array(
		'title' => 'Advanced Main Menu',
		'description' => 'Displays Advanced Main Menu on header page.',
		'category' => 'Advanced Menu System',
		'type' => 'widget',
		'name' => 'advmenusystem.advanced-main-menu',
		'adminForm'=> array(
				'elements' => array(
						array(
								'Text',
								'title',
								array(
										'label' => 'Title'
								)
						),
						array(
								'Radio',
								'style_menu',
								array(
										'label' => 'Select style for main menu bar',
										'multiOptions' => array(
													'flat' => 'Flat',
													'metro' => 'Metro',
													'simple' => 'Simple',
													'special' => 'Special',
													'white' => 'White',
										),
										'value' => 'flat',
								)
						),	
						array(
								'Radio',
								'fix_menu_position',
								array(
										'label' => 'Do you want to fix menu position when users scroll the browser?',
										'multiOptions' => array(
												1 => 'Yes.',
												0 => 'No.',
										),
										'value' => 1,
								)
						),		
						array(
								'Radio',
								'show_non_logged_user',
								array(
										'label' => 'Do you want to show this widget to non-logged in users?',
										'multiOptions' => array(
												1 => 'Yes.',
												0 => 'No.',
										),
										'value' => 1,
								)
						),		
						array(
								'Text',
								'number_tabs',
								array(
										'label' =>  'How many tabs do you want to show?',
										'value' => '7',
										'required' => true,
										'validators' => array(
												array('Between',true,array(1,12)),
										),
								),
						),	
						array(
								'Text',
								'title_truncation',
								array(
										'label' =>  'Enter the title truncation for the content.',
										'value' => '20',
										'required' => true,
										'validators' => array(
												array('Between',true,array(1,50)),
										),
								),
						),	
						array(
								'Radio',
								'show_more_link',
								array(
										'label' => 'Do you want to show this display `More` link in this widget?',
										'multiOptions' => array(
												1 => 'Yes.',
												0 => 'No.',
										),
										'value' => 1,
								)
						),							
						array(
								'Radio',
								'arrow_sign',
								array(
										'label' => 'Do you want to show arrow with menu name?
										   			Note: The arrow sign will come only if the menu contains submenus.',
										'multiOptions' => array(
												1 => 'Yes.',
												0 => 'No.',
										),
										'value' => 1,
								)
						),		
			  )),
		),
	
		
	array(
	    'title' => 'Advanced Mini Menu',
	    'description' => 'Please go to <a href="admin/files" target="_parent">File & Media Manager</a> to upload image and copy link to `Notification background image` text box.',
	    'category' => 'Advanced Menu System',
	    'type' => 'widget',
		'name' => 'advmenusystem.advanced-mini-menu',
	    'adminForm' => 'Advmenusystem_Form_Admin_Widget_Mini',
	    'requirements' => array(
	      'header-footer',
	  ),
	 ),
	 	
	array(
	    'title' => 'Advanced Footer Menu',
	    'description' => 'Displays Advanced Footer on fotter page. Icons are uploaded via the <a href="admin/advmenusystem/socials" target="_parent">Social Link Manager</a>.',
	    'category' => 'Advanced Menu System',
	    'type' => 'widget',
		'name' => 'advmenusystem.advanced-footer-menu',
	    'adminForm' => 'Advmenusystem_Form_Admin_Widget_Footer',
	    'requirements' => array(
	      'header-footer',
	  ),
  ),
  
) ?>