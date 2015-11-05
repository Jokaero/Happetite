UPDATE `engine4_core_modules` SET `version` = '4.03' WHERE `engine4_core_modules`.`name` = 'advmenusystem' LIMIT 1 ;

DELETE FROM `engine4_core_menus` WHERE `name` = 'advmenusystem_mini' LIMIT 1;
DELETE FROM `engine4_core_menuitems` WHERE `name` = 'advmenusystem_admin_main_settings' LIMIT 1;

ALTER TABLE `engine4_activity_notifications` ADD INDEX ( `user_id`,`type`,`mitigated`);
ALTER TABLE `engine4_activity_notifications` ADD INDEX ( `user_id`,`type`,`read`); 

UPDATE `engine4_core_menuitems` SET `params` = '{"route":"admin_default","module":"advmenusystem","controller":"menus"}' WHERE `engine4_core_menuitems`.`name` = 'core_admin_main_plugins_advmenusystem' LIMIT 1;

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES  
('advmenusystem_admin_main_menus', 'advmenusystem', 'Menu Settings', '', '{"route":"admin_default","module":"advmenusystem","controller":"menus"}', 'advmenusystem_admin_main', '', 2),
('advmenusystem_admin_main_styles', 'advmenusystem', 'Style Settings', '', '{"route":"admin_default","module":"advmenusystem","controller":"styles"}', 'advmenusystem_admin_main', '', 3);

DELETE FROM `engine4_core_menuitems` WHERE `menu` LIKE 'advmenusystem_mini';
DELETE FROM `engine4_core_content` WHERE `engine4_core_content`.`name` = 'advmenusystem.advmenu-main';
DELETE FROM `engine4_core_content` WHERE `engine4_core_content`.`name` = 'advmenusystem.advmenu-mini';
DELETE FROM `engine4_core_content` WHERE `engine4_core_content`.`name` = 'advmenusystem.advanced-notifications';
