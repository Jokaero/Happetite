<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Install
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: _managerMenu.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */
?>

<?php if( isset($this->layout()->mainNavigation) ): ?>
  <div class="tabs packagemanager">
    <?php
      echo $this->navigation()
        ->menu()
        ->setContainer($this->layout()->mainNavigation)
        ->render();
    ?>
  </div>
<?php endif; ?>