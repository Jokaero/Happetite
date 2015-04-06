<?php
$scope = $_REQUEST['scope'];
if (isset($_REQUEST['code']) && isset($_REQUEST['state']) && $_REQUEST['code'])
{
	$obj = Engine_Api::_()->socialbridge()->getInstance("facebook");
	$obj->saveToken();
	$token = $obj->_accessToken;
	$_SESSION['socialbridge_session']['facebook']['access_token'] = $token;
	$_SESSION['socialbridge_session']['facebook']['access_token_time'] = time();
	if (!$token)
	{
		$params['scope'] = $scope;
		$url = $obj->getLoginUrl($params);
		header('location:' . $url);
		$html = "<a href='" . $url . "'>Click here to connect facebook</a>";
		echo $html;
		exit ;
	}

	try
	{
		$me = $obj->_me;
		if (!$me)
		{
			$params['scope'] = $scope;
			$url = $obj->getLoginUrl($params);
			header('location:' . $url);
			echo "Cannot connect to facebook .";
			exit ;
		}
	}
	catch(Exception $e)
	{
		$params['scope'] = $scope;
		$url = $obj->getLoginUrl($params);
		header('location:' . $url);
		echo "Cannot connect to facebook .";
		exit ;
	}

}
elseif(isset($_REQUEST['error']))
{
	$callbackUrl = $_REQUEST['callbackUrl'];
	header('location:' . $callbackUrl);	
}
else
{
	$obj = Engine_Api::_()->socialbridge()->getInstance("facebook");
	$params['scope'] = $scope;
    $sRedirectUrl = $obj->getLoginUrl($params);
    header('Location: ' . $sRedirectUrl);
    exit;
}
$callbackUrl = $_REQUEST['callbackUrl'];
$is_from_socialpublisher = 0;
if (!empty($_REQUEST['is_from_socialpublisher'])) {
    $is_from_socialpublisher = 1;
}
?>
<?php if (!$is_from_socialpublisher): ?>
<form method="post" id="connect_form" action="<?php echo $callbackUrl?>">
<input type="hidden" name="task" value="get_contacts" />
</form>
<script> document.getElementById('connect_form').submit(); </script>
<script>self.close();</script>
<?php endif; ?>
<?php
	echo "<script>opener.parent.frames['TB_iframeContent'].document.location.reload();</script>";
	echo "<script>self.close();</script>";
?>
