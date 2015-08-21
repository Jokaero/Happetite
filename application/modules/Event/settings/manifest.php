<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: manifest.php 10267 2014-06-10 00:55:28Z lucas $
 * @author     Sami
 */
return array(
  // Package -------------------------------------------------------------------
  'package' => array(
    'type' => 'module',
    'name' => 'event',
    'version' => '4.8.5',
    'revision' => '$Revision: 10267 $',
    'path' => 'application/modules/Event',
    'repository' => 'socialengine.com',
    'title' => 'Events',
    'description' => 'Events',
    'author' => 'Webligo Developments',
    'changeLog' => 'settings/changelog.php',
    'dependencies' => array(
      array(
        'type' => 'module',
        'name' => 'core',
        'minVersion' => '4.2.0',
      ),
    ),
    'actions' => array(
      'install',
      'upgrade',
      'refresh',
      'enable',
      'disable',
    ),
    'callback' => array(
      'path' => 'application/modules/Event/settings/install.php',
      'class' => 'Event_Installer',
    ),
    'directories' => array(
      'application/modules/Event',
    ),
    'files' => array(
      'application/languages/en/event.csv',
    ),
  ),
  // Hooks ---------------------------------------------------------------------
  'hooks' => array(
    array(
      'event' => 'onStatistics',
      'resource' => 'Event_Plugin_Core'
    ),
    array(
      'event' => 'onUserDeleteBefore',
      'resource' => 'Event_Plugin_Core',
    ),
    array(
      'event' => 'getActivity',
      'resource' => 'Event_Plugin_Core',
    ),
    array(
      'event' => 'addActivity',
      'resource' => 'Event_Plugin_Core',
    ),
    array(
      'event' => 'onRenderLayoutDefault',
      'resource' => 'Event_Plugin_Core',
    ),
    array(
      'event' => 'onUserCreateAfter',
      'resource' => 'Event_Plugin_Core',
    ),
  ),
  // Items ---------------------------------------------------------------------
  'items' => array(
    'event',
    'event_album',
    'event_category',
    'event_photo',
    'event_post',
    'event_topic',
    'event_transaction',
    'event_slide',
  ),
  // Routes --------------------------------------------------------------------
  'routes' => array(
    'event_extended' => array(
      'route' => 'classes/:controller/:action/*',
      'defaults' => array(
        'module' => 'event',
        'controller' => 'index',
        'action' => 'index',
      ),
      'reqs' => array(
        'controller' => '\D+',
        'action' => '\D+',
      )
    ),
    'event_general' => array(
      'route' => 'classes/:action/*',
      'defaults' => array(
        'module' => 'event',
        'controller' => 'index',
        'action' => 'browse',
      ),
      'reqs' => array(
        'action' => '(index|browse|create|delete|list|manage|edit|job|bank)',
      )
    ),
    'event_payment' => array(
      'route' => 'classes/payment/:action/*',
      'defaults' => array(
        'module' => 'event',
        'controller' => 'payment',
        'action' => 'pay',
      ),
      'reqs' => array(
        'action' => '(pay|success)',
        //'event_id' => '\d+',
      )
    ),
    'event_specific' => array(
      'route' => 'classes/:action/:event_id/*',
      'defaults' => array(
        'module' => 'event',
        'controller' => 'event',
        'action' => 'index',
      ),
      'reqs' => array(
        'action' => '(edit|edit-bank|delete|join|leave|invite|accept|style|reject|cancel|members-full|finish)',
        'event_id' => '\d+',
      )
    ),
    'event_profile' => array(
      'route' => 'class/:id/*',
      'defaults' => array(
        'module' => 'event',
        'controller' => 'profile',
        'action' => 'index',
      ),
      'reqs' => array(
        'id' => '\d+',
      )
    ),
    'event_upcoming' => array(
      'route' => 'classes/upcoming/*',
      'defaults' => array(
        'module' => 'event',
        'controller' => 'index',
        'action' => 'browse',
        'filter' => 'future'
      )
    ),
    'event_past' => array(
      'route' => 'classes/past/*',
      'defaults' => array(
        'module' => 'event',
        'controller' => 'index',
        'action' => 'browse',
        'filter' => 'past'
      )
    ),
    'event_photo' => array(
      'route' => 'class/:action',
      'defaults' => array(
        'module' => 'event',
        'controller' => 'index',
        'action' => 'upload-photo',
      ),
      'reqs' => array(
        'controller' => '\D+',
        'action' => '\D+',
      )
    ),
    'event_steps' => array(
      'route' => 'classes/step/:action/*',
      'defaults' => array(
        'module' => 'event',
        'controller' => 'classes-steps',
        'action' => 'index',
      ),
      'reqs' => array(
        'action' => '(index|guest|host|guest-share|host-share)',
        //'event_id' => '\d+',
      )
    ),
  )
) ?>
