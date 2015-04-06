<?php
class Advmenusystem_Form_Admin_Menu_ItemDelete extends Engine_Form
{
	protected $_hasContent;

	public function getHasContent()
	{
		return $this -> _hasContent;
	}
	public function setHasContent($hasContent)
	{
		$this -> _hasContent= $hasContent;
	}

	public function init()
	{
		$this
		->setTitle('Delete Menu Item')
		->setAttrib('class', 'global_form_popup');
		
		if($this -> _hasContent)
		{
			$this->addElement('Select', 'move_content_to', array(
	             'label' => 'Move Content To Menu',
	             'multiOptions' => array('none'=>'None'),
			));
		}
		// Buttons
		$this->addElement('Button', 'submit', array(
			'label' => 'Delete Menu Item',
			'type' => 'submit',
			'ignore' => true,
			'decorators' => array('ViewHelper')
		));

		$this->addElement('Cancel', 'cancel', array(
			'label' => 'cancel',
			'link' => true,
			'prependText' => ' or ',
			'href' => '',
			'onclick' => 'parent.Smoothbox.close();',
			'decorators' => array(
				'ViewHelper'
			)
		));

		$this->addDisplayGroup(array('submit', 'cancel'), 'buttons');
	}
}
