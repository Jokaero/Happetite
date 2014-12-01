<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Authorization
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Core.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Authorization
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Authorization_Plugin_Core
{
  public function onItemDeleteBefore($event)
  {
    $payload = $event->getPayload();
    if( $payload instanceof Core_Model_Item_Abstract )
    {
      $table = Engine_Api::_()->getDbtable('allow', 'authorization');
      $table->delete(array(
        'resource_type = ?' => $payload->getType(),
        'resource_id = ?' => $payload->getIdentity(),
      ));
    }
  }
}