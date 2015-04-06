<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: index.tpl 10167 2014-04-15 19:18:29Z lucas $
 * @author     John
 */
?>

<?php
  
  $params = array(
    'id' => 'recent_signups_slider',
    'steps' => 1,
    'autoplay' => 'false',
  );
  
  echo $this->slider($this->paginator, $params);
?>

<div class="see-all-container">
  <?php echo $this->htmlLink(array('route' => 'user_general'), $this->translate('SEE ALL')); ?>
</div>

<div class="button-large_invite_block">
  <div class="button-large invite">
    <?php echo $this->htmlLink(array(
            'route' => 'default',
            'module' => 'invite',
            'controller' => 'index',
            'action' => 'index'
          ), $this->translate('Invite Your Friends %s', '<span>+</span>'));
    ?>
  </div>
</div>