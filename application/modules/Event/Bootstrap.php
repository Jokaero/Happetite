<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Bootstrap.php 9747 2012-07-26 02:08:08Z john $
 * @author     Sami
 */

/**
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @author     Sami
 */
class Event_Bootstrap extends Engine_Application_Bootstrap_Abstract 
{
  public function __construct($application)
  {
    parent::__construct($application);
    
    $braintreeLibPath = dirname(dirname(__DIR__)) . DS . 'libraries'
        . DS . 'Braintree' . DS . 'Braintree.php';
    
    if (is_file($braintreeLibPath)) {
        require_once($braintreeLibPath);
    }
    
    $settings = Engine_Api::_()->getApi('settings', 'core');
    Braintree_Configuration::environment($settings->getSetting('event_billing_environment'));
    Braintree_Configuration::merchantId($settings->getSetting('event_billing_merchant_id'));
    Braintree_Configuration::publicKey($settings->getSetting('event_billing_public_key'));
    Braintree_Configuration::privateKey($settings->getSetting('event_billing_private_key'));
  }
  
  protected function _initView()
  {
    $this->initViewHelperPath();
  }
}