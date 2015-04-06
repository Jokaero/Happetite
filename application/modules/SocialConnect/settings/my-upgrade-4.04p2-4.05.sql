INSERT IGNORE INTO `engine4_core_mailtemplates` (`type`, `module`, `vars`) VALUES
('socialconnect_autopassword', 'social-connect', '[host],[email],[recipient_title],[recipient_link],[sender_name],[object_link]');

# CREATE TABLE TO STORE AGENTS.
DROP TABLE IF EXISTS engine4_socialconnect_accounts;

CREATE TABLE `engine4_socialconnect_accounts` (
  `account_id` int(11) NOT NULL auto_increment,
  `user_id` int(11) unsigned NOT NULL,
  `identity` varchar(128) NOT NULL,
  `service` varchar(64) NOT NULL,
  `profile` text,
  PRIMARY KEY  (`account_id`),  
  KEY `identity` (`identity`,`service`)
) ENGINE=InnoDB;

# MIGRAGTE OLD DATA TO NEW TABLE.
INSERT INTO engine4_socialconnect_accounts(account_id,user_id, identity, service)
SELECT a.agent_id AS account_id, a.user_id as user_id,  a.identity as identity, s.name AS service
FROM engine4_socialconnect_agents AS a
LEFT JOIN engine4_socialconnect_services AS s ON ( s.service_id = a.service_id );


# DELETE UNSUPPORTED ANYMORE
DELETE FROM `engine4_socialconnect_services` WHERE `name` IN ('hyves','openidfrance','yiid','chimp','livejournal','clickpass','getopenid','meinguter','blogger','typepad','blogses','myvidoop','claimid','fupei','identity','daum');

# RE UPDATE ORDER
UPDATE `engine4_socialconnect_services` SET `ordering` = `service_id`;


# UPDATE MENU SETTINGS
INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES
( 'core_admin_main_plugins_socialconnect', 'social-connect', 'Social Connect', NULL, '{"route":"admin_default","module":"social-connect","controller":"settings","action":"index"}', 'core_admin_main_plugins', NULL, 1, 0, 1),
('socialconnect_admin_settings', 'social-connect', 'Global Settings', NULL, '{"route":"admin_default","module":"social-connect","controller":"settings","action":"index"}', 'socialconnect_admin', NULL, 1, 0, 1),
('socialconnect_admin_providers', 'social-connect', 'Provider Settings', NULL, '{"route":"admin_default","module":"social-connect","controller":"settings","action":"listing"}', 'socialconnect_admin', NULL, 1, 0, 2);


INSERT IGNORE INTO `engine4_core_mailtemplates` (`type` ,`module` ,`vars`)
VALUES (
'socialconnect_verify_code', 'social-connect', '');

DROP TABLE IF EXISTS  engine4_socialconnect_fields;
CREATE TABLE `engine4_socialconnect_fields` (
  `field_id` int(11) NOT NULL auto_increment,
  `opt_id` varchar(32) collate utf8_unicode_ci default NULL,
  `field` varchar(32) collate utf8_unicode_ci default NULL,
  `service` varchar(32) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`field_id`)
) ENGINE=InnoDB;

DELETE
FROM `engine4_socialconnect_maps`
WHERE `service` LIKE 'youtube';

DELETE
FROM `engine4_socialconnect_maps`
WHERE `service` LIKE 'picasa';

DELETE
FROM `engine4_socialconnect_maps`
WHERE `service` LIKE 'myopenid';

DELETE
FROM `engine4_socialconnect_maps`
WHERE `service` LIKE 'aol';

DELETE
FROM `engine4_socialconnect_maps`
WHERE `service` LIKE 'netlog';

DELETE
FROM `engine4_socialconnect_maps`
WHERE `service` LIKE 'xlogon';

DELETE
FROM `engine4_socialconnect_maps`
WHERE `service` LIKE 'onelogin';

DELETE
FROM `engine4_socialconnect_maps`
WHERE `service` LIKE 'steam';

DELETE
FROM `engine4_socialconnect_maps`
WHERE `service` LIKE 'betaid';

DELETE
FROM `engine4_socialconnect_options`
WHERE `service` LIKE 'picasa';

DELETE
FROM `engine4_socialconnect_options`
WHERE `service` LIKE 'youtube';

DELETE
FROM `engine4_socialconnect_options`
WHERE `service` LIKE 'myOpenID';

DELETE
FROM `engine4_socialconnect_options`
WHERE `service` LIKE 'aol';

DELETE
FROM `engine4_socialconnect_options`
WHERE `service` LIKE 'netlog';

DELETE
FROM `engine4_socialconnect_options`
WHERE `service` LIKE 'xlogon';

DELETE
FROM `engine4_socialconnect_options`
WHERE `service` LIKE 'steam';

DELETE
FROM `engine4_socialconnect_options`
WHERE `service` LIKE 'onelogin';

DELETE
FROM `engine4_socialconnect_options`
WHERE `service` LIKE 'betaid';

DELETE FROM `engine4_socialconnect_services` WHERE `engine4_socialconnect_services`.`name` = 'youtube';
DELETE FROM `engine4_socialconnect_services` WHERE `engine4_socialconnect_services`.`name` = 'picasa';
DELETE FROM `engine4_socialconnect_services` WHERE `engine4_socialconnect_services`.`name` = 'myopenid';
DELETE FROM `engine4_socialconnect_services` WHERE `engine4_socialconnect_services`.`name` = 'aol';
DELETE FROM `engine4_socialconnect_services` WHERE `engine4_socialconnect_services`.`name` = 'netlog';
DELETE FROM `engine4_socialconnect_services` WHERE `engine4_socialconnect_services`.`name` = 'xlogon';
DELETE FROM `engine4_socialconnect_services` WHERE `engine4_socialconnect_services`.`name` = 'steam';
DELETE FROM `engine4_socialconnect_services` WHERE `engine4_socialconnect_services`.`name` = 'onelogin';
DELETE FROM `engine4_socialconnect_services` WHERE `engine4_socialconnect_services`.`name` = 'betaid';
DELETE FROM `engine4_socialconnect_services` WHERE `engine4_socialconnect_services`.`name` = 'openminds';

DELETE
FROM `engine4_socialconnect_settings`
WHERE `service` LIKE 'openminds';

DELETE
FROM `engine4_socialconnect_settings`
WHERE `service` LIKE 'picasa';

DELETE
FROM `engine4_socialconnect_settings`
WHERE `service` LIKE 'youtube';

DELETE
FROM `engine4_socialconnect_settings`
WHERE `service` LIKE 'myopenid';

DELETE
FROM `engine4_socialconnect_settings`
WHERE `service` LIKE 'aol';

DELETE
FROM `engine4_socialconnect_settings`
WHERE `service` LIKE 'netlog';

DELETE
FROM `engine4_socialconnect_settings`
WHERE `service` LIKE 'xlogon';

DELETE
FROM `engine4_socialconnect_settings`
WHERE `service` LIKE 'steam';

DELETE
FROM `engine4_socialconnect_settings`
WHERE `service` LIKE 'onelogin';

DELETE
FROM `engine4_socialconnect_settings`
WHERE `service` LIKE 'betaid';

