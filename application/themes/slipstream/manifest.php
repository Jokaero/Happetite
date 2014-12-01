<?php
/**
 * SocialEngine
 *
 * @category   Application_Theme
 * @package    SlipStream
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: manifest.php 10267 2014-06-10 00:55:28Z lucas $
 * @author     Bryan
 */

return array(
  'package' => array(
    'type' => 'theme',
    'name' => 'slipstream',
    'version' => '4.8.5',
    'revision' => '$Revision: 10267 $',
    'path' => 'application/themes/slipstream',
    'repository' => 'socialengine.com',
    'title' => 'Slipstream',
    'thumb' => 'slipstream.jpg',
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
      '4.2.0' => array(
        'manifest.php' => 'Incremented version',
        'theme.css' => 'Fixed issue with feed comment option list',
      ),
      '4.1.8' => array(
        'manifest.php' => 'Incremented version',
        'mobile.css' => 'Added styles for HTML5 input elements',
        'theme.css' => 'Added styles for HTML5 input elements',
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
      'application/themes/slipstream',
    ),
  ),
  'files' => array(
    'theme.css',
    'constants.css',
  ),
  'nophoto' => array(
    'user' => array(
      'thumb_icon' => 'application/themes/slipstream/images/nophoto_user_thumb_icon.png',
      'thumb_profile' => 'application/themes/slipstream/images/nophoto_user_thumb_profile.png',
    ),
    'group' => array(
      'thumb_normal' => 'application/themes/slipstream/images/nophoto_event_thumb_normal.jpg',
      'thumb_profile' => 'application/themes/slipstream/images/nophoto_event_thumb_profile.jpg',
    ),
    'event' => array(
      'thumb_normal' => 'application/themes/slipstream/images/nophoto_event_thumb_normal.jpg',
      'thumb_profile' => 'application/themes/slipstream/images/nophoto_event_thumb_profile.jpg',
    ),
  ),
) ?>
