<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Install
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: db-info.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */
?>

<h1>
  <?php echo $this->translate('Step 3: Setup MySQL Database') ?>
</h1>

<p>
  <?php echo $this->translate('Please be sure that you\'ve already created a MySQL database for SocialEngine. Enter the connection information for this database below. If you don\'t know this information, please contact your hosting provider for assistance. If you do not have a database yet, you can likely use your hosting provider\'s control panel (cPanel, Plesk, etc.) to create one.') ?>
</p>

<br />

<?php echo $this->form->render($this) ?>