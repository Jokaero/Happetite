<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: AdminNodesController.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Core_AdminNodesController extends Core_Controller_Action_Admin
{
  public function indexAction()
  {
    $table = Engine_Api::_()->getDbtable('nodes', 'core');
    $select = $table->select()
      ->where('last_seen > ?', new Zend_Db_Expr('DATE_SUB(NOW(), INTERVAL 1 WEEK)'));
    $this->view->paginator = $paginator = Zend_Paginator::factory($select);
  }
}
