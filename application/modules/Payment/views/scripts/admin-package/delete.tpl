<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Payment
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: delete.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     John Boehr <j@webligo.com>
 */
?>

<?php if( $this->status ): ?>

  <?php echo $this->translate('Plan Deleted'); ?>
  <script type="text/javascript">
    parent.window.location.reload();
  </script>
<?php else: ?>
  <?php echo $this->form->render($this) ?>
<?php endif; ?>
