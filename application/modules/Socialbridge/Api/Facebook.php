<?php
/**
 * SocialEngine
 *
 * @category   Application_Socialbridge
 * @package    Socialbridge
 * @copyright  Copyright 2013-2013 YouNet Company
 * @license    http://socialengine.younetco.com/
 * @version    $Id: Abstract.php minhnc $
 * @author     MinhNC
 */

/**
 * @category   Application_Socialbridge
 * @package    Socialbridge
 * @copyright  Copyright 2013-2013 YouNet Company
 * @license    http://socialengine.younetco.com/
 */

require_once SOCIALBRIDGE_LIBS_PATH . '/facebook.php';

class Socialbridge_Api_Facebook extends Socialbridge_Api_Abstract
{
	protected $_plugin = 'facebook';
	public $_accessToken = null;
	public $_me = null;

	public function __construct()
	{
		if (!$this -> _objPlugin)
		{
			$this -> getPlugin();
		}
	}

	/**
	 * Save Token
	 *
	 * @return
	 */
	public function saveToken($params = array())
	{
		$token = $this -> _objPlugin -> getUserAccessToken();
		$this -> _objPlugin -> setAccessToken($token);
		$this -> _accessToken = $this -> _objPlugin -> getAccessToken();
		$this -> _me = $this -> _objPlugin -> api('/me');
		$user_id = Engine_Api::_() -> user() -> getViewer() -> getIdentity();
		if ($user_id > 0)
		{
			if ($token)
			{
				//get token old if exists
				$params = array(
					'service' => $this -> _plugin,
					'user_id' => $user_id
					//'uid'	  => $this->getOwnerId()
				);
				$oldToken = $this -> getToken($params);

				if ($oldToken)
				{
					// update token
					$oldToken -> access_token = $token;
					$oldToken -> uid = $this -> getOwnerId();
					//$oldToken->profile = serialize($this->getOwnerInfo());
					$oldToken -> creation_date = date('Y-m-d H:i:s');
					//$oldToken->session_id = 1;
					$oldToken -> save();
				}
				else
				{
					//save new Token
					$values = array(
						'access_token' => $token,
						'secret_token' => '',
						'service' => $this -> _plugin,
						'user_id' => $user_id,
						'uid' => $this -> getOwnerId(),
						//'session_id' => 1,
						//'profile' => serialize($this->getOwnerInfo())
					);
					$this -> setToken($values);
				}
			}
		}
	}

	/**
	 * Get plugin
	 *
	 * @return
	 */
	public function getPlugin($params = array())
	{
		$apiSetting = Engine_Api::_() -> getDbtable('apisettings', 'socialbridge');
		$select = $apiSetting -> select() -> where('api_name = ?', $this -> _plugin);
		$provider = $apiSetting -> fetchRow($select);
		if ($provider == null)
		{
			return false;
		}
		$api_params = unserialize($provider -> api_params);
		$this -> _objPlugin = new YNSFacebook( array(
			'appId' => $api_params['key'],
			'secret' => $api_params['secret'],
			'cookie' => true,
		));
	}

	/**
	 * Get contact list
	 *
	 * @return array (id, pic, name)
	 */
	public function getContacts($params = array())
	{
		if ($this -> _objPlugin)
		{
			$contact = array();
			try
			{
				if (empty($params['limit']))
				{
					$params['limit'] = 30;
				}
				if (!isset($params['offset']))
				{
					$params['offset'] = 0;
				}
				$query = "SELECT uid, name FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1 = me()) ";
				if (isset($params['search']) && trim($params['search']) != "")
				{
					$query .= "AND strpos(name,'" . $params['search'] . "') >=0 ";
				}
				
				if (isset($params['invited_uids']) && is_array($params['invited_uids']) && count($params['invited_uids']))
				{
					$invitedUids = implode(",", $params['invited_uids']);
					
					$query .= "AND NOT (uid IN (". $invitedUids. "))";
				}
				$query .= "ORDER BY name LIMIT " . $params['limit'] . " OFFSET " . $params['offset'];
				$friends = $this -> facebookQuery(array('query' => $query));
				
				$imgLink = "http://graph.facebook.com/%s/picture";
				foreach ($friends as $key => $aFriend)
				{
						$contact[$aFriend['uid']] = array(
							'id' => $aFriend['uid'],
							'pic' => sprintf($imgLink, $aFriend['uid']),
							'name' => $aFriend['name'],
						);
				}
			}
			catch(FacebookApiException $e)
			{
				throw $e;
				return null;
			}
			return $contact;
		}
		return null;
	}

	/**
	 * Get owner info
	 *
	 * @return array (id, name, first_name, last_name, link,...)
	 */
	public function getOwnerInfo($params = array())
	{
		if ($this -> _objPlugin)
		{
			try
			{
				if (isset($params['access_token']))
					$this -> _objPlugin -> setAccessToken($params['access_token']);
				$me = $this -> _objPlugin -> api('/me');
				$me['identity'] = $me['id'];
				$me['displayname'] = @$me['name'];
				$location = @$me['location']['name'];
				if ($location)
				{
					$arr_location = explode(",", $location);
					if (count($arr_location) > 0)
						$me['country'] = $arr_location[count($arr_location) - 1];
				}
				if (isset($me['username']))
					$me['facebook'] = $me['username'];
				else
				{
					$me['facebook'] = $me['id'];
					$me['username'] = $me['first_name'] . $me['last_name'];
				}
				$me['service'] = 'facebook';
				if (isset($me['birthday']) && !empty($me['birthday']))
				{
					$me['birthdate'] = date("Y-m-d", strtotime($me['birthday']));
				}
				$me['gender'] = ($me['gender'] == 'male') ? 1 : 2;
				$me['about_me'] = @$me['bio'];
				$me['about'] = @$me['bio'];
				$me['picture'] = 'https://graph.facebook.com/' . $me['id'] . '/picture?type=small';
				$me['photo_url'] = 'https://graph.facebook.com/' . $me['id'] . '/picture?type=large';
			}
			catch(FacebookApiException $e)
			{
				throw $e;
				return null;
			}
			return $me;
		}
		return null;
	}

	/**
	 * Get owner id
	 *
	 * @return string
	 */
	public function getOwnerId($params = array())
	{
		if (isset($params['access_token']))
			$this -> _objPlugin -> setAccessToken($params['access_token']);
		$me = $this -> _objPlugin -> api('/me');
		return $me['id'];
	}

	/**
	 * Get user info
	 *
	 * @param array (uid)
	 * @return array (id, name, first_name, last_name, link,...)
	 */
	public function getUserInfo($params = array())
	{
		if ($this -> _objPlugin)
		{
			$uid = $params['uid'];
			try
			{
				$user = $this -> _objPlugin -> api('/' . $uid);
			}
			catch(FacebookApiException $e)
			{
				throw $e;
				return null;
			}
			return $user;
		}
		return null;
	}

	/**
	 * Get users info
	 *
	 * @return array
	 */
	public function getUsersInfo($params = array())
	{

	}

	/**
	 * Get albums
	 *
	 * @return array
	 */
	public function getAlbums($params = array())
	{
		$extra = $params['extra'];
		$uid = $params['uid'];
		$limit = $params['limit'];
		$offset = $params['offset'];
		$aid = trim($params['aid'], "'");
		$aid = "'{$aid}'";

		/**
		 * fetch data for each albums
		 */
		switch($extra)
		{
			case 'like' :
				/**
				 * get albums that user liked
				 */
				$query = "SELECT aid, name, photo_count, cover_pid, owner FROM album WHERE  object_id IN (SELECT object_id FROM like WHERE user_id=$uid) LIMIT $limit OFFSET $offset";
				break;
			case 'tag' :
				/**
				 * get albums that contain photo which user is tagged.
				 */
				$query = "SELECT aid, name, photo_count, cover_pid, owner FROM album WHERE aid IN ( SELECT aid FROM photo WHERE pid IN (SELECT pid FROM photo_tag WHERE subject=$uid)) LIMIT $limit OFFSET $offset";
				break;
			case 'friend' :
				/**
				 * get albums of user's friends
				 */
				$query = "SELECT aid, name, photo_count, cover_pid, owner FROM album WHERE  owner IN (SELECT uid2 FROM friend WHERE uid1 = $uid) LIMIT $limit OFFSET $offset";
				break;
			case 'page' :
				/**
				 * get albums that belong to pages.
				 */
				break;
			case 'group' :
				/**
				 * get albums belong to groups that user is a member
				 */
				$query = "SELECT aid, name, photo_count, cover_pid, owner FROM album WHERE  owner IN (SELECT uid2 FROM friend WHERE uid1 = $uid) LIMIT $limit OFFSET $offset";
				break;
			case 'comment' :
				/**
				 * failed because fromid still not index in FBQL
				 */
				$query = "SELECT aid, name, photo_count, cover_pid, owner FROM album WHERE  bject_id IN (SELECT object_id FROM comment WHERE fromid = $uid) LIMIT $limit OFFSET $offset";
				break;
			case 'friend-like' :
				/**
				 * get photo that my friends have been liked.
				 */
				$query = "SELECT aid, name, photo_count, cover_pid, owner FROM album WHERE  owner IN (SELECT uid2 FROM friend WHERE uid1 = $uid) LIMIT $limit OFFSET $offset";
				break;
			default :
				$query = "SELECT aid, name, photo_count, cover_pid, owner FROM album WHERE owner = $uid LIMIT $limit OFFSET $offset";
		}

		$albums = $this -> _objPlugin -> api(array(
			'method' => 'fql.query',
			'query' => $query
		));
		return $albums;
	}

	/**
	 * Get album info
	 *
	 * @return array
	 */
	public function getAlbumInfo($params = array())
	{

	}

	/**
	 * Get photos
	 *
	 * @param array(limit, )
	 * @return array
	 */
	public function getPhotos($params = array())
	{
		$extra = $params['extra'];
		$uid = $params['uid'];
		$limit = $params['limit'];
		$offset = $params['offset'];
		$aid = $params['aid'];
		$aid = trim($params['aid'], "'");
		$aid = "'{$aid}'";
		/**
		 * fetch data for each albums
		 */
		switch($extra)
		{
			case 'aid' :
				$query = "SELECT pid, aid, caption, owner, src_small, src, src_big, link FROM photo WHERE aid = $aid LIMIT $limit OFFSET $offset";
				break;
			case 'like' :
				/**
				 * get albums that user liked
				 */
				$query = "SELECT pid, aid, caption, owner, src_small, src, src_big, link FROM photo WHERE object_id IN (SELECT object_id FROM like WHERE user_id=$uid) LIMIT $limit OFFSET $offset";
				break;
			case 'tag' :
				/**
				 * get albums that contain photo which user is tagged.
				 */
				$query = "SELECT pid, created, aid, caption, owner, src_small, src, src_big, link FROM photo WHERE pid IN (SELECT pid FROM photo_tag WHERE subject=$uid) LIMIT $limit OFFSET $offset";
				break;
			case 'friend' :
				/**
				 * get albums of user's friends
				 */
				$query = "SELECT pid, created, aid, caption, owner, src_small, src, src_big, link FROM photo WHERE aid IN (SELECT aid FROM album WHERE owner IN (SELECT uid2 FROM friend WHERE uid1 = $uid) )  LIMIT $limit OFFSET $offset";
				break;
			case 'page' :
				/**
				 * get albums that belong to pages.
				 */
				break;
			case 'group' :
				/**
				 * get albums belong to groups that user is a member
				 */
				$query = "SELECT aid, name, caption, photo_count, cover_pid FROM album WHERE size > 0 AND owner IN (SELECT uid2 FROM friend WHERE uid1 = $uid) LIMIT $limit OFFSET $offset";
				break;
			case 'comment' :
				/**
				 * failed because fromid still not index in FBQL
				 */
				$query = "SELECT aid, name, caption, photo_count, cover_pid FROM album WHERE size > 0 AND bject_id IN (SELECT object_id FROM comment WHERE fromid = $uid)";
				break;
			case 'friend-like' :
				/**
				 * get photo that my friends have been liked.
				 */
				$query = "SELECT aid, name, caption, photo_count, cover_pid FROM album WHERE size > 0 AND owner IN (SELECT uid2 FROM friend WHERE uid1 = $uid) LIMIT $limit OFFSET $offset";
				break;
			case 'uid' :
			case 'my' :
			default :
				$query = "SELECT pid, aid,created, caption, owner, src_small, src, src_big, link FROM photo WHERE aid IN (select aid FROM album WHERE owner = $uid) LIMIT $limit OFFSET $offset";
		}

		$photos = $this -> _objPlugin -> api(array(
			'method' => 'fql.query',
			'query' => $query
		));
		return $photos;
	}

	/**
	 * Get photo info
	 *
	 * @return array
	 */
	public function getPhotoInfo($params = array())
	{

	}

	/**
	 * Get activity
	 *
	 * @param array(lastFeedTimestamp, limit)
	 * @return array (post_id,actor_id,target_id,message,description,created_time,attachment,permalink,description_tags,type)
	 */
	public function getActivity($params = array('lastFeedTimestamp' => 0, 'limit' => 5))
	{
		$this -> _objPlugin -> setAccessToken($params['access_token']);
		$result_me = array();
		$result_friend = array();

		if ($params['lastFeedTimestamp'] > 0)
		{
			if ($params['type'] != 'friend')
			{
				$my_feeds = $this -> _objPlugin -> api('/' . $params['uid'] . '/feed?limit=99&since=' . $params['lastFeedTimestamp']);
				$result_me = @$my_feeds['data'];
			}
			if ($params['type'] != 'me')
			{
				$friend_feeds = $this -> _objPlugin -> api('/' . $params['uid'] . '/home?limit=99&since=' . $params['lastFeedTimestamp']);
				$result_friend = @$friend_feeds['data'];
			}
		}
		else
		{
			if ($params['type'] != 'friend')
			{
				$my_feeds = $this -> _objPlugin -> api('/' . $params['uid'] . '/feed?limit=' . $params['limit']);
				$result_me = @$my_feeds['data'];
			}
			if ($params['type'] != 'me')
			{
				$friend_feeds = $this -> _objPlugin -> api('/' . $params['uid'] . '/home?limit=' . $params['limit']);
				$result_friend = @$friend_feeds['data'];
			}
		}
		$result = array();
		foreach ($result_me as $my_feed)
		{
			$result[strtotime($my_feed['created_time'])] = $my_feed;
		}
		foreach ($result_friend as $friend_feed)
		{
			$result[strtotime($friend_feed['created_time'])] = $friend_feed;
		}
		if ($params['lastFeedTimestamp'] > 0)
		{
			ksort($result);
			$result = array_slice($result, 0, $params['limit']);
		}
		else
		{
			krsort($result);
			$result = array_slice($result, 0, $params['limit']);
			krsort($result);
		}
		return $result;
	}

	/**
	 * Insert feeds
	 *
	 * @param array(activities, viewer, timestamp)
	 * @return bool
	 */
	public function insertFeeds($params = array())
	{
		$this -> _objPlugin -> setAccessToken($params['access_token']);
		$viewer = $params['viewer'];
		$user_id = $viewer -> getIdentity();
		$uid = $params['uid'];
		$activities = $params['activities'];
		foreach ($activities as $activity)
		{
			$table = new Socialstream_Model_DbTable_Feeds;
			$db = $table -> getAdapter();
			$db -> beginTransaction();
			try
			{
				$obj = Engine_Api::_() -> socialbridge() -> getInstance('facebook');
				$actor = $obj -> getUserInfo(array('uid' => @$activity['from']['id']));

				$attachment['name'] = @$activity['name'];
				$attachment['src'] = @$activity['picture'];
				$attachment['href'] = @$activity['link'];
				$attachment['description'] = @$activity['description'];

				$translate = Zend_Registry::get('Zend_Translate');
				$type = $translate -> translate($activity['type']);
				$type = "<a href = '" . @$activity['actions'][0]['link'] . "' target = '_blank'>" . $type . "</a>";

				if (!isset($attachment['description']) || $attachment['description'] == "")
				{
					if (isset($attachment['caption']) && $attachment['caption'] != "")
						$attachment['description'] = $attachment['caption'];
				}

				$description = "";
				if (isset($activity['message']) && $activity['message'] != "")
				{
					$description = $activity['message'];
				}
				$regex = '@((https?://)?([-\w]+\.[-\w\.]+)+\w(:\d+)?(/([-\w/_\.]*(\?\S+)?)?)*)@';
				$description = preg_replace($regex, '<a href="$1">$1</a>', $description);

				if (isset($activity['place']))
				{
					$description = @$activity['description'];
					$description = preg_replace($regex, '<a href="$1">$1</a>', $description);
					$place = $activity['place'];
					$place_link = "<a href = 'http://www.facebook.com/" . $place['id'] . "' target='_blank'>" . $place['name'] . "</a>";
					$description .= ' - ' . $translate -> translate('at') . " " . $place_link;
				}

				$values = array_merge(array(
					'provider' => 'facebook',
					'user_id' => $user_id,
					'uid' => $uid,
					'timestamp' => strtotime($activity['created_time']),
					'update_key' => $activity['id'],
					'update_type' => $type,
					'photo_url' => @$attachment['src'],
					'title' => @$attachment['name'],
					'href' => @$attachment['href'],
					'description' => @$attachment['description'],

					'friend_id' => @$activity['from']['id'],
					'friend_name' => @$actor['name'],
					'friend_href' => @$actor['link'],
					'friend_description' => $description,
					'privacy' => Zend_Json::encode($activity['privacy']),
				));
				// save feed
				$feed = $table -> createRow();
				$feed -> setFromArray($values);
				$feed -> save();
				// Auth
				$auth = Engine_Api::_() -> authorization() -> context;
				$roles = array(
					'owner',
					'owner_member',
					'everyone'
				);

				$settingTable = Engine_Api::_() -> getDbTable('settings', 'socialstream');
				$stream_settings = $settingTable -> checkExists($viewer -> getIdentity(), 'facebook');
				$auth_view = Engine_Api::_() -> getApi('settings', 'core') -> getSetting('default_fb_view', 'everyone');
				if ($stream_settings)
				{
					$auth_view = $stream_settings -> view_privacy;
				}
				$viewMax = array_search($auth_view, $roles);
				foreach ($roles as $i => $role)
				{
					$auth -> setAllowed($feed, $role, 'view', ($i <= $viewMax));
					$auth -> setAllowed($feed, $role, 'comment', ($i <= $viewMax));
				}

				//Add activity
				$this -> addActivity($feed, $viewer);
				$db -> commit();

			}
			catch( Exception $e )
			{
				$db -> rollBack();
				throw $e;
			}
		}
	}

	/**
	 * Send invite
	 *
	 * @param array (to string, message string, link string, uid int, access_token string)
	 * @return bool
	 */
	public function sendInvite($params = array())
	{
		$message = $params['message'];
		$link = $params['link'];
		$uid = $params['uid'];
		$to = $params['to'];
		$access_token = $params['access_token'];

		$api = Engine_Api::_() -> getApi('facebookChat', 'Socialbridge');
		$options = array(
			'uid' => $uid,
			'app_id' => $this -> _objPlugin -> getAppId(),
			'server' => 'chat.facebook.com',
		);
		$connectResult = $api -> xmpp_connect($options, $access_token);

		if (!$connectResult)
		{
			echo 'connect failed';
		}

		$sMessage = $message . ' ' . $link;
		$sendMessageResult = $api -> xmpp_message($to = $to, $body = $sMessage);

		if (!$sendMessageResult)
		{
			echo 'send message failed due to some error, will be checked later';
		}
		else
		{
			echo $sendMessageResult;
		}
	}

	/**
	 * Send invites
	 *
	 * @param array (list array, message string, link string, uid int, access_token string)
	 * @return bool
	 */
	public function sendInvites($params = array())
	{
		$list = $params['list'];
		$message = $params['message'];
		$link = $params['link'];
		$uid = $params['uid'];
		$user_id = $params['user_id'];

		if (isset($list))
		{
			$api = Engine_Api::_() -> getApi('facebookChat', 'Socialbridge');
			$options = array(
				'uid' => $uid,
				'app_id' => $this -> _objPlugin -> getAppId(),
				'server' => 'chat.facebook.com',
			);
			$access_token = $params['access_token'];
			$connectResult = $api -> xmpp_connect($options, $access_token);

			if (!$connectResult)
			{
				echo 'connect failed';
			}

			$sMessage = $message . ' ' . $link;

			//get max invite per day
			$max_invite = 20;
			$apiSetting = Engine_Api::_() -> getDbtable('apisettings', 'socialbridge');
			$select = $apiSetting -> select() -> where('api_name = ?', $this -> _plugin);
			$provider = $apiSetting -> fetchRow($select);
			if ($provider)
			{
				$api_params = unserialize($provider -> api_params);
				if ($api_params['max_invite_day'])
				{
					$max_invite = $api_params['max_invite_day'];
				}
			}

			$count_invite = 0;

			$values = array(
				'user_id' => $user_id,
				'uid' => $uid,
				'service' => $this -> _plugin,
				'date' => date('Y-m-d')
			);

			$total_invited = $this -> getTotalInviteOfDay($values);
			$count_invite_succ = $total_invited;
			$count_invite = $total_invited;

			$count_queues = 0;
			$arr_user_queues = array();

			foreach ($list as $key => $user)
			{
				try
				{
					if ($count_invite < $max_invite)
					{
						$sendMessageResult = $api -> xmpp_message($to = $key, $body = $sMessage);
						if (!$sendMessageResult)
						{
							$count_queues++;
							$arr_user_queues[$key] = $user;
							//echo 'Send message failed due to some error, will be checked later';
						}
						else
						{
							$count_invite_succ++;
							//echo $sendMessageResult;
						}
					}
					else
					{
						$count_queues++;
						$arr_user_queues[$key] = $user;
					}
					$count_invite++;
				}
				catch(Exception $e)
				{

					throw $e;
				}
			}
			//save statistics
			$values = array(
				'user_id' => $user_id,
				'uid' => $uid,
				'service' => $this -> _plugin,
				'invite_of_day' => $count_invite_succ,
				'date' => date('Y-m-d')
			);
			$this -> createOrUpdateStatistic($values);

			// Save queues
			if ($count_queues > 0)
			{
				$values = array(
					'uid' => $uid,
					'service' => $this -> _plugin,
					'user_id' => $user_id
				);
				$token = $this -> getToken($values);
				if ($token)
				{
					$extra_params['list'] = $arr_user_queues;
					$extra_params['link'] = $link;
					$extra_params['message'] = $message;
					$values = array(
						'token_id' => $token -> token_id,
						'user_id' => $user_id,
						'service' => $this -> _plugin,
						'type' => 'sendInvite',
						'extra_params' => serialize($extra_params),
						'last_run' => date('Y-m-d H:i:s'),
						'status' => 0,
					);
					$this -> saveQueues($values);
					$translate = Zend_Registry::get('Zend_Translate');
					echo $translate -> translate("Some invitations were added to queue!");
				}
			}
			return true;
		}
		return false;
	}

	/**
	 * Post activity
	 *
	 * @param array
	 * @return bool
	 */
	public function postActivity($params = array())
	{
		if ($this -> _objPlugin)
		{
			try
			{
				$this -> _objPlugin -> setAccessToken($params['access_token']);

				$postParam = array(
					'message' => $params['message'],
					'description' => Engine_Api::_() -> getApi('settings', 'core') -> getSetting('core.general.site.title', 'SocialEngine Site')
				);
				if (!empty($params['link']))
				{
					$postParam['link'] = $params['link'];
				}
				// link title
				if (isset($params['name']))
				{
					$postParam['name'] = $params['name'];
				}
				// link caption
				if (isset($params['caption']))
				{
					$postParam['caption'] = $params['caption'];
				}
				// picture url
				if (!empty($params['picture']))
				{
					$postParam['picture'] = $params['picture'];
				}

				$this -> _objPlugin -> api('/me/feed', 'POST', $postParam);
			}
			catch (exception $ex)
			{
				$aResponse['error'] = $ex -> getMessage();
				$aResponse['apipublisher'] = 'facebook';
				return $aResponse;
			}
			return true;
		}
		return false;
	}

	/**
	 * Get login status
	 *
	 * @param array
	 * @return bool
	 */
	public function getLoginStatus($params = array())
	{
		if ($this -> _objPlugin == null)
		{
			return false;
		}
		$token = $this -> _objPlugin -> getAccessToken();
		if ($token)
		{
			$me = $this -> getOwnerInfo();
			if ($me)
				return true;
		}
		return false;
	}

	/**
	 * Get throttle limit
	 *
	 * @param array
	 * @return integer
	 */
	public function getThrottleLimit($params = array())
	{

	}

	/**
	 * Get login URL
	 *
	 * @param array ()
	 * @return string
	 */
	public function getConnectUrl($params = array())
	{
		if ($this -> _objPlugin)
		{
			$request = Zend_Controller_Front::getInstance() -> getRequest();
			$url = $request -> getScheme() . '://' . $request -> getHttpHost() . $request -> getBaseUrl() . '?m=lite&name=fb&module=socialbridge';
			return $url;
		}
	}

	/**
	 * Get login URL
	 *
	 * @param array ()
	 * @return string
	 */
	public function getLoginUrl($params = array())
	{
		if ($this -> _objPlugin)
		{
			return $this -> _objPlugin -> getLoginUrl($params);
		}
	}

	/**
	 * Get logout
	 *
	 * @return string
	 */
	public function getLogoutUrl($params = array())
	{
		if ($this -> _objPlugin && $this -> _objPlugin -> getAccessToken())
		{
			return $this -> _objPlugin -> getLogoutUrl();
		}
	}

	/**
	 * Has permission
	 *@param array(uid, access_token)
	 * @return array
	 */
	public function hasPermission($params = array())
	{
		$permissions = $this -> _objPlugin -> api('/' . $params['uid'] . '/permissions?access_token=' . $params['access_token']);
		if ($permissions)
			return $permissions['data'];
		else
		{
			return null;
		}
	}

	/**
	 *
	 * @param $query
	 * @return array of photos
	 */
	public function facebookQuery($param = array())
	{
		$covers = $this -> _objPlugin -> api(array(
			'method' => 'fql.query',
			'query' => $param['query']
		));
		return $covers;
	}

	/**
	 * Comment on feed
	 *
	 * @param array
	 * @return bool
	 */
	public function addCommentOnFeed($params = array())
	{
		$postParam = array('message' => $params['message']);
		$this -> _objPlugin -> api('/' . $params['postId'] . '/comments', 'POST', $postParam);
	}

	/**
	 * Like feed
	 *
	 * @param array
	 * @return bool
	 */
	public function likeFeed($params = array())
	{
		$this -> _objPlugin -> api('/' . $params['postId'] . '/likes', 'POST');
	}

	/**
	 * Un Like feed
	 *
	 * @param array
	 * @return bool
	 */
	public function unLikeFeed($params = array())
	{
		$this -> _objPlugin -> api('/' . $params['postId'] . '/likes', 'DELETE');
	}

	/**
	 * get Total Friends
	 *
	 */
	public function getTotalFriends($params = array())
	{
		$query = "SELECT uid FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1 = me()) ";
		if (isset($params['search']) && trim($params['search']) != "")
		{
			$query .= "AND strpos(name,'" . $params['search'] . "') >=0 ";
		}
		
		if (isset($params['invited_uids']) && is_array($params['invited_uids']) && count($params['invited_uids']))
		{
			$invitedUids = implode(",", $params['invited_uids']);
			$query .= "AND NOT (uid IN (". $invitedUids. "))";
		}
		
		$friends = $this -> facebookQuery(array('query' => $query));
		return count($friends);
	}
}
