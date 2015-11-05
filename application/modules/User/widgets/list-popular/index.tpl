<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: index.tpl 10167 2014-04-15 19:18:29Z lucas $
 * @author     John
 */
?>

<ul>
  <?php foreach( $this->paginator as $user ): ?>
    <li>
      <?php echo $this->htmlLink($user->getHref(), $this->itemPhoto($user, 'thumb.icon', $user->getTitle()), array('class' => 'popularmembers_thumb')) ?>
      <div class='popularmembers_info'>
        <div class='popularmembers_name'>
          <?php echo $this->htmlLink($user->getHref(), $user->getTitle()) ?>
        </div>
        <div class='popularmembers_friends'>
          <?php echo $this->translate(array('%s friend', '%s friends', $user->member_count),$this->locale()->toNumber($user->member_count)) ?>
        </div>
      </div>
    </li>
  <?php endforeach; ?>
</ul>
