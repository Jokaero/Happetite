<?php

class SocialConnect_IndexController extends Core_Controller_Action_Standard
{
	const TEMPORAY_SESSION_LOGIN_ID = 'socialconnect_temporary_login_id';
	
	public function init()
	{

	}

	public function checkLayoutAction()
	{
		$this -> _helper -> layout -> setLayout('social-connect-layout');
	}

	protected function generateSecurityCode()
	{
		$seeks = '0123456789abcdefghiklmnopqstvxuyzABCDEFGHIKLMNOPQXUYZ';
		$max = strlen($seeks) - 1;
		$str = '';
		for ($i = 0; $i < 32; ++$i)
		{
			$str .= $seeks[mt_rand(0, $max)];
		}
		return sha1($str, false);
	}

	public function openidStartAction()
	{
		$req = $this -> getRequest();

		$service = $this -> _request -> getParam('service', '');

		$callbackUrl = $req -> getScheme() . '://' . $req -> getHttpHost() . Zend_Controller_Front::getInstance() -> getRouter() -> assemble(array(), 'connect_return');
		$url = "";
		
		if(in_array($service, array('facebook','twitter','linkedin')))
		{
			if(!Engine_Api::_() -> getApi('Core', 'SocialConnect')->checkSocialBridgePlugin())
			{
				echo $this->view->translate("Please install or enable Social Bridge plugin!");
				exit;
			}
			$obj = Engine_Api::_()->socialbridge()->getInstance($service);
			switch ($service) {
				case 'facebook':
					$url = $obj->getConnectUrl() .
						'&scope=email,user_about_me,user_birthday,user_hometown,user_interests,user_location,user_photos,user_website'.
						 '&' . http_build_query(array(
						'callbackUrl' => $callbackUrl.'?service='.$service
					));
					break;
				
				case 'twitter':
					$url = $obj->getConnectUrl() .
						 '&' . http_build_query(array(
						'callbackUrl' => $callbackUrl
					));
					break;
				
				case 'linkedin':
					$url = $obj->getConnectUrl() .
						'&scope=r_emailaddress'.
						 '&' . http_build_query(array(
						'callbackUrl' => $callbackUrl
					));
					break;
			}
		}
		else
		{
			$url = Engine_Api::_() -> getApi('Core', 'SocialConnect') -> getCentralServiceUrl() . '?' . http_build_query(array(
				'service' => $service,
				'callbackUrl' => urlencode($callbackUrl),
			));
		}
		$this -> _redirect($url);
	}

	/**
	 * @TODO: working with duplicated emails. if there is a duplicated email, please check to notify theme about mapping resoled.
	 */
	public function openidReturnAction()
	{
		$this -> _helper -> layout -> disableLayout();

		$viewer = Engine_Api::_() -> user() -> getViewer();
		
		/******Get contact from openId*****/
		$cur_url = $_SERVER['REQUEST_URI'];
		parse_str($cur_url, $params);
		
		$arr_token = array();
		$service = "";
		foreach ($params as $key => $val)
		{
			if (strpos($key, '?user') !== false)
			{
				$service = 'twitter';
				$arr_token['user_id'] = $val;
			}
			if (strpos($key, 'oauth_tok3n') !== false)
			{
				$arr_token['access_token'] = $val;
			}
			if ($key == 'contact')
			{
				$service = 'linkedin';
			}
			if (strpos($key, 'oauth_token_secret') !== false)
			{
				$arr_token['secret_token'] = $val;
			}
		}
		if($this -> _request -> getParam('service', '') == "facebook")
		{
			$service = 'facebook';
		}

		if(in_array($service, array('facebook','twitter','linkedin')))
		{
			 
			$obj = Engine_Api::_()->socialbridge()->getInstance($service);
			$data = $obj->getOwnerInfo($arr_token);
		}
		else 
		{
			$data = Zend_Json::decode($_POST['json_data'], 1);
		}
		$api = Engine_Api::_() -> getApi('Core', 'SocialConnect');
		if(isset($data['service']) && $data['service'])
		{
			$service = $data['service'];
		}

		$identity = $data['identity'];

		if (!$identity or !$service)
		{
			exit("No Idenity And Service Specific, please contact admin for this problem!");
		}

		// if account is exsits, map this account by agent table
		if (is_object($viewer) && $viewer -> getIdentity())
		{
			$api -> createAccount($viewer -> getIdentity(), $identity, $service, $data);
			return $this -> render('check-signon');
		}

		$user = $api -> getUserByIdentityAndService($identity, $service);
		$redirectUrl = '';
		$router = Zend_Controller_Front::getInstance() -> getRouter();
		// have mapped account
		if (is_object($user) && $user -> user_id)
		{
			$_SESSION[self::TEMPORAY_SESSION_LOGIN_ID] = $user -> getIdentity();
			$account = $api -> getAccountLinked($user -> getIdentity(), $service);
			if($account)
			{
				$account->returning = 1;
				$account->save();
			}
			$redirectUrl = $router -> assemble(array(), 'socialconnect_login', true);
		}
		else
		{
			$_SESSION['quick_signup'] = array(
				'service' => $service,
				'identity' => $identity,
				'data' => Zend_Json::encode($data)
			);
			$settings = Engine_Api::_()->getApi('settings', 'core');
			$api -> buildSessionSignupData($data, $identity, $service);
			$userExists = NULL;
			if (isset($data['email']) && $data['email'])
			{
				$userExists = $api -> getUserByEmail($data['email']);
				// exists SE  account
				if (is_object($userExists) && $userExists -> email)
				{
					$_SESSION['quick_signup'] = array(
						'service' => $service,
						'identity' => $identity,
						'email'=>  $userExists->email,
						'user_id' => $userExists->getIdentity(),
						'title' => $userExists->getTitle(),
						'data' => Zend_Json::encode($data)
					);
					$redirectUrl = $router -> assemble(array(), 'connect_exists', true);
				}
				else if(!$settings->getSetting('socialconnect.standardsignup', 1)) // quick sign up
				{
					// not exists SE account
					if(!in_array($service, array('yahoo')) && isset($data['gender']) && $data['gender'] != "")
						$data['gender'] = $data['gender'] + 1;
					// check settings
					$input_password = $settings->getSetting('socialconnect.inputpassword', 0);
					$_SESSION['quick_signup']['noVerifyEmail'] = TRUE;
					if($input_password) // need input password
					{
						$redirectUrl = $router -> assemble(array(), 'socialconnect_add_password', true);	
					}
					else
					{
						$user = $this -> createAccount();
						if($user)
						{
							$_SESSION[self::TEMPORAY_SESSION_LOGIN_ID] = $user -> getIdentity();
							$redirectUrl = $router -> assemble(array(), 'socialconnect_login', true);
						}
						else
						{
							$_SESSION['quick_signup']['noVerifyEmail'] = FALSE;
							$redirectUrl = $router -> assemble(array(), 'socialconnect_signup', true);
						}
					}
				}
				else // standard sign up
				{
					if(!in_array($service, array('yahoo')) && isset($data['gender']) && $data['gender'] != "")
						$data['gender'] = $data['gender'] + 1;
					$redirectUrl = $router -> assemble(array(), 'socialconnect_signup', true);
				}
			}
			else if(!$settings->getSetting('socialconnect.standardsignup', 1)) // quick sign up but missing email
			{
				$redirectUrl = $router -> assemble(array(), 'socialconnect_add_email', true);
			}
			else // standard signup
			{
				if(!in_array($service, array('yahoo')) && isset($data['gender']) && $data['gender'] != "")
					$data['gender'] = $data['gender'] + 1;
				$redirectUrl = $router -> assemble(array(), 'socialconnect_signup', true);
			}
		}
		$this -> view -> service = $service;
		$this -> view -> identity = $identity;
		$this -> view -> redirectUrl = $redirectUrl;

		return $this -> render('check-signup');
		// we need to check signon on signup.
	}

	public function signupAction()
	{
		$front = Zend_Controller_Front::getInstance();
		$base_path = $front -> getBaseUrl();

		$this -> _successRedirectUrl = $base_path;

		if (getenv('mode') == 'debug')
		{
			print_r($_SESSION);
		}

		$service = $this -> _request -> getParam('service');

		$form = $this -> view -> form = new SocialConnect_Form_SignUp();

		$form -> setTitle(sprintf('Sign Up with %s account ', ucfirst($service)));
		$desc = sprintf("you are using profile information from %s account to our site", ucfirst($service));
		$form -> setDescription($desc);
		$sesData = $_SESSION['quick_signup'];
		$connectedData = $userInfo = $sesData['user'];
		$identity = $sesData['identity'];
		$connectedData['fullname'] = $connectedData['firstname'] . ' ' . $connectedData['lastname'];
		$connectedData['displayname'] = $connectedData['fullname'];
		if ($this -> _request -> isGet())
		{
			if (isset($userInfo['email']))
			{
				$form -> getElement('email') -> setValue($userInfo['email']);
			}
			if (isset($userInfo['nickname']) && $form -> getElement('username'))
			{
				$form -> getElement('username') -> setValue($userInfo['nickname']);
			}
		}

		if ($this -> _request -> isPost() && $form -> isValid($_POST))
		{
			$putData = $formData = $form -> getValues();
			try
			{
				$api = Engine_Api::_() -> getApi('Core', 'SocialConnect');
				$result = $api -> addUser($service, $identity, $connectedData, $formData);
				if ($result)
				{
					if ($this -> openidCheckSignOn($connectedData, FALSE))
					{
						$front = Zend_Controller_Front::getInstance();
						$base_path = $front -> getBaseUrl();
					}
					$this -> _redirect('/members/home');
				}
			}
			catch(Exception $e)
			{
				$form -> setDescription('there are an error occur. ' . $e -> getMessage());
			}

		}
	}

	protected function getUrl($url)
	{
		$host = (isset($_SERVER['HTTP_HOST']) ? $_SERVER['HTTP_HOST'] : '');
		$proto = (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== "off") ? 'https' : 'http';
		$port = (isset($_SERVER['SERVER_PORT']) ? $_SERVER['SERVER_PORT'] : 80);
		$uri = $proto . '://' . $host;
		if ((('http' == $proto) && (80 != $port)) || (('https' == $proto) && (443 != $port)))
		{
			$uri .= ':' . $port;
		}
		$url = $uri . '/' . ltrim($url, '/');

		return $url;
	}
	public function loginAction()
	{
		// Render
		$this -> _helper -> content -> setContentName('user_auth_login') -> setEnabled();
		
		$this->view->form = $form = new User_Form_Login();
		$form->setAction(Zend_Controller_Front::getInstance()->getRouter()->assemble(array(), 'user_login', true));
	    
		$user_id = 0;
		$email = "";

		$skey = self::TEMPORAY_SESSION_LOGIN_ID;

		if (isset($_SESSION[$skey]))
		{
			$user_id = $_SESSION[$skey];
			unset($_SESSION[$skey]);
		}

		// $email, $password, $remember
		$user_table = Engine_Api::_() -> getDbtable('users', 'user');
		// If post exists
		$user = $user_table -> find($user_id) -> current();

		// Get ip address
		$db = Engine_Db_Table::getDefaultAdapter();
		$ipObj = new Engine_IP();
		$ipExpr = new Zend_Db_Expr($db -> quoteInto('UNHEX(?)', bin2hex($ipObj -> toBinary())));

		// Check if user exists
		if (empty($user))
		{
			$this -> view -> status = false;
			$this -> view -> error = Zend_Registry::get('Zend_Translate') -> _('No record of a member with that email was found.');

			// Register login
			Engine_Api::_() -> getDbtable('logins', 'user') -> insert(array(
				'email' => $email,
				'ip' => $ipExpr,
				'timestamp' => new Zend_Db_Expr('NOW()'),
				'state' => 'no-member',
			));

			return;
		}

		// Check if user is verified and enabled
		if (!$user -> enabled)
		{
			if (!$user -> verified)
			{
				$this -> view -> status = false;

				$resend_url = $this -> _helper -> url -> url(array(
					'action' => 'resend',
					'email' => $email
				), 'user_signup', true);
				$translate = Zend_Registry::get('Zend_Translate');
				$error = $translate -> translate('This account still requires either email verification.');
				$error .= ' ';
				$error .= sprintf($translate -> translate('Click <a href="%s">here</a> to resend the email.'), $resend_url);

				$this -> view -> error = $error;
				$form->getDecorator('errors')->setOption('escape', false);
				$form->addError($error);

				// Register login
				Engine_Api::_() -> getDbtable('logins', 'user') -> insert(array(
					'user_id' => $user -> getIdentity(),
					'email' => $email,
					'ip' => $ipExpr,
					'timestamp' => new Zend_Db_Expr('NOW()'),
					'state' => 'disabled',
				));

				return;
			}
			else
			if (!$user -> approved)
			{
				$this -> view -> status = false;

				$translate = Zend_Registry::get('Zend_Translate');
				$this -> view -> error = $error = $translate -> translate('This account still requires admin approval.');
				$form->getDecorator('errors')->setOption('escape', false);
				$form->addError($error);

				// Register login
				Engine_Api::_() -> getDbtable('logins', 'user') -> insert(array(
					'user_id' => $user -> getIdentity(),
					'email' => $email,
					'ip' => $ipExpr,
					'timestamp' => new Zend_Db_Expr('NOW()'),
					'state' => 'disabled',
				));

				return;
			}
			// Should be handled by hooks or payment
		}

		// Handle subscriptions
		if (Engine_Api::_() -> hasModuleBootstrap('payment'))
		{
			// Check for the user's plan
			$subscriptionsTable = Engine_Api::_() -> getDbtable('subscriptions', 'payment');
			if (!$subscriptionsTable -> check($user))
			{
				// Register login
				Engine_Api::_() -> getDbtable('logins', 'user') -> insert(array(
					'user_id' => $user -> getIdentity(),
					'email' => $email,
					'ip' => $ipExpr,
					'timestamp' => new Zend_Db_Expr('NOW()'),
					'state' => 'unpaid',
				));
				// Redirect to subscription page
				$subscriptionSession = new Zend_Session_Namespace('Payment_Subscription');
				$subscriptionSession -> unsetAll();
				$subscriptionSession -> user_id = $user -> getIdentity();
				return $this -> _helper -> redirector -> gotoRoute(array(
					'module' => 'payment',
					'controller' => 'subscription',
					'action' => 'index'
				), 'default', true);
			}
		}

		// Register login
		$auth = Zend_Auth::getInstance();

		$auth -> getStorage() -> write($user -> getIdentity());

		// Run pre login hook
		$event = Engine_Hooks_Dispatcher::getInstance() -> callEvent('onUserLoginBefore', $user);

		foreach ((array) $event->getResponses() as $response)
		{
			if (is_array($response))
			{
				if (!empty($response['error']) && !empty($response['message']))
				{
					$form -> addError($response['message']);
				}
				else
				if (!empty($response['redirect']))
				{
					$this -> _helper -> redirector -> gotoUrl($response['redirect'], array('prependBase' => false));
				}
				else
				{
					continue;
				}

				// Register login
				Engine_Api::_() -> getDbtable('logins', 'user') -> insert(array(
					'user_id' => $user -> getIdentity(),
					'email' => $email,
					'ip' => $ipExpr,
					'timestamp' => new Zend_Db_Expr('NOW()'),
					'state' => 'third-party',
				));

				// Return
				return;
			}
		}

		// Register login
		$loginTable = Engine_Api::_() -> getDbtable('logins', 'user');
		$loginTable -> insert(array(
			'user_id' => $user -> getIdentity(),
			'email' => $email,
			'ip' => $ipExpr,
			'timestamp' => new Zend_Db_Expr('NOW()'),
			'state' => 'success',
			'active' => true,
		));
		$_SESSION['login_id'] = $login_id = $loginTable -> getAdapter() -> lastInsertId();

		// Increment sign-in count
		Engine_Api::_() -> getDbtable('statistics', 'core') -> increment('user.logins');

		// Test activity @todo remove
		$viewer = Engine_Api::_() -> user() -> getViewer();
		if ($viewer -> getIdentity())
		{
			$viewer -> lastlogin_date = date("Y-m-d H:i:s");
			if ('cli' !== PHP_SAPI)
			{
				$viewer -> lastlogin_ip = $ipExpr;
			}
			$viewer -> save();
			Engine_Api::_() -> getDbtable('actions', 'activity') -> addActivity($viewer, $viewer, 'login');
		}

		// Assign sid to view for json context
		$this -> view -> status = true;
		$this -> view -> message = Zend_Registry::get('Zend_Translate') -> _('Login successful');
		$this -> view -> sid = Zend_Session::getId();
		$this -> view -> sname = Zend_Session::getOptions('name');

		// Run post login hook
		$event = Engine_Hooks_Dispatcher::getInstance() -> callEvent('onUserLoginAfter', $viewer);

		// Do redirection only if normal context
		if (null === $this -> _helper -> contextSwitch -> getCurrentContext())
		{
			// Redirect by session
			$session = new Zend_Session_Namespace('Redirect');
			if (isset($session -> uri))
			{
				$uri = $session -> uri;
				$opts = $session -> options;
				$session -> unsetAll();
				return $this -> _redirect($uri, $opts);
			}
			else
			if (isset($session -> route))
			{
				$session -> unsetAll();
				return $this -> _helper -> redirector -> gotoRoute($session -> params, $session -> route, $session -> reset);
			}

			// Redirect by hook
			foreach ((array) $event->getResponses() as $response)
			{
				if (is_array($response))
				{
					if (!empty($response['error']) && !empty($response['message']))
					{
						return $form -> addError($response['message']);
					}
					else
					if (!empty($response['redirect']))
					{
						return $this -> _helper -> redirector -> gotoUrl($response['redirect'], array('prependBase' => false));
					}
				}
			}

			// Just redirect to home
			return $this -> _helper -> redirector -> gotoRoute(array('action' => 'home'), 'user_general', true);
		}
	}

	// Exists account
	public function identityExistsAction()
	{
		if(isset($_SESSION['quick_signup']))
		{
			$email = $_SESSION['quick_signup']['email'];
			$this->view->email = $email;
			 // Make form
		    $this->view->form = $form = new User_Form_Login();
		    $form->setAction($this->view->url(array('return_url' => null)));
		}
		else 
		{
			return $this->_helper->requireAuth->forward ();
		}
	}
	
	// Input email
	public function addEmailAction()
	{
		if(isset($_SESSION['quick_signup']) && isset($_SESSION['SocialConnect_SignUp_Data']))
		{
			$_SESSION['quick_signup']['noVerifyEmail'] = FALSE;
			 // Make form
		    $this->view->form = $form = new SocialConnect_Form_AddEmail();
			if(!$this -> getRequest() -> isPost())
			{
				return;
			}
			$posts = $this -> getRequest() -> getPost();
			if (!$form -> isValid($posts))
			{
				return;
			}
			$values = $form -> getValues();
			$_SESSION['SocialConnect_SignUp_Data']['email'] = $values['email'];
			if(isset($values['password']) && $values['password'])
			{
				$_SESSION['SocialConnect_SignUp_Data']['password'] = $values['password'];
			}
			$api = Engine_Api::_() -> getApi('Core', 'SocialConnect');
			$userExists = $api -> getUserByEmail($values['email']);
			if (is_object($userExists) && $userExists -> email)
			{
				$_SESSION['quick_signup']['user_id'] = $userExists->getIdentity();
				$_SESSION['quick_signup']['title'] = $userExists->getTitle();
				return $this->_helper->redirector->gotoRoute(array(), 'connect_exists', true);
			}
			else 
			{
				$user = $this -> createAccount();
				if($user)
				{
					$_SESSION[self::TEMPORAY_SESSION_LOGIN_ID] = $user -> getIdentity();
					return $this->_helper->redirector->gotoRoute(array(), 'socialconnect_login', true);
				}
				else {
					return $this->_helper->redirector->gotoRoute(array(), 'socialconnect_signup', true);
				}
			}
		}
		else 
		{
			return $this->_helper->redirector->gotoRoute(array(), 'socialconnect_signup', true);
		}
	}
	
	// Input password
	public function addPasswordAction()
	{
		if(isset($_SESSION['quick_signup']) && isset($_SESSION['SocialConnect_SignUp_Data']))
		{
			 // Make form
		    $this->view->form = $form = new SocialConnect_Form_AddPassword();
			if(!$this -> getRequest() -> isPost())
			{
				return;
			}
			$posts = $this -> getRequest() -> getPost();
			if (!$form -> isValid($posts))
			{
				return;
			}
			$values = $form -> getValues();
			$_SESSION['SocialConnect_SignUp_Data']['password'] = $values['password'];
			$user = $this -> createAccount();
			if($user)
			{
				$_SESSION[self::TEMPORAY_SESSION_LOGIN_ID] = $user -> getIdentity();
				return $this->_helper->redirector->gotoRoute(array(), 'socialconnect_login', true);
			}
			else {
				return $this->_helper->redirector->gotoRoute(array(), 'socialconnect_signup', true);
			}
		}
		else 
		{
			return $this->_helper->redirector->gotoRoute(array(), 'socialconnect_signup', true);
		}
	}
	
	public function verifyCodeMapUserAction()
	{
		if(isset($_SESSION['quick_signup']))
		{
			$userId = $_SESSION['quick_signup']['user_id'];
			$identity = $_SESSION['quick_signup']['identity'];
			$email = $_SESSION['quick_signup']['email'];
			$title = $_SESSION['quick_signup']['title'];
			$service = $_SESSION['quick_signup']['service'];
			$data = Zend_Json::decode($_SESSION['quick_signup']['data']);
			$str = $email.$userId.$identity.$service;
			$code = md5($str);
			$this->view->email = $email;
				
			if(!isset($_POST['submit']))
			{
				//send $code to this email
				$mailParams = array(
			      'host' => $_SERVER['HTTP_HOST'],
			      'email' => $email,
			      'date' => time(),
			      'recipient_title' => $title,
			      'queue' => false,
			      'verify_code' => $code,
			    );
			    
			    Engine_Api::_()->getApi('mail', 'core')->sendSystem(
			      $email,
			      'socialconnect_verify_code',
			      $mailParams
			    );
			}
			else 
			{
				$code_verify = $_POST['code'];
				if($code == $code_verify)
				{
					$api = Engine_Api::_() -> getApi('Core', 'SocialConnect');
					$router = Zend_Controller_Front::getInstance() -> getRouter();
					
					$api->createAccount($userId, $identity, $service, $data);
				
					$_SESSION[self::TEMPORAY_SESSION_LOGIN_ID] = $userId;
					
					unset($_SESSION['quick_signup']);	
					
					return $this->_helper->redirector->gotoRoute ( array (
							'module' => 'social-connect',
							'controller' => 'index',
							'action' => 'login'
					), 'default', true );
				}
				else {
					$this->view->message = $this->view->translate("Verify code incorrect!");
				}
			}
		}
		else 
		{
			return $this->_helper->requireAuth->forward ();
		}	
	}
	public function accountLinkingAction()
	{
		// Check auth
        if( !$this->_helper->requireUser()->isValid() ) return;
		 // Can specifiy custom id
	    $id = $this->_getParam('id', null);
	    $subject = null;
	    if( null === $id )
	    {
	      $subject = Engine_Api::_()->user()->getViewer();
	      Engine_Api::_()->core()->setSubject($subject);
	    }
	    else
	    {
	      $subject = Engine_Api::_()->getItem('user', $id);
	      Engine_Api::_()->core()->setSubject($subject);
	    }
	
	    // Set up require's
	    $this->_helper->requireUser();
	    $this->_helper->requireSubject();
	    $this->_helper->requireAuth()->setAuthParams(
	      $subject,
	      null,
	      'edit'
	    );
    
	    // Set up navigation
	    $this->view->navigation = $navigation = Engine_Api::_()
	      ->getApi('menus', 'core')
	      ->getNavigation('user_settings', ( $id ? array('params' => array('id'=>$id)) : array()));
		$this->view->user_id = $subject->getIdentity();
		$this->view->services = Engine_Api::_() -> getDbTable('Services', 'SocialConnect') -> getServices(100, 1);	
	}
	public function deleteLinkedAction()
	{
		$account_id = $this->_getParam('account_id', null);
		$this->view->account_id = $account_id;
		// check auth
		if (! $this->_helper->requireUser ()->isValid ())
			return;
		// In smoothbox
		$this->_helper->layout->setLayout ( 'default-simple' );
		$form = new SocialConnect_Form_Confirm ();
		$this->view->form = $form;
		if (! $this->getRequest ()->isPost ()) {
			return;
		}
		Engine_Api::_() -> getDbTable('Accounts', 'SocialConnect')->deleteAccount($account_id);
		return $this->_forward ( 'success', 'utility', 'core', array (
				'messages' => array (
						Zend_Registry::get ( 'Zend_Translate' )->_ ( 'Delete linking successfully.' )
				),
				'layout' => 'default-simple',
				'smoothboxClose' => true,
				'parentRefresh' => true
		) );
	}
	protected function createAccount()
	{
		if(!isset($_SESSION['SocialConnect_SignUp_Data']))
		{
			return;
		}
		$data = $_SESSION['SocialConnect_SignUp_Data'];
		unset($_SESSION['SocialConnect_SignUp_Data']);
		unset($_SESSION['User_Plugin_Signup_Account']);
		unset($_SESSION['User_Plugin_Signup_Fields']);
		unset($_SESSION['User_Plugin_Signup_Photo']);
		unset($_SESSION['User_Plugin_Signup_Invite']);
		unset($_SESSION['Contactimporter_Plugin_Signup_Invite']);
		try
		{
			$settings = Engine_Api::_()->getApi('settings', 'core');
			$userTable = Engine_Api::_() -> getItemTable('user');
			// check username
			if(isset($data['username']))
			{
				$select = $userTable -> select() -> where('username = ?', $data['username']);
				$accountExist = $userTable->fetchRow($select);
				if($accountExist)
				{
					$data['username'] = $data['username']. '_'. time();
				}
			}
			$emailadmin = ($settings->getSetting('user.signup.adminemail', 0) == 1);
			if( $emailadmin ) {
			  // the signup notification is emailed to the first SuperAdmin by default
			  $users_select = $userTable->select()
		  	    ->where('level_id = ?', 1)
			    ->where('enabled >= ?', 1);
			  $super_admin = $userTable->fetchRow($users_select);
			}
			$random = false;
			if(!$settings->getSetting('socialconnect.inputpassword', 0))
			{
				$data['password'] = Engine_Api::_()->user()->randomPass(10);
				$random = true;
			}
			$core_locale = $settings -> core_locale;
			$data['timezone'] = $core_locale['timezone'];
			
			//creating user model
			$user = $userTable -> createRow();
			$user->setFromArray($data);
			$user -> save();
			
			$user->setDisplayName(array(
					'first_name' => $data['first_name'],
					'last_name' => $data['last_name']
			));
			Engine_Api::_()->user()->setViewer($user);

		    // Increment signup counter
		    Engine_Api::_()->getDbtable('statistics', 'core')->increment('user.creations');
			
			if( $user->verified && $user->enabled ) 
			{
		      // Create activity for them
		      Engine_Api::_()->getDbtable('actions', 'activity')->addActivity($user, $user, 'signup');
		      // Set user as logged in if not have to verify email
		      Engine_Api::_()->user()->getAuth()->getStorage()->write($user->getIdentity());
		    }
	
			foreach ($data as $k => $v)
			{
				if (is_string($v))
					$data[$k] = html_entity_decode($v, ENT_QUOTES, 'UTF-8');
			}
			
			$topStructure = Engine_Api::_() -> fields() -> getFieldStructureTop('user');
			$formArgs = array();
			if (count($topStructure) == 1 && $topStructure[0] -> getChild() -> type == 'profile_type')
			{
				$profileTypeField = $topStructure[0] -> getChild();
				$options = $profileTypeField -> getOptions();
				$formArgs = array(
					'topLevelId' => $profileTypeField -> field_id,
					'topLevelValue' => $options[0] -> option_id,
				);
			}

			if ($formArgs)
			{
				$struct = Engine_Api::_() -> fields() -> getFieldsStructureFull($user, $formArgs['topLevelId'], $formArgs['topLevelValue']);
				$arr_data = array();
				foreach ($struct as $fskey => $map)
				{
					$field = $map -> getChild();
					$type = $field -> type;
					if (isset($data[$type]))
					{
						$arr_data[$fskey] = $data[$type];
					}
				}

				$profileTypeValue = $formArgs['topLevelValue'];
				$values = Engine_Api::_() -> fields() -> getFieldsValues($user);

				$valueRow = $values -> createRow();
				$valueRow -> field_id = $profileTypeField -> field_id;
				$valueRow -> item_id = $user -> getIdentity();
				$valueRow -> value = $profileTypeValue;
				$valueRow -> save();

				foreach ($arr_data as $key => $value)
				{
					$parts = explode('_', $key);
					if (count($parts) != 3)
						continue;
					list($parent_id, $option_id, $field_id) = $parts;

					// Array mode
					if (is_array($value))
					{
						// Lookup
						$valueRows = $values -> getRowsMatching(array(
							'field_id' => $field_id,
							'item_id' => $user -> getIdentity()
						));

						// Delete all
						$prevPrivacy = null;
						foreach ($valueRows as $valueRow)
						{
							if (!empty($valueRow -> privacy))
							{
								$prevPrivacy = $valueRow -> privacy;
							}
							$valueRow -> delete();
						}

						// Insert all
						$indexIndex = 0;
						if (is_array($value) || !empty($value))
						{
							foreach ((array) $value as $singleValue)
							{
								$valueRow = $values -> createRow();
								$valueRow -> field_id = $field_id;
								$valueRow -> item_id = $user -> getIdentity();
								$valueRow -> index = $indexIndex++;
								$valueRow -> value = $singleValue;
								$valueRow -> save();
							}
						}
						else
						{
							$valueRow = $values -> createRow();
							$valueRow -> field_id = $field_id;
							$valueRow -> item_id = $user -> getIdentity();
							$valueRow -> index = 0;
							$valueRow -> value = '';
							$valueRow -> save();
						}
					}
					// Scalar mode
					else
					{
						// Lookup
						$valueRow = $values -> getRowMatching(array(
							'field_id' => $field_id,
							'item_id' => $user -> getIdentity(),
							'index' => 0
						));

						// Create if missing
						$isNew = false;
						if (!$valueRow)
						{
							$isNew = true;
							$valueRow = $values -> createRow();
							$valueRow -> field_id = $field_id;
							$valueRow -> item_id = $user -> getIdentity();
						}

						$valueRow -> value = htmlspecialchars($value);
						$valueRow -> save();
					}
				}

				// Update search table
				Engine_Api::_() -> getApi('core', 'fields') -> updateSearch($user, $values);

				// Fire on save hook
				Engine_Hooks_Dispatcher::getInstance() -> callEvent('onFieldsValuesSave', array(
					'item' => $user,
					'values' => $values
				));

				// Run post signup hook
				$event = Engine_Hooks_Dispatcher::getInstance()->callEvent('onUserSignupAfter', $user);
				
				$mailType = null;
			    $mailParams = array(
			      'host' => $_SERVER['HTTP_HOST'],
			      'email' => $user->email,
			      'date' => time(),
			      'recipient_title' => $user->getTitle(),
			      'recipient_link' => $user->getHref(),
			      'recipient_photo' => $user->getPhotoUrl('thumb.icon'),
			      'object_link' => Zend_Controller_Front::getInstance()->getRouter()->assemble(array(), 'user_login', true),
			    );
			
			    // Add password to email if necessary
			    if( $random ) 
			    {
			    	$mailParams['password'] = $data['password'];
			    }
			
		        // Mail stuff
			    switch( $settings->getSetting('user.signup.verifyemail', 0) ) 
			    {
			      case 0:
			        if( $random ) 
			        {
			        	$mailType = 'core_welcome_password';
			        }
					if( $emailadmin ) 
					{
						$mailAdminType = 'notify_admin_user_signup';
						$mailAdminParams = array(
							'host' => $_SERVER['HTTP_HOST'],
							'email' => $user->email,
							'date' => date("F j, Y, g:i a"),
							'recipient_title' => $super_admin->displayname,
							'object_title' => $user->displayname,
							'object_link' => $user->getHref(),
						);
					}
			        break;
			
			      case 1:
			        // send welcome email
			        $mailType = ($random ? 'core_welcome_password' : 'core_welcome');
					if( $emailadmin ) {
						$mailAdminType = 'notify_admin_user_signup';
						$mailAdminParams = array(
							'host' => $_SERVER['HTTP_HOST'],
							'email' => $user->email,
							'date' => date("F j, Y, g:i a"),
							'recipient_title' => $super_admin->displayname,
							'object_title' => $user->getTitle(),
							'object_link' => $user->getHref(),
						);
					}
			        break;
			
			      case 2:
			        // verify email before enabling account
			        $verify_table = Engine_Api::_()->getDbtable('verify', 'user');
			        $verify_row = $verify_table->createRow();
			        $verify_row->user_id = $user->getIdentity();
			        $verify_row->code = md5($user->email
			            . $user->creation_date
			            . $settings->getSetting('core.secret', 'staticSalt')
			            . (string) rand(1000000, 9999999));
			        $verify_row->date = $user->creation_date;
			        $verify_row->save();
			        $mailType = ($random ? 'core_verification_password' : 'core_verification');
			        $mailParams['object_link'] = Zend_Controller_Front::getInstance()->getRouter()->assemble(array(
			              'action' => 'verify',
			              'email' => $user->email,
			              'verify' => $verify_row->code
			            ), 'user_signup', true);
					
					if( $emailadmin ) 
					{
						$mailAdminType = 'notify_admin_user_signup';
						$mailAdminParams = array(
							'host' => $_SERVER['HTTP_HOST'],
							'email' => $user->email,
							'date' => date("F j, Y, g:i a"),
							'recipient_title' => $super_admin->displayname,
							'object_title' => $user->getTitle(),
							'object_link' => $user->getHref(),
						);
					}
			        break;
			
			      default:
			        // do nothing
			        break;
			    }
			    
    			// Send Welcome E-mail
			    if( isset($mailType) && $mailType ) {
			      Engine_Api::_()->getApi('mail', 'core')->sendSystem(
			        $user,
			        $mailType,
			        $mailParams
			      );
			    }
			    
			    // Send Notify Admin E-mail
			    if( isset($mailAdminType) && $mailAdminType ) {
			      Engine_Api::_()->getApi('mail', 'core')->sendSystem(
			        $user,
			        $mailAdminType,
			        $mailAdminParams
			      );
			    }   
			}
			return $user;
		}
		catch( Exception $e )
		{
			return;
		}
	}
}
