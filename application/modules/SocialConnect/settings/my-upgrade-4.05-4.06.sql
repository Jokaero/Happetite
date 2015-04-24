DROP TABLE engine4_socialconnect_settings;
--
-- Add the menu item on the menu inside the user setting page 
--
INSERT INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) 
VALUES ('user_settings_linkedAccount', 'social-connect', 'Account Linking', '', '{"route":"default", "module":"social-connect", "controller":"index", "action":"account-linking"}', 'user_settings', '', 1, 0, 999);

ALTER TABLE `engine4_socialconnect_accounts` ADD `returning` TINYINT( 1 ) NOT NULL DEFAULT '0' AFTER `profile`;
UPDATE `engine4_core_menuitems` SET `label` = 'Providers' WHERE `engine4_core_menuitems`.`name` = 'socialconnect_admin_providers';