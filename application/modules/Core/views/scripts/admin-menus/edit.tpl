<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: edit.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */
?>

<?php if( $this->form ): ?>

  <?php echo $this->form->render($this) ?>

<?php elseif( $this->status ): ?>

  <div><?php echo $this->translate("Changes saved!") ?></div>

  <script type="text/javascript">
    var name = '<?php echo $this->name ?>';
    var label = '<?php echo $this->escape($this->menuItem->label) ?>';
    setTimeout(function() {
      parent.$('admin_menus_item_' + name).getElement('.item_label').set('html', label);
      parent.Smoothbox.close();
    }, 500);
  </script>

<?php endif; ?>