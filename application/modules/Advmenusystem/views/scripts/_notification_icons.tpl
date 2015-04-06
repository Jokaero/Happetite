<style type="text/css">
	.ynadvmenu_mini_wrapper:hover div{
	    color:#<?php echo $this -> hover_color;?> !important;
	}
</style>
<div id="ynadvmenu_MessagesUpdates" class="ynadvmenu_mini_wrapper" title="Messages">
	<a style:  href="javascript:void(0);" <?php if($this -> design_type == 'icon') :?> class="ynadvmenu_NotifiIcon" <?php endif;?> id="ynadvmenu_messages" >
		<?php if($this -> design_type == 'title') :?>
			<div id='title-mini-message' class="title-mini" style="<?php if($this->title_color) echo "color:#{$this->title_color}"?>">Messages</div>
		<?php endif;?>
		<span id="ynadvmenu_MessageIconCount" class="ynadvmenu_NotifiIconWrapper" style="display:none"><?php if($this -> design_type == 'icon'):?><span id="ynadvmenu_MessageCount"><?php endif;?></span></span>
	</a>
	<div class="ynadvmenuMini_dropdownbox" id="ynadvmenu_messageUpdates" style="display: none;">
		<div class="ynadvmenu_dropdownHeader">
			<div class="ynadvmenu_dropdownArrow"></div>				  
		</div>
		<div class="ynadvmenu_dropdownTitle">
			<h3><?php echo $this->translate("Messages") ?> </h3>				
			<a href="<?php echo $this->url(array('action'=>'compose'),'messages_general', true)?>"><?php echo $this->translate("Send a New Message") ?></a>
		</div>
		<div class="ynadvmenu_dropdownContent" id="ynadvmenu_messages_content">
			<!-- Ajax get and out contetn to here -->
		</div>				
		<div class="ynadvmenu_dropdownFooter">
			<a class="ynadvmenu_seeMore" href="<?php echo $this->url(array('action'=>'inbox'),'messages_general', true) ?>">
				<span><?php echo $this->translate("See All Messages") ?> </span>
			</a>				
		</div>				
	</div>
</div>

<div id="ynadvmenu_FriendsRequestUpdates" class="ynadvmenu_mini_wrapper" title="Friend Requests">
	<a href="javascript:void(0);" <?php if($this -> design_type == 'icon') :?> class="ynadvmenu_NotifiIcon" <?php endif;?> id = "ynadvmenu_friends">
		<?php if($this -> design_type == 'title') :?>
			<div id='title-mini-friend' class="title-mini" style="<?php if($this->title_color) echo "color:#{$this->title_color}" ?>">Friend Requests</div>
		<?php endif;?>
		<span id="ynadvmenu_FriendIconCount" class="ynadvmenu_NotifiIconWrapper" style="display:none"><?php if($this -> design_type == 'icon'):?><span id="ynadvmenu_FriendCount"></span><?php endif;?></span>
	</a>
	<div class="ynadvmenuMini_dropdownbox" id="ynadvmenu_friendUpdates" style="display: none;">
		<div class="ynadvmenu_dropdownHeader">
			<div class="ynadvmenu_dropdownArrow"></div>				  
		</div>
		<div class="ynadvmenu_dropdownTitle">
			<h3><?php echo $this->translate("Friend Requests") ?> </h3>				
			<a href="<?php echo $this->url(array(),'user_general', true)?>"><?php echo $this->translate("Find Friends") ?></a>
		</div>
		<div class="ynadvmenu_dropdownContent" id="ynadvmenu_friends_content">
			<!-- Ajax get and out contetn to here -->
		</div>				
		<div class="ynadvmenu_dropdownFooter">
			<a class="ynadvmenu_seeMore" href="<?php echo $this->url(array(),'advmenusystem_friend_requests')?>">
				<span><?php echo $this->translate("See All Friend Requests") ?> </span>
			</a>				
		</div>				
	</div>
</div>

<div id="ynadvmenu_NotificationsUpdates"  class="ynadvmenu_mini_wrapper" title="Notifications">
	<a href="javascript:void(0);" <?php if($this -> design_type == 'icon') :?> class="ynadvmenu_NotifiIcon" <?php endif;?> id = "ynadvmenu_updates">
		<?php if($this -> design_type == 'title') :?>
			<div id='title-mini-notification' class="title-mini" style="<?php if($this->title_color) echo "color:#{$this->title_color}" ?>">Notifications</div>
		<?php endif;?>
		<span id="ynadvmenu_NotifyIconCount" class="ynadvmenu_NotifiIconWrapper"><?php if($this -> design_type == 'icon'):?><span id="ynadvmenu_NotifyCount"></span><?php endif;?></span>
	</a>
	<div class="ynadvmenuMini_dropdownbox" id="ynadvmenu_notificationUpdates" style="display: none;">
		<div class="ynadvmenu_dropdownHeader">
			<div class="ynadvmenu_dropdownArrow"></div>				  
		</div>
		<div class="ynadvmenu_dropdownTitle">
			<h3><?php echo $this->translate("Notifications") ?> </h3>									
		</div>
		<div class="ynadvmenu_dropdownContent" id="ynadvmenu_updates_content">
			<!-- Ajax get and out contetn to here -->
		</div>				
		<div class="ynadvmenu_dropdownFooter">
			<a class="ynadvmenu_seeMore" href="<?php echo $this->url(array(),'advmenusystem_notifications', true)?>">
				<span><?php echo $this->translate("See All Notifications") ?> </span>
			</a>				
		</div>				
	</div>
</div>			