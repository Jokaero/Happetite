<?php
/**
 * YouNet
 *
 * @category   Application_Extensions
 * @package    Adv Notification
 * @copyright  Copyright 2011 YouNet Developments
 * @license    http://www.modules2buy.com/
 * @version    $Id: menu auctions
 * @author     Minh Nguyen
 */
class Advmenusystem_Widget_AdvancedMiniMenuController extends Engine_Content_Widget_Abstract
{
	public function indexAction()
	{
		$this -> view -> design_type = $design_type = $this -> _getParam('design_type', 'icon');
		$this -> view -> title_color = $title_color = $this -> _getParam('title_color', 0);
		$this -> view -> hover_color = $hover_color = $this -> _getParam('hover_color', 0);
		$this -> view -> notification_icons = $notification_icons = $this -> _getParam('notification_icons', 0);
		$this-> view ->number_item_show = $this -> _getParam('number_item_show', 10);
		$this-> view -> width_searchbox = $this -> _getParam('width_searchbox', '275px');
		$this -> view -> advmenusystemEnableLoginLightbox = $this -> _getParam('lightbox_signin', 1);
		$this -> view -> advmenusystemEnableSignupLightbox = $this -> _getParam('lightbox_signup', 1);
		$this -> view -> viewer = $viewer = Engine_Api::_() -> user() -> getViewer();
		$this -> view -> viewer_id = $viewer -> getIdentity();
		
		$require_check = Engine_Api::_() -> getApi('settings', 'core') -> core_general_search;
		if (!$require_check)
		{
			if ($viewer -> getIdentity())
			{
				$this -> view -> search_check = true;
			}
			else
			{
				$this -> view -> search_check = false;
			}
		}
		else
			$this -> view -> search_check = true;

		// Notification icons
		$html_notifications = "";
		if ($viewer -> getIdentity())
		{
			$html_notifications = $this -> view -> partial(Advmenusystem_Api_Core::partialViewFullPath('_notification_icons.tpl'), array('notification_icons' => $notification_icons,'hover_color' => $hover_color, 'title_color'=>$title_color,'design_type'=>$design_type, 'viewer' => $viewer));
		}
		$this -> view -> html_notification = $html_notifications;

		// Profile

		$html_profile = "";
		if ($viewer -> getIdentity())
		{
			$html_profile = $this -> view -> partial(Advmenusystem_Api_Core::partialViewFullPath('_profile_menu.tpl'), array('viewer' => $viewer));
		}
		$this -> view -> html_json_profile = json_encode($html_profile);

		//Advanced Mini Menu
		$arr_objectParent = array();
		$arr_allsub_name_menu = array();
		$navigation = Engine_Api::_() -> getApi('menus', 'advmenusystem') -> getNavigation('core_mini');
		$arr_navigation = $navigation -> toArray();
		$arr_advmenu = array();
		$item_parent = $arr_navigation[0];
		$name_parent = $item_parent['class'];
		$arr_parents = array();
		foreach ($navigation as $item)
		{
			if ($item -> submenu)
			{
				if ($item_parent && !in_array($name_parent, $arr_parents) && !$item_parent['submenu'])
				{
					$arr_parents[] = $name_parent;
				}
				if ($item -> name != 'core_mini_messages')
				{
					$arr_advmenu[$name_parent]['items'][] = $item;
					$arr_allsub_name_menu[] = $item -> name;
				}
			}
			else
			{
				$name_parent = $item -> name;
				$arr_advmenu[$name_parent]['parent'] = $item;
			}
			$item_parent = $item -> toArray();
		}

		foreach ($arr_advmenu as $key => $values)
		{
			if (!empty($values['items']) && !empty($values['parent']))
			{
				$html = $this -> view -> partial(Advmenusystem_Api_Core::partialViewFullPath('_sub_mini_menu.tpl'), array(
					'key' => $key,
					'parent_item' => $values['parent'],
					'sub_menus' => $values['items']
				));
				$arr_objectParent[$key] = json_encode($html);
			}
		}
		$this -> view -> navigation = $navigation;
		$this -> view -> arr_sub_mini = $arr_allsub_name_menu;
		$this -> view -> arr_objectParent = $arr_objectParent;

		$front = Zend_Controller_Front::getInstance();
		$module = $front -> getRequest() -> getModuleName();
		$action = $front -> getRequest() -> getActionName();
		$controller = $front -> getRequest() -> getControllerName();
		$this -> view -> isPost = $front -> getRequest() -> isPost();

		if (($module == 'user' && $controller == 'auth' && $action == 'login') 
		|| ($module == 'core' && $controller == 'error' && $action == 'requireuser')
		|| $viewer -> getIdentity()
		)
		{
			$this -> view -> isUserLoginPage = true;
		}
		if (($module == 'user' && $controller == 'signup' && $action == 'index')
		|| ($module == 'social-connect' && $controller == 'signup' && $action == 'index')
		)
		{
			$this -> view -> isUserSignupPage = true;
		}
	}

}
