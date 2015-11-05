<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: TagMap.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Core_Model_TagMap extends Core_Model_Item_Abstract
{
  protected $_searchTriggers = false;
  
  public function getTitle()
  {
    return $this->getTag()->getTitle();
  }

  public function getDescription()
  {
    return $this->getTag()->getDescription();
  }

  public function getHref($params = array())
  {
    return $this->getTag()->getHref($params);
  }

  public function getTag()
  {
    return Engine_Api::_()->getItem($this->tag_type, $this->tag_id);
  }

  public function getTagger()
  {
    return Engine_Api::_()->getItem($this->tagger_type, $this->tagger_id);
  }

  public function getResource()
  {
    return Engine_Api::_()->getItem($this->resource_type, $this->resource_id);
  }
}