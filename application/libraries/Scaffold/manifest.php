<?php return array(
  'package' => array(
    'type' => 'library',
    'name' => 'scaffold',
    'version' => '4.8.1',
    'revision' => '$Revision: 10171 $',
    'path' => 'application/libraries/Scaffold',
    'repository' => 'socialengine.com',
    'title' => 'CSS Scaffold',
    'author' => 'Webligo Developments',
    'changeLog' => array(
      '4.8.1' => array(
        'manifest.php' => 'Incremented version',
        'libraries/Scaffold/Scaffold.php' => 'Added Content-Length to compressed output',
      ),
      '4.5.0' => array(
        'manifest.php' => 'Incremented version',
        'views/scaffold_error.php' => 'Fixed potential XSS',
      ),
      '4.1.1' => array(
        'manifest.php' => 'Incremented version',
        'modules/Absolute_Urls.php' => 'Added hack to send expires flush counter to images in the stylesheets'
      ),
      '4.0.3' => array(
        'libraries/Scaffold/Scaffold.php' => 'Fix for open_basedir warning',
        'manifest.php' => 'Incremented version',
      ),
      '4.0.2' => array(
        'libraries/Scaffold/Scaffold.php' => 'Fix for open_basedir warning',
        'manifest.php' => 'Incremented version',
      ),
    ),
    'directories' => array(
      'application/libraries/Scaffold',
    )
  )
) ?>