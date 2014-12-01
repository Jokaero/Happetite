<?php
/**
 * SocialEngine
 *
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: session.sample.php 9747 2012-07-26 02:08:08Z john $
 */
defined('_ENGINE') or die('Access Denied'); return array(
  'options' => array(
    'save_path' => 'session',
    'use_only_cookies' => true,
    'remember_me_seconds' => 864000,
    'gc_maxlifetime' => 86400,
    'cookie_httponly' => false,
  ),
  'saveHandler' => array(
    'class' => 'Core_Model_DbTable_Session',
    'params' => array(
      'lifetime' => 86400,
    ),
  )
) ?>