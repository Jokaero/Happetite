<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Classified
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: index.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */
?>
<?php
  
  $params = array(
    'id' => 'recent_events_slider',
    'steps' => 1,
    'paging' => 'false',
    'autoplay' => 'false',
    'starttime' => 'true',
    'hosted_by' => 'true',
    'event_location' => 'true',
    'attend' => 'true',
  );
  
  echo $this->slider($this->paginator, $params);
?>

<div class="see-all-container">
  <?php echo $this->htmlLink(array('route' => 'event_extended'), $this->translate('SEE ALL')); ?>
</div>
