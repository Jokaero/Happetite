<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: index.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */
?>

<script type="text/javascript">
    window.addEvent('domready', function() {
      $$('#form-language > ul li a').addEvent('click', function() {
        $('hidden-lang').value = $(this).getAttribute('data');
        $(this).getParent('form').submit();
      });
    });
</script>

<div id='core_menu_mini_menu' class="<?php echo ($this->viewer->getIdentity()) ? 'auth' : 'auth-empty'; ?>">
  <?php
    // Reverse the navigation order (they're floating right)
    $count = count($this->navigation);
    foreach( $this->navigation->getPages() as $item ) $item->setOrder(--$count);
  ?>
  <ul>
    <?php if( $this->viewer->getIdentity()) :?>
    <li id='core_menu_mini_menu_update'>
      <span onclick="toggleUpdatesPulldown(event, this, '4');" style="display: inline-block;" class="updates_pulldown">
        <div class="pulldown_contents_wrapper">
          <div class="pulldown_contents">
            <ul class="notifications_menu" id="notifications_menu">
              <div class="notifications_loading" id="notifications_loading">
                <img src='<?php echo $this->layout()->staticBaseUrl ?>application/modules/Core/externals/images/loading.gif' style='float:left; margin-right: 5px;' />
                <?php echo $this->translate("Loading ...") ?>
              </div>
            </ul>
          </div>
          <div class="pulldown_options">
            <?php echo $this->htmlLink(array('route' => 'default', 'module' => 'activity', 'controller' => 'notifications'),
               $this->translate('View All Updates'),
               array('id' => 'notifications_viewall_link')) ?>
            <?php echo $this->htmlLink('javascript:void(0);', $this->translate('Mark All Read'), array(
              'id' => 'notifications_markread_link',
            )) ?>
          </div>
        </div>
        <a href="javascript:void(0);" id="updates_toggle" <?php if( $this->notificationCount ):?> class="new_updates"<?php endif;?>><?php echo $this->translate(array('%s Update', '%s Updates', $this->notificationCount), $this->locale()->toNumber($this->notificationCount)) ?></a>
      </span>
    </li>
    <?php endif; ?>
    <?php foreach( $this->navigation as $item ): ?>
      
      <?php // Auth in lightbox ?>
      
      <?php $onClick = ''; ?>
      <?php if ($item->name == 'core_mini_auth' or $item->name == 'core_mini_signup') : ?>
        <?php if ($item->name == 'core_mini_auth') : ?>
          <?php $tempFunctionName = 'login'; ?>
        <?php elseif ($item->name == 'core_mini_signup') : ?>
          <?php $tempFunctionName = 'signup'; ?>
        <?php endif; ?>
        <?php $onClick = "advancedMenuUserLoginOrSignUp('$tempFunctionName', '{$this->isUserLoginPage}', '{$this->isUserSignupPage}'); return false;"; ?>
      <?php endif; ?>
      
      <li class="<?php echo !empty($item->class) ? $item->class : 'no-class' ?>">
        <?php echo $this->htmlLink($item->getHref(), $this->translate($item->getLabel()), array_filter(array(
          'class' => ( !empty($item->class) ? $item->class : null ),
          'alt' => ( !empty($item->alt) ? $item->alt : null ),
          'target' => ( !empty($item->target) ? $item->target : null ),
          'onclick' => $onClick,
        ))) ?>
        
        <?php // Languages submenu ?>
        <?php if (1 !== count($this->languageNameList)) : ?>
          <?php if ($item->_label == 'Language') : ?>
            <form id="form-language" method="post" action="<?php echo $this->url(array('controller' => 'utility', 'action' => 'locale'), 'default', true) ?>" style="display:block">
              <?php $selectedLanguage = $this->translate()->getLocale() ?>
              <?php echo $this->formHidden('return', $this->url()) ?>
              <ul>
                <?php foreach ($this->languageNameList as $lang => $lang_name) : ?>
                  <?php if ($lang == '') continue; ?>
                  <li class="lang-wrapper">
                    <a data="<?php echo $lang; ?>">
                      <?php echo $lang_name; ?>
                    </a>
                  </li>
                <?php endforeach; ?>
              </ul>
              <input type="hidden" value="" name="language" id="hidden-lang">
            </form>
          <?php endif; ?>
        <?php endif; ?>
        
        <?php // User submenu ?>
        <?php if ($item->name == 'custom_203') : ?>
        <form>
          <ul class="inner-menu-mini" id="user-submenu">
            
            <?php // My Profile ?>
            <?php if ($this->viewer()->getIdentity()) : ?>
              <li class="my-profile">
                <?php echo $this->htmlLink(array(
                  'route' => 'user_profile',
                  'id' => $this->viewer->username,
                  ), $this->translate('My Happetite')); ?>
              </li>
            <?php endif; ?>
            
            <?php // Attend a Class ?>
            <li class="attend-a-class">
              <?php echo $this->htmlLink(array(
                      'route' => 'event_steps',
                      'action' => 'guest'
                    ), $this->translate('Attend a Class'));
              ?>
            </li>
            
            <?php // Be a Host ?>
            <li class="host-a-class">
              <?php echo $this->htmlLink(array(
                      'route' => 'event_steps',
                      'action' => 'host'
                    ), $this->translate('Host a Class'));
              ?>
            </li>
            
            <?php // Settings ?>
            <?php if ($this->viewer()->getIdentity()) : ?>
              <li class="member-settings">
                <?php echo $this->htmlLink(array(
                  'route' => 'user_extended',
                  'controller' => 'settings',
                  'action' => 'general'
                  ), $this->translate('My Settings')); ?>
              </li>
            <?php endif; ?>
            
            <?php // Support ?>
            <li class="support">
              <?php echo $this->htmlLink('/help/contact', $this->translate('Support')); ?>
            </li>
            
            <?php // LogOut ?>
            <li class="core_mini_auth">
              <?php echo $this->htmlLink('/logout', $this->translate('Sign Out')); ?>
            </li>
            
          </ul>
        </form>
        <?php endif; ?>
        
      </li>
    <?php endforeach; ?>
    <?php if($this->search_check):?>
      <li id="global_search_form_container">
        <form id="global_search_form" action="<?php echo $this->url(array('controller' => 'search'), 'default', true) ?>" method="get">
          <input type='text' class='text suggested' name='query' id='global_search_field' size='20' maxlength='100' alt='<?php echo $this->translate('Search') ?>' />
        </form>
      </li>
    <?php endif;?>
  </ul>
</div>


<script type='text/javascript'>
  var notificationUpdater;

  en4.core.runonce.add(function(){
    if($('global_search_field')){
      new OverText($('global_search_field'), {
        poll: true,
        pollInterval: 500,
        positionOptions: {
          position: ( en4.orientation == 'rtl' ? 'upperRight' : 'upperLeft' ),
          edge: ( en4.orientation == 'rtl' ? 'upperRight' : 'upperLeft' ),
          offset: {
            x: ( en4.orientation == 'rtl' ? -4 : 4 ),
            y: 2
          }
        }
      });
    }

    if($('notifications_markread_link')){
      $('notifications_markread_link').addEvent('click', function() {
        //$('notifications_markread').setStyle('display', 'none');
        en4.activity.hideNotifications('<?php echo $this->string()->escapeJavascript($this->translate("0 Updates"));?>');
      });
    }

    <?php if ($this->updateSettings && $this->viewer->getIdentity()): ?>
    notificationUpdater = new NotificationUpdateHandler({
              'delay' : <?php echo $this->updateSettings;?>
            });
    notificationUpdater.start();
    window._notificationUpdater = notificationUpdater;
    <?php endif;?>
  });


  var toggleUpdatesPulldown = function(event, element, user_id) {
    if( element.className=='updates_pulldown' ) {
      element.className= 'updates_pulldown_active';
      showNotifications();
    } else {
      element.className='updates_pulldown';
    }
  }

  var showNotifications = function() {
    en4.activity.updateNotifications();
    new Request.HTML({
      'url' : en4.core.baseUrl + 'activity/notifications/pulldown',
      'data' : {
        'format' : 'html',
        'page' : 1
      },
      'onComplete' : function(responseTree, responseElements, responseHTML, responseJavaScript) {
        if( responseHTML ) {
          // hide loading icon
          if($('notifications_loading')) $('notifications_loading').setStyle('display', 'none');

          $('notifications_menu').innerHTML = responseHTML;
          $('notifications_menu').addEvent('click', function(event){
            event.stop(); //Prevents the browser from following the link.

            var current_link = event.target;
            var notification_li = $(current_link).getParent('li');

            // if this is true, then the user clicked on the li element itself
            if( notification_li.id == 'core_menu_mini_menu_update' ) {
              notification_li = current_link;
            }

            var forward_link;
            if( current_link.get('href') ) {
              forward_link = current_link.get('href');
            } else{
              forward_link = $(current_link).getElements('a:last-child').get('href');
            }

            if( notification_li.get('class') == 'notifications_unread' ){
              notification_li.removeClass('notifications_unread');
              en4.core.request.send(new Request.JSON({
                url : en4.core.baseUrl + 'activity/notifications/markread',
                data : {
                  format     : 'json',
                  'actionid' : notification_li.get('value')
                },
                onSuccess : function() {
                  window.location = forward_link;
                }
              }));
            } else {
              window.location = forward_link;
            }
          });
        } else {
          $('notifications_loading').innerHTML = '<?php echo $this->string()->escapeJavascript($this->translate("You have no new updates."));?>';
        }
      }
    }).send();
  };

  /*
  function focusSearch() {
    if(document.getElementById('global_search_field').value == 'Search') {
      document.getElementById('global_search_field').value = '';
      document.getElementById('global_search_field').className = 'text';
    }
  }
  function blurSearch() {
    if(document.getElementById('global_search_field').value == '') {
      document.getElementById('global_search_field').value = 'Search';
      document.getElementById('global_search_field').className = 'text suggested';
    }
  }
  */
</script>