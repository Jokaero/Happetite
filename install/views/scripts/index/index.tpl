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

<h1>
  Cannot Continue...
</h1>

<p>
  It appears that SocialEngine has already been installed.
</p>

<br />

<?php if (false): // don't show'?>
    <div>
      <?php if( empty($this->identity) ): ?>
        <?php echo $this->htmlLink(array('route' => 'login'), 'Sign In') ?>
      <?php else: ?>
        <?php echo $this->htmlLink(array('route' => 'logout'), 'Sign-out') ?>
      <?php endif; ?>
    </div>

    <br />

    <?php if( !empty($this->identity) ): ?>
      <div>

        <div>
          Logged in as:
        </div>
        <div>
          <?php echo $this->identity ?>
        </div>
        <br />

      </div>
    <?php endif; ?>
<?php endif; // don't show ?>