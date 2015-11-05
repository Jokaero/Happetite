<?php
class SocialConnect_SettingsController extends Core_Controller_Action_User
{
	protected $_user;


  public function meAction(){
		$user = $this->_helper->api()->core()->getSubject();
		$userid = 0;
		if($user){
			$userid = $user->user_id;
		}
		$Api =  SocialConnect_Api_Core::factory();
		$this->view->connectAgents =  $Api->getConnectAgents($userid);
		$this->view->disconnectAgents =  $Api->getDisconnectAgents($userid);
		$this->view->unsetupServices    = $Api->getUnsetupServices($userid);
		
		//$this->view->disconnectedService = $Api->getDisconnecedService($userid); 
  }
	public function init()
	{
		// Can specifiy custom id
		$id = $this->_getParam('id', null);
		$subject = null;
		if( null === $id )
		{
			$subject = $this->_helper->api()->user()->getViewer();
			$this->_helper->api()->core()->setSubject($subject);
		}
		else
		{
			$subject = $this->_helper->api()->user()->getUser($id);
			$this->_helper->api()->core()->setSubject($subject);
		}

		// Set up require's
		$this->_helper->requireUser();
		$this->_helper->requireAuth()->setAuthParams(
		$subject,
		null,
      'edit'
      );
      if ( !empty($id) ){
      	$params = array('params'=>array('id'=>$id));
      } else {
      	$params = array();
      }
      // Set up navigation
      $this->view->navigation = $navigation = $this->_helper->api()
      ->getApi('menus', 'core')
      ->getNavigation('user_settings', $params);

      // Removes the Delete Account tab when a user is not allowed to
      // delete their account
      $user = $this->_helper->api()->user()->getViewer();
      if( !Engine_Api::_()->authorization()->isAllowed('user', $user, 'delete') ) {
      	$count = 0;
      	foreach ( $navigation->getPages() as $page ){
        if( $page->getLabel() == 'Delete Account' ){
        	$navigation->removePage($count);
        	break;
        }
        $count++;
      	}
      }
      /*
       $viewer = Engine_Api::_()->user()->getViewer();
       if ( !$viewer->getIdentity() ) {
       $session = new Zend_Session_Namespace('Redirect');
       $session->uri     = 'user/settings';
       $session->options = array();
       $this->_redirect('login');
       }
       *
       */

      $contextSwitch = $this->_helper->contextSwitch;
      $contextSwitch
      //->addActionContext('reject', 'json')
      ->initContext();
	}

	public function _meAction(){
		// Config vars
		$user = $this->_helper->api()->core()->getSubject();
		$this->view->form = $form = new User_Form_Settings_General(array('item' => $user));

		// Set up profile type options
		/*
		$aliasedFields = $user->fields()->getFieldsObjectsByAlias();
		if( isset($aliasedFields['profile_type']) )
		{
		$options = $aliasedFields['profile_type']->getElementParams($user);
		unset($options['options']['order']);
		$form->accountType->setOptions($options['options']);
		}
		else
		{ */
		$form->removeElement('accountType');
		/* } */

		// Removed disabled features
		if( !Engine_Api::_()->authorization()->isAllowed('user', $user, 'username') ) {
			$form->removeElement('username');
		}

		// Facebook
		if ('none' != Engine_Api::_()->getApi('settings', 'core')->getSetting('core.facebook.enable', 'none')) {
			$facebook = User_Model_DbTable_Facebook::getFBInstance();
			if ($facebook->getSession()) {
				$fb_uid = Engine_Api::_()->getDbtable('facebook', 'user')->fetchRow(array('user_id = ?'=>Engine_Api::_()->user()->getViewer()->getIdentity()));
				if ($fb_uid && $fb_uid->facebook_uid)
				$fb_uid  = $fb_uid->facebook_uid;
				else
				$fb_uid  = null;

				try {
					$facebook->api('/me');
					if ($fb_uid && $facebook->getUser() != $fb_uid) {
						$form->removeElement('facebook_id');
						$form->getElement('facebook')->addError('You appear to be logged into a different Facebook account than what was registered with this account.  Please log out of Facebook using the button below to log into your correct Facebook account.');
						$form->getElement('facebook')->setContent($this->view->translate('<button onclick="window.location.href=this.value;return false;" value="%s">Logout of Facebook</button>', $facebook->getLogoutUrl()));
					} else {
						$form->removeElement('facebook');
						$form->getElement('facebook_id')->setAttrib('checked', (bool) $fb_uid);
					}
				} catch (Exception $e) {
					$form->removeElement('facebook');
					$form->removeElement('facebook_id');
				}
			} else {
				@$form->removeElement('facebook_id');
			}
		} else {
			// these should already be removed inside the form, but lets do it again.
			@$form->removeElement('facebook');
			@$form->removeElement('facebook_id');
		}


		// Check if post and populate
		if( !$this->getRequest()->isPost() )
		{
			$form->populate($user->toArray());

			$this->view->status = false;
			$this->view->error = Zend_Registry::get('Zend_Translate')->_('Invalid method');
			return;
		}

		// Check if valid
		if( !$form->isValid($this->getRequest()->getPost()) )
		{
			$this->view->status = false;
			$this->view->error = Zend_Registry::get('Zend_Translate')->_('Invalid data');
			return;
		}

		// -- Process --

		// Set values for user object
		$user->setFromArray($form->getValues());
		$user->save();

		// Check if email address changed
		$auth = Engine_Api::_()->user()->getAuth();
		if( $user->email != $auth->getIdentity() ){
			$storage = $auth->getStorage();
			$storage->write($user->email ); // update session storage
		}


		// Update account type
		/*
		$accountType = $form->getValue('accountType');
		if( isset($aliasedFields['profile_type']) )
		{
		$valueRow = $aliasedFields['profile_type']->getValue($user);
		if( null === $valueRow ) {
		$valueRow = Engine_Api::_()->fields()->getTable('user', 'values')->createRow();
		$valueRow->field_id = $aliasedFields['profile_type']->field_id;
		$valueRow->item_id = $user->getIdentity();
		}
		$valueRow->value = $accountType;
		$valueRow->save();
		}
		*
		*/

		// Update facebook settings
		if (isset($facebook) && $form->getElement('facebook_id')) {
			if ($facebook->getSession()) {
				try {
					$facebook->api('/me');
					$uid   = Engine_Api::_()->user()->getViewer()->getIdentity();
					$table = Engine_Api::_()->getDbtable('facebook', 'user');
					$row   = $table->find($uid)->current();
					if (!$row) {
						$row = $table->createRow();
						$row->user_id = $uid;
					}
					$row->facebook_uid = $this->getRequest()->getPost('facebook_id')
					? $facebook->getUser()
					: 0;
					$row->save();
					$form->removeElement('facebook');
				} catch (Exception $e) {}
			}
		}

		// Send success message
		$this->view->status = true;
		$this->view->message = Zend_Registry::get('Zend_Translate')->_('Settings saved.');
		$form->addNotice(Zend_Registry::get('Zend_Translate')->_('Settings were successfully saved.'));
	}
}