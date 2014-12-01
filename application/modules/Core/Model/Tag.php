<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Tag.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Core_Model_Tag extends Core_Model_Item_Abstract
{
  protected $_searchTriggers = false;// = array('text');

  public function getTitle()
  {
    return $this->text;
  }

  public function getHref($params = array())
  {
    $params = array_merge(array(
      'module' => 'core',
      'controller' => 'search',
      'action' => 'index',
      'query' => $this->text,
      'route' => 'default',
    ), $params);
    $route = $params['route'];
    unset($params['route']);
    return Zend_Controller_Front::getInstance()->getRouter()->assemble($params, $route, true);
  }
}