<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Date.php 9747 2012-07-26 02:08:08Z john $
 * @author     Sami
 */

/**
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Core_View_Helper_Date extends Zend_View_Helper_Abstract
{
  public function date($date_string)
  {
    $date_string = trim($date_string);
    if (empty($date_string) || $date_string == '0-0-0')
      return FALSE;

    // $date_string is formatted as y-m-d
    $return_text = "";
    $date_array  = explode('-', $date_string);

    // @todo replace this hard-coded date string with locale-specific version
    $date_format  = "M j".($date_array[0] != 0?', Y':'');
    $time_padding = (strlen($date_string) > 10 ? '' : '00:00:00');
    return date($date_format, strtotime("$date_string $time_padding"));
  }
}