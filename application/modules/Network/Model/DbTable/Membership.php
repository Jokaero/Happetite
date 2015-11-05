<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Network
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Membership.php 10088 2013-09-19 13:34:37Z andres $
 * @author     Sami
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Network
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Network_Model_DbTable_Membership extends Core_Model_DbTable_Membership
{
  protected $_type = 'network';

  public function isUserApprovalRequired()
  {
    return false;
  }

  public function isResourceApprovalRequired(Core_Model_Item_Abstract $resource)
  {
    return false;
  }

  protected function _delete(){

  }
}
