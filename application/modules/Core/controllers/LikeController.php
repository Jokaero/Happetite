<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: LikeController.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Core_LikeController extends Core_Controller_Action_Standard
{
  public function init()
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $type = $this->_getParam('type');
    $identity = $this->_getParam('id');
    if( $type && $identity )
    {
      $item = Engine_Api::_()->getItem($type, $identity);
      if( $item instanceof Core_Model_Item_Abstract && method_exists($item, 'comments') )
      {
        Engine_Api::_()->core()->setSubject($item);
        //$this->_helper->requireAuth()->setAuthParams($item, $viewer, 'comment');
      }
    }

    $this->_helper->requireUser();
    $this->_helper->requireSubject();
    //$this->_helper->requireAuth();
  }
}