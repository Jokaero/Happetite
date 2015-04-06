<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Controller.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Core_Widget_MenuMiniController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    $this->view->viewer = $viewer = Engine_Api::_()->user()->getViewer();

    $require_check = Engine_Api::_()->getApi('settings', 'core')->core_general_search;
    if(!$require_check){
      if( $viewer->getIdentity()){
        $this->view->search_check = true;
      }
      else{
        $this->view->search_check = false;
      }
    }
    else $this->view->search_check = true;

    //$this->view->navigation = $navigation = Engine_Api::_()
    //  ->getApi('menus', 'core')
    //  ->getNavigation('core_mini');
      
    $this->view->navigation = $navigation = Engine_Api::_()
      ->getApi('menus', 'advmenusystem')->getNavigation('core_mini');

    if( $viewer->getIdentity() )
    {
      $this->view->notificationCount = Engine_Api::_()->getDbtable('notifications', 'activity')->hasNotifications($viewer);
    }

    $request = Zend_Controller_Front::getInstance()->getRequest();
    $this->view->notificationOnly = $request->getParam('notificationOnly', false);
    $this->view->updateSettings = Engine_Api::_()->getApi('settings', 'core')->getSetting('core.general.notificationupdate');
    
    // Languages
    $translate    = Zend_Registry::get('Zend_Translate');
    $languageList = $translate->getList();
    
    // Prepare language name list
    $languageNameList  = array();
    $languageDataList  = Zend_Locale_Data::getList(null, 'language');
    $territoryDataList = Zend_Locale_Data::getList(null, 'territory');

    foreach( $languageList as $localeCode ) {
      $languageNameList[$localeCode] = Engine_String::ucfirst(Zend_Locale::getTranslation($localeCode, 'language', $localeCode));
      if (empty($languageNameList[$localeCode])) {
        if( false !== strpos($localeCode, '_') ) {
          list($locale, $territory) = explode('_', $localeCode);
        } else {
          $locale = $localeCode;
          $territory = null;
        }
        if( isset($territoryDataList[$territory]) && isset($languageDataList[$locale]) ) {
          $languageNameList[$localeCode] = $territoryDataList[$territory] . ' ' . $languageDataList[$locale];
        } else if( isset($territoryDataList[$territory]) ) {
          $languageNameList[$localeCode] = $territoryDataList[$territory];
        } else if( isset($languageDataList[$locale]) ) {
          $languageNameList[$localeCode] = $languageDataList[$locale];
        } else {
          continue;
        }
      }
    }
    
    $languageNameList = array_merge(array(
      $defaultLanguage => $defaultLanguage
    ), $languageNameList);
    
    $this->view->languageNameList = $languageNameList;
    
    // Auth in lightbox
    $front = Zend_Controller_Front::getInstance();
    
		$module = $front->getRequest()->getModuleName();
		$action = $front->getRequest()->getActionName();
		$controller = $front->getRequest()->getControllerName();
    
		if (($module == 'user' && $controller == 'auth' && $action == 'login') 
        or ($module == 'core' && $controller == 'error' && $action == 'requireuser')
        or $viewer->getIdentity()
		) {
			$this->view->isUserLoginPage = true;
		}
    
		if (($module == 'user' && $controller == 'signup' && $action == 'index')
        or ($module == 'social-connect' && $controller == 'signup' && $action == 'index')
		) {
			$this->view->isUserSignupPage = true;
		}
    
    
  }
}