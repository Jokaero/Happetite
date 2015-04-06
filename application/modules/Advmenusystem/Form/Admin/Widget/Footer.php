<?php

class Advmenusystem_Form_Admin_Widget_Footer extends Core_Form_Admin_Widget_Standard
{
  public function init()
  {
    parent::init();
    
    // Set form attributes
    $this
      ->setDescription('Shows your site-wide main logo or title. Icons are uploaded via the Social Link Manager.')
      ;

	$this->addElement('Text', 'title',array(
				'label' => 'Title'
	));
	
	$this->addElement('Radio', 'show_language_dropdown',array(
				'label' => 'Do you want to show language dropdown ?',
				'multiOptions' => array(
						1 => 'Yes.',
						0 => 'No.',
				),
				'value' => 1,
	));
	$this->addElement('Radio','show_facebook',array(
				'label' => 'Do you want to show Facebook link ?',
				'multiOptions' => array(
						1 => 'Yes.',
						0 => 'No.',
				),
				'value' => 1,
	));
	$this->addElement('Radio','show_twitter',array(
				'label' => 'Do you want to show Twitter link ?',
				'multiOptions' => array(
						1 => 'Yes.',
						0 => 'No.',
				),
				'value' => 1,
	));
	$this->addElement('Radio','show_pinterest',array(
				'label' => 'Do you want to show Pinterest link ?',
				'multiOptions' => array(
						1 => 'Yes.',
						0 => 'No.',
				),
				'value' => 1,
	));
	$this->addElement('Radio','show_youtube',array(
				'label' => 'Do you want to show YouTube link ?',
				'multiOptions' => array(
						1 => 'Yes.',
						0 => 'No.',
				),
				'value' => 1,
	));
						
  }
}