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
      'caching' => false,
      'gzip' => false,
    ),
  ),
  'backend' => 
  array (
    'File' => 
    array (
      'file_locking' => true,
      'cache_dir' => '/home/happetite/public_html/beta/temporary/cache',
    ),
  ),
  'default_file_path' => '/home/happetite/public_html/beta/temporary/cache',
); ?>