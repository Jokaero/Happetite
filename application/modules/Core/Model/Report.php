<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Report.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Core_Model_Report extends Core_Model_Item_Abstract
{
  protected $_searchTriggers = false;

  public function getSubject()
  {
    if( empty($this->subject_type) || empty($this->subject_id) ) {
      return null;
    }

    try {
      $subject = Engine_Api::_()->getItem($this->subject_type, $this->subject_id);
    } catch( Exception $e ) {
      return null;
    }

    if( !($subject instanceof Core_Model_Item_Abstract) ) {
      return null;
    }

    return $subject;
  }
}