<?php
class Advmenusystem_Model_DbTable_Contents extends Engine_Db_Table
{
  protected $_rowClass = 'Advmenusystem_Model_Content';
  protected $_name = 'advmenusystem_contents';
  
  public function checkHasContentLevel1($parent_id, $level)
  {
  		 $select = $this->select()
	 				->where("parent_id = ?", $parent_id)
					->where("level = ?", $level);
		 $contents = $this->fetchAll($select);
		 foreach($contents as $item)
		 {
		 	return true;
		 }
  }
  
  public function deleteContent($parent_id, $level)
  {
  	  $submenusItemsTable = Engine_Api::_() -> getDbtable('submenus', 'advmenusystem');
  	  $select = $this->select()
	 				->where("parent_id = ?", $parent_id)
					->where("level = ?", $level);
	   if($contents = $this->fetchAll($select))
	   {
	   		$submenus = $submenusItemsTable->getSubMenuByCoreMenuId($parent_id);
			foreach ($contents as $item)
			{
				$item -> delete();	
			}
	   }				
  }
  
  public function checkHasContent($parent_id, $level)
  {
  		 $select = $this->select()
	 				->where("parent_id = ?", $parent_id)
					->where("level = ?", $level);
		 $contents = $this->fetchAll($select);
		 foreach($contents as $item)
		 {
		 	return true;
		 }
		 if($level == 1)
		 {
		 //check level 2
			$submenusItemsTable = Engine_Api::_() -> getDbtable('submenus', 'advmenusystem');	
			$submenusSelect = $submenusItemsTable->select()
												  ->where('parent_id = ?', $parent_id)
												  ->where('level = ?', 2);
			$submenus = $submenusItemsTable->fetchAll($submenusSelect);										  
			foreach ($submenus as $item)
			{
				$select_content_sub = $this->select()
	 				->where("parent_id = ?", $item['submenu_id'])
					->where("level = ?", $item->level);
				 $content_subs = $this->fetchAll($select_content_sub);
				 foreach($content_subs as $item)
				 {
				 	return true;
				 }	
				 //check level 3
				$subsubmenusSelect = $submenusItemsTable->select()
												  ->where('parent_id = ?', $item['submenu_id'])
												  ->where('level = ?', 3);
				$subsubmenus = $submenusItemsTable->fetchAll($subsubmenusSelect);								  
				foreach ($subsubmenus as $item_sub)
				{
					$select_content_sub_sub = $this->select()
		 				->where("parent_id = ?", $item_sub['submenu_id'])
						->where("level = ?", 3);
					
					 $content_sub_subs = $this->fetchAll($select_content_sub_sub);
					 foreach($content_sub_subs as $item)
				 	 {
					 	return true;
					 }	
				}
			}
		}

		if($level == 2)
		{
			
			 //check level 2
			$submenusItemsTable = Engine_Api::_() -> getDbtable('submenus', 'advmenusystem');	
			$submenusSelect = $submenusItemsTable->select()
												  ->where('parent_id = ?', $parent_id)
												  ->where('level = ?', 3);
			$submenus = $submenusItemsTable->fetchAll($submenusSelect);										  
			foreach ($submenus as $item)
			{
				$select_content_sub = $this->select()
	 				->where("parent_id = ?", $item['submenu_id'])
					->where("level = ?", $item->level);
				 $content_subs = $this->fetchAll($select_content_sub);
				 foreach($content_subs as $item)
				 {
				 	return true;
				 }	
			}
		}
	 return false;	
  }
  public function updateContentParent($parent_id, $level, $parent_id_new, $level_new)
  {
  	 $select = $this->select()
	 				->where("parent_id = ?", $parent_id)
					->where("level = ?", $level);
	
	 if($contents = $this->fetchAll($select))
	 {	
	 	foreach($contents as $item)
		{
			$item->parent_id = $parent_id_new;
			$item->level = $level_new;
			$item->save();
		}
	 }
	 return true;
  }
  
  public function getContentsSelect($params = array())
  {
    $select = $this->select();
	
	if(!empty($params['parent_id']))
	{
		$select -> where('parent_id = ? ', $params['parent_id']);
	}
	if(!empty($params['level']))
	{
		$select -> where('level = ? ', $params['level']);
	}
	
	if(!empty($params['filter']) && $params['filter'] != 'all')
	{
		$parent_id = substr($params['filter'], 2);
	 	$level  = substr($params['filter'], 0, 1);
		
		if($level == 1){
	    $tableContentTable = Engine_Api::_()->getItemTable('advmenusystem_content');
	    $tableContentName = $tableContentTable->info('name');
		
		$menuItemsTable = Engine_Api::_() -> getDbtable('menuItems', 'core');
	    $menuItemsName = $menuItemsTable->info('name');
		
		$select = $tableContentTable->select()->from(array('content' => $tableContentName ));
		$select -> setIntegrityCheck(false)
	                -> join("$menuItemsName as menuitem","content.parent_id = menuitem.id",'');
		$select -> where("menuitem.id = ?", $parent_id);
	  	}
		elseif ($level == 2) {
			$tableContentTable = Engine_Api::_()->getItemTable('advmenusystem_content');
		    $tableContentName = $tableContentTable->info('name');
			
			$submenuItemsTable = Engine_Api::_() -> getDbtable('submenus', 'advmenusystem');
		    $submenuItemsName = $submenuItemsTable->info('name');
			
			$select = $tableContentTable->select()->from(array('content' => $tableContentName ));
			$select -> setIntegrityCheck(false)
		                -> join("$submenuItemsName as submenuitem","content.parent_id = submenuitem.submenu_id",'');
			$select -> where("submenuitem.submenu_id = ?", $parent_id);
		}
	}
	return $select;
	
  }
  
  public function getContentsPaginator($params = array())
  {
    $paginator = Zend_Paginator::factory($this->getContentsSelect($params));
    if( !empty($params['page']) )
    {
      $paginator->setCurrentPageNumber($params['page']);
    }

    return $paginator;
  }
  
  public function getContentByMenu($menu, $level, $limit = 0)
  {
  	if (is_object($menu))
  	{
	  	if ($level == 1)
	  	{
	  		$menuId = $menu->id;
	  	}
	  	else
	  	{
	  		$menuId = $menu->submenu_id;
	  	}
  	}
  	else if (is_int($menu) || is_string($menu))
  	{
  		$menuId = $menu;
  	}
  	
  	$select = $this->select()
				  	->where("parent_id = ?", $menuId)
				  	->where("level = ?", $level)
				  	->where("enabled = ?","1")
					->order("order");
  	if ($limit)
  	{
  		$select -> limit($limit);
  	}
  	return $this->fetchAll($select);
  }
}