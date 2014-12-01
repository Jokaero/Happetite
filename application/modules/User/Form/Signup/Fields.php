<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Fields.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class User_Form_Signup_Fields extends Fields_Form_Standard
{
  protected $_fieldType = 'user';

  public function init()
  {
    // Init form
    $this->setTitle('Profile Information');

    $this
      ->setIsCreation(true)
      ->setItem(Engine_Api::_()->user()->getUser(null));
    parent::init();
  }
}