<?php
class Socialbridge_Form_Admin_Twsettings extends Engine_Form
{
  public function init()
  {
    $this
      ->setTitle('Twitter Api Settings')
     ->setDescription('SOCIALBRIDGE_ADMIN_SETTINGS_TWITTER_DESCRIPTION');
     
	$description = $this->getTranslator()->translate('SOCIALBRIDGE_ADMIN_SETTINGS_TWITTER_DESCRIPTION');
    $settings = Engine_Api::_()->getApi('settings', 'core');
	if( $settings->getSetting('user.support.links', 0) == 1 ) {
	$moreinfo = $this->getTranslator()->translate( 
        '<br>More Info: <a href="http://support.socialengine.com/questions/204/Admin-Panel-Settings-Twitter-Integration" target="_blank"> KB Article</a>');
	} else {
	$moreinfo = $this->getTranslator()->translate( 
        '');
	}
    $description = vsprintf($description.$moreinfo, array(
      'https://dev.twitter.com/apps/new',
    ));

	$this->setDescription($description);


    $this->loadDefaultDecorators();
    $this->getDecorator('Description')->setOption('escape', false);
	 
    $this->addElement('Text', 'consumer_key', array(
          'label' => 'Twitter App Consumer Key',
          'size'=>80,
          'style'=>'width:400px'
    ));
     $this->addElement('Text', 'consumer_secret', array(
          'label' => 'Twitter App Consumer Secret',
          'size'=>80,
          'style'=>'width:400px'
    ));
	
	$this -> addElement('Text', 'max_invite_day', array(
			'label' => 'Maximum Allowed Invitations Per Day',
			'description' => 'The maximum number of messages will be sent per day for 1 account (Enter a number between 1 and 250)<br>More Info: <a href="https://support.twitter.com/articles/15364-about-twitter-limits-update-api-dm-and-following" target="_blank"> About Twitter Limits</a>',
			'validators' => array(new Zend_Validate_Between(1, 250))
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