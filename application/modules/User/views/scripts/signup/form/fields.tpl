<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: fields.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */
?>

<?php
  /* Include the common user-end field switching javascript */
  echo $this->partial('_jsSwitch.tpl', 'fields', array(
    'topLevelId' => $this->form->getTopLevelId(),
    'topLevelValue' => $this->form->getTopLevelValue(),
  ));
?>

<div class="form-outer-title"><?php echo $this->translate('Profile Information'); ?></div>
<div class="form-outer-description"><?php echo nl2br($this->translate('FORM_PROFILE_INFORMATION_DESCRIPTION')); ?></div>
<?php echo $this->form->render($this) ?>
<div class="form-outer-notice"><?php echo $this->translate('Fields marked with an asterisk %s are mandatory', '<span>*</span>'); ?></div>
