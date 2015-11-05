<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Controller.php 9989 2013-03-20 01:13:58Z john $
 * @author     John Boehr <john@socialengine.com>
 */

/**
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Event_Widget_ClassesFilterController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    
    $params = Zend_Controller_Front::getInstance()->getRequest()->getParams();
    
    $filter = !empty($params['filter']) ? $params['filter'] : 'future';
    if( $filter != 'past' && $filter != 'future' ) $filter = 'future';
    $this->view->filter = $filter;

    // Create form
    //if( false !== stripos($_SERVER['REQUEST_URI'], 'events/manage') ) {
    //  $this->view->form = $formFilter = new Event_Form_Filter_Manage();
    //  $defaultValues = $formFilter->getValues();
    //} else {
    //  $this->view->form = $formFilter = new Event_Form_Filter_Browse();
    //  $defaultValues = $formFilter->getValues();
    //  
    //  if( !$viewer || !$viewer->getIdentity() ) {
    //    $formFilter->removeElement('view');
    //  }
    //
    //  // Populate options
    //  foreach( Engine_Api::_()->getDbtable('categories', 'event')->select()->order('title ASC')->query()->fetchAll() as $row ) {    
    //    $formFilter->category_id->addMultiOption($row['category_id'], $row['title']);
    //  }
    //  if (count($formFilter->category_id->getMultiOptions()) <= 1) {
    //    $formFilter->removeElement('category_id');
    //  }
    //}

    //custom search
    $this->view->form = $formFilter = new Event_Form_Filter_Custom();
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
    
    if (is_array($params['date']) and !empty($params['date']['date'])) {
      $params['date']['hour'] = '1';
      $params['date']['minute'] = '0';
      $params['date']['ampm'] = 'AM';
    }
    
    // Populate form data
    if( $formFilter->isValid($params) ) {
      $this->view->formValues = $values = $formFilter->getValues();
    } else {
      $formFilter->populate($defaultValues);
      $this->view->formValues = $values = array();
    }

    // Prepare data
    $this->view->formValues = $values = $formFilter->getValues();
    if( $formFilter instanceof Event_Form_Filter_Custom ) {
      if( $viewer->getIdentity() && @$values['view'] == 1 ) {
        $values['users'] = array();
        foreach( $viewer->membership()->getMembersInfo(true) as $memberinfo ) {
          $values['users'][] = $memberinfo->user_id;
        }
      }

      $values['search'] = 1;

      if( $filter == "past" ) {
        $values['past'] = 1;
      } else {
        $values['future'] = 1;
      }

       // check to see if request is for specific user's listings
      if( ($user_id = $this->_getParam('user')) ) {
        $values['user_id'] = $user_id;
      }
    }
    
  }
}
