<?php
/**
 * YouNet
 *
 * @category   Application_Extensions
 * @package    Adv Menu system
 * @copyright  Copyright 2011 YouNet Company
 * @license    http://www.modules2buy.com/
 * @version    $Id: AdminSettingsController.php
 * @author     Minh Nguyen
 */
class Advmenusystem_AdminStylesController extends Core_Controller_Action_Admin
{
	public function init()
	{
		$this -> view -> navigation = $navigation = Engine_Api::_() -> getApi('menus', 'core') -> getNavigation('advmenusystem_admin_main', array(), 'advmenusystem_admin_main_styles');
	}

	public function indexAction()
	{
		$params = $this -> getRequest() -> getPost();
		$main_menu_style = 'flat';
		if(!empty($params['main_menu_style']))
		{
			$main_menu_style = $params['main_menu_style'];
		}
		$main_menu_styles = array(
			'flat' => 'Flat',
			'metro' => 'Metro',
			'simple' => 'Simple',
			'special' => 'Special',
			'white' => 'White',
		);
		$this -> view -> form = $form = new Advmenusystem_Form_Admin_Style(array('style' => $main_menu_style));
		$url = (_ENGINE_SSL ? 'https://' : 'http://') . $_SERVER['HTTP_HOST'] . $this -> view -> url(array('controller' => 'files'), 'admin_default', true);
		$form -> addNotice($this -> view -> translate('Please go to <a href = "%s" target = "_blank">File & Media Manager</a> to upload and copy URL for icons.', $url));
		$form -> addNotice("If you do not want to set color in color textbox, please kindly copy `transparent` and paste it into color textbox.");
		$values = Engine_Api::_() -> getApi('settings', 'core') -> getSetting($main_menu_style.'.avdmenusystem.customcssobj', 0);
		$values = Zend_JSON::decode($values);
		$form -> main_menu_style -> addMultiOptions($main_menu_styles);
		if ($values)
		{
			$form -> populate($values);
		}
		else {
			$form -> main_menu_style -> setValue($main_menu_style);
		}
		
		if (isset($params['save_change']) || isset($params['clear']))
		{
			if ($this -> getRequest() -> isPost() && $form -> isValid($params))
			{
				$values = $form -> getValues();
				if (isset($_POST['save_change']))
				{
					/*
					echo "<pre>";
					print_r($values);
					echo "</pre>"; exit;
					*/
					$str = $this -> view -> partial("_css_{$main_menu_style}.tpl");
					$arr_keys = array_keys($values);
					$arr_values = array_values($values);
					$arr_keys = array_map(array(
						$this,
						'map'
					), $arr_keys);
					$str = str_replace($arr_keys, $arr_values, $str);
					Engine_Api::_() -> getApi('settings', 'core') -> setSetting($main_menu_style .'.avdmenusystem.customcssobj', Zend_JSON::encode($values));
					Engine_Api::_() -> getApi('settings', 'core') -> setSetting($main_menu_style .'_avdmenusystem_customcss', $str);
					$form -> addNotice('Your changes have been saved.');
				}
				else
				if (isset($_POST['clear']))
				{
					$server_array = explode("/", $_SERVER['PHP_SELF']);
					$server_array_mod = array_pop($server_array);
					if ($server_array[count($server_array) - 1] == "admin")
					{
						$server_array_mod = array_pop($server_array);
					}
					$server_info = implode("/", $server_array);
					$url = (_ENGINE_SSL ? 'https://' : 'http://') . $_SERVER['HTTP_HOST'] . $server_info . '/application/modules/Advmenusystem/externals/images/notification_inbox_updates.png';
					Engine_Api::_() -> getApi('settings', 'core') -> setSetting($main_menu_style.'.avdmenusystem.customcssobj', '');
					Engine_Api::_() -> getApi('settings', 'core') -> setSetting($main_menu_style.'_avdmenusystem_customcss', '');
					
					switch ($main_menu_style) {
						case 'flat'://DONE
							$form -> populate(array(
								'background_color' => '#f7f8f8',
								'text_color' => '#777',
								'active_hover_background_color' => '#1E88B9',
								'hover_text_color' => '#FFFFFF',
								'separated_line' => 'solid',
								'top_border_size' => '2px',
								'top_border_color' => '#1E88B9',
								'bottom_border_size' => '2px',
								'bottom_border_color' => '#EEEEEE',
								'dropdown_left_right_border_size' => '2px',
								'dropdown_left_right_border_color' => 'transparent',
								'dropdown_bottom_border_size' => '3px',
								'dropdown_bottom_border_color' => '#5a5e61',
							));
							break;
						
						case 'metro': //DONE
							$form -> populate(array(
								'background_color' => '#1DACD6',
								'text_color' => '#FFFFFF',
								'dropdown_bottom_border_size' => '3px',
								'dropdown_bottom_border_color' => '#1DACD6',
								'dropdown_left_right_bottom_border_size' => '1px',
								'dropdown_left_right_border_bottom_color' => '#1DACD6',
							));
							break;
						
						case 'simple': //DONE
							$form -> populate(array(
								'background_color' => '#5483AB',
								'text_color' => '#FFFFFF',
								'active_hover_background_color' => '#324F67',
								'hover_text_color' => '#E3E6E8',
								'separated_line' => 'solid',
								'dropdown_border_size' => '1px',
								'dropdown_border_color' => '#D6D6D6',
							));
							break;
						
						case 'special': //DONE
							$form -> populate(array(
								'background_color' => '#34495E',
								'text_color' => '#FFFFFF',
								'background_icon_color' => '#29C0A1',
								'hover_background_icon_color' => '#EE1731',
								'dropdown_border_size' => '2px',
								'dropdown_border_color' => '#384D61',
							));
							break;
						
						case 'white': //DONE
							$form -> populate(array(
								'text_color' => '#777777',
								'active_hover_border_color' => '#E74C3C',
								'hover_text_color' => '#E74C3C',
								'separated_line' => 'none',
								'dropdown_border_size' => '3px',
								'dropdown_border_color' => '#555555',
							));
							break;
					}
					$form -> addNotice('You have set default styles.');
				}
			}
		}
	}

	static public function map($a)
	{
		return "[{$a}]";
	}

}
