<?php
/**
 * SocialEngine
 *
 * @category   Application_Theme
 * @package    Kandy Theme
 * @copyright  Copyright 2006-2012 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: manifest.php 9714 2012-05-07 23:17:50
 * @author     
 */

return array(
  'package' => array(
    'type' => 'theme',
    'name' => 'kandy-cappuccino',
    'version' => '4.8.5',
    'revision' => '$Revision: 10267 $',
    'path' => 'application/themes/kandy-cappuccino',
    'repository' => 'socialengine.com',
    'title' => 'Kandy Cappuccino',
    'thumb' => 'thumb.png',
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
      'application/themes/kandy-cappuccino',
    ),
  ),
  'files' => array(
    'theme.css',
    'constants.css',
  )
) ?>
