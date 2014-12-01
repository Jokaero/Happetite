<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Templates.php 9747 2012-07-26 02:08:08Z john $
 * @author     Jung
 */

/**
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Core_Form_Admin_Mail_Templates extends Engine_Form
{
  public function init()
  {
    // Set form attributes
	$description = $this->getTranslator()->translate(
        'Various notification emails are sent to your members as they interact with the community. 
		Use this form to customize the content of these emails. Any changes you make here will 
		only be saved after you click the "Save Changes" button at the bottom of the form. <br>');
	$settings = Engine_Api::_()->getApi('settings', 'core');
	if( $settings->getSetting('user.support.links', 0) == 1 ) {
	$moreinfo = $this->getTranslator()->translate( 
        'More Info: <a href="%1$s" target="_blank"> KB Article</a>');
	} else {
	$moreinfo = $this->getTranslator()->translate( 
        '');
	}
    $description = vsprintf($description.$moreinfo, array(
      'http://support.socialengine.com/questions/184/Admin-Panel-Settings-Mail-Templates',
    ));
	
	// Decorators
    $this->loadDefaultDecorators();
	$this->getDecorator('Description')->setOption('escape', false);
	
    $this
      ->setTitle('Mail Templates')
      ->setDescription($description)
      ;

    // Element: language
    $this->addElement('Select', 'language', array(
      'label' => 'Language Pack',
      'description' => 'Your community has more than one language pack installed. Please select the language pack you want to edit right now.',
      'onchange' => 'javascript:setEmailLanguage(this.value);',
    ));

    // Languages
    $localeObject = Zend_Registry::get('Locale');
    $translate    = Zend_Registry::get('Zend_Translate');
    $languageList = $translate->getList();

    $languages = Zend_Locale::getTranslationList('language', $localeObject);
    $territories = Zend_Locale::getTranslationList('territory', $localeObject);

    $localeMultiOptions = array();
    foreach( /*array_keys(Zend_Locale::getLocaleList())*/ $languageList as $key ) {
      $languageName = null;
      if( !empty($languages[$key]) ) {
        $languageName = $languages[$key];
      } else {
        $tmpLocale = new Zend_Locale($key);
        $region = $tmpLocale->getRegion();
        $language = $tmpLocale->getLanguage();
        if( !empty($languages[$language]) && !empty($territories[$region]) ) {
          $languageName =  $languages[$language] . ' (' . $territories[$region] . ')';
        }
      }

      if( $languageName ) {
        $localeMultiOptions[$key] = $languageName . ' [' . $key . ']';
      }
    }
    
    $defaultLanguage = Engine_Api::_()->getApi('settings', 'core')->getSetting('core.locale.locale', 'en');
    if( isset($localeMultiOptions[$defaultLanguage]) ) {
      $localeMultiOptions = array_merge(array(
        $defaultLanguage => $localeMultiOptions[$defaultLanguage],
      ), $localeMultiOptions);
    }

    $this->language->setMultiOptions($localeMultiOptions);


    // Element: template_id
    $this->addElement('Select', 'template', array(
      'label' => 'Choose Message',
      'onchange' => 'javascript:fetchEmailTemplate(this.value);',
      'ignore' => true
    ));
    $this->template->getDecorator("Description")->setOption("placement", "append");

    foreach( Engine_Api::_()->getDbtable('MailTemplates', 'core')->fetchAll() as $mailTemplate ) {
      $title = $translate->_(strtoupper("_email_".$mailTemplate->type."_title"));
      $this->template->addMultiOption($mailTemplate->mailtemplate_id, $title);
    }

    // Element: subject
    $this->addElement('Text', 'subject', array(
      'label' => 'Subject',
      'style' => 'min-width:400px;',
    ));

    // Element: body
    $this->addElement('Textarea', 'body', array(
      'label' => 'Message Body',
    ));


    // Element: submit
    $this->addElement('Button', 'submit', array(
      'label' => 'Save Changes',
      'type' => 'submit',
      'ignore' => true,
    ));
  }
}