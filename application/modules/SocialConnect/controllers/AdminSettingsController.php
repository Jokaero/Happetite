<?php

class SocialConnect_AdminSettingsController extends Core_Controller_Action_Admin
{

	public function init()
	{
	}

	public function listingAction()
	{
		$this -> view -> navigation = $navigation = Engine_Api::_() -> getApi('menus', 'core') -> getNavigation('socialconnect_admin', array(), 'socialconnect_admin_providers');

		$talbe = Engine_Api::_() -> getDbTable('Services', 'SocialConnect');
		$select = $talbe -> select() -> order('service_id');
		$this -> view -> paginator = $paginator = $talbe -> fetchAll($select);
	}

	/**
	 * main settings.
	 * @return unknown_type
	 */

	/**
	 * show list of consumer for edit.
	 * @return unknown_type
	 */

	public function indexAction()
	{

		$this -> view -> navigation = $navigation = Engine_Api::_() -> getApi('menus', 'core') -> getNavigation('socialconnect_admin', array(), 'socialconnect_admin_settings');

		$form = $this -> view -> form = new SocialConnect_Form_General();

		if ($this -> getRequest() -> isPost() && $form -> isValid($this -> getRequest() -> getPost()))
		{
			$values = $form -> getValues();
			foreach ($values as $key => $value)
			{
				if($key == 'quick_signup_heading')
				{
					continue;
				}
				Engine_Api::_() -> getApi('settings', 'core') -> setSetting($key, $value);
			}
			$form -> addNotice('Your changes have been saved.');
		}

	}
	/**
	 * fields settings
	 *
	 */
	public function fieldsAction()
	{
		$this -> view -> navigation = $navigation = Engine_Api::_() -> getApi('menus', 'core') -> getNavigation('openid_admin', array(), 'openid_admin_fields');
	}

	/**
	 * @return unknown_type
	 */
	public function mapAction()
	{
		$service = $this -> _request -> getParam('service');
		// In smoothbox
		$form = $this -> view -> form = new SocialConnect_Form_Map();
		$check = SocialConnect_Api_Core::getMapService($service);

		$title = sprintf('%s to Social Engine Profile ', ucfirst($service));

		$desc = 'Set "None" value if you do not need to map %s fields.';
		$desc = sprintf($desc, ucfirst($service));
		if ($check == 'openid')
		{
			$desc .= ' This configuration affects to all OpenID service providers as myopenid, yiid.com, etc.';
		}
		$form -> setTitle($title);
		$form -> setDescription($desc);

		$form -> populateData($service);

		if ($this -> _request -> isPost() && $form -> isValid($_POST))
		{
			$result = $form -> commitSave($service);

			if ($result)
			{
				//$form -> addNotice('Your changes have been saved.');
				return $this->_forward ( 'success', 'utility', 'core', array (
				'messages' => array (
						Zend_Registry::get ( 'Zend_Translate' )->_ ( 'Your changes have been saved.' )
				),
				'layout' => 'default-simple',
				'smoothboxClose' => true,
				'parentRefresh' => false
		) );
			}
		}
	}

	public function changeEnableAction()
	{
		$service_id = $this -> _request -> getParam('service_id');
		$talbe = Engine_Api::_() -> getDbTable('Services', 'SocialConnect') -> switchEnable($service_id);
	}

}
