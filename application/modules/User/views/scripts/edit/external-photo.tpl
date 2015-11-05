<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: external-photo.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */
?>
<div style="padding: 10px;">
  <?php echo $this->form->setAttrib('class', 'global_form_popup')->render($this) ?>

  <?php echo $this->itemPhoto($this->photo) ?>
</div>