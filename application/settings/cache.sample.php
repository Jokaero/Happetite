<?php
/**
 * SocialEngine
 *
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: cache.sample.php 9747 2012-07-26 02:08:08Z john $
 */
defined('_ENGINE') or die('Access Denied');
return array (
  'default_backend' => 'File',
  'frontend' => 
  array (
    'core' => 
    array (
      'automatic_serialization' => true,
      'cache_id_prefix' => 'Engine4_',
      'lifetime' => '300',
      'caching' => true,
    ),
  ),
  'backend' => array(
    'File' => array(
      'cache_dir' => APPLICATION_PATH . '/temporary/cache'
    )
  )
);
?>
