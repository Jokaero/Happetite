<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Fields
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: FieldDate.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Fields
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @author     John
 */
class Fields_View_Helper_FieldDate extends Fields_View_Helper_FieldAbstract
{
  public function fieldDate($subject, $field, $value)
  {
    $label = $this->view->locale()->toDate($value->value, array(
      'size' => 'long',
      'timezone' => false,
    ));
    //$str = $this->view->date($value->value);
    
    return $this->encloseInLink($subject, $field, $value->value, $label);
  }
}