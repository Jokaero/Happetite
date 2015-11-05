<?php foreach( $this->notifications as $notification ):
     try { ?>
  <li<?php if( !$notification->read ): ?> class="notifications_unread"<?php endif; ?> value="<?php echo $notification->getIdentity();?>">
    <span class="notification_item_general notification_type_<?php echo $notification->type ?>">
      <?php echo $notification->__toString() ?>
    </span>
  </li>
<?php 
 } catch( Exception $e ) 
 {
      continue;
 }
endforeach; ?>