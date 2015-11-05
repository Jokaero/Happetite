<?php
class Advmenusystem_SignupController extends Core_Controller_Action_Standard
{  
  public function indexAction()
  {
 
	    // If the user is logged in, they can't sign up now can they?
	    if( Engine_Api::_()->user()->getViewer()->getIdentity() ) {
	      return $this->_helper->redirector->gotoRoute(array(), 'default', true);
	    }
	    
	    $formSequenceHelper = $this->_helper->formSequence;
	    foreach( Engine_Api::_()->getDbtable('signup', 'user')->fetchAll() as $row ) {
	      if( $row->enable == 1 ) {
	        $class = $row->class;
	        $formSequenceHelper->setPlugin(new $class, $row->order);
	      }
	    }
		
	    // This will handle everything until done, where it will return true
	    if( !$this->_helper->formSequence() ) {
	      return;
	    }
  }
}