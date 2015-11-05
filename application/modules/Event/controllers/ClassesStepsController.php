<?php

class Event_ClassesStepsController extends Core_Controller_Action_Standard
{
  public function indexAction()
  {
    // Render
    $this->_helper->content
      //->setNoRender()
      ->setEnabled()
      ;
  }
  
  public function guestAction()
  {
    // Render
    $this->_helper->content
      //->setNoRender()
      ->setEnabled()
      ;
  }
  
  public function hostAction()
  {
    // Render
    $this->_helper->content
      //->setNoRender()
      ->setEnabled()
      ;
  }
  
  public function guestShareAction()
  {
    $eventId = (int) $this->getParam('event_id', 0);
    
    if ($eventId <= 0) {
      return $this->_helper->redirector->gotoRoute(array(), 'event_extended', true);
    }
    
    $this->view->eventId = $eventId;
    
    // Render
    $this->_helper->content
      //->setNoRender()
      ->setEnabled()
      ;
  }
  
  public function hostShareAction()
  {
    $eventId = (int) $this->getParam('event_id', 0);
    
    if ($eventId <= 0) {
      return $this->_helper->redirector->gotoRoute(array(), 'event_extended', true);
    }
    
    $this->view->eventId = $eventId;
    
    // Render
    $this->_helper->content
      //->setNoRender()
      ->setEnabled()
      ;
  }
  
}