<?php
/**
 * SocialEngine
 *
 * @category   Application_Theme
 * @package    Musicbox Theme
 * @copyright  Copyright 2006-2012 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: manifest.php 9714 2012-05-07 23:17:50
 * @author     
 */

return array(
  'package' => array(
    'type' => 'theme',
    'name' => 'musicbox-brown',
    'version' => '4.8.5',
    'revision' => '$Revision: 10267 $',
    'path' => 'application/themes/musicbox-brown',
    'repository' => 'socialengine.com',
    'title' => 'Musicbox Brown',
    'thumb' => 'musicbox_brown.png',
    'author' => 'Webligo Developments',
    'changeLog' => array(
      '4.8.5' => array(
        'theme.css' => 'Display the submit button when flash is disabled',
        'manifest.php' => 'Incremented version',
      ),
      '4.7.0' => array(
        'images/*' => 'Optimized images',
        'manifest.php' => 'Incremented version',
      ),
      '4.6.0' => array(
        'manifest.php' => 'Incremented version',
        'theme.css' => 'Fixed issue with user-select',
      ),
    ),
    'actions' => array(
      'install',
      'upgrade',
      'refresh',
      'remove',
    ),
    'callback' => array(
      'class' => 'Engine_Package_Installer_Theme',
    ),
    'directories' => array(
      'application/themes/musicbox-brown',
    ),
  ),
  'files' => array(
    'theme.css',
    'constants.css',
  ),
  'nophoto' => array(
    'user' => array(
      'thumb_icon' => 'application/themes/musicbox-brown/images/nophoto_user_thumb_icon.png',
      'thumb_profile' => 'application/themes/musicbox-brown/images/nophoto_user_thumb_profile.png',
    ),
    'group' => array(
      'thumb_normal' => 'application/themes/musicbox-brown/images/nophoto_event_thumb_normal.jpg',
      'thumb_profile' => 'application/themes/musicbox-brown/images/nophoto_event_thumb_profile.jpg',
    ),
    'event' => array(
      'thumb_normal' => 'application/themes/musicbox-brown/images/nophoto_event_thumb_normal.jpg',
      'thumb_profile' => 'application/themes/musicbox-brown/images/nophoto_event_thumb_profile.jpg',
    ),
  ),
) ?>
