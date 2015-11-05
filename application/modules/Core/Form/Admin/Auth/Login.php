<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Login.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Core_Form_Admin_Auth_Login extends Engine_Form
{
  public function init()
  {
    $this->setTitle('Admin Sign In');
    switch (Engine_Api::_()->getApi('settings', 'core')->core_admin_mode) {
      case 'global':
        $this->setDescription('Please enter the admin password.');
        break;
      case 'user':
        $this->setDescription('Please enter your password again.');
        break;
      case 'none':
      default;
        // form should not be shown
    }

    $this->addElement('Hidden', 'return', array(
      
    ));

    $this->addElement('Password', 'password', array(
      'label' => 'Password',
      'required' => true,
      'allowEmpty' => false,
    ));

    $this->addElement('Button', 'execute', array(
      'type' => 'submit',
      'label' => 'Sign In',
    ));
  }
}