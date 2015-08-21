UPDATE `engine4_core_modules` SET `version` = '4.02' WHERE `engine4_core_modules`.`name` = 'socialbridge' LIMIT 1;

INSERT IGNORE INTO `engine4_core_menus` (`name`, `type`, `title`) VALUES
('socialbridge_main', 'standard', 'Social Main Navigation Menu');

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('user_settings_socialBridge', 'socialbridge', 'Manage Social Settings', '', '{"route":"default", "module":"socialbridge", "controller":"index", "action":"index"}', 'user_settings', '',  999),
('socialbridge_main_connection', 'socialbridge', 'Connections', '', '{"route":"default","module":"socialbridge","controller":"index","action":"index"}', 'socialbridge_main', '', 1);
