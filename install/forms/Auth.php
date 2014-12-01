<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Install
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Auth.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Install
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Install_Form_Auth extends Engine_Form
{
  public function init()
  {
    $this->addElement('Text', 'email', array(
      'label' => 'Email Address',
      'required' => true,
      'allowEmpty' => false,
    ));

    $this->addElement('Password', 'password', array(
      'label' => 'Password',
      'required' => true,
      'allowEmpty' => false,
    ));

    // Submit
    $this->addElement('Button', 'submit', array(
      'label' => 'Continue',
      'type' => 'submit',
      'ignore' => true,
    ));
  }
}