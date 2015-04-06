<?php

class SocialConnect_Form_General extends Engine_Form
{
	public function init()
	{
		$settings = Engine_Api::_()->getApi('settings', 'core');
		$description = '';
		$this -> setTitle('General Settings');
		$this -> setDescription($description);
		$this -> setAttrib('id', 'user_form_login');
		$this -> loadDefaultDecorators();
		$this -> getDecorator('Description') -> setOption('escape', false);

		$this -> addElement('Text', 'socialconnect_seperatelimit', array(
			'label' => 'Short Limit',
			'description' => 'Number of items show on login-or-join widget.',
			'validators' => array('Int'),
			'size' => 2,
			'value' => $settings->getSetting('socialconnect.seperatelimit', 5),
			'validators' => array(
				array(
					'Int',
					true
				),
				array(
					'GreaterThan',
					true,
					array(-1)
				)
			)
		));
		
		if(Engine_Api::_() -> getApi('Core', 'SocialConnect')->checkContactimporterPlugin())
		{
			$this -> addElement('radio', 'socialconnect_invitefriends', array(
				'label' => 'Invite Friends',
				'description' => 'Direct to Contact Importer to invite friends if sign up process is successful with corresponding provider.',
				'multiOptions' => array(
					'1' => 'Yes',
					'0' => 'No'
				),
				'value' => $settings->getSetting('socialconnect.invitefriends', 1),
			));
		}

		$this -> addElement('radio', 'socialconnect_standardsignup', array(
			'label' => 'SignUp Mode',
			//'description' => 'If you choose "Use Quick Signup Process", only "Account Information" step will be shown.',
			'multiOptions' => array(
				'1' => 'Use Standard Signup Process',
				'0' => 'Use Quick Signup Process'
			),
			'value' => $settings->getSetting('socialconnect.standardsignup', 1),
		));
		
		$this -> addElement('dummy', 'quick_signup_heading', array(
			'label' => 'Quick Sign-Up Settings'
		));
		
		$this -> addElement('radio', 'socialconnect_inputpassword', array(
			'label' => 'Input Password',
			'description' => 'Allow user to input their own password?',
			'multiOptions' => array(
				'1' => 'Yes',
				'0' => 'No'
			),
			'value' => $settings->getSetting('socialconnect.inputpassword', 0),
		));
		
		$this -> addElement('radio', 'socialconnect_autoapprove', array(
			'label' => 'Auto Approve',
			'description' => 'Allow Social connected account to be approved automatically?',
			'multiOptions' => array(
				'1' => 'Yes',
				'0' => 'No'
			),
			'value' => $settings->getSetting('socialconnect.autoapprove', 1),
		));
		
		// Init submit
		$this -> addElement('Button', 'submit', array(
			'label' => 'Save Changes',
			'type' => 'submit',
			'ignore' => true,
		));
		
	}
}
