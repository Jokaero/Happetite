INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'messages' as `type`,
    'editor' as `name`,
    3 as `value`,
    'plaintext' as `params`
  FROM `engine4_authorization_levels` WHERE `type` NOT IN('public');