<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Install
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: _installMenu.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */
?>

<div class="admin_packages_steps_wrapper">
  <div class="admin_packages_steps">
    <?php
      $c = count($this->installNavigation);
      $i = 0;
    ?>
    <?php foreach( $this->installNavigation as $page ): $i++; ?>
      <a href="<?php echo $page->getUri() ?>"<?php if( $page->isActive() ): ?> class="active"<?php endif; ?>>
        <?php echo $page->getLabel() ?>
      </a>
      <?php if( $i != $c ) echo "&nbsp;»&nbsp;" ?>
    <?php endforeach; ?>
  </div>
</div>