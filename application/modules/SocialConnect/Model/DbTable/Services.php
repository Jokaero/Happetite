<?php

class SocialConnect_Model_DbTable_Services extends Engine_Db_Table
{

	protected $_rowClass = 'SocialConnect_Model_Service';

	/**
	 *  get all enable services
	 *
	 */

	public function getSeperateLimit()
	{
		return Engine_Api::_() -> getApi('settings', 'core') -> getSetting('socialconnect.seperatelimit', 16);
	}

	/**
	 * this method is predecated
	 */
	public function getServices($limit = 100, $privacy = NULL)
	{

		$select = $this -> select() -> order('ordering');

		if (NULL != $privacy)
		{
			$select -> where('privacy=?', $privacy);
		}

		return $this -> fetchAll($select);
	}

	/**
	 * @param   string   $service
	 * @return  Zend_Model_DbTable_Row
	 *
	 */

	public function getService($service)
	{

		$select = $this -> select() -> where('name = ?', $service);

		$r = $this -> fetchRow($select);

		if (!$r)
		{
			$r = $this -> fetchNew();
			//XXX: need start something.
		}
		return $r;
	}

	public function switchEnable($service_id)
	{

		$select = $this -> select() -> where('service_id=?', (int)$service_id);

		$row = $this -> fetchRow($select);

		if ($row)
		{
			$row -> privacy = (int)(!($row -> privacy));
			$row -> save();
		}
	}

}
