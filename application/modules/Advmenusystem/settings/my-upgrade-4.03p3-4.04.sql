UPDATE `engine4_core_modules` SET `version` = '4.04' WHERE `engine4_core_modules`.`name` = 'advmenusystem' LIMIT 1 ;
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci  ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci  ;

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES 
('advmenusystem_admin_contents_menu', 'advmenusystem', 'Content Settings', '', '{"route":"admin_default","module":"advmenusystem","controller":"contents"}', 'advmenusystem_admin_main', '', 4), 
('advmenusystem_admin_socials_menu', 'advmenusystem', 'Social Link Settings', '', '{"route":"admin_default","module":"advmenusystem","controller":"socials"}', 'advmenusystem_admin_main', '', 5);

UPDATE `engine4_core_menuitems` set `submenu` = 0 WHERE `menu` = 'core_main';