<?php
class Advmenusystem_Model_Submenu extends Core_Model_Item_Abstract
{
	
	public function checklevel2HasModuleInSub()
	{
		$submenusItemsTable = Engine_Api::_() -> getDbtable('submenus', 'advmenusystem');
		$select = $submenusItemsTable -> select()
									  -> where('parent_id = ?', $this->getIdentity())
									  -> where('level = 3');
		foreach($submenusItemsTable->fetchAll($select) as $item)
		{
			if(isset($item->params['route']))
				return true;
		}
		return false;
	}
	
	public function getCoreMenu()
	{
		if ($this->core_menu_id == '0')
		{
			return null;
		}
		$coremenuTbl = Engine_Api::_()->getDbTable("menuitems", "core");
		$select = $coremenuTbl->select()->where("id = ?", $this->core_menu_id);
		return $coremenuTbl->fetchRow($select);
	}
	public function getHref()
    {
    	$params = $this -> params;
		if(!$this -> core_menu_id)
		{
			if(isset($params['uri']))
				return $params['uri'];
			else
				return "#";
		}
		else 
		{
			
			if(isset($params['route']))
			{
				$route = $params['route'];
				if(isset($params['uri']))
					unset($params['uri']);
			}	
			if(isset($params['uri']))
				return $params['uri'];
			unset($params['route']);
			unset($params['label']);
			unset($params['style']);
			unset($params['icon']);
			unset($params['hover_active_icon']);
			unset($params['main_menu_background_color']);
			unset($params['main_menu_text_color']);
			unset($params['main_menu_hover_color']);
			unset($params['separator']);
			unset($params['background_multicolumn_color']);
			unset($params['background_multicolumn_image']);
			unset($params['login']);
			unset($params['logout']);
			unset($params['target']);
			unset($params['enabled']);
			return Zend_Controller_Front::getInstance() -> getRouter() -> assemble($params, $route, true);
		}
        
    }
	public function canView()
	{
		$viewer = Engine_Api::_() -> user() -> getViewer();
		$canView = true;
		if(isset($this -> params['login']) && $this -> params['login'] && !$viewer->getIdentity())
		{
			$canView = false;
		}
		
		if(isset($this -> params['logout']) && $this -> params['logout'] && $viewer->getIdentity())
		{
			$canView = false;
		}
		
		if(isset($this -> params['logout']) && $this -> params['logout'] && isset($this -> params['login']) && $this -> params['login']) 
		{
			$canView = true;
		}
		return $canView;
	}
}