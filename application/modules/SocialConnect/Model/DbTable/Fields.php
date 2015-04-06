<?php

class SocialConnect_Model_DbTable_Fields extends Engine_Db_Table
{
	protected $_name = 'socialconnect_fields';

	public function getProfileFieldStructure($service)
	{

		$db = $this -> getAdapter();
		$select = $this -> select()
					->from($this->info('name'),array('opt_id','field')) 
					-> where('service= ?', (string)$service) 
					-> where('opt_id <> ?', '') 
					-> where('field <> ?', '');
		return $db -> fetchPairs($select);
	}

	public function getProfileFields()
	{

		$maps = array();

		$skipTypes = array('heading' => 1, );

		$topStructure = Engine_Api::_() -> fields() -> getFieldStructureTop('user');

		foreach ($topStructure as $structure)
		{
			if ($structure -> getChild() -> type == 'profile_type')
			{
				$profileTypeField = $structure -> getChild();
				$options = $profileTypeField -> getOptions();

				foreach ($options as $option)
				{

					$profileLabel = $option -> label;
					$topLevelId = $profileTypeField -> field_id;
					$topLevelValue = $option -> option_id;
					$fields = Engine_Api::_() -> fields() -> getFieldsStructureFull('user', $topLevelId, $topLevelValue);

					foreach ($fields as $fskey => $map)
					{
						$field = $map -> getChild();
						$type = $field -> type;
						if (isset($skipTypes[$type]))
						{
							continue;
						}
						$maps[] = array(
							'label' => $field -> label,
							'type' => $type,
							'field_id' => $fskey,
							'profile_label' => $profileLabel,
							'profile_id' => $topLevelValue,
						);
					}
				}
			}
		}
		return $maps;
	}

	public function getValues($service)
	{

		$return = array();

		if (!is_string($service))
		{
			return $return;
		}

		$adapter = Engine_Db_Table::getDefaultAdapter();
		$sql = "
            select concat('pfid_',t1.field) as name, t1.opt_id as value
            from engine4_socialconnect_fields as t1
            where t1.service = '$service'";

		$rs = $adapter -> fetchPairs($sql);

		return $rs;
	}

	/**
	 * @param string $service
	 * @param string $field
	 */

	public function getItem($service, $field)
	{

		$select = $this -> select() -> where('service = ?', $service) -> where('field = ?', $field);

		$item = $this -> fetchRow($select);

		if (!$item)
		{
			$item = $this -> createRow();
			$item -> service = $service;
			$item -> field = $field;
		}
		return $item;
	}

}
