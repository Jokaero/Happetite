<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Fields
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Birthdate.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Fields
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @author     John
 */
class Fields_Form_Admin_Field_Birthdate extends Fields_Form_Admin_Field
{
  public function init()
  {
    parent::init();

    // Add minimum age
    $this->addElement('Integer', 'min_age', array(
      'label' => 'Minimum Age',
    ));
  }
}