<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Announcement
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Delete.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Announcement
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Announcement_Form_Admin_Delete extends Engine_Form
{
  public function init()
  {
    $this->setTitle('Delete Announcement')
      ->setDescription('Are you sure you want to delete this announcement?');

    $this->addElement('Button', 'submit', array(
      'label' => 'Delete Announcement',
      'type' => 'submit',
    ));

    $this->addElement('Button', 'cancel', array(
      'label' => 'cancel',
      'onclick' => 'window.location.href="'.Zend_Controller_Front::getInstance()->assemble().'";'
    ));
  }
}