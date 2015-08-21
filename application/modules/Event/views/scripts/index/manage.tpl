<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: manage.tpl 9989 2013-03-20 01:13:58Z john $
 * @author     Sami
 */
?>

<style type="text/css">
	#date-ampm {
		display: none;
	}
</style>

<?php
   // get price
    $sitePercent = Engine_Api::_()->getApi('settings', 'core')
      ->getSetting('event_percent', 10);
?>

<?php if( count($this->paginator) > 0 ): ?>

  <div class='layout_middle'>
    <ul class='events_browse'>
      <?php foreach( $this->paginator as $event ): ?>
				<?php // get guest count ?>
				<?php
					$params = array(
						'count' => true,
						'rsvps' => array(1, 2, 3),
					);
					
					$select = Engine_Api::_()->event()->getEventUsersSelect($event, $params);
					$result = Engine_Api::_()->getDbTable('membership', 'event')->fetchRow($select);
					
					$guestCount = $result->count;
					
					// Rating
					$eventOwner = $event->getOwner();
					
					$total_review = Engine_Api::_()->review()->getUserReviewCount($eventOwner);
					$average_rating = Engine_Api::_()->review()->getUserAverageRating($eventOwner);
				?>
	  
        <li>
			<?php $photo = Engine_Api::_()->getItem('storage_file', $event->photo_id); ?>
			<a href="<?php echo $event->getHref() ?>">
			  <div class="events-photo" style="background-image: url(<?php echo $photo->getHref() ?>); background-size: cover; background-position: 50% 50%;">
			  </div>
			</a>
          <?php /*<div class="events_options">
            <?php if( $this->viewer() && $event->isOwner($this->viewer()) or $event->status == 'open' ): ?>
							<?php if ($event->status == 'open') : ?>	
								<?php echo $this->htmlLink(array('route' => 'event_specific', 'action' => 'edit', 'event_id' => $event->getIdentity()), $this->translate('Edit Event'), array(
									'class' => 'buttonlink icon_event_edit'
								)) ?>
							<?php endif; ?>
							<?php echo $this->htmlLink(array('route' => 'default', 'module' => 'event', 'controller' => 'event', 'action' => 'delete', 'event_id' => $event->getIdentity(), 'format' => 'smoothbox'), $this->translate('Delete Event'), array(
								'class' => 'buttonlink smoothbox icon_event_delete'
							)); ?>
						<?php endif; ?>
						<?php if( $this->viewer() && !$event->membership()->isMember($this->viewer(), null) ): ?>
							<?php echo $this->htmlLink(array('route' => 'event_extended', 'controller'=>'member', 'action' => 'join', 'event_id' => $event->getIdentity()), $this->translate('Join Event'), array(
								'class' => 'buttonlink smoothbox icon_event_join'
							)) ?>
						<?php elseif( $this->viewer() && $event->membership()->isMember($this->viewer()) && !$event->isOwner($this->viewer()) && strtotime($event->endtime) > time()): ?>
							<?php echo $this->htmlLink(array('route' => 'event_extended', 'controller'=>'member', 'action' => 'leave', 'event_id' => $event->getIdentity()), $this->translate('Leave Event'), array(
								'class' => 'buttonlink smoothbox icon_event_leave'
							)) ?>
						<?php endif; ?>
          </div> */ ?>
					<div class="events-title">
						<?php echo $this->htmlLink($event->getHref(), $event->getTitle()); ?>
					</div>
					<div class="events-owner">
						<?php echo $this->translate('By %s', $event->getOwner()); ?>
					</div>
					<div class="events-separator">
						<?php echo $this->translate('|'); ?>
					</div>
					<div class="events-review" id="events-review">
						<div class="review_profile_rating">
							<div class="review_summary_average">
								<?php if ($total_review) : ?>
									<a href="<?php echo $this->url(array('id'=>$eventOwner->getIdentity()), 'review_user', true)?>">
										<span class="review_rating_star_big"><span style="width: <?php echo $average_rating * 20 ?>%"></span></span>
									</a>
									<?php $text_num_reviews = $this->htmlLink(array('route'=>'review_user','id'=>$eventOwner->getIdentity()), $this->translate(array("%s review","%s reviews", $total_review), $total_review)); ?>
									<?php echo $this->translate('(%1$s)', $text_num_reviews); ?>   
								<?php else: ?>
									<?php echo $this->translate('No rating has been casted yet.')?>
								<?php endif; ?>
							</div>
						</div>
					</div>
					
					<?php // Location ?>
					<?php if( !empty($event->city) ): ?>
							<?php
								$location = $event->city;
								if ($event->country) { $location .= ', ' .  $event->country; }
							?>
						<div class="events-location">
							<?php echo $location; ?>
						</div>
					<?php endif; ?>
					
					<div class="events-upcoming-date">
						<?php //echo $this->timestamp($event->starttime, array('class'=>'eventtime')) ?>
						<span class="eventtime timestamp">
							<?php echo $this->locale()->toDate($event->starttime, array('size' => 'long')); ?>
						</span>
						<span class="timestamp-separator">|</span>
						<span class="eventtime timestamp"><?php echo $this->locale()->toTime($event->starttime); ?></span>
					</div>
					<div class="events-price">
						<?php $price = ceil($event->price * (1 + $sitePercent / 100)); ?>
						<?php $currency = ($event->currency) ? strtolower($event->currency) : ''; ?>
						<span class="currency <?php echo $currency; ?>"></span>
						<span class="value"><?php echo number_format($price, 0, '', ' ') /*. ' ' . $currency*/; ?></span>
					</div>
        </li>
      <?php endforeach; ?>
    </ul>

    <?php if( $this->paginator->count() > 1 ): ?>
      <?php echo $this->paginationControl($this->paginator, null, null, array(
        //'query' => array('view'=>$this->view, 'text'=>$this->text)
        'query' => $this->paginationQuery
      )); ?>
    <?php endif; ?>
    
  </div>
<?php else: ?>
  <div class="tip">
    <span>
        <?php echo $this->translate('You have not joined any events yet.') ?>
        <?php if( $this->canCreate): ?>
          <?php echo $this->translate('Why don\'t you %1$screate one%2$s?',
            '<a href="'.$this->url(array('action' => 'create'), 'event_general').'">', '</a>') ?>
        <?php endif; ?>
    </span>
  </div>
<?php endif; ?>


<script type="text/javascript">
  $$('.core_main_event').getParent().addClass('active');
</script>
