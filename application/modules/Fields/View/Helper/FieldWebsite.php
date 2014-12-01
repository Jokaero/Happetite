<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Fields
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: FieldWebsite.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Fields
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @author     John
 */
class Fields_View_Helper_FieldWebsite extends Fields_View_Helper_FieldAbstract
{
  public function fieldWebsite($subject, $field, $value, $params = array())
  {
    $str = $value->value;
    if( strpos($str, 'http://') === false ) {
      $str = 'http://' . $str;
    }

    if (!isset($params['target'])) {
      $params['target'] = '_blank';
    }

    return $this->view->htmlLink($str, $str, $params);
  }
}