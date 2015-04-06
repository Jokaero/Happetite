<?php

/**
 * SocialEngine
 *
 * @category   Application_Extensions 
 * @package    Seaocore
 * @copyright  Copyright 2009-2010 BigStep Technologies Pvt. Ltd.
 * @license    http://www.socialengineaddons.com/license/
 * @version    $Id: Core.php 2010-11-18 9:40:21Z SocialEngineAddOns $
 * @author     SocialEngineAddOns
 */
class Seaocore_Api_Core extends Core_Api_Abstract {

  protected $_table;

  /**
   *
   * @param $title: String which are require for truncate
   * @return string
   */
  public function seaddonstruncateTitle($title) {
    $tmpBody = strip_tags($title);
    return ( Engine_String::strlen($tmpBody) > 13 ? Engine_String::substr($tmpBody, 0, 15) . '..' : $tmpBody );
  }

  public function getDefault() {
    Engine_Api::_()->getApi('settings', 'core')->getSettings(Zend_Controller_Front::getInstance());
  }

  // return: CDN enabled or not at the site.
  public function isCdn() {
    $storagemodule = Engine_Api::_()->getDbtable('modules', 'core')->getModule('storage');
    $storageversion = $storagemodule->version;

    $db = Engine_Db_Table::getDefaultAdapter();
    // $type_array = $db->query("SHOW COLUMNS FROM engine4_storage_servicetypes LIKE 'enabled'")->fetch();
    $cdn_path = null;

    if ($storageversion >= '4.1.6') {
      $storageServiceTypeTable = Engine_Api::_()->getDbtable('serviceTypes', 'storage');
      $storageServiceTypeTableName = $storageServiceTypeTable->info('name');

      $storageServiceTable = Engine_Api::_()->getDbtable('services', 'storage');
      $storageServiceTableName = $storageServiceTable->info('name');

      $select = $storageServiceTypeTable->select()
              ->setIntegrityCheck(false)
              ->from($storageServiceTypeTableName, array(null))
              ->join($storageServiceTableName, "$storageServiceTypeTableName.servicetype_id = $storageServiceTableName.servicetype_id", array('enabled', 'config', 'default'))
              ->where("$storageServiceTypeTableName.plugin != ?", "Storage_Service_Local")
              ->where("$storageServiceTypeTableName.enabled = ?", 1);

      $storageCheck = $storageServiceTypeTable->fetchRow($select);
      if (!empty($storageCheck)) {
        if ($storageCheck->enabled == 1 && $storageCheck->default == 1) {
          $cdn_path = true;
        }
      }
    }
    return $cdn_path;
  }

  public function setDefaultConstant() {
    // Set Emotions Tag
    $file_path = APPLICATION_PATH . DIRECTORY_SEPARATOR . 'application' . DIRECTORY_SEPARATOR
            . 'modules' . DIRECTORY_SEPARATOR
            . "Seaocore/settings/config/emoticons.php";
    $tags = NULL;
    if (file_exists($file_path)) {
      $tags = include $file_path;
    }
    define('SEA_EMOTIONS_TAG', serialize($tags));

    $showLightboxOptionDisplay = Engine_Api::_()->getApi('settings', 'core')->getSetting('seaocore.lightbox.option.display', array());
    $seaocore_display_lightbox = Engine_Api::_()->getApi('settings', 'core')->getSetting('seaocore.display.lightbox', 1);
    define('SEA_DISPLAY_LIGHTBOX', $seaocore_display_lightbox);
    if (!empty($showLightboxOptionDisplay)) {
      define('SEA_SITEPAGEALBUM_LIGHTBOX', in_array('sitepagealbum', $showLightboxOptionDisplay) || $seaocore_display_lightbox);
      define('SEA_SITEPAGEEVENT_LIGHTBOX', in_array('sitepageevent', $showLightboxOptionDisplay) || $seaocore_display_lightbox);
      define('SEA_SITEBUSINESSEVENT_LIGHTBOX', in_array('sitebusinessevent', $showLightboxOptionDisplay) || $seaocore_display_lightbox);
      define('SEA_SITEBUSINESSALBUM_LIGHTBOX', in_array('sitebusinessalbum', $showLightboxOptionDisplay) || $seaocore_display_lightbox);
      define('SEA_LIST_LIGHTBOX', in_array('list', $showLightboxOptionDisplay) || $seaocore_display_lightbox);
      define('SEA_RECIPE_LIGHTBOX', in_array('recipe', $showLightboxOptionDisplay) || $seaocore_display_lightbox);
      define('SEA_SITEPAGENOTE_LIGHTBOX', in_array('sitepagenote', $showLightboxOptionDisplay) || $seaocore_display_lightbox);
      define('SEA_SITEBUSINESSNOTE_LIGHTBOX', in_array('sitebusinessnote', $showLightboxOptionDisplay) || $seaocore_display_lightbox);
      define('SEA_LIKE_LIGHTBOX', in_array('sitelike', $showLightboxOptionDisplay) || $seaocore_display_lightbox);
      define('SEA_SITEALBUM_LIGHTBOX', in_array('sitealbum', $showLightboxOptionDisplay) || $seaocore_display_lightbox);
      define('SEA_SITEGROUPALBUM_LIGHTBOX', in_array('sitegroupalbum', $showLightboxOptionDisplay) || $seaocore_display_lightbox);
      define('SEA_SITEGROUPEVENT_LIGHTBOX', in_array('sitegroupevent', $showLightboxOptionDisplay) || $seaocore_display_lightbox);
      define('SEA_SITEGROUPNOTE_LIGHTBOX', in_array('sitegroupnote', $showLightboxOptionDisplay) || $seaocore_display_lightbox);
      define('SEA_SITESTOREALBUM_LIGHTBOX', in_array('sitestorealbum', $showLightboxOptionDisplay) || $seaocore_display_lightbox);
      define('SEA_SITESTOREEVENT_LIGHTBOX', in_array('sitestoreevent', $showLightboxOptionDisplay) || $seaocore_display_lightbox);
      define('SEA_SITESTORENOTE_LIGHTBOX', in_array('sitestorenote', $showLightboxOptionDisplay) || $seaocore_display_lightbox);
      define('SEA_SITEEVENT_LIGHTBOX', in_array('siteevent', $showLightboxOptionDisplay) || $seaocore_display_lightbox);
//      define('SEA_SITEREVIEW_LIGHTBOX', in_array('sitereview', $showLightboxOptionDisplay) || $seaocore_display_lightbox);
    } else {
      define('SEA_SITEPAGEALBUM_LIGHTBOX', $seaocore_display_lightbox);
      define('SEA_SITEBUSINESSALBUM_LIGHTBOX', $seaocore_display_lightbox);
      define('SEA_SITEPAGEEVENT_LIGHTBOX', $seaocore_display_lightbox);
      define('SEA_SITEBUSINESSEVENT_LIGHTBOX', $seaocore_display_lightbox);
      define('SEA_LIST_LIGHTBOX', $seaocore_display_lightbox);
      define('SEA_RECIPE_LIGHTBOX', $seaocore_display_lightbox);
      define('SEA_SITEPAGENOTE_LIGHTBOX', $seaocore_display_lightbox);
      define('SEA_SITEBUSINESSNOTE_LIGHTBOX', $seaocore_display_lightbox);
      define('SEA_LIKE_LIGHTBOX', $seaocore_display_lightbox);
      define('SEA_SITEALBUM_LIGHTBOX', $seaocore_display_lightbox);
      define('SEA_SITEGROUPALBUM_LIGHTBOX', $seaocore_display_lightbox);
      define('SEA_SITEGROUPEVENT_LIGHTBOX', $seaocore_display_lightbox);
      define('SEA_SITEGROUPNOTE_LIGHTBOX', $seaocore_display_lightbox);
      define('SEA_SITESTOREALBUM_LIGHTBOX', $seaocore_display_lightbox);
      define('SEA_SITESTOREEVENT_LIGHTBOX', $seaocore_display_lightbox);
      define('SEA_SITEEVENT_LIGHTBOX', $seaocore_display_lightbox);
      define('SEA_SITESTORENOTE_LIGHTBOX', $seaocore_display_lightbox);
//      define('SEA_SITEREVIEW_LIGHTBOX', $seaocore_display_lightbox);
    }

    define('SITEALBUM_ENABLED', Engine_Api::_()->getDbtable('modules', 'core')->isModuleEnabled('sitealbum'));
    define('SITEACTIVITY_ENABLED', Engine_Api::_()->getDbtable('modules', 'core')->isModuleEnabled('advancedactivity'));

    if ($seaocore_display_lightbox) {
      if ((SITEALBUM_ENABLED || SITEACTIVITY_ENABLED)) {
        define('SEA_ACTIVITYFEED_LIGHTBOX', $seaocore_display_lightbox);
      } else {
        define('SEA_ACTIVITYFEED_LIGHTBOX', 0);
      }
    } else {
      if ((SITEALBUM_ENABLED || SITEACTIVITY_ENABLED)) {
        if (!empty($showLightboxOptionDisplay)) {
          define('SEA_ACTIVITYFEED_LIGHTBOX', in_array('activity', $showLightboxOptionDisplay));
        } else {
          define('SEA_ACTIVITYFEED_LIGHTBOX', 0);
        }
      } else {
        define('SEA_ACTIVITYFEED_LIGHTBOX', 0);
      }
    }

    if (SITEALBUM_ENABLED) {
      if (!empty($showLightboxOptionDisplay)) {
        define("SEA_GROUP_LIGHTBOX", in_array("group", $showLightboxOptionDisplay));
        define("SEA_EVENT_LIGHTBOX", in_array("event", $showLightboxOptionDisplay));
        define("SEA_YNEVENT_LIGHTBOX", in_array("ynevent", $showLightboxOptionDisplay));
        define("SEA_ADVGROUP_LIGHTBOX", in_array("advgroup", $showLightboxOptionDisplay));
      } else {
        define("SEA_GROUP_LIGHTBOX", 0);
        define("SEA_EVENT_LIGHTBOX", 0);
        define("SEA_YNEVENT_LIGHTBOX", 0);
        define("SEA_ADVGROUP_LIGHTBOX", 0);
      }
    }

    $enableSubModules = array();
    $includeModules = array("sitepagealbum" => "Directory / Pages - Photo Albums Extension", "sitepagenote" => "Directory / Pages - Notes Extension", "sitepageevent" => "Directory / Pages - Events Extension", "list" => "Listing", "recipe" => "Recipe", "sitelike" => "Likes Plugin and Widgets", "sitealbum" => "Advanced Photo Albums", "sitebusinessalbum" => "Directory / Businesses - Photo Albums Extension", "sitebusinessnote" => "Directory / Businesses - Notes Extension", "sitebusinessevent" => "Directory / Businesses - Events Extension", 'sitereview' => 'Review Plugin', "sitegroupalbum" => "Groups / Communities - Photo Albums Extension", "sitegroupnote" => "Directory / Groups - Notes Extension ", "sitegroupevent" => "Directory / Groups - Events Extension ", "sitestorealbum" => "Stores / Communities - Photo Albums Extension", "sitestorenote" => "Directory /
Stores - Notes Extension ", "sitestoreevent" => "Directory / Stores - Events Extension ", "siteevent" => 'SEAO - Advanced Events ', "advancedactivity" => "SEAO - Advanced Activity Feeds ");

    $enableAllModules = Engine_Api::_()->getDbtable('modules', 'core')->getEnabledModuleNames();
    $enableModules = array_intersect(array_keys($includeModules), $enableAllModules);
    if (!empty($enableModules)) {
      define('SEA_PHOTOLIGHTBOX_DOWNLOAD', Engine_Api::_()->getApi('settings', 'core')->getSetting('seaocore.photo.download', 1));
      define('SEA_PHOTOLIGHTBOX_REPORT', Engine_Api::_()->getApi('settings', 'core')->getSetting('seaocore.photo.report', 1));
      define('SEA_PHOTOLIGHTBOX_MAKEPROFILEPHOTO', Engine_Api::_()->getApi('settings', 'core')->getSetting('seaocore.photo.makeprofile', 1));
      define('SEA_PHOTOLIGHTBOX_SHARE', Engine_Api::_()->getApi('settings', 'core')->getSetting('seaocore.photo.share', 1));
      define('SEA_PHOTOLIGHTBOX_EDITLOCATION', Engine_Api::_()->getApi('settings', 'core')->getSetting('seaocore.photo.editlocation', 1));
      define('SEA_PHOTOLIGHTBOX_GETLINK', Engine_Api::_()->getApi('settings', 'core')->getSetting('seaocore.photo.getlink', 1));
      define('SEA_PHOTOLIGHTBOX_SENDMAIL', Engine_Api::_()->getApi('settings', 'core')->getSetting('seaocore.photo.sendmail', 1));
      define('SEA_PHOTOLIGHTBOX_MAKEALBUMCOVER', Engine_Api::_()->getApi('settings', 'core')->getSetting('seaocore.photo.makealbumcover', 1));
      define('SEA_PHOTOLIGHTBOX_MOVETOOTHERALBUM', Engine_Api::_()->getApi('settings', 'core')->getSetting('seaocore.photo.movetootheralbum', 1));
    } else {
      define('SEA_PHOTOLIGHTBOX_DOWNLOAD', 0);
      define('SEA_PHOTOLIGHTBOX_REPORT', 0);
      define('SEA_PHOTOLIGHTBOX_MAKEPROFILEPHOTO', 0);
      define('SEA_PHOTOLIGHTBOX_SHARE', 0);
      define('SEA_PHOTOLIGHTBOX_GETLINK', 0);
      define('SEA_PHOTOLIGHTBOX_SENDMAIL', 0);
      define('SEA_PHOTOLIGHTBOX_MAKEALBUMCOVER', 0);
      define('SEA_PHOTOLIGHTBOX_MOVETOOTHERALBUM', 0);
      define('SEA_PHOTOLIGHTBOX_EDITLOCATION', 0);
    }
  }

  /**
   * Returns array of "Mutual Friend" between "$friend_id" and "viewer_id".
   *
   * @param $friend_id: Find out mutual friend between "Pass friend id" and "Loggden user id".
   * @return Array.
   */
  public function getMutualFriend($friend_id, $LIMIT = null) {

    $mutualFriendArray = array();

    //GET THE VIEWER ID.
    $viewer_id = Engine_Api::_()->user()->getViewer()->getIdentity();

    $memberTable = Engine_Api::_()->getDbtable('membership', 'user');
    $memberTableName = $memberTable->info('name');

    $select = $memberTable->select()
            ->setIntegrityCheck(false)
            ->from($memberTableName, array('user_id', 'resource_id'))
            ->join($memberTableName, "`{$memberTableName}`.`user_id`=`{$memberTableName}_2`.user_id", null)
            ->where("`{$memberTableName}`.resource_id = ?", $friend_id) // FRIEND ID.
            ->where("`{$memberTableName}_2`.resource_id = ?", $viewer_id) // VIEWER ID.
            ->where("`{$memberTableName}`.active = ?", 1)
            ->where("`{$memberTableName}_2`.active = ?", 1);
    if (!empty($LIMIT)) {
      $select->limit($LIMIT);
    }
    return Zend_Paginator::factory($select);
//     if (!empty($fetch_mutual_friend)) {
//       foreach ($fetch_mutual_friend as $mutual_friend_id) {
//         $mutualFriendArray[] = $mutual_friend_id['user_id'];
//       }
//     }
  }

  public function getCategory($resource_type, $resource) {


    // RETURN CATEGORY FOR MAGENTO PLUGIN.
    if (strstr($resource_type, 'siteestore')) {
      if (Engine_Api::_()->getDbtable('modules', 'core')->isModuleEnabled('siteestore')) {
        $categorysArray = $resource->category;
        $categorysArray = @unserialize($categorysArray);
        if (!empty($categorysArray) && !empty($categorysArray[0])) {
          $category = $categorysArray[0];
          return $category;
        }
      }
    }

    //Start Work for faq plugin.
    if ($resource_type == 'sitefaq_faq' && !empty($resource['category_id'])) {
      $first_category_id_array = explode('["', $resource['category_id']);
      $first_category_id_array = explode('"', $first_category_id_array[1]);
      $resource['category_id'] = $first_category_id_array[0];
    }
    //End Work for faq plugin.

    if (empty($resource['category_id'])) {
      return;
    }

    switch ($resource_type) {
      case 'event':
        if (!Engine_Api::_()->getDbtable('modules', 'core')->isModuleEnabled('event')) {
          $Table = Engine_Api::_()->getItemTable('ynevent_category');
        } else {
          $Table = Engine_Api::_()->getDbtable('categories', $resource_type);
        }
        $title = 'title';
        break;
      case 'group':
        if (!Engine_Api::_()->getDbtable('modules', 'core')->isModuleEnabled('group')) {
          $Table = Engine_Api::_()->getDbtable('categories', 'advgroup');
        } else {
          $Table = Engine_Api::_()->getDbtable('categories', $resource_type);
        }
        $title = 'title';
        break;
      case 'forum':
        if (!Engine_Api::_()->getDbtable('modules', 'core')->isModuleEnabled('forum')) {
          $Table = Engine_Api::_()->getItemTable('ynforum_category');
        } else {
          $Table = Engine_Api::_()->getDbtable('categories', $resource_type);
        }
        $title = 'title';
        break;
      case 'video':
        if (!Engine_Api::_()->getDbtable('modules', 'core')->isModuleEnabled('video')) {
          $Table = Engine_Api::_()->getItemTable('video_category');
        } else {
          $Table = Engine_Api::_()->getDbtable('categories', $resource_type);
        }
        $title = 'category_name';
        break;
      case 'classified':
      case 'recipe':
      case 'document':
        $Table = Engine_Api::_()->getDbtable('categories', $resource_type);
        $title = 'category_name';
        break;
      case 'album':
      case 'blog':
        $Table = Engine_Api::_()->getItemTable($resource_type . '_category');
        $title = 'category_name';
        break;
      case 'list_listing':
        $Table = Engine_Api::_()->getDbtable('categories', 'list');
        $title = 'category_name';
        break;
      case 'sitepage_page':
        $Table = Engine_Api::_()->getDbtable('categories', 'sitepage');
        $title = 'category_name';
        break;
      case 'sitegroup_group':
        $Table = Engine_Api::_()->getDbtable('categories', 'sitegroup');
        $title = 'category_name';
        break;
      case 'sitestore_store':
        $Table = Engine_Api::_()->getDbtable('categories', 'sitestore');
        $title = 'category_name';
        break;
      case 'sitebusiness_business':
        $Table = Engine_Api::_()->getDbtable('categories', 'sitebusiness');
        $title = 'category_name';
        break;
      case 'sitefaq_faq':
        $Table = Engine_Api::_()->getDbtable('categories', 'sitefaq');
        $title = 'category_name';
        break;
      case 'sitestoreproduct_product':
        $Table = Engine_Api::_()->getDbtable('categories', 'sitestoreproduct');
        $title = 'category_name';
        break;
      case 'siteevent_event':
        $Table = Engine_Api::_()->getDbtable('categories', 'siteevent');
        $title = 'category_name';
        break;
      case 'sitereview_listing':
        $Table = Engine_Api::_()->getDbtable('categories', 'sitereview');
        $title = 'category_name';
        break;
      default:
        return;
    }
    return $Table->select()->from($Table, new Zend_Db_Expr($title))
                    ->where('category_id = ?', $resource['category_id'])->limit(1)->query()->fetchColumn();
  }

  /**
   * Gets a url slug for string
   *
   * @return string The slug
   */
  public function getSlug($str, $limit = 64) {

    if (strlen($str) > $limit) {
      $str = Engine_String::substr($str, 0, $limit) . '...';
    }

    $slugString = $str;

    //CASE 1:
    $search  = array('À','Á','Â','Ã','Ä','Å','Æ','Ç','È','É','Ê','Ë','Ì','Í','Î','Ï','Ð','Ñ','Ò','Ó','Ô','Õ','Ö','Ø','Ù','Ú','Û','Ü','Ý','ß','à','á','â','ã','ä','å','æ','ç','è','é','ê','ë','ì','í','î','ï','ñ','ò','ó','ô','õ','ö','ø','ù','ú','û','ü','ý','ÿ','Ā','ā','Ă','ă','Ą','ą','Ć','ć','Ĉ','ĉ','Ċ','ċ','Č','č','Ď','ď','Đ','đ','Ē','ē','Ĕ','ĕ','Ė','ė','Ę','ę','Ě','ě','Ĝ','ĝ','Ğ','ğ','Ġ','ġ','Ģ','ģ','Ĥ','ĥ','Ħ','ħ','Ĩ','ĩ','Ī','ī','Ĭ','ĭ','Į','į','İ','ı','Ĳ','ĳ','Ĵ','ĵ','Ķ','ķ','Ĺ','ĺ','Ļ','ļ','Ľ','ľ','Ŀ','ŀ','Ł','ł','Ń','ń','Ņ','ņ','Ň','ň','ŉ','Ō','ō','Ŏ','ŏ','Ő','ő','Œ','œ','Ŕ','ŕ','Ŗ','ŗ','Ř','ř','Ś','ś','Ŝ','ŝ','Ş','ş','Š','š','Ţ','ţ','Ť','ť','Ŧ','ŧ','Ũ','ũ','Ū','ū','Ŭ','ŭ','Ů','ů','Ű','ű','Ų','ų','Ŵ','ŵ','Ŷ','ŷ','Ÿ','Ź','ź','Ż','ż','Ž','ž','ſ','ƒ','Ơ','ơ','Ư','ư','Ǎ','ǎ','Ǐ','ǐ','Ǒ','ǒ','Ǔ','ǔ','Ǖ','ǖ','Ǘ','ǘ','Ǚ','ǚ','Ǜ','ǜ','Ǻ','ǻ','Ǽ','ǽ','Ǿ','ǿ');
    $replace = array('A','A','A','A','A','A','AE','C','E','E','E','E','I','I','I','I','D','N','O','O','O','O','O','O','U','U','U','U','Y','s','a','a','a','a','a','a','ae','c','e','e','e','e','i','i','i','i','n','o','o','o','o','o','o','u','u','u','u','y','y','A','a','A','a','A','a','C','c','C','c','C','c','C','c','D','d','D','d','E','e','E','e','E','e','E','e','E','e','G','g','G','g','G','g','G','g','H','h','H','h','I','i','I','i','I','i','I','i','I','i','IJ','ij','J','j','K','k','L','l','L','l','L','l','L','l','l','l','N','n','N','n','N','n','n','O','o','O','o','O','o','OE','oe','R','r','R','r','R','r','S','s','S','s','S','s','S','s','T','t','T','t','T','t','U','u','U','u','U','u','U','u','U','u','U','u','W','w','Y','y','Y','Z','z','Z','z','Z','z','s','f','O','o','U','u','A','a','I','i','O','o','U','u','U','u','U','u','U','u','U','u','A','a','AE','ae','O','o');
    $str = str_replace($search, $replace, $str);
    
    $str = preg_replace('/([a-z])([A-Z])/', '$1 $2', $str);
    $str = strtolower($str);
    $str = preg_replace('/[^a-z0-9-]+/i', '-', $str);
    $str = preg_replace('/-+/', '-', $str);
    $str = trim($str, '-');

    //CASE 2:
    if (empty($str) || $str == '-') {
      setlocale(LC_CTYPE, 'pl_PL.utf8');
      $str = @iconv('UTF-8', 'ASCII//TRANSLIT', $slugString);
      $str = strtolower($str);
      $str = strtr($str, array('&' => '-', '"' => '-', '&' . '#039;' => '-', '<' => '-', '>' => '-', '\'' => '-'));
      $str = preg_replace('/^[^a-z0-9]{0,}(.*?)[^a-z0-9]{0,}$/si', '\\1', $str);
      $str = preg_replace('/[^a-z0-9\-]/', '-', $str);
      $str = preg_replace('/[\-]{2,}/', '-', $str);

      //CASE 3:
      if (empty($str) || $str == '-') {

        $cyrillicArray = array(
            "Є" => "YE", "І" => "I", "Ї" => "YI", "Ѓ" => "G", "і" => "i", "№" => "#", "є" => "ye", "ѓ" => "g",
            "А" => "A", "Б" => "B", "В" => "V", "Г" => "G", "Д" => "D",
            "Е" => "E", "Ё" => "YO", "Ж" => "ZH",
            "З" => "Z", "И" => "I", "Й" => "J", "К" => "K", "Л" => "L",
            "М" => "M", "Н" => "N", "О" => "O", "П" => "P", "Р" => "R",
            "С" => "S", "Т" => "T", "У" => "U", "Ф" => "F", "Х" => "X",
            "Ц" => "C", "Ч" => "CH", "Ш" => "SH", "Щ" => "SHH", "Ъ" => "'",
            "Ы" => "Y", "Ь" => "", "Э" => "E", "Ю" => "YU", "Я" => "YA",
            "а" => "a", "б" => "b", "в" => "v", "г" => "g", "д" => "d",
            "е" => "e", "ё" => "yo", "ж" => "zh",
            "з" => "z", "и" => "i", "ї" => "yi", "й" => "j", "к" => "k", "л" => "l",
            "м" => "m", "н" => "n", "о" => "o", "п" => "p", "р" => "r",
            "с" => "s", "т" => "t", "у" => "u", "ф" => "f", "х" => "x",
            "ц" => "c", "ч" => "ch", "ш" => "sh", "щ" => "shh", "ъ" => "",
            "ы" => "y", "ь" => "", "э" => "e", "ю" => "yu", "я" => "ya", "«" => "", "»" => "", "—" => "-"
        );

        $str = strtr($slugString, $cyrillicArray);
        $str = preg_replace('/\W+/', '-', $str);
        $str = strtolower(trim($str, '-'));
      }
    }

    if (!$str) {
      $str = '-';
    }

    return $str;
  }

  /**
   * Returns true / false if "Friend Id" is the friend of "Loggden User"
   *
   * @param $friend_id: Friend Id,
   * @return true or false
   */
  public function isMember($friend_id) {

    //GET THE VIEWER ID.
    $viewer_id = Engine_Api::_()->user()->getViewer()->getIdentity();
    $isFriend = false;

    //FETCH FRIEND ID FROM DATABASE.
    $memberTable = Engine_Api::_()->getDbtable('membership', 'user');
    $memberTableName = $memberTable->info('name');

    $select = $memberTable->select()
            ->where($memberTableName . '.active = ?', 1)
            ->where($memberTableName . '.resource_id = ?', $friend_id)
            ->where($memberTableName . '.user_id = ?', $viewer_id);

    $fetch = $select->query()->fetchAll();
    if (!empty($fetch)) {
      $isFriend = true;
    }
    return $isFriend;
  }

  public function canSendUserMessage($subject) {
    // Not logged in
    $viewer = Engine_Api::_()->user()->getViewer();
    if (!$viewer->getIdentity() || $viewer->getGuid(false) === $subject->getGuid(false)) {
      return false;
    }
    // Get setting?
    $permission = Engine_Api::_()->authorization()->getPermission($viewer->level_id, 'messages', 'create');
    if (Authorization_Api_Core::LEVEL_DISALLOW === $permission) {
      return false;
    }
    $messageAuth = Engine_Api::_()->authorization()->getPermission($viewer->level_id, 'messages', 'auth');
    if ($messageAuth == 'none') {
      return false;
    } else if ($messageAuth == 'friends') {
      // Get data
      $direction = (int) Engine_Api::_()->getApi('settings', 'core')->getSetting('user.friends.direction', 1);
      if (!$direction) {
        //one way
        $friendship_status = $viewer->membership()->getRow($subject);
      } else {
        $friendship_status = $subject->membership()->getRow($viewer);
      }

      if (!$friendship_status || $friendship_status->active == 0) {
        return false;
      }
    }
    return true;
  }

  public function baseOnContentOwner(User_Model_User $viewer, Core_Model_Item_Abstract $item) {

    $settingsCoreApi = Engine_Api::_()->getApi('settings', 'core');
    if ($item->getType() == 'sitepage_page') {
      $advancedactivityEnable = Engine_Api::_()->getDbtable('modules', 'core')->isModuleEnabled('advancedactivity');
      if ($advancedactivityEnable && $settingsCoreApi->sitepage_feed_type && $item->isOwner($viewer)) {
        return true;
      }
    } elseif ($item->getType() == 'sitebusiness_business') {
      $advancedactivityEnable = Engine_Api::_()->getDbtable('modules', 'core')->isModuleEnabled('advancedactivity');
      if ($advancedactivityEnable && $settingsCoreApi->sitebusiness_feed_type && $item->isOwner($viewer)) {
        return true;
      }
    } elseif ($item->getType() == 'sitegroup_group') {
      $advancedactivityEnable = Engine_Api::_()->getDbtable('modules', 'core')->isModuleEnabled('advancedactivity');
      if ($advancedactivityEnable && $settingsCoreApi->sitegroup_feed_type && $item->isOwner($viewer)) {
        return true;
      }
    } elseif ($item->getType() == 'sitestore_store') {
      $advancedactivityEnable = Engine_Api::_()->getDbtable('modules', 'core')->isModuleEnabled('advancedactivity');
      if ($advancedactivityEnable && $settingsCoreApi->sitestore_feed_type && $item->isOwner($viewer)) {
        return true;
      }
    } elseif ($item->getType() == 'siteevent_event') {
      $advancedactivityEnable = Engine_Api::_()->getDbtable('modules', 'core')->isModuleEnabled('advancedactivity');
      $settingsCoreApi = Engine_Api::_()->getApi('settings', 'core');
      $parent = $item->getParent();
      $name = 'siteevent_event_leader_owner_' . $parent->getType();
      if ($advancedactivityEnable && $settingsCoreApi->$name && $parent->isOwner($viewer))
        return true;
    }
    return false;
  }

  public function isLessThan420ActivityModule() {
    $activityModule = Engine_Api::_()->getDbtable('modules', 'core')->getModule('activity');
    $activityModuleVersion = $activityModule->version;
    if ($activityModuleVersion < '4.1.8') {
      return true;
    } else {
      return false;
    }
  }

  /**
   * Added Widget On Page
   *
   * @return bool
   */
  public function hasAddedWidgetOnPage($pageName, $widgetName, $params = array()) {
    $isCoreActivtyFeedWidget = false;

    $pagesTable = Engine_Api::_()->getDbtable('pages', 'core');
    $pagesTableName = $pagesTable->info('name');
    $contentsTable = Engine_Api::_()->getDbtable('content', 'core');
    $contentsTableName = $contentsTable->info('name');

    $select = $contentsTable->select()
            ->setIntegrityCheck(false)
            ->from($contentsTableName, array($contentsTableName . '.name'))
            ->join($pagesTableName, "`{$pagesTableName}`.page_id = `{$contentsTableName}`.page_id  ", null)
            ->where($pagesTableName . '.name = ?', $pageName)
            ->where($contentsTableName . '.name = ?', $widgetName);
    $row = $contentsTable->fetchRow($select);
    if (!empty($row))
      $isCoreActivtyFeedWidget = true;
    return $isCoreActivtyFeedWidget;
  }

  /**
   * Get Truncation String
   *
   * @param string $text
   * @param int $limit
   * @return truncate string
   */
  public function seaocoreTruncateText($string, $limit) {


    //IF LIMIT IS EMPTY
    if (empty($limit)) {
      $limit = 16;
    }

    //RETURN TRUNCATED STRING
    $string = strip_tags($string);
    return ( Engine_String::strlen($string) > $limit ? Engine_String::substr($string, 0, ($limit - 3)) . '...' : $string );
  }

  public function canShowSuggestFriendLink($module_name) {
    $flage = false;
    $viewer_id = Engine_Api::_()->user()->getViewer()->getIdentity();

    $sitevideo_view_type = Engine_Api::_()->getApi('settings', 'core')->getSetting('sitevideoview.view.type', null);
    $sitevideo_core_str = Engine_Api::_()->getApi('settings', 'core')->getSetting('sitevideoview.core.str', null);
    if (!empty($sitevideo_view_type) && ($sitevideo_view_type != $sitevideo_core_str)) {
      Engine_Api::_()->getApi('settings', 'core')->setSetting('sitevideoview.view.queue', 0);
    }

    if (!empty($viewer_id) && Engine_Api::_()->getDbtable('modules', 'core')->isModuleEnabled('suggestion')) {

      if (in_array($module_name, array('sitepagevideo', 'sitebusinessvideo', 'sitegroupvideo', 'sitestorevideo'))) {
        if ($module_name == 'sitepagevideo') {
          $module_name = 'sitepage';
          $link = 'video_sugg_link';
        } elseif ($module_name == 'sitebusinessvideo') {
          $module_name = 'sitebusiness';
          $link = 'video_sugg_link';
        } elseif ($module_name == 'sitegroupvideo') {
          $module_name = 'sitegroup';
          $link = 'video_sugg_link';
        } elseif ($module_name == 'sitestorevideo') {
          $module_name = 'sitestore';
          $link = 'video_sugg_link';
        }
        $getModObj = Engine_Api::_()->suggestion()->getModSettings($module_name, $link);
        if (!empty($getModObj))
          $flage = true;
      } else {
        $getModObj = Engine_Api::_()->getDbtable('modinfos', 'suggestion')->getMod($module_name);
        $getModObj = !empty($getModObj) ? $getModObj[0] : null;
        if (!empty($getModObj) && !empty($getModObj['enabled'])) {
          $flage = true;
        }
      }
    }

    return $flage;
  }

  /**
   * Return Profile Map Bounds Params
   *
   * @param array $checkinMarkers
   */
  public function getProfileMapBounds($checkinMarkers) {
    $minLatitude = 200;
    $maxLatitude = -200;
    $minLongitude = 200;
    $maxLongitude = -200;

    if (count($checkinMarkers) == 0) {
      return array();
    } elseif (count($checkinMarkers) == 1) {
      $checkinMarker = $checkinMarkers[0];
      $minLatitude = $maxLatitude = $checkinMarker['latitude'];
      $minLongitude = $maxLongitude = $checkinMarker['longitude'];
    } else {
      foreach ($checkinMarkers as $checkinMarker) {
        if (empty($checkinMarker['longitude']) || empty($checkinMarker['latitude']))
          continue;

        if ($checkinMarker['longitude'] <= $minLongitude) {
          $minLongitude = $checkinMarker['longitude'];
        }

        if ($checkinMarker['longitude'] >= $maxLongitude) {
          $maxLongitude = $checkinMarker['longitude'];
        }

        if ($checkinMarker['latitude'] <= $minLatitude) {
          $minLatitude = $checkinMarker['latitude'];
        }

        if ($checkinMarker['latitude'] >= $maxLatitude) {
          $maxLatitude = $checkinMarker['latitude'];
        }
      }
    }

    if ($minLatitude == $maxLatitude && $minLongitude == $maxLongitude) {
      $minLatitude -= 0.0009;
      $maxLatitude += 0.0009;
      $minLongitude -= 0.0009;
      $maxLongitude += 0.0009;
    }

    $centerLat = (float) ($minLatitude + $maxLatitude) / 2;
    $centerLng = (float) ($minLongitude + $maxLongitude) / 2;

    return array(
        'min_lat' => $minLatitude,
        'max_lat' => $maxLatitude,
        'min_lng' => $minLongitude,
        'max_lng' => $maxLongitude,
        'center_lat' => $centerLat,
        'center_lng' => $centerLng
    );
  }

  public function isMobile() {
    $mobileEnable = false;
    $request = Zend_Controller_Front::getInstance()->getRequest();
    // Code for Mobile Compatibilty Plugins. We are not excuting the our plugin code in case of mode='mobile' or mode === 'touch'.
    $session = new Zend_Session_Namespace('standard-mobile-mode');
    if (array_key_exists('HTTP_USER_AGENT', $_SERVER)) {
      // Reference from "Detect mobile browser (smartphone)" and URL : http://www.serveradminblog.com/2011/01/detect-mobile-browser-smartphone/
      $useragent = strtolower($_SERVER['HTTP_USER_AGENT']);
      if
      (
              preg_match('/imageuploader|android|blackberry|compal|fennec|hiptop|iemobile/i', $useragent) ||
              preg_match('/ip(hone|od|ad)|kindle|lge|maemo|midp|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\//i', $useragent) ||
              preg_match('/pocket|psp|symbian|treo|up\.(browser|link)|vodafone|windows (ce|phone)|xda/i', $useragent)
      )
        $mobileEnable = true;
      if (preg_match('/imageuploader|android|avantgo|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i', $useragent) || preg_match('/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|e\-|e\/|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(di|rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|xda(\-|2|g)|yas\-|your|zeto|zte\-/i', substr($useragent, 0, 4)))
        $mobileEnable = true;
    }
    $mobile = false;
    if (!$mobileEnable && Engine_Api::_()->getDbtable('modules', 'core')->isModuleEnabled('mobi')) {
      $mobile = $request->getParam("mobile");
      $session = new Zend_Session_Namespace('mobile');

      if ($mobile == "1") {
        $mobileEnable = true;
        $session->mobile = true;
      } elseif ($mobile == "0") {
        $mobileEnable = false;
        $session->mobile = false;
      } else {
        if (isset($session->mobile)) {
          $mobileEnable = (bool) $session->mobile;
        } else {
          // CHECK TO SEE IF MOBILE
          if (Engine_Api::_()->mobi()->isMobile()) {
            $mobileEnable = true;
            $session->mobile = true;
          } else {
            $mobileEnable = false;
            $session->mobile = false;
          }
        }
      }
    }
    return $mobileEnable;
  }

  /**
   * Get the tags list in autosuggest(autosuggest list will have only the tags of resource_type)
   *
   * @param string $text
   * @param int $limit
   */
  public function getTagsByText($text = null, $limit = 10, $resourceType = '') {
    //GET TAG TABLE
    $tableTags = Engine_Api::_()->getDbtable('tags', 'core')->getTagTable();
    $tableTagsName = $tableTags->info('name');

    //GET TAG MAP TABLE
    $tableTagMaps = Engine_Api::_()->getDbtable('TagMaps', 'core');
    $tableTagMapsName = $tableTagMaps->info('name');

    //MAKE QUERY
    $select = $tableTags->select()
            ->setIntegrityCheck(false)
            ->from($tableTagsName)
            ->join($tableTagMapsName, "$tableTagsName.tag_id = $tableTagMapsName.tag_id", null);

    if (!empty($resourceType)) {
      $select->where("$tableTagMapsName.resource_type = ?", "$resourceType");
    }

    if ($text) {
      $select->where('text LIKE ?', '%' . $text . '%');
    }

    $select->order('text ASC')
            ->group("$tableTagsName.tag_id")
            ->limit($limit);

    return $tableTags->fetchAll($select);
  }

  /**
   * Return GOOGLE MAP API KEY
   */
  public function getGoogleMapApiKey() {

    //GET API KEY
    return Engine_Api::_()->getApi('settings', 'core')->getSetting('seaocore.google.map.key', '');
  }

  /**
   * Return $location 
   *
   * @param $subject
   */
  public function getCustomFieldLocation($subject) {
    $resource_type = $subject->getType();
    $location = "";
    //SET CUSTOM FILLED ARRAY
    $customFilledLocationArray = array("classified", "list_listing", "recipe");
    //GET LOCATION FOR CUSTOM FILLED
    if (in_array($resource_type, $customFilledLocationArray)) {

      //GET RESOURCE TABLE
      $resourceTable = Engine_Api::_()->getItemTable($resource_type);

      //GET RESOURCE TABLE NAME
      $resourceTableName = $resourceTable->info('name');

      //GET PRIMARY KEY NAME
      $primary = current($resourceTable->info("primary"));

      //GET FIELD VALUE TABLE
      $valueTable = Engine_Api::_()->fields()->getTable($resource_type, 'values');

      //GET FIELD VALUE TABLE NAME
      $valueTableName = $valueTable->info('name');

      //GET FIELD META TABLE NAME
      $metaName = Engine_Api::_()->fields()->getTable($resource_type, 'meta')->info('name');

      //GET LOCATION
      $location = $valueTable->select()
              ->setIntegrityCheck(false)
              ->from($valueTableName, array('value'))
              ->join($metaName, $metaName . '.field_id = ' . $valueTableName . '.field_id', null)
              ->join($resourceTableName, $resourceTableName . '.' . $primary . '=' . $valueTableName . '.item_id', null)
              ->where($valueTableName . '.item_id = ?', $subject->getIdentity())
              ->where($metaName . '.type = ?', 'Location')
              ->order($metaName . '.field_id')
              ->query()
              ->fetchColumn();
    }

    //GET LOCATION FOR NOT CUSTOM FILED
    if (isset($subject->location) && !empty($subject->location)) {
      $location = $subject->location;
    }
    return $location;
  }

  /*   * public function hasLike($RESOURCE_ID, $viewer_id) {
    if (empty($RESOURCE_ID) || empty($viewer_id))
    return false;

    $sub_status_table = Engine_Api::_()->getItemTable('core_like');

    $sub_status_select = $sub_status_table->select()
    ->where('resource_type = ?', 'sitepage_page')
    ->where('resource_id = ?', $RESOURCE_ID)
    ->where('poster_id = ?', $viewer_id);
    $fetch_sub = $sub_status_table->fetchRow($sub_status_select);
    if (!empty($fetch_sub))
    return true;
    else
    return false;
    } */

  /**
   * check the item is like or not.
   *
   * @param Stirng $RESOURCE_TYPE
   * @param Int $RESOURCE_ID
   * @return results
   */
  public function checkAvailability($RESOURCE_TYPE, $RESOURCE_ID) {

    //GET THE VIEWER.
    $viewer = Engine_Api::_()->user()->getViewer();
    $likeTable = Engine_Api::_()->getItemTable('core_like');
    $likeTableName = $likeTable->info('name');
    $sub_status_select = $likeTable->select()
            ->from($likeTableName, array('like_id'))
            ->where('resource_type = ?', $RESOURCE_TYPE)
            ->where('resource_id = ?', $RESOURCE_ID)
            ->where('poster_type =?', $viewer->getType())
            ->where('poster_id =?', $viewer->getIdentity())
            ->limit(1);
    return $sub_status_select->query()->fetchAll();
  }

  /**
   * Get member online
   *
   * @param int $user_id
   * @return int $flag;
   */
  public function isOnline($user_id) {

    // Get online users
    $table = Engine_Api::_()->getItemTable('user');
    $onlineTable = Engine_Api::_()->getDbtable('online', 'user');

    $tableName = $table->info('name');
    $onlineTableName = $onlineTable->info('name');

    $select = $table->select()
            //->from($onlineTableName, null)
            //->joinLeft($tableName, $onlineTable.'.user_id = '.$tableName.'.user_id', null)
            ->from($tableName)
            ->joinRight($onlineTableName, $onlineTableName . '.user_id = ' . $tableName . '.user_id', null)
            //->where($onlineTableName.'.user_id > ?', 0)
            ->where($onlineTableName . '.user_id = ?', $user_id)
            //->where($onlineTableName.'.active > ?', new Zend_Db_Expr('DATE_SUB(NOW(),INTERVAL 20 MINUTE)'))
            ->where($tableName . '.search = ?', 1)
            ->where($tableName . '.enabled = ?', 1)
            ->order($onlineTableName . '.active DESC')
            ->group($onlineTableName . '.user_id');
    $row = $table->fetchRow($select);

    $flag = false;
    if (!empty($row)) {
      $flag = true;
    }
    return $flag;
  }

  public function getCurrentVersion($maxVersion, $name) {

    $moduleTable = Engine_Api::_()->getDbtable('modules', 'core');
    $version = $moduleTable->select()
            ->from($moduleTable->info('name'), 'version')
            ->where('name = ?', $name)
            ->where('version >= ?', $maxVersion)
            ->query()
            ->fetchColumn();
    return $version;
  }

  public function isSiteMobileModeEnabled() {
    return $this->checkSitemobileMode('tablet-mode') || $this->checkSitemobileMode('mobile-mode');
  }

  public function checkSitemobileMode($mode = 'fullsite-mode') {
    if (Engine_Api::_()->hasModuleBootstrap('sitemobile')) {
      return (bool) (Engine_API::_()->sitemobile()->getViewMode() === $mode);
    } else {
      return (bool) ('fullsite-mode' === $mode);
    }
  }

  public function isSitemobileApp() {
    if (Engine_Api::_()->hasModuleBootstrap('sitemobile') && Engine_Api::_()->hasModuleBootstrap('sitemobileapp')) {
      return (bool) Engine_API::_()->sitemobile()->isApp();
    } else {
      return false;
    }
  }

  //PAGE INTERGRATION PLUGIN PRIVACY WORK.
  public function itemPrivacyCheck($subject) {

    //$subject = Engine_Api::_()->core()->getSubject();
    $resource_id = $subject->getIdentity();
    $resource_type = $subject->getType();

    $itemPrivacyCheck = false;

    if (Engine_Api::_()->getDbtable('modules', 'core')->isModuleEnabled('sitepageintegration')) {
      $contentsintegrationTable = Engine_Api::_()->getDbtable('contents', 'sitepageintegration');
      $contentsintegrationTableName = $contentsintegrationTable->info('name');
      $item_id = 'page_id';
      $item_type = 'sitepage_page';

      $itemId = $contentsintegrationTable->select()
                      ->from($contentsintegrationTableName, new Zend_Db_Expr("MAX(`$item_id`) as $item_id"))
                      ->where('resource_id = ?', $resource_id)
                      ->where('resource_type = ?', $resource_type)
                      ->query()->fetchColumn();
      //$result = $select->query()->fetch();

      if (!empty($itemId)) {

        $item_object = Engine_Api::_()->getItem($item_type, $itemId);

        //START MANAGE-ADMIN CHECK
        $isManageAdmin = Engine_Api::_()->sitepage()->isManageAdmin($item_object, 'view');
        if (empty($isManageAdmin)) {
          $itemPrivacyCheck = true;
        }

        //PAGE VIEW AUTHORIZATION
        if (!Engine_Api::_()->sitepage()->canViewPage($item_object)) {
          $itemPrivacyCheck = true;
        }
      }
    }

    if (Engine_Api::_()->getDbtable('modules', 'core')->isModuleEnabled('sitebusinessintegration')) {
      $contentsintegrationTable = Engine_Api::_()->getDbtable('contents', 'sitebusinessintegration');
      $contentsintegrationTableName = $contentsintegrationTable->info('name');
      $item_id = 'business_id';
      $item_type = 'sitebusiness_business';

      $itemId = $contentsintegrationTable->select()
                      ->from($contentsintegrationTableName, new Zend_Db_Expr("MAX(`$item_id`) as $item_id"))
                      ->where('resource_id = ?', $resource_id)
                      ->where('resource_type = ?', $resource_type)->query()->fetchColumn();
      //$result = $select->query()->fetch();

      if (!empty($itemId)) {

        $item_object = Engine_Api::_()->getItem($item_type, $itemId);

        //START MANAGE-ADMIN CHECK
        $isManageAdmin = Engine_Api::_()->sitebusiness()->isManageAdmin($item_object, 'view');
        if (empty($isManageAdmin)) {
          $itemPrivacyCheck = true;
        }

        //BUSINESS VIEW AUTHORIZATION
        if (!Engine_Api::_()->sitebusiness()->canViewBusiness($item_object)) {
          $itemPrivacyCheck = true;
        }
      }
    }

    if (Engine_Api::_()->getDbtable('modules', 'core')->isModuleEnabled('sitegroupintegration')) {
      $contentsintegrationTable = Engine_Api::_()->getDbtable('contents', 'sitegroupintegration');
      $contentsintegrationTableName = $contentsintegrationTable->info('name');
      $item_id = 'group_id';
      $item_type = 'sitegroup_group';

      $itemId = $contentsintegrationTable->select()
                      ->from($contentsintegrationTableName, new Zend_Db_Expr("MAX(`$item_id`) as $item_id"))
                      ->where('resource_id = ?', $resource_id)
                      ->where('resource_type = ?', $resource_type)->query()->fetchColumn();
      //$result = $select->query()->fetch();

      if (!empty($itemId)) {

        $item_object = Engine_Api::_()->getItem($item_type, $itemId);

        //START MANAGE-ADMIN CHECK
        $isManageAdmin = Engine_Api::_()->sitegroup()->isManageAdmin($item_object, 'view');
        if (empty($isManageAdmin)) {
          $itemPrivacyCheck = true;
        }

        //GROUP VIEW AUTHORIZATION
        if (!Engine_Api::_()->sitegroup()->canViewGroup($item_object)) {
          $itemPrivacyCheck = true;
        }
      }
    }
    return $itemPrivacyCheck;
  }

  /*
   * Save the scribd keys for given module if other document related plugins are already installed.
   */

  public function getScribdApiKeys($installedModuleName) {

    if (empty($installedModuleName))
      return;

    $coreTable = Engine_Api::_()->getDbtable('modules', 'core');
    $coreSettings = Engine_Api::_()->getApi('settings', 'core');

    $modulesArray = array('document', 'groupdocument', 'eventdocument', 'sitepagedocument', 'sitebusinessdocument', 'sitegroupdocument', 'siteeventdocument');

    foreach ($modulesArray as $moduleCheck) {
      if ($moduleCheck == $installedModuleName)
        continue;
      if ($coreTable->isModuleEnabled($moduleCheck)) {
        $apiKey = $coreSettings->getSetting("$moduleCheck.api.key");
        $secretKey = $coreSettings->getSetting("$moduleCheck.secret.key");

        if (!empty($apiKey) && !empty($secretKey)) {
          $coreSettings->setSetting("$installedModuleName.api.key", $apiKey);
          $coreSettings->setSetting("$installedModuleName.secret.key", $secretKey);
          return;
        }
      }
    }
  }

  public function getUserPhotoHref($user) {
    $href = '';
    $moduleCore = Engine_Api::_()->getDbtable('modules', 'core');
    $getEnableModuleAdvalbum = $moduleCore->isModuleEnabled('advalbum');
    if (!$getEnableModuleAdvalbum) {
      $tab = Engine_Api::_()->getDbtable('photos', 'album');
    } else {
      $tab = Engine_Api::_()->getDbtable('photos', 'advalbum');
    }
    $photo_id = $tab->select()->from($tab->info('name'), 'photo_id')->where('file_id =?', $user->photo_id)->query()->fetchColumn();
    if ($photo_id) {
      if ($getEnableModuleAdvalbum) {
        $getItem = Engine_Api::_()->getItem('advalbum_photo', $photo_id);
        if (!empty($getItem))
          $href = $getItem->getHref();
      } else {
        $getItem = Engine_Api::_()->getItem('album_photo', $photo_id);
        if (!empty($getItem))
          $href = $getItem->getHref();
      }
    }

    return $href;
  }

  public function getContentPhotoHref($content) {
    $href = '';
    $photo_id = $content->photo_id;
    $tab = Engine_Api::_()->getDbtable('photos', strtolower($content->getModuleName()));
    $photo_id = $tab->select()->from($tab->info('name'), 'photo_id')->where('file_id =?', $content->photo_id)->query()->fetchColumn();
    if ($photo_id) {
      if ($content->getModuleName() == 'Sitealbum')
        $getItem = Engine_Api::_()->getItem("album_photo", $photo_id);
      else
        $getItem = Engine_Api::_()->getItem(strtolower($content->getModuleName()) . "_photo", $photo_id);
      if (!empty($getItem))
        $href = $getItem->getHref();
    }

    return $href;
  }

  public function tinymceEditorOptions($upload_url = false) {
    $coremodule = Engine_Api::_()->getDbtable('modules', 'core')->getModule('core');
    $coreversion = $coremodule->version;
    if ($coreversion < '4.7.0') {
      return array(
          'upload_url' => $upload_url,
          'plugins' => 'directionality,preview,table,layer,style,xhtmlxtras,media,advhr,paste,fullscreen,searchreplace',
          'theme_advanced_buttons1' => "ltr,rtl,|,preview,code,|,cut,copy,paste,pastetext,pasteword,|,undo,redo,|,link,unlink,anchor,charmap,image,media,advhr,|,hr,removeformat,cleanup,fullscreen,|,search,replace",
          'theme_advanced_buttons2' => "bold,italic,underline,strikethrough,|,bullist,numlist,|,outdent,indent,blockquote,|,justifyleft,justifycenter,justifyright,justifyfull,|,sub,sup,|,tablecontrols",
          'theme_advanced_buttons3' => "formatselect,fontselect,fontsizeselect,|,forecolor,backcolor,|,insertlayer,moveforward,movebackward,absolute,|,styleprops,attribs,|,cite,del,ins,");
    } else {
      if (!$upload_url) {
        $uploadPlugin = '';
      } else {
        $uploadPlugin = "jbimages,";
      }
      return array(
          'upload_url' => $upload_url,
          'menubar' => true,
          'plugins' => "directionality,advlist,autolink,lists,link,image," . $uploadPlugin . "charmap,print,preview,hr,anchor,pagebreak,searchreplace,wordcount,visualblocks,visualchars,code,fullscreen,insertdatetime,media,nonbreaking,save,table,contextmenu,directionality,emoticons,paste,textcolor",
          'toolbar1' => "ltr,rtl,undo,redo,removeformat,pastetext,|,code,link,media,image," . $uploadPlugin . "emoticons,|,bullist,numlist,|,print,preview,fullscreen",
          'toolbar2' => "fontselect,fontsizeselect,bold,italic,underline,strikethrough,forecolor,backcolor,|,alignleft,aligncenter,alignright,alignjustify,|,outdent,indent,blockquote",
          'image_advtab' => true,
              /*  'plugins' => 'directionality,preview,table,code,layer,image,media,paste,fullscreen,searchreplace,link,textcolor,charmap,anchor,visualchars,contextmenu',
                'toolbar1' => "ltr,rtl,|,preview,code,|,cut,copy,paste,pastetext,pasteword,|,undo,redo,|,link,unlink,anchor,charmap,image,media,|,hr,removeformat,fullscreen,|,search,replace",
                'toolbar2' => "bold,italic,underline,strikethrough,|,bullist,numlist,|,outdent,indent,blockquote,|,alignleft,aligncenter,alignright,alignjustify,|,sub,sup,|,table",
                'toolbar3' => "formatselect,fontselect,fontsizeselect,|,forecolor,backcolor,|,insertlayer,moveforward,movebackward,absolute," */
      );
    }
  }

  public function tinymceEditorPhotoUploadedFileName() {
    $coremodule = Engine_Api::_()->getDbtable('modules', 'core')->getModule('core');
    $coreversion = $coremodule->version;
    $fileNmame = 'userfile';
    if ($coreversion < '4.7.0') {
      $fileNmame = 'Filedata';
    }
    return $fileNmame;
  }

  public function setMyLocationDetailsCookie($seaocore_myLocationDetails) {

    if(!isset($seaocore_myLocationDetails['changeLocationWidget']) && Engine_Api::_()->getApi('settings', 'core')->getSetting('seaocore.locationspecific', 0)) {
        return;
    }
    
    if(!isset($seaocore_myLocationDetails['changeLocationWidget']) && !Engine_Api::_()->getApi('settings', 'core')->getSetting('seaocore.locationspecific', 0)) {
        $currentCookiesValues = $this->getMyLocationDetailsCookie(1);   
        
        if(!empty($currentCookiesValues['location'])) {
            return;
        }
    }
    
    if (!isset($seaocore_myLocationDetails['locationmiles'])) {
      $seaocore_myLocationDetails['locationmiles'] = Engine_Api::_()->getApi('settings', 'core')->getSetting('seaocore.locationdefaultmiles', 1000);
    }

    if (!empty($seaocore_myLocationDetails)) {
      $seaocore_myLocationDetails = Zend_Json::encode($seaocore_myLocationDetails);
      $view = Zend_Registry::isRegistered('Zend_View') ? Zend_Registry::get('Zend_View') : null;

      setcookie('seaocore_myLocationDetails', $seaocore_myLocationDetails, time() + 60 * 60 * 24 * 30, $view->url(array(), 'default', true));
    }
  }

  public function getMyLocationDetailsCookie($fromCookiesOnly = 0) {

    $seaocore_myLocationDetails = isset($_COOKIE['seaocore_myLocationDetails']) ? $_COOKIE['seaocore_myLocationDetails'] : array();

    if($fromCookiesOnly) {
        if(!is_array($seaocore_myLocationDetails)) {
            return Zend_Json::decode($seaocore_myLocationDetails);
        }
        return array();
    }
    
    if (!empty($seaocore_myLocationDetails) && !is_array($seaocore_myLocationDetails)) {
      $seaocore_myLocationDetails = Zend_Json::decode($seaocore_myLocationDetails);
    }

    if (Count($seaocore_myLocationDetails) > 1) {
      return $seaocore_myLocationDetails;
    } elseif (Engine_Api::_()->getApi('settings', 'core')->getSetting('seaocore.locationdefault', '') && Engine_Api::_()->getApi('settings', 'core')->getSetting('seaocore.locationdefaultlatitude', 0) && Engine_Api::_()->getApi('settings', 'core')->getSetting('seaocore.locationdefaultlongitude', 0)) {

      $seaocore_myLocationDetails['location'] = Engine_Api::_()->getApi('settings', 'core')->getSetting('seaocore.locationdefault', '');
      $seaocore_myLocationDetails['latitude'] = Engine_Api::_()->getApi('settings', 'core')->getSetting('seaocore.locationdefaultlatitude', 0);
      $seaocore_myLocationDetails['longitude'] = Engine_Api::_()->getApi('settings', 'core')->getSetting('seaocore.locationdefaultlongitude', 0);
      $seaocore_myLocationDetails['locationmiles'] = Engine_Api::_()->getApi('settings', 'core')->getSetting('seaocore.locationdefaultmiles', 1000);

      return $seaocore_myLocationDetails;
    }

    return array();
  }

  public function getSuperAdminEmailAddress() {
    $userTable = Engine_Api::_()->getDbtable('users', 'user');
    $userTableName = $userTable->info('name');
    $email = $userTable->select()->from($userTableName, 'email')->where('level_id =?', 1)->order('user_id ASC')->query()->fetchColumn();
    $settings = Engine_Api::_()->getApi('settings', 'core');
    $core_mail_contact = $settings->getSetting('core.mail.contact');
    return $core_mail_contact ? $core_mail_contact : $email;
  }

  public function getLocaleDateFormat() {
    $localeObject = Zend_Registry::get('Locale');
    $dateLocaleString = $localeObject->getTranslation('long', 'Date', $localeObject);
    $dateLocaleString = preg_replace('~\'[^\']+\'~', '', $dateLocaleString);
    $dateLocaleString = strtolower($dateLocaleString);
    $dateLocaleString = preg_replace('/[^ymd]/i', '', $dateLocaleString);
    $dateLocaleString = preg_replace(array('/y+/i', '/m+/i', '/d+/i'), array('y', 'm', 'd'), $dateLocaleString);
    return $dateLocaleString;
  }

  //GET BITLY SHORT URL:
  public function getBitlyShortUrl($URL) {
    $shortURL = $URL;
    $appkey = Engine_Api::_()->getApi('settings', 'core')->getSetting('bitly.apikey');
    $appsecret = Engine_Api::_()->getApi('settings', 'core')->getSetting('bitly.secretkey');
    if (!empty($appkey) && !empty($appsecret)) {
      $shortURL = Engine_Api::_()->getApi('Bitly', 'seaocore')->get_bitly_short_url($URL, $appkey, $appsecret, $format = 'txt');
    }
    if($shortURL == 'INVALID_LOGIN')
          return $URL;
    return $shortURL;
  }

  public function geoUserSettings($moduleName) {
    $viewer = Engine_Api::_()->user()->getViewer();
    $userSettings = Engine_Api::_()->getDbtable('settings', 'user')->getSetting($viewer, "seaocore_geo_metrice");
    if (isset($userSettings) && !empty($userSettings)) {
      $geoSettings = $userSettings;
    } else {
      if ($moduleName == 'sitetagcheckin') {
        $geoSettings = Engine_Api::_()->getApi('settings', 'core')->getSetting('sitetagcheckin.proximity.search.kilometer', 0);
      } elseif ($moduleName == 'sitereview') {
        $geoSettings = Engine_Api::_()->getApi('settings', 'core')->getSetting('sitereview.proximity.search.kilometer', 0);
      }
    }

    return $geoSettings;
  }
    
  public function getModuleContent($contentDetails = array()) {
        
          $table_name = Engine_Api::_()->getItemTable($contentDetails['tempTableName']);

          $orderby = $contentDetails['orderby'];
          switch ($contentDetails['module_name']) {
              case 'classified':
                  $params = array('closed' => 0, 'orderby' => $orderby);
                  $select = $table_name->getClassifiedsSelect(null, null);
                  break;
              case 'blog':
                  $params = array('draft' => 1, 'visible' => 1, 'orderby' => $orderby);
                  $select = $table_name->getBlogsSelect($params);
                  break;
              case 'album':
                  $params = array('search' => 1);
                  if(Engine_Api::_()->getDbtable('modules', 'core')->isModuleEnabled('sitealbum')){
                    $params = array('albumType' => 1, 'notLocationPage' => 1);
                  }
                  $select = $table_name->getAlbumSelect($params);    
                  $select->order($orderby);
                  break;
              case 'event':
                  $params = array('search' => 1, 'orderby' => $orderby);
                  $select = $table_name->getEventSelect($params);                                
                  break;
              case 'forum':
                  $select = $table_name->select()
                      ->where('closed = ?', 0)
                      ->order($orderby);    
                  break;
              case 'group':
                  $params = array('search' => 1, 'orderby' => $orderby);
                  $select = $table_name->getGroupSelect($params);                  
                  break;             
              case 'music':
                  $select = $table_name->select()
                      ->where('search = ?', 1)
                      ->order($orderby);                   
                  break;
              case 'poll':
                  $select = $table_name->select()
                      ->where('search = ?', 1)
                      ->where('closed = ?', 0)
                      ->order($orderby);                   
                  break;
              case 'video':
                  $params = array('search' => 1, 'status' => 1, 'orderby' => $orderby);
                  $select = Engine_Api::_()->video()->getVideosSelect($params);                   
                  break;
              case 'list':
                  $params = array('type' => 'browse_home_zero', 'orderby' => $orderby);
                  $select = $table_name->getListsSelect($params);                   
                  break;
              case 'sitestore':
                  $params = array('type' => 'browse_home_zero', 'orderby' => $orderby);
                  $select = Engine_Api::_()->sitestore()->getSitestoresSelect($params);          
                  break;     
              case 'sitestoreproduct':
                  $params = array('type' => 'browse_home_zero', 'orderby' => $orderby);
                  $select = $table_name->getSitestoreproductsSelect($params);                   
                  break;
              case 'siteevent':
                  $params = array('type' => 'browse_home_zero', 'action' => 'upcoming');
                  $select = $table_name->getSiteeventsSelect($params);                   
                  break;
              case 'sitepage':
                  $params = array('type' => 'browse_home_zero', 'orderby' => $orderby);
                  $select = Engine_Api::_()->sitepage()->getSitepagesSelect($params);   
                  break;
              case 'sitepagedocument':
                  $params = array('status' => 1, 'draft' => 0, 'approved' => 1, 'searchable' => 1, 'orderby' => $orderby);
                  $select = $table_name->getSitepagedocumentsSelect($params);
                  break;    
              case 'sitepageevent':
                  $params = array('orderby' => 'endtime', 'searchable' => 1, 'orderby' => $orderby);
                  $select = $table_name->getSitepageeventsSelect($params);
                  break;    
              case 'sitepagenote':
                  $params = array('draft' => 0, 'searchable' => 1, 'orderby' => $orderby);
                  $select = $table_name->getSitepagenotesSelect($params);
                  break;  
              case 'sitepageoffer':
                  $select = $table_name->select()->order($orderby); 
                  break;  
              case 'sitepagevideo':
                  $params = array('see_all' => 0, 'orderby' => $orderby);
                  $select = $table_name->getSitepagevideosSelect($params);                  
                  break;
              case 'sitepagemusic':
                  $params = array('searchable' => 1, 'orderby' => $orderby);
                  $select = $table_name->getPlaylistSelect($params);                  
                  break;
              case 'sitepagepoll':
                  $params = array('approved' => 1, 'searchable' => 1, 'orderby' => $orderby);
                  $select = $table_name->getsitepagepollsSelect($params);                  
                  break;
              case 'sitepagereview':
                  $select = $table_name->select()->order($orderby);                  
                  break;
              case 'sitegroup':
                  $params = array('type' => 'browse_home_zero', 'orderby' => $orderby);
                  $select = Engine_Api::_()->sitegroup()->getSitegroupsSelect($params);
                  break;    
              case 'sitebusiness':
                  $params = array('type' => 'browse_home_zero', 'orderby' => $orderby);
                  $select = Engine_Api::_()->sitebusiness()->getSitebusinessesSelect($params);
                  break;  
              case 'sitereview':
                  $params = array('type' => 'browse_home_zero', 'listingtype_id' => $contentDetails['listingtypeId'], 'orderby' => $orderby);
                  $select = $table_name->getSitereviewsSelect($params);
                  break;    
              default:
                  $select = $table_name->select();
                  break; 
          }
          
          if (isset($contentDetails['content_limit']) && !empty($contentDetails['content_limit'])) {
              $select->limit($contentDetails['content_limit']);
          }
          
          if(isset($contentDetails['category_id']) && !empty($contentDetails['category_id'])){
            $select->where('category_id = ?', $contentDetails['category_id']);
          }          
          
          return $table_name->fetchAll($select);         
    }
    
    public function getLocationsTabs() {
        
        $modules = array('siteevent', 'sitealbum', 'sitemember');
        
        foreach($modules as $module) {
            $isEnabled = Engine_Api::_()->getDbtable('modules', 'core')->isModuleEnabled($module);
            if($isEnabled) {
                return true;
            }
        }
        
        return false;
    }
    
  public function getModuleItem($resourceType = null, $resourceId = null) {

    $table = Engine_Api::_()->getItemTable($resourceType);
    $table_name = $table->info('name');
    switch ($resourceType) {
      case 'sitereview_listing':
        $listingtype_id = Engine_Api::_()->getItem('sitereview_listing', $resourceId)->listingtype_id;
        Engine_Api::_()->sitereview()->setListingTypeInRegistry($listingtype_id);
        $listingtypeArray = Zend_Registry::get('listingtypeArray' . $listingtype_id);
        $corePagesTable = Engine_Api::_()->getDbtable('pages', 'core');
        $page_id = $corePagesTable->select()
                        ->from($corePagesTable->info('name'), 'page_id')
                        ->where("name = ?", "sitereview_index_index_listtype_$listingtype_id")->query()->fetchColumn();

        $coreContentTable = Engine_Api::_()->getDbtable('content', 'core');
        $params = $coreContentTable->select()
                        ->from($coreContentTable->info('name'), 'params')
                        ->where("page_id = ?", $page_id)->where('name = ?', 'sitereview.browse-listings-sitereview')->query()->fetchColumn();
        $params = Zend_Json::decode($params);
        $statstics = $params['statistics'];
        if (!empty($statstics) && empty($listingtypeArray->reviews) || $listingtypeArray->reviews == 1) {
          $key = array_search('reviewCount', $statstics);
          if (!empty($key)) {
            unset($statstics[$key]);
          }
        }
        $columnArray = array();
        if (in_array('viewCount', $statstics))
          $columnArray[] = 'view_count';
        if (in_array('commentCount', $statstics))
          $columnArray[] = 'comment_count';
        if (in_array('likeCount', $statstics))
          $columnArray[] = 'like_count';
        if (in_array('reviewCount', $statstics))
          $columnArray[] = 'review_count';
        $columnArray[] = 'category_id';
        $columnArray[] = 'listingtype_id';
        $columnArray[] = 'listing_id';
        $columnArray[] = 'title';
        $columnArray[] = 'photo_id';
        $columnArray[] = 'price';
        $columnArray[] = 'location';
        $columnArray[] = 'creation_date';
        $columnArray[] = 'owner_id';
        if(Engine_Api::_()->getDbtable('modules', 'core')->isModuleEnabled('sitereviewpaidlisting'))
        $columnArray[] = 'package_id';
        $select = $table->select()->from($table_name, $columnArray)->where('listing_id =?', $resourceId);
        $resultRow = $table->fetchRow($select);
        break;
      case 'siteevent_event':
        $siteeventTable = Engine_Api::_()->getDbTable('events', 'siteevent');
        $siteeventTableName = $siteeventTable->info('name');
        $SiteEventOccuretable = Engine_Api::_()->getDbTable('occurrences', 'siteevent');
        $siteeventOccurTableName = $SiteEventOccuretable->info('name');
        $select = $siteeventTable->select()
                ->setIntegrityCheck(false)
                ->from($siteeventTableName);
        $select = $select->join($siteeventOccurTableName, "$siteeventTableName.event_id = $siteeventOccurTableName.event_id")->where($siteeventTableName. '.event_id =?', $resourceId);
        $resultRow = $table->fetchRow($select);
        break;
      case 'sitestoreproduct_product':
        $sitestoreproductTable = Engine_Api::_()->getDbTable('products', 'sitestoreproduct');
        $sitestoreproductTableName = $sitestoreproductTable->info('name');
        $otherInfoTable = Engine_Api::_()->getDbtable('otherinfo', 'sitestoreproduct');
        $otherInfoTableName = $otherInfoTable->info('name');
     
        $select = $sitestoreproductTable->select()
                ->setIntegrityCheck(false)
                ->from($sitestoreproductTableName);
        $select = $select->joinLeft($otherInfoTableName, "$sitestoreproductTableName.product_id = $otherInfoTableName.product_id")->where($sitestoreproductTableName. '.product_id =?', $resourceId);
        $resultRow = $table->fetchRow($select);
        break;
      case 'recipe':
        $recipeTable = Engine_Api::_()->getDbTable('recipes', 'recipe');
        $recipeTableName = $recipeTable->info('name');
        $locationTable = Engine_Api::_()->getDbtable('locations', 'recipe');
        $locationName = $locationTable->info('name');
     
        $select = $recipeTable->select()
                ->setIntegrityCheck(false)
                ->from($recipeTableName);
        $select = $select->joinLeft($locationName, "$recipeTableName.recipe_id = $locationName.recipe_id")->where($recipeTableName. '.recipe_id =?', $resourceId);
        $resultRow = $table->fetchRow($select);
        break;
      case 'feedback':
        $feedbackTable = Engine_Api::_()->getItemTable('feedback');
        $feedbackTableName = $feedbackTable->info('name');
        $feedbackVoteTable = Engine_Api::_()->getDbtable('votes', 'feedback');
        $feedbackVoteTableName = $feedbackVoteTable->info('name');
     
        $select = $feedbackTable->select()
                ->setIntegrityCheck(false)
                ->from($feedbackTableName);
        $select = $select->joinLeft($feedbackVoteTableName, "$feedbackTableName.feedback_id = $feedbackVoteTableName.feedback_id")->where($feedbackTableName. '.feedback_id =?', $resourceId);
        $resultRow = $table->fetchRow($select);
        break;
      default:
        $resultRow = Engine_Api::_()->getItem($resourceType, $resourceId);
    }
    return $resultRow;
  }

  public function setUserLocation($location, $locationPrivacy = 'everyone') {

        $db = Zend_Db_Table_Abstract::getDefaultAdapter();
        $viewer = Engine_Api::_()->user()->getViewer();
        $viewer_id = $viewer->getIdentity();
        $resource = $user = Engine_Api::_()->getItem('user', $viewer_id);
        
       // if (empty($user->location) && empty($user->seao_locationid)) {
            $aliasedFields = $user->fields()->getFieldsObjectsByAlias();
            $topLevelId = $aliasedFields['profile_type']->field_id;
           
            $table_exist = $db->query('SHOW TABLES LIKE \'engine4_user_fields_search\'')->fetch();
            if (!empty($table_exist)) {
                $column_exist = $db->query('SHOW COLUMNS FROM engine4_user_fields_search LIKE \'location\'')->fetch();
            }

            $profilemapsTable = Engine_Api::_()->getDbtable('profilemaps', 'sitemember');
            $profilemapsTablename = $profilemapsTable->info('name');
            $select = $profilemapsTable->select()->from($profilemapsTablename, array('profile_type'));
            $select->where($profilemapsTablename . '.option_id = ?', $topLevelId);
            
            $profile_type = $select->query()->fetchColumn();

            if (!empty($profile_type)) {

                $valuesTable = Engine_Api::_()->fields()->getTable('user', 'values');
                $valuesTableName = $valuesTable->info('name');
                $select = $valuesTable->select()
                        ->from($valuesTableName, array('*'))
                        ->where($valuesTableName . '.item_id = ?', $viewer_id)
                        ->where($valuesTableName . '.field_id = ?', $profile_type);
                $valuesResultsLocation = $select->query()->fetchAll();

                if (empty($valuesResultsLocation)) {
                    Engine_Api::_()->fields()->getTable('user', 'values')->insert(array('value' => $location, 'item_id' => $viewer_id, 'field_id' => $profile_type, 'privacy' => $locationPrivacy));
                } else {
                    Engine_Api::_()->fields()->getTable('user', 'values')->update(array('value' => $location, 'privacy' => $locationPrivacy), array('item_id =?' => $viewer_id, 'field_id =?' => $profile_type));
                }
                
                if (!empty($column_exist)) {
                        Engine_Api::_()->fields()->getTable('user', 'search')->update(array('location' => $location), array('item_id =?' => $viewer_id));
                    }
            }

            $resource->location = $location;
            $resource->save();
            $itemTable = Engine_Api::_()->getDbtable('users', 'user');    
            if ($location) {
                //DELETE THE RESULT FORM THE TABLE.
                Engine_Api::_()->getDbtable('locationitems', 'seaocore')->delete(array('resource_id =?' => $viewer_id, 'resource_type = ?' => 'user'));
                $seaoLocation = Engine_Api::_()->getDbtable('locationitems', 'seaocore')->getLocationItemId($location, '', 'user', $viewer_id);
                $itemTable->update(array('seao_locationid' => $seaoLocation), array("user_id =?" => $viewer_id));
            }
        //}
    }
    
    public function checkEnabledNestedComment($resource_type = null, $params = array()) {
        
        if(!$resource_type)
            return false;
      
        $params = array_merge($params, array('resource_type' => $resource_type));
        
        if(Engine_Api::_()->hasModuleBootstrap('nestedcomment')) {
            return Engine_Api::_()->nestedcomment()->getEnabledModule($params);
        }
        
        return false;
    }
    
    public function isTabletDevice() {
    // No UA defined?
    if (!isset($_SERVER['HTTP_USER_AGENT'])) {
      return false;
    }
    $userAgent = $_SERVER['HTTP_USER_AGENT'];
    if (preg_match('/' . 'Nexus 5' . '/i', $userAgent))
            return false;
    if (preg_match('/' . 'iPad|Nexus|GT-P1000|SGH-T849|SHW-M180S' . '/i', $userAgent))
      return true;
    else
      return false;
  }
    
}
