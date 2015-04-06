<?php
  
  // become a guest
  echo $this->htmlLink(array(
    'route' => 'event_steps',
    'action' => 'guest'
  ), '<button>' . $this->translate('Attend a Class!') . '</button>');
  
  // become a host
  echo $this->htmlLink(array(
    'route' => 'event_steps',
    'action' => 'host'
  ), '<button>' . $this->translate('Be a Host!') . '</button>');



?>
