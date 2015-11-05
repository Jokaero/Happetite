<?php return array(
  'package' => array(
    'type' => 'external',
    'name' => 'soundmanager',
    'version' => '4.7.0',
    'revision' => '$Revision: 10111 $',
    'path' => 'externals/soundmanager',
    'repository' => 'socialengine.com',
    'title' => 'SoundManager',
    'author' => 'Webligo Developments',
    'changeLog' => array(
      '4.7.0' => array(
        '*' => 'Upgraded to the latest version',
        'manifest.php' => 'Incremented version',
      ),
      '4.3.0' => array(
        'soundmanager2*' => 'Changed default parameters to use HTML5 first if available',
        'manifest.php' => 'Incremented version',
      ),
      '4.1.8p1' => array(
        '*' => 'Upgrading and adjusting to fix issues with CDN/Flash cross-domain policy',
      ),
      '4.1.8' => array(
        'manifest.php' => 'Incremented version',
        'soundmanager2-nodebug-jsmin.js' => 'Fixed RTL issue that wasn\'t copied from non-minified version',
      ),
      '4.1.1' => array(
        'manifest.php' => 'Incremented version',
        'soundmanager2.js' => 'Added console logging in development mode',
        'soundmanager2-nodebug-jsmin.js' => 'Added console logging in development mode'
      ),
    ),
    'directories' => array(
      'externals/soundmanager',
    ),
  )
) ?>
