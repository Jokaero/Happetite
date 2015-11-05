<?php
class Advmenusystem_AdminMenusController extends Core_Controller_Action_Admin
{

	protected $_menus;
	protected $_enabledModuleNames;

	public function init()
	{
		// Get list of menus
		$menusTable = Engine_Api::_() -> getDbtable('menus', 'core');
		$menusSelect = $menusTable -> select();
		$this -> view -> menus = $this -> _menus = $menusTable -> fetchAll($menusSelect);
		$this -> _enabledModuleNames = Engine_Api::_() -> getDbtable('modules', 'core') -> getEnabledModuleNames();
		$this -> view -> navigation = $navigation = Engine_Api::_() -> getApi('menus', 'core') -> getNavigation('advmenusystem_admin_main', array(), 'advmenusystem_admin_main_menus');
	}

	public function indexAction()
	{
		if ($this -> getRequest() -> isPost())
		{
			$value = $this -> getRequest() -> getPost();
			if (isset($value['btnSitemap']))
			{
				$orderedMenus = Zend_Json::decode($value['list_ordered_menus']);
				$orderedArr = array();
				$orderedArr = $this -> getMenuArray($orderedMenus, $orderedArr, 1, 0);
				$this -> sitemap($orderedArr);
			}
			if (isset($value['submenus']))
			{
				$item_names = explode(',', $value['submenus']);
				$menuItemsTable = Engine_Api::_() -> getDbtable('menuItems', 'core');
				try
				{
					foreach ($item_names as $item_name)
					{
						$where_item = $menuItemsTable -> getAdapter() -> quoteInto('name = ?', $item_name);
						$menuItemsTable -> update(array('submenu' => $value['is_set_submenu']), $where_item);
					}
				}
				catch (Exception $e)
				{
					$this -> view -> result = 0;
				}
			}

			if (isset($value['list_ordered_menus']))
			{
				$orderedMenus = Zend_Json::decode($value['list_ordered_menus']);
				$previousMenus = Zend_Json::decode($value['list_original_menus']);

				$orderedArr = array();
				$previousArr = array();
				$orderedArr = $this -> getMenuArray($orderedMenus, $orderedArr, 1, 0);
				$previousArr = $this -> getMenuArray($previousMenus, $previousArr, 1, 0);
				$contentTbl = Engine_Api::_() -> getDbTable("contents", "advmenusystem");
				foreach ($previousArr as $menuId => $menuArr)
				{
					if ($menuArr['level'] == '2' || $menuArr['level'] == '3')
					{
						if ($orderedArr[$menuId]['level'] == '2' || $orderedArr[$menuId]['level'] == '3')
						{
							if ($orderedArr[$menuId]['level'] != $menuArr['level'])
							{
								$contentTbl -> updateContentParent($menuId, $menuArr['level'], $menuId, $orderedArr[$menuId]['level']);
							}
						}
					}
					else
					{
						continue;
					}
				}
				$this -> updateStatus($orderedMenus);
			}
			return $this->_helper->redirector->gotoRoute(array('module'=>'advmenusystem','controller'=>'menus', 'action'=>'index'), 'admin_default', true);
		}
		$this -> view -> name = $name = $this -> _getParam('name', 'core_main');
		// Get list of menus
		$menus = $this -> _menus;

		// Check if selected menu is in list
		$selectedMenu = $menus -> getRowMatching('name', $name);
		if (null === $selectedMenu)
		{
			throw new Core_Model_Exception('Invalid menu name');
		}
		$this -> view -> selectedMenu = $selectedMenu;
		$this -> view -> selected_menu_bar = Engine_Api::_() -> getApi('settings', 'core') -> getSetting('advmenusystem.style_menu_bar', 1);

		// Make select options
		$menuList = array();
		foreach ($menus as $menu)
		{
			if ($menu -> name == "core_main" || $menu -> name == "core_mini")
				$menuList[$menu -> name] = $this -> view -> translate($menu -> title);
		}
		$this -> view -> menuList = $menuList;

		// Get menu items
		$menuItemsTable = Engine_Api::_() -> getDbtable('menuItems', 'core');
		if ($name == 'core_main')
		{
			$menuItemsSelect = $menuItemsTable -> select() -> where('menu = ?', $name) -> where("(submenu = '') OR (submenu IS NULL) OR (submenu = '0')") -> order('order');
		}
		else
		{
			$menuItemsSelect = $menuItemsTable -> select() -> where('menu = ?', $name) -> order('order');
		}
		if (!empty($this -> _enabledModuleNames))
		{
			$menuItemsSelect -> where('module IN(?)', $this -> _enabledModuleNames);
		}
		$this -> view -> menuItems = $menuItems = $menuItemsTable -> fetchAll($menuItemsSelect);
		$submenus = array();
		$subMenuItemsTable = Engine_Api::_() -> getDbTable('submenus', 'advmenusystem');
		$submenuItems = $subMenuItemsTable -> fetchAll($subMenuItemsTable -> select() -> order("order ASC"));

		foreach ($submenuItems as $item)
		{
			$submenus[$item -> submenu_id] = $item;
		}
		$this -> view -> submenu = $submenus;
		if ($name == 'core_main')
		{
			$this -> renderScript('admin-menus/core-main.tpl');
		}
	}

	public function getMenuArray($menus, $result, $level, $parent_id)
	{
		foreach ($menus as $menu)
		{
			$result[$menu['id']] = array(
				'id' => $menu['id'],
				'level' => $level,
				'parent_id' => $parent_id,
			);
			$previousLevel = $level;

			if (isset($menu['children']) && count($menu['children']))
			{

				$level++;
				$result = $this -> getMenuArray($menu['children'], $result, $level, $menu['id']);
			}
			$level = $previousLevel;
		}
		return $result;
	}

	public function updateStatus($orderedMenus)
	{
		$coreMenuTbl = Engine_Api::_() -> getDbTable("menuItems", "core");
		$subMenuTbl = Engine_Api::_() -> getDbTable("submenus", "advmenusystem");
		$order = 1;
		foreach ($orderedMenus as $menu)
		{
			// INCASE: this menu is from core menu
			if (strpos($menu['id'], "core_") !== false)
			{
				$coreMenuId = $menuId = intval(str_replace("core_", "", $menu['id']));

				//UPDATE core_menuitems table
				$coremenu = $coreMenuTbl -> find($menuId) -> current();
				if ($coremenu)
				{
					$coremenu -> submenu = '';
					$coremenu -> order = $order;
					$coremenu -> save();
				}

				$submenu = $subMenuTbl -> getSubMenuByCoreMenuId($menuId);

				//UPDATE advmenusystem_submenus table
				if ($submenu)
				{
					//UPDATE contents BEFORE DELETE THIS SUBMENU
					$this -> updateContentLevel1($coremenu, $submenu);
					$submenu -> delete();
				}
			}
			// INCASE: this menu is from sub menu
			else
			{
				$coreMenuId = 0;
				$menuId = $menu['id'];
				$value = $subMenuTbl -> find($menuId) -> current();
				if ($value -> core_menu_id != '0')
				{
					$coremenu = $coreMenuTbl -> findRow($value -> core_menu_id);
					if ($coremenu)
					{
						$coremenu -> setFromArray(array(
							'menu' => 'core_main',
							'submenu' => '',
							'order' => $order
						));
					}
				}
				else
				{
					//ADD NEW RECORD to core menu table
					$coremenu = $coreMenuTbl -> createRow();
					$coremenu -> setFromArray(array(
						'name' => 'advmenusystem_custom_' . $value -> submenu_id,
						'module' => 'advmenusystem',
						'label' => $value -> label,
						'menu' => 'core_main',
						'submenu' => '',
						'order' => $order,
						'custom' => 1,
						'params' => (is_array($value -> params)) ? Zend_Json::encode($value -> params) : $value -> params,
					));
				}
				$coremenu -> save();
				if ($value)
				{
					//UPDATE contents BEFORE DELETE THIS SUBMENU
					$this -> updateContentLevel1($coremenu, $value);

					//UPDATE advmenusystem_submenus table
					$value -> delete();
				}
				$menuId = $coremenu -> id;
			}
			$order++;
			$level = 2;
			$this -> updateChildren($menu['children'], $menuId, $level);
		}
		return true;
	}

	public function updateChildren($children, $menuId, $level)
	{
		// PROCESS children
		$coreMenuTbl = Engine_Api::_() -> getDbTable("menuItems", "core");
		$subMenuTbl = Engine_Api::_() -> getDbTable("submenus", "advmenusystem");
		$order = 1;
		if (isset($children) && count($children))
		{
			foreach ($children as $child)
			{
				// INCASE: this child is from core menu
				if (strpos($child['id'], "core_") !== false)
				{
					$childId = intval(str_replace("core_", "", $child['id']));
					//UPDATE core_menuitems table
					$coremenu = $coreMenuTbl -> find($childId) -> current();
					if ($coremenu)
					{
						$coremenu -> submenu = 'advmenusystem_custom_' . $menuId;
						$coremenu -> save();
					}

					//UPDATE advmenusystem_submenus table
					$submenu = $subMenuTbl -> find($childId) -> current();
					if ($submenu)
					{
						$submenu -> parent_id = $menuId;
						$submenu -> core_menu_id = $childId;
						$submenu -> level = $level;
						$submenu -> order = $order;
					}
					else
					{
						$submenu = $subMenuTbl -> createRow();
						$submenu -> parent_id = $menuId;
						$submenu -> level = $level;
						$submenu -> name = $coremenu -> name;
						$submenu -> label = $coremenu -> label;
						$submenu -> params = Zend_Json::encode($coremenu -> params);
						$submenu -> order = $order;
						$submenu -> core_menu_id = $childId;
					}
					$submenu -> save();
					if ($level == 2)
					{
						$this -> updateContentLevel2($coremenu, $submenu);
					}
					if ($level == 3)
					{
						$this -> updateContentLevel3($coremenu, $submenu);
					}
				}
				// INCASE: this child is from sub menu
				else
				{
					$childId = $child['id'];
					$submenu = $subMenuTbl -> find($childId) -> current();
					$submenu -> parent_id = $menuId;
					$submenu -> level = $level;
					$submenu -> order = $order;
					$submenu -> save();
				}
				$order++;
				$childLevel = 3;
				//LEVEL 3 - using submenu_id
				$this -> updateChildren($child['children'], $submenu -> submenu_id, $childLevel);
			}
		}
	}

	public function createAction()
	{
		$this -> view -> name = $name = $this -> _getParam('name');
		// Get list of menus
		$menus = $this -> _menus;
		// Check if selected menu is in list
		$selectedMenu = $menus -> getRowMatching('name', $name);
		if (null === $selectedMenu)
		{
			throw new Core_Model_Exception('Invalid menu name');
		}
		$this -> view -> selectedMenu = $selectedMenu;
		// Get form
		if ($name == 'core_main')
		{
			$this -> view -> form = $form = new Advmenusystem_Form_Admin_Menu_ItemCoreMainCreate();
			$url = (_ENGINE_SSL ? 'https://' : 'http://') . $_SERVER['HTTP_HOST'] . $this -> view -> url(array('controller' => 'files'), 'admin_default', true);
			$form -> addNotice($this -> view -> translate('Please go to <a href = "%s" target = "_blank">File & Media Manager</a> to upload icon.', $url));
			$form -> addNotice("If you do not want to set color in color textbox, please kindly copy `transparent` and paste it into color textbox.");
		}
		else
		{
			$this -> view -> form = $form = new Advmenusystem_Form_Admin_Menu_ItemCreate();
		}

		if ($name != "core_mini" && $name != "core_main")
		{
			$form -> removeElement('submenu');
		}
		// Check stuff
		if (!$this -> getRequest() -> isPost())
		{
			return;
		}
		if (!$form -> isValid($this -> getRequest() -> getPost()))
		{
			return;
		}

		// Save
		$values = $form -> getValues();
		$label = $values['label'];
		unset($values['label']);

		$submenu = $values['submenu'];
		unset($values['submenu']);
		$flag_unique = '1';

		$menuItemsTable = Engine_Api::_() -> getDbtable('menuItems', 'core');

		$menuItem = $menuItemsTable -> createRow();
		$menuItem -> label = $label;
		$menuItem -> params = $values;
		$menuItem -> menu = $name;
		$menuItem -> module = 'core';
		// Need to do this to prevent it from being hidden
		$menuItem -> plugin = '';
		if (!empty($submenu))
			$menuItem -> submenu = $submenu;
		else
			$menuItem -> submenu = "";
		$menuItem -> flag_unique = $flag_unique;
		$menuItem -> custom = 1;
		$menuItem -> enabled = $values['enabled'];
		$menuItem -> save();

		$menuItem -> name = 'custom_' . sprintf('%d', $menuItem -> id);
		$menuItem -> save();

		$this -> view -> status = true;
		$this -> view -> form = null;
		return $this -> _forward('success', 'utility', 'core', array(
			'messages' => array(Zend_Registry::get('Zend_Translate') -> _('Menu Added.')),
			'format' => 'smoothbox',
			'smoothboxClose' => true,
			'parentRefresh' => true,
		));
	}

	public function editAction()
	{
		$this -> view -> name = $name = $this -> _getParam('name');
		$this -> view -> flag_unique = $flag_unique = $this -> _getParam('flag_unique');
		// Get menu item
		$menuItemsTable = Engine_Api::_() -> getDbtable('menuItems', 'core');
		$menuItemsSelect = $menuItemsTable -> select() -> where('name = ?', $name) -> where('flag_unique = ?', $flag_unique);
		if (!empty($this -> _enabledModuleNames))
		{
			$menuItemsSelect -> where('module IN(?)', $this -> _enabledModuleNames);
		}
		$this -> view -> menuItem = $menuItem = $menuItemsTable -> fetchRow($menuItemsSelect);
		if (!$menuItem)
		{
			throw new Core_Model_Exception('missing menu item');
		}
		// Get form
		$menu = $this -> _getParam('menu');
		if ($menu == 'main_menu')
		{
			$this -> view -> style = $menuItem['params']['style'];
			$this -> view -> form = $form = new Advmenusystem_Form_Admin_Menu_ItemCoreMainEdit();
			$url = (_ENGINE_SSL ? 'https://' : 'http://') . $_SERVER['HTTP_HOST'] . $this -> view -> url(array('controller' => 'files'), 'admin_default', true);
			$form -> addNotice($this -> view -> translate('Please go to <a href = "%s" target = "_blank">File & Media Manager</a> to upload icon.', $url));
			$form -> addNotice("If you do not want to set color in color textbox, please kindly copy `transparent` and paste it into color textbox.");
		}
		else
		{
			$this -> view -> form = $form = new Advmenusystem_Form_Admin_Menu_ItemEdit();
		}
		// Make safe
		$menuItemData = $menuItem -> toArray();

		if (isset($menuItemData['params']) && is_array($menuItemData['params']))
			$menuItemData = array_merge($menuItemData, $menuItemData['params']);

		if (!$menuItem -> custom)
		{
			$form -> removeElement('uri');
		}
		if ($menuItem -> menu == "core_mini")
		{
			$old_sub = $menuItem -> submenu;
			if ($old_sub == 1)
			{
				$form -> submenu -> setValue('1');
			}
			else
				$form -> submenu -> setValue('');
		}
		else

		if (!$this -> getRequest() -> isPost())
		{
			$form -> populate($menuItemData);
			return;
		}
		if (!$form -> isValid($this -> getRequest() -> getPost()))
		{
			return;
		}

		// Save
		$values = $form -> getValues();
		$menuItem -> label = $values['label'];
		if ($menuItem -> menu == "core_mini")
		{
			$menuItem -> submenu = $values['submenu'];
		}
		unset($values['label']);
		if ($menuItem -> custom)
		{
			$menuItem -> params = $values;
		}
		else
		{
			if ($menuItem -> params)
			{
				$menuItem -> params = array_merge($menuItem -> params, $values);
			}
			else
			{
				$menuItem -> params = $values;
			}
		}
		if (!empty($values['target']))
		{
			$menuItem -> params = array_merge($menuItem -> params, array('target' => $values['target']));
		}
		if (isset($values['enabled']))
		{
			$menuItem -> enabled = (bool)$values['enabled'];
		}
		// core-main menu item
		if (isset($values['style']))
		{
			$menuItem -> params = array_merge($menuItem -> params, array('style' => $values['style']));
		}
		$menuItem -> save();

		$this -> view -> status = true;
		$this -> view -> form = null;
		
		return $this -> _forward('success', 'utility', 'core', array(
			'messages' => array(Zend_Registry::get('Zend_Translate') -> _('Menu Edited.')),
			'format' => 'smoothbox',
			'smoothboxClose' => true,
			'parentRefresh' => true,
		));

	}

	public function deleteAction()
	{
		 ini_set('display_startup_errors', 1);
 ini_set('display_errors', 1);
 ini_set('error_reporting', -1);
		$this -> view -> name = $name = $this -> _getParam('name');
		$this -> view -> flag_unique = $flag_unique = $this -> _getParam('flag_unique');

		// Get menu item
		$menuItemsTable = Engine_Api::_() -> getDbtable('menuItems', 'core');
		$menuItemsSelect = $menuItemsTable -> select() -> where('name = ?', $name) -> where('flag_unique = ?', $flag_unique) -> order('order ASC');
		if (!empty($this -> _enabledModuleNames))
		{
			$menuItemsSelect -> where('module IN(?)', $this -> _enabledModuleNames);
		}
		$this -> view -> menuItem = $menuItem = $menuItemsTable -> fetchRow($menuItemsSelect);

		if (!$menuItem || !$menuItem -> custom)
		{
			throw new Core_Model_Exception('missing menu item');
		}

		$tableContentTable = Engine_Api::_() -> getItemTable('advmenusystem_content');
		$hasContent = $tableContentTable -> checkHasContent($menuItem -> id, 1);
		// Get form
		$this -> view -> form = $form = new Advmenusystem_Form_Admin_Menu_ItemDelete( array('hasContent' => $hasContent));
		if ($hasContent)
		{
			$enabledModuleNames = Engine_Api::_() -> getDbtable('modules', 'core') -> getEnabledModuleNames();
			$coremenuItemsTable = Engine_Api::_() -> getDbtable('menuItems', 'core');
			$coremenuItemsSelect = $coremenuItemsTable -> select() -> where('menu = ?', 'core_main') -> where('name <> ?', $name) -> where("submenu = '' OR submenu IS NULL") -> where('module IN(?)', $enabledModuleNames) -> order('order');
			$coreMenuItems = $coremenuItemsTable -> fetchAll($coremenuItemsSelect);
			$parram = array();
			foreach ($coreMenuItems as $coreMenuItem)
			{
				$parram['1_' . $coreMenuItem -> id] = $coreMenuItem -> label;

			}
			$submenuItemsTable = Engine_Api::_() -> getDbTable('submenus', 'advmenusystem');
			$submenuItemsSelect = $submenuItemsTable -> select() -> where('level = 2') -> where('parent_id <> ?', $menuItem -> id) -> order('order');
			$subMenusItems = $submenuItemsTable -> fetchAll($submenuItemsSelect);
			foreach ($subMenusItems as $subMenusItem)
			{
				$parram['2_' . $subMenusItem -> submenu_id] = "---- " . $subMenusItem -> label;

			}
			$form -> move_content_to -> addMultiOptions($parram);
		}
		// Check stuff
		if (!$this -> getRequest() -> isPost())
		{
			return;
		}
		if (!$form -> isValid($this -> getRequest() -> getPost()))
		{
			return;
		}
		$id = $menuItem -> id;
		$menuItem -> delete();

		//check if menu has content
		$tableContentTable = Engine_Api::_() -> getItemTable('advmenusystem_content');
		if ($tableContentTable -> checkHasContent($id, 1))
		{
			if ($this -> _getParam('move_content_to') == 'none')
			{
				$params = array(
					'parent_id' => $id,
					'level' => 1,
				);
				$select_contents = $tableContentTable -> getContentsSelect($params);
				$contents = $tableContentTable -> fetchAll($select_contents);
				foreach ($contents as $item)
				{
					$item -> delete();
				}
			}
			else
			{
				//update content of delete selected item
				$parent_id_new = substr($this -> _getParam('move_content_to'), 2);
				$level_new = substr($this -> _getParam('move_content_to'), 0, 1);
				$tableContentTable -> updateContentParent($id, 1, $parent_id_new, $level_new);

				//update submenu 's selected item content
				$subMenuItemsTable = Engine_Api::_() -> getDbtable('submenus', 'advmenusystem');
				$subMenuItemsSelect = $subMenuItemsTable -> select() -> where('parent_id = ?', $id) -> where('level = ?', 2);
				$subMenuItems = $subMenuItemsTable -> fetchAll($subMenuItemsSelect);
				foreach ($subMenuItems as $item_submenu)
				{
					$params = array(
						'parent_id' => $item_submenu['submenu_id'],
						'level' => 2,
					);
					$select_contents = $tableContentTable -> getContentsSelect($params);
					$contents = $tableContentTable -> fetchAll($select_contents);
					foreach ($contents as $item_content)
					{
						die('haha');
						$item_content -> parent_id = $parent_id_new;
						$item_content -> level = $level_new;
						$item_content -> save();
					}
					
					$subsubMenuItemsSelect = $subMenuItemsTable -> select() -> where('parent_id = ?', $item_submenu['submenu_id']) ->  where('level = ?', 3);
					$subsubMenuItems = $subMenuItemsTable -> fetchAll($subsubMenuItemsSelect);
					foreach ($subsubMenuItems as $item_subsubmenu)
					{
						
						$params = array(
							'parent_id' => $item_subsubmenu['submenu_id'],
							'level' => 3,
						);
						$select_content1s = $tableContentTable -> getContentsSelect($params);
						$content1s = $tableContentTable -> fetchAll($select_content1s);
						foreach ($content1s as $item_content1)
						{
							
							$item_content1 -> parent_id = $parent_id_new;
							$item_content1 -> level = $level_new;
							$item_content1 -> save();
						}
					}
				}
			}
		}

		//delete submenu
		$subMenuItemsTable = Engine_Api::_() -> getDbtable('submenus', 'advmenusystem');
		$subMenuItemsSelect = $subMenuItemsTable -> select() -> where('parent_id = ?', $id) -> where('level = ?', 2);
		$subMenuItems = $subMenuItemsTable -> fetchAll($subMenuItemsSelect);
		foreach ($subMenuItems as $item)
		{
			$tableContentTable -> deleteContent($item -> submenu_id, $item -> level);
			$subsubMenuItemsSelect = $subMenuItemsTable -> select() -> where('parent_id = ?', $item -> submenu_id) -> where('level = ?', 3);
			$subsubMenuItems = $subMenuItemsTable -> fetchAll($subsubMenuItemsSelect);
			foreach ($subsubMenuItems as $subitem)
			{
				$tableContentTable -> deleteContent($subitem -> submenu_id, $subitem -> level);
				$subitem -> delete();
			}
			$item -> delete();
		}

		$this -> view -> form = null;
		$this -> view -> status = true;

		return $this -> _forward('success', 'utility', 'core', array(
			'messages' => array(Zend_Registry::get('Zend_Translate') -> _('Menu Deleted.')),
			'format' => 'smoothbox',
			'smoothboxClose' => true,
			'parentRefresh' => true,
		));
	}

	public function orderAction()
	{
		if (!$this -> getRequest() -> isPost())
		{
			return;
		}

		$table = $this -> _helper -> api() -> getDbtable('menuItems', 'core');
		$menuitems = $table -> fetchAll($table -> select() -> where('menu = ?', $this -> getRequest() -> getParam('menu')));
		foreach ($menuitems as $menuitem)
		{
			$menuitem -> order = $this -> getRequest() -> getParam('admin_menus_item_' . $menuitem -> name);
			$menuitem -> save();
		}
		return;
	}

	public function createSubAction()
	{
		$this -> view -> name = $name = $this -> _getParam('name');

		$parent_id = $this -> _getParam('parent_id');
		// Get list of menus
		$menus = $this -> _menus;

		// Check if selected menu is in list
		$selectedMenu = $menus -> getRowMatching('name', $name);

		if (null === $selectedMenu)
		{
			throw new Core_Model_Exception('Invalid menu name');
		}
		$this -> view -> selectedMenu = $selectedMenu;
		// Get form
		$this -> view -> form = $form = new Advmenusystem_Form_Admin_Menu_ItemSubCreate();
		$url = (_ENGINE_SSL ? 'https://' : 'http://') . $_SERVER['HTTP_HOST'] . $this -> view -> url(array('controller' => 'files'), 'admin_default', true);
		$form -> addNotice($this -> view -> translate('Please go to <a href = "%s" target = "_blank">File & Media Manager</a> to upload icon.', $url));
		$form -> addNotice("If you do not want to set color in color textbox, please kindly copy `transparent` and paste it into color textbox.");
		$array_form = array('parent_id' => $parent_id);
		$form -> populate($array_form);
		// Check stuff
		if (!$this -> getRequest() -> isPost())
		{
			return;
		}
		if (!$form -> isValid($this -> getRequest() -> getPost()))
		{
			return;
		}

		// Save
		$values = $form -> getValues();
		$label = $values['label'];
		unset($values['label']);
		$menuItemsTable = Engine_Api::_() -> getDbtable('submenus', 'advmenusystem');

		$menuItem = $menuItemsTable -> createRow();
		$menuItem -> parent_id = $values['parent_id'];
		$menuItem -> label = $label;
		$menuItem -> level = $this -> _getParam('level') + 1;
		$menuItem -> params = $values;
		// Need to do this to prevent it from being hidden
		$menuItem -> enabled = $values['enabled'];
		$menuItem -> save();

		$this -> view -> status = true;
		$this -> view -> form = null;
		return $this -> _forward('success', 'utility', 'core', array(
			'messages' => array(Zend_Registry::get('Zend_Translate') -> _('Menu Added.')),
			'format' => 'smoothbox',
			'smoothboxClose' => true,
			'parentRefresh' => true,
		));
	}

	/**
	 * 2->1
	 * update contents when user set 2nd menu to 1st menu
	 * @param engine4_core_menuitem $coremenu
	 * @param engine4_advmenusytem_submenu $submenu
	 */
	public function updateContentLevel1($coremenu, $submenu)
	{
		$contentTbl = Engine_Api::_() -> getDbTable("contents", "advmenusystem");
		if ($submenu -> core_menu_id)
		{
			$contentTbl -> updateContentParent($submenu -> submenu_id, $submenu->level, $submenu -> core_menu_id, 1);
		}
		else
		{
			$contentTbl -> updateContentParent($submenu -> submenu_id, $submenu->level, $coremenu -> id, 1);
		}
	}

	public function updateContentLevel2($coremenu, $submenu, $newLevel = 2)
	{
		$contentTbl = Engine_Api::_() -> getDbTable("contents", "advmenusystem");
		if ($submenu -> core_menu_id)
		{
			$contentTbl -> updateContentParent($submenu -> core_menu_id, 1, $submenu -> submenu_id, $newLevel);
		}
		else
		{
			$contentTbl -> updateContentParent($coremenu -> id, 1, $submenu -> submenu_id, $newLevel);
		}
	}

	public function updateContentLevel3($coremenu, $submenu)
	{
		$this->updateContentLevel2($coremenu, $submenu, 3);
	}
	
	public function sitemap($orderedMenus)
	{
		header('Content-type: text/xml');
		header('Content-Disposition: attachment; filename="sitemap.xml"');
		$xmlOutput = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
		<urlset
      		xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\"
      		xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"
      		xsi:schemaLocation=\"http://www.sitemaps.org/schemas/sitemap/0.9
            	http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd\">";

		foreach ($orderedMenus as $menu)
		{
			$menuObject = Engine_Api::_() -> advmenusystem() -> getMenu($menu);
			if (!$menuObject)
			{
				continue;
			}
			$menuParams = Engine_Api::_() -> advmenusystem() -> parseParams($menuObject -> params);
			$url = $menuParams['url'];
			$freq = "daily";
			$priority = ($menu['level'] == '1') ? "0.8" : "0.5";
			$xmlOutput .= "<url>\n  <loc>{$url}</loc>\n";
			$xmlOutput .= "  <changefreq>{$freq}</changefreq>\n";
			$xmlOutput .= "  <priority>{$priority}</priority>\n</url>\n";
		}
		
		$xmlOutput .= "</urlset>\n";
		echo $xmlOutput;
		exit ;
	}

	public function editSubAction()
	{
		$this -> view -> name = $name = $this -> _getParam('name');

		// Get list of menus
		$menus = $this -> _menus;

		// Check if selected menu is in list
		$selectedMenu = $menus -> getRowMatching('name', $name);

		if (null === $selectedMenu)
		{
			throw new Core_Model_Exception('Invalid menu name');
		}
		$this -> view -> selectedMenu = $selectedMenu;

		// Get form
		$this -> view -> form = $form = new Advmenusystem_Form_Admin_Menu_ItemSubEdit();
		$url = (_ENGINE_SSL ? 'https://' : 'http://') . $_SERVER['HTTP_HOST'] . $this -> view -> url(array('controller' => 'files'), 'admin_default', true);
		$form -> addNotice($this -> view -> translate('Please go to <a href = "%s" target = "_blank">File & Media Manager</a> to upload icon.', $url));
		$form -> addNotice("If you do not want to set color in color textbox, please kindly copy `transparent` and paste it into color textbox.");
		$submenu_id = $this -> _getParam('submenu_id');
		$submenu = Engine_Api::_() -> getItem('advmenusystem_submenu', $submenu_id);
		$menuItemData = $submenu -> toArray();
		if (isset($menuItemData['params']) && is_array($menuItemData['params']))
			$menuItemData = array_merge($menuItemData, $menuItemData['params']);
		$form -> populate($menuItemData);
		if ($submenu -> core_menu_id)
		{
			$form -> removeElement('uri');
		}
		// Check stuff
		if (!$this -> getRequest() -> isPost())
		{
			return;
		}
		if (!$form -> isValid($this -> getRequest() -> getPost()))
		{
			return;
		}

		// Save
		$values = $form -> getValues();
		$label = $values['label'];
		unset($values['label']);

		$submenu -> label = $label;
		if ($submenu -> params)
		{
			unset($values['parent_id']);
			$submenu -> params = array_merge($submenu -> params, $values);
		}
		else
		{
			unset($values['parent_id']);
			$menuItem -> params = $values;
		}
		// Need to do this to prevent it from being hidden
		$submenu -> enabled = $values['enabled'];
		$submenu -> save();

		$this -> view -> status = true;
		$this -> view -> form = null;
		return $this -> _forward('success', 'utility', 'core', array(
			'messages' => array(Zend_Registry::get('Zend_Translate') -> _('Menu Edited.')),
			'format' => 'smoothbox',
			'smoothboxClose' => true,
			'parentRefresh' => true,
		));
	}

	public function deleteSubAction()
	{
		$submenu_id = $this -> _getParam('submenu_id');
		$submenu = Engine_Api::_() -> getItem('advmenusystem_submenu', $submenu_id);
		$tableContentTable = Engine_Api::_() -> getItemTable('advmenusystem_content');
		$hasContent = $tableContentTable -> checkHasContent($submenu_id, $submenu -> level);
		// Get form
		$this -> view -> form = $form = new Core_Form_Admin_Menu_ItemDelete( array('hasContent' => $hasContent));
		if ($hasContent)
		{
			$enabledModuleNames = Engine_Api::_() -> getDbtable('modules', 'core') -> getEnabledModuleNames();
			$coremenuItemsTable = Engine_Api::_() -> getDbtable('menuItems', 'core');
			$coremenuItemsSelect = $coremenuItemsTable -> select() -> where('menu = ?', 'core_main') -> where("submenu = '' OR submenu IS NULL") -> where('module IN(?)', $enabledModuleNames) -> order('order');
			$coreMenuItems = $coremenuItemsTable -> fetchAll($coremenuItemsSelect);
			$parram = array();
			foreach ($coreMenuItems as $coreMenuItem)
			{
				$parram['1_' . $coreMenuItem -> id] = $coreMenuItem -> label;

			}
			$submenuItemsTable = Engine_Api::_() -> getDbTable('submenus', 'advmenusystem');
			$submenuItemsSelect = $submenuItemsTable -> select() -> where('submenu_id <> ?', $submenu_id) -> where('level = 2') -> order('order');
			$subMenusItems = $submenuItemsTable -> fetchAll($submenuItemsSelect);
			foreach ($subMenusItems as $subMenusItem)
			{
				$parram['2_' . $subMenusItem -> submenu_id] = "---- " . $subMenusItem -> label;

			}
			$form -> move_content_to -> addMultiOptions($parram);
		}
		// Check stuff
		if (!$this -> getRequest() -> isPost())
		{
			return;
		}
		if (!$form -> isValid($this -> getRequest() -> getPost()))
		{
			return;
		}
		$submenu = Engine_Api::_() -> getItem('advmenusystem_submenu', $submenu_id);
		$submenu_id = $submenu -> submenu_id;
		$level = $submenu -> level;
		$submenu -> delete();

		//check if menu has content
		if ($hasContent)
		{
			if ($this -> _getParam('move_content_to') == 'none')
			{

				$params = array(
					'parent_id' => $submenu_id,
					'level' => $level,
				);
				$select_contents = $tableContentTable -> getContentsSelect($params);
				$contents = $tableContentTable -> fetchAll($select_contents);
				foreach ($contents as $item)
				{
					$item -> delete();
				}
			}
			else
			{
				$parent_id_new = substr($this -> _getParam('move_content_to'), 2);
				$level_new = substr($this -> _getParam('move_content_to'), 0, 1);
				$tableContentTable -> updateContentParent($submenu_id, $level, $parent_id_new, $level_new);

				//update submenu 's selected item content
				$subMenuItemsTable = Engine_Api::_() -> getDbtable('submenus', 'advmenusystem');
				$subMenuItemsSelect = $subMenuItemsTable -> select() -> where('parent_id = ?', $submenu_id) -> where('level = ?', 3);
				$subMenuItems = $subMenuItemsTable -> fetchAll($subMenuItemsSelect);
				foreach ($subMenuItems as $item_submenu)
				{
					$params = array(
						'parent_id' => $item_submenu['submenu_id'],
						'level' => 3,
					);
					$select_contents = $tableContentTable -> getContentsSelect($params);
					$contents = $tableContentTable -> fetchAll($select_contents);
					foreach ($contents as $item_content)
					{
						$item_content -> parent_id = $parent_id_new;
						$item_content -> level = $level_new;
						$item_content -> save();
					}
				}
			}
		}

		//delete sub menu (level 3)
		if ($submenu -> level == 2)
		{
			$subMenuItemsTable = Engine_Api::_() -> getDbtable('submenus', 'advmenusystem');
			$subMenuItemsSelect = $subMenuItemsTable -> select() -> where('parent_id = ?', $submenu_id) -> order('order ASC');
			$subMenuItems = $subMenuItemsTable -> fetchAll($subMenuItemsSelect);
			foreach ($subMenuItems as $item)
			{
				$tableContentTable -> deleteContent($item -> submenu_id, $item -> level);
				$item -> delete();
			}
		}

		$this -> view -> form = null;
		$this -> view -> status = true;

		return $this -> _forward('success', 'utility', 'core', array(
			'messages' => array(Zend_Registry::get('Zend_Translate') -> _('Menu Deleted.')),
			'format' => 'smoothbox',
			'smoothboxClose' => true,
			'parentRefresh' => true,
		));
	}

}
