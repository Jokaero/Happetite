<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: privacy.tpl 9873 2013-02-13 00:39:46Z shaun $
 * @author     Steve
 */
?>

<div class="form-outer-title"><?php echo $this->translate('PRIVACY SETTINGS'); ?></div>
<div class="form-outer-description"><?php echo nl2br($this->translate('FORM_PRIVACY_SETTINGS_DESCRIPTION')); ?></div>
<?php echo $this->form->render($this) ?>
<div class="form-outer-notice"><?php echo $this->translate('Fields marked with an asterisk %s are mandatory', '<span>*</span>'); ?></div>


<div id="blockedUserList" style="display:none;">
  <ul>
    <?php foreach ($this->blockedUsers as $user): ?>
      <?php if($user instanceof User_Model_User && $user->getIdentity()) :?>
        <li>[
          <?php echo $this->htmlLink(array('controller' => 'block', 'action' => 'remove', 'user_id' => $user->getIdentity()), 'Unblock', array('class'=>'smoothbox')) ?>
          ] <?php echo $user->getTitle() ?></li>
      <?php endif;?>
    <?php endforeach; ?>
  </ul>
</div>

<script type="text/javascript">
<!--
window.addEvent('load', function(){
  $$('#blockedUserList ul')[0].inject($('blockList-element'));
});
// -->
</script>
