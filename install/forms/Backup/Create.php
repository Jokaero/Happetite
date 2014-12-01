<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Install
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Create.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Install
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Install_Form_Backup_Create extends Engine_Form
{
  public function init()
  {
    $this->addElement('Text', 'name', array(
      'label' => 'Name',
      'value' => date('Y-m-d-H-i-s') . '.tar',
      //'value' => date('YmdHis') . '.tar',
    ));

    $this->addElement('Button', 'execute', array(
      'type' => 'submit',
      'label' => 'Create Backup',
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