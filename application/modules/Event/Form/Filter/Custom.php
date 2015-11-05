<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Browse.php 9829 2012-11-27 01:13:07Z richard $
 * @author     John
 */

/**
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Event_Form_Filter_Custom extends Engine_Form
{
  public function init()
  {
    $this->clearDecorators()
      ->addDecorators(array(
        'FormElements',
        array('HtmlTag', array('tag' => 'dl')),
        'Form',
      ))
      ->setMethod('get')
      ->setAttrib('class', 'filters')
      ->setAttrib('id', 'filter-form')
      ;
    
    $this->addElement('Select', 'order', array(
      'label' => 'Sort By:',
      'multiOptions' => array(
        'creation_date DESC' => 'Recently Created',
        'starttime ASC' => 'Start Date',
        'price DESC' => 'Price',
      ),
      'decorators' => array(
        'ViewHelper',
        array('HtmlTag', array('tag' => 'dd')),
        array('Label', array('tag' => 'dt', 'placement' => 'PREPEND'))
      ),
      'value' => 'creation_date DESC',
    ));
    
    $this->addElement('Text', 'city', array(
      'label' => 'City:',
      'placeholder' => 'Type City name...',
      'decorators' => array(
        'ViewHelper',
        array('HtmlTag', array('tag' => 'dd')),
        array('Label', array('tag' => 'dt', 'placement' => 'PREPEND'))
      ),
    ));
    
    $this->addElement('Select', 'category_id', array(
      'label' => 'Category:',
      'multiOptions' => array(
        '' => 'All Categories',
      ),
      'decorators' => array(
        'ViewHelper',
        array('HtmlTag', array('tag' => 'dd')),
        array('Label', array('tag' => 'dt', 'placement' => 'PREPEND'))
      ),
    ));

    //$this->addElement('Select', 'view', array(
    //  'label' => 'View:',
    //  'multiOptions' => array(
    //    '' => 'Everyone\'s Events',
    //    '1' => 'Only My Friends\' Events',
    //  ),
    //  'decorators' => array(
    //    'ViewHelper',
    //    array('HtmlTag', array('tag' => 'dd')),
    //    array('Label', array('tag' => 'dt', 'placement' => 'PREPEND'))
    //  ),
    //  'onchange' => '$(this).getParent("form").submit();',
    //));

    //$this->addElement('Select', 'order', array(
    //  'label' => 'List By:',
    //  'multiOptions' => array(
    //    'starttime ASC' => 'Start Date',
    //    'creation_date DESC' => 'Recently Created',
    //    'price DESC' => 'Price',
    //  ),
    //  'decorators' => array(
    //    'ViewHelper',
    //    array('HtmlTag', array('tag' => 'dd')),
    //    array('Label', array('tag' => 'dt', 'placement' => 'PREPEND'))
    //  ),
    //  'value' => 'creation_date DESC',
    //));
    
    $this->addElement('CalendarDateTime', 'date', array(
       'label' => 'Date:',
       'decorators' => array(
        'ViewHelper',
        array('HtmlTag', array('tag' => 'dd')),
        array('Label', array('tag' => 'dt', 'placement' => 'PREPEND'))
      ),
    ));
    
    $this->addElement('Button', 'submit', array(
      'type' => 'submit',
      'label' => 'Search',
      'decorators' => array(
        'ViewHelper',
        array('HtmlTag', array('tag' => 'dd')),
      ),
    ));
  }
}