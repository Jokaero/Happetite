<div class='notifications_layout'>   
<div >
    <h3 class="sep">
      <?php  $itemCount = count($this->freqs); ?>
      <span><?php echo $this->translate(array("Friend Request (%d)","Friend Requests (%d)", $itemCount), $itemCount) ?></span>
    </h3>
    <ul class='requests'>
      <div class='notifications_layout'>   
		<?php if (count($this->freqs)):
			$viewer = Engine_Api::_()->user()->getViewer(); 
			$viewer_id = $viewer->getIdentity();?>
		<div class="ynadvmenu_dropdownHaveContent">
			<ul class="ynadvmenu_Contentlist">
		<?php foreach ($this->freqs as $item):?>
			<?php $subject = Engine_Api::_()->user()->getUser($item->resource_id);
			//get mutual friends
			// Diff friends
		    $friendsTable = Engine_Api::_()->getDbtable('membership', 'user');
		    $friendsName = $friendsTable->info('name'); 
		    // Mututal friends/following mode            
		    $sql = "SELECT `user_id` FROM `{$friendsName}` WHERE (`active`= 1 and `resource_id`={$item->resource_id})
		        and `user_id` in (select `resource_id` from `engine4_user_membership` where (`user_id`={$viewer_id} and `active`= 1))";
		    $db = Engine_Db_Table::getDefaultAdapter();
		    $friends = $friendsTable->getAdapter()->fetchcol($sql);
			$totalFriends = count($friends);
			$str_mutural_users = "";
			if($totalFriends)
			 {
			  // Get users
			  $usersTable = Engine_Api::_()->getItemTable('user');
			  $select = $usersTable->select()
			     ->where('user_id IN(?)', $friends);
			  $users = Zend_Paginator::factory($select);
			  foreach ($users as $user) 
			  {
			   $str_mutural_users .= $user->getTitle().", ";
			  }
			  $str_mutural_users = substr($str_mutural_users, 0, -2);
			 }
			?>
		    <li id="freqs_<?php echo $subject->getIdentity()?>">
				<a href="<?php echo $subject->getHref(); ?>">
				    <?php echo $this->itemPhoto($subject, 'thumb.icon');?>
				</a>
				<div class="ynadvmenu_ContentlistInfo">
					<div class="ynadvmenu_NameUser">
						<?php echo $subject;?>
					</div>
		    		<div class="ynadvmenu_MessDescription" <?php if($totalFriends > 0):?> title = "<?php echo $str_mutural_users; ?>" <?php endif;?>> 
		    			<?php echo $this->translate(array("%s mutural friend","%s mutural friends",$totalFriends), $this->locale()->toNumber($totalFriends));?>
		    		</div>
					<div class="ynadvmenu_Friendsbutton" id="friend_action_<?php echo $subject->getIdentity()?>"> 
						<button class="ynadvmenu_FriendsbuttonConfirm" onclick="return doConfirm(<?php echo $subject->getIdentity()?>)"> <?php echo $this->translate("Confirm") ?> </button>
						<button class="ynadvmenu_FriendsbuttonCancel" onclick="return doCancel(<?php echo $subject->getIdentity()?>)"> <?php echo $this->translate("Not Now") ?> </button>
					</div>
				</div>
		    </li>
		<?php endforeach;?>
			</ul>
		</div>
		<?php else:?>
		    <div class="ynadvmenu_dropdownNoContent">
				<?php echo $this->translate("You have no new friend requests.") ?>
			</div>
		<?php endif;?>
		
		  </div>
    </ul>
  </div>
  </div>
  
<script type="text/javascript">
var doConfirm = function(rid)
  {
      do_confrim_friend = true;
      var img_loading = '<?php echo $this->baseUrl(); ?>/application/modules/Advmenusystem/externals/images/loading_friend.gif';
      $('friend_action_'+rid).innerHTML = '<center><img src="'+ img_loading +'" border="0" /></center>';
      new Request.HTML({
           'url'    :    en4.core.baseUrl + 'advmenusystem/index/confirm-friend/',
           'data' : {
                'format' : 'html',
                'resource_id' : rid
            },
            'onComplete' : function(responseTree, responseElements, responseHTML, responseJavaScript) 
            {
                if(responseHTML){ 
                    $('friend_action_'+rid).innerHTML = responseHTML;
                }
            }
       }).send();
       return false;
  }

  var doCancel = function(rid)
  {
      do_confrim_friend = true;
      var img_loading = '<?php echo $this->baseUrl(); ?>/application/modules/Advmenusystem/externals/images/loading_friend.gif';
      $('friend_action_'+rid).innerHTML = '<center><img src="'+ img_loading +'" border="0" /></center>';
      new Request.HTML({
           'url'    :    en4.core.baseUrl + 'advmenusystem/index/cancel-friend/',
           'data' : {
                'format' : 'html',
                'resource_id' : rid
            },
            'onComplete' : function(responseTree, responseElements, responseHTML, responseJavaScript) 
            {
                if(responseHTML)
                { 
                    $('friend_action_'+rid).innerHTML = responseHTML;
                }
            }
       }).send();
       return false;
  }
</script>