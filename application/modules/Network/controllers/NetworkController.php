<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Network
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: NetworkController.php 9872 2013-02-13 00:31:37Z shaun $
 * @author     Sami
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Network
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Network_NetworkController extends Core_Controller_Action_Standard
{
   public function suggestAction()
   {
    if( $this->_helper->requireUser()->checkRequire() )
    {
      $viewer = Engine_Api::_()->user()->getViewer();
      $data = Network_Model_Network::getUserNetworks($viewer, 
        $this->_getParam('text', $this->_getParam('text'))); 
    }
    
    if( $this->_getParam('sendNow', true) )
    {
      return $this->_helper->json($data);
    }
    else
    {
      $this->_helper->viewRenderer->setNoRender(true);
      $data = Zend_Json::encode($data);
      $this->getResponse()->setBody($data);
    }
  }
}