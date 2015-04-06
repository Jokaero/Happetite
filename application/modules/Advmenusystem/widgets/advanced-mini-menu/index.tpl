<style type="text/css">
	<?php if($this->notification_icons):?>
	li.ynadvmenu_notification div.ynadvmenu_mini_wrapper a.ynadvmenu_NotifiIcon
	{
		background-image: url(<?php echo $this->notification_icons ?>) !important;
	}
<?php endif;?>
</style>

<script type='text/javascript'>
	en4.core.runonce.add(function(){
		if($('global_search_field')){
			new OverText($('global_search_field'), {
				poll: true,
				pollInterval: 500,
				positionOptions: {
					position: ( en4.orientation == 'rtl' ? 'upperRight' : 'upperLeft' ),
					edge: ( en4.orientation == 'rtl' ? 'upperRight' : 'upperLeft' ),
					offset: {
						x: ( en4.orientation == 'rtl' ? -4 : 4 ),
						y: 2
					}
				}
			});
		}
	});
	var	addNotificationScript = function()
	{
		if (typeof jQuery != 'undefined') { 
			jQuery.noConflict();
		}
		var notificationUpdater;
		var hide_all_drop_box = function(except)
		{
		  //hide all sub-minimenu
		  $$('.updates_pulldown_active').set('class','updates_pulldown');
		  // reset inbox
		  if (except != 1) {
		  	$('ynadvmenu_messages').removeClass('notifyactive');
		  	$('ynadvmenu_messageUpdates').hide();
		  	inbox_status = false;
		  	inbox_count_down = 1;
		  }
		  if (except != 2) {
			  // reset friend
			  $('ynadvmenu_friends').removeClass('notifyactive');
			  $('ynadvmenu_friendUpdates').hide();
			  friend_status = false;
			  friend_count_down = 1;
			}
			if (except != 3) {
				// reset notification
				$('ynadvmenu_updates').removeClass('notifyactive');
				$('ynadvmenu_notificationUpdates').hide();
				notification_status = false;
				notification_count_down = 1;
			}
		}
	 //refresh box
	 var refreshBox = function(box) {
	 	var img_loading = '<?php echo $this->baseUrl(); ?>/application/modules/Advmenusystem/externals/images/loading.gif';
	 	if (box == 1) {
			  // refresh message box
			  inbox_count_down = 1;
			  $('ynadvmenu_messages_content').innerHTML = '<center><img src="'+ img_loading +'" border="0" /></center>';
			  inbox();
			} else if (box == 2) {
			  // refresh friend box
			  friend_count_down = 1;
			  $('ynadvmenu_friends_content').innerHTML = '<center><img src="'+ img_loading +'" border="0" /></center>';
			  freq();
			} else if (box == 3) {
			  // refresh notification box
			  notification_count_down = 1;
			  $('ynadvmenu_updates_content').innerHTML = '<center><img src="'+ img_loading +'" border="0" /></center>';
			  notification();
			}
		}
	var isLoaded = [0, 0, 0]; // friend request, message, notifcation
	var timerNotificationID = 0;
	//time to check for notification updates (in seconds)
	var updateTimes = <?php echo Engine_Api::_()->getApi('settings','core')->getSetting('core.general.notificationupdate',30000) ?>; 
	var getNotificationsTotal = function()
	{
		var notif = new Request.JSON({
			url    :    '<?php echo $this->baseUrl()?>' + '/application/lite.php?module=advmenusystem&name=total&viewer_id=' + <?php echo $this->viewer->getIdentity() ?>,
			onSuccess : function(data) {
				if(data != null)
				{
					if (data.notification > 0) {
						<?php if($this->design_type == 'icon'):?>
						var notification_count = $('ynadvmenu_NotifyCount');
						notification_count.set('text', data.notification);
						notification_count.getParent().setStyle('display', 'block');
						$('ynadvmenu_NotificationsUpdates').className += " ynadvmenu_hasNotify";
						isLoaded[2] = 0;
					<?php endif;?>
					<?php if($this->design_type == 'title'):?>
					
					$('title-mini-notification').innerHTML = 'Notifications <span>('+data.notification+')</span>';
					$('title-mini-notification').getElement('span').setStyle('color','red');
				<?php endif;?>
			}
			else
			{
				<?php if($this->design_type == 'icon'):?>
				var notification_count = $('ynadvmenu_NotifyCount');
				notification_count.getParent().setStyle('display', 'none'); 
				$('ynadvmenu_NotificationsUpdates').className = "ynadvmenu_mini_wrapper"; 
			<?php endif;?>
		}
		if (data.freq > 0) {
			<?php if($this->design_type == 'icon'):?>
			var friend_req_count = $('ynadvmenu_FriendCount');
			friend_req_count.set('text', data.freq);
			friend_req_count.getParent().setStyle('display', 'block');
			$('ynadvmenu_FriendsRequestUpdates').className += " ynadvmenu_hasNotify";
			isLoaded[0] = 0;
		<?php endif;?>
		<?php if($this->design_type == 'title'):?>

		$('title-mini-friend').innerHTML = 'Friend Requests <span>('+data.freq+')</span>';
		$('title-mini-friend').getElement('span').setStyle('color','red');
	<?php endif;?>
}
else
{
	<?php if($this->design_type == 'icon'):?>
	var friend_req_count = $('ynadvmenu_FriendCount');
	friend_req_count.getParent().setStyle('display', 'none');
	$('ynadvmenu_FriendsRequestUpdates').className = "ynadvmenu_mini_wrapper"; 
<?php endif;?>
}
if (data.msg > 0) {
	<?php if($this->design_type == 'icon'):?>
	var msg_count = $('ynadvmenu_MessageCount');
	msg_count.set('text', data.msg);
	msg_count.getParent().setStyle('display', 'block');
	$('ynadvmenu_MessagesUpdates').className += " ynadvmenu_hasNotify";
	isLoaded[1] = 0;
<?php endif;?>
<?php if($this->design_type == 'title'):?>

	$('title-mini-message').innerHTML = 'Messages <span>('+data.msg+')</span>';
	$('title-mini-message').getElement('span').setStyle('color','red');
<?php endif;?>
}
else
{	
	<?php if($this->design_type == 'icon'):?>
	var msg_count = $('ynadvmenu_MessageCount');
	msg_count.getParent().setStyle('display', 'none');
	$('ynadvmenu_MessagesUpdates').className = "ynadvmenu_mini_wrapper";
<?php endif; ?>
}
}              
}
}).get();
<?php if($this->viewer()->getIdentity() > 0): ?>
	if(updateTimes > 10000){
		timerNotificationID = setTimeout(getNotificationsTotal, updateTimes);
	}
<?php endif; ?>
}
	// DOM READY
	window.addEvent('domready', function(){
		// Load notification, friend request, message in total
		en4.core.runonce.add(getNotificationsTotal);
	});

	var inbox = function() {
		new Request.HTML({
			'url'    :    en4.core.baseUrl + 'advmenusystem/index/message',
			'data' : {
				'format' : 'html',
				'page' : 1,
				'number_item_show' : <?php echo $this->number_item_show ?>
			},
			'onComplete' : function(responseTree, responseElements, responseHTML, responseJavaScript) {
				if(responseHTML)
				{
					$('ynadvmenu_messages_content').innerHTML = responseHTML;
					<?php if($this->design_type == 'icon'):?> 
					$('ynadvmenu_MessageCount').getParent().setStyle('display', 'none'); 
				<?php endif;?> 
				<?php if($this->design_type == 'title'):?>
				$('title-mini-message').setStyle('color','#<?php echo $this->title_color;?>');
				$('title-mini-message').set('text','Messages');
			<?php endif;?> 
			$('ynadvmenu_MessagesUpdates').removeClass('ynadvmenu_hasNotify'); 
			$('ynadvmenu_messages_content').getChildren('ul').getChildren('li').each(function(el){
				el.addEvent('click', function(){inbox_count_down = 1;});
			});
		}
	}
}).send();
	}
	   //inbox();	   
	   var freq = function() {
	   	new Request.HTML({
	   		'url'    :    en4.core.baseUrl + 'advmenusystem/index/friend',
	   		'data' : {
	   			'format' : 'html',
	   			'page' : 1,
	   			'number_item_show' : <?php echo $this->number_item_show ?>
	   		},
	   		'onComplete' : function(responseTree, responseElements, responseHTML, responseJavaScript) {
	   			if(responseHTML)
	   			{ 
	   				$('ynadvmenu_friends_content').innerHTML = responseHTML;
	   				<?php if($this->design_type == 'icon'):?> 
	   				$('ynadvmenu_FriendCount').getParent().setStyle('display', 'none');
	   			<?php endif;?> 
	   			<?php if($this->design_type == 'title'):?>
	   			$('title-mini-friend').setStyle('color','#<?php echo $this->title_color;?>');
	   			$('title-mini-friend').set('text','Friend Requests');
	   		<?php endif;?>  
	   		$('ynadvmenu_FriendsRequestUpdates').removeClass('ynadvmenu_hasNotify');
	   		$('ynadvmenu_friends_content').getChildren('ul').getChildren('li').each(function(el){
	   			el.addEvent('click', function(){friend_count_down = 1;});
	   		});
	   	}
	   }
	}).send();
}
	   //freq();	   
	   var notification = function() {
	   	new Request.HTML({
	   		'url'    :    en4.core.baseUrl + 'advmenusystem/index/notification',
	   		'data' : {
	   			'format' : 'html',
	   			'page' : 1,
	   			'number_item_show' : <?php echo $this->number_item_show ?>
	   		},
	   		'onComplete' : function(responseTree, responseElements, responseHTML, responseJavaScript) {
	   			if(responseHTML)
	   			{ 
	   				$('ynadvmenu_updates_content').innerHTML = responseHTML;   
	   				<?php if($this->design_type == 'icon'):?> 
	   				$('ynadvmenu_NotifyCount').getParent().setStyle('display', 'none');
	   			<?php endif;?>  
	   			<?php if($this->design_type == 'title'):?>
	   			$('title-mini-notification').setStyle('color','#<?php echo $this->title_color;?>');
	   			$('title-mini-notification').set('text','Notifications');
	   		<?php endif;?>  
	   		$('ynadvmenu_NotificationsUpdates').removeClass('ynadvmenu_hasNotify');      
	   		$('ynadvmenu_updates_content').getChildren('ul').getChildren('li').each(function(el){
	   			el.addEvent('click', function(){notification_count_down = 1;});
	   		});
	   	}
	   }
	}).send();
}
	   //notification();
	  // Show Inbox Message
	  var inbox_count_down = 1;
	  var inbox_status = false; // false -> not shown, true -> shown
	  $('ynadvmenu_messages').addEvent('click', function() 
	  {
	  	hide_all_drop_box(1);
	  	if (inbox_status) inbox_count_down = 1; 
	  	if (!inbox_status) {
			  // show
			  $(this).addClass('notifyactive');
			  $('ynadvmenu_messageUpdates').setStyle('display', 'block');
			} else {
			  // hide
			  $(this).removeClass('notifyactive');
			  $('ynadvmenu_messageUpdates').setStyle('display', 'none');
			}
			inbox_status = inbox_status ? false : true;
			if (isLoaded[1] == 0) 
			{
				refreshBox(1);
				isLoaded[1] = 1;
			}
		});
	  // Friend box
	  var friend_count_down = 1;
	  var friend_status = false;
	  $('ynadvmenu_friends').addEvent('click', function(){
	  	hide_all_drop_box(2);
	  	if (friend_status) friend_count_down = 1;
	  	if (!friend_status) {
	  		$(this).addClass('notifyactive');
	  		$('ynadvmenu_friendUpdates').setStyle('display', 'block');
	  	} else {
	  		$(this).removeClass('notifyactive');
	  		$('ynadvmenu_friendUpdates').setStyle('display', 'none');
	  	}
	  	friend_status = friend_status ? false : true; 

		  // Set all message as read
		  if (isLoaded[0] == 0) {
		  	refreshBox(2);
			  isLoaded[0] = 1;   // get again is check isloaded = 0      
			}
		});

	  //Notification box
	  var notification_count_down = 1;
	  var notification_status = false;
	  $('ynadvmenu_updates').addEvent('click', function(){
	  	hide_all_drop_box(3);
	  	if (notification_status) notification_count_down = 1;
	  	if (!notification_status) {
			  // active
			  $(this).addClass('notifyactive');
			  $('ynadvmenu_notificationUpdates').setStyle('display', 'block');
			} else {
				$(this).removeClass('notifyactive');
				$('ynadvmenu_notificationUpdates').setStyle('display', 'none');
			}
			notification_status = notification_status ? false : true;

			if (isLoaded[2] == 0) {
				refreshBox(3);
				isLoaded[2] = 1;
			}
		});
	  do_confrim_friend = false;
	  $(document).addEvent('click', function() {
	  	if (inbox_status && inbox_count_down <= 0) {
	  		$('ynadvmenu_messages').removeClass('notifyactive');
	  		$('ynadvmenu_messageUpdates').setStyle('display', 'none');
	  		inbox_status = false;            
	  		inbox_count_down = 1;
	  	} else if (inbox_status) {
	  		inbox_count_down = (inbox_count_down <= 0) ? 0 : --inbox_count_down;
	  	}         

	  	if (friend_status && friend_count_down <= 0) {
	  		if (do_confrim_friend) {do_confrim_friend = false; return false;}
	  		$('ynadvmenu_friends').removeClass('notifyactive');
	  		$('ynadvmenu_friendUpdates').setStyle('display', 'none');
	  		friend_status = false;            
	  		friend_count_down = 1;
	  	} else if (friend_status) {
	  		friend_count_down = (friend_count_down <= 0) ? 0 : --friend_count_down;
	  	} 
	  	if (notification_status && notification_count_down <= 0) {
	  		$('ynadvmenu_updates').removeClass('notifyactive');
	  		$('ynadvmenu_notificationUpdates').setStyle('display', 'none');
	  		notification_status = false;            
	  		notification_count_down = 1;
	  	} else if (notification_status) {
	  		notification_count_down = (notification_count_down <= 0) ? 0 : --notification_count_down;
	  	}
	  });

	var firefox = false;
		if (/Firefox[\/\s](\d+\.\d+)/.test(navigator.userAgent)){ //test for Firefox/x.x or Firefox x.x (ignoring remaining digits);
		 var ffversion=new Number(RegExp.$1) // capture x.x portion and store as a number
		 if (ffversion>=1)
		 {
		 	firefox = true;
		 } 
		}
		
		var isMouseLeaveOrEnter = function(e, handler)
		{    
			if (e.type != 'mouseout' && e.type != 'mouseover') return false;
			var reltg = e.relatedTarget ? e.relatedTarget :
			e.type == 'mouseout' ? e.toElement : e.fromElement;
			while (reltg && reltg != handler) reltg = reltg.parentNode;
			return (reltg != handler);
		}
	}
</script>

<div id='core_menu_mini_menu' class="ynadvanced-menu-mini">
<?php
// Reverse the navigation order (they're floating right)
$count = count($this->navigation);
foreach( $this->navigation->getPages() as $item ) $item->setOrder(--$count);
?>
<ul>

	<?php if($this->search_check):?>
		<li id="global_search_form_container">
			<form id="global_search_form" action="<?php echo $this->url(array('controller' => 'search'), 'default', true) ?>" method="get">
				<input type='text' <?php if($this -> width_searchbox) echo "style='width:".$this -> width_searchbox."'"; ?> class='text suggested' name='query' id='global_search_field' size='20' maxlength='100' alt='<?php echo $this->translate('Search') ?>' />
			</form>
		</li>
	<?php endif;?>

	<?php if( $this->viewer->getIdentity()) :?>
		<li class="ynadvmenu_notification type-<?php echo $this->design_type; ?>" >
			<?php echo $this -> html_notification?>
		</li>
		<script type="text/javascript">
			addNotificationScript();
		</script>
	<?php endif; ?>
		
	<?php foreach( $this->navigation as $item ):
		if($item -> name == 'core_mini_auth' || $item -> name == 'core_mini_signup'):?>
		<?php if( $item -> name == 'core_mini_auth' ) : ?>
			<?php $tempFunctionName = 'login'; ?>
		<?php elseif( $item -> name == 'core_mini_signup' ): ?>
			<?php $tempFunctionName = 'signup'; ?>
		<?php endif; ?>
		<li class="">
			<a 
			<?php if( $item -> name == 'core_mini_auth' && !empty($this->advmenusystemEnableLoginLightbox) && (empty($this->isUserLoginPage) && empty($this->isUserSignupPage)) ) : ?>
				onclick="advancedMenuUserLoginOrSignUp('<?php echo $tempFunctionName ?>', '<?php echo $this->isUserLoginPage ?>', '<?php echo $this->isUserSignupPage ?>'); return false;"
			<?php elseif( $item -> name == 'core_mini_signup' && !empty($this->advmenusystemEnableSignupLightbox) && (empty($this->isUserSignupPage) && empty($this->isUserLoginPage))): ?>  
				onclick="advancedMenuUserLoginOrSignUp('<?php echo $tempFunctionName ?>', '<?php echo $this->isUserLoginPage ?>', '<?php echo $this->isUserSignupPage ?>'); return false;" 
			<?php endif;?>
			href="<?php echo $item->getHref() ?>">          
			<span><?php echo $this->translate($item->getLabel()) ?></span>
		</a>
	</li>
	<?php
	elseif(in_array($item -> name, $this->arr_sub_mini) || $item -> name == 'core_mini_messages'):?>
	<?php else:?>
		<li><?php echo $this->htmlLink($item->getHref(), $this->translate($item->getLabel()), array_filter(array(
			'class' => ( !empty($item->class) ? $item->class : null ),
			'alt' => ( !empty($item->alt) ? $item->alt : null ),
			'target' => ( !empty($item->target) ? $item->target : null ),
			))) ?></li>
		<?php endif;?>
	<?php endforeach; ?>

</ul>
</div>

<!--Sign in/ Sign up smooth box work-->
<?php if (empty($this->viewer_id) && empty($this->isUserLoginPage) && empty($this->isUserSignupPage) && (!empty($this->advmenusystemEnableLoginLightbox) || !empty($this->advmenusystemEnableSignupLightbox))) : ?>
	<div class="ynadvmenu-popup">		
		<div class="ynadvmenu-overlay"></div>
		<div class="ynadvmenu-popup-content">
			<div class="ynadvmenu-popup-close"></div>
			<div class='advmenusystem_lightbox' id='user_form_default_sea_lightbox'>
				<!--LOGIN PAGE CONTENT-->
				<?php if(!empty($this->advmenusystemEnableLoginLightbox)): ?>
					<div id="user_login_form" class="ynadvmenu-user-login-form">
						<?php /* Newrosoftmods (eMail 31.01.2015 - 1.) if(!empty($this->advmenusystemEnableLoginLightbox)): ?>
							<h3><?php echo $this->translate('Sign In') ?></h3>
						<?php endif; /**/?>

						<?php echo $this->content()->renderWidget('advmenusystem.login-or-signup'); ?>
						<?php if(!empty($this->advmenusystemEnableSignupLightbox)):?>
							<div class="fright advmenusystem_signup_instead_btn"> 
								<button type="button" onclick="advancedMenuUserLoginOrSignUp('signup', '<?php echo $this->isUserLoginPage ?>', '<?php echo $this->isUserSignupPage ?>');" name="submit"><?php echo $this->translate('Create Account') ?></button>
							</div>
						<?php endif;?>
					</div>
				<?php endif; ?>

				<!-- SIGNUP PAGE CONTENT -->
				<?php if (empty($this->isUserSignupPage) && !$this->isPost && !empty($this->advmenusystemEnableSignupLightbox)) : ?>
					<div id="user_signup_form" class="ynadvmenu-user-signup-form">
						<?php echo $this->action("index", "signup", "advmenusystem", array()) ?>
						<?php if(!empty($this->advmenusystemEnableLoginLightbox)):?>
							<div class="fright advmenusystem_login_instead_btn">
								<button type="button" onclick="advancedMenuUserLoginOrSignUp('login', '<?php echo $this->isUserLoginPage ?>', '<?php echo $this->isUserSignupPage ?>');" name="submit"><?php echo $this->translate('Already a member?') ?></button>
							</div>
						<?php endif; ?>
					</div>
				<?php endif; ?>
			</div>
		</div>
	</div>
<?php endif; ?>

<script type="text/javascript">

	var check_return_url = false;
	var ynAdvMenu = {	
		updateAllElement: function()
		{
			var flag = 0;
			if($$('.core_mini_profile')[0] !== null && $$('.core_mini_profile')[0] !== undefined)
			{
				flag = 1;
				var profile_element = $$('.core_mini_profile')[0];
				var parent_element = profile_element.parentNode;
				parent_element.className = 'ynadvmenu_MyProfile';
				parent_element.innerHTML = <?php echo $this->html_json_profile;?>;
				ynAdvMenu.doAddSubMenu();
			}
			if(flag == 0)
			{
				ynAdvMenu.doAddSubMenu();
			}
		},

		doAddSubMenu: function()
		{
			// Add sub menu for mini menu
			<?php foreach($this->arr_objectParent as $key => $html_json):?>
			ynAdvMenu.doAddEachSubMiniMenu('<?php echo $key?>',<?php echo $html_json;?>);
		<?php endforeach;?>
	},
	doAddEachSubMiniMenu: function(key, html) {
		var parent_menu_item = $$('.'+ key)[0];
		if(parent_menu_item !== null && parent_menu_item !== undefined)
		{
			var parent_item = parent_menu_item.parentNode;
			parent_item.className += ' ynadvmenu_downservices';
			parent_item.innerHTML = html;
		}
	},
	mouseoverMiniMenuPulldown: function(event, element, user_id) {
		element.className= 'updates_pulldown_active';
	},
	mouseoutMiniMenuPulldown: function(event, element, user_id) {
		element.className='updates_pulldown';
	}
}

window.addEvent('domready', function()
{
	ynAdvMenu.updateAllElement();
	if($$('.ynadvmenu-user-signup-form').length)
		$$('.ynadvmenu-user-signup-form')[0].getElement('button[name=submit]').grab( $$('.ynadvmenu-user-signup-form')[0].getElement('.advmenusystem_login_instead_btn'), "after" );
	if($$('.ynadvmenu-user-login-form').length)
		$$('.ynadvmenu-user-login-form')[0].getElement('button[name=submit]').grab( $$('.ynadvmenu-user-login-form')[0].getElement('.advmenusystem_signup_instead_btn'), "after" );

	/*** add event click menu ***/
	if (Browser.Platform.ios || Browser.Platform.android || Browser.Platform.webos) {
		console.log('touch-device');
		
		$$('.ynadvmenu_downservices a.menu_core_mini')[0].addEvent('click', function(){
			var span = this.getParent('span');

			if ( this.hasClass('open-pulldown-wrapper') ) {

				window.open( this.get('href'), '_self');

		    	return false;
			} else {
				this.addClass('open-pulldown-wrapper');
				span.addClass('updates_pulldown_active').removeClass('updates_pulldown');	

				return false;
			}

			return false;
		});	
	}	
});

var advancedMenuUserLoginOrSignUp = function(type, isLoginPage, isSignupPage)
{
	var ynadvpopup_content 	= $$('.ynadvmenu-popup')[0],
		global_content		= $('global_content'),
		main_html			= $$('html');

	// reset popup
	global_content.removeClass('ynadvmenu-login').removeClass('ynadvmenu-signup');
	global_content.getElements('.ynadvmenu-popup').destroy();

	// open popup
	main_html.addClass('ynadvmenu-html-fixed');
	global_content.addClass( 'ynadvmenu-'+type );
	global_content.grab( ynadvpopup_content.clone() , 'top');
	$$('input[name=name]').getParent('.form-wrapper').hide();

	if ( window.getSize().y > global_content.getElement('.advmenusystem_lightbox').getSize().y ) {
		global_content.getElement('.advmenusystem_lightbox').setStyle('margin-top', (window.getSize().y-global_content.getElement('.advmenusystem_lightbox').getSize().y) / 2);
	}	

	// close popup
	global_content.getElement('.ynadvmenu-popup-close').addEvent('click',function(){
		main_html.removeClass('ynadvmenu-html-fixed');
		global_content.removeClass('ynadvmenu-login').removeClass('ynadvmenu-signup');
		global_content.getElements('.ynadvmenu-popup').destroy();
	});
}
</script>
