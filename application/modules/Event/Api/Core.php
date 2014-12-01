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
        'CHF' => 'CHF',
        'EUR' => 'EUR',
        'USD' => 'USD',
        'GBP' => 'GBP',
    );
  }
}
