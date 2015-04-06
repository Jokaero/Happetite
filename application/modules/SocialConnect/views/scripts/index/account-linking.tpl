<div class="headline">
  <h2>
    <?php echo $this->translate('My Settings');?>
  </h2>
  <div class="tabs">
    <?php
      // Render the menu
      echo $this->navigation()
        ->menu()
        ->setContainer($this->navigation)
        ->render();
    ?>
  </div>
</div>
<h3><?php echo $this->translate("Your Accounts")?></h3>
<p class="account_description"><?php echo $this->translate("ACCOUNT_LINK_DESCRIPTION")?></p>
<div style="padding-top: 10px">
<?php $linkservices = array();
foreach($this->services as $service):?>
	<?php if(Engine_Api::_() -> getApi('Core', 'SocialConnect')->getAccountLinked($this->user_id, $service->name)):?>
	<div class="socialconnect_account"> 
			<?php $account = Engine_Api::_() -> getApi('Core', 'SocialConnect')->getAccountLinked($this->user_id, $service->name);
				$profile = json_decode($account->profile);
			if($profile->picture):?>
				<img src="<?php echo $profile->picture;?>" class="ynsc_quick"/>
			<?php elseif($profile->photo_url):?>
				<img src="<?php echo $profile->photo_url;?>" class="ynsc_quick"/>
			<?php else:?>
				<img src="./application/modules/SocialConnect/externals/images/no_image_icon.png" class="ynsc_quick"/>
			<?php endif;?>
			<span>
				<div>
					<strong>
					<?php if($profile->name)
						echo $profile->name;
					else
						echo $profile->username;
					?>
					</strong>
				</div>
				<div>
					<a class="smoothbox" href="<?php echo $this->url(array('account_id' => $account->account_id), "socialconnect_delete_account")?>"> <?php echo $this->translate("Disconnect")?></a>
				</div>
			</span>
			<div style="margin-top: -10px">
			<img src="./application/modules/SocialConnect/externals/images/<?php echo $service->name ?>.png" class="ynsc_logo"/>
			</div>
		</div>
	<?php else:
		$linkservices[] = $service; 
	endif;?>
<?php endforeach;?>
<?php foreach ($linkservices as $linkservice):?>
<div class="socialconnect_services"> 
	<img src="./application/modules/SocialConnect/externals/images/<?php echo $linkservice->name ?>.png" class="ynsc_quick"/>
	<span>
		<a href="javascript:;" onclick="javascript: sopopup('<?php echo $linkservice->getHref(); ?>')">
			<?php echo $this->translate("Connect to %s", $linkservice->title)?>
		</a>
	</span>
</div>
<?php endforeach;?>
</div>