<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: index.tpl 9987 2013-03-20 00:58:10Z john $
 * @author     Sami
 */
?>

<h3>
  <?php echo $this->translate('Event Details') ?>
</h3>
<div id='event_stats'>
  <ul>
    <?php $membersCount = count(Engine_Api::_()->getDbTable('membership', 'event')
        ->getAllMembers(array('event_id' => $this->subject->getIdentity(), 'status' => '1,2,3'), null)); ?>
    <?php if ($this->subject->max_users and $membersCount >= $this->subject->max_users) : ?>
    <li class="fully_booked">
      <?php echo $this->translate('The class is fully booked.'); ?>
    </li>
    <?php endif; ?>
    <li class="event_date">
      <?php
        // Convert the dates for the viewer
        $startDateObject = new Zend_Date(strtotime($this->subject->starttime));
        $endDateObject = new Zend_Date(strtotime($this->subject->endtime));
        if( $this->viewer() && $this->viewer()->getIdentity() ) {
          $tz = $this->viewer()->timezone;
          $startDateObject->setTimezone($tz);
          $endDateObject->setTimezone($tz);
        }
      ?>
      <?php if( $this->subject->starttime == $this->subject->endtime ): ?>
        <div class="label">
          <?php echo $this->translate('Date') ?>
        </div>
        <div class="event_stats_content">
          <?php echo $this->locale()->toDate($startDateObject) ?>
        </div>

        <div class="label">
          <?php echo $this->translate('Time') ?>
        </div>
        <div class="event_stats_content">
          <?php echo $this->locale()->toTime($startDateObject) ?>
        </div>

      <?php elseif( $startDateObject->toString('y-MM-dd') == $endDateObject->toString('y-MM-dd') ): ?>
        <div class="label">
          <?php echo $this->translate('Date')?>
        </div>
        <div class="event_stats_content">
          <?php echo $this->locale()->toDate($startDateObject) ?>
        </div>

        <div class="label">
          <?php echo $this->translate('Time')?>
        </div>
        <div class="event_stats_content">
          <?php echo $this->locale()->toTime($startDateObject) ?>
          -
          <?php echo $this->locale()->toTime($endDateObject) ?>
        </div>

      <?php else: ?>  
        <div class="event_stats_content">
          <?php echo $this->translate('%1$s at %2$s',
            $this->locale()->toDate($startDateObject),
            $this->locale()->toTime($startDateObject)
          ) ?>
          - <br />
          <?php echo $this->translate('%1$s at %2$s',
            $this->locale()->toDate($endDateObject),
            $this->locale()->toTime($endDateObject)
          ) ?>
        </div>
      <?php endif ?>
    </li>
    
    <?php if( !empty($this->subject->location) ): ?>
    <li>
      <div class="label"><?php echo $this->translate('Where')?></div>
      <div class="event_stats_content"><?php echo $this->subject->location; ?> <?php echo $this->htmlLink('http://maps.google.com/?q='.urlencode($this->subject->location), $this->translate('Map'), array('target' => 'blank')) ?></div>
    </li>
    <?php endif ?>
    
    <li>
      <div class="label"><?php echo $this->translate('Host') ?></div>
      <div class="event_stats_content">
        <?php echo $this->htmlLink($this->subject->getParent(), $this->subject->getParent()->getTitle()); ?>
      </div>
    </li>
    
    <?php if( !empty($this->subject->category_id) ): ?>
    <li>
      <div class="label"><?php echo $this->translate('Category')?></div>
      <div class="event_stats_content">
        <?php echo $this->htmlLink(array(
          'route' => 'event_general',
          'action' => 'browse',
          'category_id' => $this->subject->category_id,
        ), $this->translate((string)$this->subject->categoryName())) ?>
      </div>
    </li>
    <?php endif ?>
    
    <li>
      <div class="label"><?php echo $this->translate('Price')?></div>
      <div class="event_stats_content">
        <?php echo $this->price; ?>
        <?php echo $this->subject->currency; ?>
      </div>
    </li>
    
    <li>
      <div class="label"><?php echo $this->translate('Maximum participants')?></div>
      <div class="event_stats_content" style="text-transform: uppercase;">
      <?php if ($this->subject->max_users) : ?>
        <?php echo $this->subject->max_users; ?>
      <?php else : ?>
        <?php echo $this->translate('open'); ?>
      <?php endif; ?>
      </div>
    </li>
  </ul>
</div>

<script type="text/javascript">
  $$('.core_main_event').getParent().addClass('active');
</script>
