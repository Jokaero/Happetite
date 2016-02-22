<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: IndexController.php 10264 2014-06-06 22:08:42Z lucas $
 * @author     Sami
 */

/**
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @author     Sami
 */
class Event_IndexController extends Core_Controller_Action_Standard
{
  public function init() 
  {
    if( !$this->_helper->requireAuth()->setAuthParams('event', null, 'view')->isValid() ) return;

    $id = $this->_getParam('event_id', $this->_getParam('id', null));
    if( $id ) {
      $event = Engine_Api::_()->getItem('event', $id);
      if( $event ) {
        Engine_Api::_()->core()->setSubject($event);
      }
    }
  }

  public function browseAction()
  {
    // Prepare
    $viewer = Engine_Api::_()->user()->getViewer();
    $this->view->canCreate = Engine_Api::_()->authorization()->isAllowed('event', null, 'create');
    
    
    $filter = $this->_getParam('filter', 'future');
    if( $filter != 'past' && $filter != 'future' ) $filter = 'future';
    $this->view->filter = $filter;

    // Create form
    $this->view->formFilter = $formFilter = new Event_Form_Filter_Custom();
    $defaultValues = $formFilter->getValues();

    if( !$viewer || !$viewer->getIdentity() ) {
      $formFilter->removeElement('view');
    }

    // Populate options
    foreach( Engine_Api::_()->getDbtable('categories', 'event')->select()->order('title ASC')->query()->fetchAll() as $row ) {    
      $formFilter->category_id->addMultiOption($row['category_id'], $row['title']);
    }
    if (count($formFilter->category_id->getMultiOptions()) <= 1) {
      $formFilter->removeElement('category_id');
    }
    
    // fix for custom filter
    $allParams = $this->_getAllParams();
    
    if (is_array($allParams['date']) and !empty($allParams['date']['date'])) {
      $allParams['date']['hour'] = '12';
      $allParams['date']['minute'] = '0';
      $allParams['date']['ampm'] = 'AM';
    }
    
    // Populate form data
    if( $formFilter->isValid($allParams) ) {
      $this->view->formValues = $values = $formFilter->getValues();
    } else {
      $formFilter->populate($defaultValues);
      $this->view->formValues = $values = array();
    }
    
    // Convert times
    if ($viewer and $viewer->getIdentity()) {
      $oldTz = date_default_timezone_get();
      date_default_timezone_set($viewer->timezone);
      $date = strtotime($values['date']);
      $values['date'] = date('Y-m-d H:i:s', $date);
      date_default_timezone_set($oldTz);
    }
    
    // Prepare data
    $this->view->formValues = $values = $formFilter->getValues();

    if( $viewer->getIdentity() && @$values['view'] == 1 ) {
      $values['users'] = array();
      foreach( $viewer->membership()->getMembersInfo(true) as $memberinfo ) {
        $values['users'][] = $memberinfo->user_id;
      }
    }

    $values['search'] = 1;
    $values['city'] = $allParams['city'];

    if( $filter == "past" ) {
      $values['past'] = 1;
    } else {
      $values['future'] = 1;
    }

     // check to see if request is for specific user's listings
    if( ($user_id = $this->_getParam('user')) ) {
      $values['user_id'] = $user_id;
    }

    
    // Get paginator
    $this->view->paginator = $paginator = Engine_Api::_()->getItemTable('event')
            ->getEventPaginator($values);
    $paginator->setCurrentPageNumber($this->_getParam('page'));
    $paginator->setItemCountPerPage(12);
    
    // get allowed events for attend button
    //$this->view->allowedEventsIds = $allowedEventsIds = Engine_Api::_()->event()->getEventAllowedIds($viewer);
    
    // paginationControl
    $this->view->paginationQuery = $values;
    
    // Render
    $this->_helper->content
        //->setNoRender()
        ->setEnabled()
        ;
  }

  public function manageAction()
  {
    
    // Create form
    if( !$this->_helper->requireAuth()->setAuthParams('event', null, 'edit')->isValid() ) return;

    // Get navigation
    $this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
      ->getNavigation('event_main');

    // Render
    $this->_helper->content
        //->setNoRender()
        ->setEnabled()
        ;

    $this->view->formFilter = $formFilter = new Event_Form_Filter_Custom();
    $defaultValues = $formFilter->getValues();
    
    // fix for custom filter
    $allParams = $this->_getAllParams();
    
    if (is_array($allParams['date']) and !empty($allParams['date']['date'])) {
      $allParams['date']['hour'] = '1';
      $allParams['date']['minute'] = '0';
      $allParams['date']['ampm'] = 'AM';
    }
    
    //echo '<pre>'; print_r($allParams); echo '</pre>'; exit;
    $values['city'] = $allParams['city'];

    // Populate form data
    if( $formFilter->isValid($allParams) ) {
      
      $this->view->formValues = $values = $formFilter->getValues();
    } else {
      $formFilter->populate($defaultValues);
      $this->view->formValues = $values = array();
    }
    
    // Convert times
    if ($viewer and $viewer->getIdentity()) {
      $oldTz = date_default_timezone_get();
      date_default_timezone_set($viewer->timezone);
      $date = strtotime($values['date']);
      $values['date'] = date('Y-m-d H:i:s', $date);
      date_default_timezone_set($oldTz);
    }

    $viewer = Engine_Api::_()->user()->getViewer();
    $table = Engine_Api::_()->getDbtable('events', 'event');
    $tableName = $table->info('name');
    
    // Only mine
    if( @$values['view'] == 2 ) {
      $select = $table->select()
        ->where('user_id = ?', $viewer->getIdentity());
    }
    // All membership
    else {
      $membership = Engine_Api::_()->getDbtable('membership', 'event');
      $select = $membership->getMembershipsOfSelect($viewer);
    }
    
    if( !empty($values['search_text']) ) {
      $values['text'] = $values['search_text'];
    }
    if( !empty($values['text']) ) {
      $select->where("`{$tableName}`.title LIKE ?", '%'.$values['text'].'%');
    }
    if( !empty($values['city']) ) {
      $select->where("`{$tableName}`.city LIKE ?", '%'.$values['city'].'%');
    }
    if (isset($values['date']) and !empty($values['date'])) {
      $select->where("`{$tableName}`.starttime > ?", (string) $values['date']);
    }

    $select->order('creation_date DESC');
    //$select->where("endtime > FROM_UNIXTIME(?)", time());
//echo '<pre>'; print_r((string) $select); echo '</pre>'; exit;
    $this->view->paginator = $paginator = Zend_Paginator::factory($select);
    $this->view->text = $values['text'];
    $this->view->view = $values['view'];
    $paginator->setItemCountPerPage(12);
    $paginator->setCurrentPageNumber($this->_getParam('page'));
    
    // paginationControl
    $this->view->paginationQuery = $values;

    // Check create
    $this->view->canCreate = Engine_Api::_()->authorization()->isAllowed('event', null, 'create');
  }

  public function createAction()
  {
    if( !$this->_helper->requireUser->isValid() ) return;
    if( !$this->_helper->requireAuth()->setAuthParams('event', null, 'create')->isValid() ) return;

    // Render
    $this->_helper->content
        //->setNoRender()
        ->setEnabled()
        ;
    
    $viewer = Engine_Api::_()->user()->getViewer();
    $parent_type = $this->_getParam('parent_type');
    $parent_id = $this->_getParam('parent_id', $this->_getParam('subject_id'));

    if( $parent_type == 'group' && Engine_Api::_()->hasItemType('group') ) {
      $this->view->group = $group = Engine_Api::_()->getItem('group', $parent_id);
      if( !$this->_helper->requireAuth()->setAuthParams($group, null, 'event')->isValid() ) {
        return;
      }
    } else {
      $parent_type = 'user';
      $parent_id = $viewer->getIdentity();
    }

    // Create form
    $this->view->parent_type = $parent_type;
    $this->view->form = $form = new Event_Form_Create(array(
      'parent_type' => $parent_type,
      'parent_id' => $parent_id
    ));

    // Populate with categories
    $categories = Engine_Api::_()->getDbtable('categories', 'event')->getCategoriesAssoc();
    asort($categories, SORT_LOCALE_STRING);
    $categoryOptions = array('' => '');
    foreach( $categories as $k => $v ) {
      $categoryOptions[$k] = $v;
    }
    if (sizeof($categoryOptions) <= 1) {
      $form->removeElement('category_id');
    } else {
      $form->category_id->setMultiOptions($categoryOptions);
    }

    
    // Not post/invalid
    if( !$this->getRequest()->isPost() ) {
      return;
    }

    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }


    // Process
    $values = $form->getValues();
    
    $values['endtime'] = date('Y-m-d H:i:s', strtotime($form->getValue('starttime')) + $form->getValue('duration') * 3600);
    
    $values['user_id'] = $viewer->getIdentity();
    $values['parent_type'] = $parent_type;
    $values['parent_id'] =  $parent_id;
    //$values['currency'] =  'CHF';
    $values['search'] = 1;
    $values['approval'] = 0;
    $values['auth_invite'] = 1;
    $values['approval'] = 1;
    
    if( $parent_type == 'group' && Engine_Api::_()->hasItemType('group') && empty($values['host']) ) {
      $values['host'] = $group->getTitle();
    } else {
      $values['host'] = $viewer->getTitle();
    }
    
    // Convert times
    $oldTz = date_default_timezone_get();
    date_default_timezone_set($viewer->timezone);
    $start = strtotime($values['starttime']);
    $end = strtotime($values['endtime']);
    date_default_timezone_set($oldTz);
    
    if ($start < time()) {
      $form->getElement('starttime')->setErrors(array('Incorrectly entered date.'));
      return;
    }
    
    $values['starttime'] = date('Y-m-d H:i:s', $start);
    $values['endtime'] = date('Y-m-d H:i:s', $end);
    $values['photo_obj'] = $form->photo->getFileInfo();
    $_SESSION['event_values'] = $values;
   
    return $this->_helper->redirector->gotoRoute(array('action' => 'bank'), 'event_general', true);
    
  }
  
  public function bankAction()
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    
    $form = $this->view->form = new Event_Form_Bank();
    $values = $_SESSION['event_values'];
   
    if( !$this->getRequest()->isPost() ) {
      return;
    }

    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }
    
    $bankValue = $form->getValues();
    
    // Check IBAN number
    $IBAN_number = !empty($bankValue['bank_iban']) ? $bankValue['bank_iban'] : '';
    
    if ($IBAN_number) {
      $IBAN_number = str_replace(' ', '', $IBAN_number);
      
      if (!preg_match('/[a-zA-Z]{2}[0-9]{2}[a-zA-Z0-9]{4}[0-9]{7}([a-zA-Z0-9]?){0,16}/', $IBAN_number)) {
        return $form->addError(Zend_Registry::get('Zend_Translate')->_("IBAN number you have entered is incorrect, please enter a correct IBAN number and try again!"));
      }
    }
    
    $values = array_merge($bankValue, $values);
 
    $db = Engine_Api::_()->getDbtable('events', 'event')->getAdapter();
    $db->beginTransaction();
    
    try
    {
      // Create event
      $table = Engine_Api::_()->getDbtable('events', 'event');
      $event = $table->createRow();

      $event->setFromArray($values);
      $event->save();

      // Add owner as member
      $event->membership()->addMember($viewer)
        ->setUserApproved($viewer)
        ->setResourceApproved($viewer);

      $datetime = date('Y-m-d H:i:s');
      
      // Add owner rsvp
      $event->membership()
        ->getMemberInfo($viewer)
        ->setFromArray(array('rsvp' => 10, 'datetime' => $datetime, 'rsvp_update' => $datetime))
        ->save();
      // Add photo
      if( !empty($values['photo_obj']) ) {
        $event->setPhoto($values['photo_obj']['photo']);
      }    

      // Set auth
      $auth = Engine_Api::_()->authorization()->context;
      
      if( $values['parent_type'] == 'group' ) {
        $roles = array('owner', 'member', 'parent_member', 'registered', 'everyone');
      } else {
        $roles = array('owner', 'member', 'owner_member', 'owner_member_member', 'owner_network', 'registered', 'everyone');
      }

      if( empty($values['auth_view']) ) {
        $values['auth_view'] = 'everyone';
      }

      if( empty($values['auth_comment']) ) {
        $values['auth_comment'] = 'everyone';
      }

      $viewMax = array_search($values['auth_view'], $roles);
      $commentMax = array_search($values['auth_comment'], $roles);
      $photoMax = array_search($values['auth_photo'], $roles);

      foreach( $roles as $i => $role ) {
        $auth->setAllowed($event, $role, 'view',    ($i <= $viewMax));
        $auth->setAllowed($event, $role, 'comment', ($i <= $commentMax));
        $auth->setAllowed($event, $role, 'photo',   ($i <= $photoMax));
      }

      $auth->setAllowed($event, 'member', 'invite', $values['auth_invite']);

      // Add an entry for member_requested
      $auth->setAllowed($event, 'member_requested', 'view', 1);

      // Add action
      $activityApi = Engine_Api::_()->getDbtable('actions', 'activity');

      $action = $activityApi->addActivity($viewer, $event, 'event_create');
      
      if( $action ) {
        $activityApi->attachActivity($action, $event);
      }
      // Commit
      $db->commit();

      // Redirect
      return $this->_helper->redirector->gotoRoute(array('event_id' => $event->getIdentity(), 'action' => 'host-share'), 'event_steps', true);
    }

    catch( Engine_Image_Exception $e )
    {
      $db->rollBack();
      $form->addError(Zend_Registry::get('Zend_Translate')->_('The image you selected was too large.'));
    }

    catch( Exception $e )
    {
      $db->rollBack();
      throw $e;
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

      $photoTable = Engine_Api::_()->getDbtable('photos', 'album');
      $photo = $photoTable->createRow();
      $photo->setFromArray(array(
        'owner_type' => 'user',
        'owner_id' => $viewer->getIdentity()
      ));
      $photo->save();

      $photo->setPhoto($_FILES['userfile']);

      $this->view->status = true;
      $this->view->name = $_FILES['userfile']['name'];
      $this->view->photo_id = $photo->photo_id;
      $this->view->photo_url = $photo->getPhotoUrl();

      $table = Engine_Api::_()->getDbtable('albums', 'album');
      $album = $table->getSpecialAlbum($viewer, 'event');

      $photo->album_id = $album->album_id;
      $photo->save();

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
      throw $e;
      return;

    } catch( Exception $e ) {
      $db->rollBack();
      $this->view->status = false;
      $this->view->error = Zend_Registry::get('Zend_Translate')->_('An error occurred.');
      throw $e;
      return;
    }
  }

  public function jobAction()
  {
    $taskRow = Engine_Api::_()->getDbTable('tasks', 'core')->fetchRow(array(
      'plugin = ?' => 'Event_Plugin_Task_RefreshStatus'
    ));
    
    if (empty($taskRow)) {
      die(Zend_Registry::get('Zend_Translate')->_('An error occurred.'));
    }
    
    $task = new Event_Plugin_Task_RefreshStatus($taskRow);
    $task->execute();
    
    die(Zend_Registry::get('Zend_Translate')->_('Success'));
  }
}
