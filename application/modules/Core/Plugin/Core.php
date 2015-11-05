<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Core.php 9858 2013-02-06 01:15:54Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Core_Plugin_Core
{
  public function onItemDeleteBefore($event)
  {
    $payload = $event->getPayload();

    if( $payload instanceof Core_Model_Item_Abstract ) {

      // Delete tagmaps
      $tagMapTable = Engine_Api::_()->getDbtable('TagMaps', 'core');

      // Delete tagmaps by resource
      $tagMapSelect = $tagMapTable->select()
        ->where('resource_type = ?', $payload->getType())
        ->where('resource_id = ?', $payload->getIdentity());
      foreach( $tagMapTable->fetchAll($tagMapSelect) as $tagMap ) {
        $tagMap->delete();
      }

      // Delete tagmaps by tagger
      $tagMapSelect = $tagMapTable->select()
        ->where('tagger_type = ?', $payload->getType())
        ->where('tagger_id = ?', $payload->getIdentity());
      foreach( $tagMapTable->fetchAll($tagMapSelect) as $tagMap ) {
        $tagMap->delete();
      }

      // Delete tagmaps by tag
      $tagMapSelect = $tagMapTable->select()
        ->where('tag_type = ?', $payload->getType())
        ->where('tag_id = ?', $payload->getIdentity());
      foreach( $tagMapTable->fetchAll($tagMapSelect) as $tagMap ) {
        $tagMap->delete();
      }

      // Delete links
      $linksTable = Engine_Api::_()->getDbtable('links', 'core');

      // Delete links by parent
      $linksSelect = $linksTable->select()
        ->where('parent_type = ?', $payload->getType())
        ->where('parent_id = ?', $payload->getIdentity());
      foreach( $linksTable->fetchAll($linksSelect) as $link ) {
        $link->delete();
      }

      // Delete links by owner
      $linksSelect = $linksTable->select()
        ->where('owner_type = ?', $payload->getType())
        ->where('owner_id = ?', $payload->getIdentity());
      foreach( $linksTable->fetchAll($linksSelect) as $link ) {
        $link->delete();
      }

      // Delete comments
      $commentTable = Engine_Api::_()->getDbtable('comments', 'core');

      // Delete comments by parent
      $commentSelect = $commentTable->select()
        ->where('resource_type = ?', $payload->getType())
        ->where('resource_id = ?', $payload->getIdentity());
      foreach( $commentTable->fetchAll($commentSelect) as $comment ) {
        $comment->delete();
      }

      // Delete comments by poster
      $commentSelect = $commentTable->select()
        ->where('poster_type = ?', $payload->getType())
        ->where('poster_id = ?', $payload->getIdentity());
      foreach( $commentTable->fetchAll($commentSelect) as $comment ) {
        $comment->delete();
      }

      // Delete likes
      $likeTable = Engine_Api::_()->getDbtable('likes', 'core');

      // Delete likes by resource
      $likeSelect = $likeTable->select()
        ->where('resource_type = ?', $payload->getType())
        ->where('resource_id = ?', $payload->getIdentity());
      foreach( $likeTable->fetchAll($likeSelect) as $like ) {
        $like->delete();
      }

      // Delete likes by poster
      $likeSelect = $likeTable->select()
        ->where('poster_type = ?', $payload->getType())
        ->where('poster_id = ?', $payload->getIdentity());
      foreach( $likeTable->fetchAll($likeSelect) as $like ) {
        $like->delete();
      }


      // Delete styles
      $stylesTable = Engine_Api::_()->getDbtable('styles', 'core');
      $stylesSelect = $stylesTable->select()
        ->where('type = ?', $payload->getType())
        ->where('id = ?', $payload->getIdentity());
      foreach( $stylesTable->fetchAll($stylesSelect) as $styles ) {
        $styles->delete();
      }
      
      // Delete reports
      //
      // Admins can now dismiss reports from the Abuse reports page
      //
      // $reportTable = Engine_Api::_()->getDbtable('reports', 'core');
      // $reportTable->delete(array(
      //   'subject_type = ?' => $payload->getType(),
      //   'subject_id = ?' => $payload->getIdentity(),
      // ));
    }

    // Users only
    if( $payload instanceof User_Model_User ) {

      // Delete reports
      $reportTable = Engine_Api::_()->getDbtable('reports', 'core');

      // Delete reports by reporter
      $reportSelect = $reportTable->select()
        ->where('user_id = ?', $payload->getIdentity());
      foreach( $reportTable->fetchAll($reportSelect) as $report ) {
        $report->delete();
      }
    }
  }
  
  public function onRenderLayoutDefault($event, $mode = null)
  {
    $view = $event->getPayload();
    if( !($view instanceof Zend_View_Interface) ) {
      return;
    }
    
    $settings = Engine_Api::_()->getDbtable('settings', 'core');
    
    // Generic
    if( ($script = $settings->core_site_script) ) {
      $view->headScript()->appendScript($script);
    }
    
    // Google analytics
    if( ($code = $settings->core_analytics_code) ) {
      $code = $view->string()->escapeJavascript($code);
      $script = <<<EOF
var _gaq = _gaq || [];
_gaq.push(['_setAccount', '$code']);
_gaq.push(['_trackPageview']);

(function() {
  var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
  ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
  var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();
EOF;
      $view->headScript()->appendScript($script);
    }
    
    // Viglink
    if( $settings->core_viglink_enabled ) {
      $code = $settings->core_viglink_code;
      $subid = $settings->core_viglink_subid;
      $subid = ( !$subid ? 'undefined' : "'" . $subid . "'" );
      $code = $view->string()->escapeJavascript($code);
      $script = <<<EOF
var vglnk = {
  api_url: 'http://api.viglink.com/api',
  key: '$code',
  sub_id: $subid
};

(function(d, t) {
  var s = d.createElement(t); s.type = 'text/javascript'; s.async = true;
  s.src = ('https:' == document.location.protocol ? vglnk.api_url :
           'http://cdn.viglink.com/api') + '/vglnk.js';
  var r = d.getElementsByTagName(t)[0]; r.parentNode.insertBefore(s, r);
}(document, 'script'));
EOF;
      $view->headScript()->appendScript($script);
    }
    
    // Wibiya
    if( ($src = $settings->core_wibiya_src) ) {
      $view->headScript()->appendFile($src);
    }
    
    // Janrain
    if( 'none' != $settings->core_janrain_enable ) {
      $locale = Zend_Registry::get('Locale');
      
      $janrainAccountType = $settings->core_janrain_type;
      $janrainUsername = $settings->core_janrain_username;
      $janrainAppId = $settings->core_janrain_id;
      $janrainAppDomain = $settings->core_janrain_domain;
      $janrainAppUrl = $janrainAppDomain;
      if( strtolower(substr($janrainAppUrl, 0, 4)) != 'http' ) {
        $janrainAppUrl = 'https://' . $janrainAppUrl;
      }
      $janrainTokenUrl = ( _ENGINE_SSL ? 'https://' : 'http://' )
          . $_SERVER['HTTP_HOST']
          . $view->url(array('action' => 'janrain', 'controller' => 'auth', 
            'module' => 'user'), 'default', true);
      $jainrainLanguage = $locale->getLanguage();
    
      $script = <<<EOF
if (typeof window.janrain !== 'object') window.janrain = {};
window.janrain.settings = {};
// Extra
janrain.settings.appId = '$janrainAppId';
janrain.settings.appUrl = '$janrainAppUrl';
janrain.settings.language = '$jainrainLanguage';
janrain.settings.tokenUrl = '$janrainTokenUrl';
EOF;
      $view->headScript()->appendScript($script);
    }
    
    if( 'publish' == $settings->core_janrain_enable ) {
      // Handle post-publish javascript stuff
      if( $mode != 'simple' ) { // Required to prevent smoothbox issue
        $session = new Zend_Session_Namespace('JanrainActivity');
        $viewer = Engine_Api::_()->user()->getViewer();
        if( ($session->message || $session->url) && $viewer->getIdentity() ) {
          $userSettings = Engine_Api::_()->getDbtable('settings', 'user');
          if( !$userSettings->getSetting($viewer, 'janrain.no-share', 0) ) {
            $janrainAppId = $settings->core_janrain_id;
            $janrainUsername = $settings->core_janrain_username;
            
            $providers = Zend_Json::encode(explode(',', $settings->core_janrain_providers));
            $publishMessage = Zend_Json::encode($session->message);
            $publishUrl = Zend_Json::encode($session->url);
            $publishName = Zend_Json::encode($session->name);
            $publishDesc = Zend_Json::encode($session->desc);
            $publishPicUrl = Zend_Json::encode($session->picture);
            
            $script = <<<EOF
(function() {
    if (typeof window.janrain !== 'object') window.janrain = {};
    if (typeof window.janrain.settings !== 'object') window.janrain.settings = {};
    if (typeof window.janrain.settings.share !== 'object') window.janrain.settings.share = {};
    if (typeof window.janrain.settings.packages !== 'object') janrain.settings.packages = [];
    janrain.settings.packages.push('share');

    /* _______________ can edit below this line _______________ */

    //janrain.settings.share.providers = ["facebook", "twitter"];
    //janrain.settings.share.modes = ["broadcast"];
    janrain.settings.share.message = $publishMessage;
    janrain.settings.share.title = $publishName;
    janrain.settings.share.url = $publishUrl;
    janrain.settings.share.description = $publishDesc;

    /* _______________ can edit above this line _______________ */

    function isReady() { janrain.ready = true; };
    if (document.addEventListener) {
        document.addEventListener("DOMContentLoaded", isReady, false);
    } else {
        window.attachEvent('onload', isReady);
    }

    var e = document.createElement('script');
    e.type = 'text/javascript';
    e.id = 'janrainWidgets';

    if (document.location.protocol === 'https:') {
      e.src = 'https://rpxnow.com/js/lib/$janrainUsername/widget.js';
    } else {
      e.src = 'http://widget-cdn.rpxnow.com/js/lib/$janrainUsername/widget.js';
    }

    var s = document.getElementsByTagName('script')[0];
    s.parentNode.insertBefore(e, s);
    
    window.addEvent('load', function() {
      $('janrainEngageShare').click();
    });
})();
EOF;
            $view->headScript()->appendScript($script);
            
            // Clear session
            $session->unsetAll();
          }
        }
      }
    }
  }
  
  public function onRenderLayoutDefaultSimple($event)
  {
    // Forward
    return $this->onRenderLayoutDefault($event, 'simple');
  }
  
  public function onRenderLayoutMobileDefault($event)
  {
    // Forward
    return $this->onRenderLayoutDefault($event);
  }
  
  public function onRenderLayoutMobileDefaultSimple($event)
  {
    // Forward
    return $this->onRenderLayoutDefault($event);
  }
}