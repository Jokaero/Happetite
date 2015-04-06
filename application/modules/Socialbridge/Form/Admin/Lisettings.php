<?php
class Socialbridge_Form_Admin_Lisettings extends Engine_Form
{
  public function init()
  {
    $this
      ->setTitle('Linkedin Api Settings')
     ->setDescription('SOCIALBRIDGE_ADMIN_SETTINGS_LINKEDIN_DESCRIPTION');
     
	$description = $this->getTranslator()->translate('SOCIALBRIDGE_ADMIN_SETTINGS_LINKEDIN_DESCRIPTION');
    $settings = Engine_Api::_()->getApi('settings', 'core');
    $description = vsprintf($description, array(
      'https://www.linkedin.com/secure/developer',
    ));
	$this->setDescription($description);


    $this->loadDefaultDecorators();
    $this->getDecorator('Description')->setOption('escape', false);
	 
    $this->addElement('Text', 'key', array(
          'label' => 'Linkedin Key',
          'size'=>80,
          'style'=>'width:400px'
    ));
     $this->addElement('Text', 'secret', array(
          'label' => 'Linkedin Secret',
          'size'=>80,
          'style'=>'width:400px'
    ));
	
	$this -> addElement('Text', 'max_invite_day', array(
			'label' => 'Maximum Allowed Invitations Per Day',
			'description' => 'The maximum number of messages will be sent per day for 1 account (Enter a number between 1 and 10)<br>More Info: <a href="http://developer.linkedin.com/documents/throttle-limits" target="_blank"> Throttle Limits</a>',
			'validators' => array(new Zend_Validate_Between(1, 10))
		));
	$this->max_invite_day->loadDefaultDecorators();
    $this->max_invite_day->getDecorator('Description')->setOption('escape', false);
    // Add submit button
    $this->addElement('Button', 'submit', array(
          'label' => 'Save Changes',
          'type' => 'submit',
          'ignore' => true
    ));
  }
}