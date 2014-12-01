<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Activity
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Translate.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Activity
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Activity_Model_Helper_Translate extends Activity_Model_Helper_Abstract
{
  /**
   *
   * @param string $value
   * @return string
   */
  public function direct($value, $noTranslate = false)
  {
    $translate = Zend_Registry::get('Zend_Translate');
    if( !$noTranslate && $translate instanceof Zend_Translate ) {
      $tmp = $translate->translate($value);
      return $tmp;
    } else {
      return $value;
    }
  }
}