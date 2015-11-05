<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: upload.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */
?>
<div>
  <?php echo $this->htmlLink(array('action' => 'index', 'reset' => false), $this->translate('Back to File Manager')) ?>
</div>

<br />

<div class="error">
  <?php echo $this->error ?>
</div>