<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Twitter.php 9382 2011-10-14 00:41:45Z john $
 * @author     John Boehr <john@socialengine.com>
 */

/**
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class User_Model_DbTable_Janrain extends Engine_Db_Table
{
  static public function loginButton($mode = null)
  {
    $settings = Engine_Api::_()->getApi('settings', 'core');
    $translate = Zend_Registry::get('Zend_Translate');
    $view = Zend_Registry::get('Zend_View');
    $locale = Zend_Registry::get('Locale');
    
    $janrainAccountType = $settings->core_janrain_type;
    $janrainUsername = $settings->core_janrain_username;
    $jainrainActionText = Zend_Json::encode(true ? '' : $translate->translate('Sign in using your account with'));
    $formMode = Zend_Json::encode($mode);
    $accountType = Zend_Json::encode($janrainAccountType);
    if( $mode == 'page' ) {
      $extraClass = 'janrainPageMode';
    } else {
      $extraClass = 'janrainColumnMode';
    }
    $janrainCode = <<<EOF
<script type="text/javascript">
(function() {
    var formMode = $formMode;
    var accountType = $accountType;
    
    // Custom
    if( accountType == 'pro' ) {
      janrain.settings.type = 'embed';
      janrain.settings.providersPerPage = '6';
      if( $jainrainActionText ) {
        janrain.settings.actionText = $jainrainActionText;
      }
      if( formMode == "page" ) {
        janrain.settings.format = 'one row';
        janrain.settings.width = '400';
      } else {
        janrain.settings.format = 'one column';
        janrain.settings.width = '168';
      }
    } else {
      janrain.settings.type = 'modal';
    }
    
    function isReady() { janrain.ready = true; };
    if (document.addEventListener) {
      document.addEventListener("DOMContentLoaded", isReady, false);
    } else {
      window.attachEvent('onload', isReady);
    }

    var e = document.createElement('script');
    e.type = 'text/javascript';
    e.id = 'janrainAuthWidget';

    if (document.location.protocol === 'https:') {
      e.src = 'https://rpxnow.com/js/lib/$janrainUsername/engage.js';
    } else {
      e.src = 'http://widget-cdn.rpxnow.com/js/lib/$janrainUsername/engage.js';
    }

    var s = document.getElementsByTagName('script')[0];
    s.parentNode.insertBefore(e, s);
})();
</script>
EOF;
    
    // Add link/widget
    if( $janrainAccountType == 'pro' ) {
      $janrainCode .= '<div id="janrainEngageEmbed" class="$extraClass"></div>';
    } else {
      $janrainProviders = explode(',', $settings->core_janrain_providers);
      $imgStr = '';
      $baseUrl = Zend_Registry::get('StaticBaseUrl');
      foreach( $janrainProviders as $janrainProvider ) {
        $imgStr .= '<img src="' 
          . $baseUrl . 'application/modules/User/externals/images/janrain/' . $janrainProvider . '.png'
          . '" alt="' 
          . $janrainProvider
          . '" title="' 
          . $janrainProvider
          . '"/>';
      }
      $janrainCode .= '<span class="janrainEngageLabel">'
          . $translate->translate('Or sign in using:')
          . '<br />'
          . '<a class="janrainEngage" href="#">' 
          . $imgStr
          . '<wbr />'
          . '</a>'
          . '</span>'
          ;
    }

    return $janrainCode;
  }
}
