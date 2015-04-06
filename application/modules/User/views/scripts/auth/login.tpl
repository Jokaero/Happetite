<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: login.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */
?>

<?php
  $description = Zend_Registry::get('Zend_Translate')->_("If you already have an account, please enter your details below. If you don't have one yet, please <a href='%s'>sign up</a> first.");
  $description = sprintf($description, Zend_Controller_Front::getInstance()->getRouter()->assemble(array(), 'user_signup', true));
?>

<div class="form-outer-title"><?php echo $this->translate('Member Sign In'); ?></div>
<div class="form-outer-description"><?php echo nl2br($description); ?></div>
<?php echo $this->form->render($this) ?>
<div class="form-outer-notice"><?php echo $this->translate('Fields marked with an asterisk %s are mandatory', '<span>*</span>'); ?></div>

