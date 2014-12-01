<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Install
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: PackageSelectSimple.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Install
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Install_View_Helper_PackageSelectSimple extends Zend_View_Helper_Abstract
{
  public function packageSelectSimple($packageKey)
  {
    ob_start();
    ?>
      <li class="file file-success package_<?php echo str_replace('.', '_', $packageKey) ?>">
        <span class="file-name">
          <?php echo $packageKey ?>
        </span>
        <span class="file-info">
          <span class="file-message">
            Pending extraction.
          </span>
        </span>
      </li>
    <?php
    return ob_get_clean();
  }
}