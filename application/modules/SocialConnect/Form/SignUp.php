<?php
class SocialConnect_Form_SignUp extends Engine_Form
{
	public function init()
	{
		$settings = Engine_Api::_() -> getApi('settings', 'core');

		$tabIndex = 0;
		// Init form
		$email_address = Zend_Controller_Front::getInstance() -> getRequest() -> getParam('email');
		$invite_code = Zend_Controller_Front::getInstance() -> getRequest() -> getParam('code');

		$this -> setTitle('Quick SignUp');

		// Init email
		$this -> addElement('Text', 'email', array(
			'label' => 'Email Address',
			'description' => 'You will use your email address to login.',
			'required' => true,
			'allowEmpty' => false,
			'tabindex' => $tabIndex++,
			'validators' => array(
				array(
					'NotEmpty',
					true
				),
				array(
					'EmailAddress',
					true
				),
				array(
					'Db_NoRecordExists',
					true,
					array(
						Engine_Db_Table::getTablePrefix() . 'users',
						'email'
					)
				)
			)
		));

		if (($settings -> getSetting('user.signup.verifyemail') > 0) && ($settings -> getSetting('user.signup.checkemail') == 1))
		{
			$this -> email -> addValidator('Identical', true, array($email_address));
			$this -> email -> getValidator('Identical') -> setMessage('Your email address must match the address that was invited.', 'notSame');
		}
		if (!empty($email_address))
		{
			$this -> email -> setValue($email_address);
		}

		// Element: username
		if ($settings -> getSetting('user.signup.username', 1) > 0)
		{
			$description = Zend_Registry::get('Zend_Translate') -> _('This will be the end of your profile link, for example: <br /> ' . '<span id="profile_address">http://%s</span>');
			$description = sprintf($description, $_SERVER['HTTP_HOST'] . Zend_Controller_Front::getInstance() -> getRouter() -> assemble(array('id' => 'yourname'), 'user_profile'));

			$this -> addElement('Text', 'username', array(
				'label' => 'Profile Address',
				'description' => $description,
				'required' => true,
				'allowEmpty' => false,
				'validators' => array(
					array(
						'NotEmpty',
						true
					),
					array(
						'Alnum',
						true
					),
					array(
						'StringLength',
						true,
						array(
							4,
							64
						)
					),
					array(
						'Regex',
						true,
						array('/^[a-z][a-z0-9]*$/i')
					),
					array(
						'Db_NoRecordExists',
						true,
						array(
							Engine_Db_Table::getTablePrefix() . 'users',
							'username'
						)
					)
				),
				'tabindex' => $tabIndex++,
			));
			$this -> username -> getDecorator('Description') -> setOptions(array(
				'placement' => 'APPEND',
				'escape' => false
			));
			$this -> username -> getValidator('NotEmpty') -> setMessage('Please enter a valid profile address.', 'isEmpty');
			$this -> username -> getValidator('Db_NoRecordExists') -> setMessage('Someone has already picked this profile address, please use another one.', 'recordFound');
			$this -> username -> getValidator('Regex') -> setMessage('Profile addresses must start with a letter.', 'regexNotMatch');
			$this -> username -> getValidator('Alnum') -> setMessage('Profile addresses must be alphanumeric.', 'notAlnum');

			// Add banned username validator
			$bannedUsernameValidator = new Engine_Validate_Callback( array(
				$this,
				'checkBannedUsername'
			), $this -> username);
			$bannedUsernameValidator -> setMessage("This profile address is not available, please use another one.");
			$this -> username -> addValidator($bannedUsernameValidator);
		}

		/**
		 * add email by some other rule
		 */
		if ($settings -> getSetting('user.signup.random', 0) == 0 && empty($_SESSION['facebook_signup']) && empty($_SESSION['twitter_signup']) && empty($_SESSION['janrain_signup']))
		{

			// Element: password
			$this -> addElement('Password', 'password', array(
				'label' => 'Password',
				'description' => 'Passwords must be at least 6 characters in length.',
				'required' => true,
				'allowEmpty' => false,
				'validators' => array(
					array(
						'NotEmpty',
						true
					),
					array(
						'StringLength',
						false,
						array(
							6,
							32
						)
					),
				),
				'tabindex' => $tabIndex++,
			));
			$this -> password -> getDecorator('Description') -> setOptions(array('placement' => 'APPEND'));
			$this -> password -> getValidator('NotEmpty') -> setMessage('Please enter a valid password.', 'isEmpty');

			// Element: passconf
			$this -> addElement('Password', 'passconf', array(
				'label' => 'Password Again',
				'description' => 'Enter your password again for confirmation.',
				'required' => true,
				'validators' => array( array(
						'NotEmpty',
						true
					), ),
				'tabindex' => $tabIndex++,
			));
			$this -> passconf -> getDecorator('Description') -> setOptions(array('placement' => 'APPEND'));
			$this -> passconf -> getValidator('NotEmpty') -> setMessage('Please make sure the "password" and "password again" fields match.', 'isEmpty');

			$specialValidator = new Engine_Validate_Callback( array(
				$this,
				'checkPasswordConfirm'
			), $this -> password);
			$specialValidator -> setMessage('Password did not match', 'invalid');
			$this -> passconf -> addValidator($specialValidator);
		}

		//'onblur' => 'var el = this; en4.user.checkEmailTaken(this.value, function(taken){ el.style.marginBottom = taken * 100 +
		// "px" });'
		$this -> email -> getDecorator('Description') -> setOptions(array('placement' => 'APPEND'));
		$this -> email -> getValidator('NotEmpty') -> setMessage('Please enter a valid email address.', 'isEmpty');
		$this -> email -> getValidator('Db_NoRecordExists') -> setMessage('Someone has already registered this email address, please use another one.', 'recordFound');

		$description = Zend_Registry::get('Zend_Translate') -> _('This will be the end of your profile link, for example: <br /> <span id="profile_address">http://%s</span>');
		$description = sprintf($description, $_SERVER['HTTP_HOST'] . Zend_Controller_Front::getInstance() -> getRouter() -> assemble(array('id' => Zend_Registry::get('Zend_Translate') -> _('yourname')), 'user_profile'));

		// Init profile_type
		if ($settings -> getSetting('user.signup.terms', 1) == 1)
		{
			// Init terms
			$description = Zend_Registry::get('Zend_Translate') -> _('I have read and agree to the <a target="_blank" href="%s/help/terms">terms of service</a>.');
			$description = sprintf($description, Zend_Controller_Front::getInstance() -> getBaseUrl());

			$this -> addElement('Checkbox', 'terms', array(
				'label' => 'Terms of Service',
				'description' => $description,
				'validators' => array(
					'notEmpty',
					array(
						'GreaterThan',
						false,
						array(0)
					),
				)
			));
			$this -> terms -> getValidator('GreaterThan') -> setMessage('You must agree to the terms of service to continue.', 'notGreaterThan');

			$this -> terms -> clearDecorators() -> addDecorator('ViewHelper') -> addDecorator('Description', array(
				'placement' => Zend_Form_Decorator_Abstract::APPEND,
				'tag' => 'label',
				'class' => 'null',
				'escape' => false,
				'for' => 'terms'
			)) -> addDecorator('DivDivDivWrapper');

			//$this->terms->setDisableTranslator(true);
		}

		// Init submit
		$this -> addElement('Button', 'submit', array(
			'label' => 'Continue',
			'type' => 'submit',
			'ignore' => true,
		));

		// Set default action
		$this -> setAction(Zend_Controller_Front::getInstance() -> getRouter() -> assemble(array(), 'connect_signup'));
	}

	public function checkPasswordConfirm($value, $passwordElement)
	{
		return ($value == $passwordElement -> getValue());
	}

	public function checkInviteCode($value, $emailElement)
	{
		$inviteTable = Engine_Api::_() -> getDbtable('invites', 'invite');
		$select = $inviteTable -> select() -> from($inviteTable -> info('name'), 'COUNT(*)') -> where('code = ?', $value);

		if (Engine_Api::_() -> getApi('settings', 'core') -> getSetting('user.signup.checkemail'))
		{
			$select -> where('recipient LIKE ?', $emailElement -> getValue());
		}

		return (bool)$select -> query() -> fetchColumn(0);
	}

	public function checkBannedEmail($value, $emailElement)
	{
		$bannedEmailsTable = Engine_Api::_() -> getDbtable('BannedEmails', 'core');
		return !$bannedEmailsTable -> isEmailBanned($value);
	}

	public function checkBannedUsername($value, $usernameElement)
	{
		$bannedUsernamesTable = Engine_Api::_() -> getDbtable('BannedUsernames', 'core');
		return !$bannedUsernamesTable -> isUsernameBanned($value);
	}

}
