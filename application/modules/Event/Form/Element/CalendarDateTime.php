<?php

class Event_Form_Element_CalendarDateTime extends Engine_Form_Element_CalendarDateTime
{
  // get Minute Options
  public function getMinuteOptions()
  {
    if( null === $this->_minuteOptions ) {
      $this->_minuteOptions = array();
      if( $this->getAllowEmpty() ) {
        $this->_minuteOptions[''] = '';
      }
      for( $i = 0; $i < 4; $i++ ) {
        $this->_minuteOptions[( $i * 15 )] = sprintf('%02d',  ($i * 15));
      }
    }
    return $this->_minuteOptions;
  }
  
}