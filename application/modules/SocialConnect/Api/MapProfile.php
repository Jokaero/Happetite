<?php


class SocialConnect_Api_MapProfile{

	protected static $inst;

	protected $connectedData;

	protected $formData;

	protected $identity;

	protected $service;


	/**
	 *
	 * Enter description here ...
	 * @param $identity
	 * @param $service
	 * @param $connectedData
	 * @param $formData
	 */
	public function __construct($identity, $service, $connectedData, $formData){
		$this->identity      = $identity;
		$this->service       = $service;
		$this->connectedData = $connectedData;
		$this->formData      = $formData;
	}

	/**
	 *
	 * Enter description here ...
	 * @param unknown_type $identity
	 * @param unknown_type $service
	 * @param unknown_type $connectedData
	 * @param unknown_type $formData
	 */
	public static function factory($identity, $service, $connectedData, $formData){
		if(self::$inst == NULL){
			self::$inst = new self($identity, $service, $connectedData, $formData);
		}
		return self::$inst;
	}


	protected function get_displayname($data = NULL){
		if(@$this->formData['fullname']){
			return $this->formData['fullname'];
		}

		if(@$this->connectedData['displayname']){
			return $this->connectedData['displayname'];
		}

		if(@$this->connectedData['name']){
			return $this->connectedData['name'];
		}
		if(@$this->formData['username']){
			return $this->formData['username'];
		}
	}

	/**
	 *
	 * get creation date from data
	 * @param unknown_type $connectedData
	 * @param unknown_type $formData
	 */
	protected function get_creationdate($data = NULL){
		return date('Y-m-d H:j:s');
	}
	protected function get_lastlogin_date($data = NULL){
		return date('Y-m-d H:j:s');
	}
	protected function get_modified_date($data = NULL){
		return date('Y-m-d H:j:s');
	}

	protected function get_password($data = NULL){
		return self::randomString(6);
	}

	protected function get_creation_ip($data = NULL){
		return $_SERVER['REMOTE_ADDR'];
	}

	protected function get_lastlogin_ip($data = NULL){
		return $_SERVER['REMOTE_ADDR'];
	}

	public function getField($name,$data = array()){
		if(isset($this->formData[$name]) && !empty($this->formData[$name])){
			return $this->formData[$name];
		}
	 if(isset($this->connectedData[$name]) && !empty($this->connectedData[$name])){
			return $this->connectedData[$name];
		}

	 $methodName = 'get_'.$name;
	 if(method_exists($this, $methodName)){
	 	return $this->{$methodName}($data);
	 }
	}

	/**
	 *
	 * get identity fields
	 * @param unknown_type $name
	 * @param unknown_type $data
	 */
	public function getIdentityField($name,$data = array()){
		if(isset($this->formData[$name]) && !empty($this->formData[$name])){
			return $this->formData[$name];
		}
	 if(isset($this->connectedData[$name]) && !empty($this->connectedData[$name])){
			return $this->connectedData[$name];
		}

	 $methodName = 'get_identity_'.$name;
	 if(method_exists($this, $methodName)){
	 	return $this->{$methodName}($data);
	 }

	 $methodName = 'get_'.$name;
	 if(method_exists($this, $methodName)){
	 	return $this->{$methodName}($data);
	 }
	}
	/**
	 * get a random string
	 * Enter description here ...
	 * @param unknown_type $length
	 */
	protected static function randomString($length=32){
		$chars = '1234567890qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM';
		$max = strlen($chars)-1;
		$ret = '';
		for($i = 0; $i<$length; ++$i){
			$ret .= $chars[mt_rand(0, $max)];
		}
		return $ret;
	}
	protected function get_user_id($data = array()){
		return NULL;
	}

	protected function get_identity_service_id(){
		return NULL;
	}
	protected function get_identity_idnetity_id(){
		return NULL;
	}
	protected function get_identity_data(){
		return json_encode($this->connectedData);
	}
	protected function get_identity_identity(){
		return $this->identity;
	}
	protected function get_photo_id(){
		return '';
	}
	protected function get_locale(){
		return 'auto';
	}
	protected function get_timezone(){
		return 'America/Los_Angeles';
	}
	protected function get_show_profileviewers(){
		return 0;
	}
	protected function get_invites_used(){
		return 0;
	}
	protected function get_extra_invites(){
		return 0;
	}
	protected function get_member_count(){
		return 0;
	}
	protected function get_view_count(){
		return 0;
	}
	protected function get_update_date(){
		return date('Y-m-d H:j:s');
	}

}