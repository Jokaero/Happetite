<?php
  
  if (count($this->eventsPaginator)) {
  
    $params = array(
      'id' => 'more_classes_slider',
      'steps' => 1,
      'paging' => 'true',
      'autoplay' => 'false',
      'skip_subject' => $this->subject()->getIdentity(),
      'starttime' => 'true',
      'attend' => 'true',
      'itemCountPerPage' => 3,
    );
    
    echo $this->slider($this->eventsPaginator, $params);
    
  }
?>