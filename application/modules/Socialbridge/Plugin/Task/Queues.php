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
class Socialbridge_Plugin_Task_Queues extends Core_Plugin_Task_Abstract
{
	public function execute()
	{
		$queues = Engine_Api::_() -> getApi('core', 'socialbridge') -> getAllQueues();
		foreach ($queues as $queue)
		{
			switch ($queue->type)
			{
				case 'sendInvite' :
					$extra_params = unserialize($queue->extra_params);
					$token = Engine_Api::_() -> getItem('socialbridge_token', $queue->token_id);
					$obj = Engine_Api::_() -> socialbridge() -> getInstance($queue -> service);
					$params['list'] = $extra_params['list'];
					$params['link'] = $extra_params['link'];
					$params['message'] = $extra_params['message'];
					$params['uid'] = $token->uid;
					$params['user_id'] = $queue -> user_id;
					$params['access_token'] = $token -> access_token;
					$params['secret_token'] = $token -> secret_token;
					echo ucfirst($queue -> service).": ".$token->uid.": Send invite successfully! ";
					$obj -> sendInvites($params);
					echo " <br/>  ";
					$queue->delete();
					break;
				case 'getFeed':
					if(Engine_Api::_()->getApi('settings', 'core')->getSetting('get_feed_cron', 0))
					{
						$service = $queue -> service;
						$token = Engine_Api::_() -> getItem('socialbridge_token', $queue->token_id);
						if($token)
						{
							$uid = $token->uid;
							$user = Engine_Api::_() -> getItem('user', $queue->user_id);	
							//check permission get Feed
							//check allow get feed with cron job?
							$settingTable = Engine_Api::_() -> getDbTable('settings', 'socialstream');
							$stream_settings = $settingTable -> checkExists($queue->user_id, $service);
							$get_feed = 1;
							$cron = 0;
							if($stream_settings)
							{
								$get_feed = $stream_settings -> get_feed;
								$cron = $stream_settings ->	cron_job;
							}
							if( !$get_feed
							|| !Engine_Api::_() -> authorization() -> isAllowed('socialstream', $user, 'get_feed')
							|| !$cron
							|| !Engine_Api::_() -> getApi('settings', 'core') -> getSetting('get_feed_'.$service, 1))
							{
								continue;
							}
							//get Feeds
							$obj = Engine_Api::_()->socialbridge()->getInstance($service);
							$feedLast =  Engine_Api::_()->getDbTable('feeds', 'Socialstream')->getFeedLast($service, $uid);
							$arr_token = array('access_token'=>$token -> access_token,'secret_token'=>$token -> secret_token);
							$arr_token['lastFeedTimestamp'] = 0;
							if($feedLast)
									$arr_token['lastFeedTimestamp'] = $feedLast->timestamp;
							
							$arr_token['limit'] = Engine_Api::_()->getApi('settings', 'core')->getSetting('max_'.$service.'_get_feed', 5);
							$arr_token['uid'] = $uid;
							$sortService = 'fb';
							switch ($service) 
							{
								case 'facebook':
									$sortService = 'fb';
									break;
								case 'twitter':
									$sortService = 'tw';
									break;
								case 'linkedin':
									$sortService = 'li';
									break;
							}
							$arr_token['type'] = Engine_Api::_() -> getApi('settings', 'core') -> getSetting('default_'.$sortService.'_feed', 'friend_me');
							if($stream_settings)
								$arr_token['type'] = $stream_settings->source_feed;
							$activities = $obj->getActivity($arr_token);	
							if($activities != null)
							{
								$obj->insertFeeds(array(
									'activities'	=> $activities,
						 			'viewer'		=> $user,
									'timestamp'     => $arr_token['lastFeedTimestamp'],
									'access_token'	=>$token -> access_token,
									'secret_token'	=>$token -> secret_token,
									'uid'           => $uid,
								));
							}		
							$queue->last_run = date ('Y-m-d H:i:s');
							$queue->save();
							echo ucfirst($service).": ".$token->uid.": Get feed successfully!";
							echo " <br/>  ";
						}
					}
					break;
					
				default :
					break;
			}
		}
	}

}
