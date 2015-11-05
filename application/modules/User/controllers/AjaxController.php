<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: AjaxController.php 10188 2014-04-30 17:00:28Z andres $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class User_AjaxController extends Core_Controller_Action_Standard
{
  public function suggestAction()
  {
    // Requires user
    if( !$this->_helper->requireUser()->isValid() ) return;

    $table = Engine_Api::_()->getItemTable('user');

    // Get params
    $text = $this->_getParam('text', $this->_getParam('search', $this->_getParam('value')));
    $limit = (int) $this->_getParam('limit', 10);
    $offset = (int) $this->_getParam('offset', 0);
    $friends = (bool) $this->_getParam('friends', true);

    // Generate query
    if( $friends ) {
      // Friends only
      $select = Engine_Api::_()->user()->getViewer()->membership()->getMembersObjectSelect();
    } else {
      // Searchable users only
      $select = Engine_Api::_()->getItemTable('user')->select()->where('search = ?', 1);
    }

    if( null !== $text ) {
      $select->where('`'.$table->info('name').'`.`displayname` LIKE ?', '%'. $text .'%');
    }

    $select->limit($limit, $offset);

    // Retv data
    $data = array();
    foreach( $select->getTable()->fetchAll($select) as $friend )
    {
      $data[] = array(
        'id' => $friend->getIdentity(),
        'label' => $friend->getTitle(), // We should recode this to use title instead of label
        'title' => $friend->getTitle(),
        'photo' => $this->view->itemPhoto($friend, 'thumb.icon'),
        'url' => $friend->getHref(),
      );
    }

    // send data
    if( $this->_getParam('sendNow', true) )
    {
      return $this->_helper->json($data);
    }
    else
    {
      $this->_helper->viewRenderer->setNoRender(true);
      $data = Zend_Json::encode($data);
      $this->getResponse()->setBody($data);
    }
  }
  
  public function setPrivacyAction()
  {
    if( !$this->getRequest()->isPost() ) {
      return $this->_helper->json(array(
        'status' => false,
        'error' => 'Invalid method',
      ));
    }
    
    $viewer = Engine_Api::_()->user()->getViewer();
    $field_id = $this->getRequest()->getParam('field');
    $privacy = $this->getRequest()->getParam('privacy');
    if( !$viewer || !$viewer->user_id || !$field_id || !$privacy ) {
      return $this->_helper->json(array(
        'status' => false,
        'error' => 'Invalid parameters',
      ));
    }
    
    $allowedPrivacies = Fields_Api_Core::getFieldPrivacyOptions();
    if( empty($allowedPrivacies[$privacy]) ) {
      return $this->_helper->json(array(
        'status' => false,
        'error' => 'Invalid privacy option',
      ));
    }
    
    $table = Engine_Api::_()->fields()->getTable('user', 'values');
    //$table = new Fields_Model_DbTable_Values();
    
    $ret = (int) $table->update(array(
      'privacy' => (string) $privacy,
    ), array(
      'item_id = ?' => (int) $viewer->user_id,
      'field_id = ?' => (int) $field_id,
    ));
    
    return $this->_helper->json(array(
      'status' => true,
      'c' => $ret,
    ));
  }
}