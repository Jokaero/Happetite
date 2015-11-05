<?php
/**
 * SocialEngine
 *
 * @category   Application_Widget
 * @package    Weather
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @author     John
 */
return array(
  'package' => array(
    'type' => 'widget',
    'name' => 'weather',
    'version' => '4.0.1',
    'revision' => '$Revision: 9747 $',
    'path' => 'application/widgets/weather',
    'repository' => 'socialengine.com',
    'title' => 'Weather',
    'description' => 'Displays the weather.',
    'author' => 'Webligo Developments',
    'changeLog' => array(
      '4.0.1' => array(
        'choose.tpl' => 'Page now reloads when location is selected',
      )
    ),
    'directories' => array(
      'application/widgets/weather',
    ),
  ),

  // Backwards compatibility
  'type' => 'widget',
  'name' => 'weather',
  'version' => '4.0.1',
  'revision' => '$Revision: 9747 $',
  'title' => 'Weather',
  'description' => 'Displays the weather.',
  'category' => 'Widgets',
) ?>