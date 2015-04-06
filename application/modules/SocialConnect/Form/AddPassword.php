<?php
class SocialConnect_Form_AddPassword extends Engine_Form
{
	public function init()
	{
		$settings = Engine_Api::_() -> getApi('settings', 'core');
		$this -> setTitle('SignUp - Required Info');
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
		// Init submit
		$this -> addElement('Button', 'submit', array(
			'label' => 'Continue',
			'type' => 'submit',
			'ignore' => true,
		));
	}

	public function checkPasswordConfirm($value, $passwordElement)
  	{
   		return ( $value == $passwordElement->getValue() );
  	}
}
