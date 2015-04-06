<?php

class SocialConnect_Model_Service extends Core_Model_Item_Abstract{
	
	public function getHref(){
		return Zend_Controller_Front::getInstance()->getRouter()->assemble(array('service'=>$this->name), 'connect_signin');
	}
}