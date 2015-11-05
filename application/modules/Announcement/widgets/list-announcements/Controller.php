<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Announcement
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Controller.php 10139 2014-03-11 13:49:08Z andres $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Announcement
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Announcement_Widget_ListAnnouncementsController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    // Only Display Items that match member's Network, Member Level, or  Profile Type
    $user = Engine_Api::_()->user()->getViewer();
    
    if( isset($user['user_id'] ) ) { $user_id = $user['user_id']; }
    else { $user_id = null;}
    
    // Get Member Level ID
    if( isset( $user['level_id'] )) { $user_member_level_id = $user['level_id']; }
    else{ 
      // Get Public Member Level ID
      $auth_level_table = Engine_Api::_()->getDbtable('levels', 'authorization');
      $auth_level_select = $auth_level_table->select('level_id')->where('flag = ?', 'public');
      $auth_level_id_query = $auth_level_table->fetchRow($auth_level_select);
      $user_member_level_id = $auth_level_id_query['level_id'];     
      } 
      
    // Get Network IDs
    if( $user_id != null) {
      $network_table = Engine_Api::_()->getDbtable('membership', 'network');
      $network_select = $network_table->select('resource_id')->where('user_id = ?', $user_id);
      $network_id_query = $network_table->fetchAll($network_select);
      $network_id_query_count = count($network_id_query);
      $network_id_array = array();
      for($i = 0; $i < $network_id_query_count; $i++) {
        $network_id_array[$i] = $network_id_query[$i]['resource_id'];
      }
      
      // Get Profile Type
      $profile_table = Engine_Api::_()->fields()->getTable('user', 'values');
      $profile_select = $profile_table->select('value')->where('field_id = 1 AND item_id = ?', $user_id);
      $profile_type_query = $profile_table->fetchRow($profile_select);
      $profile_type_id = $profile_type_query['value'];
    }
    else{
      $network_id_array = null;
      $profile_type_id = null;
    }   
    
    // Get Announcements
    // Get paginator
    $table = Engine_Api::_()->getDbtable('announcements', 'announcement');
    $announcement_select = $table->select()->order('creation_date DESC');
    $announcement_query = $table->fetchAll($announcement_select);
    
    // Keep only Relevent Announcements
    $announcement_keep_list = array();
    $announcement_count = count($announcement_query);
    // Expand JSON Arrays into Annoucement Arrays
    for($i = 0; $i < $announcement_count; $i++) {
        // Convert JSON strings to Arrays
        $continue = false;
        $network_array = json_decode($announcement_query[$i]['networks']);
        // Check if Member Networks Match Annoucement Networks
        if ($network_array != NULL)
            foreach ( $network_array as $value) {
                if( $network_id_array != NULL && in_array( $value, $network_id_array) != FALSE ) {
                    array_push($announcement_keep_list, $announcement_query[$i]);
                    $continue = true;
                    break;
                }
            }
        if ($continue)
            continue;
      
      $member_level_array = json_decode($announcement_query[$i]['member_levels']);
      // Check if Member Level Matches Annoucement Level
      if( $member_level_array != NULL && $user_member_level_id != NULL && in_array( $user_member_level_id, $member_level_array) != FALSE ) {
        array_push($announcement_keep_list, $announcement_query[$i]);
        continue;
      }      
      
      $profile_type_array = json_decode($announcement_query[$i]['profile_types']);     
      // Check Member Profile Type Matches Anncounement Profile Type
      if( $profile_type_array != NULL && $profile_type_id != NULL && in_array( $profile_type_id, $profile_type_array) != FALSE ) {
        array_push($announcement_keep_list, $announcement_query[$i]);
        continue;
      } 
    }
    
    $paginator = Zend_Paginator::factory($announcement_keep_list);
    
    // Set item count per page and current page number
    $paginator->setItemCountPerPage($this->_getParam('itemCountPerPage', 2));
    $paginator->setCurrentPageNumber($this->_getParam('page', 1));   

    // Hide if nothing to show
    if( $paginator->getTotalItemCount() <= 0 ) {
      return $this->setNoRender();
    }
    
    $this->view->announcements = $paginator;
  }
}
