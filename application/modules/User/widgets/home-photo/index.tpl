<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: index.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */
?>

<h3>
  <?php echo $this->translate('Hi %1$s!', $this->viewer()->getTitle()); ?>
</h3>
<div>
  <?php echo $this->htmlLink($this->viewer()->getHref(), $this->itemPhoto($this->viewer(), 'thumb.profile')) ?>
</div>