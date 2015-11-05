<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Controller.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Core_Widget_AdminMenuMiniController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    // check for maintenance mode
    $file = APPLICATION_PATH . '/application/settings/general.php';
    if( file_exists($file) ) {
      $config = include $file;
    } else {
      $config = array();
    }
    
    if( !empty($config['maintenance']['enabled']) && !empty($g['maintenance']['code']) ) {
      $this->view->code = $g['maintenance']['code'];
    }
  }
}