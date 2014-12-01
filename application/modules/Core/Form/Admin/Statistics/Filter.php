<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Filter.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Core_Form_Admin_Statistics_Filter extends Engine_Form
{
  public function init()
  {
    $this
      ->setAttrib('class', 'global_form_box')
      ->addDecorator('FormElements')
      ->addDecorator('Form')
      ->setAction(Zend_Controller_Front::getInstance()->getRouter()->assemble(array()))
      ;

    // Init mode
    $this->addElement('Select', 'mode', array(
      'multiOptions' => array(
        'normal' => 'All',
        'cumulative' => 'Cumulative',
        'delta' => 'Change in',
      ),
      'value' => 'normal',
      'decorators' => array(
        'ViewHelper',
        array('HtmlTag', array('tag' => 'div')),
      ),
    ));

    $this->addElement('Select', 'type', array(
      'multiOptions' => array(
        'core.views' => 'Page views',
      ),
      'value' => 'core.views',
      'decorators' => array(
        'ViewHelper',
        array('HtmlTag', array('tag' => 'div')),
      ),
    ));

    // Init period
    $this->addElement('Select', 'period', array(
      'multiOptions' => array(
        //'day' => 'Today',
        Zend_Date::WEEK => 'This week',
        Zend_Date::MONTH => 'This month',
        Zend_Date::YEAR => 'This year',
      ),
      'value' => 'month',
      'decorators' => array(
        'ViewHelper',
        array('HtmlTag', array('tag' => 'div')),
      ),
    ));

    // Init chunk
    $this->addElement('Select', 'chunk', array(
      'multiOptions' => array(
        Zend_Date::DAY => 'By Day',
        Zend_Date::WEEK => 'By Week',
        Zend_Date::MONTH => 'By Month',
        Zend_Date::YEAR => 'By Year',
      ),
      'value' => 'day',
      'decorators' => array(
        'ViewHelper',
        array('HtmlTag', array('tag' => 'div')),
      ),
    ));

    // Init submit
    $this->addElement('Button', 'submit', array(
      'label' => 'Search',
      'type' => 'submit',
      'onclick' => 'return processStatisticsFilter($(this).getParent("form"))',
      'decorators' => array(
        'ViewHelper',
        array('HtmlTag', array('tag' => 'div')),
      ),
    ));
  }
}