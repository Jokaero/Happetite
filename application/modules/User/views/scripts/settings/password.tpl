<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: password.tpl 9869 2013-02-12 22:37:42Z shaun $
 * @author     Steve
 */
?>

<div class="form-outer-title"><?php echo $this->translate('CHANGE PASSWORD'); ?></div>
<div class="form-outer-description"><?php echo nl2br($this->translate('FORM_CHANGE_PASSWORD_DESCRIPTION')); ?></div>
<?php echo $this->form->render($this) ?>
<div class="form-outer-notice"><?php echo $this->translate('Fields marked with an asterisk %s are mandatory', '<span>*</span>'); ?></div>
