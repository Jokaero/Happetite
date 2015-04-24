<?php
/**
 * @package          Social Connect
 * @subpackage       Social Connect For phpfox
 * @author           namnv
 * @since            Oct, 2010
 */

class M2b_Adapter_Se4
{
	function getProfile( $user)
	{
		$result = $this -> linkedinProfile($user);		
		return $result;
	}

	function linkedinProfile($user)
	{
		
		$bx = array();

		$email = (string)$user->{'email-address'};

		if (!$email)
		{
			exit("OpenID provider did not return enought information to authenticate who you are!. Please try to connect by others.");
		}

		$bx['email'] = $email;
		$bx['first_name'] =(string)$user->{'first-name'};
		$bx['last_name'] = (string)$user->{'last-name'};
		$bx['displayname'] = (string)$user['formatted-name'];
		$bx['username'] = (string)$user['formatted-name'];

		$bx['location'] = (string)$user->{'location'}->{'name'};
		$bx['service'] = 'linkedin';
		$birthdate = null;
		$year = (string)$connections->{'date-of-birth'}->year;
		$month = (string)$connections->{'date-of-birth'}->month;
		$day= (string)$connections->{'date-of-birth'}->day;
		if (!empty($year) && !empty($month) && !empty($day))
				{
					$birthdate = date("Y-m-d", strtotime($year.'-'.$month.'-'.$day));
				}	
		
		$bx['birthdate'] = $birthdate;
		$bx['gender'] = null;
		$bx['timezone'] = (string)$user->{'current-status-timestamp'};
		$bx['language'] = (string)$user->{'languages'}->{'name'};
		$bx['identity'] = $bx['id'] = $email;

		//echo '<pre>';var_dump($user,$bx);echo '</pre>';exit;
		
		return $bx;
	}

	

}
