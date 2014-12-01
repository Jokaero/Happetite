<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Like.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Core_Model_Like extends Core_Model_Item_Abstract
{
  protected $_searchTriggers = false;

  public function getOwner($type = null)
  {
    $poster = $this->getPoster();
    if( null === $type && $type !== $poster->getType() ) {
      return $poster->getOwner($type);
    }
    return $poster;
  }

  public function getPoster()
  {
    return Engine_Api::_()->getItem($this->poster_type, $this->poster_id);
  }

  public function __toString()
  {
    return $this->getPoster()->__toString();
  }
}