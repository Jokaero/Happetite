<?php
class Advmenusystem_Model_DbTable_Submenus extends Engine_Db_Table
{
  protected $_serializedColumns = array('params');
  protected $_rowClass = "Advmenusystem_Model_Submenu";
  
  public function getSubMenuByCoreMenuId($coreMenuId)
  {
  		$select = $this->select()->where("core_menu_id = ?", $coreMenuId);
  		return $this->fetchRow($select);
  }
  
}