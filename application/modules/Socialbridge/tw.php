<?php
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
$is_from_socialpublisher = 0;
if (!empty($_GET['is_from_socialpublisher'])) {
    $is_from_socialpublisher = 1;
}
$returnURL = $_GET['callbackUrl'];
$obj = Engine_Api::_()->socialbridge()->getInstance("twitter");
// authorize
if(!isset($_GET['oauth_token']))
{
	$url = curPageURL();
	$obj->authorizeRequest(array('url' => $url));
}
else
{
	$params['oauth_token'] = $_GET['oauth_token'];
	$params['oauth_verifier'] = $_GET['oauth_verifier'];
    $response = $obj->getAuthAccessToken($params);
	if($response && isset($response['oauth_token']))
	{
	    $_SESSION['socialbridge_session']['twitter']['access_token'] = $response['oauth_token'];
	    $_SESSION['socialbridge_session']['twitter']['secret_token'] = $response['oauth_token_secret'];
	    $datatopost['user'] = $_SESSION['socialbridge_session']['twitter']['owner_id'] = $response['user_id'];
	    $params = http_build_query($datatopost)."&oauth_tok3n=".$response['oauth_token']."&oauth_token_secret=".$response['oauth_token_secret'];
		$obj->saveToken();
	}
	else 
	{
		$url = curPageURL();
		$obj->authorizeRequest(array('url' => $url));
	}

?>
<?php if (!$is_from_socialpublisher):?>
<form method="post" id="connect_form" action="<?php echo $returnURL."?".$params?>">
	<input type="hidden" name="task" value="get_contacts" />
</form>
<script>document.getElementById('connect_form').submit();</script>
<script>self.close();</script>
<?php endif; ?>
<?php
	echo "<script>opener.parent.frames['TB_iframeContent'].document.location.reload();</script>";
	echo "<script>self.close();</script>";
?>
<?php
}
?>