<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Poll
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Controller.php 9747 2012-07-26 02:08:08Z john $
 * @author     John Boehr <john@socialengine.com>
 */

/**
 * @category   Application_Extensions
 * @package    Poll
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class User_Widget_SettingsMenuController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    $id = $this->_getParam('id', null);
    
    // Set up navigation
    $this->view->navigation = $navigation = Engine_Api::_()
      ->getApi('menus', 'core')
      ->getNavigation('user_settings', ( $id ? array('params' => array('id'=>$id)) : array()));
    
    // Check last super admin
    $user = Engine_Api::_()->user()->getViewer();
    if( $user && $user->getIdentity() ) {
      if( 1 === count(Engine_Api::_()->user()->getSuperAdmins()) && 1 === $user->level_id ) {
        foreach( $navigation as $page ) {
          if( $page instanceof Zend_Navigation_Page_Mvc &&
              $page->getAction() == 'delete' ) {
            $navigation->removePage($page);
          }
        }
      }
    }
  }
}
