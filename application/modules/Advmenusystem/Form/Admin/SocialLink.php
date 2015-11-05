<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.net/license/
 * @version    $Id: ItemCreate.php 7244 2010-09-01 01:49:53Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.net/license/
 */
class Advmenusystem_Form_Admin_SocialLink extends Engine_Form
{
  public function init()
  {
  	$view = Zend_Registry::get('Zend_View');
    $view->headScript()->appendFile(Zend_Registry::get('StaticBaseUrl') . 'application/modules/Advmenusystem/externals/scripts/jscolor.js');
    $this
      ->setTitle('Edit Social Link')
      ->setAttrib('class', 'global_form_popup')
      ;

    $this->addElement('Text', 'title', array(
    	'label' => 'Title',
		'readonly' => true,    
	 )); 
	
	
    $this->addElement('Text', 'uri', array(
      'label' => 'URL',
      'required' => true,
      'allowEmpty' => false,
      'style' => 'width: 300px',
    ));
    
     // Get available files
    $logoOptions = array('' => 'Text-only (No images)');
    $imageExtensions = array('gif', 'jpg', 'jpeg', 'png');

    $it = new DirectoryIterator(APPLICATION_PATH . '/public/admin/');
    foreach( $it as $file ) {
      if( $file->isDot() || !$file->isFile() ) continue;
      $basename = basename($file->getFilename());
      if( !($pos = strrpos($basename, '.')) ) continue;
      $ext = strtolower(ltrim(substr($basename, $pos), '.'));
      if( !in_array($ext, $imageExtensions) ) continue;
      $logoOptions['public/admin/' . $basename] = $basename;
    }

    $this->addElement('Select', 'icon', array(
      'label' => 'Icon',
      'multiOptions' => $logoOptions,
    ));
	
    // Buttons
    $this->addElement('Button', 'submit', array(
      'label' => 'Edit Social Link',
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