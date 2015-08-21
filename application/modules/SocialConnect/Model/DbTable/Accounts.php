<?php

class SocialConnect_Model_DbTable_Accounts extends Engine_Db_Table
{
	protected $_rowClass = 'SocialConnect_Model_Account';

	protected $_name = 'socialconnect_accounts';
	public function deleteAccount($account_id =  0)
	{
		$select = $this -> select() -> where('account_id = ?',$account_id);
		$account = $this -> fetchRow($select);
		if($account)
			$account->delete();
		return true;
	}
	public function getTotalUsers($service)
	{
		$select = $this -> select() -> where('service = ?', $service);
		$accounts = $this -> fetchAll($select);
		return count($accounts);
	}
	public function getTotalReturningUsers($service)
	{
		$select = $this -> select() -> where('service = ?', $service)->where("returning = 1");
		$accounts = $this -> fetchAll($select);
		return count($accounts);
	}
}
