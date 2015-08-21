<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: content.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 * 
 */
return array(
  array(
    'title' => 'Upcoming Events',
    'description' => 'Displays the logged-in member\'s upcoming events.',
    'category' => 'Events',
    'type' => 'widget',
    'name' => 'event.home-upcoming',
    'isPaginated' => true,
    'requirements' => array(
      'viewer',
      'no-subject',
    ),
    'adminForm' => array(
      'elements' => array(
        array(
          'Text',
          'title',
          array(
            'label' => 'Title'
          )
        ),
        array(
          'Radio',
          'type',
          array(
            'label' => 'Show',
            'multiOptions' => array(
              '1' => 'Any upcoming events.',
              '2' => 'Current member\'s upcoming events.',
              '0' => 'Any upcoming events when member is logged out, that member\'s events when logged in.',
            ),
            'value' => '0',
          )
        ),
      )
    ),
  ),
  array(
    'title' => 'Profile Events',
    'description' => 'Displays a member\'s events on their profile.',
    'category' => 'Events',
    'type' => 'widget',
    'name' => 'event.profile-events',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => 'Events',
      'titleCount' => true,
    ),
    'requirements' => array(
      'subject' => 'user',
    ),
  ),
  array(
    'title' => 'My Classes',
    'description' => 'Displays a member\'s classes on their profile.',
    'category' => 'Events',
    'type' => 'widget',
    'name' => 'event.profile-my-events',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => 'Events',
      'titleCount' => true,
    ),
    'requirements' => array(
      'subject' => 'user',
    ),
  ),
  array(
    'title' => 'Event Profile Discussions',
    'description' => 'Displays a event\'s discussions on it\'s profile.',
    'category' => 'Events',
    'type' => 'widget',
    'name' => 'event.profile-discussions',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => 'Discussions',
      'titleCount' => true,
    ),
    'requirements' => array(
      'subject' => 'event',
    ),
  ),
  array(
    'title' => 'Event Profile Info',
    'description' => 'Displays a event\'s info (creation date, member count, etc) on it\'s profile.',
    'category' => 'Events',
    'type' => 'widget',
    'name' => 'event.profile-info',
    'requirements' => array(
      'subject' => 'event',
    ),
  ),
  array(
    'title' => 'Event Profile Info Center',
    'description' => 'Displays a event\'s info (creation date, member count, etc) on it\'s profile.',
    'category' => 'Events',
    'type' => 'widget',
    'name' => 'event.profile-info-center',
    'requirements' => array(
      'subject' => 'event',
    ),
  ),
  array(
    'title' => 'Event Profile Members',
    'description' => 'Displays a event\'s members on it\'s profile.',
    'category' => 'Events',
    'type' => 'widget',
    'name' => 'event.profile-members',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => 'Guests',
      'titleCount' => true,
    ),
    'requirements' => array(
      'subject' => 'event',
    ),
  ),
  array(
    'title' => 'Event Profile Members in Slider Core',
    'description' => 'Core Widget for Event Profile Members in Slider. REQUIRED.',
    'category' => 'Events',
    'type' => 'widget',
    'name' => 'event.profile-members-slider-core',
    'requirements' => array(
      'subject' => 'event',
    ),
  ),
  array(
    'title' => 'Event Profile Members in Slider',
    'description' => 'Displays a event\'s members on it\'s profile in Slider.',
    'category' => 'Events',
    'type' => 'widget',
    'name' => 'event.profile-members-slider',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => 'Guests',
      'titleCount' => true,
    ),
    'requirements' => array(
      'subject' => 'event',
    ),
  ),
  array(
    'title' => 'Guests Who attend',
    'description' => 'Displays a event\'s Guests who attend.',
    'category' => 'Events',
    'type' => 'widget',
    'name' => 'event.guests-attend',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => 'Guests',
      'titleCount' => true,
    ),
    'requirements' => array(
      'subject' => 'event',
    ),
  ),
  array(
    'title' => 'Guests Who attend in slider',
    'description' => 'Displays a event\'s Guests who attend in slider.',
    'category' => 'Events',
    'type' => 'widget',
    'name' => 'event.guests-attend-slider',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => 'Guests in slider',
      'titleCount' => true,
    ),
    'requirements' => array(
      'subject' => 'event',
    ),
  ),
  array(
    'title' => 'More classes',
    'description' => 'Displays More classes.',
    'category' => 'Events',
    'type' => 'widget',
    'name' => 'event.more-classes',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => 'More Classes',
      'titleCount' => true,
    ),
    'requirements' => array(
      'subject' => 'event',
    ),
  ),
  array(
    'title' => 'More classes in slider',
    'description' => 'Displays More classes in slider.',
    'category' => 'Events',
    'type' => 'widget',
    'name' => 'event.more-classes-slider',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => 'More Classes in slider',
      'titleCount' => true,
    ),
    'requirements' => array(
      'subject' => 'event',
    ),
  ),
  array(
    'title' => 'Event Profile Options',
    'description' => 'Displays a menu of actions (edit, report, join, invite, etc) that can be performed on a event on it\'s profile.',
    'category' => 'Events',
    'type' => 'widget',
    'name' => 'event.profile-options',
    'requirements' => array(
      'subject' => 'event',
    ),
  ),
  array(
    'title' => 'Event Profile Photo',
    'description' => 'Displays a event\'s photo on it\'s profile.',
    'category' => 'Events',
    'type' => 'widget',
    'name' => 'event.profile-photo',
    'requirements' => array(
      'subject' => 'event',
    ),
  ),
  array(
    'title' => 'Event Profile Photos',
    'description' => 'Displays a event\'s photos on it\'s profile.',
    'category' => 'Events',
    'type' => 'widget',
    'name' => 'event.profile-photos',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => 'Photos',
      'titleCount' => true,
    ),
    'requirements' => array(
      'subject' => 'event',
    ),
  ),
  array(
    'title' => 'Event Profile RSVP',
    'description' => 'Displays options for RSVP\'ing to an event on it\'s profile.',
    'category' => 'Events',
    'type' => 'widget',
    'name' => 'event.profile-rsvp',
    'requirements' => array(
      'subject' => 'event',
    ),
  ),
  
   array(
    'title' => 'Slider on landing',
    'description' => 'Displays slider on landing.',
    'category' => 'Events',
    'type' => 'widget',
    'name' => 'event.landing-slider',
    'requirements' => array(
      'subject' => 'event',
    ),
  ),
  
  array(
    'title' => 'Classes Map',
    'description' => 'Displays class on the map.',
    'category' => 'Events',
    'type' => 'widget',
    'name' => 'event.classes-map',
    'requirements' => array(
      'subject' => 'event',
    ),
  ),
  
  array(
    'title' => 'Class Owner',
    'description' => 'Displays class owner.',
    'category' => 'Events',
    'type' => 'widget',
    'name' => 'event.event-owner',
    'requirements' => array(
      'subject' => 'event',
    ),
  ),
  
  array(
    'title' => 'Event Profile Status',
    'description' => 'Displays a event\'s title on it\'s profile.',
    'category' => 'Events',
    'type' => 'widget',
    'name' => 'event.profile-status',
    'requirements' => array(
      'subject' => 'event',
    ),
  ),
  array(
    'title' => 'Popular Events',
    'description' => 'Displays a list of most viewed events.',
    'category' => 'Events',
    'type' => 'widget',
    'name' => 'event.list-popular-events',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => 'Popular Events',
    ),
    'requirements' => array(
      'no-subject',
    ),
    'adminForm' => array(
      'elements' => array(
        array(
          'Radio',
          'popularType',
          array(
            'label' => 'Popular Type',
            'multiOptions' => array(
              'view' => 'Views',
              'member' => 'Members',
            ),
            'value' => 'view',
          )
        ),
      )
    ),
  ),
  array(
    'title' => 'Recent Events',
    'description' => 'Displays a list of recently created events.',
    'category' => 'Events',
    'type' => 'widget',
    'name' => 'event.list-recent-events',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => 'Recent Events',
    ),
    'requirements' => array(
      'no-subject',
    ),
    'adminForm' => array(
      'elements' => array(
        array(
          'Radio',
          'recentType',
          array(
            'label' => 'Recent Type',
            'multiOptions' => array(
              'creation' => 'Creation Date',
              'modified' => 'Modified Date',
              'start' => 'Started',
              'end' => 'Ended',
            ),
            'value' => 'creation',
          )
        ),
      )
    ),
  ),
  
  array(
    'title' => 'Recent Events Slider',
    'description' => 'Displays a list of recently created events in slider.',
    'category' => 'Events',
    'type' => 'widget',
    'name' => 'event.list-recent-events-slider',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => 'Recent Events Slider',
    ),
    'requirements' => array(
      'no-subject',
    ),
    'adminForm' => array(
      'elements' => array(
        array(
          'Radio',
          'recentType',
          array(
            'label' => 'Recent Type',
            'multiOptions' => array(
              'creation' => 'Creation Date',
              'modified' => 'Modified Date',
              'start' => 'Started',
              'end' => 'Ended',
            ),
            'value' => 'creation',
          )
        ),
      )
    ),
  ),
  
  array(
    'title' => 'Event Browse Search',
    'description' => 'Displays a search form in the event browse page.',
    'category' => 'Events',
    'type' => 'widget',
    'name' => 'event.browse-search',
    'requirements' => array(
      'no-subject',
    ),
  ),
  
  array(
    'title' => 'Classes Filter ',
    'description' => 'Displays a search form in the upcoming classes page.',
    'category' => 'Classes',
    'type' => 'widget',
    'name' => 'event.classes-filter',
    'requirements' => array(
      'no-subject',
    ),
  ),
  
  array(
    'title' => 'Event Browse Menu',
    'description' => 'Displays a menu in the event browse page.',
    'category' => 'Events',
    'type' => 'widget',
    'name' => 'event.browse-menu',
    'requirements' => array(
      'no-subject',
    ),
  ),
  array(
    'title' => 'Event Browse Quick Menu',
    'description' => 'Displays a small menu in the event browse page.',
    'category' => 'Events',
    'type' => 'widget',
    'name' => 'event.browse-menu-quick',
    'requirements' => array(
      'no-subject',
    ),
  ),
  array(
    'title' => 'User Info',
    'description' => 'Displays 3 widgets in 1, some user info.',
    'category' => 'Events',
    'type' => 'widget',
    'name' => 'event.user-info',
  ),
  array(
    'title' => 'How Does It Work',
    'description' => 'How Does It Work Info',
    'category' => 'Events',
    'type' => 'widget',
    'name' => 'event.how-does-it-work',
  ),
  array(
    'title' => 'My Recipes',
    'description' => 'Displays My Recipes on Profile',
    'category' => 'Events',
    'type' => 'widget',
    'name' => 'event.my-recipes',
  ),
  array(
    'title' => 'Share This',
    'description' => 'Displays Share This Buttons',
    'category' => 'Events',
    'type' => 'widget',
    'name' => 'event.share-this',
  ),
  array(
    'title' => 'Class Cover Photo',
    'description' => 'Displays Class Cover Photo',
    'category' => 'Events',
    'type' => 'widget',
    'name' => 'event.event-cover-photo',
  ),
  array(
    'title' => 'Profile About Me',
    'description' => 'About Me Text',
    'category' => 'User',
    'type' => 'widget',
    'name' => 'event.profile-about',
  ),
  
) ?>