<?php
/**
 * @package     Engine_Core
 * @version     $Id: index.php 9764 2012-08-17 00:04:31Z matthew $
 * @copyright   Copyright (c) 2008 Webligo Developments
 * @license     http://www.socialengine.com/license/
 */

// Check version
if( version_compare(phpversion(), '5.1.2', '<') ) {
  printf('PHP 5.1.2 is required, you have %s', phpversion());
  exit(1);
}

// Constants
define('_ENGINE_R_BASE', dirname($_SERVER['SCRIPT_NAME']));
define('_ENGINE_R_FILE', $_SERVER['SCRIPT_NAME']);
define('_ENGINE_R_REL', 'application');
define('_ENGINE_R_TARG', 'index.php');

// Main
include dirname(__FILE__) . DIRECTORY_SEPARATOR
  . _ENGINE_R_REL . DIRECTORY_SEPARATOR
  . _ENGINE_R_TARG;
