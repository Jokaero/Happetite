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
abstract class Socialbridge_Api_Abstract
{
	protected $_objPlugin = null;
	protected $_plugin = '';

	/**
	 * Get plugin
	 *
	 * @return
	 */
	abstract public function getPlugin($params = array());
	
	/**
	 * Save Token
	 *
	 * @return
	 */
	abstract public function saveToken($params = array());

	/**
	 * Get contact list
	 *
	 * @return array (id, pic, name)
	 */
	abstract public function getContacts($params = array());

	/**
	 * Get owner info
	 *
	 * @return array (id, name, first_name, last_name, link,...)
	 */
	abstract public function getOwnerInfo($params = array());

	/**
	 * Get owner id
	 *
	 * @return string
	 */
	abstract public function getOwnerId($params = array());

	/**
	 * Get user info
	 *
	 * @return array
	 */
	abstract public function getUserInfo($params = array());

	/**
	 * Get users info
	 *
	 * @return array
	 */
	abstract public function getUsersInfo($params = array());

	/**
	 * Get albums
	 *
	 * @return array
	 */
	abstract public function getAlbums($params = array());

	/**
	 * Get album info
	 *
	 * @return array
	 */
	abstract public function getAlbumInfo($params = array());

	/**
	 * Get photos
	 *
	 * @return array
	 */
	abstract public function getPhotos($params = array());

	/**
	 * Get photo info
	 *
	 * @return array
	 */
	abstract public function getPhotoInfo($params = array());

	/**
	 * Get activity
	 *
	 * @param array(lastFeedTimestamp, limit)
	 * @return array (post_id,actor_id,target_id,message,description,created_time,attachment,permalink,description_tags,type)
	 */
	abstract public function getActivity($params = array());

	/**
	 * Insert feeds
	 *
	 * @param array(activities, viewer, timestamp)
	 * @return bool
	 */
	abstract public function insertFeeds($params = array());

	/**
	 * Send invite
	 *
	 * @param array (to string, message string, link string, uid int, access_token string)
	 * @return bool
	 */
	abstract public function sendInvite($params = array());

	/**
	 * Send invites
	 *
	 * @param array (list array, message string, link string, uid int, access_token string)
	 * @return bool
	 */
	abstract public function sendInvites($params = array());

	/**
	 * Post activity
	 *
	 * @param array
	 * @return bool
	 */
	abstract public function postActivity($params = array());
	
	/**
	 * Comment on feed
	 *
	 * @param array
	 * @return bool
	 */
	abstract public function addCommentOnFeed($params = array());
	
	
	/**
	 * Like feed
	 *
	 * @param array
	 * @return bool
	 */
	abstract public function likeFeed($params = array());
	
	/**
	 * Un-Like feed
	 *
	 * @param array
	 * @return bool
	 */
	abstract public function unLikeFeed($params = array());

	/**
	 * Get login status
	 *
	 * @param array
	 * @return string
	 */
	abstract public function getLoginStatus($params = array());

	/**
	 * Get throttle limit
	 *
	 * @param array
	 * @return integer
	 */
	abstract public function getThrottleLimit($params = array());

	/**
	 * Get login URL
	 *
	 * @param array
	 * @return string
	 */
	abstract public function getLoginUrl($params = array());

	/**
	 * Get logout
	 *
	 * @return string
	 */
	abstract public function getLogoutUrl($params = array());

	/**
	 * Has permission
	 *
	 * @return bool
	 */
	abstract public function hasPermission($params = array());
	/*
	 * get Token
	 *
	 */
	public function getToken($params = array())
	{
		$tokenTable = Engine_Api::_() -> getDbtable('tokens', 'socialbridge');
		$select = $tokenTable -> select() 
			-> where('service = ?', $params['service']) 
			-> where('user_id = ?', $params['user_id']);
		 	//-> where('uid = ?', $params['uid']);
		$oldToken = $tokenTable -> fetchRow($select);
		return $oldToken;
	}

	/*
	 * set Token
	 *
	 */
	public function setToken($params = array())
	{
		$tokenTable = Engine_Api::_() -> getDbtable('tokens', 'socialbridge');
		$st = $tokenTable -> createRow();
		$st -> setFromArray($params);
		$st -> save();
		return $st;
	}

	/*
	 * get Total invite of day
	 *
	 */
	public function getTotalInviteOfDay($params = array())
	{
		$statisticTable = Engine_Api::_() -> getDbtable('statistics', 'socialbridge');
		$select = $statisticTable -> select() -> where('uid = ?', $params['uid']) -> where('service = ?', $params['service']) -> where('date = ?', $params['date']);
		$statistic = $statisticTable -> fetchRow($select);
		if ($statistic)
			return $statistic -> invite_of_day;
		else
			return 0;
	}

	/*
	 * create or update statistics
	 *
	 */
	public function createOrUpdateStatistic($params = array())
	{
		$statisticTable = Engine_Api::_() -> getDbtable('statistics', 'socialbridge');
		$select = $statisticTable -> select() -> where('uid = ?', $params['uid']) -> where('service = ?', $params['service']) -> where('date = ?', $params['date']);
		$statistic = $statisticTable -> fetchRow($select);
		if ($statistic)
		{
			$statistic -> invite_of_day = $params['invite_of_day'];
			$statistic -> save();
		}
		else
		{
			$st = $statisticTable -> createRow();
			$st -> setFromArray($params);
			$st -> save();
		}
	}

	/*
	 * save queues
	 *
	 */
	public function saveQueues($params = array())
	{
		$queuesTable = Engine_Api::_() -> getDbtable('queues', 'socialbridge');
		$st = $queuesTable -> createRow();
		$st -> setFromArray($params);
		$st -> save();
	}

	/*
	 * get Queue
	 *
	 */
	public function getQueue($params)
	{
		$queueTable = Engine_Api::_() -> getDbtable('queues', 'socialbridge');
		$select = $queueTable -> select() -> where('token_id = ?', $params['token_id']) -> where('service = ?', $params['service']) -> where('user_id = ?', $params['user_id']) -> where('type = ?', $params['type']);
		$queue = $queueTable -> fetchRow($select);
		return $queue;
	}

	//Add activitys
	public function addActivity($feed = array(), $viewer)
	{
		$service = $this -> _plugin;
		if ($feed -> title != "" || $feed -> description != "" || $feed -> href != "" || $feed -> friend_description != "")
		{
			$body = $feed -> friend_description;
			$type = 'socialstream_' . $service;
			$name = $feed -> friend_name;
			if ($service == 'twitter')
			{
				$name = "@" . $name;
			}
			$str_friend = "<a href = '" . $feed -> friend_href . "' target = '_blank'>" . $name . "</a>"."'s";
			$action = NULL;

			$action = @Engine_Api::_() -> getDbtable('actions', 'activity') -> addActivity($viewer, $feed, $type, $body, array('friend' => $str_friend, 'type' => $feed->update_type));
			
			if ($action != null && ($feed -> photo_url != "" || $feed -> title))
			{
				if ($feed -> photo_url == "")
				{
					$feed -> photo_url = "./application/modules/Socialstream/externals/images/noimage.png";
					$feed -> save();
				}
				Engine_Api::_() -> getDbtable('actions', 'activity') -> attachActivity($action, $feed);
			}
			$feed -> check_core_link = 1;
			$feed -> save();
		}
	}

	public function _parseImage($uri, Zend_Http_Response $response)
	{
		return $arr_result['uri'] = $uri;
	}

	public function _parseText($uri, Zend_Http_Response $response)
	{
		$body = $response -> getBody();
		if (preg_match('/charset=([a-zA-Z0-9-_]+)/i', $response -> getHeader('content-type'), $matches) || preg_match('/charset=([a-zA-Z0-9-_]+)/i', $response -> getBody(), $matches))
		{
			$charset = trim($matches[1]);
		}
		else
		{
			$charset = 'UTF-8';
		}
		// Reduce whitespace
		$body = preg_replace('/[\n\r\t\v ]+/', ' ', $body);

		$arr_result = array();

		$arr_result['title'] = substr($body, 0, 63);
		$arr_result['description'] = substr($body, 0, 255);
		return $arr_result;
	}

	public function _parseHtml($uri, Zend_Http_Response $response)
	{
		$body = $response -> getBody();
		$body = trim($body);
		if (preg_match('/charset=([a-zA-Z0-9-_]+)/i', $response -> getHeader('content-type'), $matches) || preg_match('/charset=([a-zA-Z0-9-_]+)/i', $response -> getBody(), $matches))
		{
			$this -> view -> charset = $charset = trim($matches[1]);
		}
		else
		{
			$this -> view -> charset = $charset = 'UTF-8';
		}
		// Get DOM
		if (class_exists('DOMDocument'))
		{
			$dom = new Zend_Dom_Query($body);
		}
		else
		{
			$dom = null;
			// Maybe add b/c later
		}

		$title = null;
		if ($dom)
		{
			$titleList = $dom -> query('title');
			if (count($titleList) > 0)
			{
				$title = trim($titleList -> current() -> textContent);
				$title = substr($title, 0, 255);
			}
		}
		$arr_result['title'] = $title;

		$description = null;
		if ($dom)
		{
			$descriptionList = $dom -> queryXpath("//meta[@name='description']");
			// Why are they using caps? -_-
			if (count($descriptionList) == 0)
			{
				$descriptionList = $dom -> queryXpath("//meta[@name='Description']");
			}
			if (count($descriptionList) > 0)
			{
				$description = trim($descriptionList -> current() -> getAttribute('content'));
				$description = substr($description, 0, 255);
			}
		}
		$arr_result['description'] = $description;

		$thumb = null;
		if ($dom)
		{
			$thumbList = $dom -> queryXpath("//link[@rel='image_src']");
			if (count($thumbList) > 0)
			{
				$thumb = $thumbList -> current() -> getAttribute('href');
			}
		}

		$medium = null;
		if ($dom)
		{
			$mediumList = $dom -> queryXpath("//meta[@name='medium']");
			if (count($mediumList) > 0)
			{
				$medium = $mediumList -> current() -> getAttribute('content');
			}
		}

		// Get baseUrl and baseHref to parse . paths
		$baseUrlInfo = parse_url($uri);
		$baseUrl = null;
		$baseHostUrl = null;
		if ($dom)
		{
			$baseUrlList = $dom -> query('base');
			if ($baseUrlList && count($baseUrlList) > 0 && $baseUrlList -> current() -> getAttribute('href'))
			{
				$baseUrl = $baseUrlList -> current() -> getAttribute('href');
				$baseUrlInfo = parse_url($baseUrl);
				$baseHostUrl = $baseUrlInfo['scheme'] . '://' . $baseUrlInfo['host'] . '/';
			}
		}
		if (!$baseUrl)
		{
			$baseHostUrl = $baseUrlInfo['scheme'] . '://' . $baseUrlInfo['host'] . '/';
			if (empty($baseUrlInfo['path']))
			{
				$baseUrl = $baseHostUrl;
			}
			else
			{
				$baseUrl = explode('/', $baseUrlInfo['path']);
				array_pop($baseUrl);
				$baseUrl = join('/', $baseUrl);
				$baseUrl = trim($baseUrl, '/');
				$baseUrl = $baseUrlInfo['scheme'] . '://' . $baseUrlInfo['host'] . '/' . $baseUrl . '/';
			}
		}

		$images = array();
		if ($thumb)
		{
			$images[] = $thumb;
		}
		if ($dom)
		{
			$imageQuery = $dom -> query('img');
			foreach ($imageQuery as $image)
			{
				$src = $image -> getAttribute('src');
				// Ignore images that don't have a src
				if (!$src || false === ($srcInfo = @parse_url($src)))
				{
					continue;
				}
				$ext = ltrim(strrchr($src, '.'), '.');
				// Detect absolute url
				if (strpos($src, '/') === 0)
				{
					// If relative to root, add host
					$src = $baseHostUrl . ltrim($src, '/');
				}
				else
				if (strpos($src, './') === 0)
				{
					// If relative to current path, add baseUrl
					$src = $baseUrl . substr($src, 2);
				}
				else
				if (!empty($srcInfo['scheme']) && !empty($srcInfo['host']))
				{
					// Contians host and scheme, do nothing
				}
				else
				if (empty($srcInfo['scheme']) && empty($srcInfo['host']))
				{
					// if not contains scheme or host, add base
					$src = $baseUrl . ltrim($src, '/');
				}
				else
				if (empty($srcInfo['scheme']) && !empty($srcInfo['host']))
				{
					// if contains host, but not scheme, add scheme?
					$src = $baseUrlInfo['scheme'] . ltrim($src, '/');
				}
				else
				{
					// Just add base
					$src = $baseUrl . ltrim($src, '/');
				}
				// Ignore images that don't come from the same domain
				//if( strpos($src, $srcInfo['host']) === false ) {
				// @todo should we do this? disabled for now
				//continue;
				//}
				// Ignore images that don't end in an image extension
				if (!in_array($ext, array(
					'jpg',
					'jpeg',
					'gif',
					'png'
				)))
				{
					// @todo should we do this? disabled for now
					//continue;
				}
				if (!in_array($src, $images))
				{
					$images[] = $src;
				}
			}
		}

		// Unique
		$images = array_values(array_unique($images));

		// Truncate if greater than 20
		if (count($images) > 30)
		{
			array_splice($images, 30, count($images));
		}

		$imageCount = count($images);
		if ($imageCount > 0)
			$arr_result['uri'] = $images[0];
		else
			$arr_result['uri'] = '';
		return $arr_result;
	}

}
