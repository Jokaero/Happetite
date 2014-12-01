<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Install
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Restore.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Install
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Install_Form_Backup_Restore extends Engine_Form
{
  public function init()
  {
    $this->setTitle('Restore Backup')
      ->setDescription('Are you sure you want to restore this backup? All data on your site created after the backup will be lost.');

//    $this->addElement('Checkbox', 'wipe', array(
//      'label' => 'Delete existing files first?',
//    ));

    $this->addElement('Button', 'execute', array(
      'type' => 'submit',
      'label' => 'Restore Backup',
      'decorators' => array(
        'ViewHelper',
      ),
    ));

    $this->addElement('Cancel', 'cancel', array(
      'link' => true,
      'prependText' => ' or ',
      'label' => 'cancel',
      'href' => Zend_Controller_Front::getInstance()->getRouter()->assemble(array('action' => 'index')),
      'decorators' => array(
        'ViewHelper',
      ),
    ));

    $this->addDisplayGroup(array('execute', 'cancel'), 'buttons');
  }
}