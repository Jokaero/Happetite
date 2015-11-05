<?php
class Advmenusystem_AdminContentsController extends Core_Controller_Action_Admin
{

	public function init()
	{
		// Get list of menus
		$this -> view -> navigation = $navigation = Engine_Api::_() -> getApi('menus', 'core') -> getNavigation('advmenusystem_admin_main', array(), 'advmenusystem_admin_contents_menu');
	}

	public function indexAction()
	{
		$this->view->form = $form = new Advmenusystem_Form_Admin_Content_Search();
		$enabledModuleNames = Engine_Api::_() -> getDbtable('modules', 'core') -> getEnabledModuleNames();
		$coremenuItemsTable = Engine_Api::_() -> getDbtable('menuItems', 'core');
		$coremenuItemsSelect = $coremenuItemsTable -> select() 
							-> where('menu = ?','core_main')
							-> where("submenu = '' OR submenu IS NULL")
							-> where('module IN(?)', $enabledModuleNames)
							-> order('order');
		$coreMenuItems = $coremenuItemsTable -> fetchAll($coremenuItemsSelect);
		$parram = array();
		foreach($coreMenuItems as $coreMenuItem)
		{
			$parram['1_'.$coreMenuItem-> id] = $coreMenuItem -> label;
			
		}
		$submenuItemsTable = Engine_Api::_()->getDbTable('submenus','advmenusystem');
		$submenuItemsSelect = $submenuItemsTable -> select() 
							-> where('level = 2');
		$subMenusItems = $submenuItemsTable -> fetchAll($submenuItemsSelect);
		foreach($subMenusItems as $subMenusItem)
		{
			$parram['2_'.$subMenusItem-> submenu_id] = "---- ".$subMenusItem -> label;
			
		}
		$form -> filter -> addMultiOptions($parram);
		
		$contentsTable = Engine_Api::_() -> getDbtable('contents', 'advmenusystem');
		if($this->_getParam('parent_id') && $this->_getParam('level'))
		{
			$params['parent_id'] = $this->_getParam('parent_id');
			$this -> view -> parent_id = $this->_getParam('parent_id');
			
			$params['level'] = $this->_getParam('level');
			$this -> view -> level = $this->_getParam('level');
			
			$form -> filter -> setValue($params['level']."_".$params['parent_id']);
		}
		//for search filter
		
		if($this->_getParam('filter') && $this->_getParam('search_filter'))
		{
			$params['filter'] = $this->_getParam('filter');
			$form -> filter -> setValue($params['filter']);
		}
		
		if ($this->getRequest()->isPost()) {
	      $values = $this->getRequest()->getPost();
	      foreach ($values as $key => $value) {
	        if ($key == 'delete_' . $value) {
	          $content = Engine_Api::_()->getItem('advmenusystem_content', $value);
	          $content->delete();
	        }
	      }
	    }
	    $page = $this->_getParam('page',1);
	    $this->view->paginator = Engine_Api::_()->getDbTable('contents','advmenusystem')->getContentsPaginator($params);
	    $this->view->paginator->setItemCountPerPage(20);
	    $this->view->paginator->setCurrentPageNumber($page);
		
	}
	
	public function createAction()
	{
		// Get form
		$this -> view -> form = $form = new Advmenusystem_Form_Admin_Content_Create();
		
		$enabledModuleNames = Engine_Api::_() -> getDbtable('modules', 'core') -> getEnabledModuleNames();
		$coremenuItemsTable = Engine_Api::_() -> getDbtable('menuItems', 'core');
		$coremenuItemsSelect = $coremenuItemsTable -> select() 
							-> where('menu = ?','core_main')
							-> where("submenu = '' OR submenu IS NULL")
							-> where('module IN (?)', $enabledModuleNames)
							-> order('order');
		$coreMenuItems = $coremenuItemsTable -> fetchAll($coremenuItemsSelect);
		$parram = array();
		foreach($coreMenuItems as $coreMenuItem)
		{
			$parram['1_'.$coreMenuItem-> id] = $coreMenuItem -> label;
			
		}
		$submenuItemsTable = Engine_Api::_()->getDbTable('submenus','advmenusystem');
		$submenuItemsSelect = $submenuItemsTable -> select() 
							-> where('level = 2');
		$subMenusItems = $submenuItemsTable -> fetchAll($submenuItemsSelect);					
		foreach($subMenusItems as $subMenusItem)
		{
			$parram['2_'.$subMenusItem-> submenu_id] = "---- ".$subMenusItem -> label;
			
		}
		if($this->_getParam('parent_id') && $this->_getParam('level'))
		{
			$selectedValue = $this->_getParam('level')."_".$this->_getParam('parent_id');
		}
		$form -> parent -> addMultiOptions($parram) ->setValue($selectedValue);
		
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
		$content = $form->saveValues();
		
		return $this -> _forward('success', 'utility', 'core', array(
			'messages' => array(Zend_Registry::get('Zend_Translate') -> _('Content Added.')),
			'format' => 'smoothbox',
			'smoothboxClose' => true,
			'parentRefresh' => true,
		));
	}
	
	public function editAction()
	{
		$content = Engine_Api::_()->getItem('advmenusystem_content', $this->_getParam('content_id'));	
		// Get form
		$this -> view -> form = $form = new Advmenusystem_Form_Admin_Content_Edit();
		
		$enabledModuleNames = Engine_Api::_() -> getDbtable('modules', 'core') -> getEnabledModuleNames();
		$coremenuItemsTable = Engine_Api::_() -> getDbtable('menuItems', 'core');
		$coremenuItemsSelect = $coremenuItemsTable -> select() 
							-> where('menu = ?','core_main')
							-> where("submenu = '' OR submenu IS NULL")
							-> where('module IN (?)', $enabledModuleNames)
							-> order('order');
		$coreMenuItems = $coremenuItemsTable -> fetchAll($coremenuItemsSelect);
		$menuItems = array();
		foreach($coreMenuItems as $coreMenuItem)
		{
			$menuItems['1_'.$coreMenuItem-> id] = $coreMenuItem -> label;
			
		}
		$submenuItemsTable = Engine_Api::_()->getDbTable('submenus','advmenusystem');
		$submenuItemsSelect = $submenuItemsTable -> select() 
							-> where('level = 2');
		$subMenusItems = $submenuItemsTable -> fetchAll($submenuItemsSelect);					
		foreach($subMenusItems as $subMenusItem)
		{
			$menuItems['2_'.$subMenusItem-> submenu_id] = "---- ".$subMenusItem -> label;
			
		}
		
		$selectedValue = $content['level']."_".$content['parent_id'];
		$form -> parent -> addMultiOptions($menuItems) -> setValue($selectedValue);
		
		$arr = array('title'=>json_decode($content['params']) -> title, 'url'=> json_decode($content['params']) -> url);
		$params = array_merge($content->toArray(), $arr);
		$form -> populate($params);
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
		  $values = $form->getValues();
		  unset($params);
		  $params['title'] = $values['title'];
		 $params['url'] = $values['url'];
		 $content-> parent_id = substr($values['parent'], 2);
		 $content-> level  = substr($values['parent'], 0, 1);
		 $content-> order = $values['order'];
		 $content-> enabled = $values['enabled'];
		 $content-> params = json_encode($params);
	      $content->modified_date = date('Y-m-d H:i:s');
	      $content->save();
		if (!empty($values['photo']))
			$content -> setPhoto($form -> photo);
		
		return $this -> _forward('success', 'utility', 'core', array(
			'messages' => array(Zend_Registry::get('Zend_Translate') -> _('Content Edited.')),
			'format' => 'smoothbox',
			'smoothboxClose' => true,
			'parentRefresh' => true,
		));
	}
	
	public function deleteAction()
   {
    // In smoothbox
    $this->_helper->layout->setLayout('admin-simple');
    $id = $this->_getParam('id');
    $this->view->content_id=$id;
    // Check post
    if( $this->getRequest()->isPost() )
    {
      $db = Engine_Db_Table::getDefaultAdapter();
      $db->beginTransaction();

      try
      {
        $content = Engine_Api::_()->getItem('advmenusystem_content', $id);
        // delete the book entry into the database
        $content->delete();
        $db->commit();
      }

      catch( Exception $e )
      {
        $db->rollBack();
        throw $e;
      }

      $this->_forward('success', 'utility', 'core', array(
          'smoothboxClose' => 10,
          'parentRefresh'=> 10,
          'messages' => array('')
      ));
    }

    // Output
    $this->renderScript('admin-contents/delete.tpl');
  }

}
