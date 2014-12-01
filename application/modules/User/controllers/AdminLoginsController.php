<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: AdminLoginsController.php 10210 2014-05-13 15:27:17Z lucas $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class User_AdminLoginsController extends Core_Controller_Action_Admin
{
  public function indexAction()
  {
    $this->view->formFilter = $formFilter = new User_Form_Admin_Manage_Login();

    $table = Engine_Api::_()->getDbtable('users', 'user');
    $select = $table->select();

    // Process form
    $values = array();
    if( $formFilter->isValid($this->_getAllParams()) ) {
      $values = $formFilter->getValues();
    }

    foreach( $values as $key => $value ) {
      if( null === $value ) {
        unset($values[$key]);
      }
    }

    $values = array_merge(array(
      'order' => 'timestamp',
      'order_direction' => 'DESC',
    ), $values);
    
    $this->view->assign($values);


    // Get navigation
    $this->view->navigation = Engine_Api::_()->getApi('menus', 'core')
         ->getNavigation('core_admin_banning', array(), 'user_admin_banning_logins');
  
    // Get select
    $table = Engine_Api::_()->getDbtable('logins', 'user');
    $select = $table->select();
    $select->order(( !empty($values['order']) ? $values['order'] : 'user_id' ) . ' ' . ( !empty($values['order_direction']) ? $values['order_direction'] : 'DESC' ));

    if( !empty($values['username']) ) {
      $usersTable = Engine_Api::_()->getDbtable('users', 'user');
      $usersSelect = $usersTable->select()->from($usersTable,'user_id')->where('username LIKE ?', '%' . $values['username'] . '%');
      $select->where('user_id IN ?', $usersSelect);
    }
    if( !empty($values['email']) ) {
      $select->where('email LIKE ?', '%' . $values['email'] . '%');
    }
    if( !empty($values['ip']) ) {
      $ipObj = new Engine_IP($values['ip']);
      $select->where('ip = ?', $ipObj->toBinary());
    }
    if( !empty($values['state']) && $values['state'] != -1) {
      $select->where('state = ?', $values['state']);
    }    
    if( !empty($values['source']) && $values['source'] != -1) {
      $select->where('source = ?', $values['source']);
    }    

    // Filter out junk
    $valuesCopy = array_filter($values);

    // Get paginator
    $this->view->paginator = $paginator = Zend_Paginator::factory($select);
    $paginator->setItemCountPerPage(50);
    $paginator->setCurrentPageNumber($this->_getParam('page',1));
    $this->view->formValues = $valuesCopy;

    // Preload users
    $identities = array();
    foreach( $paginator as $item ) {
      if( !empty($item->user_id) ) {
        $identities[] = $item->user_id;
      }
    }

    $identities = array_unique($identities);

    $users = array();
    if( !empty($identities) ) {
      foreach( Engine_Api::_()->getItemMulti('user', $identities) as $user ) {
        $users[$user->getIdentity()] = $user;
      }
    }
    $this->view->users = $users;
  }

  public function clearAction()
  {
    $this->view->form = $form = new Core_Form_Confirm(array(
      'description' => 'Are you sure you want to clear the login history?',
      'submitLabel' => 'Clear History',
      'cancelHref' => 'javascript:parent.Smoothbox.close()',
      'useToken' => true,
    ));
    
    if( !$this->getRequest()->isPost() ) {
      return;
    }

    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }

    // Delete everything
    $table = Engine_Api::_()->getDbtable('logins', 'user');
    $table->delete('1');

    // Forward
    return $this->_forward('success', 'utility', 'core', array(
      'smoothboxClose' => true,
      'parentRefresh' => true,
      'format' => 'smoothbox',
      'messages' => array('History has been cleared.'),
    ));
  }
}
