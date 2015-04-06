<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: index.tpl 9867 2013-02-12 21:17:02Z jung $
 * @access	   John
 */
?>

<a id="event_profile_members_anchor"></a>

<script type="text/javascript">
  var eventMemberSearch = <?php echo Zend_Json::encode($this->search) ?>;
  var eventMemberPage = Number('<?php echo $this->members->getCurrentPageNumber() ?>');
  var waiting = '<?php echo $this->waiting ?>';
  en4.core.runonce.add(function() {
    var url = en4.core.baseUrl + 'widget/index/content_id/' + <?php echo sprintf('%d', $this->identity) ?>;
    $('event_members_search_input').addEvent('keypress', function(e) {
      if( e.key != 'enter' ) return;

      en4.core.request.send(new Request.HTML({
        'url' : url,
        'data' : {
          'format' : 'html',
          'subject' : en4.core.subject.guid,
          'search' : this.value
        }
      }), {
        'element' : $('event_profile_members_anchor').getParent()
      });
    });
  });

  var paginateEventMembers = function(page) {
    //var url = '<?php echo $this->url(array('module' => 'event', 'controller' => 'widget', 'action' => 'profile-members', 'subject' => $this->subject()->getGuid(), 'format' => 'html'), 'default', true) ?>';
    var url = en4.core.baseUrl + 'widget/index/content_id/' + <?php echo sprintf('%d', $this->identity) ?>;
    en4.core.request.send(new Request.HTML({
      'url' : url,
      'data' : {
        'format' : 'html',
        'subject' : en4.core.subject.guid,
        'search' : eventMemberSearch,
        'page' : page,
        'waiting' : waiting
      }
    }), {
      'element' : $('event_profile_members_anchor').getParent()
    });
  }
  
  
</script>

<script type="text/javascript">
  function StartCountDown(myDiv, myTargetDate, endTime) {
    var dthen	= new Date(myTargetDate);
    var dnow	= new Date(endTime);
    ddiff		= new Date(dthen-dnow);
    gsecs		= Math.floor(ddiff.valueOf() / 1000);
    CountBack(myDiv, gsecs);
  }
  
  function Calcage(secs, num1, num2) {
    s = ((Math.floor(secs/num1))%num2).toString();
    if (s.length < 2)  {	
      s = "0" + s;
    }
    
    return (s);
  }
  
  function CountBack(myDiv, secs) {
    var DisplayStr;
    var DisplayFormat = "%%H%%h %%M%%min";//"%%H%%h %%M%%min %%S%%sec";
    DisplayStr = DisplayFormat.replace(/%%H%%/g, Calcage(secs, 3600, 24));
    DisplayStr = DisplayStr.replace(/%%M%%/g, Calcage(secs, 60, 60));
    DisplayStr = DisplayStr.replace(/%%S%%/g,		Calcage(secs, 1, 60));
    
    if (secs > 0) {
      document.getElementById(myDiv).innerHTML = DisplayStr;
      setTimeout("CountBack('" + myDiv + "'," + (secs - 1) + ");", 990);
    } else {
      document.getElementById(myDiv).innerHTML = "<b><?php echo $this->translate("Please wait..."); ?></b>";
      
      new Request.HTML({
        'url' : '<?php echo $this->url(array('action' => 'job'), 'event_general', true); ?>',
        'onComplete' : function(responseTree, responseElements, responseHTML, responseJavaScript) {
          if( responseHTML ) {
            $(myDiv).getParent().getParent().getParent().destroy();
          }
        }
      }).send();
    }
  }
</script>

<div class="event_members_info">
  <div class="event_members_search">
    <input id="event_members_search_input" type="text" value="<?php echo $this->translate('Search Guests');?>" onfocus="$(this).store('over', this.value);this.value = '';" onblur="this.value = $(this).retrieve('over');">
  </div>
  <div class="event_members_total">
    <?php if( '' == $this->search ): ?>
      <?php echo $this->translate(array('This event has %1$s guest.', 'This event has %1$s guests.', $this->members->getTotalItemCount() - 1),$this->locale()->toNumber($this->members->getTotalItemCount() - 1)) ?>
    <?php else: ?>
      <?php echo $this->translate(array('This event has %1$s guest that matched the query "%2$s".', 'This event has %1$s guests that matched the query "%2$s".', $this->members->getTotalItemCount()), $this->locale()->toNumber($this->members->getTotalItemCount()), $this->escape($this->search)) ?>
    <?php endif; ?>
  </div>
  <?php if( !empty($this->waitingMembers) && $this->waitingMembers->getTotalItemCount() > 0 ): ?>
    <div class="event_members_total">
      <?php echo $this->htmlLink('javascript:void(0);', $this->translate('See Waiting'), array('onclick' => 'showWaitingMembers(); return false;')) ?>
    </div>
  <?php endif; ?>
</div>

<?php if( $this->members->getTotalItemCount() > 0 ): ?>
  <ul class='event_members'>
    <?php foreach( $this->members as $member ):
      if( !empty($member->resource_id) ) {
        $memberInfo = $member;
        $member = $this->item('user', $memberInfo->user_id);
      } else {
        $memberInfo = $this->event->membership()->getMemberInfo($member);
      }
      ?>

      <li id="event_member_<?php echo $member->getIdentity() ?>">

        <?php echo $this->htmlLink($member->getHref(), $this->itemPhoto($member, 'thumb.icon'), array('class' => 'event_members_icon')) ?>
        <div class='event_members_options'>

          <?php // Remove/Promote/Demote member ?>
          <?php if( $this->event->isOwner($this->viewer())): ?>

            <?php if( !$this->event->isOwner($member) && $memberInfo->active == true ): ?>
              <?php /*echo $this->htmlLink(array('route' => 'event_extended', 'controller' => 'member', 'action' => 'remove', 'event_id' => $this->event->getIdentity(), 'user_id' => $member->getIdentity()), $this->translate('Remove Member'), array(
                'class' => 'buttonlink smoothbox icon_friend_remove'
              ))*/ ?>
            <?php endif; ?>
            
            <?php if( $memberInfo->active == false && $memberInfo->resource_approved == false and $memberInfo->rsvp == 0 ): ?>
              <?php echo $this->htmlLink(array('route' => 'event_extended', 'controller' => 'member', 'action' => 'approve', 'event_id' => $this->event->getIdentity(), 'user_id' => $member->getIdentity()), $this->translate('Approve Request'), array(
                'class' => 'buttonlink smoothbox icon_event_accept'
              )) ?>
              <?php echo $this->htmlLink(array('route' => 'event_extended', 'controller' => 'member', 'action' => 'remove', 'event_id' => $this->event->getIdentity(), 'user_id' => $member->getIdentity()), $this->translate('Reject Request'), array(
                'class' => 'buttonlink smoothbox icon_event_reject'
              )) ?>
            <?php endif; ?>
            
            <?php if( $memberInfo->active == false
                     and $memberInfo->resource_approved == true
                     and $memberInfo->rsvp != 4
                     and $memberInfo->rsvp != 9 ): ?>
              <?php echo $this->htmlLink(array('route' => 'event_extended', 'controller' => 'member', 'action' => 'cancel', 'event_id' => $this->event->getIdentity(), 'user_id' => $member->getIdentity()), $this->translate('Cancel Invite'), array(
                'class' => 'buttonlink smoothbox icon_event_cancel'
              )) ?>
            <?php endif; ?>


          <?php endif; ?>
        </div>
        <div class='event_members_body'>
          <div>
            <span class='event_members_status'>
              <?php echo $this->htmlLink($member->getHref(), $member->getTitle()) ?>

              <?php // Titles ?>
              <?php if( $this->event->getParent()->getGuid() == ($member->getGuid())): ?>
                <?php echo $this->translate('(%s)', ( $memberInfo->title ? $memberInfo->title : $this->translate('host') )) ?>
              <?php endif; ?>

            </span>
            <span>
              <?php echo $member->status; ?>
            </span>
          </div>
          <div class="event_members_rsvp">
            <?php echo $this->translate('EVENT_MEMBER_STATUS_' . $memberInfo->rsvp) ?>
            
            <?php if ($memberInfo->rsvp == 0) : ?>
              <?php
                $endDateObject = new Zend_Date(strtotime($memberInfo->datetime) + 86400);
                $nowTime = new Zend_Date(time());
                if( $this->viewer() && $this->viewer()->getIdentity() ) {
                  $tz = $this->viewer()->timezone;
                  $endDateObject->setTimezone($tz);
                  $nowTime->setTimezone($tz);
                }
              ?>
              <br />
              <?php echo $this->translate('Time left for action: '); ?>
              <span id="timer_member_<?php echo $member->getIdentity(); ?>">[timer <?php echo $member->getIdentity(); ?>]</span>
              <script type="text/javascript">
                StartCountDown("timer_member_<?php echo $member->getIdentity(); ?>","<?php echo $endDateObject->toString('MM/dd/y H:mm:ss'); ?>", "<?php echo $nowTime->toString('MM/dd/y H:mm:ss'); ?>");
              </script>
            <?php endif; ?>
            <?php if ($memberInfo->rsvp == 1) : ?>
              <?php
                $endDateObject = new Zend_Date(strtotime($memberInfo->datetime) + 86400);
                $nowTime = new Zend_Date(time());
                if( $this->viewer() && $this->viewer()->getIdentity() ) {
                  $tz = $this->viewer()->timezone;
                  $endDateObject->setTimezone($tz);
                  $nowTime->setTimezone($tz);
                }
              ?>
              <br />
              <?php echo $this->translate('Time left for pay: '); ?>
              <span id="timer_member_<?php echo $member->getIdentity(); ?>">[timer <?php echo $member->getIdentity(); ?>]</span>
              <script type="text/javascript">
                StartCountDown("timer_member_<?php echo $member->getIdentity(); ?>","<?php echo $endDateObject->toString('MM/dd/y H:mm:ss'); ?>", "<?php echo $nowTime->toString('MM/dd/y H:mm:ss'); ?>");
              </script>
            <?php endif; ?>
          </div>
        </div>

      </li>

    <?php endforeach;?>

  </ul>


  <?php if( $this->members->count() > 1 ): ?>
    <div>
      <?php if( $this->members->getCurrentPageNumber() > 1 ): ?>
        <div id="user_event_members_previous" class="paginator_previous">
          <?php echo $this->htmlLink('javascript:void(0);', $this->translate('Previous'), array(
            'onclick' => 'paginateEventMembers(eventMemberPage - 1)',
            'class' => 'buttonlink icon_previous',
            'style' => '',
          )); ?>
        </div>
      <?php endif; ?>
      <?php if( $this->members->getCurrentPageNumber() < $this->members->count() ): ?>
        <div id="user_event_members_next" class="paginator_next">
          <?php echo $this->htmlLink('javascript:void(0);', $this->translate('Next'), array(
            'onclick' => 'paginateEventMembers(eventMemberPage + 1)',
            'class' => 'buttonlink icon_next'
          )); ?>
        </div>
      <?php endif; ?>
    </div>
  <?php endif; ?>

<?php endif; ?>