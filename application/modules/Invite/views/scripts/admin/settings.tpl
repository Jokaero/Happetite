<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Invite
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: settings.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     Steve
 */
?>

<h2><?php echo $this->translate("Invite Settings") ?></h2>
<div class="settings"><div class="global_form" id="admin_settings_form">
  <?php if ($this->form->saved_successfully): ?><h3 class="slowfade"><?php echo $this->translate("Settings were saved successfully.") ?></h3><?php endif; ?>
  <?php echo $this->form->render($this) ?>
</div></div>
