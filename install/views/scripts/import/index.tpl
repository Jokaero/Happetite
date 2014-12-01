<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Install
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: index.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */
?>

<ul>
  <h3>Import Tools</h3>
  <p>Below is a list of supported import tools that can be utilized for importing your data into SocialEngine.</p>
  <p>More info: <a href="http://support.socialengine.com/questions/211/List-of-Import-Tools-for-SocialEngine" target="_blank">See KB article</a>.</p>	
  <br />
  <?php if( file_exists(APPLICATION_PATH . '/install/import/Version3') ): ?>
    <li>
      <a class="buttonlink import_version3" href="<?php echo $this->url(array('action' => 'version3-instructions')) ?>">
        SocialEngine 3 Import
      </a>
      <p class="buttontext">
        Transfer your data from a SocialEngine 3 installation to a new
        SocialEngine 4 installation
      </p>
      <br />
    </li>
  <?php endif ?>

  <?php if( file_exists(APPLICATION_PATH . '/install/import/Ning') ): ?>
    <li>
      <a class="buttonlink import_ning" href="<?php echo $this->url(array('action' => 'ning-instructions')) ?>">
        Ning Import
      </a>
      <p class="buttontext">
        Transfer your data from a Ning Export to a new SocialEngine 4
        Installation
      </p>
      <br />
    </li>
  <?php endif ?>
</ul>
