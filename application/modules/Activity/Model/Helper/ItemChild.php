<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Activity
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: ItemChild.php 9921 2013-02-16 01:38:52Z jung $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Activity
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Activity_Model_Helper_ItemChild extends Activity_Model_Helper_Item
{
  public function direct($item, $type = null, $child_id = null)
  {
    $item = $this->_getItem($item, false);   
    
    // Check to make sure we have an item
    if( !($item instanceof Core_Model_Item_Abstract) )
    {
      return false;
    }
    
    $child_type = $item->getType().'_'.$type;
    
    try{
      $item = Engine_Api::_()->getItem($child_type, $child_id);
    }
    catch (Exception $e) {
      // With no alarms and no surprises
      // No alarms and no surprises
      // No alarms and no surprises
      // Silent, silent
    }
    
    if( !($item instanceof Core_Model_Item_Abstract) )
    {
      return false;
    }    
    
    return parent::direct($item, $type);
  }
}