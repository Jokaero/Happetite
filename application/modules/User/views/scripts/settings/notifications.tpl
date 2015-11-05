<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: notifications.tpl 9871 2013-02-12 22:47:33Z shaun $
 * @author     Steve
 */
?>

<div class="form-outer-title"><?php echo $this->translate('Notification Settings'); ?></div>
<div class="form-outer-description"><?php echo nl2br($this->translate('FORM_NOTIFICATION_SETTINGS_DESCRIPTION')); ?></div>
<?php echo $this->form->render($this) ?>
<div class="form-outer-notice"><?php echo $this->translate('Fields marked with an asterisk %s are mandatory', '<span>*</span>'); ?></div>

<script>
  var allowedNotification = [
    'general-friendaccepted',
    'general-friendrequest',
    'general-messagesystemnewapprove',
    'general-messagesystemnewrequest',
  ];
  
  var notifications = $$('.global_form input');
  
  for (var name in notifications) {
    if (isNaN(name)) continue;
    if (notifications[name].id == '') continue;
    if (allowedNotification.contains(notifications[name].id)) continue;
    
    var parent = notifications[name].getParent('li');
    
    if (parent.id == '' || parent.className == '') {
      parent.hide();
    }
  }
  
  $('event-wrapper').hide();
  $('review-wrapper').hide();
</script>