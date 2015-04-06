<?php

class SocialConnect_Model_Agent extends Core_Model_Item_Abstract{

	/**
	 *
	 * Login from another
	 * @param unknown_type $data
	 */
	public function login($data = NULL){
		$this->login_time = date('Y-m-d H:i:s');
		$this->login = 1;
		if($data !=  NULL){
			$this->data =  json_encode($data);
		}
		$this->save();
	}
	
	/**
	 *
	 * Logout from another.
	 */
	public function logout(){
		$this->logout_time = date('Y-m-d H:i:s');
		$this->login = 0;
		$this->save();
	}

	/**
	 * XXX: NEED IMPLEMENT THIS METHOD.
	 */
	public function connect($user_id = NULL){
		throw new Exception('need implement',-1);
	}

	/**
	 * get connect data from ...
	 * 
	 */
	public function getData(){
		try{
			return json_decode($this->data);
		}catch(Exception $e){
			return array();
		}

	}
	public function getUser(){
		$Users = new User_Model_DbTable_Users();
		return $Users->findRow($this->user_id);
		
	}
	public function switchUser($user_id, $data = NULL){
		$this->user_id = $user_id;
		$this->login_time = date('Y-m-d H:i:s');
		$this->login = 1;
		if($data !==  NULL){
			$this->data =  json_encode($data);
		}
		$this->save();
	}
}