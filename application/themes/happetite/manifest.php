<?php return array (
  'package' => 
  array (
    'type' => 'theme',
    'name' => 'happetite',
    'version' => NULL,
    'revision' => '$Revision: 10113 $',
    'path' => 'application/themes/happetite',
    'repository' => 'socialengine.com',
    'title' => 'happetite',
    'thumb' => 'theme.jpg',
    'author' => 'Newrosoftmods',
    'changeLog' => 
    array (
      '4.7.0' => 
      array (
        'images/*' => 'Optimized images',
        'manifest.php' => 'Incremented version',
      ),
      '4.6.0' => 
      array (
        'manifest.php' => 'Incremented version',
        'theme.css' => 'Fixed issue with user-select',
      ),
      '4.2.9p1' => 
      array (
        'manifest.php' => 'Incremented version',
        'theme.css' => 'Fixed issue with missing image',
      ),
    ),
    'actions' => 
    array (
      0 => 'install',
      1 => 'upgrade',
      2 => 'refresh',
      3 => 'remove',
    ),
    'callback' => 
    array (
      'class' => 'Engine_Package_Installer_Theme',
    ),
    'directories' => 
    array (
      0 => 'application/themes/happetite',
    ),
    'description' => '',
  ),
  'files' => 
  array (
    0 => 'theme.css',
    1 => 'constants.css',
  ),
); ?>