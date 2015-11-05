INSERT IGNORE INTO `engine4_core_modules` (`name`, `title`, `description`, `version`, `enabled`, `type`) VALUES  ('advmenusystem', 'Advanced Menu System', 'This is Advanced Menu System module.', '4.04p3', 1, 'extra') ;

DELETE FROM `engine4_core_menus` WHERE `name` = 'advmenusystem_mini' LIMIT 1;

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES  
('core_admin_main_plugins_advmenusystem', 'advmenusystem', 'Adv Menu System', '', '{"route":"admin_default","module":"advmenusystem","controller":"menus"}', 'core_admin_main_plugins', '', 999),
('advmenusystem_admin_main_menus', 'advmenusystem', 'Menu Settings', '', '{"route":"admin_default","module":"advmenusystem","controller":"menus"}', 'advmenusystem_admin_main', '', 2),
('advmenusystem_admin_main_styles', 'advmenusystem', 'Style Settings', '', '{"route":"admin_default","module":"advmenusystem","controller":"styles"}', 'advmenusystem_admin_main', '', 3);

ALTER TABLE `engine4_core_menuitems`     ADD COLUMN `flag_unique` INT(2) DEFAULT '0' NOT NULL;
ALTER TABLE `engine4_core_menuitems` DROP KEY `name`, ADD UNIQUE `name` (`name`, `flag_unique`);

ALTER TABLE `engine4_activity_notifications` ADD INDEX ( `user_id`,`type`,`mitigated`);
ALTER TABLE `engine4_activity_notifications` ADD INDEX ( `user_id`,`type`,`read`); 

CREATE TABLE IF NOT EXISTS `engine4_advmenusystem_submenus` (
  `submenu_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) unsigned NOT NULL,
  `level` int(1) unsigned NOT NULL,
  `name` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `label` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `params` text COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `order` smallint(6) NOT NULL DEFAULT '999',
  `core_menu_id` int(11) DEFAULT '0' NOT NULL,
  PRIMARY KEY (`submenu_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `engine4_advmenusystem_contents` (
  `content_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) unsigned NOT NULL,
  `level` int(1) NOT NULL,
  `photo_id` int(11) NOT NULL,
  `params` text COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `order` smallint(6) NOT NULL DEFAULT '999',
  `modified_date` datetime NOT NULL,
  `creation_date` datetime NOT NULL,
  PRIMARY KEY (`content_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES 
('advmenusystem_admin_contents_menu', 'advmenusystem', 'Content Settings', '', '{"route":"admin_default","module":"advmenusystem","controller":"contents"}', 'advmenusystem_admin_main', '', 4), 
('advmenusystem_admin_socials_menu', 'advmenusystem', 'Social Link Settings', '', '{"route":"admin_default","module":"advmenusystem","controller":"socials"}', 'advmenusystem_admin_main', '', 5);
