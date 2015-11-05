<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Affiliate.php 9747 2012-07-26 02:08:08Z john $
 * @author     John Boehr <john@socialengine.com>
 */

/**
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Core_Form_Admin_Settings_Affiliate extends Engine_Form
{
  public function init()
  {
    // Set form attributes
    $this->setTitle('SocialEngine Affiliate Program');
    $this->setDescription('Earn back your SocialEngine product feeds and ' . 
        'more! Just enter your affiliate ID below.');

    $this->addElement('Text', 'code', array(
      'label' => 'Affiliate ID',
      'description' => 'More Info: ' . 
          '<a href="http://www.socialengine.com/affiliate" target="_blank">' . 
          'http://www.socialengine.com/affiliate</a>',
      'filters' => array(
        'StringTrim',
      ),
    ));
    $this->getElement('code')->getDecorator('description')
        ->setOption('escape', false)
        ->setOption('placement', 'APPEND');
    
    // init submit
    $this->addElement('Button', 'submit', array(
      'label' => 'Save Changes',
      'type' => 'submit',
      'ignore' => true,
    ));
  }
}
