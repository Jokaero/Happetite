<?php


class SocialConnect_Api_Exception extends Exception{
	CONST KEY_EMPTY = -1000;
	CONST SECRET_EMPTY = -1001;
	CONST KEY_INVALID = -1002;
	CONST SECRET_INVALID = -1003;
	CONST USER_REFULSE =  -1004;
	CONST CANNOT_GET_REQUEST_TOKEN = -1005;
	CONST CANNOT_REDIRECT          = -1006;
	CONST INVALID_VERSION = -1007;
	CONST INVALID_VERIFIED = -1008;
	CONST PERMISION_DENIED  = -1009;
	CONST INVALID_OPENID   = -1010;
	CONST NO_OPENID   = -1010;
	CONST DATA_REFUSED     = -1011;
	CONST NO_ACCOUNT  = -1010;
	CONST CONFLICT_ACCOUNT =  -10012;
	CONST UNKNOWN_ERROR =  -10014;
	CONST INVALID_AUTHORIZE = -10015;

	CONST UNKNOWN   = -100000;

	protected $response  = '';

	public function __construct($message, $code =-10014, $response = ''){
		$this->message = $message;
		$this->code   = $code;
		$this->response =  $response;
	}
	
	public function getResponse(){
		return $this->response;
	}
}