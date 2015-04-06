<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: index.tpl 9867 2013-02-12 21:17:02Z jung $
 * @access	   John
 */
?>

<?php
  
  $params = array(
    'id' => 'profile_members_slider',
    'event_host_menu' => true,
    'event_members_rsvp' => true,
  );
  
  echo $this->slider($this->members, $params);
?>

