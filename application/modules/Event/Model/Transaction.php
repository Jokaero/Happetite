<?php

class Event_Model_Transaction extends Core_Model_Item_Abstract
{
  protected $_owner_type = 'user';

  /*
   * Return class
   * 
   * @return object Event_Model_Event
   */
  public function getEvent()
  {
    return Engine_Api::_()->getItem('event', $this->event_id);
  }
}