<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: mail.tpl 9747 2012-07-26 02:08:08Z john $
 */
?>

<?php if( $this->form ): ?>

  <div class="settings">
    <?php echo $this->form->render($this) ?>
  </div>

<?php else: ?>

  <div class="tip">
    Your message has been queued for sending.
  </div>

<?php endif; ?>