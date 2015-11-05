<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Invite
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: IndexController.php 10180 2014-04-28 21:02:01Z lucas $
 * @author     Steve
 */

/**
 * @category   Application_Extensions
 * @package    Invite
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @todo SignupController.php: integrate invite-only functionality (reject if invite code is bad)
 * @todo AdminController.php: add in stricter settings for admin level checking
 */
class Invite_IndexController extends Core_Controller_Action_Standard
{
  public function indexAction()
  {
    // Render
    $this->_helper->content
        //->setNoRender()
        ->setEnabled()
        ;
    
    $settings = Engine_Api::_()->getApi('settings', 'core');

    // Check if admins only
    if( $settings->getSetting('user.signup.inviteonly') == 1 ) {
      if( !$this->_helper->requireAdmin()->isValid() ) {
        return;
      }
    }

    // Check for users only
    if( !$this->_helper->requireUser()->isValid() ) {
      return;
    }

    // Make form
    $this->view->form = $form = new Invite_Form_Invite();

    if( !$this->getRequest()->isPost() ) {
      return;
    }

    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }

    
    // Process
    $values = $form->getValues();
    $viewer = Engine_Api::_()->user()->getViewer();
    $inviteTable = Engine_Api::_()->getDbtable('invites', 'invite');
    $db = $inviteTable->getAdapter();
    $db->beginTransaction();
    
    try {
      $emailsSent = $inviteTable->sendInvites($viewer, $values['recipients'], @$values['message'],$values['friendship']);
      $db->commit();
    } catch( Exception $e ) {
      $db->rollBack();
      if( APPLICATION_ENV == 'development' ) {
        throw $e;
      }
    }

    //$this->view->alreadyMembers = $alreadyMembers;
    $this->view->emails_sent = $emailsSent;
    
    return $this->render('sent');
  }
}
