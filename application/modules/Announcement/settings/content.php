<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Announcement
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: content.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */
return array(
  array(
    'title' => 'Announcements',
    'description' => 'Displays recent announcements.',
    'category' => 'Core',
    'type' => 'widget',
    'name' => 'announcement.list-announcements',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => 'Announcements',
    ),
    'requirements' => array(
      'no-subject',
    ),
  ),
) ?>