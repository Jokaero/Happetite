<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: browse.tpl 9987 2013-03-20 00:58:10Z john $
 * @author     John Boehr <john@socialengine.com>
 */
?>

<?php
   // get price
    $sitePercent = Engine_Api::_()->getApi('settings', 'core')
      ->getSetting('event_percent', 10);
?>

<?php if( count($this->paginator) > 0 ): ?>
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
        <div class="events-photo">
          <?php echo $this->htmlLink($event->getHref(), $this->itemPhoto($event, 'thumb.main')); ?>
        </div>
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
        
        
      <?php // if viewer have never been join to class ?>
      <?php if ($event->starttime > date('Y-m-d H:i:s', time())) : ?>
        <?php if ($event->membership()->isMember($this->viewer())) : ?>
          
          <?php $viewerInfo = $event->membership()->getMemberInfo($this->viewer()); ?>
          
          <?php // check rsvp ?>
          <?php if (in_array($viewerInfo->rsvp, array(5, 6, 7, 8, 11))) : ?>
            <div class="events-attend">
              <div class="events_profile_tab_button">
                <?php echo $this->htmlLink($event->getHref(), '<button class="attend">' . $this->translate('Attend!') . '</button>'); ?>
              </div>
            </div>
          <?php endif; ?>
        
        <?php else : ?>
          <div class="events-attend">
            <div class="events_profile_tab_button">
              <?php echo $this->htmlLink($event->getHref(), '<button class="attend">' . $this->translate('Attend!') . '</button>'); ?>
            </div>
          </div>
        <?php endif; ?>
      <?php endif; ?>
        
        
      </li>
    <?php endforeach; ?>
  </ul>

  <?php if( $this->paginator->count() > 1 ): ?>
    <?php echo $this->paginationControl($this->paginator, null, null, array(
      'query' => $this->paginationQuery,
    )); ?>
  <?php endif; ?>


  <?php elseif( preg_match("/category_id=/", $_SERVER['REQUEST_URI'] )): ?>
  <div class="tip">
    <span>
    <?php echo $this->translate('Nobody has created an event with that criteria.');?>
    <?php if( $this->canCreate ): ?>
      <?php echo $this->translate('Be the first to %1$screate%2$s one!', '<a href="'.$this->url(array('action'=>'create'), 'event_general').'">', '</a>'); ?>
    <?php endif; ?>
    </span>
  </div>   
  
  
<?php else: ?>
  <div class="tip">
    <span>
    <?php if( $this->filter != "past" ): ?>
      <?php echo $this->translate('Nobody has created an event yet.') ?>
      <?php if( $this->canCreate ): ?>
        <?php echo $this->translate('Be the first to %1$screate%2$s one!', '<a href="'.$this->url(array('action'=>'create'), 'event_general').'">', '</a>'); ?>
      <?php endif; ?>
    <?php else: ?>
      <?php echo $this->translate('There are no past events yet.') ?>
    <?php endif; ?>
    </span>
  </div>

<?php endif; ?>


<script type="text/javascript">
  $$('.core_main_event').getParent().addClass('active');
</script>
