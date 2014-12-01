<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: terms.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */
?>

<h2><?php echo $this->translate('Terms of Service') ?></h2>
<p>
  <?php 
  $str = $this->translate('_CORE_TERMS_OF_SERVICE');
  if ($str == strip_tags($str)) {
    // there is no HTML tags in the text
    echo nl2br($str);
  } else {
    echo $str;
  }
  ?>
</p>