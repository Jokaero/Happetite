INSERT IGNORE INTO `engine4_core_modules` (`name`, `title`, `description`, `version`, `enabled`, `type`) VALUES  ('socialbridge', 'Social Bridge', 'This is Social Bridge plugin.', '4.04p3', 1, 'extra') ;

CREATE TABLE IF NOT EXISTS `engine4_socialbridge_apisettings` (
  `apisetting_id` int(11) NOT NULL AUTO_INCREMENT,
  `api_name` varchar(50) NOT NULL,
  `api_params` text NOT NULL,
  PRIMARY KEY (`apisetting_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `engine4_socialbridge_tokens` (
  `token_id` int(11) NOT NULL auto_increment,
  `access_token` varchar(256) collate utf8_unicode_ci default NULL,
  `secret_token` varchar(256) collate utf8_unicode_ci NOT NULL,
  `user_id` int(11) unsigned NOT NULL default '0',
  `session_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `service` varchar(32) collate utf8_unicode_ci NOT NULL,
  `uid` varchar(64) collate utf8_unicode_ci NOT NULL,
  `profile` text collate utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  PRIMARY KEY  (`token_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;

CREATE TABLE IF NOT EXISTS `engine4_socialbridge_queues` (
  `queue_id` int(11) unsigned NOT NULL auto_increment,
  `token_id`  int(11) NOT NULL,
  `user_id` int(11) unsigned NOT NULL default '0',
  `service` varchar(32) NOT NULL,
  `type` varchar(32) NOT NULL,
  `extra_params` text collate utf8_unicode_ci NOT NULL,
  `link` text collate utf8_unicode_ci NOT NULL,
  `message` text collate utf8_unicode_ci NOT NULL,
  `last_run` datetime NOT NULL,
  `next_run` datetime NOT NULL,
  `priority` tinyint(1) NOT NULL DEFAULT '1',
  `error_id` int(11) NOT NULL default '0',
  `error_message` text collate utf8_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY  (`queue_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `engine4_socialbridge_statistics` (
  `statistic_id` int(11) NOT NULL auto_increment,
  `service` varchar(32) NOT NULL,
  `user_id` int(11) unsigned NOT NULL default '0',
  `uid` varchar(64) collate utf8_unicode_ci NOT NULL,
  `invite_of_day` int(20) unsigned NOT NULL default '0',
  `date` date NOT NULL,
  PRIMARY KEY  (`statistic_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('core_admin_main_plugins_socialbridge', 'socialbridge', 'Social Brigde', '', '{"route":"admin_default","module":"socialbridge","controller":"settings","action":"fbsetting"}', 'core_admin_main_plugins', '', 999);

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('socialbridge_admin_main_fbsetting', 'socialbridge', 'Facebook Settings', '', '{"route":"admin_default","module":"socialbridge","controller":"settings","action":"fbsetting"}', 'socialbridge_admin_main', '', 1);

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('socialbridge_admin_main_twsetting', 'socialbridge', 'Twitter Settings', '', '{"route":"admin_default","module":"socialbridge","controller":"settings","action":"twsetting"}', 'socialbridge_admin_main', '', 2);

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('socialbridge_admin_main_lisetting', 'socialbridge', 'Linkedin Settings', '', '{"route":"admin_default","module":"socialbridge","controller":"settings","action":"lisetting"}', 'socialbridge_admin_main', '', 3);


INSERT IGNORE INTO `engine4_core_menus` (`name`, `type`, `title`) VALUES
('socialbridge_main', 'standard', 'Social Main Navigation Menu');

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('user_settings_socialBridge', 'socialbridge', 'Manage Social Settings', '', '{"route":"default", "module":"socialbridge", "controller":"index", "action":"index"}', 'user_settings', '', 999),
('socialbridge_main_connection', 'socialbridge', 'Connections', '', '{"route":"default","module":"socialbridge","controller":"index","action":"index"}', 'socialbridge_main', '', 1);


