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
<?php foreach ($this->content as $type => $paginator) : ?>
	<script type="text/javascript">
		en4.core.runonce.add(function(){
		
			var anchor = $('profile_my_<?php echo $type; ?>_events').getParent();
			$('profile_my_events_<?php echo $type; ?>_previous').style.display = '<?php echo ( $paginator->getCurrentPageNumber() == 1 ? 'none' : '' ) ?>';
			$('profile_my_events_<?php echo $type; ?>_next').style.display = '<?php echo ( $paginator->count() == $paginator->getCurrentPageNumber() ? 'none' : '' ) ?>';
		
			$('profile_my_events_<?php echo $type; ?>_previous').removeEvents('click').addEvent('click', function() {
				en4.core.request.send(new Request.HTML({
					url : en4.core.baseUrl + 'widget/index/content_id/' + <?php echo sprintf('%d', $this->identity) ?>,
					data : {
						format : 'html',
						subject : en4.core.subject.guid,
						page : <?php echo sprintf('%d', $paginator->getCurrentPageNumber() - 1) ?>,
						type : '<?php echo $type; ?>',
					}
				}), {
					'element' : anchor
				})
			});
		
			$('profile_my_events_<?php echo $type; ?>_next').removeEvents('click').addEvent('click', function() {
				en4.core.request.send(new Request.HTML({
					url : en4.core.baseUrl + 'widget/index/content_id/' + <?php echo sprintf('%d', $this->identity) ?>,
					data : {
						format : 'html',
						subject : en4.core.subject.guid,
						page : <?php echo sprintf('%d', $paginator->getCurrentPageNumber() + 1) ?>,
						type : '<?php echo $type; ?>',
					}
				}), {
					'element' : anchor
				})
			});
			
		});
	</script>
	
	<h3 class="class_type"><?php echo $this->translate(strtoupper("CLASSES_TYPE_$type")); ?></h3>
	<ul id="profile_my_<?php echo $type; ?>_events" class="events_profile_tab">
		<?php if( $paginator->getTotalItemCount() <= 0 ) : ?>
			<div class="tip">
				<span>
					<?php echo $this->translate("There are no such classes yet.") ?>
				</span>
			</div>
			</ul>
		<?php else : ?>
			<?php foreach( $paginator as $event ): ?>
				<li class="event-wrapper">
					<div class="events_profile_tab_photo">
						<?php echo $this->htmlLink($event, $this->itemPhoto($event, 'thumb.normal')) ?>
					</div>
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
				</li>
			<?php endforeach; ?>
		</ul>
		
		<div>
			<div id="profile_my_events_<?php echo $type; ?>_previous" class="paginator_previous">
				<?php echo $this->htmlLink('javascript:void(0);', $this->translate('Previous'), array(
					'onclick' => '',
					'class' => 'buttonlink icon_previous'
				)); ?>
			</div>
			<div id="profile_my_events_<?php echo $type; ?>_next" class="paginator_next">
				<?php echo $this->htmlLink('javascript:void(0);', $this->translate('Next'), array(
					'onclick' => '',
					'class' => 'buttonlink_right icon_next'
				)); ?>
			</div>
		</div>
	<?php endif; ?>
<?php endforeach; ?>