<?php 
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Membership.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Event_Model_DbTable_Membership extends Core_Model_DbTable_Membership
{
  protected $_type = 'event';


  // Configuration

  /**
   * Does membership require approval of the resource?
   *
   * @param Core_Model_Item_Abstract $resource
   * @return bool
   */
  public function isResourceApprovalRequired(Core_Model_Item_Abstract $resource)
  {
    return $resource->approval;
  }
  
  /*
   * Return all members
   *
   * @param array $params
   * @param bool active
   * @return mixed
   */
  public function getAllMembers($params = array(), $active = true)
  {
    $membershipTableName = $this->info('name');
    $userTable = Engine_Api::_()->getItemTable('user');
    $userTableName = $userTable->info('name');
    $eventTable = Engine_Api::_()->getItemTable('event');
    $eventTableName = $eventTable->info('name');
    
    $select = $this->select()
      ->from($membershipTableName)
      ->joinLeft($userTableName, "$membershipTableName.user_id = $userTableName.user_id", null)
      ->joinLeft($eventTableName, "$membershipTableName.resource_id = $eventTableName.event_id", null)
      ;
    
    if ($active !== null) {
      $select->where('active = ?', (int) $active);
    }
    
    if (!empty($params['user'])) {
      $select->where("$userTableName.displayname LIKE ?", '%' . $params['user'] . '%');
    }
    
    if (!empty($params['event_id'])) {
      $select->where("$eventTableName.event_id = ?", $params['event_id']);
    }
    
    if (!empty($params['user_id'])) {
      $select->where("$membershipTableName.user_id = ?", $params['user_id']);
    }
    
    if (!empty($params['group'])) {
      $select->group($params['group']);
    }
    
    if (isset($params['status']) and $params['status'] !== '') {
      $select->where("$membershipTableName.rsvp IN (?)", explode(',', $params['status']));
    }
    
    //echo '<pre>'; print_r( (string)$select ); echo '</pre>'; exit;
    return $this->fetchAll($select);
  }
}