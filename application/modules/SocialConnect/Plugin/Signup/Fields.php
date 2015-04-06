<?php
class SocialConnect_Plugin_Signup_Fields extends User_Plugin_Signup_Fields {
	protected $_name = 'fields';
  	protected $_formClass = 'User_Form_Signup_Fields';
  	protected $_script = array('signup/form/fields.tpl', 'user');
  	protected $_adminFormClass = 'User_Form_Admin_Signup_Fields';
    protected $_adminScript = array('admin-signup/fields.tpl', 'user');
	public function getForm() {
		$formArgs = array();
		// Preload profile type field stuff
		$profileTypeField = $this -> getProfileTypeField();
		if ($profileTypeField) {
			$accountSession = new Zend_Session_Namespace('User_Plugin_Signup_Account');
			$profileTypeValue = @$accountSession -> data['profile_type'];
			if ($profileTypeValue) {
				$formArgs = array('topLevelId' => $profileTypeField -> field_id, 'topLevelValue' => $profileTypeValue, );
			} else {
				$topStructure = Engine_Api::_() -> fields() -> getFieldStructureTop('user');
				if (count($topStructure) == 1 && $topStructure[0] -> getChild() -> type == 'profile_type') {
					$profileTypeField = $topStructure[0] -> getChild();
					$options = $profileTypeField -> getOptions();
					if (count($options) == 1) {
						$formArgs = array('topLevelId' => $profileTypeField -> field_id, 'topLevelValue' => $options[0] -> option_id, );
					}
				}
			}
		}

		// Create form
		Engine_Loader::loadClass($this -> _formClass);
		$class = $this -> _formClass;
		$this -> _form = new $class($formArgs);
		$fieldsSession = new Zend_Session_Namespace('User_Plugin_Signup_Fields');
		$this -> setSession($fieldsSession);
		$data = $this -> getSession() -> data;
		if (!empty($data)) {
			foreach ($data as $key => $val) {
				$el = $this -> _form -> getElement($key);
				if ($el instanceof Zend_Form_Element) {
					$el -> setValue($val);
				}
			}
		}
		return $this -> _form;
	}

}
