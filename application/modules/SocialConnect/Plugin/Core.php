<?php

class SocialConnect_Plugin_Core
{
	public function onUserDeleteBefore($event)
	{
		$payload = $event -> getPayload();
		if ($payload instanceof User_Model_User)
		{
			Engine_Api::_() -> getApi('Core', 'SocialConnect') -> dropAccount($payload -> getIdentity());
		}
	}

	public function onUserCreateAfter($event)
	{
		$payload = $event -> getPayload();
		if ($payload instanceof User_Model_User)
		{
			// using social connect to sign up
			if (isset($_SESSION['quick_signup']))
			{
				if (isset($_SESSION['main_photo_file_id']));
				{
					$payload->photo_id = $_SESSION['main_photo_file_id'];
					$payload->save();
				}
				$settings = Engine_Api::_()->getApi('settings', 'core');
				if(!$settings->getSetting('socialconnect.standardsignup', 1))
				{
					if($settings->getSetting('socialconnect.autoapprove', 1))
					{
						$payload->approved = true;
						if(isset($_SESSION['quick_signup']['noVerifyEmail']) && $_SESSION['quick_signup']['noVerifyEmail'])
						{
							$payload->enabled = true;
							$payload->verified = true;
						}
						$payload->save();
					}
				}
				
				$identity = $_SESSION['quick_signup']['identity'];
				$service = $_SESSION['quick_signup']['service'];
				$data =Zend_Json::decode($_SESSION['quick_signup']['data']);
				Engine_Api::_() -> getApi('Core', 'SocialConnect') -> createAccount($payload -> getIdentity(), $identity, $service, $data);
				
				if(Engine_Api::_()->getApi('settings', 'core')->getSetting('socialconnect.invitefriends', 1)
				&& Engine_Api::_() -> getApi('Core', 'SocialConnect')->checkContactimporterPlugin())
				{
					//check enable Invite Friends when signup
					if(in_array($service, array('facebook','twitter','linkedin','live','google','yahoo','myspace')))
					{
						$user_signupTB = Engine_Api::_()->getDbtable('signup', 'user');
						$select = $user_signupTB->select()->where('class = "Contactimporter_Plugin_Signup_Invite"');
						$invite_friend = $user_signupTB->fetchRow($select);
						if($invite_friend && !$invite_friend->enable)
						{
							if($service == 'google')
								$service = 'gmail';
							$_SESSION['social_connect_invite'] = $service;
						}
					}
				}
			}
			unset($_SESSION['quick_signup']);
			unset($_SESSION['SocialConnect_SignUp_Data']);
			unset($_SESSION['main_photo_file_id']);
		}

	}

}
