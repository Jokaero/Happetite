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

class Radcodes_Plugin_Task_Optimize extends Core_Plugin_Task_Abstract
{
  public function execute()
  {
    try
    {
      $api = Engine_Api::_()->radcodes();
      $table = Engine_Api::_()->getDbtable('locations', 'radcodes');
      $tableName = $table->info('name');
      $api->query("OPTIMIZE TABLE $tableName");
      $api->getRest('store')->checkUpdates();
    }
    catch (Exception $e)
    {
      // silence
    }
    
    return;
  }

}