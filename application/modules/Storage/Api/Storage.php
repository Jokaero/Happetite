<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Storage
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Storage.php 10233 2014-05-22 16:10:47Z andres $
 * @author     John Boehr <j@webligo.com>
 */

/**
 * @category   Application_Core
 * @package    Storage
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Storage_Api_Storage extends Core_Api_Abstract
{
  const SPACE_LIMIT_REACHED_CODE = 3999;
  
  public function getService($serviceIdentity = null)
  {
    return Engine_Api::_()->getDbtable('services', 'storage')
      ->getService($serviceIdentity);
  }
  
  public function get($id, $relationship = null)
  {
    return Engine_Api::_()->getItemTable('storage_file')
        ->getFile($id, $relationship);
  }

  public function lookup($id, $relationship)
  {
    return Engine_Api::_()->getItemTable('storage_file')
        ->lookupFile($id, $relationship);
  }

  public function create($file, $params)
  {
    return Engine_Api::_()->getItemTable('storage_file')
        ->createFile($file, $params);
  }
  
  public function getStorageLimits()
  {
    return Engine_Api::_()->getItemTable('storage_file')
        ->getStorageLimits();
  }
}