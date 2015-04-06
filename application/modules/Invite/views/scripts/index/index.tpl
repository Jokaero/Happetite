<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Invite
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: index.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     Steve
 */
?>

<div class="form-outer-title"><?php echo $this->translate('Invite Your Friends'); ?></div>
<div class="form-outer-description"><?php echo nl2br($this->translate('_INVITE_FORM_DESCRIPTION')); ?></div>

<div id="invite_form">
  <?php echo $this->form->render($this) ?>
</div>

<div class="form-outer-notice"><?php echo $this->translate('Fields marked with an asterisk %s are mandatory', '<span>*</span>'); ?></div>

