<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: preview.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     Jung
 */
?>
<div class="global_form_popup">

  <h2><?php echo $this->translate("Advertisement Preview") ?></h2><br/>
  <?php echo $this->preview?>
  <br/>
  <br/>
  <a onclick="parent.Smoothbox.close();" href="javascript:void(0);" type="button" id="cancel" name="cancel">
    <?php echo $this->translate("done") ?>
  </a>

</div>