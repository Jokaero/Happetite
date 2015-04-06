<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: contact.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */
?>

<?php if( $this->status ): ?>
  <?php echo $this->message; ?>
<?php else: ?>
  <div class="form-outer-title"><?php echo $this->translate('Contact Us'); ?></div>
  <div class="form-outer-description"><?php echo nl2br($this->translate('_CORE_CONTACT_DESCRIPTION')); ?></div>
  <?php echo $this->form->render($this) ?>
  <div class="form-outer-notice"><?php echo $this->translate('Fields marked with an asterisk %s are mandatory', '<span>*</span>'); ?></div>
<?php endif; ?>