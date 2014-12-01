<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Messages
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Core.php 10155 2014-04-09 13:17:28Z lucas $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Messages
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Messages_Api_Core extends Core_Api_Abstract
{
  public function getUnreadMessageCount(Core_Model_Item_Abstract $user)
  {
    $identity = $user->getIdentity();
    $rName = Engine_Api::_()->getDbtable('recipients', 'messages')->info('name');
    $cName = Engine_Api::_()->getDbtable('conversations', 'messages')->info('name');
		$enabledModules = Engine_Api::_()->getDbtable('modules', 'core')->getEnabledModuleNames();

    $select = Engine_Api::_()->getDbtable('recipients', 'messages')->select()
      ->setIntegrityCheck(false)
      ->from($rName, new Zend_Db_Expr("COUNT(`{$rName}`.conversation_id) AS unread"))
      ->joinRight($cName, "`{$cName}`.`conversation_id` = `{$rName}`.`conversation_id`", null)
      ->where($rName.'.user_id = ?', $identity)
      ->where($rName.'.inbox_deleted = ?', 0)
      ->where($rName.'.inbox_read = ?', 0)
      ->where("`{$cName}`.`resource_type` IS NULL or `{$cName}`.`resource_type` ='' or `{$cName}`.`resource_type` IN (?)", $enabledModules);

    $data = Engine_Api::_()->getDbtable('recipients', 'messages')->fetchRow($select);
    return (int) $data->unread;
  }
}
