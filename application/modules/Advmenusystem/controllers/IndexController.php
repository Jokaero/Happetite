<?php

class Advmenusystem_IndexController extends Core_Controller_Action_Standard
{

	public function indexAction()
	{
	}

	public function cancelFriendAction()
	{
		// Get Viewer
		$viewer = Engine_Api::_() -> user() -> getViewer();
		if (!$viewer -> getIdentity())
		{
			// Set Norender if user is not logged on
			return false;
		}
		 // Get user
	    if( null == ($user_id = $this->_getParam('resource_id')) ||
	        null == ($user = Engine_Api::_()->getItem('user', $user_id)) ) {
	      $this->view->status = false;
	      $this->view->error = Zend_Registry::get('Zend_Translate')->_('No member specified');
	      return;
	    }
		
		$userTb = Engine_Api::_() -> getDbTable('membership', 'user');
		$db = $userTb -> getAdapter();
		$db -> beginTransaction();
		try
		{
			$user->membership()->removeMember($viewer);
			// Set the requests as handled
			$notification = Engine_Api::_() -> getDbtable('notifications', 'activity') -> getNotificationBySubjectAndType($viewer, $user, 'friend_request');
			if ($notification)
			{
				$notification -> mitigated = true;
				$notification -> read = 1;
				$notification -> save();
			}
			$notification = Engine_Api::_() -> getDbtable('notifications', 'activity') -> getNotificationBySubjectAndType($viewer, $user, 'friend_follow_request');
			if ($notification)
			{
				$notification -> mitigated = true;
				$notification -> read = 1;
				$notification -> save();
			}
			$db -> commit();
			$this->view->status = true;
      		$this->view->message = Zend_Registry::get('Zend_Translate')->_('Your friend request has been cancelled.');
      
		}
		catch (Exception $e)
		{
			$db -> rollBack();
			$this->view->status = false;
      		$this->view->error = Zend_Registry::get('Zend_Translate')->_('An error has occurred.');
			throw $e;
		}
	}

	public function confirmFriendAction()
	{
		// Get Viewer
		$viewer = Engine_Api::_() -> user() -> getViewer();
		if (!$viewer -> getIdentity())
		{
			// Set Norender if user is not logged on
			return false;
		}
		 // Get user
	    if( null == ($user_id = $this->_getParam('resource_id')) ||
	        null == ($user = Engine_Api::_()->getItem('user', $user_id)) ) {
	      $this->view->status = false;
	      $this->view->error = Zend_Registry::get('Zend_Translate')->_('No member specified');
	      return;
	    }
		$friendship = $viewer->membership()->getRow($user);
	    if( $friendship->active ) 
	    {
	      $this->view->status = false;
	      $this->view->error = Zend_Registry::get('Zend_Translate')->_('Already friends');
	      return;
	    }
		$userTb = Engine_Api::_() -> getDbTable('membership', 'user');
		$db = $userTb -> getAdapter();
		$db -> beginTransaction();
		try
		{
			$viewer->membership()->setResourceApproved($user);
			
			// Add activity
			if (!$user -> membership() -> isReciprocal())
			{
				Engine_Api::_() -> getDbtable('actions', 'activity') -> addActivity($user, $viewer, 'friends_follow', '{item:$subject} is now following {item:$object}.');
			}
			else
			{
				Engine_Api::_() -> getDbtable('actions', 'activity') -> addActivity($user, $viewer, 'friends', '{item:$object} is now friends with {item:$subject}.');
				Engine_Api::_() -> getDbtable('actions', 'activity') -> addActivity($viewer, $user, 'friends', '{item:$object} is now friends with {item:$subject}.');
			}

			// Add notification
			if (!$user -> membership() -> isReciprocal())
			{
				Engine_Api::_() -> getDbtable('notifications', 'activity') -> addNotification($user, $viewer, $user, 'friend_follow_accepted');
			}
			else
			{
				Engine_Api::_() -> getDbtable('notifications', 'activity') -> addNotification($user, $viewer, $user, 'friend_accepted');
			}
			// Set the requests as handled
			$notification = Engine_Api::_() -> getDbtable('notifications', 'activity') -> getNotificationBySubjectAndType($viewer, $user, 'friend_request');
			if ($notification)
			{
				$notification -> mitigated = true;
				$notification -> read = 1;
				$notification -> save();
			}
			$notification = Engine_Api::_() -> getDbtable('notifications', 'activity') -> getNotificationBySubjectAndType($viewer, $user, 'friend_follow_request');
			if ($notification)
			{
				$notification -> mitigated = true;
				$notification -> read = 1;
				$notification -> save();
			}
			 // Increment friends counter
			Engine_Api::_()->getDbtable('statistics', 'core')->increment('user.friendships');
			
			$db -> commit();
			$message = Zend_Registry::get('Zend_Translate')->_('You are now friends with %s');
		    $message = sprintf($message, $user->__toString());
		
		    $this->view->status = true;
		    $this->view->message = $message;
		}
		catch (Exception $e)
		{
			$db -> rollBack();
			$this->view->status = false;
      		$this->view->error = Zend_Registry::get('Zend_Translate')->_('An error has occurred.');
			throw $e;
		}
		
	}

	/**
	 * Message alert
	 * @todo get message
	 * @access public
	 */
	public function messageAction()
	{
		// Get Viewer
		$viewer = Engine_Api::_() -> user() -> getViewer();
		if (!$viewer -> getIdentity())
		{
			// Set Norender if user is not logged on
			return false;
		}
		$notificationsTable = Engine_Api::_() -> getDbtable('notifications', 'activity');
		$db = $notificationsTable -> getAdapter();
		$db -> beginTransaction();
		try
		{
			// Get notification
			$notifications = $notificationsTable -> fetchAll("`user_id` = {$viewer->getIdentity()} AND `type` = 'message_new' AND `mitigated` = 0");
			if ($notifications)
			{
				foreach ($notifications as $notification)
				{
					$notification -> mitigated = 1;
					$notification -> save();
				}
				$db -> commit();
			}
		}
		catch (Exception $e)
		{
			$db -> rollBack();
			throw $e;
		}
		// Get Message
		$table = Engine_Api::_() -> getItemTable('messages_conversation');
		$rName = Engine_Api::_() -> getDbtable('recipients', 'messages') -> info('name');
		$cName = $table -> info('name');
		$select = $table -> select() -> from($cName) -> joinRight($rName, "`{$rName}`.`conversation_id` = `{$cName}`.`conversation_id`", null) -> where("`{$rName}`.`user_id` = ?", $viewer -> getIdentity()) -> where("`{$rName}`.`inbox_deleted` = ?", 0) -> order('inbox_read ASC') -> order(new Zend_Db_Expr('inbox_updated DESC')) -> limit($this->_getParam('number_item_show'));
		$this -> view -> messages = $messages = $table -> fetchAll($select);

		$this -> _helper -> layout -> disableLayout();
	}

	public function notificationsAction()
	{
		$viewer = Engine_Api::_() -> user() -> getViewer();
		$select = Engine_Api::_() -> getDbTable('notifications', 'activity') 
		 -> select()
		 -> where("`user_id` = ?", $viewer -> getIdentity()) 
		 -> where("`type` NOT IN ('friend_request','message_new')") 
		 -> order('read ASC') -> order('notification_id DESC') ;
		$this -> view -> notifications = $notifications = Zend_Paginator::factory($select);
		$notifications -> setCurrentPageNumber($this -> _getParam('page'));
		$this -> view -> requests = Engine_Api::_() -> getDbtable('notifications', 'activity') -> getRequestsPaginator($viewer);
		// Force rendering now
		$this -> _helper -> viewRenderer -> postDispatch();
		$this -> _helper -> viewRenderer -> setNoRender(true);

		$this -> view -> hasunread = false;

		// Now mark them all as read
		$ids = array();
		foreach ($notifications as $notification)
		{
			$ids[] = $notification -> notification_id;
		}
	}

	public function markreadAction()
	{
		$request = Zend_Controller_Front::getInstance() -> getRequest();
		$action_id = $request -> getParam('actionid', 0);
		$viewer = Engine_Api::_() -> user() -> getViewer();
		$notificationsTable = Engine_Api::_() -> getDbtable('notifications', 'activity');
		$db = $notificationsTable -> getAdapter();
		$db -> beginTransaction();

		try
		{
			$notification = Engine_Api::_() -> getItem('activity_notification', $action_id);
			$notification -> read = 1;
			$notification -> save();
			// Commit
			$db -> commit();
		}
		catch( Exception $e )
		{
			$db -> rollBack();
			throw $e;
		}
	}

	public function pulldownAction()
	{
		$page = $this -> _getParam('page');
		$viewer = Engine_Api::_() -> user() -> getViewer();
		$select = Engine_Api::_() -> getDbTable('notifications', 'activity') -> select() -> where("`user_id` = ?", $viewer -> getIdentity()) -> where("`type`NOT IN ('friend_request','message_new')") -> order('notification_id DESC');
		$this -> view -> notifications = $notifications = Zend_Paginator::factory($select);
		$notifications -> setCurrentPageNumber($page);

		if ($notifications -> getCurrentItemCount() <= 0 || $page > $notifications -> getCurrentPageNumber())
		{
			$this -> _helper -> viewRenderer -> setNoRender(true);
			return;
		}
		// Force rendering now
		$this -> _helper -> viewRenderer -> postDispatch();
		$this -> _helper -> viewRenderer -> setNoRender(true);
	}

	/**
	 * Notification alert
	 * @todo get notification
	 * @access public
	 */
	public function notificationAction()
	{
		// Get Viewer
		$viewer = Engine_Api::_() -> user() -> getViewer();
		if (!$viewer -> getIdentity())
		{
			// Set Norender if user is not logged on
			return false;
		}
		$notificationsTable = Engine_Api::_() -> getDbtable('notifications', 'activity');
		$db = $notificationsTable -> getAdapter();
		$db -> beginTransaction();
		try
		{
			// Get notification
			$notifications = $notificationsTable -> fetchAll("`user_id` = {$viewer->getIdentity()} AND `type` NOT  IN ('friend_request','message_new') AND `mitigated` = 0");
			if ($notifications)
			{
				foreach ($notifications as $notification)
				{
					$notification -> mitigated = 1;
					$notification -> save();
				}
				$db -> commit();
			}
		}
		catch (Exception $e)
		{
			$db -> rollBack();
			throw $e;
		}
		// Get notifications
		$select = Engine_Api::_() -> getDbTable('notifications', 'activity') -> select() -> where("`user_id` = ?", $viewer -> getIdentity()) -> where("`type` NOT IN ('friend_request','message_new')") -> order('read ASC') -> order('notification_id DESC') -> limit($this->_getParam('number_item_show'));
		$this -> view -> updates = Engine_Api::_() -> getDbTable('notifications', 'activity') -> fetchAll($select);
		$this -> _helper -> layout -> disableLayout();
	}

	/**
	 * Friend request alert
	 * @todo get friend request
	 * @access public
	 */
	public function friendAction()
	{
		$viewer = Engine_Api::_() -> user() -> getViewer();
		if (!$viewer -> getIdentity())
		{
			return false;
		}
		// Mark read action
		$notificationsTable = Engine_Api::_() -> getDbtable('notifications', 'activity');
		$db = $notificationsTable -> getAdapter();
		$db -> beginTransaction();
		try
		{
			// Get friend request notifications
			$notifications = $notificationsTable -> fetchAll("`user_id` = {$viewer->getIdentity()} AND `type` = 'friend_request'");
			if ($notifications)
			{
				foreach ($notifications as $notification)
				{
					$notification -> read = 1;
					// set it as read
					$notification -> mitigated = 1;
					$notification -> save();
				}
				$db -> commit();
			}
		}
		catch (Exception $e)
		{
			$db -> rollBack();
			throw $e;
		}
		// Get Friend request but not confirm yet
		$userTb = Engine_Api::_() -> getDbTable('membership', 'user');
		$select = $userTb -> select() -> where("user_id = ?", $viewer -> getIdentity()) -> where("active = 0 AND resource_approved = 1 AND user_approved = 0")-> limit($this->_getParam('number_item_show'));
		$this -> view -> freqs = $userTb -> fetchAll($select);
		$this -> _helper -> layout -> disableLayout();
	}

	public function friendRequestsAction()
	{
		$viewer = Engine_Api::_() -> user() -> getViewer();
		if (!$viewer -> getIdentity())
		{
			return false;
		}
		// Get Friend request but not confirm yet
		$userTb = Engine_Api::_() -> getDbTable('membership', 'user');
		$select = $userTb -> select() -> where("user_id = ?", $viewer -> getIdentity()) -> where("active = 0 AND resource_approved = 1 AND user_approved = 0");
		$this -> view -> freqs = $userTb -> fetchAll($select);
	}
	
	public function getcontentAction()
	{
		if ( isset($_POST['menu_id']) && isset($_POST['level']) )
		{
			$contentTbl = Engine_Api::_() -> getDbtable('contents', 'advmenusystem');
			$contents = $contentTbl-> getContentByMenu($_POST['menu_id'], $_POST['level'], $_POST['limit']);
			if (!count($contents))
			{
				$output = '<div class="tip" style="margin-top: 8px; margin-left: 8px;"><span>' . Zend_Registry::get("Zend_Translate")->_("There is no content to show!") . '</span></div>';
				echo $output; exit;
			}
			else 
			{
				$output = "";
				foreach ($contents as $content)
				{
					$params = Zend_Json::decode($content->params);
					$url = (isset($params['url']) && $params['url'] != '') ? $params['url'] : "#";
					$title = (isset($params['title']) && $params['title'] != '') ? $params['title'] : Zend_Registry::get("Zend_Translate")->_("Untitled");
					$photoUrl = ($content->photo_id) ? $content->getPhotoUrl() : "";
					if ($photoUrl)
					{
						$output .= "<li class=\"item-content\"><a href=\"{$url}\" title=\"{$title}\" style=\"background-image: url({$photoUrl});\"><span>{$title}</span></a></li>";
					}
					else
					{
						$output .= "<li class=\"item-content\"><a href=\"{$url}\" title=\"{$title}\"><span>{$title}</span></a></li>";
					}
						
				}
				echo $output; exit;
			}
		}
		else 
		{
			$output = '<div class="tip" style="margin-top: 8px; margin-left: 8px;"><span>' . Zend_Registry::get("Zend_Translate")->_("There is no content to show!") . '</span></div>';
			echo $output; exit;
		}
	}

}

if (!function_exists('json_decode'))
{
	function json_decode($json)
	{
		$comment = false;
		$out = '$x=';

		for ($i = 0; $i < strlen($json); $i++)
		{
			if (!$comment)
			{
				if (($json[$i] == '{') || ($json[$i] == '['))
					$out .= ' array(';
				else
				if (($json[$i] == '}') || ($json[$i] == ']'))
					$out .= ')';
				else
				if ($json[$i] == ':')
					$out .= '=>';
				else
					$out .= $json[$i];
			}
			else
				$out .= $json[$i];
			if ($json[$i] == '"' && $json[($i - 1)] != "\\")
				$comment = !$comment;
		}
		eval($out . ';');
		return $x;
	}
}
