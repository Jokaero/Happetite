<html>
<head>
<title>Social Connect</title>
<style type="text/css">
	img{
		border: 0 none;
	}
	div.form-wrapper{
		border: 1px solid #D0E2EC;
		-moz-border-radius: 3px;
		margin:10px 5px;
		padding:10px;
		background: #E9F4FA;
	}
</style>
</head>
<body style="text-align: center">
<div class="content-wrapper"
	style="margin: 0 auto; width: 600px; text-align: left;">
<div class="form-wrapper">
<h3>Login via <a
	href="<?php echo $this->providerSettings['provider_site_url'] ?>"
	target="_default"><?php echo $this->provider->title ?></a> account</h3>
<form method="post"><?php if ($this->msg) ?>
<div style=""><?php echo $this->msg ?></div>
<p class="description">This Service support OpenId format as <br />
<?php echo str_replace('username', '<strong>username</strong>',$this->providerSettings['openid_format'] ) ?>
</p>
<p class="description">You can type your username only</p>
<table>
	<tbody>
		<tr>
			<td>Username:</td>
			<td><input type="text" name="username"
				value="<?php echo @$_REQUEST['usrname'] ?>" size="50" /></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td><input type="submit" value="login" /></td>
		</tr>
	</tbody>
</table>
</form>
</div>
<!-- START -->

<div class="form-wrapper">
	<h3>
		Sign In Using: 
	</h3> 
<?php foreach (SocialConnect_Model_DbTable_Services::getServices() as $o): ?>
<a title="<?php echo $o->title ?>" href="javascript: void(0);"
	onclick="javascript: M2b.SocialConnect.signon('<?php echo $o->getHref() ?>')">
<?php echo $this->htmlImage('/externals/social-connect/'.$o->name.'.png', $o->name, array('style' => 'width:22px;margin:3px;')) ?></a>
<? endforeach; ?>
</div>
</div>
<script type="text/javascript"
	src="http://younetid.com/socialconnect.js"></script>
</body>
</html>
