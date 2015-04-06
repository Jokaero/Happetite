<?php

class Advmenusystem_Api_Core
{

	public function checklevel1HasModuleInSub($id)
	{
		$submenusItemsTable = Engine_Api::_() -> getDbtable('submenus', 'advmenusystem');
		$select = $submenusItemsTable -> select() -> where('parent_id = ?', $id) -> where('level = 2');
		foreach ($submenusItemsTable->fetchAll($select) as $itemlevel2)
		{
			if (isset($itemlevel2 -> params['route']))
				return true;
			$select1 = $submenusItemsTable -> select() -> where('parent_id = ?', $itemlevel2 -> getIdentity()) -> where('level = 3');
			foreach ($submenusItemsTable->fetchAll($select1) as $itemlevel3)
			{
				if (isset($itemlevel3 -> params['route']))
					return true;
			}
		}
		return false;
	}

	public static function partialViewFullPath($partialTemplateFile)
	{
		$ds = DIRECTORY_SEPARATOR;
		return "application{$ds}modules{$ds}Advmenusystem{$ds}views{$ds}scripts{$ds}{$partialTemplateFile}";
	}

	public function checkYouNetPlugin($name)
	{
		$table = Engine_Api::_() -> getDbTable('modules', 'core');
		$select = $table -> select() -> where('name = ?', $name) -> where('enabled  = 1');
		$result = $table -> fetchRow($select);
		if ($result)
		{
			return true;
		}
		else
		{
			return false;
		}
	}

	public function getMenu($menuInfo)
	{
		$coreMenuTbl = Engine_Api::_() -> getDbTable("menuitems", "core");
		$subMenuTbl = Engine_Api::_() -> getDbTable("submenus", "advmenusystem");
		if ($menuInfo['level'] == 1)
		{
			$menuId = intval(str_replace("core_", "", $menuInfo['id']));
			return $coreMenuTbl -> findRow($menuId);
		}
		else
		{
			return $subMenuTbl -> findRow(intval($menuInfo['id']));
		}
	}

	public function parseParams($params)
	{
		if (!$params)
		{
			return array();
		}
		if (is_string($params))
		{
			try
			{
				$params = Zend_Json::decode($params);
			}
			catch (Exception $e)
			{
				return array();
			}
		}

		//INIT URL
		$view = Zend_Registry::get("Zend_View");
		if (isset($params['route']))
		{
			$routeParams = array();
			if (isset($params['module']))
				$routeParams['module'] = $params['module'];
			if (isset($params['action']))
				$routeParams['action'] = $params['action'];

			$params['url'] = $view -> url($routeParams, $params['route']);
		}
		elseif (isset($params['uri']))
		{
			$params['url'] = $params['uri'];
		}
		else
		{
			$params['url'] = $view -> baseUrl();
		}
		return $params;
	}

}
