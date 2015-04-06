<div class="socialbridge_services">
	<h3><?php echo $this->translate("Your contacts are safe with us!");?></h3>
	<p><?php echo $this->translate("We'll import your address book to suggest connections and help you manage your contacts. And we won't store your password or email anyone without your permission.")?></p>
	<br/>
<?php $serviceNames = array('facebook','twitter','linkedin');
	$viewer = Engine_Api::_()->user()->getViewer();
	$viewer_id = $viewer -> getIdentity();
	?>

<?php foreach($serviceNames as $serviceName):?>
<?php
	$apiSetting = Engine_Api::_() -> getDbtable('apisettings', 'socialbridge');
	$select = $apiSetting->select()->where('api_name = ?', $serviceName);
	$provider = $apiSetting->fetchRow($select);
	if(!$provider)
	{
		continue;
	}
	$obj = Socialbridge_Api_Core::getInstance($serviceName);
	$me = null;
	$values = array('service' => $serviceName,'user_id' => $viewer_id);
	$token = $obj -> getToken($values);
	switch ($serviceName)
	{
		case 'facebook':
			if(!empty($_SESSION['socialbridge_session'][$serviceName]['access_token'])) 
			{
			    try 
			    {
				    $me = $obj->getOwnerInfo(array('access_token' => $_SESSION['socialbridge_session'][$serviceName]['access_token']));
			    }
			    catch(Exception $e) {
                    $me = null;
			    }
			}
			else if($token)
			{
				try 
				{
					$_SESSION['socialbridge_session'][$serviceName]['access_token'] = $token->access_token;
				    $me = $obj->getOwnerInfo(array('access_token' => $token->access_token));
			    }
			    catch(Exception $e) {
                    $me = null;
			    }
			}
			else 
			{
				$url = $obj->getConnectUrl() .
					'&scope=user_photos'.
					'&' . http_build_query(array(
					'callbackUrl' => $this->callbackUrl.'?service='.$serviceName
				));
			}
			break;
		case 'twitter':
			//get twitter token
            if (!empty($_SESSION['socialbridge_session'][$serviceName]['access_token'])
                && !empty($_SESSION['socialbridge_session'][$serviceName]['secret_token'])
                && !empty($_SESSION['socialbridge_session'][$serviceName]['owner_id'])) {
                    try {
                        $me = $obj->getOwnerInfo(array(
                                'access_token' => $_SESSION['socialbridge_session'][$serviceName]['access_token'],
                                'secret_token' => $_SESSION['socialbridge_session'][$serviceName]['secret_token']
                                ));
                    } catch(Exception $e) {
                        $me = null;
                    }
            }
			else if($token)
			{
				try {
					$_SESSION['socialbridge_session'][$serviceName]['access_token'] = $token->access_token;
					$_SESSION['socialbridge_session'][$serviceName]['secret_token'] = $token->secret_token;
					$_SESSION['socialbridge_session'][$serviceName]['owner_id'] = $token->uid;
				    $me = $obj->getOwnerInfo(array(
                                'access_token' => $token->access_token,
                                'secret_token' => $token->secret_token,
                                'user_id' => $token->uid
                                ));
			    }
			    catch(Exception $e) {
                    $me = null;
			    }
			}
            else {
                $url = $obj->getConnectUrl() .
                '&' . http_build_query(array(
                        'callbackUrl' => $this->callbackUrl.'?service='.$serviceName
                ));
            }
			break;
		case 'linkedin':
			if(isset($_SESSION['socialbridge_session'][$serviceName]['secret_token'])
				&& $_SESSION['socialbridge_session'][$serviceName]['secret_token'] != "")
			{
				$me = $obj->getOwnerInfo($_SESSION['socialbridge_session'][$serviceName]);
			}
			else if($token)
			{
				try 
				{
					$_SESSION['socialbridge_session'][$serviceName]['access_token'] = $token->access_token;
					$_SESSION['socialbridge_session'][$serviceName]['secret_token'] = $token->secret_token;
				    $me = $obj->getOwnerInfo(array(
                                'access_token' => $token->access_token,
                                'secret_token' => $token->secret_token
                                ));
			    }
			    catch(Exception $e) {
                    $me = null;
			    }
			}
			else {
				$url = $obj->getConnectUrl() .
					'&scope=r_basicprofile,rw_nus'.
					'&' . http_build_query(array(
					'callbackUrl' => $this->callbackUrl.'?service='.$serviceName
				));
			}
			break;
	}

?>
<div class="socialbridge_service_wrapper">
        <div>
                <img class='socialbridge_service_image' src="<?php echo $this->baseUrl();?>/application/modules/Socialbridge/externals/images/service/<?php echo $serviceName; ?>.jpg" />
        </div>
        <?php if(!isset($me)):?>
        	<div style='text-align:center'>
					<a href="<?php echo $url?>" title="<?php echo $this->translate('Connect to %s',ucfirst($serviceName));?>">
		            	<?php echo $this->translate('Connect to %s',ucfirst($serviceName));?>
		            </a>
	        </div>
       <?php else:?>
       		<div class="socialbridge_connect">
       		    <?php if(isset($me['picture'])) $me['photo_url'] = $me['picture'];
       		    $image_url = !empty($me['photo_url'])?$me['photo_url']:$this->baseUrl() . '/application/modules/Socialbridge/externals/images/default_user.jpg'?>
				    <img src="<?php echo $image_url?>" alt="<?php echo $me['username']?>" align="left" height="32" width="32">
        		<p>	<?php echo $this->translate("Connected as");?> <strong><?php echo $me['displayname']?></strong></p>
        		<?php $disconnect_url = $this->disconnect .'/service/'.$serviceName ?>
        		<p> <a href="javascript:void(0);" onclick="return confirmDisconnect('<?php echo $disconnect_url ?>');"><?php echo $this->translate('Click here')?></a><?php echo $this->translate(' to disconnect.')?></p>
	        </div>
       <?php endif;?>
</div>

<?php endforeach; ?>

<?php if ($this->iframeurl): ?>
<div style="display:none">
    <iframe width="0" height="0" border="none" src="<?php echo base64_decode($this->iframeurl); ?>"></iframe>
</div>
<?php endif; ?>
</div>
<script type="text/javascript">

	function confirmDisconnect(link){
		console.log(link);
		if(confirm('<?php echo $this->translate("Are you sure you want to disconnect this account?");?>'))
		{
			window.location = link;
		}
	}
     </script>
