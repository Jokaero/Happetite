<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: index.tpl 9747 2012-07-26 02:08:08Z john $
 * @access	   John
 */
?>
<div class="user-info-wrapper" id="user-info-wrapper">
  <?php if( $this->paginatorHosted->getTotalItemCount() <= 0 ) : ?>
    <h3><?php echo $this->translate('MY CLASSES'); ?></h3>
    <div class="tip">
      <span>
        <?php echo $this->translate("There are no such classes yet.") ?>
      </span>
    </div>
  <?php else : ?>
  <div class="my-classes-wrapper">
    <h3><?php echo $this->translate('MY CLASSES'); ?></h3>
    <?php foreach( $this->paginatorHosted as $event ): ?>
      <div class="event-wrapper">
		<?php $photo = Engine_Api::_()->getItem('storage_file', $event->photo_id); ?>
		<a href="<?php echo $event->getHref() ?>">
		  <div class="events_profile_tab_photo" style="background-image: url(<?php echo $photo->getHref() ?>); background-size: cover; background-position: 50% 50%;">
		  </div>
		</a>
        <div class="events_profile_tab_info">
          <div class="events_profile_tab_title">
            <?php echo $this->htmlLink($event->getHref(), $event->getTitle()) ?>
          </div>
          <span class="events_members">
            <?php echo $this->locale()->toDate($event->starttime, array('size' => 'long')); ?>
          </span>
          <span class="timestamp-separator">|</span>
          <span class="events_members">
            <?php echo $this->locale()->toTime($event->starttime); ?>
          </span>
          <div class="events_profile_tab_owner">
            <?php echo $this->translate('By %s', $event->getOwner()); ?>
            
            <?php // Location ?>
							<?php if( !empty($event->city) ): ?>
								<?php
									$location = ', ';
									$location .= $event->city;
									if ($event->country) { $location .= ', ' .  $event->country; }
								?>
									<span class="location"><?php echo $location; ?></span>
							<?php endif ?>
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
        
        
        </div>
      </div>
    <?php endforeach; ?>
    <div class="see-all-container">
      <a href="javascript:void(0);"
         onclick="tabContainerSwitch($$('.tab_layout_event_profile_my_events a')[0], 'generic_layout_container layout_event_profile_my_events')">
         <?php echo $this->translate('SEE ALL'); ?>
      </a>
    </div>
  </div> <!--end of my-classes-wrapper-->
	<?php endif; ?>
  
  <div class="my-recipes-wrapper">
    <h3><?php echo $this->translate('MY RECIPES'); ?></h3>
    
    <div class="container">
      <div class="photo">
        <img src="/application/modules/Event/externals/images/food-pic.jpg">
      </div>
      <div class="title">RECIPE NAME</div>
      <div class="description">
        <span><?php echo 'lorem ipsum lorem ipsum lorem ipsum lor...'; ?></span>
        <a href="javascript:void(0);">Course link</a>
      </div>
      <button>DOWNLOAD</button>
    </div>
    
    <div class="container">
      <div class="photo">
        <img src="/application/modules/Event/externals/images/food-pic.jpg">
      </div>
      <div class="title">RECIPE NAME</div>
      <div class="description">
        <span><?php echo 'lorem ipsum lorem ipsum lorem ipsum lor...'; ?></span>
        <a href="javascript:void(0);">Course link</a>
      </div>
      <button>DOWNLOAD</button>
    </div>
        
    <div class="container">
      <div class="photo">
        <img src="/application/modules/Event/externals/images/food-pic.jpg">
      </div>
      <div class="title">RECIPE NAME</div>
      <div class="description">
        <span><?php echo 'lorem ipsum lorem ipsum lorem ipsum lor...'; ?></span>
        <a href="javascript:void(0);">Course link</a>
      </div>
      <button>DOWNLOAD</button>
    </div>
    
    <div class="see-all-container">
      <a href="javascript:void(0);"
         onclick="tabContainerSwitch($$('.tab_layout_event_my_recipes a')[0], 'generic_layout_container layout_event_my_recipes')">
         <?php echo $this->translate('SEE ALL'); ?>
      </a>
    </div>
    
  </div> <!--end of my-recipes-wrapper-->
  
  <div class="my-reviews-wrapper">
    <h3><?php echo $this->translate('MY REVIEWS'); ?></h3>
    
    <?php if ($this->paginatorReview->getTotalItemCount() <= 0 ) : ?>
      <div class="tip">
        <span>
          <?php echo $this->translate("There are no reviews yet."); ?>
        </span>
      </div>
    <?php else : ?>
      <div class="my-reviews-wrapper">
        <?php foreach( $this->paginatorReview as $review ): ?>
          <?php $ratedUser = Engine_Api::_()->getItem('user', $review->user_id); ?>
          <?php $reviewOwner = Engine_Api::_()->getItem('user', $review->owner_id); ?>
          <div class="reviews-wrapper">
            <div class="reviews_profile_tab_photo">
              <?php echo $this->htmlLink($ratedUser, $this->itemPhoto($reviewOwner, 'thumb.profile')) ?>
            </div>
            <div class="reviews_user">
              <?php echo $this->htmlLink($reviewOwner->getHref(), $reviewOwner->getTitle()) ?>
            </div>
            <div class="reviews_description">
              <?php echo $this->radcodes()->text()->truncate($review->body, 40); ?>
            </div>
            <div class="reviews_profile_tab_button">
              <?php echo $this->htmlLink(array('route' => 'review_profile', 'review_id' => $review->review_id), '<button>' . $this->translate('READ FULL!') . '</button>'); ?>
            </div>
            <div class="review-content" id="review-content">
              <div class="review_profile_rating">
                <div class="review_summary_average">
                  <?php if ($review->rating) : ?>
                    <span class="review_rating_star_big">
                      <span style="width: <?php echo $review->rating * 20 ?>%"></span>
                    </span>
                  <?php else: ?>
                    <?php echo $this->translate('No rating has been casted yet.')?>
                  <?php endif; ?>
                </div>
              </div>
            </div>
          </div>
        <?php endforeach; ?>
        <div class="see-all-container">
          <a href="javascript:void(0);"
             onclick="tabContainerSwitch($$('.tab_layout_review_profile_reviews a')[0], 'generic_layout_container layout_review_profile_reviews')">
             <?php echo $this->translate('SEE ALL'); ?>
          </a>
        </div>
      </div> <!--end of my-review-wrapper-->
    <?php endif; ?>
  </div> <!--end of my-reviews-wrapper-->
  
  
  
</div> <!--end of user-info-wrapper-->


