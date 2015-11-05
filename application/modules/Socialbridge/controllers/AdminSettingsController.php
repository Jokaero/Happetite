<?php
class Socialbridge_AdminSettingsController extends Core_Controller_Action_Admin
{
	public function indexAction()
	{

	}

	public function fbsettingAction()
	{
		$this -> view -> navigation = $navigation = Engine_Api::_() -> getApi('menus', 'core') -> getNavigation('socialbridge_admin_main', array(), 'socialbridge_admin_main_fbsetting');
		$this -> view -> form = $form = new Socialbridge_Form_Admin_Fbsettings();
		$name = 'facebook';
		$apiSetting = Engine_Api::_() -> getDbtable('apisettings', 'socialbridge');
		$select = $apiSetting -> select() -> where('api_name = ?', $name);
		$provider = $apiSetting -> fetchRow($select);
		if (isset($provider) && $provider != null)
		{
			$params = unserialize($provider -> api_params);
			$form -> FBKey -> setValue($params['key']);
			$form -> FBSecret -> setValue($params['secret']);
			if($params['max_invite_day'])
				$form -> max_invite_day -> setValue($params['max_invite_day']);
			else {
				$form -> max_invite_day -> setValue(20);
			}
		}

		if ($this -> getRequest() -> isPost() && $this -> view -> form -> isValid($this -> getRequest() -> getPost()))
		{
			$db = Engine_Api::_() -> getDbtable('apisettings', 'socialbridge') -> getAdapter();
			$db -> beginTransaction();
			try
			{
				$params = array(
					'key' => $form -> getValue('FBKey'),
					'secret' => $form -> getValue('FBSecret'),
					'max_invite_day' => $form -> getValue('max_invite_day'),
				);
				if ($provider != null)
				{
					$provider -> api_params = serialize($params);
					$provider -> save();
					$form -> addNotice("Update Facebook Settings Successfully.");
				}
				else
				{
					$values = array(
						'api_name' => 'facebook',
						'api_params' => serialize($params),
					);
					$table = $this -> _helper -> api() -> getDbtable('apisettings', 'socialbridge');
					$st = $table -> createRow();
					$st -> setFromArray($values);
					$st -> save();
					$form -> addNotice("Add Facebook Settings Successfully.");
				}

				$db -> commit();
			}
			catch (Exception $e)
			{
				$db -> rollback();
				throw $e;
			}
		}
	}
	public function twsettingAction()
	{
		$this -> view -> navigation = $navigation = Engine_Api::_() -> getApi('menus', 'core') -> getNavigation('socialbridge_admin_main', array(), 'socialbridge_admin_main_twsetting');
		$this -> view -> form = $form = new Socialbridge_Form_Admin_Twsettings();
		$name = 'twitter';
		$apiSetting = Engine_Api::_() -> getDbtable('apisettings', 'socialbridge');
		$select = $apiSetting -> select() -> where('api_name = ?', $name);
		$provider = $apiSetting -> fetchRow($select);
		if (isset($provider) && $provider != null)
		{
			$params = unserialize($provider -> api_params);
			$form -> consumer_key -> setValue($params['key']);
			$form -> consumer_secret -> setValue($params['secret']);
			if($params['max_invite_day'])
				$form -> max_invite_day -> setValue($params['max_invite_day']);
			else {
				$form -> max_invite_day -> setValue(250);
			}
		}

		if ($this -> getRequest() -> isPost() && $this -> view -> form -> isValid($this -> getRequest() -> getPost()))
		{
			$db = Engine_Api::_() -> getDbtable('apisettings', 'socialbridge') -> getAdapter();
			$db -> beginTransaction();
			try
			{
				$params = array(
					'key' => $form -> getValue('consumer_key'),
					'secret' => $form -> getValue('consumer_secret'),
					'max_invite_day' => $form -> getValue('max_invite_day'),
				);
				if ($provider != null)
				{
					$provider -> api_params = serialize($params);
					$provider -> save();
					$form -> addNotice("Update Twitter Settings Successfully.");
				}
				else
				{
					$values = array(
						'api_name' => 'twitter',
						'api_params' => serialize($params),
					);
					$table = $this -> _helper -> api() -> getDbtable('apisettings', 'socialbridge');
					$st = $table -> createRow();
					$st -> setFromArray($values);
					$st -> save();
					$form -> addNotice("Add Twitter Settings Successfully.");
				}

				$db -> commit();
			}
			catch (Exception $e)
			{
				$db -> rollback();
				throw $e;
			}
		}
	}
	public function lisettingAction()
	{
		$this -> view -> navigation = $navigation = Engine_Api::_() -> getApi('menus', 'core') -> getNavigation('socialbridge_admin_main', array(), 'socialbridge_admin_main_lisetting');
		$this -> view -> form = $form = new Socialbridge_Form_Admin_Lisettings();
		$name = 'linkedin';
		$apiSetting = Engine_Api::_() -> getDbtable('apisettings', 'socialbridge');
		$select = $apiSetting -> select() -> where('api_name = ?', $name);
		$provider = $apiSetting -> fetchRow($select);
		if (isset($provider) && $provider != null)
		{
			$params = unserialize($provider -> api_params);
			$form -> key -> setValue($params['key']);
			$form -> secret -> setValue($params['secret']);
			if($params['max_invite_day'])
				$form -> max_invite_day -> setValue($params['max_invite_day']);
			else {
				$form -> max_invite_day -> setValue(10);
			}
		}

		if ($this -> getRequest() -> isPost() && $this -> view -> form -> isValid($this -> getRequest() -> getPost()))
		{
			$db = Engine_Api::_() -> getDbtable('apisettings', 'socialbridge') -> getAdapter();
			$db -> beginTransaction();
			try
			{
				$params = array(
					'key' => $form -> getValue('key'),
					'secret' => $form -> getValue('secret'),
					'max_invite_day' => $form -> getValue('max_invite_day'),
				);
				if ($provider != null)
				{
					$provider -> api_params = serialize($params);
					$provider -> save();
					$form -> addNotice("Update Linkedin Settings Successfully.");
				}
				else
				{
					$values = array(
						'api_name' => 'linkedin',
						'api_params' => serialize($params),
					);
					$table = $this -> _helper -> api() -> getDbtable('apisettings', 'socialbridge');
					$st = $table -> createRow();
					$st -> setFromArray($values);
					$st -> save();
					$form -> addNotice("Add Linkedin Settings Successfully.");
				}

				$db -> commit();
			}
			catch (Exception $e)
			{
				$db -> rollback();
				throw $e;
			}
		}
	}
}
