<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Install
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: General.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Install
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Install_Form_Settings_General extends Engine_Form
{
  public function init()
  {
    $this->addElement('Checkbox', 'verbose', array(
      'label' => 'Verbose messages?',
    ));

    $this->addElement('Checkbox', 'automated', array(
      'label' => 'Skip displaying successful steps?'
    ));

    $this->addElement('Checkbox', 'force', array(
      'label' => 'Display an option to force-continue during install?'
    ));

    // Submit
    $this->addElement('Button', 'execute', array(
      'label' => 'Continue',
      'type' => 'submit',
      'ignore' => true,
      'decorators' => array('ViewHelper'),
    ));

    // Cancel
    $this->addElement('Cancel', 'cancel', array(
      'label' => 'cancel',
      'link' => true,
      'prependText' => ' or ',
      'decorators' => array('ViewHelper'),
    ));

    $this->addDisplayGroup(array('execute', 'cancel'), 'buttons');
  }
}