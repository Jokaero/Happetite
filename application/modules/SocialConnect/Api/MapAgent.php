<?php


class SocialConnect_Api_MapAgent{

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

	public function getField($name){
	 $methodName = 'get_'.$name;
	 if(method_exists($this, $methodName)){
	 	return $this->{$methodName}();
	 }
	 
		if(isset($this->formData[$name]) && !empty($this->formData[$name])){
			return $this->formData[$name];
		}
		
	  if(isset($this->connectedData[$name]) && !empty($this->connectedData[$name])){
			return $this->connectedData[$name];
		}

	 
	}

	protected function get_user_id(){
		return NULL;
	}
	protected function get_agent_id(){
		return NULL;
	}
	protected function get_service_id(){
		return NULL;
	}
	protected function get_data(){
		return json_encode($this->connectedData);
	}
	protected function get_identity(){
		return $this->identity;
	}
}