<?php
/**
 * SocialEngine
 *
 * @category   Application_Socialbridge
 * @package    Socialbridge
 * @copyright  Copyright 2013-2013 YouNet Company
 * @license    http://socialengine.younetco.com/
 * @version    $Id: Abstract.php minhnc $
 * @author     LuanND
 */

/**
 * @category   Application_Socialbridge
 * @package    Socialbridge
 * @copyright  Copyright 2013-2013 YouNet Company
 * @license    http://socialengine.younetco.com/
 */

require_once SOCIALBRIDGE_LIBS_PATH . '/linkedin.php';

class Socialbridge_Api_Linkedin extends Socialbridge_Api_Abstract
{
	protected $_plugin = 'linkedin';
	public  $_api_params = null;

	public function __construct()
	{
		if (!$this -> _objPlugin)
		{
			$this->getPlugin();
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
		if($user_id > 0)
		{
			//get token old if exists
			$params = array(
					'service' => $this->_plugin,
					'user_id' => $user_id
					//'uid'	  => $this->getOwnerId()
				);
			$oldToken = $this->getToken($params);

			if($oldToken)
			{
				// update token
				$oldToken->access_token = $_SESSION['socialbridge_session']['linkedin']['access_token'];
				$oldToken->secret_token = $_SESSION['socialbridge_session']['linkedin']['secret_token'];
				$oldToken->creation_date = date('Y-m-d H:i:s');
				//$oldToken->session_id = 1;
				$oldToken->uid	  = $this->getOwnerId();
				//$oldToken->profile = serialize($this->getOwnerInfo());
				$oldToken->save();
			}
			else
			{
				//save new Token
				$values = array(
					'access_token' => $_SESSION['socialbridge_session']['linkedin']['access_token'],
					'secret_token' =>  $_SESSION['socialbridge_session']['linkedin']['secret_token'],
					'service' => $this->_plugin,
					'user_id' => $user_id,
					'uid'	  => $this->getOwnerId(),
					//'session_id' => 1,
					//'profile' => serialize($this->getOwnerInfo())
				);
				$this->setToken($values);
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
		$select = $apiSetting->select()->where('api_name = ?',$this->_plugin);
		$provider = $apiSetting->fetchRow($select);
		if ($provider == null)
		{
			return false;
		}
		$api_params = unserialize($provider -> api_params);
		if(isset($_GET['oauth_callback']) && $_GET['oauth_callback']!= null)
		{

			$this ->_objPlugin = new linkedin_API(array(
				'appKey' => $api_params['key'],
				'appSecret' =>$api_params['secret'],
				'callbackUrl' => $_GET['oauth_callback']
			));
		}
		else
		{

			$this ->_objPlugin = new linkedin_API(array(
				'appKey' => $api_params['key'],
				'appSecret' =>$api_params['secret']	,
				'callbackUrl' => ''
			));
		}
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
			$this->initConnect();
			$response = $this->_objPlugin->connections();
	        $connections = new SimpleXMLElement($response['linkedin']);
			$datatopost = null;
			$index =0;
			foreach($connections as $con)
			{
				$datatopost .= 'id_'.$index.','.(string)$con->id.',name_'.$index.','.(string)$con->{'first-name'}.',pic_'.$index.','.(string)$con->{'picture-url'}.',';
				$index++;

			}
			
			$hasInvitedUids = (isset($params['invited_uids']) 
								&& is_array($params['invited_uids']) 
								&& count($params['invited_uids']));
			
			if($index==0)
				return array();
			else
			{
				$array_data = explode(',', $datatopost);
				$count = count($array_data) - 1;
				$contacts = array();
				for ($i = 0; $i < $count - 1; $i += 6)
				{
					if ($hasInvitedUids)
					{
						if ( in_array($array_data[$i + 1], $params['invited_uids']))
						{
							continue;
						}
					}
					$contacts[$array_data[$i + 1]] = array(
						'id' => $array_data[$i + 1],
						'name' => $array_data[$i + 3],
						'pic' => $array_data[$i + 5]
					);
				}
			}


			return $contacts;
		}
		return null;
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
			$url = $request -> getScheme() . '://' . $request -> getHttpHost() . $request -> getBaseUrl() . '?m=lite&name=li&module=socialbridge';
			return $url;
		}
	}

	private function initConnect($params = array())
	{
		$access = array(
	            'oauth_callback_confirmed' => true,
	            'xoauth_request_auth_url' => 'https://api.linkedin.com/uas/oauth/authorize',
	            'oauth_expires_in' => 599);
		if(!isset($params['secret_token']))
		{
			$access['oauth_token'] = $_SESSION['socialbridge_session']['linkedin']['access_token'];
	        $access['oauth_token_secret'] = $_SESSION['socialbridge_session']['linkedin']['secret_token'];
		}
		else
		{
			$access['oauth_token'] = $params['access_token'];
	        $access['oauth_token_secret'] = $params['secret_token'];
		}
	    $this->_objPlugin->setTokenAccess($access);
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
			$this->initConnect($params);

			$fields = '';
			if(!isset($params['fields']) || $params['fields'] == '')
				$fields = '~:(id,first-name,last-name,maiden-name,formatted-name,phonetic-first-name,phonetic-last-name,formatted-phonetic-name,headline,location,industry,distance,relation-to-viewer,current-status,current-status-timestamp,current-share,num-connections,num-connections-capped,summary,specialties,positions,picture-url,site-standard-profile-request,api-standard-profile-request,public-profile-url,email-address,last-modified-timestamp,proposal-comments,associations,honors,interests,publications,patents,languages,skills,certifications,educations,courses,volunteer,three-current-positions,three-past-positions,num-recommenders,recommendations-received,mfeed-rss-url,following,job-bookmarks,suggestions,date-of-birth,member-url-resources,related-profile-views)';
			$response = $this->_objPlugin->profile($fields);

	        $connections = new SimpleXMLElement($response['linkedin']);

			$arr_data = (array)$connections;

			if(count($arr_data)> 0)
			{
				$me = $arr_data;
				$me['identity'] = @$arr_data['id'];
				$me['first_name'] = @$arr_data['first-name'];
				$me['last_name'] = @$arr_data['last-name'];
				$me['username'] = @$me['first_name'] .@$me['last_name'];
				$me['displayname'] = @$me['formatted-name'];
				$me['picture'] = @$me['picture-url'];
				$me['photo_url'] = @$me['picture-url'];
				$me['email'] = @$me['email-address'];
				$me['service'] = 'linkedin';
				$year = @$me['date-of-birth']->year;
				$month = @$me['date-of-birth']->month;
				$day= @$me['date-of-birth']->day;

				if (!empty($year) && !empty($month) && !empty($day))
				{
					$me['birthdate'] = date("Y-m-d", strtotime($year.'-'.$month.'-'.$day));
				}
				return $me;
			}
			return null;
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
		if ($this -> _objPlugin)
		{
			$this->initConnect();
			$fields = '~:(id)';
			$response = $this->_objPlugin->profile($fields);
	        $connections = new SimpleXMLElement($response['linkedin']);
			if(!empty($connections->id))
				return (string)$connections->id;
			return null;
		}
		return null;
	}

	/**
	 * Get user info
	 *
	 * @param array (uid)
	 * @return array (id, name, first_name, last_name, link,...)
	 */
	public function getUserInfo($params = array())
	{

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
	 * @return array
	 */
	public function getPhotos($params = array())
	{

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
	public function getActivity($params = array('lastFeedTimestamp' => 0,'limit' => 5))
	{
		$result = array();
		if ($this -> _objPlugin)
		{
			$_SESSION['socialbridge_session']['linkedin']['stream'] = 1;
			$access['oauth_token'] = $params['access_token'];
	        $access['oauth_token_secret'] = $params['secret_token'];
	    	$this->_objPlugin->setTokenAccess($access);
			$this->initConnect($params);
			
			if($params['type'] != 'me')
			{
				//Connection Updates
				$fields = '?type=CONN';
				if($params['lastFeedTimestamp'])
				{
					$fields .= '&after='.(int)($params['lastFeedTimestamp'] + 1);
				}
				$response = $this->_objPlugin->updates($fields);
				if($response['success'])
		        {
		        	$activities = new SimpleXMLElement($response['linkedin']);
					$activities = (array)$activities;
					if($activities['@attributes']['total'] == 1)
						$updates = array('0' => (array)$activities['update']);
					else
						$updates = (array)@$activities['update'];
					
					foreach($updates as $update)
					{
						$update = (array)$update;
						$result[$update['timestamp']] = $update;
					}
				}

				//Joined a Group
				$fields = '?type=JGRP';
				if($params['lastFeedTimestamp'])
				{
					$fields .= '&after='.(int)($params['lastFeedTimestamp'] + 1);
				}
				$response = $this->_objPlugin->updates($fields);
				if($response['success'])
		        {
		        	$activities = new SimpleXMLElement($response['linkedin']);
					$activities = (array)$activities;
					if($activities['@attributes']['total'] == 1)
						$updates = array('0' => (array)$activities['update']);
					else
						$updates = (array)@$activities['update'];
					foreach($updates as $update)
					{
						$update = (array)$update;
						$result[$update['timestamp']] = $update;
					}
				}

				//Shared item
				$fields = '?type=SHAR';
				if($params['lastFeedTimestamp'])
				{
					$fields .= '&after='.(int)($params['lastFeedTimestamp'] + 1);
				}
				$response = $this->_objPlugin->updates($fields);
				if($response['success'])
		        {
		        	$activities = new SimpleXMLElement($response['linkedin']);
					$activities = (array)$activities;
					if($activities['@attributes']['total'] == 1)
						$updates = array('0' => (array)$activities['update']);
					else
						$updates = (array)@$activities['update'];
					foreach($updates as $update)
					{
						$update = (array)$update;
						$result[$update['timestamp']] = $update;
					}
				}
	
				//All updates
				$fields = '';
				if($params['lastFeedTimestamp'])
				{
					$fields .= '?after='.$params['lastFeedTimestamp'];
				}
				$response = $this->_objPlugin->updates($fields);
				if($response['success'])
		        {
		        	$activities = new SimpleXMLElement($response['linkedin']);
					$activities = (array)$activities;
					$updates = (array)@$activities['update'];
					foreach($updates as $update)
					{
						$update = (array)$update;
						$result[$update['timestamp']] = $update;
					}
				}
			}
			if($params['type'] != 'friend')
			{
				//get self
				$fields = '?scope=self';
				if($params['lastFeedTimestamp'])
				{
					$fields .= '&after='.(int)($params['lastFeedTimestamp'] + 1);
				}
				$response = $this->_objPlugin->updates($fields);
				if($response['success'])
		        {
		        	$activities = new SimpleXMLElement($response['linkedin']);
					$activities = (array)$activities;
					if($activities['@attributes']['total'] == 1)
						$updates = array('0' => (array)$activities['update']);
					else
						$updates = (array)@$activities['update'];
					foreach($updates as $update)
					{
						$update = (array)$update;
						$result[$update['timestamp']] = $update;
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
		$access['oauth_token'] = $params['access_token'];
        $access['oauth_token_secret'] = $params['secret_token'];
    	$this->_objPlugin->setTokenAccess($access);
		$viewer = $params['viewer'];
		$user_id = $viewer->getIdentity();
		$uid = $params['uid'];
		$activities = $params['activities'];
	  	foreach($activities as $activity)
		{
			if($activity['update-content']->{'person'}->{'first-name'} != 'private')
			{
				$table = new Socialstream_Model_DbTable_Feeds;
		    	$db = $table -> getAdapter();
		    	$db -> beginTransaction();
		    	try
		    	{
		    		$translate = Zend_Registry::get('Zend_Translate');
		    		$type = $activity['update-type'];
					$person = (array)$activity['update-content']->{'person'};
					
					//friend info
					$friend_description = @$person['current-status'];
					$friend_name = (string)@$person['first-name'].' '.(string)@$person['last-name'];
					$friend_href = (string)@$person['site-standard-profile-request']->{'url'};
					$href_friend = "<a href = '".$friend_href."' target = '_blank'>".$friend_name."</a>";

					$arr_info = array();
		    		//check type and get data.
		    		switch ($type)
		    		{
						case 'CONN':
							$type = $translate->translate('connection');
							//object info
							$arr_info['photo_url'] = (string)$person['connections']->{'person'}->{'picture-url'};
							$arr_info['title'] = (string)$person['connections']->{'person'}->{'first-name'}.' '. (string)$person['connections']->{'person'}->{'last-name'};
							$arr_info['href'] = (string)$person['connections']->{'person'}->{'site-standard-profile-request'}->{'url'};
							$arr_info['description'] = (string)$person['connections']->{'person'}->{'headline'};

							$friend_description = $href_friend.$translate->translate(" has a new connection.");
							$type = "<a href = '" .$friend_href. "' target = '_blank'>" . $type . "</a>";
							break;

						case 'PROF':
							$type = $translate->translate('profile');
							if($activity['updated-fields']->{'update-field'}->{'name'} == 'person/skills')
							{
								$skills = (array)$person['skills'];
								if($skills)
								{
									$description = "</br>".$translate->translate("Skills")." - ";
									$count = 0;
									foreach($skills['skill'] as $skill)
									{
										$count ++;
										$description.= $skill->{'skill'}->{'name'};
										if($count < $skills['@attributes']['count'])
											$description .= ', ';
									}
								}
								$friend_description = $href_friend.$translate->translate(" has an updated profile.");
								$friend_description .= $description;
							}
							$type = "<a href = '" . $friend_href . "' target = '_blank'>" . $type . "</a>";
							break;
						case 'JGRP':
							$type = $translate->translate('group');
							$group = @$person['member-groups']->{'member-group'};
							$group_href = (string)@$group->{'site-group-request'}->{'url'};
							$result = array();
							if($group_href)
							{
								try
								{
									$client = new Zend_Http_Client($group_href, array(
								        'maxredirects' => 2,
								        'timeout'      => 10,
								      ));
								      // Try to mimic the requesting user's UA
								      $client->setHeaders(array(
								        'User-Agent' => @$_SERVER['HTTP_USER_AGENT'],
								        'X-Powered-By' => 'Zend Framework'
								      ));

								      $response = $client->request();
									  list($contentType) = explode(';', $response->getHeader('content-type'));
									  // Handling based on content-type
								      switch( strtolower($contentType) )
								      {
								        // Images
								        case 'image/gif':
								        case 'image/jpeg':
								        case 'image/jpg':
								        case 'image/tif': // Might not work
								        case 'image/xbm':
								        case 'image/xpm':
								        case 'image/png':
								        case 'image/bmp': // Might not work
								          $result = $this->_parseImage($group_href, $response);
								          break;

								        // HTML
								        case '':
								        case 'text/html':
								          $result = $this->_parseHtml($group_href, $response);
								          break;

								        // Plain text
								        case 'text/plain':
								          $result = $this->_parseText($group_href, $response);
								          break;

								        // Unknown
								        default:
								          break;
								      }
								}
								catch( Exception $e )
							    {
							      throw $e;
							    }
							}
							$arr_info['photo_url'] = @$result['uri'];
							$arr_info['title'] = @$result['title'];
							$arr_info['href'] = $group_href;
							$arr_info['description'] = @$result['description'];
							$friend_description = $href_friend.$translate->translate(" joined a group:");
							$type = "<a href = '" . $arr_info['href'] . "' target = '_blank'>" . $type . "</a>";
							break;

						case 'SHAR':
							$type = $translate->translate('share');
							$share = (array)@$person['current-share'];
							$arr_info['photo_url'] = (string)@$share['content']->{'submitted-image-url'};
							$arr_info['title'] = (string)@$share['content']->{'title'};
							$arr_info['href'] = (string)@$share['content']->{'submitted-url'};
							$arr_info['description'] = (string)@$share['content']->{'description'};
							$friend_description = (string)@$share['comment'];
							$regex = '@((https?://)?([-\w]+\.[-\w\.]+)+\w(:\d+)?(/([-\w/_\.]*(\?\S+)?)?)*)@';
							$friend_description = preg_replace($regex, '<a href="$1">$1</a>', $friend_description);
							$type = "<a href = '" . (string)@$share['content']->{'eyebrow-url'} . "' target = '_blank'>" . $type . "</a>";
							break;

						case 'STAT':
							$type = $translate->translate('status');
							$regex = '@((https?://)?([-\w]+\.[-\w\.]+)+\w(:\d+)?(/([-\w/_\.]*(\?\S+)?)?)*)@';
							$friend_description = preg_replace($regex, '<a href="$1">$1</a>', $friend_description);
							$type = "<a href = '" . $friend_href . "' target = '_blank'>" . $type . "</a>";
							break;
						case 'PICU':
							$type = $translate->translate('photo');
							if($person['id'] != 'private')
								$friend_description = $href_friend.$translate->translate(" has a new profile picture.");
							$type = "<a href = '" . $friend_href . "' target = '_blank'>" . $type . "</a>";
							break;

						case 'PRFX':
							$type = $translate->translate('profile');
							$friend_description = $href_friend.$translate->translate(" has updated their extended profile data.");
							$type = "<a href = '" . $friend_href . "' target = '_blank'>" . $type . "</a>";
							break;

						default:
							$type = $translate->translate('feed');
							$type = "<a href = '" . (string)@$person['site-standard-profile-request']->{'url'} . "' target = '_blank'>" . $type . "</a>";
							break;
					}
		    		$values = array_merge(array(
					  	'provider' 		=> 'linkedin',
						'user_id'		=> $user_id,
						'uid'			=> $uid,
					  	'timestamp' 	=> (string)$activity['timestamp'],
					  	'update_key' 	=> (string)$activity['update-key'],
					  	'update_type' 	=> $type,

					  	'photo_url' 	=> @$arr_info['photo_url'],
					  	'title' 		=> @$arr_info['title'],
					  	'href'			=> @$arr_info['href'],
					 	'description'	=> @$arr_info['description'],

					 	'friend_id'		=> (string)@$person['id'],
					 	'friend_name'	=> $friend_name,
					 	'friend_href'	=> $friend_href,
					 	'friend_description'	=> $friend_description,

					));
					//save feed
		    		$feed = $table -> createRow();
		    		$feed -> setFromArray($values);
		    		$feed -> save();

					// Auth
				    $auth = Engine_Api::_()->authorization()->context;
				    $roles = array('owner', 'owner_member','everyone');
				    
					$settingTable = Engine_Api::_() -> getDbTable('settings', 'socialstream');
					$stream_settings = $settingTable -> checkExists($viewer -> getIdentity(), 'linkedin');
					$auth_view = Engine_Api::_() -> getApi('settings', 'core') -> getSetting('default_li_view', 'everyone');
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
					$this->addActivity($feed, $viewer);

		    		$db -> commit();

		    	} catch( Exception $e ) {
		    		$db -> rollBack();
		    		throw $e;
		    	}
		    }
		}
	}

	/**
	 * Send invite
	 *
	 * @param array (to string, message string, link string, uid int, access_token string)
	 * @return bool
	 */
	public function sendInvite($arr = array())
	{
		if($this->_objPlugin)
		{
			try
			{
				$mailtemp = $arr['message'].$arr['link'];
				$user_id = $arr['user_id'];
				$inviter = Engine_Api::_() -> getItem('user', $user_id);
				$this->initConnect();
				$members = array();
				$members[] = key($arr['list']);

		        $response = $this->_objPlugin->message($members, $inviter -> displayname, htmlspecialchars($mailtemp), true);

		        if($response['success'] === TRUE) {
		          //successful
		        }
			} catch (Exception $e)
			{
				echo "Error sending message:\n\nRESPONSE:\n\n" . print_r($e->getMessage(), TRUE) . "\n\nLINKEDIN OBJ:\n\n" ;
			}

		}
	}

	/**
	 * Send invites
	 *
	 * @param array (list array, message string, link string, uid int, access_token string)
	 * @return bool
	 */


	public function sendInvites($arr = array())
	{

		if($this->_objPlugin)
		{
			try
			{
				$mailtemp = $arr['message'].$arr['link'];
				$user_id = $arr['user_id'];
				$uid = $arr['uid'];
				$this->initConnect($arr);

				//get max invite per day
				$max_invite = 10;
				$service = 'linkedin';
				$apiSetting = Engine_Api::_() -> getDbtable('apisettings', 'socialbridge');
				$select = $apiSetting->select()->where('api_name = ?',$service);
				$provider = $apiSetting->fetchRow($select);
				if($provider)
				{
					$api_params = unserialize($provider -> api_params);
					if($api_params['max_invite_day'])
					{
						$max_invite = $api_params['max_invite_day'];
					}
				}

				$count_invite = 0;

				$values = array('user_id' => $user_id, 'uid' => $uid, 'service' => $service, 'date' => date('Y-m-d'));
				$total_invited = $this->getTotalInviteOfDay($values);
				$count_invite_succ = $total_invited;
				$count_invite = $total_invited;

				$count_queues = 0;
				$arr_user_queues = array();

				$members = array();
				foreach($arr['list'] as $key => $name)
				{
					if($count_invite < $max_invite)
					{
						$members[] = $key;
					}
					else
					{
						$count_queues ++;
						$arr_user_queues[$key] = $name;
					}
					$count_invite ++;
				}

				$inviter = Engine_Api::_() -> getItem('user', $user_id);
				if(count($members) > 0)
				{
		        	$response = $this->_objPlugin->message($members, $inviter -> displayname, htmlspecialchars($mailtemp), true);
			        if($response['success'] === TRUE)
			        {
			        	$count_invite_succ = $count_invite_succ + count($members);
			        }
				}
				//save statistics
				$values = array('user_id' => $user_id, 'uid' => $uid, 'service' => $service, 'invite_of_day'=> $count_invite_succ,'date' => date('Y-m-d'));
				$this->createOrUpdateStatistic($values);

				// Save queues
				if($count_queues > 0)
				{
					$values = array(
							'uid' => $uid,
							'service' => $service,
							'user_id' => $user_id
						);
					$token = $this->getToken($values);
					if($token)
					{
						$extra_params['list'] = $arr_user_queues;
						$extra_params['link'] = $arr['link'];
						$extra_params['message'] = $arr['message'];
						$values = array(
								'token_id' => $token->token_id,
								'user_id' => $user_id,
								'service' => $service,
								'type' => 'sendInvite',
								'extra_params' => serialize($extra_params),
								'last_run' => date ('Y-m-d H:i:s'),
								'status' => 0,
								);
						$this->saveQueues($values);
						$translate = Zend_Registry::get('Zend_Translate');
						echo $translate->translate("Some invitations were added to queue!");
					}
				}
				return true;
			}
			catch (Exception $e)
			{
				echo "Error sending message:\n\nRESPONSE:\n\n" . print_r($e->getMessage(), TRUE) . "\n\nLINKEDIN OBJ:\n\n" ;
				return false;
			}
		}
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
	        try {
    	        $content = array(
    	                'comment' => $params['comment'],
    	                'title' => $params['title'],
    	                'submitted-url' => $params['submitted-url'],
    	                'description' => $params['description']
    	        );
    	        if (!empty($params['submitted-image-url'])) {
    	            $content['submitted-image-url'] = $params['submitted-image-url'];
    	        }

    	        //$content => ('comment' => 'xxx', 'title' => 'xxx', 'submitted-url' => 'xxx', 'submitted-image-url' => 'xxx', 'description' => 'xxx')
    	        $this->initConnect($params);
    	        if (!empty($params['message']) && !empty($params['link'])) {
    	            $status = "<a href='{$params['link']}' target='_blank'>{$params['message']}</a>";
    	        }

	            $response = $this -> _objPlugin->share('new', $content, FALSE);
	            return true;
	        } catch (Exception $e) {
	            return $e->getMessage();
	        }
	    }
	    return false;

	}

	/**
	 * Share comment posting method.
	 * 
	 * Post a comment on an existing connections shared content. API details can
	 * be found here: 
	 * 
	 * http://developer.linkedin.com/docs/DOC-1043 
	 * 
	 * @param str $uid 
	 *    The LinkedIn update ID.   	 
	 * @param str $comment 
	 *    The share comment to be posted.
	 *            	 
	 * @return arr 
	 *    Array containing retrieval success, LinkedIn response.       	 
	 */
	public function addCommentOnFeed($params = array())
	{
		if ($this -> _objPlugin)
	    {
	    	$this->initConnect($params);
	    	$this -> _objPlugin->comment($params['postId'], $params['message']);
		}
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
	    	$this->initConnect($params);
	    	$this -> _objPlugin->like($params['postId']);
		}
	}
	
	/**
	 * Like feed
	 *
	 * @param array
	 * @return bool
	 */
	public function unLikeFeed($params = array())
	{
		if ($this -> _objPlugin)
	    {
	    	$this->initConnect($params);
	    	$this -> _objPlugin->unlike($params['postId']);
		}
	}
	/**
	 * Get login status
	 *
	 * @param array
	 * @return bool
	 */
	public function getLoginStatus($params = array())
	{

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
	 * @param array (name, module)
	 * @return string
	 */
	public function getLoginUrl($params = array('name'=> 'li', 'module' => 'contactimporter'))
	{
		$name = $params['name'];
		$module = $params['module'];
		if ($this -> _fbAdapter)
		{
			$request = Zend_Controller_Front::getInstance() -> getRequest();
			$url = $request -> getScheme() . '://' . $request -> getHttpHost() . $request -> getBaseUrl() . '?m=lite&name='.$name.'&module='.$module;
			$_SESSION['en4_baseurl'] = $request -> getBaseUrl();
			return $url;
		}
	}

	/**
	 * Get logout
	 *
	 * @return string
	 */
	public function getLogoutUrl($params = array())
	{

	}

	/**
	 * Has permission
	 *
	 * @return bool
	 */
	public function hasPermission($params = array())
	{

	}
	// MinhNC add

	public function getGetType()
	{
		return $this->_objPlugin->getGetType();
	}
	public function getGetResponse()
	{
		return $this->_objPlugin->getGetResponse();
	}
	public function retrieveTokenRequest($params = array())
	{
		return $this->_objPlugin->retrieveTokenRequest($params);
	}
	public function getUrlAuth()
	{
		return $this->_objPlugin->getUrlAuth();
	}
	public function retrieveTokenAccess($token, $secret, $verifier)
	{
		return $this->_objPlugin->retrieveTokenAccess($token, $secret, $verifier);
	}
	public function getProfile()
	{
		return $this->_objPlugin->profile();
	}
}
