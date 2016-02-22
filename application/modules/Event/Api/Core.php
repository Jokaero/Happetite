<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Core.php 9747 2012-07-26 02:08:08Z john $
 * @author     Sami
 */

/**
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @author     Sami
 */
class Event_Api_Core extends Core_Api_Abstract
{
  /*
   * Return info
   * 
   * @param array $params
   * @return mixed
   */
  public function getEventCountInfoAs($item, $params)
  {
    $count = 0;
    
    if (!empty($params['type']) and $params['type'] == 'owner') {
        $table = Engine_Api::_()->getItemTable('event');
        
        $select = $table->select()
            ->from($table, array('count' => 'count(*)'))
            ->where('user_id = ?', $item->getIdentity());
        
        if (!empty($params['when']) and $params['when'] == 'not_later') {
            $select->where('endtime > NOW()');
        }
        
        $count = (int) $table->fetchRow($select)->count;
    }
    
    if (!empty($params['type']) and $params['type'] == 'guest') {
        $table = Engine_Api::_()->getDbTable('membership', 'event');
        $tableName = $table->info('name');
        $tableEvent = Engine_Api::_()->getItemTable('event');
        $tableEventName = $tableEvent->info('name');
        
        $select = $table->select()
            ->from($table, array('count' => 'count(*)'))
            ->joinLeft($tableEventName, "$tableName.resource_id = $tableEventName.event_id", null)
            ->where("$tableName.user_id = ?", $item->getIdentity())
            ->where("$tableName.user_id <> $tableEventName.user_id")
            ->group("$tableName.user_id");
        
        if (!empty($params['when']) and $params['when'] == 'not_later') {
            $select->where("$tableEventName.endtime > NOW()");
        }
        
        $count = (int) $table->fetchRow($select)->count;
    }
    
    return $count;
  }
  
  /*
   * Return Finance Information
   * 
   * @param User_Model_User $user
   * @param array $params
   * @return float
   */
  public function getFinanceInfo($user, $params)
  {
    if (!$user->getIdentity()) {
        return;
    }
    
    $transactionTable = Engine_Api::_()->getItemTable('event_transaction');
    $transactionTableName = $transactionTable->info('name');
    $eventTable = Engine_Api::_()->getItemTable('event');
    $eventTableName = $eventTable->info('name');
    $userTable = Engine_Api::_()->getItemTable('user');
    $userTableName = $userTable->info('name');
    
    $select = $transactionTable->select()
        ->from($transactionTableName, array('price' => "SUM($transactionTableName.price)", 'currency'))
        ->joinLeft($eventTableName, "$eventTableName.event_id = $transactionTableName.event_id", null)
        ->where("$transactionTableName.status IN (?)", array('completed', 'refunded'))
        ->group("$transactionTableName.currency")
        ;
    
    if (!empty($params['type']) and $params['type'] == 'received') {
        $select
            ->where("$transactionTableName.user_id = ?", $user->getIdentity())
            ->where("$transactionTableName.price < ?", '0');
    }
    
    if (!empty($params['type']) and $params['type'] == 'paid') {
        $select
            ->where("$transactionTableName.user_id = ?", $user->getIdentity())
            ->where("$transactionTableName.user_id <> $eventTableName.user_id");
    }
    
    $content = false;
    foreach ($transactionTable->fetchAll($select) as $row) {
      if (empty($content)) {
        $content = abs($row->price) . ' ' . $row->currency;
      } else {
        $content .= ', ' . abs($row->price) . ' ' . $row->currency;
      }
    }
    
    return $content;
  }
  
  /*
   * Return currency
   * 
   * @return array
   */
  public function getCurrencies()
  {
    return array(
        'USD' => 'USD',
        'CHF' => 'CHF',
        'EUR' => 'EUR',
        'GBP' => 'GBP',
    );
  }
  
  /**
   * Get Class Users Count
   * @param Event_Model_Event $event
   * @param array $params
   *
   * @return Engine_Db_Table_Select $select
   */
  public function getEventUsersSelect(Event_Model_Event $event, $params = array())
  {
    $eventsTable = Engine_Api::_()->getDbTable('events', 'event');
    $eventsTableName = $eventsTable->info('name');
    
    $membershipTable = Engine_Api::_()->getDbTable('membership', 'event');
    $membershipTableName = $membershipTable->info('name');
    
    $select = $membershipTable->select()
      ->from($membershipTableName)
      ->joinLeft($eventsTableName, "$eventsTableName.event_id = $membershipTableName.resource_id", null)
      ;
    
    // count
    if ($params['count']) {
      $select = $membershipTable->select()
        ->from($membershipTableName, 'COUNT(*) AS count');
    }
    
    $select->where("$membershipTableName.resource_id = ?", $event->getIdentity());
    
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
    
    // search
    if ($params['search']) {
      $userTable = Engine_Api::_()->getItemTable('user');
      $userTableName = $userTable->info('name');
      
      $select
        ->joinLeft($userTableName, "$userTableName.user_id = $membershipTableName.user_id", null)
        ->where("$userTableName.displayname LIKE ?", '%' . $params['search'] . '%');
    }
    
    // user not admin and not host
    if ($params['user_not_host'] and $params['user_not_admin']) {
      
      $where = "rsvp IN (1, 2, 3) OR $membershipTableName.user_id IN ('". $event->getOwner()->getIdentity() . "'";
      
      if (!empty($params['viewer'])) {
        $where .= ", '" . $params['viewer'] . "'";
      }
      
      $where .= ')';
      
      $select->where($where);
    }
    
    //echo '<pre>'; print_r((string) $select); echo '</pre>'; exit;
    
    return $select;
  }
  
  public function getSiteUrl($params = array())
  {
    $code = '';
    $requestUri = '';
    
    if ($params['code']) {
      // Get settings
      $global_settings_file = APPLICATION_PATH . '/application/settings/general.php';
      if( file_exists($global_settings_file) ) {
        $generalConfig = include $global_settings_file;
      } else {
        $generalConfig = array();
      }
      
      if (!empty($generalConfig)) {
        if (!empty($generalConfig['maintenance'])) {
          if ($generalConfig['maintenance']['code']) {
            $code = '/?en4_maint_code=' . $generalConfig['maintenance']['code'];
          }
        }
      }
    }
    
    if ($params['request_uri']) {
      $requestUri = $_SERVER['REQUEST_URI'];
    }
    
    $protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off' || $_SERVER['SERVER_PORT'] == 443) ? "https://" : "http://";
    
    $url = $protocol . $_SERVER['SERVER_NAME'] . $requestUri . $code;
    
    return $url;
  }
  
  /**
   * get allowed id's of events in which user can join
   * @param User_Model_User $user
   *  
   * @return array $allowedEventsIds
   */
  public function getEventAllowedIds($user = null)
  {
    
    if (!($user instanceof User_Model_User)) {
      return array('allow_all' => true);
    }
    
    $membershipTable = Engine_Api::_()->getDbTable('membership', 'event');
    $membershipTableName = $membershipTable->info('name');
    
    $eventTable = Engine_Api::_()->getDbTable('events', 'event');
    $eventTableName = $eventTable->info('name');
    
    $allowedEventsIds = array();
    
    $dateNow = date('Y-m-d H:i:s', time());
    
    // select all open event where host is not our user
    $select = $eventTable->select()
      ->from($eventTableName)
      ->joinLeft($membershipTableName, "$eventTableName.event_id = $membershipTableName.resource_id", null)
      ->where("$eventTableName.endtime > '$dateNow'")
      ->where("$eventTableName.status = 'open'")
      ->where("$eventTableName.user_id != ?", $user->getIdentity())
      ->group("$eventTableName.event_id")
      ;
    
    $allowedEvents = $membershipTable->fetchAll($select);
    
    foreach ($allowedEvents as $event) {
      $allowedEventsIds[] = $event->event_id;
    }
    
    // all events in what user can join again
    $viewerEvents = $membershipTable->fetchAll(array(
      'user_id = ?' => $user->getIdentity(),
      'rsvp NOT IN (?)' => array(0, 1, 2, 3, 4, 9, 10)
      //'rsvp IN (?)' => array(5, 6, 7, 8, 11)
    ));
    
    $viewerEventsIds = array();
    
    foreach ($viewerEvents as $viewerEvent) {
      $viewerEventsIds[] = $viewerEvent->resource_id;
    }
    
    // add only event in where viewer don't join
    $diff = array_merge($allowedEventsIds, $viewerEventsIds);
    
    return $diff;
    
    
    
    
  }
  
}
