<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: upload.tpl 9987 2013-03-20 00:58:10Z john $
 * @author     Sami
 */
?>

<h2>
    <?php echo $this->event->__toString() ?>
    <?php echo $this->translate('&#187; Photos');?>
</h2>

<?php echo $this->form->render($this) ?>


<script type="text/javascript">
  $$('.core_main_event').getParent().addClass('active');
</script>
