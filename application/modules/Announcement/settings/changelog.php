<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Announcement
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: changelog.php 10267 2014-06-10 00:55:28Z lucas $
 * @author     John
 */
return array(
  '4.8.0' => array(
    'settings/manifest.php' => 'Incremented version',
    'settings/my.sql' => 'Incremented version',
    'widgets/list-announcements/Controller.php' => 'Fixed duplicate announcements',
  ),
  '4.7.0' => array(
    'externals/images/*' => 'Optimized images',
    'settings/changelog.php' => 'Incremented version',
    'settings/manifest.php' => 'Incremented version',
    'settings/my.sql' => 'Incremented version',
    'widgets/list-announcements/Controller.php' => 'Fixed some warnings',
  ),
  '4.6.0' => array(
    'settings/changelog.php' => 'Incremented version',
    'settings/manifest.php' => 'Incremented version',
    'settings/my.sql' => 'Incremented version',
    'views/scripts/admin-manage/index.tpl' => 'Fixed issue with displaying announcement to correct set of members',
    'widgets/list-announcements/Controller.php' => 'Fixed issue with displaying announcement to correct set of members',
  ),
  '4.5.0' => array(
    'settings/changelog.php' => 'Incremented version',
    'settings/manifest.php' => 'Incremented version',
    'settings/my.sql' => 'Incremented version',
  ),
  '4.3.0' => array(
    'settings/changelog.php' => 'Incremented version',
    'settings/manifest.php' => 'Incremented version',
    'settings/my.sql' => 'Incremented version',
    'widgets/list-announcements/Controller.php' => 'Fixed exception',
  ),
  '4.2.9p1' => array(
    'settings/changelog.php' => 'Incremented version',
    'settings/manifest.php' => 'Incremented version',
    'settings/my.sql' => 'Incremented version',
    'widgets/list-announcements/Controller.php' => 'Fixed issue where announcements would not be displayed to anonymous visitor',
  ),
  '4.2.9' => array(
    'controllers/AdminManageController.php' => 'Added ability to target announcements',
    'settings/changelog.php' => 'Incremented version',
    'settings/manifest.php' => 'Incremented version',
    'settings/my-upgrade-4.2.8-4.2.9.sql' => 'Added',
    'settings/my.sql' => 'Incremented version',
    'views/scripts/admin-manage/index.tpl' => 'Added support links in admin panel',
    'widgets/list-announcements/Controller.php' => 'Added ability to target announcements',
    'form/admin/create.php' => 'Added ability to target announcements',
    'form/admin/edit.php' => 'Added ability to target announcements',
  ),
  '4.2.3' => array(
    'controllers/AdminManageController.php' => 'Different',
    'Form/Admin/Create.php' => 'Allow TinyMCE',
    'Form/Admin/Edit.php' => 'Allow TinyMCE',
    'settings/changelog.php' => 'Incremented version',
    'settings/manifest.php' => 'Incremented version',
    'settings/my-upgrade-4.2.8-4.2.9.sql' => 'Added',
    'settings/my.sql' => 'Incremented version',
    'views/scripts/admin-manage/index.tpl' => 'Added support links in admin panel',
    'widgets/list-announcements/Controller.php' => 'Different',
  ),
  '4.2.2' => array(
    'settings/changelog.php' => 'Incremented version',
    'settings/manifest.php' => 'Incremented version',
    'settings/my.sql' => 'Incremented version',
    'views/scripts/admin-manage/index.tpl' => 'MooTools 1.4 compatibility',
  ),
  '4.2.0' => array(
    'settings/changelog.php' => 'Incremented version',
    'settings/manifest.php' => 'Incremented version',
    'settings/my.sql' => 'Incremented version',
  ),
  '4.1.8' => array(
    'Api/Core.php' => 'Refactored deprecated method calls',
    'externals/.htaccess' => 'Updated with far-future expires headers for static resources',
    'settings/changelog.php' => 'Incremented version',
    'settings/manifest.php' => 'Incremented version',
    'settings/my.sql' => 'Incremented version',
    'views/scripts/admin-manage/index.tpl' => 'Added static base URL for CDN support',
  ),
  '4.1.7' => array(
    'controllers/AdminManageController.php' => 'Removing deprecated usage of $this->_helper->api()',
    'settings/changelog.php' => 'Incremented version',
    'settings/manifest.php' => 'Incremented version',
    'settings/my.sql' => 'Incremented version',
  ),
  '4.1.4' => array(
    'externals/styles/main.css' => 'Removed constants include',
    'externals/styles/mobile.css' => 'Added',
    'settings/changelog.php' => 'Incremented version',
    'settings/manifest.php' => 'Incremented version',
    'settings/my.sql' => 'Incremented version',
  ),
  '4.1.2' => array(
    'settings/changelog.php' => 'Incremented version',
    'settings/content.php' => 'Added preliminary layout enhancements',
    'settings/manifest.php' => 'Incremented version',
    'settings/my.sql' => 'Incremented version',
  ),
  '4.1.1' => array(
    'externals/.htaccess' => 'Added keywords; removed deprecated code',
    'settings/changelog.php' => 'Incremented version',
    'settings/manifest.php' => 'Incremented version',
    'settings/my.sql' => 'Incremented version',
  ),
  '4.1.0' => array(
    'Model/Announcement.php' => 'Fixed incorrect getHref() method',
    'settings/changelog.php' => 'Incremented version',
    'settings/content.php' => 'Added pagination/item count limits to widgets',
    'settings/manifest.php' => 'Incremented version',
    'settings/my.sql' => 'Incremented version',
    'widgets/list-announcements/Controller.php' => 'Added pagination/item count limit',
  ),
  '4.0.3' => array(
    'Model/Announcement.php' => 'Removed redundant code',
    'settings/changelog.php' => 'Added',
    'settings/manifest.php' => 'Incremented version',
    'settings/my.sql' => 'Incremented version',
  ),
  '4.0.2' => array(
    'settings/manifest.php' => 'Incremented version',
    'settings/my.sql' => 'Incremented version',
    '/application/languages/en/announcement.csv' => 'Added phrases',
  ),
  '4.0.1' => array(
    'settings/manifest.php' => 'Incremented version',
    'widgets/list-announcements/index.tpl' => 'Switched array to paginator',
  ),
) ?>