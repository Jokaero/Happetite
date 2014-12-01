<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: List.php 10190 2014-04-30 19:01:04Z lucas $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class User_Model_List extends Core_Model_List
{
  protected $_owner_type = 'user';

  protected $_child_type = 'user';

  public function getListItemTable()
  {
    return Engine_Api::_()->getItemTable('user_list_item');
  }

  public function getFriends(){
    throw new Engine_Package_Manager_Exception('This function is deprecated.');
  }
}