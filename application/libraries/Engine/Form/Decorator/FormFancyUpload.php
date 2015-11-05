<?php
/**
 * SocialEngine
 *
 * @category   Engine
 * @package    Engine_Form
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: FormFancyUpload.php 9881 2013-02-13 20:07:49Z john $
 */

/**
 * @category   Engine
 * @package    Engine_Form
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Engine_Form_Decorator_FormFancyUpload extends Zend_Form_Decorator_Abstract
{
  public function render($content)
  {
    $data = $this->getElement()->getAttrib('data');
    if( $data ) {
      $this->getElement()->setAttrib('data', null);
    }
    $view = $this->getElement()->getView();
    return $view->partial('upload/upload.tpl', 'storage', array(
      'name' => $this->getElement()->getName(),
      'data' => $data,
      'element' => $this->getElement()
    ));
  }
}
