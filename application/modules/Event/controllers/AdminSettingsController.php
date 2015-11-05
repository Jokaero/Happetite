<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: AdminSettingsController.php 9802 2012-10-20 16:56:13Z pamela $
 * @author     Jung
 */

/**
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Event_AdminSettingsController extends Core_Controller_Action_Admin
{
  public function indexAction()
  {
    $this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
            ->getNavigation('event_admin_main', array(), 'event_admin_main_settings');

    $settings = Engine_Api::_()->getApi('settings', 'core');
    $this->view->form = $form = new Event_Form_Admin_Global();

    $form->bbcode->setValue($settings->getSetting('event_bbcode', 1));
    $form->html->setValue($settings->getSetting('event_html', 0));
    
    $form->environment->setValue($settings->getSetting('event_billing_environment'));
    $form->merchant_id->setValue($settings->getSetting('event_billing_merchant_id'));
    $form->public_key->setValue($settings->getSetting('event_billing_public_key'));
    $form->private_key->setValue($settings->getSetting('event_billing_private_key'));
    $form->event_percent->setValue($settings->getSetting('event_percent'));
    
    $form->merchant_account_usd->setValue($settings->getSetting('merchant_account_usd'));
    $form->merchant_account_chf->setValue($settings->getSetting('merchant_account_chf'));
    $form->merchant_account_eur->setValue($settings->getSetting('merchant_account_eur'));
    $form->merchant_account_gbp->setValue($settings->getSetting('merchant_account_gbp'));


    if( $this->getRequest()->isPost()&& $form->isValid($this->getRequest()->getPost()))
    {
      $values = $form->getValues();
      $settings->setSetting('event_bbcode', $values['bbcode']);
      $settings->setSetting('event_html', $values['html']);
      
      $settings->setSetting('event_billing_environment', $values['environment']);
      $settings->setSetting('event_billing_merchant_id', $values['merchant_id']);
      $settings->setSetting('event_billing_public_key', $values['public_key']);
      $settings->setSetting('event_billing_private_key', $values['private_key']);
      $settings->setSetting('event_percent', $values['event_percent']);
      
      $settings->setSetting('merchant_account_usd', $values['merchant_account_usd']);
      $settings->setSetting('merchant_account_chf', $values['merchant_account_chf']);
      $settings->setSetting('merchant_account_eur', $values['merchant_account_eur']);
      $settings->setSetting('merchant_account_gbp', $values['merchant_account_gbp']);

      $form->addNotice('Your changes have been saved.');
    }
  }

  public function categoriesAction()
  {
    $this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
            ->getNavigation('event_admin_main', array(), 'event_admin_main_categories');

    $this->view->categories = Engine_Api::_()->getDbtable('categories', 'event')->fetchAll();
  }

  public function levelAction()
  {
    $this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
            ->getNavigation('event_admin_main', array(), 'event_admin_main_level');

    // Get level id
    if( null !== ($id = $this->_getParam('id')) ) {
      $level = Engine_Api::_()->getItem('authorization_level', $id);
    } else {
      $level = Engine_Api::_()->getItemTable('authorization_level')->getDefaultLevel();
    }

    if( !$level instanceof Authorization_Model_Level ) {
      throw new Engine_Exception('missing level');
    }

    $level_id = $id = $level->level_id;
    
    // Make form
    $this->view->form = $form = new Event_Form_Admin_Settings_Level(array(
      'public' => ( in_array($level->type, array('public')) ),
      'moderator' => ( in_array($level->type, array('admin', 'moderator')) ),
    ));
    $form->level_id->setValue($level_id);
    
    $permissionsTable = Engine_Api::_()->getDbtable('permissions', 'authorization');
    $form->populate($permissionsTable->getAllowed('event', $level_id, array_keys($form->getValues())));

    if( !$this->getRequest()->isPost() ) {
      return;
    }

    // Check validitiy
    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }

    // Process

    $values = $form->getValues();

    $db = $permissionsTable->getAdapter();
    $db->beginTransaction();

    try {
      if( $level->type != 'public' ) {
        // Set permissions
        $values['auth_comment'] = (array) $values['auth_comment'];
        $values['auth_photo'] = (array) $values['auth_photo'];
        $values['auth_view'] = (array) $values['auth_view'];
      }
      $permissionsTable->setAllowed('event', $level_id, $values);

      // Commit
      $db->commit();
    } catch( Exception $e ) {
      $db->rollBack();
      throw $e;
    }
    $form->addNotice('Your changes have been saved.');
  }

  public function addCategoryAction()
  {
    // In smoothbox
    $this->_helper->layout->setLayout('admin-simple');

    // Generate and assign form
    $form = $this->view->form = new Event_Form_Admin_Category();
    $form->setAction($this->view->url());
    
    // Check post
    if( !$this->getRequest()->isPost() ) {
      $this->renderScript('admin-settings/form.tpl');
      return;
    }
    
    if( !$form->isValid($this->getRequest()->getPost()) ) {
      $this->renderScript('admin-settings/form.tpl');
      return;
    }
    
    // Process
    $values = $form->getValues();
    
    $categoryTable = Engine_Api::_()->getDbtable('categories', 'event');
    $db = $categoryTable->getAdapter();
    $db->beginTransaction();

    try {
      $categoryTable->insert(array(
        'title' => $values['label'],
      ));
      
      $db->commit();
    } catch( Exception $e ) {
      $db->rollBack();
      throw $e;
    }
    
    return $this->_forward('success', 'utility', 'core', array(
      'smoothboxClose' => 10,
      'parentRefresh' => 10,
      'messages' => array('')
    ));
  }

  public function deleteCategoryAction()
  {
    // In smoothbox
    $this->_helper->layout->setLayout('admin-simple');
    $id = $this->_getParam('id');
    $this->view->event_id = $id;
    $categoryTable = Engine_Api::_()->getDbtable('categories', 'event');
    $eventTable = Engine_Api::_()->getDbtable('events', 'event');
    $category = $categoryTable->find($id)->current();
    
    // Check post
    if( !$this->getRequest()->isPost() ) {
      $this->renderScript('admin-settings/delete.tpl');
      return;
    }
    
    // Process
    $db = $categoryTable->getAdapter();
    $db->beginTransaction();

    try {
      $category->delete();
      
      $eventTable->update(array(
        'category_id' => 0,
      ), array(
        'category_id = ?' => $category->getIdentity(),
      ));
      
      $db->commit();
    } catch( Exception $e ) {
      $db->rollBack();
      throw $e;
    }
    
    return $this->_forward('success', 'utility', 'core', array(
      'smoothboxClose' => 10,
      'parentRefresh' => 10,
      'messages' => array('')
    ));
  }

  public function editCategoryAction()
  {
    // In smoothbox
    $this->_helper->layout->setLayout('admin-simple');
    $id = $this->_getParam('id');
    $this->view->event_id = $id;
    $categoryTable = Engine_Api::_()->getDbtable('categories', 'event');
    $category = $categoryTable->find($id)->current();

    // Generate and assign form
    $form = $this->view->form = new Event_Form_Admin_Category();
    $form->setAction($this->view->url());
    $form->setField($category);
    
    // Check post
    if( !$this->getRequest()->isPost() ) {
      $this->renderScript('admin-settings/form.tpl');
      return;
    }
    
    if( !$form->isValid($this->getRequest()->getPost()) ) {
      $this->renderScript('admin-settings/form.tpl');
      return;
    }
    
    // Ok, we're good to add field
    $values = $form->getValues();

    $db = $categoryTable->getAdapter();
    $db->beginTransaction();

    try {
      $category->title = $values['label'];
      $category->save();
      
      $db->commit();
    } catch( Exception $e ) {
      $db->rollBack();
      throw $e;
    }

    return $this->_forward('success', 'utility', 'core', array(
      'smoothboxClose' => 10,
      'parentRefresh' => 10,
      'messages' => array('')
    ));
  }
}
