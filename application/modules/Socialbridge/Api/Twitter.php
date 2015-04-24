<?php

/**
 * SocialEngine
 *
 * @category   Application_Socialbridge
 * @package    Socialbridge
 * @copyright  Copyright 2013-2013 YouNet Company
 * @license    http://socialengine.younetco.com/
 * @version    $Id: Abstract.php minhnc $
 * @author     Trunglt
 */

/**
 *
 * @category Application_Socialbridge
 * @package Socialbridge
 * @copyright Copyright 2013-2013 YouNet Company
 * @license http://socialengine.younetco.com/
 */

require_once SOCIALBRIDGE_LIBS_PATH . '/twitter.php';

class Socialbridge_Api_Twitter extends Socialbridge_Api_Abstract
{
	/**
	 * Twitter instance
	 * @var	Twitter
	 */
	protected $_plugin = 'twitter';
	const SHORT_LENGTH_URL = 22;

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
		$user_id = Engine_Api::_() -> user() -> getViewer() -> getIdentity();
		if ($user_id > 0)
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
				$oldToken -> access_token = $_SESSION['socialbridge_session']['twitter']['access_token'];
				$oldToken -> secret_token = $_SESSION['socialbridge_session']['twitter']['secret_token'];
				$oldToken -> creation_date = date('Y-m-d H:i:s');
				//$oldToken->session_id = 1;
				$oldToken -> uid = $this -> getOwnerId();
				//$oldToken->profile = serialize($this->getOwnerInfo($_SESSION['socialbridge_session']['twitter']));
				$oldToken -> save();
			}
			else
			{
				//save new Token
				$values = array(
					'access_token' => $_SESSION['socialbridge_session']['twitter']['access_token'],
					'secret_token' => $_SESSION['socialbridge_session']['twitter']['secret_token'],
					'service' => $this -> _plugin,
					'user_id' => $user_id,
					'uid' => $this -> getOwnerId(),
					//'session_id' => 1,
					//'profile' => serialize($this->getOwnerInfo($_SESSION['socialbridge_session']['twitter']))
				);
				$this -> setToken($values);
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
		$this -> _objPlugin = new Twitter($api_params['key'], $api_params['secret']);
	}

	/*
	 * Returns an array contains every user following the specified user.
	 * @param  string $params['oauth_token'] The token to use.
	 * @param  string $params['oauth_token_secret'] The token secret to use.
	 * @param  string $param['user_id'] User id
	 * @return array(id, name, pic)
	 */
	public function getContacts($params = array())
	{
		if (empty($params['user_id']))
		{
			throw new Exception('Specify user id.');
		}

		try
		{
			$this -> authorize($params['access_token'], $params['secret_token']);

			$friends = $this -> _objPlugin -> followersIds($params['user_id']);

			$return_data = array();
			
			$hasInvitedUids = (isset($params['invited_uids']) 
								&& is_array($params['invited_uids']) 
								&& count($params['invited_uids']));
				
			// get friends info
			if (count($friends['ids']) > 0)
			{
				foreach ($friends['ids'] as $key => $value)
				{
					$users_info = $this -> _objPlugin -> usersLookup($value);
					if ($hasInvitedUids)
					{
						if ( in_array($users_info[0]['id'], $params['invited_uids']))
						{
							continue;
						}
					}
					$return_data[$users_info[0]['id']] = array(
						'id' => $users_info[0]['id'],
						'name' => $users_info[0]['name'],
						'pic' => $users_info[0]['profile_image_url']
					);
				}
			}
		}
		catch (Exception $e)
		{
			echo $e -> getMessage();
		}

		//echo "<pre>".print_r($return_data,true)."</pre>";die;
		return $return_data;
	}

	/*
	 * Returns user object as values passed to the identity (user_id and/or user_name) parameter.
	 * @param  string $params['oauth_token'] The token to use.
	 * @param  string $params['oauth_token_secret'] The token secret to use.
	 * @param  string[optional] $param['user_id'] User id
	 * @param  string[optional] $param['user_name'] User name
	 * @return array
	 */
	public function getUserInfo($params = array())
	{
		$user_name = @(string)$params['user_name'];
		$user_id = @(string)$params['user_id'];
		$response = array();
		if (empty($user_id) && empty($user_name))
		{
			throw new Exception('Specify an user id or an user name.');
		}

		try
		{
			$this -> authorize(@$params['access_token'], @$params['secret_token']);
			if (!empty($user_id))
			{
				$response = $this -> _objPlugin -> usersShow($user_id);
			}
			else
			{
				$response = $this -> _objPlugin -> usersShow(null, $user_name);
			}
		}
		catch (Exception $e)
		{
			echo $e -> getMessage();
		}
		//echo "<pre>"; print_r($response); echo "</pre>"; die;
		return $response;
	}

	/*
	 * Returns user objects for up to 100 users per request, as specified by comma-separated values passed to the user_id
	 * and/or user_name parameters.
	 * @param  string $params['oauth_token'] The token to use.
	 * @param  string $params['oauth_token_secret'] The token secret to use.
	 * @param  mixed[optional] $param['user_ids'] An array of user IDs, up to 100 are allowed in a single request.
	 * @param  mixed[optional] $param['user_names'] An array of user names, up to 100 are allowed in a single request.
	 * @return array
	 */
	public function getUsersInfo($params = array())
	{
		$user_ids = $params['user_ids'];
		$user_names = $params['user_names'];

		if (empty($user_ids) && empty($user_names))
		{
			throw new Exception('Specify user ids or an user names.');
		}

		try
		{
			$this -> authorize($params['access_token'], $params['secret_token']);
			$response = $this -> _objPlugin -> usersLookup($user_ids, $user_names);
		}
		catch (Exception $e)
		{
			echo $e -> getMessage();
		}
		//echo "<pre>"; print_r($response); echo "</pre>"; die;
		return $response;
	}

	/**
	 * Sends a new direct message to the specified user from the authenticating user.
	 * @param  string $params['oauth_token'] The token to use.
	 * @param  string $params['oauth_token_secret'] The token secret to use.
	 * @param string[optional] $params['user_id']  The ID of the user who should receive the direct message.
	 * @param string[optional] $params['user_name'] The user name of the user who should receive the direct message.
	 * @param string $text The text of your direct message. Be sure to URL encode as necessary, and keep the message under
	 * 140 characters.
	 */
	public function sendInvite($params = array())
	{

		if (empty($params['message']))
		{
			throw new Exception('Specify message.');
		}

		if (empty($params['link']))
		{
			throw new Exception('Specify link.');
		}

		if (empty($params['user_id']) && empty($params['user_name']))
		{
			throw new Exception('Specify an user id or an user name.');
		}

		try
		{
			$this -> authorize($params['access_token'], $params['secret_token']);

			$message = $params['message'];
			$link = $params['link'];
			$message = strip_tags($message);
			if (!empty($link))
			{
				$message = substr($message, 0, 140 - strlen($link)) . "\n\r" . $link;
			}
			if (!isset($params['user_name']))
			{
				$params['user_name'] = null;
			}

			$this -> _objPlugin -> directMessagesNew(trim($params['user_id']), $params['user_name'], $message);
		}
		catch (Exception $e)
		{
			echo $e -> getMessage();
		}
	}

	/**
	 * @param array (list array, message string, link string, uid int, access_token string)
	 * Sends a new direct message to many users from the authenticating user.
	 * @param  string $params['oauth_token'] The token to use.
	 * @param  string $params['oauth_token_secret'] The token secret to use.
	 * @param  array $param['list'] An array of user IDs, up to 100 are allowed in a single request.
	 * @param  string message The text of your direct message.
	 * @param  string $param['link'] The link to add to your messge
	 */
	public function sendInvites($params = array())
	{
		if (empty($params['message']))
		{
			throw new Exception('Specify message.');
		}
		if (empty($params['list']))
		{
			throw new Exception('Specify user ids.');
		}
		if (empty($params['link']))
		{
			throw new Exception('Specify link.');
		}

		try
		{
			$user_id = $params['user_id'];
			$uid = $params['uid'];
			//get max invite per day
			$max_invite = 250;
			$service = 'twitter';
			$apiSetting = Engine_Api::_() -> getDbtable('apisettings', 'socialbridge');
			$select = $apiSetting -> select() -> where('api_name = ?', $service);
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
				'service' => $service,
				'date' => date('Y-m-d')
			);
			$total_invited = $this -> getTotalInviteOfDay($values);
			$count_invite_succ = $total_invited;
			$count_invite = $total_invited;

			$count_queues = 0;
			$arr_user_queues = array();
			// send message to user ids
			foreach ($params['list'] as $key => $name)
			{
				if ($count_invite < $max_invite)
				{
					$params['user_id'] = $key;
					$this -> sendInvite($params);
					$count_invite_succ++;
				}
				else
				{
					$count_queues++;
					$arr_user_queues[$key] = $name;
				}
				$count_invite++;
			}

			//save statistics
			$values = array(
				'user_id' => $user_id,
				'uid' => $uid,
				'service' => $service,
				'invite_of_day' => $count_invite_succ,
				'date' => date('Y-m-d')
			);
			$this -> createOrUpdateStatistic($values);

			// Save queues
			if ($count_queues > 0)
			{
				$values = array(
					'uid' => $uid,
					'service' => $service,
					'user_id' => $user_id
				);
				$token = $this -> getToken($values);
				if ($token)
				{
					$extra_params['list'] = $arr_user_queues;
					$extra_params['link'] = $params['link'];
					$extra_params['message'] = $params['message'];
					$values = array(
						'token_id' => $token -> token_id,
						'user_id' => $user_id,
						'service' => $service,
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
		catch (Exception $e)
		{
			echo $e -> getMessage();
			return false;
		}
	}

	/*
	 * Returns authenticating user object
	 * @see Socialbridge_Api_Abstract::getOwnerInfo()
	 */
	public function getOwnerInfo($params = array())
	{
		if (isset($params['access_token']))
			$this -> authorize($params['access_token'], $params['secret_token']);
		if (empty($_SESSION['socialbridge_session']['twitter']['owner_id']) && !isset($params['user_id']))
		{
			throw new Exception('Can not get owner information.');
		}
		if (isset($_SESSION['socialbridge_session']['twitter']['owner_id']))
			$params['user_id'] = $_SESSION['socialbridge_session']['twitter']['owner_id'];
		$me = $this -> getUserInfo($params);
		$me['identity'] = @$me['id'];
		$me['displayname'] = @$me['name'];
		if (isset($me['name']) && !isset($me['first_name']))
		{
			$arr_name = explode(" ", $me['name']);
			$me['first_name'] = @$arr_name[0];
			$me['last_name'] = @$arr_name[1];
		}
		$me['username'] = @$me['screen_name'];
		$me['website'] = @$me['entities']['url']['urls'][0]['display_url'];
		$me['twitter'] = @$me['screen_name'];
		$me['service'] = 'twitter';

		$me['about_me'] = @$me['description'];
		$me['about'] = @$me['description'];
		$me['picture'] = @$me['profile_image_url'];
		$me['photo_url'] = str_replace('normal', 'bigger', @$me['profile_image_url']);
		return $me;
	}

	/*
	 * Returns authenticating user id
	 * @see Socialbridge_Api_Abstract::getOwnerId()
	 */
	public function getOwnerId($params = array())
	{
		if (!empty($_SESSION['socialbridge_session']['twitter']['owner_id']))
		{
			return $_SESSION['socialbridge_session']['twitter']['owner_id'];
		}
		return null;
	}

	/*
	 * authorize Twitter using token and secret token
	 * @param  string $token[optional] The token to use.
	 * @param  string $secret_token[optional] The token secret to use.
	 */
	public function authorize($token = null, $secret_token = null)
	{
		if (!$token && isset($_SESSION['twitter']['oauth_token']))
		{
			$token = @$_SESSION['twitter']['oauth_token'];
		}
		if (!$secret_token && isset($_SESSION['twitter']['oauth_token_secret']))
		{
			$secret_token = @$_SESSION['twitter']['oauth_token_secret'];
		}
		if (empty($token) || empty($secret_token))
		{
			throw new Exception('Specify token and secret token parameters');
		}

		$this -> _objPlugin -> setOAuthToken($token);
		$this -> _objPlugin -> setOAuthTokenSecret($secret_token);
	}

	/*
	 * (non-PHPdoc) @see Socialbridge_Api_Abstract::getActivity()
	 * Returns a collection of the Tweets posted by the authenticating user.
	 * @param  string $params['oauth_token'] The token to use.
	 * @param  string $params['oauth_token_secret'] The token secret to use.
	 * @param int[optional] $params['count'] Specifies the number of records to retrieve. Must be less than or equal to 200.
	 * Defaults to 20.
	 * @param type[optional] $params['type'] Specifies Tweets from user profile or homepage. Defaults to user profile.
	 * @return array
	 */
	public function getActivity($params = array())
	{
		$result = array();
		try
		{
			$this -> authorize($params['access_token'], $params['secret_token']);
			if (!isset($params['limit']))
			{
				$params['limit'] = 5;
			}
			if ($params['type'] != 'friend')
			{
				$result_me = $this -> _objPlugin -> statusesUserTimeline($params['uid'], null, null, null);
			}
			if ($params['type'] != 'me')
			{
				$result_friend = $this -> _objPlugin -> statusesHomeTimeline();
			}
			foreach ($result_me as $feed)
			{
				if (strtotime($feed['created_at']) > $params['lastFeedTimestamp'])
				{
					$result[strtotime($feed['created_at'])] = $feed;
				}
			}
			foreach ($result_friend as $feed)
			{
				if (!in_array($feed, $result) && strtotime($feed['created_at']) > $params['lastFeedTimestamp'])
				{
					if($params['type'] == 'friend')
					{
						if($feed['user']['id'] != $params['uid'])
							$result[strtotime($feed['created_at'])] = $feed;
					}
					else 
					{
						$result[strtotime($feed['created_at'])] = $feed;
					}
				}
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
		}
		catch (Exception $e)
		{
			echo $e -> getMessage();
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
		$this -> authorize($params['access_token'], $params['secret_token']);
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
				$translate = Zend_Registry::get('Zend_Translate');
				$type = $translate->translate('status');
				$type = "<a href = '" . "https://twitter.com/" . $activity['user']['screen_name'] . "/status/". $activity['id'] . "' target = '_blank'>" . $type . "</a>";
				//parse friend_description
				$friend_description = (string)$activity['text'];
				$regex = '@((https?://)?([-\w]+\.[-\w\.]+)+\w(:\d+)?(/([-\w/_\.]*(\?\S+)?)?)*)@';
				$friend_description = preg_replace($regex, '<a href="$1">$1</a>', $friend_description);
				$friend_description= preg_replace("/@(\w+)/", '<a href="http://www.twitter.com/$1" target="_blank">@$1</a>', $friend_description);
    			$friend_description= preg_replace("/\#(\w+)/", '<a href="http://search.twitter.com/search?q=$1" target="_blank">#$1</a>',$friend_description);

				$values = array_merge(array(
					'provider' => 'twitter',
					'user_id' => $user_id,
					'uid' => $uid,
					'timestamp' => strtotime($activity['created_at']),
					'update_key' => $activity['id'],
					'update_type' => $type,
					'photo_url' => '',
					'title' => '',
					'href' => '',
					'description' => '',
					'friend_id' => $activity['user']['id'],
					'friend_name' => $activity['user']['name'],
					'friend_href' => 'https://twitter.com/' . $activity['user']['screen_name'],
					'friend_description' => $friend_description,
				));
	
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
				$stream_settings = $settingTable -> checkExists($viewer -> getIdentity(), 'twitter');
				$auth_view = Engine_Api::_() -> getApi('settings', 'core') -> getSetting('default_tw_view', 'everyone');
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

	/*
	 * @see Socialbridge_Api_Abstract::postActivity()
	 * Updates the authenticating user's status.
	 * @param string $params['oauth_token'] The token to use.
	 * @param string $params['oauth_token_secret'] The token secret to use.
	 * @param string $params['status'] The text of your status update, typically up to 140 characters.
	 * @param string[optional] $params['tweet_id'] The ID of an existing status that the update is in reply to. Note: This
	 * parameter will be ignored unless the author of the tweet this parameter references is mentioned within the status
	 * text. Therefore, you must include @username, where username is the author of the referenced tweet, within the update.
	 * @return array
	 */
	public function postActivity($params = array())
	{
		if ($this -> _objPlugin)
		{
			try
			{
				$this -> authorize($params['access_token'], $params['secret_token']);

				if (empty($params['message']))
				{
					//throw new Exception('Specify message.');
				}
				$message = $params['message'];
				$message = strip_tags($message);
				if (!empty($params['link']))
				{
					$link = $params['link'];
					$message = substr($message, 0, 140 - Socialbridge_Api_Twitter::SHORT_LENGTH_URL) . " " . $link;
					//$message = substr($message, 0, 140 - strlen($link)) . "\n\r" . $link;
				}

				$reply_to_status_id = $params['tweet_id'] ? $params['tweet_id'] : null;
				if ($reply_to_status_id)
				{
					$author_name = $this -> getStatusAuthorName($params);
					$message = "@$author_name " . $message;
				}
				$response = $this -> _objPlugin -> statusesUpdate($message, $reply_to_status_id);
				return true;
			}
			catch (Exception $e)
			{
				return $e -> getMessage();
			}
		}
		return false;
	}

	/**
	 * Comment on feed
	 *
	 * @param array
	 * @return bool
	 */
	public function addCommentOnFeed($params = array())
	{
		$params['tweet_id'] = $params['postId'];
		$this -> postActivity($params);
	}

	/**
	 * Like feed
	 *
	 * @param array
	 * @return bool
	 */
	public function likeFeed($params = array())
	{
		if ($this -> _objPlugin)
		{
			try
			{

				$this -> authorize($params['access_token'], $params['secret_token']);
				$this -> _objPlugin -> favoritesCreate($params['postId']);
			}
			catch (Exception $e)
			{
				return $e -> getMessage();
			}
		}

	}

	/**
	 * Un Like feed
	 *
	 * @param array
	 * @return bool
	 */
	public function unLikeFeed($params = array())
	{
		if ($this -> _objPlugin)
		{
			try
			{
				$this -> authorize($params['access_token'], $params['secret_token']);
				$this -> _objPlugin -> favoritesDestroy($params['postId']);
			}
			catch (Exception $e)
			{
				return $e -> getMessage();
			}
		}
	}

	/**
	 * Returns a single Tweet, specified by the id parameter. The Tweet's author will also be embedded within the tweet.
	 * @param string $params['oauth_token_secret'] The token secret to use.
	 * @param string $params['status'] The text of your status update, typically up to 140 characters.
	 * @param  string $params['tweet_id'] The numerical ID of the desired Tweet.
	 * @return array
	 */
	public function getStatusAuthorName($params = array())
	{
		try
		{
			$this -> authorize($params['access_token'], $params['secret_token']);
			if (empty($params['tweet_id']))
			{
				throw new Exception('Specify tweet id');
			}
			$tweet_id = $params['tweet_id'];
			$respone = $this -> _objPlugin -> statusesShow($tweet_id);
			return $respone['user']['screen_name'];
		}
		catch (Exception $e)
		{
			echo $e -> getMessage();
		}
	}

	/*
	 * (non-PHPdoc) @see Socialbridge_Api_Abstract::getAlbums()
	 */
	public function getAlbums($params = array())
	{
		// TODO Auto-generated method stub
	}

	/*
	 * (non-PHPdoc) @see Socialbridge_Api_Abstract::getAlbumInfo()
	 */
	public function getAlbumInfo($params = array())
	{
		// TODO Auto-generated method stub
	}

	/*
	 * (non-PHPdoc) @see Socialbridge_Api_Abstract::getPhotos()
	 */
	public function getPhotos($params = array())
	{
		// TODO Auto-generated method stub
	}

	/*
	 * (non-PHPdoc) @see Socialbridge_Api_Abstract::getPhotoInfo()
	 */
	public function getPhotoInfo($params = array())
	{
		// TODO Auto-generated method stub
	}

	/*
	 * (non-PHPdoc) @see Socialbridge_Api_Abstract::getLoginStatus()
	 */
	public function getLoginStatus($params = array())
	{
		// TODO Auto-generated method stub
	}

	/*
	 * @see Socialbridge_Api_Abstract::getThrottleLimit()
	 * Returns the current configuration used by Twitter
	 */
	public function getThrottleLimit($params = array())
	{
		try
		{
			$this -> authorize($params['access_token'], $params['secret_token']);
			return $this -> _objPlugin -> helpConfiguration();
		}
		catch (Exception $e)
		{
			echo $e -> getMessage();
		}
	}

	/*
	 * (non-PHPdoc) @see Socialbridge_Api_Abstract::getConnectUrl()
	 */
	public function getConnectUrl($params = array())
	{
		// TODO Auto-generated method stub
		if ($this -> _objPlugin)
		{
			$request = Zend_Controller_Front::getInstance() -> getRequest();
			$url = $request -> getScheme() . '://' . $request -> getHttpHost() . $request -> getBaseUrl() . '?m=lite&name=tw&module=socialbridge';
			return $url;
		}
	}

	/*
	 * get oauth_token value and redirect to the page to authorize the applicatione
	 */
	public function authorizeRequest($params = array())
	{
		// TODO Auto-generated method stub
		$response = $this -> _objPlugin -> oAuthRequestToken($params['url']);
		$this -> _objPlugin -> oAuthAuthorize($response['oauth_token']);
	}

	/*
	 * (non-PHPdoc) @see Socialbridge_Api_Abstract::getLogoutUrl()
	 */
	public function getLogoutUrl($params = array())
	{
		// TODO Auto-generated method stub
	}

	/*
	 * (non-PHPdoc) @see Socialbridge_Api_Abstract::hasPermission()
	 */
	public function hasPermission($params = array())
	{
		// TODO Auto-generated method stub
	}

	/*
	 *
	 *
	 */
	public function getAuthAccessToken($params = array())
	{
		return $this -> _objPlugin -> oAuthAccessToken($params['oauth_token'], $params['oauth_verifier']);
	}

	/* (non-PHPdoc)
	 * @see Socialbridge_Api_Abstract::getLoginUrl()
	 */
	public function getLoginUrl($params = array())
	{
		// TODO Auto-generated method stub
	}

}
