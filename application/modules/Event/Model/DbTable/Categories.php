<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Categories.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Event_Model_DbTable_Categories extends Engine_Db_Table
{
  protected $_rowClass = 'Event_Model_Category';
  
  public function getCategoriesAssoc()
  {
    $stmt = $this->select()
        ->from($this, array('category_id', 'title'))
        ->order('title ASC')
        ->query();
    
    $data = array();
    foreach( $stmt->fetchAll() as $category ) {
      $data[$category['category_id']] = $category['title'];
    }
    
    return $data;
  }
}
