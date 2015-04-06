<?php
 
class Advmenusystem_Model_Content extends Core_Model_Item_Abstract
{
	
  public function getParentName($parent_id, $level)
  {
  	if($level == 1){
	    $tableContentTable = Engine_Api::_()->getItemTable('advmenusystem_content');
	    $tableContentName = $tableContentTable->info('name');
		
		$menuItemsTable = Engine_Api::_() -> getDbtable('menuItems', 'core');
	    $menuItemsName = $menuItemsTable->info('name');
		
		$select = $menuItemsTable->select()->from(array('menuitem' => $menuItemsName ));
		$select -> setIntegrityCheck(false)
	                -> join("$tableContentName as content","content.parent_id = menuitem.id",'');
		$select -> where("menuitem.id = ?", $parent_id);
		$parent = $menuItemsTable -> fetchRow($select);
		return $parent['label'];
	    
  	}
	elseif ($level == 2) {
		$tableContentTable = Engine_Api::_()->getItemTable('advmenusystem_content');
	    $tableContentName = $tableContentTable->info('name');
		
		$submenuItemsTable = Engine_Api::_() -> getDbtable('submenus', 'advmenusystem');
	    $submenuItemsName = $submenuItemsTable->info('name');
		
		$select = $submenuItemsTable->select()->from(array('submenuitem' => $submenuItemsName ));
		$select -> setIntegrityCheck(false)
	                -> join("$tableContentName as content","content.parent_id = submenuitem.submenu_id",'');
		$select -> where("submenuitem.submenu_id = ?", $parent_id);
		$parent = $submenuItemsTable -> fetchRow($select);
		return $parent['label'];
	}
  }
  
  public function setPhoto($photo)
	{
		if ($photo instanceof Zend_Form_Element_File)
		{
			$file = $photo -> getFileName();
		}
		else
		if (is_array($photo) && !empty($photo['tmp_name']))
		{
			$file = $photo['tmp_name'];
		}
		else
		if (is_string($photo) && file_exists($photo))
		{
			$file = $photo;
		}
		else
		{
			throw new Music_Model_Exception('Invalid argument passed to setPhoto: ' . print_r($photo, 1));
		}

		$name = basename($file);
		$path = APPLICATION_PATH . DIRECTORY_SEPARATOR . 'temporary';
		$params = array(
			'parent_type' => 'book',
			'parent_id' => $this -> getIdentity()
		);
		// Save
		$storage = Engine_Api::_ ()->storage ();

		// Resize image (main)
		$image = Engine_Image::factory ();
		$image->open ( $file )->resize ( 720, 720 )->write ( $path . '/m_' . $name )->destroy ();

		// Resize image (profile)
		$image = Engine_Image::factory ();
		$image->open ( $file )->resize ( 240, 240 )->write ( $path . '/p_' . $name )->destroy ();

		// Resize image (normal)
		$image = Engine_Image::factory ();
		$image->open ( $file )->resize ( 110, 110 )->write ( $path . '/in_' . $name )->destroy ();

		// Resize image (icon)
		$image = Engine_Image::factory ();
		$image->open ( $file );

		$size = min ( $image->height, $image->width );
		$x = ($image->width - $size) / 2;
		$y = ($image->height - $size) / 2;

		$image->resample ( $x, $y, $size, $size, 50, 50 )->write ( $path . '/is_' . $name )->destroy ();

		// Store
		$iMain = $storage->create ( $path . '/m_' . $name, $params );
		$iProfile = $storage->create ( $path . '/p_' . $name, $params );
		$iIconNormal = $storage->create ( $path . '/in_' . $name, $params );
		$iSquare = $storage->create ( $path . '/is_' . $name, $params );

		$iMain->bridge ( $iProfile, 'thumb.profile' );
		$iMain->bridge ( $iIconNormal, 'thumb.normal' );
		$iMain->bridge ( $iSquare, 'thumb.icon' );

		// Remove temp files
		@unlink ( $path . '/p_' . $name );
		@unlink ( $path . '/m_' . $name );
		@unlink ( $path . '/in_' . $name );
		@unlink ( $path . '/is_' . $name );
		// Update row
		$this -> modified_date = date('Y-m-d H:i:s');
		$this -> photo_id = $iMain -> getIdentity();
		$this -> save();

		return $this;
	}
}