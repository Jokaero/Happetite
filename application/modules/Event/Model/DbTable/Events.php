<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Events.php 9829 2012-11-27 01:13:07Z richard $
 * @author     Sami
 */

/**
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @author     Sami
 */
class Event_Model_DbTable_Events extends Engine_Db_Table
{
  protected $_rowClass = "Event_Model_Event";
  
  public function getEventPaginator($params = array())
  {
    return Zend_Paginator::factory($this->getEventSelect($params));
  }
  
  public function getEventSelect($params = array())
  {
    $table = Engine_Api::_()->getItemTable('event');
    $tableName = $table->info('name');
    $usersTable = Engine_Api::_()->getItemTable('user');
    $usersTableName = $usersTable->info('name');
    $membershipTable = Engine_Api::_()->getDbTable('membership', 'event');
    $membershipTableName = $membershipTable->info('name');
    
    $select = $table->select()
      ->from($tableName, array("$tableName.*", "is_action" => "COUNT(CASE WHEN $membershipTableName.rsvp = 4 OR $tableName.status IN ('verified', 'canceled') AND $membershipTableName.rsvp = 3 THEN 1 ELSE NULL END)"))
      ->joinLeft($membershipTableName, "$membershipTableName.resource_id = $tableName.event_id", null)
      ->joinLeft($usersTableName, "$tableName.user_id = $usersTableName.user_id", null)
      ->group("$tableName.event_id")
      ;
    
    // resource_id => membership table event_id 
    if (!empty($params['resource_id'])) {
      $select->where("$membershipTableName.resource_id = ?", $params['resource_id']);
    }
    
    if (!empty($params['displayname'])) {
      $select->where("$usersTableName.displayname LIKE ?", '%'.$params['displayname'].'%');
    }
    
    if (!empty($params['title'])) {
      $select->where("$tableName.title LIKE ?", '%'.$params['title'].'%');
    }
    
    if (!empty($params['status'])) {
      $select->where("$tableName.status = ?", $params['status']);
    }
    
    if( isset($params['search']) ) {
      $select->where("$tableName.search = ?", (bool) $params['search']);
    }
    
    if( isset($params['owner']) && $params['owner'] instanceof Core_Model_Item_Abstract ) {
      $select->where("$tableName.user_id = ?", $params['owner']->getIdentity());
    } else if( isset($params['user_id']) && !empty($params['user_id']) ) {
      $select->where("$tableName.user_id = ?", $params['user_id']);
    } else if( isset($params['users']) && is_array($params['users']) ) {
      $users = array();
      foreach( $params['users'] as $user_id ) {
        if( is_int($user_id) && $user_id > 0 ) {
          $users[] = $user_id;
        }
      }
      // if users is set yet there are none, $select will always return an empty rowset
      if( empty($users) ) {
        return $select->where('1 != 1');
      } else {
        $select->where("$tableName.user_id IN (?)", $users);
      }
    }
    
    // User joined to class
    if (isset($params['user_id_joined']) && !empty($params['user_id_joined'])) {
      $select->where("$membershipTableName.user_id = ?", $params['user_id_joined']);
    }
    
    // user rsvp's
    if( isset($params['rsvps']) && is_array($params['rsvps']) ) {
      $rsvps = array();
      foreach( $params['rsvps'] as $rsvp ) {
        if( is_int($rsvp) && $rsvp >= 0 ) {
          $rsvps[] = $rsvp;
        }
      }
      
      $select->where("$membershipTableName.rsvp IN (?)", $rsvps);
    }
    
    // Category
    if( isset($params['category_id']) && !empty($params['category_id']) ) {
      $select->where("$tableName.category_id = ?", $params['category_id']);
    }
    
    // City
    if( isset($params['city']) && !empty($params['city']) ) {
      $select->where("$tableName.city LIKE '%{$params['city']}%'");
    }
    
    //Full Text	
    $search_text = !empty($params['search_text']) ? $params['search_text'] : null;	
    if( !empty($params['search_text']) ) {	
      $select->where("$tableName.description LIKE '%$search_text%'");	
      $select->orWhere("$tableName.title LIKE '%$search_text%'");	
    }
    
    // Endtime
    if( isset($params['past']) && !empty($params['past']) ) {
      $select->where("$tableName.endtime <= FROM_UNIXTIME(?)", time());
    } elseif( isset($params['future']) && !empty($params['future']) ) {
      $select->where("$tableName.endtime > FROM_UNIXTIME(?)", time());
    }
    
    if (isset($params['date']) and !empty($params['date'])) {
      
      $select->where("$tableName.starttime >= ?", (string)$params['date']);
    }
    // Order
    if( isset($params['order']) && !empty($params['order']) ) {
      $select->order($params['order']);
    } else {
      $select->order('creation_date DESC');
    }
    
    // limit
    if( isset($params['limit']) && !empty($params['limit']) ) {
      $select->limit($params['limit']);
    }
    
    // Not in ids
    if( isset($params['notin']) && !empty($params['notin']) ) {
      $select->where("$tableName.event_id NOT IN (?)", $params['notin']);
    }
    
    return $select;
  }
}