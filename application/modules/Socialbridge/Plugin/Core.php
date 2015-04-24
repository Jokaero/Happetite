<?php
class Socialbridge_Plugin_Core extends Core_Model_Abstract
{
  public function onUserLogoutBefore($event)
  {
    $payload = $event->getPayload();

    if( !($payload instanceof User_Model_User) ) {
      return;
    }
	if(!empty($_SESSION['socialbridge_session']) ) 
	{
		unset($_SESSION['socialbridge_session']);
	}
  }
}