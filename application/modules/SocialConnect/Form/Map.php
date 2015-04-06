<?php

class SocialConnect_Form_Map extends Engine_Form
{
	public function init()
	{
	}

	public function populateData($service)
	{
		$api = Engine_Api::_() -> getApi('Core', 'SocialConnect');
		$table = Engine_Api::_() -> getDbTable('Fields', 'SocialConnect');
		$service = $api -> getMapService($service);
		$options = $api -> getServiceFields($service);
		$profileFields = $table -> getProfileFields();
		$values = $table -> getProfileFieldStructure($service);
		$counter = 0;

		$view = Zend_Registry::get('Zend_View');
		foreach ($profileFields as $field)
		{
			$profileLabel = $field['profile_label'];
			$profileId = $field['profile_id'];
			if (!$values)
				$value = $field['type'];
			else
				$value = $values[$field['field_id']];

			if ($field['type'] == 'profile_type')
			{
				$id = 'profile_type_' . ($counter++);
				$content = sprintf('<h3>Profile Type: %s</h3><p>This configure is apply for profile type: <a href="%s/admin/user/fields?option_id=%s">%s</a></p>', $profileLabel, $view -> baseUrl(), $profileId, $profileLabel);
				$this -> addElement('Dummy', $id, array(
					'content' => $content,
					'decorators' => array('ViewHelper')
				));
			}
			else
			{
				$this -> addElement('select', "pfid_" . $field['field_id'], array(
					'label' => $field['label'],
					'multiOptions' => $options,
					'value' => $value,
				));
			}
		}

		// Init submit

		/**
		 * add button groups
		 */
		$this -> addElement('Button', 'submit', array(
			'label' => 'Save Changes',
			'type' => 'submit',
			'ignore' => true,
			'decorators' => array('ViewHelper', ),
		));

		// Element: cancel
		$this -> addElement('Cancel', 'cancel', array(
			'label' => 'Cancel',
			'link' => true,
			'prependText' => ' or ',
			'onclick' => 'parent.Smoothbox.close()',
			'decorators' => array('ViewHelper', ),
		));
		// DisplayGroup: buttons
		$this -> addDisplayGroup(array(
			'submit',
			'cancel',
		), 'buttons', array('decorators' => array(
				'FormElements',
				'DivDivDivWrapper'
			), ));

	}

	public function commitSave($service)
	{
		$api = Engine_Api::_() -> getApi('Core', 'SocialConnect');

		$service = $api -> getMapService($service);

		$data = $this -> getValues();
		$table = Engine_Api::_() -> getDbTable('Fields', 'SocialConnect');

		try
		{
			$where = "service = '" . $service . "'";
			$table -> delete($where);
			foreach ($data as $pfid => $field)
			{
				if (strpos($pfid, 'pfid_') === 0)
				{
					$opt_id = str_replace('pfid_', '', $pfid);
					$item = $table -> getItem($service, $field);
					$item -> opt_id = $opt_id;
					$item -> save();
				}
			}
		}
		catch(Exception $e)
		{
			$this -> setDescription($e -> getMessage());
			return false;
		}
		return true;
	}

}
