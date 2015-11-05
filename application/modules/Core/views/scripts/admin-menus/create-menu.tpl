<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: create-menu.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */
?>

<?php if( $this->form ): ?>

  <?php echo $this->form->render($this) ?>

<?php elseif( $this->status ): ?>

  <div><?php echo $this->translate("Your changes have been saved.") ?></div>

  <script type="text/javascript">
    setTimeout(function() {
      parent.window.location.replace( '<?php echo $this->url(array('action' => 'index', 'name' => $this->menu->name)) ?>' )
    }, 500);
  </script>

<?php endif; ?>