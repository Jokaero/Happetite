<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Announcement
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Core.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Announcement
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Announcement_Plugin_Core
{
  public function onItemDeleteBefore($event)
  {
    $payload = $event->getPayload();
    if( $payload instanceof Core_Model_Item_Abstract && $payload->getType() === 'user' )
    {
      $table = Engine_Api::_()->getDbtable('announcements', 'announcement');
      foreach( $table->fetchAll($table->select()->where('user_id = ?', $payload->getIdentity())) as $announcement )
      {
        $announcement->delete();
      }
    }
  }
}