<?php

class Socialbridge_IndexController extends Core_Controller_Action_Standard
{
	public function indexAction()
	{
		if (!$this -> _helper -> requireUser() -> isValid())
		{
			return;
		}
		$this->_helper->content->setEnabled();
		$req = $this -> getRequest();
		$this->view->callbackUrl = $req -> getScheme() . '://' . $req -> getHttpHost() . Zend_Controller_Front::getInstance() -> getRouter() -> assemble(array(), 'socialbridge_general');
		$this->view->disconnect = $req -> getScheme() . '://' . $req -> getHttpHost() . Zend_Controller_Front::getInstance() -> getRouter() -> assemble(array('action'=>'disconnect'), 'socialbridge_general');
	}

	public function disconnectAction()
	{
		$viewer = Engine_Api::_() -> user() -> getViewer();
		$service = $this -> _request -> getParam('service', '');
		$obj = Engine_Api::_() -> socialbridge() -> getInstance($service);
		$values = array('service' => $service,'user_id' => $viewer->getIdentity());
		$token = $obj -> getToken($values);
		if($token)
		{
			$queue = $obj -> getQueue(array(
					'token_id' => $token -> token_id,
					'user_id' => $viewer -> getIdentity(),
					'service' => $service,
					'type' => 'getFeed'
				));
			if($queue)
			{
				$queue->delete();
			}
			//$token->session_id = 0;
			$token->delete();
		}
		switch ($service)
		{
			case 'facebook':
				unset($_SESSION['socialbridge_session'][$service]);
				break;
			case 'twitter':
				unset($_SESSION['socialbridge_session'][$service]);
				break;
			case 'linkedin':
				unset($_SESSION['socialbridge_session'][$service]);
				break;
		}

	    return $this -> _helper -> redirector -> gotoRoute(array('action' => 'index'), 'socialbridge_general', true);
	}
}
