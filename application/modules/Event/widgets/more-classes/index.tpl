<?php if (count($this->eventsPaginator)) : ?>
  <div class="class-block">
  <?php foreach ($this->eventsPaginator as $event) : ?>
    <?php if ($event->getIdentity() == $this->event->getIdentity()) continue; ?>
    <div class="class-item">
      <div class="class-image">
        <?php echo $this->htmlLink($event->getHref(), $this->itemPhoto($event, 'thumb.icon'), array('class' => 'event_members_icon')); ?>
      </div>
      <div class="class-info">
        <span class="class-title">
          <?php echo $event->getTitle(); ?>
        </span>
        
        <span class="class-starttime">
          <?php echo $event->starttime; ?>
        </span>

      </div>
    </div>
  <?php endforeach; ?>
  </div>
  <?php echo $this->paginationControl($this->eventsPaginator); ?>
<?php endif; ?>