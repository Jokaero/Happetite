<?php
class SocialConnect_Controller_Action_Helper_FormSequence2
  extends Zend_Controller_Action_Helper_Abstract
{
  protected $_plugins = array();
  protected $_order = array();
  protected $_needsSort = false;
  protected $_completeAction = array();
  protected $_registry;

  public function direct()
  {
    // Call init
    $this->initAll();

    // Process
    $this->doSubmit();
    $this->doView();
    return $this->doProcess();
  }

  public function getRegistry()
  {
    if( null === $this->_registry ) {
      $this->_registry = new stdClass();
    }

    return $this->_registry;
  }

  public function setPlugin(Core_Plugin_FormSequence_Interface $plugin, $order = 100)
  {
    $class = get_class($plugin);
    $this->_plugins[$class] = $plugin;
    $this->_order[$class] = $order;
    $this->_needsSort = true;
    $plugin->setRegistry($this->getRegistry());
    return $this;
  }

  public function getPlugin($class)
  {
    return @$this->_plugins[$class];
  }

  public function getPlugins()
  {
    $this->_sortPlugins();
    return $this->_plugins;
  }

  public function setPluginOrder($class, $order = 100)
  {
    if( isset($this->_plugins[$class]) )
    {
      $this->_order[$class] = $order;
      $this->_needsSort = true;
    }
    return $this;
  }

  public function clearPlugins()
  {
    $this->_plugins = array();
    $this->_order = array();
    $this->_needsSort = false;
    return $this;
  }

  protected function _sortPlugins()
  {
    if( $this->_needsSort )
    {
      $this->_needsSort = false;
      asort($this->_order);

      // Experimental
      $plugins = array();
      foreach( $this->_order as $class => $order )
      {
        $plugins[$class] = $this->_plugins[$class];
      }
      $this->_plugins = $plugins;
    }
  }

  public function initAll()
  {
    foreach( $this->getPlugins() as $plugin ) {
      if( method_exists($plugin, 'init') ) {
        $plugin->init();
      }
    }

    return $this;
  }

  public function resetAll()
  {
    foreach( $this->getPlugins() as $plugin ) {
      $plugin->resetSession();
    }

    return $this;
  }

  // Processing
  public function doSubmit()
  {
    if( $this->getActionController()->getRequest()->isPost() )
    {
      foreach( $this->getPlugins() as $plugin )
      {
        if( $plugin->isActive() )
        {
          	$plugin->onSubmit($this->getActionController()->getRequest());
          	return $plugin;
        }
      }
    }

    return false;
  }

  public function doView()
  {
    foreach( $this->getPlugins() as $plugin )
    {
      if( $plugin->isActive() )
      {
        $plugin->onView();
        $this->getActionController()->view->script = $plugin->getScript();
		$form = NULL;
		if($plugin -> getName() == 'fields')
		{
			$accountSession = new Zend_Session_Namespace('User_Plugin_Signup_Account');
        	$profileTypeValue = @$accountSession->data['profile_type'];
			if($profileTypeValue)
			{
				$pluginField = new SocialConnect_Plugin_Signup_Fields();
				$form = $pluginField -> getForm();
			}
			else 
			{
				$form = $plugin -> getForm();
			}
		}
		else {
			$form = $plugin -> getForm();
		}
        $this->getActionController()->view->form = $form;
        $this->getActionController()->view->title = $plugin->getTitle();
        return $plugin;
      }
    }

    return false;
  }

  public function doProcess()
  {
    // Check if we are all done
    $done = true;
    foreach( $this->getPlugins() as $plugin )
    {
      if( $plugin->isActive() )
      {
        $done = false;
      }
    }

    // Process
    if( $done )
    {
      $db = Engine_Db_Table::getDefaultAdapter();
      $db->beginTransaction();

      try
      {
        foreach( $this->getPlugins() as $plugin )
        {
          $plugin->onProcess();
        }

        $db->commit();
      }
      catch( Exception $e )
      {
        $db->rollBack();
        throw $e;
      }

      // Remove session data
      foreach( $this->getPlugins() as $plugin )
      {
        $plugin->getSession()->unsetAll();
      }

    }

    return $done;
  }

  protected function _forward($action, $controller = null, $module = null, array $params = null)
  {
    $request = $this->getActionController->getRequest();

    if (null !== $params) {
      $request->setParams($params);
    }

    if (null !== $controller) {
      $request->setControllerName($controller);

      // Module should only be reset if controller has been specified
      if (null !== $module) {
        $request->setModuleName($module);
      }
    }

    $request->setActionName($action)
      ->setDispatched(false);
  }
}