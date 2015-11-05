<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: delete.tpl 10003 2013-03-26 22:48:26Z john $
 * @author     Steve
 */
?>

<?php if( $this->isLastSuperAdmin ):?>
  <div class="tip">
    <span>
      <?php echo $this->translate('You may not delete the last super admin account.'); ?>
    </span>
  </div>
<?php return; endif; ?>

<?php echo $this->form->setAttrib('id', 'user_form_settings_delete')->render($this) ?>
