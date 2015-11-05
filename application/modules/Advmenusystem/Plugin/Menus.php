<?php

class Advmenusystem_Plugin_Menus
{
	// core_mini

	public function onMenuInitialize_AdvmenusystemMiniAdmin($row)
	{
		// @todo check perms
		if (Engine_Api::_() -> getApi('core', 'authorization') -> isAllowed('admin', null, 'view'))
		{
			return array(
				'label' => $row -> label,
				'route' => 'admin_default'
			);
		}

		return false;
	}

	public function onMenuInitialize_AdvmenusystemMiniProfile($row)
	{
		$viewer = Engine_Api::_() -> user() -> getViewer();
		if ($viewer -> getIdentity())
		{
			return array(
				'label' => $row -> label,
				'uri' => $viewer -> getHref(),
			);
		}
		return false;
	}

	public function onMenuInitialize_AdvmenusystemMiniSettings($row)
	{
		$viewer = Engine_Api::_() -> user() -> getViewer();
		if ($viewer -> getIdentity())
		{
			return array(
				'label' => $row -> label,
				'route' => 'user_extended',
				'params' => array(
					'controller' => 'settings',
					'action' => 'general',
				)
			);
		}
		return false;
	}

	public function onMenuInitialize_AdvmenusystemMiniAuth($row)
	{
		$viewer = Engine_Api::_() -> user() -> getViewer();
		if ($viewer -> getIdentity())
		{
			return array(
				'label' => 'Sign Out',
				'route' => 'user_logout'
			);
		}

		else
		{
			return array(
				'label' => 'Sign In',
				'route' => 'user_login',
				'params' => array(
					// Nasty hack
					'return_url' => '64-' . base64_encode($_SERVER['REQUEST_URI']), ),
			);
		}
	}

	public function onMenuInitialize_AdvmenusystemMiniSignup($row)
	{
		$viewer = Engine_Api::_() -> user() -> getViewer();
		if (!$viewer -> getIdentity())
		{
			return array(
				'label' => 'Sign Up',
				'route' => 'user_signup'
			);
		}

		return false;
	}

	public function onMenuInitialize_AdvmenusystemMiniNotification($row)
	{
		$viewer = Engine_Api::_() -> user() -> getViewer();
		if (!$viewer -> getIdentity())
		{
			return true;
		}

		return false;
	}

}
