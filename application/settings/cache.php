<?php
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
      'gzip' => true,
    ),
  ),
  'backend' => 
  array (
    'Apc' => 
    array (
    ),
  ),
  'default_file_path' => '/var/www/taurussoft/data/www/happetite.newrosoftdev.com/temporary/cache',
); ?>