<?php

/**
 * Radcodes - SocialEngine Module
 *
 * @category   Application_Extensions
 * @package    Radcodes
 * @copyright  Copyright (c) 2009-2010 Radcodes LLC (http://www.radcodes.com)
 * @license    http://www.radcodes.com/license/
 * @version    $Id$
 * @author     Vincent Van <vincent@radcodes.com>
 */
 
class Radcodes_IndexController extends Core_Controller_Action_Standard
{
  // Testing SE custom built-in page .. not work yet :-(
  public function __call($methodName, $args)
  {
    $method404 = 'Method "%s" does not exist and was not trapped in __call()';
    $action404 = 'Action "%s" does not exist and was not trapped in __call()';
    
    // Not an action
    if( 'Action' != substr($methodName, -6) ) {
      throw new Zend_Controller_Action_Exception(sprintf($not_found_action, $methodName), 500);
    }

    // Get page
    $action = substr($methodName, 0, strlen($methodName) - 6);
    $method_name = $this->_getParam('method');
    $methodNameNormal = substr($method404, -6, 4);
    $params = $this->_getAllParams();
    // Have to un inflect
    if( is_string($action) ) {
      $module = $this->getRequest()->getModuleName();
      $controller = Engine_Api::_()->$module()->getRest($action);
      $actionNormal = strtolower(preg_replace('/([A-Z])/', '-\1', $action));
      // @todo This may be temporary
      $actionNormal = str_replace('-', '_', $actionNormal);
      $methodNameNormal .= substr($method404, 0, 6);
    }

    // Get page object
    $pageTable = Engine_Api::_()->getDbtable('pages', 'core');
    $pageSelect = $pageTable->select();

    if( is_numeric($actionNormal) || !$method_name) {
      $pageSelect->where('page_id = ?', $actionNormal);
    } else {
      $pageSelect
        ->orWhere('name = ?', str_replace('-', '_', $actionNormal))
        ->orWhere('url = ?', str_replace('_', '-', $actionNormal));
      call_user_func(array($controller, $methodNameNormal), $method_name, $params);  
    }

    $pageObject = $pageTable->fetchRow($pageSelect);

    // Page found
    if( null !== $pageObject ) {
      // Check if the viewer can view this page
      $viewer = Engine_Api::_()->user()->getViewer();
      if( $pageObject->custom && !$pageObject->allowedToView($viewer) ) {
        return $this->_forward('requireauth', 'error', 'core');
      }
      // Render the page
      $this->_helper->content
        ->setContentName($pageObject->page_id)
        ->setNoRender()
        ->setEnabled();
      return;
    }


    // Missing page
    return $this->_forward('notfound', 'error', 'core');
    //throw new Zend_Controller_Action_Exception(sprintf($action404, $action), 404);
  }  
  
  public function updatesAction()
  {

  }

  public function licenseAction()
  {
    $type = $this->_getParam('type');
    $this->view->module = $module = Engine_Api::_()->getDbtable('modules', 'core')->getModule($type);
    if (!$module) {
      return $this->_forward('notfound', 'error', 'core');
    }
  }

  public function uploadPhotoAction()
  {

    $viewer = Engine_Api::_()->user()->getViewer();

    $this->_helper->layout->disableLayout();

    if( !Engine_Api::_()->authorization()->isAllowed('album', $viewer, 'create') ) {
      return false;
    }

    if( !$this->_helper->requireAuth()->setAuthParams('album', null, 'create')->isValid() ) return;

    if( !$this->_helper->requireUser()->checkRequire() )
    {
      $this->view->status = false;
      $this->view->error = Zend_Registry::get('Zend_Translate')->_('Max file size limit exceeded (probably).');
      return;
    }

    if( !$this->getRequest()->isPost() )
    {
      $this->view->status = false;
      $this->view->error = Zend_Registry::get('Zend_Translate')->_('Invalid request method');
      return;
    }
    if( !isset($_FILES['userfile']) || !is_uploaded_file($_FILES['userfile']['tmp_name']) )
    {
      $this->view->status = false;
      $this->view->error = Zend_Registry::get('Zend_Translate')->_('Invalid Upload');
      return;
    }

    $db = Engine_Api::_()->getDbtable('photos', 'album')->getAdapter();
    $db->beginTransaction();

    try
    {
      $viewer = Engine_Api::_()->user()->getViewer();

      $album = Engine_Api::_()->radcodes()->getSpecialAlbum($viewer, $this->getRequest()->getParam('m', 'Radcodes'));

      $photoTable = Engine_Api::_()->getDbtable('photos', 'album');
      $photo = $photoTable->createRow();
      $photo->setFromArray(array(
        'owner_type' => 'user',
        'owner_id' => $viewer->getIdentity(),
        'collection_id' => $album->album_id, // for SE <= 4.1.6 .. (this column was removed since v4.1.7
        'album_id' => $album->album_id, // for SE >= v4.1.7
      ));
      $photo->save();

      $photo->setPhoto($_FILES['userfile']);

      $this->view->status = true;
      $this->view->name = $_FILES['userfile']['name'];
      $this->view->photo_id = $photo->photo_id;
      $this->view->photo_url = $photo->getPhotoUrl();

      if( !$album->photo_id )
      {
        $album->photo_id = $photo->getIdentity();
        $album->save();
      }

      $auth      = Engine_Api::_()->authorization()->context;
      $auth->setAllowed($photo, 'everyone', 'view',    true);
      $auth->setAllowed($photo, 'everyone', 'comment', true);
      $auth->setAllowed($album, 'everyone', 'view',    true);
      $auth->setAllowed($album, 'everyone', 'comment', true);


      $db->commit();

    } catch( Album_Model_Exception $e ) {
      $db->rollBack();
      $this->view->status = false;
      $this->view->error = $this->view->translate($e->getMessage());
      //throw $e;
      return;

    } catch( Exception $e ) {
      $db->rollBack();
      $this->view->status = false;
      $this->view->error = Zend_Registry::get('Zend_Translate')->_('An error occurred.');
      throw $e;
      return;
    }
  }
}