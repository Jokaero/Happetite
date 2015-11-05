<?php
/**
 * SocialEngine
 *
 * @category   Application_Theme
 * @package    Quantum Theme
 * @copyright  Copyright 2006-2012 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: manifest.php 9714 2012-05-07 23:17:50
 * @author     
 */

return array (
  'package' => array (
    'type' => 'theme',
    'name' => 'quantum-purple',
    'version' => '4.7.0',
    'revision' => '$Revision: 10113 $',
    'path' => 'application/themes/quantum-purple',
    'repository' => 'socialengine.com',
    'title' => 'Quantum Purple',
    'thumb' => 'quantum_theme.png',
    'author' => 'Webligo Developments',
    'changeLog' => array(
      '4.7.0' => array(
        'images/*' => 'Optimized images',
        'manifest.php' => 'Incremented version',
      ),
      '4.6.0' => array(
        'manifest.php' => 'Incremented version',
        'theme.css' => 'Fixed issue with user-select',
      ),    
    ),
    'actions' => array (
      0 => 'install',
      1 => 'upgrade',
      2 => 'refresh',
      3 => 'remove',
    ),
    'callback' => array (
      'class' => 'Engine_Package_Installer_Theme',
    ),
    'directories' => array (
      0 => 'application/themes/quantum-purple',
    ),
  ),
  'files' => array(
    'theme.css',
    'constants.css',
  )
); ?>
