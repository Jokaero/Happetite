<?php

/**
 * Radcodes - SocialEngine Module
 *
 * @category   Application_Extensions
 * @package    Radcodes
 * @copyright  Copyright (c) 2009-2010 Radcodes LLC (http://www.radcodes.com)
 * @license    http://www.radcodes.com/license/
 * @version    $Id$
 * @author     Vincent Van <vincent@radcodes.com>
 */
 
class Radcodes_Form_Admin_Global extends Engine_Form
{
  public function init()
  {
    $this
      ->setTitle('Global Settings')
      ->setDescription('These settings affect all members in your community.');
    
    
    $this->addElement('Radio', 'radcodes_mapcache', array(
      'label' => 'Google Map - Caching',
      'description' => "Would you like to enable caching for geocoding result?",
      'multiOptions' => array(
				1 => "Yes",
        0 => "No",
      ),
      'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('radcodes.mapcache', 1),
    ));
        
    $this->addElement('Radio', 'radcodes_mapdebug', array(
      'label' => 'Google Map - Debug',
      'description' => "Would you like to output debug data for geocoding result?",
      'multiOptions' => array(
				1 => "Yes",
        0 => "No",
      ),
      'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('radcodes.mapdebug', 0),
    ));
    
    $this->addElement('Radio', 'radcodes_mapcurl', array(
      'label' => 'Google Map - cURL',
      'description' => "Would you like to connect to Google Map API service using cURL adapter? By default, socket adapter would be used to do remote connection, however, some hosting providers may block it, the alternative would be using cURL library. If your server does not have cURL, and/or block both, then you would need to contact your hosting tech support to get them enabled.",
      'multiOptions' => array(
				1 => "Yes (use uCURL)",
        0 => "No (use socket - default/recommended)",
      ),
      'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('radcodes.mapcurl', 0),
    ));
    
    // Add submit button
    $this->addElement('Button', 'submit', array(
      'label' => 'Save Changes',
      'type' => 'submit',
      'ignore' => true
    ));
  }
}