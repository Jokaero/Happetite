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
class Socialbridge_Api_Core extends Core_Api_Abstract
{
	/**
	 *
	 * @param string service
	 * @return Object or Null
	 */
	public function getInstance($service = 'facebook')
	{
		$api = Engine_Api::_();
		$className = "Socialbridge_Api_".$api -> inflect($service);
    	return new $className();
	}
	
	public function getAllQueues()
	{
		$queuesTable = Engine_Api::_() -> getDbtable('queues', 'socialbridge');
		$queuesTableName = $queuesTable->info ( 'name' );
		$select = $queuesTable->select ($queuesTableName);
		return $queuesTable->fetchAll($select);
	}

}
