<?php
class SocialConnect_Form_AddEmail extends Engine_Form
{
	public function init()
	{
		$settings = Engine_Api::_() -> getApi('settings', 'core');
		$this -> setTitle('SignUp - Required Info');

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

		$this -> email -> getValidator('Db_NoRecordExists')->setMessage('Someone has already registered this email address, please use another one.', 'recordFound');
		 // Add banned email validator
    	$bannedEmailValidator = new Engine_Validate_Callback(array($this, 'checkBannedEmail'), $emailElement);
    	$bannedEmailValidator->setMessage("This email address is not available, please use another one.");
    	$this -> email->addValidator($bannedEmailValidator);
		
		if( $settings->getSetting('socialconnect.inputpassword', 0)) 
		{
	      // Element: password
	      $this->addElement('Password', 'password', array(
	        'label' => 'Password',
	        'description' => 'Passwords must be at least 6 characters in length.',
	        'required' => true,
	        'allowEmpty' => false,
	        'validators' => array(
	          array('NotEmpty', true),
	          array('StringLength', false, array(6, 32)),
	        ),
	        'tabindex' => $tabIndex++,
	      ));
	      $this->password->getDecorator('Description')->setOptions(array('placement' => 'APPEND'));
	      $this->password->getValidator('NotEmpty')->setMessage('Please enter a valid password.', 'isEmpty');
	
	      // Element: passconf
	      $this->addElement('Password', 'passconf', array(
	        'label' => 'Password Again',
	        'description' => 'Enter your password again for confirmation.',
	        'required' => true,
	        'validators' => array(
	          array('NotEmpty', true),
	        ),
	        'tabindex' => $tabIndex++,
	      ));
	      $this->passconf->getDecorator('Description')->setOptions(array('placement' => 'APPEND'));
	      $this->passconf->getValidator('NotEmpty')->setMessage('Please make sure the "password" and "password again" fields match.', 'isEmpty');
	
	      $specialValidator = new Engine_Validate_Callback(array($this, 'checkPasswordConfirm'), $this->password);
	      $specialValidator->setMessage('Password did not match', 'invalid');
	      $this->passconf->addValidator($specialValidator);
	    }

		// Init submit
		$this -> addElement('Button', 'submit', array(
			'label' => 'Continue',
			'type' => 'submit',
			'ignore' => true,
		));
	}

	public function checkBannedEmail($value, $emailElement)
	{
		$bannedEmailsTable = Engine_Api::_() -> getDbtable('BannedEmails', 'core');
		return !$bannedEmailsTable -> isEmailBanned($value);
	}
	public function checkPasswordConfirm($value, $passwordElement)
  	{
   		return ( $value == $passwordElement->getValue() );
  	}
}
