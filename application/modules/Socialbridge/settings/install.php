<?php
class Socialbridge_Installer extends Engine_Package_Installer_Module {
	function onInstall() {		

		
	$this->_addManageSocial();
	
		

	parent::onInstall ();
	}
	
	protected function _addManageSocial()
  	{
	  	$db = $this->getDb();
	  
	  	// profile page
	  	$page_id = $db->select()
	  	->from('engine4_core_pages', 'page_id')
	  	->where('name = ?', 'socialbridge_index_index')
	  	->limit(1)
	  	->query()
	  	->fetchColumn();
	  
	  	// insert if it doesn't exist yet
	  	if( !$page_id ) {
	  		// Insert page
	  		$db->insert('engine4_core_pages', array(
	  				'name' => 'socialbridge_index_index',
	  				'displayname' => 'Manage Social Bridge',
	  				'title' => 'Manage Social Bridge',
	  				'description' => 'Manage Social Bridge.',
	  				'custom' => 0,
	  		));
	  		$page_id = $db->lastInsertId();
	  
	  		// Insert top
	  		$db->insert('engine4_core_content', array(
	  				'type' => 'container',
	  				'name' => 'top',
	  				'page_id' => $page_id,
	  				'order' => 1,
	  		));
	  		$top_id = $db->lastInsertId();
	  
	  		// Insert main
	  		$db->insert('engine4_core_content', array(
	  				'type' => 'container',
	  				'name' => 'main',
	  				'page_id' => $page_id,
	  				'order' => 2,
	  		));
	  		$main_id = $db->lastInsertId();
	  
	  		// Insert top-middle
	  		$db->insert('engine4_core_content', array(
	  				'type' => 'container',
	  				'name' => 'middle',
	  				'page_id' => $page_id,
	  				'parent_content_id' => $top_id,
	  		));
	  		$top_middle_id = $db->lastInsertId();
	  
	  		// Insert main-middle
	  		$db->insert('engine4_core_content', array(
	  				'type' => 'container',
	  				'name' => 'middle',
	  				'page_id' => $page_id,
	  				'parent_content_id' => $main_id,
	  				'order' => 2,
	  		));
	  		$main_middle_id = $db->lastInsertId();
	  
	  		// Insert menu
	  		$db->insert('engine4_core_content', array(
	  				'type' => 'widget',
	  				'name' => 'socialbridge.browse-menu',
	  				'page_id' => $page_id,
	  				'parent_content_id' => $top_middle_id,
	  				'order' => 1,
	  		));
	  
	  		// Insert content
	  		$db->insert('engine4_core_content', array(
	  				'type' => 'widget',
	  				'name' => 'core.content',
	  				'page_id' => $page_id,
	  				'parent_content_id' => $main_middle_id,
	  				'order' => 1,
	  		));
	  
	  	}
  
  	}
}
?>