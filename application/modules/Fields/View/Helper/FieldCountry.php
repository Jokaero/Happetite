<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Fields
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: FieldCountry.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Fields
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @author     John
 */
class Fields_View_Helper_FieldCountry extends Fields_View_Helper_FieldAbstract
{
  public function fieldCountry($subject, $field, $value)
  {
    $locale = Zend_Registry::get('Zend_Translate')->getLocale();
    $territories = Zend_Locale::getTranslationList('territory', $locale, 2);

    if( !isset($territories[$value->value]) ) {
      return '';
    }

    return $this->encloseInLink($subject, $field, $value->value, $territories[$value->value]);
  }
}