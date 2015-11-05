<?php
/**
 * SocialEngine
 *
 * @category   Engine
 * @package    Engine_Form
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: MultiText.php 9747 2012-07-26 02:08:08Z john $
 */

/**
 * @category   Engine
 * @package    Engine_Form
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Event_Form_Element_MultiTextarea extends Zend_Form_Element_Xhtml
{
  public $helper = 'formMultiTextarea';

  protected $_isArray = true;
  
  /**
   * Load default decorators
   *
   * @return void
   */
  public function loadDefaultDecorators()
  {
    if( $this->loadDefaultDecoratorsIsDisabled() )
    {
      return;
    }

    $decorators = $this->getDecorators();
    if( empty($decorators) )
    {
      $this->addDecorator('ViewHelper');
      Engine_Form::addDefaultDecorators($this);
    }
  }
  
  public function setValue($data)
  {
    $dataUnserialized = unserialize($data);
    
    if (is_string($data) and is_array($dataUnserialized)) {
      return parent::setValue(array_diff($dataUnserialized, array('')));
    } else {
      return parent::setValue($data);
    }
  }
  
  public function getValue()
  {
    $data = parent::getValue();
    $clearData = array_diff($data, array(''));
    
    if (is_array($data) and !empty($clearData)) {
      return serialize($clearData);
    } else if (is_array($data) and empty($clearData)) {
      return false;
    } else {
      return $data;
    }
  }
  
  public function isValid($data)
  {
    $clearData = array_diff($data, array(''));
    if (is_array($data) and !empty($clearData)) {
      return parent::isValid($clearData);
    } else {
      return parent::isValid($data);
    }
  }
}