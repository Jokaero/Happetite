<?php


/**
 * Radcodes - SocialEngine Module
 *
 * @category   Application_Extensions
 * @package  Radcodes
 * @copyright  Copyright (c) 2009-2010 Radcodes LLC (http://www.radcodes.com)
 * @license  http://www.radcodes.com/license/
 * @version  $Id$
 * @author   Vincent Van <vincent@radcodes.com>
 */
 


class Radcodes_Lib_Rest_Store extends Radcodes_Lib_Rest
{
	
  public function getCompactModules()
  {
  	$modules = Engine_Api::_()->getDbtable('modules', 'core')->getModules();
		$compactModules = array();
		foreach ($modules as $module) {
			$compactModules[$module->name] = array_merge(
			  $module->toArray(),
			  array('license' => Engine_Api::_()->getApi('settings', 'core')->getSetting($module->name.'.license'))
			);
		}
		return $compactModules;
  }
  
	public function getModules()
	{
		$compactModules = $this->getCompactModules();
    $radcodesModules = $this->callMethod('getModules', array('modules'=>$compactModules));
    if (empty($radcodesModules)) $radcodesModules = array();
		return $radcodesModules;
	}
	
	
	public function getCustomer()
	{
		$customer = $this->callMethod('getCustomer');
		return $customer;
	}
	
	
	public function getProduct($name)
	{
		$product = $this->callMethod('getProduct', array('name'=>$name));
		return $product;
	}
	
	
	public function getLicense($product)
	{
		$license = $this->callMethod('getLicense', array('product'=>$name));
		return $license;
	}
	
	public function setEnableModules($names = array(), $val = 1)
	{
		if (!is_array($names)) {
			$names = explode(',', $names);
		}
		if (!empty($names)) {
			$data = array('enabled' => $val);
			$where = "name IN ('".join("','",$names)."')";
			Engine_Api::_()->getDbtable('modules', 'core')->update($data, $where);
		}
	}
	
	public function enableModules($names = array())
	{
		$this->setEnableModules($names,1);
	}
	
	
	public function disableModules($names = array())
	{
	  $this->setEnableModules($names,0);
	}
	
	
	public function getCoreVersion()
	{
		$version = $this->callMethod('getCoreVersion');
		return $version;
	}
	
	
	public function checkUpdates()
	{
		$compactModules = $this->getCompactModules();
    $radcodesModules = $this->callMethod('checkUpdates', array('modules'=>$compactModules));
    if (empty($radcodesModules)) $radcodesModules = array();
		return $radcodesModules;
	}
	
	public function verifyLicense($license, $domain, $type)
	{
		$params = array('license'=>$license,'domain'=>$domain,'type'=>$type);
    $result = $this->callMethod('verifyLicense', $params);
    return $result;
	}
}

