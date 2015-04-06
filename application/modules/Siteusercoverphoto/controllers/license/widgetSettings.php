<?php

$db = Zend_Db_Table_Abstract::getDefaultAdapter();

$db->query('INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES ("siteusercoverphoto_admin_main_level", "siteusercoverphoto", "Member Level Settings", NULL, \'{"route":"admin_default","module":"siteusercoverphoto","controller":"level"}\', "siteusercoverphoto_admin_main", NULL, "1", "0", "2");');

$coreSettings = Engine_Api::_()->getApi('settings', 'core');
if (!Engine_API::_()->seaocore()->checkSitemobileMode('fullsite-mode')) {
  Engine_Api::_()->siteusercoverphoto()->setDefaultUserProfileWidgets('content', 'pages');
  Engine_Api::_()->siteusercoverphoto()->setDefaultUserProfileWidgets('tabletcontent', 'tabletpages');
}

$contentTable = Engine_Api::_()->getDbtable('content', 'core');
$contentTableName = $contentTable->info('name');
$pageTable = Engine_Api::_()->getDbtable('pages', 'core');
$pageTableName = $pageTable->info('name');
$selectPage = $pageTable->select()
        ->from($pageTableName, array('page_id'))
        ->where('name =?', 'user_profile_index')
        ->limit(1);
$fetchPageId = $selectPage->query()->fetchColumn();

if (!empty($fetchPageId)) {
  $content_main_id = $contentTable->select()
          ->from($contentTableName, array('content_id'))
          ->where('page_id =?', $fetchPageId)
          ->where('name =?', 'main')
          ->query()
          ->fetchColumn();
  if (!empty($content_main_id)) {
    $content_middle_id = $contentTable->select()
            ->from($contentTableName, array('content_id'))
            ->where('page_id =?', $fetchPageId)
            ->where('name =?', 'middle')
            ->where('parent_content_id =?', $content_main_id)
            ->query()
            ->fetchColumn();

    if (!empty($content_middle_id)) {
      $content_id = $contentTable->select()
              ->from($contentTableName, array('content_id'))
              ->where('page_id =?', $fetchPageId)
              ->where('name =?', 'siteusercoverphoto.user-cover-photo')
              ->query()
              ->fetchColumn();
      if (empty($content_id)) {
        $contentCreate = $contentTable->createRow();
        $contentCreate->page_id = $fetchPageId;
        $contentCreate->name = 'siteusercoverphoto.user-cover-photo';
        $contentCreate->type = 'widget';
        $contentCreate->parent_content_id = $content_middle_id;
        $contentCreate->params = '{"title":"","titleCount":"true"}';
        $contentCreate->order = 1;
        $contentCreate->save();
      }
    }
  }
}

$isModEnabled = Engine_Api::_()->getDbtable('modules', 'core')->isModuleEnabled('siteverify');
if(!empty($isModEnabled)) {
  //START UPDATE MEMBER PROFILE COVER PHOTO.
  $select = new Zend_Db_Select($db);
  $select
          ->from('engine4_core_content', array('content_id', 'params'))
          ->where('type =?', 'widget')
          ->where('name =?', 'siteusercoverphoto.user-cover-photo');
  $fetch = $select->query()->fetchAll();
  foreach ($fetch as $modArray) {
      $params = Zend_Json::decode($modArray['params']);
      if(is_array($params)) {
        if(!in_array("verify", $params['memberInfo']))
          $params['showContent'][] = "verify";

        $paramss = Zend_Json::encode($params);
        $tableObject = Engine_Api::_()->getDbtable('content', 'core');
        $tableObject->update(array("params" => $paramss), array("content_id =?" => $modArray['content_id']));          
      }
  }
  //END UPDATE MEMBER PROFILE COVER PHOTO
}