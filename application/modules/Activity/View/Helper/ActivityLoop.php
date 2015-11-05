<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Activity
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: ActivityLoop.php 9814 2012-11-08 20:02:52Z richard $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Activity
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Activity_View_Helper_ActivityLoop extends Activity_View_Helper_Activity
{
  public function activityLoop($actions = null, array $data = array())
  {
    if( null == $actions || (!is_array($actions) && !($actions instanceof Zend_Db_Table_Rowset_Abstract)) ) {
      return '';
    }

    $form = new Activity_Form_Comment();
    $viewer = Engine_Api::_()->user()->getViewer();
    $activity_moderate = "";
	$group_owner ="";
	$group = "";
    try
    {
    $group = Engine_Api::_()->core()->getSubject('group');    
    }
    catch( Exception $e){      
    }
    if ($group) {
    $table = Engine_Api::_()->getDbtable('groups', 'group');
    $select = $table->select()
         ->where('group_id = ?', $group->getIdentity())
         ->limit(1);

    $row = $table->fetchRow($select);
    $group_owner = $row['user_id'];
    }
    if($viewer->getIdentity()){
      $activity_moderate = Engine_Api::_()->getDbtable('permissions', 'authorization')->getAllowed('user', $viewer->level_id, 'activity');
    }
    $data = array_merge($data, array(
      'actions' => $actions,
      'commentForm' => $form,
      'user_limit' => Engine_Api::_()->getApi('settings', 'core')->getSetting('activity_userlength'),
      'allow_delete' => Engine_Api::_()->getApi('settings', 'core')->getSetting('activity_userdelete'),
      'activity_group' =>$group_owner,
      'activity_moderate' =>$activity_moderate,
    ));

    return $this->view->partial(
      '_activityText.tpl',
      'activity',
      $data
    );
  }
}