<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Controller.php 9747 2012-07-26 02:08:08Z john $
 * @author     Jung
 */

/**
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Core_Widget_AdCampaignController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    // Get campaign
    if( !($id = $this->_getParam('adcampaign_id')) ||
        !($campaign = Engine_Api::_()->getItem('core_adcampaign', $id)) ) {
      return $this->setNoRender();
    }

    // Check limits, start, and expire
    if( !$campaign->isActive() ) {
      return $this->setNoRender();
    }
    
    // Get viewer
    $viewer = Engine_Api::_()->user()->getViewer();
    if( !$campaign->isAllowedToView($viewer) ) {
      return $this->setNoRender();
    }

    // Get ad
    if( !($ad = $campaign->getAd()) ) {
      return $this->setNoRender();
    }
    
    // Okay
    $campaign->views++;
    $campaign->save();
    
    $ad->views++;
    $ad->save();

    $this->view->campaign = $campaign;
    $this->view->ad = $ad;
  }
}
