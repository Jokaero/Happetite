<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Announcement
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Edit.php 9837 2012-11-29 01:12:35Z matthew $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Announcement
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Announcement_Form_Admin_Edit extends Engine_Form
{
  public function init()
  {
    $this->setTitle('Edit Announcement')
      ->setDescription('Please modifiy your announcement below.');    
    
    // Prepare Network options
    $networkOptions = array();
    foreach( Engine_Api::_()->getDbtable('networks', 'network')->fetchAll() as $network) {
      $networkOptions[$network->network_id] = $network->getTitle();
    }   
    
    // Select Networks
    $this->addElement('multiselect', 'networks', array(
      'label' => 'Networks',
      'description' => 'Which Neworks do you want to see this Announcement?',
      'multiOptions' => $networkOptions,
      'required' => false,
      'allowEmpty' => true,
    ));    
    
    // Prepare Member levels
    $levelOptions = array();
    foreach( Engine_Api::_()->getDbtable('levels', 'authorization')->fetchAll() as $level ) {
      $levelOptions[$level->level_id] = $level->getTitle();
    }
    
    // Select Member Levels
    $this->addElement('multiselect', 'member_levels', array(
      'label' => 'Member Levels',
      'description' => 'Which Member Levels do you want to see this Announcement?',
      'multiOptions' => $levelOptions,
      'required' => false,
      'allowEmpty' => true,
    ));
    
    // Prepare Profile Types
    $topStructure = Engine_Api::_()->fields()->getFieldStructureTop('user');
    if( count($topStructure) == 1 && $topStructure[0]->getChild()->type == 'profile_type' ) {
      $profileTypeField = $topStructure[0]->getChild();
      $options = $profileTypeField->getOptions();
      if( count($options) > 1 ) {
        $options = $profileTypeField->getElementParams('user');
        unset($options['options']['order']);
        unset($options['options']['multiOptions']['0']);
        // Select Profile Types
        $this->addElement('multiselect', 'profile_types', array_merge($options['options'], array(
              'required' => false,
              'description' => 'Which Profile Types do you want to see this Announcement?',
              'allowEmpty' => true,
              'tabindex' => $tabIndex++,
            )));
      } else if( count($options) == 1 ) {
        // Empty and Hidden Profile Types
        $this->addElement('Hidden', 'profile_types', array(
          'value' => $options[0]->option_id
        ));
      }
    }
    
    // Add title
    $this->addElement('Text', 'title', array(
      'label' => 'Title',
      'required' => true,
      'allowEmpty' => false,
    ));

    $this->addElement('TinyMce', 'body', array(
      'label' => 'Body',
      'required' => true,
      'editorOptions' => array(
        'bbcode' => true,
        'html' => true,
      ),
      'allowEmpty' => false,
    ));

    $this->addElement('Button', 'submit', array(
      'label' => 'Edit Announcement',
      'type' => 'submit',
      'ignore' => true,
      'decorators' => array(
        'ViewHelper',
      ),
    ));

    $this->addElement('Cancel', 'cancel', array(
      'label' => 'cancel',
      'ignore' => true,
      'link' => true,
      'href' => Zend_Controller_Front::getInstance()->getRouter()->assemble(array('module' => 'announcement', 'controller' => 'manage', 'action' => 'index'), 'admin_default', true),
      'prependText' => Zend_Registry::get('Zend_Translate')->_(' or '),
      'decorators' => array(
        'ViewHelper',
      ),
    ));

    $this->addDisplayGroup(array('submit', 'cancel'), 'buttons');
  }
}