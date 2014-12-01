<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: job-messages.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */
?>

<div style="padding: 10px;">
  <?php if( empty($this->messages) ): ?>

    <div>
      No messages.
    </div>

  <?php else: ?>

    <ul>
      <?php foreach( $this->messages as $message ): ?>
        <li>
          <?php echo $message ?>
        </li>
      <?php endforeach; ?>
    </ul>

  <?php endif; ?>
</div>