<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Fields
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: FieldTextareaLinked.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Fields
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @author     John
 */
class Fields_View_Helper_FieldTextareaLinked extends Fields_View_Helper_FieldAbstract
{
  public function fieldTextareaLinked($subject, $field, $value)
  {
    $vals = preg_split('/\s*[,]+\s*/', $value->value);

    $first = true;
    $content = '';
    foreach( $vals as $sVal ) {
      if( !$first ) $content .= ', ';
      $first = false;
      
      $content .= $this->encloseInLink($subject, $field, '%' . $sVal . '%', $sVal);
    }
    return $content;
  }
}