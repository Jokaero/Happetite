<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Themes.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Core_Model_DbTable_Themes extends Engine_Db_Table
{

  /**
   * Deletes all temporary files in the Scaffold cache
   *
   * @example self::clearScaffoldCache();
   * @return void
   */
  public static function clearScaffoldCache()
  {
    try {
      Engine_Package_Utilities::fsRmdirRecursive(APPLICATION_PATH . '/temporary/scaffold', false);
    } catch( Exception $e ) {}
  }
}
