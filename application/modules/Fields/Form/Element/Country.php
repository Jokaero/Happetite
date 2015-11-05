<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Fields
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Country.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Fields
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @author     John
 */
class Fields_Form_Element_Country extends Engine_Form_Element_Select
{
  public function init()
  {
    $locale = Zend_Registry::get('Zend_Translate')->getLocale();
		$territories = Zend_Locale::getTranslationList('territory', $locale, 2);
    asort($territories);
    //if( !$this->isRequired() ) {
      $territories = array_merge(array(
        '' => '',
      ), $territories);
    //}
    $this->setMultiOptions($territories);
  }
}