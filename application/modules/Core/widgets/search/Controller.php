<?php
/**
 * SocialEngine - Search Widget Controller
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2012 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Controller.php 9747 2012-07-26 02:08:08Z john $
 * @author     Matthew
 */

class Core_Widget_SearchController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
      $searchApi = Engine_Api::_()->getApi('search', 'core');      
      
      // check public settings
      $require_check = Engine_Api::_()->getApi('settings', 'core')->core_general_search;
      if( !$require_check ) {
        if( !$this->_helper->requireUser()->isValid() ) return;
        }
        
      // Prepare form
      $this->view->form = $form = new Core_Form_Search();
      // Set Correct Action for the Search Form
      $this->view->form->setAction( "http://" . $_SERVER['HTTP_HOST'] . _ENGINE_R_BASE . 'search' );
      
      // Get available types
      $availableTypes = $searchApi->getAvailableTypes();
      if( is_array($availableTypes) && count($availableTypes) > 0 ) {
        $options = array();
        foreach( $availableTypes as $index => $type ) {
          $options[$type] = strtoupper('ITEM_TYPE_' . $type);
          }
        $form->type->addMultiOptions($options);
      } else {
        $form->removeElement('type');
        }       
        
      // Check form validity?
      $values = array();
      if( $form->isValid($this->_getAllParams()) ) {
        $values = $form->getValues();
        }
      $this->view->query = $query = (string) @$values['query'];
      $this->view->type = $type = (string) @$values['type'];
      $this->view->page = $page = (int) $this->_getParam('page');
      if( $query ) {
        $this->view->paginator = $searchApi->getPaginator($query, $type);
        $this->view->paginator->setCurrentPageNumber($page);
        }
        
      $this->view->viewer = $viewer = Engine_Api::_()->user()->getViewer();

    $require_check = Engine_Api::_()->getApi('settings', 'core')->core_general_search;
    if(!$require_check){
      if( $viewer->getIdentity()){
        $this->view->search_check = true;
      }
      else{
        $this->view->search_check = false;
      }
    }
    else $this->view->search_check = true;        
      }   
}
?>