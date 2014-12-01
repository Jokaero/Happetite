<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Payment
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Core.php 9747 2012-07-26 02:08:08Z john $
 * @author     John Boehr <j@webligo.com>
 */

/**
 * @category   Application_Core
 * @package    Payment
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Payment_Plugin_Core extends Core_Model_Abstract
{
  public function onUserCreateBefore($event)
  {
    $payload = $event->getPayload();

    if( !($payload instanceof User_Model_User) ) {
      return;
    }

    // Check if the user should be enabled?
    $subscriptionsTable = Engine_Api::_()->getDbtable('subscriptions', 'payment');
    if( !$subscriptionsTable->check($payload) ) {
      $payload->enabled = false;
      // We don't want to save here
    }
  }
  
  public function onUserUpdateBefore($event)
  {
    $payload = $event->getPayload();

    if( !($payload instanceof User_Model_User) ) {
      return;
    }

    // Actually, let's ignore if they've logged in before
    if( !empty($payload->lastlogin_date) ) {
      return;
    }

    // Check if the user should be enabled?
    $subscriptionsTable = Engine_Api::_()->getDbtable('subscriptions', 'payment');
    if( !$subscriptionsTable->check($payload) ) {
      $payload->enabled = false;
      // We don't want to save here
    }
  }

  public function onAuthorizationLevelDeleteBefore($event)
  {
    $payload = $event->getPayload();

    if( $payload instanceof Authorization_Model_Level ) {
      $packagesTable = Engine_Api::_()->getDbtable('packages', 'payment');
      $packagesTable->update(array(
        'level_id' => 0,
      ), array(
        'level_id = ?' => $payload->getIdentity(),
      ));
    }
  }
}