<?php
/**
 * YouNet
 *
 * @category   Application_Extensions
 * @package    Adv Notification
 * @copyright  Copyright 2011 YouNet Developments
 * @license    http://www.modules2buy.com/
 * @version    $Id: menu auctions
 * @author     Minh Nguyen
 */
class Advmenusystem_Widget_AdvancedFooterMenuController extends Engine_Content_Widget_Abstract
{
	public function indexAction()
	{
		$this-> view -> show_language_dropdown = $show_language_dropdown = $this -> _getParam('show_language_dropdown', 1);
		$this-> view -> show_facebook = $show_facebook = $this -> _getParam('show_facebook', 1);
		$this-> view -> show_twitter = $show_twitter = $this -> _getParam('show_twitter', 1);
		$this-> view -> show_pinterest = $show_pinterest = $this -> _getParam('show_pinterest', 1);
		$this-> view -> show_youtube = $show_youtube = $this -> _getParam('show_youtube', 1);
		$this -> view -> navigation = $navigation = Engine_Api::_() -> getApi('menus', 'core') -> getNavigation('core_footer');
		
		
		$facebook = Engine_Api::_() -> getApi('settings', 'core') -> getSetting('facebook.avdmenusystem.sociallink');
		if($facebook && $show_facebook){
			$facebook = Zend_JSON::decode($facebook);
			$this -> view -> facebook = $facebook;
		}
		
		$twitter = Engine_Api::_() -> getApi('settings', 'core') -> getSetting('twitter.avdmenusystem.sociallink');
		if($twitter && $show_twitter){
			$twitter = Zend_JSON::decode($twitter);
			$this -> view -> twitter = $twitter;
		}
		
		$pinterest = Engine_Api::_() -> getApi('settings', 'core') -> getSetting('pinterest.avdmenusystem.sociallink');
		if($pinterest && $show_pinterest){
			$pinterest = Zend_JSON::decode($pinterest);
			$this -> view -> pinterest = $pinterest;
		}
		
		$youtube = Engine_Api::_() -> getApi('settings', 'core') -> getSetting('youtube.avdmenusystem.sociallink');
		if($youtube && $show_youtube){
			$youtube = Zend_JSON::decode($youtube);
			$this -> view -> youtube = $youtube;
		}
		
		// Languages
		$translate = Zend_Registry::get('Zend_Translate');
		$languageList = $translate -> getList();

		//$currentLocale = Zend_Registry::get('Locale')->__toString();

		// Prepare default langauge
		$defaultLanguage = Engine_Api::_() -> getApi('settings', 'core') -> getSetting('core.locale.locale', 'en');
		if (!in_array($defaultLanguage, $languageList))
		{
			if ($defaultLanguage == 'auto' && isset($languageList['en']))
			{
				$defaultLanguage = 'en';
			}
			else
			{
				$defaultLanguage = null;
			}
		}

		// Prepare language name list
		$languageNameList = array();
		$languageDataList = Zend_Locale_Data::getList(null, 'language');
		$territoryDataList = Zend_Locale_Data::getList(null, 'territory');

		foreach ($languageList as $localeCode)
		{
			$languageNameList[$localeCode] = Engine_String::ucfirst(Zend_Locale::getTranslation($localeCode, 'language', $localeCode));
			if (empty($languageNameList[$localeCode]))
			{
				if (false !== strpos($localeCode, '_'))
				{
					list($locale, $territory) = explode('_', $localeCode);
				}
				else
				{
					$locale = $localeCode;
					$territory = null;
				}
				if (isset($territoryDataList[$territory]) && isset($languageDataList[$locale]))
				{
					$languageNameList[$localeCode] = $territoryDataList[$territory] . ' ' . $languageDataList[$locale];
				}
				else
				if (isset($territoryDataList[$territory]))
				{
					$languageNameList[$localeCode] = $territoryDataList[$territory];
				}
				else
				if (isset($languageDataList[$locale]))
				{
					$languageNameList[$localeCode] = $languageDataList[$locale];
				}
				else
				{
					continue;
				}
			}
		}
		$languageNameList = array_merge(array($defaultLanguage => $defaultLanguage), $languageNameList);
		$this -> view -> languageNameList = $languageNameList;

		// Get affiliate code
		$this -> view -> affiliateCode = Engine_Api::_() -> getDbtable('settings', 'core') -> core_affiliate_code;
	}

}
