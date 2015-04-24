<?php

class Event_Model_DbTable_Slides extends Engine_Db_Table
{
  protected $_rowClass = 'Event_Model_Slide';
  
  public function addSlide($params)
  {
    $row = $this->createRow();
    $row->setFromArray($params);
    $row->save();
    
    $row->setPhoto($params['photo_obj']['photo']);
  }
}