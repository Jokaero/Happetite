<?php

class Event_View_Helper_Slider extends Zend_View_Helper_Abstract
{
  /**
   * Get Slider from array of item or array of objects
   * @param array|array of objects $items
   * @param array $params
   *
   * @return html-code $content
   */
  public function slider($items, $params = array())
  {
    $content = '';
    
    // check
    if (empty($items)) {
      return $content;
    }
    
    if (!isset($params['id'])) {
      if (APPLICATION_ENV == 'development') {
        die('Slider Helper required "id" attribute!');
      }
      
      return $content;
    }
    
    if (!isset($params['paging'])) {
      $params['paging'] = 'false';
    }
    
    if (!isset($params['steps'])) {
      $params['steps'] = 1;
    }
    
    if (!isset($params['autoplay'])) {
      $params['autoplay'] = 'false';
    }
    
    $viewer = $this->view->viewer();
    
    //if (isset($params['attend'])) {
      //$allowedEventsIds = Engine_Api::_()->event()->getEventAllowedIds($viewer);
    //}
    
    // add script and style
    $this->view->headScript()
      ->appendFile($this->view->layout()->staticBaseUrl . 'application/modules/Event/externals/scripts/slideGallery.js');
    $this->view->headLink()
      ->appendStylesheet($this->view->layout()->staticBaseUrl . 'application/modules/Event/externals/styles/slider.css');
    
    $script = <<<EOF
window.addEvent('domready', function() {
  var gallery_{$params['id']} = new slideGallery($$("#{$params['id']}"), {
    steps: {$params['steps']},
    mode: "callback",
    autoplay: {$params['autoplay']},
    paging: {$params['paging']},
    pagingHolder: ".paging",
    onPlay: function() {
      this.fireEvent("start");
    }
  });
});
EOF;
    
    $this->view->headScript()->appendScript($script);
    
    // set item count per page
    if ($items instanceof Zend_Paginator) {
      if (!empty($params['itemCountPerPage']) and (int) $params['itemCountPerPage'] >= 0) {
        $items->setItemCountPerPage((int) $params['itemCountPerPage']);
      } else {
        $items->setItemCountPerPage(0);
      }
    }
    
    // creating content
    $content .= '<div class="slider-wrapper gallery" id="' . $params['id'] . '">';
    $content .= '<div class="holder">';
    $content .= '<ul class="inner-holder" id="inner-holder-' . $params['id'] . '">';
    
    foreach ($items as $item) {
      
      // skip if item == subject
      if (isset($params['skip_subject']) and $item->getIdentity() == $params['skip_subject']) {
        continue;
      }
      
      $content .= '<li>';
      
      // can we use methods as $this->itemPhoto() and other includes helpers.
      $canUseMethods = false;
      
      if ($item instanceof User_Model_User or $item instanceof Event_Model_Event) {
        $sliderItemType = $item->getType();
        $sliderItemId = $item->getIdentity();
        $canUseMethods = true;
      } else {
        $sliderItemType = 'default-type';
        $sliderItemId = 'default-id';
      }
      
      // item wrapper
      $content .= '<div class="slider-item-' . $sliderItemType
               . ' '
               . $sliderItemType . '-' . $sliderItemId
               . '">';
      
      if ($canUseMethods) {
        // photo
        
        $photo = Engine_Api::_()->getItem('storage_file', $item->photo_id);
        if (is_object($photo)) {
          $content .= '<a href="' . $item->getHref()
                   . '"><div class="photo" style="background-image: url('
                   . $photo->getHref()
                   .  '); background-size: cover; background-position: 50% 50%;"></div></a>';
        } else {
          $content .= '<div class="photo">'
                   . $this->view->htmlLink($item->getHref(), $this->view->itemPhoto($item, 'thumb.main'), array('class' => 'thumb'))
                   . '</div>';
        }
        
        // title
        $content .= '<div class="title">' . $this->view->htmlLink($item->getHref(), $item->getTitle()) . '</div>';
        
        // if event
        if ($item->getType() == 'event') {
          
          // starttime
          if (!empty($params['starttime'])) {
            $content .= '<span class="starttime">' . $this->view->locale()->toDate($item->starttime, array('size' => 'long')) . '</span>';
            $content .= '<span class="timestamp-separator"> | </span>';
            $content .= '<span class="starttime">' . $this->view->locale()->toTime($item->starttime) . '</span>';
          }
          
          // hosted by
          if (!empty($params['hosted_by'])) {
            $content .= '<div class="hosted_by">'
                     . $this->view->translate('by %1$s',
                        $this->view->htmlLink($item->getOwner()->getHref(),
                          $item->getOwner()->getTitle()
                        )
                     )
                     . '</div>';
          }
          
          // event location
          if (!empty($params['event_location'])) {
            
            if ($item->city != '') {
              $content .= '<div class="event_location">' . $item->city . ', ' . $item->country . '</div>';
            }
          }
          
          // attend button
          if (!empty($params['attend'])) {
            //if (in_array($item->getIdentity(), $allowedEventsIds)) {
            //  $content .= $this->view->htmlLink($item->getHref(), '<button class="attend">'
            //                                                      . $this->view->translate('Attend!')
            //                                                      . '</button>');
            //}
            
            if ($item->starttime > date('Y-m-d H:i:s', time())) {
            
              // if viewer have never been join to class
              if ($item->membership()->isMember($viewer)) {
                
                $viewerInfo = $item->membership()->getMemberInfo($viewer);
                
                // check rsvp
                if (in_array($viewerInfo->rsvp, array(5, 6, 7, 8, 11))) {
                  $content .= $this->view->htmlLink($item->getHref(), '<button class="attend">'
                                                                      . $this->view->translate('Attend!')
                                                                      . '</button>');
                }
                
              } else {
                $content .= $this->view->htmlLink($item->getHref(), '<button class="attend">'
                                                                    . $this->view->translate('Attend!')
                                                                    . '</button>');
              }
              
            }
            
          }
          
        }
        
      } // end of $canUseMethods
      
      else { // if !$canUseMethods
        
        // user photo
        if ($item->user_id) {
          $user = Engine_Api::_()->getItem('user', $item->user_id);
          $photo = Engine_Api::_()->getItem('storage_file', $user->photo_id);
          $content .= '<div class="photo1">'                   
                   . '<a href="' . $user->getHref() . '"' . ' ><div class="photo" style="background-image: url('. $photo->getHref() .'); background-size: cover; background-position: 50% 50%"></div></a>' 
                   . '</div>';
        } else {
          return '<pre>Something going wrong!</pre>';
        }
        
        if ($item->resource_id) {
          $event = Engine_Api::_()->getItem('event', $item->resource_id);
        } else {
          return '<pre>Something going wrong!</pre>';
        }
        
        // user title
        if ($user->getIdentity()) {
          $content .= '<div class="title">'
                   . $this->view->htmlLink($user->getHref(), $user->getTitle())
                   . '</div>';
        }
        
        // user status
        if (isset($params['event_members_rsvp'])) {
          
          $content .= '<div class="event_members_rsvp">';
          
            $viewerInfo = $event->membership()->getMemberInfo($viewer);
            $viewerMemberInfos = false;
            
            // Accepted, accepted_after_message, paid users can see themselves  
            if (($viewerInfo->rsvp == 1 or $viewerInfo->rsvp == 2 or $viewerInfo->rsvp == 3)
                and ($item->rsvp == 1 or $item->rsvp == 2 or $item->rsvp == 3)) {
              $viewerMemberInfos = true;  
            }
            
            // who can sees RSVP
            if ($viewer->isAdmin() or $event->isOwner($viewer)
                or $viewer->getIdentity() == $user->getIdentity()
                or $viewerMemberInfos) {
                
                $content .= '<div class="member_rsvp">';
                  $content .= '(';
                  
                    // host can't see rsvp refund and refunded he see this as Cancelled rspv  
                    if (($item->rsvp == 4 or $item->rsvp == 5)
                        and $event->isOwner($viewer)
                        and !$viewer->isAdmin()) {
                      $content .= $this->view->translate('EVENT_MEMBER_STATUS_CANCELED');
                    } else {
                      $content .= $this->view->translate('EVENT_MEMBER_STATUS_' . $item->rsvp);
                    }
                    
                  $content .= ')';
                $content .= '</div>';
                
                // timer only for admin, host, viewer  
                if ($viewer->isAdmin() or $event->isOwner($viewer)
                    or $viewer->getIdentity() == $user->getIdentity()) {
                  
                  if ($item->rsvp == 0 and $viewer->getIdentity() != $user->getIdentity()) {
                    
                    $content .= '<div class="timer-wrapper">';
                      $content .= '<div class="timer-content">';
                     
                        $endDateObject = new Zend_Date(strtotime($item->datetime) + 86400);
                        $nowTime = new Zend_Date(time());
                        
                        if ($viewer && $viewer->getIdentity()) {
                          $tz = $viewer->timezone;
                          $endDateObject->setTimezone($tz);
                          $nowTime->setTimezone($tz);
                        }
                       
                        $content .= '<br />';
                        
                        $content .= $this->view->translate('Time left for action: ');
                        
                        $content .= '<span id="timer_member_' . $user->getIdentity() . '">';
                          $content .= '[timer ' . $user->getIdentity() . ']';
                        $content .= '</span>';
                        
                        $content .= '<script type="text/javascript">';
                          $content .= 'StartCountDown("timer_member_'
                                   . $user->getIdentity()
                                   . '","'
                                   . $endDateObject->toString('MM/dd/y H:mm:ss')
                                   . '", "'
                                   . $nowTime->toString('MM/dd/y H:mm:ss')
                                   . '")';
                        $content .= '</script>';
                      $content .= '</div>'; // end of timer-content
                    $content .= '</div>'; // end of timer-wrapper
                    
                  } // end if $item->rsvp == 0
                  
                  if ($item->rsvp == 1 or $item->rsvp == 2) {
                    
                    $content .= '<div class="timer-wrapper">';
                    $content .= '<div class="timer-content">';
                   
                      if ($item->is_approved_late == 1) {
                        $endDateObject = new Zend_Date(strtotime($item->rsvp_update) + 86400);
                      } else {
                        $endDateObject = new Zend_Date(strtotime($item->rsvp_update) + 86400 * 4);
                      }
                      
                      $nowTime = new Zend_Date(time());
                      
                      if ($viewer && $viewer->getIdentity()) {
                        $tz = $viewer->timezone;
                        $endDateObject->setTimezone($tz);
                        $nowTime->setTimezone($tz);
                      }
                     
                      $content .= '<br />';
                      
                      $content .= $this->view->translate('Time left for pay: ');
                      
                      $content .= '<span id="timer_member_' . $user->getIdentity() . '">';
                        $content .= '[timer ' . $user->getIdentity() . ']';
                      $content .= '</span>';
                      
                      $content .= '<script type="text/javascript">';
                        $content .= 'StartCountDown("timer_member_'
                                 . $user->getIdentity()
                                 . '","'
                                 . $endDateObject->toString('MM/dd/y H:mm:ss')
                                 . '", "'
                                 . $nowTime->toString('MM/dd/y H:mm:ss')
                                 . '")';
                      $content .= '</script>';
                    
                    $content .= '</div>'; // end of timer-wrapper
                    $content .= '</div>'; // end of timer-wrapper
                    
                  } // end if $item->rsvp == 1 or $item->rsvp == 2
                  
                }
            } // end of who can sees RSVP
            else {
              if ($item->rsvp == 10) {
                $content .= '<div class="member_rsvp">';
                  $content .= '(';
                    $content .= $this->view->translate('EVENT_MEMBER_STATUS_' . $item->rsvp);
                  $content .= ')';
                $content .= '</div>';
              }
            }
          
          $content .= '</div>';
          
        }
        
        // show event control menu under user. Accept/Reject to event
        if (isset($params['event_host_menu'])) {
          
          $event = Engine_Api::_()->getItem('event', $item->resource_id);
          
          // show menu only for host
          if($event->isOwner($viewer)) {
            $content .= '<div class="event_host_menu">';
            
            if ($item->active == false
                and $item->resource_approved == false
                and $item->rsvp == 0 ) {
              
              $content .= $this->view->htmlLink(array(
                'route' => 'event_extended',
                'controller' => 'member',
                'action' => 'approve',
                'event_id' => $event->getIdentity(),
                'user_id' => $user->getIdentity()
                ), $this->view->translate('Approve Request'), array(
                'class' => 'buttonlink smoothbox icon_event_accept'
              ));
              
              $content .= $this->view->htmlLink(array(
                'route' => 'event_extended',
                'controller' => 'member',
                'action' => 'remove',
                'event_id' => $event->getIdentity(),
                'user_id' => $user->getIdentity()
                ), $this->view->translate('Reject Request'), array(
                'class' => 'buttonlink smoothbox icon_event_reject'
              ));
            }
            
            $content .= '</div">';
          }
          
        } // end of event_host_menu
        
      } // endif !$canUseMethods
      
      // end of item wrapper
      $content .= '</div>';
      
      $content .= '</li>';
    }
    
    // end of inner-holder
    $content .= '</ul>';
    
    // end of holder
    $content .= '</div>';
    
    // prev next buttons
    $content .= '<div class="control">';
      $content .= '<a href="javascript:void(0)" class="prev">prev</a>';
      $content .= '<a href="javascript:void(0)" class="next">next</a>';
    $content .= '</div>';
    
    // end of slider-wrapper
    $content .= '</div>';
    
    return $content;
  }
}