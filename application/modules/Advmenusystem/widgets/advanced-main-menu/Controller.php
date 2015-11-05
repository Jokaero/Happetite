<?php
class Advmenusystem_Widget_AdvancedMainMenuController extends Engine_Content_Widget_Abstract
{
	public function indexAction()
	{
		$this->view->viewer = $viewer = Engine_Api::_()->user()->getViewer();	
		$show_non_logged_user = $this->_getParam('show_non_logged_user', 1);
		if(!$show_non_logged_user && !$viewer->getIdentity())
		{
			return;
		}
		$this->view->fix_menu_position = $fix_menu_position = $this->_getParam('fix_menu_position', 1);
		$this->view->arrow_sign = $arrow_sign = $this->_getParam('arrow_sign', 1);
		$this->view->title_truncation = $title_truncation = $this->_getParam('title_truncation', 20);
		$this->view->show_more_link = $show_more_link = $this->_getParam('show_more_link', 1);
		$this->view->number_tabs = $number_tabs = $this->_getParam('number_tabs', 7);
		$this->view->style_menu = $styleMenu = $this->_getParam('style_menu', 'flat');
		$this->view->cssMenuStyle = Engine_Api::_() -> getApi('settings', 'core') -> getSetting($styleMenu .'.avdmenusystem.customcss', "");
		// GET LEVEL 1 MENUS
		$navigation = Engine_Api::_() -> getApi('menus', 'advmenusystem') -> getNavigation('core_main', array(), null, 'main');
    	$this-> view -> viewer = $viewer = Engine_Api::_()->user()->getViewer();
    	$require_check = Engine_Api::_()->getApi('settings', 'core')->getSetting('core.general.browse', 1);
    	if(!$require_check && !$viewer->getIdentity())
    	{
      		$navigation->removePage($navigation->findOneBy('route','user_general'));
		}
		$navigation = Engine_Api::_() -> getApi('menus', 'advmenusystem') -> getNavigation('core_main', array(), null, 'main');

		// GET LEVEL 2 MENUS
		$subMenuTable = Engine_Api::_()->getDbTable("submenus", "advmenusystem");
		$subMenuTableName = $subMenuTable->info("name");
		$colums = array(
			'submenu_id',
			'parent_id',
			'level',
			'name',
			'label',
			'params',
			'enabled',
			'order',
			'core_menu_id',
			'children' => new Zend_Db_Expr("0")
		);
		
		// GET all main menus enabled
		$menus = Engine_Api::_() -> getApi('menus', 'advmenusystem') -> getNavigation('core_main', array(), null);
		$str_menus = "";
		$arr_menus = array();
		foreach($menus as $menu)
		{
			$arr_menus[] = $menu -> id;
		}
		if($arr_menus)
		{
			$str_menus = $arr_menus;
		}
		$selectLevel2 = $subMenuTable -> select() 
										-> from($subMenuTableName, $colums) 
										-> where("`level` = ?", 2) 
										-> where("enabled = ?", 1)
										-> where("core_menu_id = 0 OR core_menu_id IN (?)", $str_menus)
										-> order("order ASC");
		$menuLevel2 = $subMenuTable->fetchAll($selectLevel2);

		// GET LEVEL 3 MENUS
		$selectLevel3 = $subMenuTable -> select() 
									-> from($subMenuTableName, $colums) 
									-> where("`level` = ?", 3)
									-> where("enabled = ?", 1)
									-> where("core_menu_id = 0 OR core_menu_id IN (?)", $str_menus)
									-> order("order ASC");
		$menuLevel3 = $subMenuTable->fetchAll($selectLevel3);
		
		// COUNTING CHILDREN - LEVEL 1
		$level1 = array();
		
		foreach ($navigation as $menu1)
		{
			$children = array();
			foreach ($menuLevel2 as $menu2)
			{
				if ($menu2->level == '2' && $menu2->parent_id == $menu1->id)
				{
					$children[] = $menu2->submenu_id;
				}
			}
			$menu1 -> children = $children;
			$level1[] = $menu1;
		}
		
		// COUNTING CHILDREN - LEVEL 2
		$level2 = array();
		foreach ($menuLevel2 as $menu2)
		{
			$children = array();
			foreach ($menuLevel3 as $menu3)
			{
				if ($menu3->level == '3' && $menu3->parent_id == $menu2->submenu_id)
				{
					$children[] = $menu3->submenu_id;
				}
			}
			$menu2 -> children = $children;
			$level2[] = $menu2;
		}
		
		$level3 = array();
		foreach ($menuLevel3 as $menu3)
		{
			$level3[] = $menu3;
		}
		$this->view->menuLevel1 = $level1;
		$this->view->menuLevel2 = $level2;
		$this->view->menuLevel3 = $level3;
	}
}
