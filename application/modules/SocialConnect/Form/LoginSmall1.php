<?php
class SocialConnect_Form_LoginSmall1 extends Engine_Form_Email
{
	public function init()
	{
		setcookie ('cookie_test', 1, time() + 600, '/');   
		$description = Zend_Registry::get('Zend_Translate') -> _("If you already have an account, please enter your details below. If you don't have one yet, please <a href='%s'>sign up</a> first.");

		$description = sprintf($description, Zend_Controller_Front::getInstance() -> getRouter() -> assemble(array(), 'user_signup', true));

		// Init form
		$this -> setTitle('Member Sign In');
		$this -> setDescription($description);
		$this -> setAttrib('id', 'user_form_login');
		$this -> loadDefaultDecorators();
		$this -> getDecorator('Description') -> setOption('escape', false);
		$email = Zend_Registry::get('Zend_Translate') -> _('Email Address');
		// Init email
		$this->addEmailElement(array(
	      'label' => $email,
	      'required' => true,
	      'allowEmpty' => false,
	      'filters' => array(
	        'StringTrim',
	      ),
	      'validators' => array(
	        'EmailAddress'
	      ),
	      
	      // Fancy stuff
	      'tabindex' => 1,
	      'autofocus' => 'autofocus',
	      'inputType' => 'email',
	      'class' => 'text',
	    ));
		
		
		$password = Zend_Registry::get('Zend_Translate') -> _('Password');
		// Init password
		$this -> addElement('Password', 'password', array(
			'label' => $password,
			'required' => true,
			'allowEmpty' => false,
			'tabindex' => 2,
			'filters' => array('StringTrim', ),
		));

		// Init remember me
		$this -> addElement('Checkbox', 'remember', array(
			'label' => 'Remember Me',
			'tabindex' => 4,
		));

		$this -> addElement('Hidden', 'return_url', array());

		$settings = Engine_Api::_() -> getApi('settings', 'core');
		if ($settings -> core_spam_login)
		{
			$this -> addElement('captcha', 'captcha', array(
				'label' => 'Human Verification',
				'description' => 'Please validate that you are not a robot by typing in the letters and numbers in this image:',
				'captcha' => 'image',
				'required' => true,
				'tabindex' => 3,
				'captchaOptions' => array(
					'wordLen' => 6,
					'fontSize' => '30',
					'timeout' => 300,
					'imgDir' => APPLICATION_PATH . '/public/temporary/',
					'imgUrl' => $this -> getView() -> baseUrl() . '/public/temporary',
					'font' => APPLICATION_PATH . '/application/modules/Core/externals/fonts/arial.ttf'
				)
			));
		}

		// Init submit
		$this -> addElement('Button', 'submit', array(
			'label' => 'Sign In',
			'type' => 'submit',
			'ignore' => true,
			'tabindex' => 5,
		));

		$this -> addDisplayGroup(array(
			'submit',
			'remember'
		), 'buttons');

		$table = Engine_Api::_() -> getDbTable('Services', 'SocialConnect');
		$rs = $table -> getServices(100, 1);
		$separateLimit = Engine_Api::_() -> getApi('settings', 'core') -> getSetting('socialconnect.seperatelimit', 5);

		$view = Zend_Registry::get('Zend_View');
		$front = Zend_Controller_Front::getInstance();
		$base_path = $view -> layout() -> staticBaseUrl;

		$htmls = array();

		if ($rs -> count())
		{
			$htmls[] = '<div style="text-left; margin-top:5px">';
			$counter = 0;
			if ($separateLimit != 0)
			{
				foreach ($rs as $o)
				{
					$htmls[] = sprintf('<a title="%s" href="javascript: void(sopopup(\'%s\'));"><img alt="%s" src="' . $base_path . 'application/modules/SocialConnect/externals/images/%s.png" class="ynsc_sprite"/></a>', $view->translate('Sign in %s', $o -> title), $o -> getHref(), $o -> title, $o -> name);
					if (++$counter >= $separateLimit)
					{
						break;
					}

				}
			}
			$counter = 0;
			if ($rs -> count() > $separateLimit)
			{

				$id2 = 'tid2_' . time();
				$id1 = 'tid1_' . time();
				$htmls[] = '';

				foreach ($rs as $o)
				{
					if (++$counter <= $separateLimit)
					{
						continue;
					}

					$htmls[] = sprintf('<a title="%s" href="javascript: void(0);" onclick="javascript: M2b.SocialConnect.signon(\'%s\')" class="ld44" style="display:none"><img alt="%s" src="' . $base_path . 'application/modules/SocialConnect/externals/images/%s.png" class="ynsc_sprite"/></a>', $view->translate('Sign in %s', $o -> title), $o -> getHref(), $o -> title, $o -> name);
				}
				$htmls[] = '';
				$htmls[] = '<a href="javascript:  void(0)" mode="open" onclick="toggleIt( \'' . $id2 . '\',\'' . $id1 . '\')" id="' . $id2 . '" style="line-height:32px;"><img title="'.$view->translate("More").'" src="' . $base_path . 'application/modules/SocialConnect/externals/images/more.png" width="26px" height="26px" class="ynsc_sprite"/></a>';
			}
			$htmls[] = '</div>';
		}
		$social_connect_html = implode('', $htmls);

		$content = Zend_Registry::get('Zend_Translate') -> _("<span><a href='%s'>Forgot Password?</a></span>");
		$content = sprintf($content, Zend_Controller_Front::getInstance() -> getRouter() -> assemble(array(
			'module' => 'user',
			'controller' => 'auth',
			'action' => 'forgot'
		), 'default', true));

		// Init forgot password link
		$this -> addElement('Dummy', 'forgot', array('content' => $content, ));

		// start change code
		if ($rs -> count())
		{
			$this -> addElement('Dummy', 'signin_using', array(
				'content' => '<h4 style="margin:5px 0; padding:0;text-align:center;border:0 none;">Or Sign In Using</h4>',
				'decorators' => array('ViewHelper'),
			));
		}

		// Init facebook login link
		if ('none' != $settings -> getSetting('core_facebook_enable', false) && $settings -> core_facebook_secret)
		{
			$this -> addElement('Dummy', 'facebook', array(
				'content' => '<div style="text-align:center">' . User_Model_DbTable_Facebook::loginButton() . '</div>',
				'decorators' => array('ViewHelper'),
			));
		}
		$this -> addElement('Dummy', 'signing_list', array(
			'content' => $social_connect_html,
			'decorators' => array('ViewHelper'),
		));
		// end change code.

		// Set default action
		$this -> setAction(Zend_Controller_Front::getInstance() -> getRouter() -> assemble(array(), 'user_login'));
	}

}
