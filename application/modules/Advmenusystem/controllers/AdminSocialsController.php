<?php
class Advmenusystem_AdminSocialsController extends Core_Controller_Action_Admin
{

	public function init()
	{
		// Get list of menus
		$this -> view -> navigation = $navigation = Engine_Api::_() -> getApi('menus', 'core') -> getNavigation('advmenusystem_admin_main', array(), 'advmenusystem_admin_socials_menu');
	}

	public function indexAction()
	{
		$facebook = Engine_Api::_() -> getApi('settings', 'core') -> getSetting('facebook.avdmenusystem.sociallink');
		if($facebook)
			$facebook = Zend_JSON::decode($facebook);
		else
		$facebook['title'] =  'Facebook';
		
		$twitter = Engine_Api::_() -> getApi('settings', 'core') -> getSetting('twitter.avdmenusystem.sociallink');
		if($twitter)
			$twitter = Zend_JSON::decode($twitter);
		else
			$twitter['title'] =  'Twitter';
		
		$pinterest = Engine_Api::_() -> getApi('settings', 'core') -> getSetting('pinterest.avdmenusystem.sociallink');
		if($pinterest)
			$pinterest = Zend_JSON::decode($pinterest);
		else
			$pinterest['title'] =  'Pinterest';
		
		$youtube = Engine_Api::_() -> getApi('settings', 'core') -> getSetting('youtube.avdmenusystem.sociallink');
		if($youtube)
			$youtube = Zend_JSON::decode($youtube);
		else
			$youtube['title'] =  'Youtube';
			
		$this -> view -> facebook = $facebook;
		$this -> view -> twitter = $twitter;
		$this -> view -> pinterest = $pinterest;
		$this -> view -> youtube = $youtube;
	}
	
	
	
	public function editAction()
	{
		$name = $this->_getParam('edit_name');
		$setting_name = "";
		switch ($name) {
			
			case 'Facebook':
					$setting = Engine_Api::_() -> getApi('settings', 'core') -> getSetting('facebook.avdmenusystem.sociallink');
					$setting_name = "facebook.avdmenusystem.sociallink";
				break;
				
			case 'Twitter':
					$setting = Engine_Api::_() -> getApi('settings', 'core') -> getSetting('twitter.avdmenusystem.sociallink');
					$setting_name = "twitter.avdmenusystem.sociallink";
				break;
				
			case 'Pinterest':
					$setting = Engine_Api::_() -> getApi('settings', 'core') -> getSetting('pinterest.avdmenusystem.sociallink');
					$setting_name = "pinterest.avdmenusystem.sociallink";
				break;
				
			case 'Youtube':
					$setting = Engine_Api::_() -> getApi('settings', 'core') -> getSetting('youtube.avdmenusystem.sociallink');
					$setting_name = "youtube.avdmenusystem.sociallink";
				break;			
			
			default:
				
				break;
		}
		if(!$setting)
		{
			Engine_Api::_() -> getApi('settings', 'core') -> setSetting($setting_name, Zend_JSON::encode(array('title'=>$name)));
			$setting = Engine_Api::_() -> getApi('settings', 'core') -> getSetting($setting_name);
		}
		$this -> view -> form = $form = new Advmenusystem_Form_Admin_SocialLink();
		$url = (_ENGINE_SSL ? 'https://' : 'http://') . $_SERVER['HTTP_HOST'] . $this -> view -> url(array('controller' => 'files'), 'admin_default', true);
		$form -> addNotice($this -> view -> translate('Please go to <a href = "%s" target = "_blank">File & Media Manager</a> to upload icon.', $url));
		if (!$this -> getRequest() -> isPost())
		{
			$form -> populate(Zend_JSON::decode($setting));
			return;
		}
		if (!$form -> isValid($this -> getRequest() -> getPost()))
		{
			return;
		}
		$values = $form -> getValues();
		Engine_Api::_() -> getApi('settings', 'core') -> setSetting($setting_name, Zend_JSON::encode($values));
		return $this -> _forward('success', 'utility', 'core', array(
			'messages' => array(Zend_Registry::get('Zend_Translate') -> _('Social Link Edited.')),
			'layout' => 'default-simple',
			'parentRefresh' => true,
		));
	}
	
}
