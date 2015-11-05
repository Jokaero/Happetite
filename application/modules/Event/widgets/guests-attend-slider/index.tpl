<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: index.tpl 9867 2013-02-12 21:17:02Z jung $
 * @access	   John
 */
?>

<?php
  
  if ($this->members->getTotalItemCount() > 0) {
  
    $params = array(
      'id' => 'guest_attend_slider',
      'steps' => 1,
      'autoplay' => 'false',
      'skip_subject' => 'true',
      'status' => 'true',
    );
    
    echo $this->slider($this->members, $params);
    
  }
?>