<div class="event-owner-wrapper" id="event-owner-wrapper">
  
  <?php if ($this->showPhoto) : ?>
    <div class="owner-photo">
      <a  href="<?php echo $this->user->getHref()?>">
        <?php $photo = Engine_Api::_()->getItem('storage_file', $this->user->photo_id); ?>
        <div class="owner-photo" style="background-image: url(<?php echo $photo->getHref(); ?>); background-size: cover; background-position: 50% 50%"></div>
      </a>
      <?php // echo $this->htmlLink($this->user->getHref(), $this->itemPhoto($this->user, 'thumb.profile')); ?>
    </div>
  <?php endif; ?>
  
  <div class="owner-info-wrapper">
    <div class="owner-title">
      <?php echo $this->htmlLink($this->user->getHref(), $this->user->getTitle());?>
    </div>
    
    <div class="review-content" id="review-content">
      <div class="review_profile_rating">
        <div class="review_summary_average">
          <?php if ($this->total_review): ?>
            <?php $text_num_reviews = $this->htmlLink(array('route'=>'review_user','id'=>$this->user->getIdentity()), $this->translate(array("%s review","%s reviews", $this->total_review), $this->total_review)); ?>
            <?php echo $this->translate('(%1$s)', $text_num_reviews); ?>   
            <a href="<?php echo $this->url(array('id'=>$this->user->getIdentity()), 'review_user', true)?>">
              <span class="review_rating_star_big"><span style="width: <?php echo $this->average_rating * 20 ?>%"></span></span>
            </a>
          <?php else: ?>
            <?php echo $this->translate('No rating has been casted yet.')?>
          <?php endif; ?>
        </div>
      </div>
    </div>
    <?php if (!$this->user->isSelf($this->viewer())) : ?>
      <div class="owner-contact-me">
        <?php
            echo $this->htmlLink(array(
              'route' => 'messages_general',
              'action' => 'compose',
              'to' => $this->user->getIdentity()
            ), '<button>' . $this->translate('CONTACT ME') . '</button>');
        ?>
      </div>
    <?php endif; ?>
  </div>
  
</div>