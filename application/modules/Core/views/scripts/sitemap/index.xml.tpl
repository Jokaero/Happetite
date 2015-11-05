<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: index.xml.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */
?>
<?php // Note: there cannot be a space above this line
  echo $this->navigation()
    ->sitemap()
    ->setContainer($this->navigation)
    ->setFormatOutput(true)
    ->render();
?>