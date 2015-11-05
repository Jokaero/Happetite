<?php
ini_set('display_startup_errors', 1);
ini_set('display_errors', 1);

if (!function_exists('curPageURL'))
{
	function curPageURL()
	{
		$pageURL = 'http';
		if (isset($_SERVER["HTTPS"]) && $_SERVER["HTTPS"] == "on")
		{
			$pageURL .= "s";
		}
		$pageURL .= "://";
		if ($_SERVER["SERVER_PORT"] != "80")
		{
			$pageURL .= $_SERVER["SERVER_NAME"] . ":" . $_SERVER["SERVER_PORT"] . $_SERVER["REQUEST_URI"];
		}
		else
		{
			$pageURL .= $_SERVER["SERVER_NAME"] . $_SERVER["REQUEST_URI"];
		}
		return $pageURL;
	}

}

if (!function_exists('get_emails'))
{

	function get_emails($str)
	{
		$emails = array();
		preg_match_all("/\b\w+\@\w+[\.\w+]+\b/", $str, $output);
		foreach ($output[0] as $email)
		{
			array_push($emails, strtolower($email));
		}
		if (count($emails) >= 1)
		{
			return $emails;
		}
		else
			return false;
	}
}

if (!class_exists('YNSFacebook', false))
{
	require_once SOCIALBRIDGE_LIBS_PATH . '/facebook.php';
}

$db = Zend_Db_Table::getDefaultAdapter();

$sql_session = 'SELECT * FROM ' . 'engine4_socialbridge_apisettings WHERE api_name = "facebook" limit 1';
$seSection = $db -> fetchAll($sql_session);

if (isset($seSection[0]['api_params']) && $seSection[0]['api_params'] != "")
{
	$_tmp = unserialize($seSection[0]['api_params']);

	$facebook = new YNSFacebook( array(
		'appId' => $_tmp['key'],
		'secret' => $_tmp['secret'],
	));

	if (isset($_REQUEST['code']))
	{
		$token = $facebook -> getUserAccessToken();
		$facebook -> setAccessToken($token);
		$_SESSION['ynfb_access_uid'] = $facebook -> getUser();
		$_SESSION['ynfb_access_token'] = $token;
		$_SESSION['ynfb_access_token_time'] = time();

		$token = $facebook -> getAccessToken();

		if (!$token)
		{
			$params['scope'] = 'publish_stream, xmpp_login';
			$url = $facebook -> getLoginUrl($params);
			header('location:' . $url);
			$html = "<a href='" . $url . "'>Click here to connect facebook</a>";
			echo $html;
			exit ;
		}

		try
		{
			$me = $facebook -> api('/me');
			if (!$me)
			{
				$params['scope'] = 'publish_stream, xmpp_login';
				$url = $facebook -> getLoginUrl($params);
				header('location:' . $url);
				echo "Cannot connect to facebook .";
				exit ;
			}
		}
		catch(Exception $e)
		{
			$params['scope'] = 'publish_stream';
			$url = $facebook -> getLoginUrl($params);
			header('location:' . $url);
			echo "Cannot connect to facebook .";
			exit ;
		}
	}
	else
	{
		$params['scope'] = 'publish_stream,offline_access,email, xmpp_login';
		$sRedirectUrl = $facebook -> getLoginUrl($params);
		header('Location: ' . $sRedirectUrl);
		exit ;
	}
	$view = Zend_Registry::get('Zend_View');
	$siteUrl =  $view->url(array(),'default'). 'socialbridge/get-contacts';
	echo "<script> opener.parent.location.href = '" . $siteUrl . "';</script>";
	echo "<script>self.close();</script>";

}
else
{
	echo "Invalid Facebook Api Settings.<br/>";
	echo "<a href='javascript:void(0)' onclick='self.close();'>Close</a>";
}
