<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: FileUpload.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Core_Form_Admin_Job_FileUpload extends Engine_Form
{
  public function init()
  {
    $this
      ->setTitle('Job: Upload File')
      ->setDescription('This will upload a file to a specified URL.')
      ;

    $this->addElement('Text', 'file', array(
      'label' => 'File',
      'required' => true,
      'allowEmpty' => false,
      //'validators' => array(),
    ));

    $this->addElement('Text', 'url', array(
      'label' => 'URL',
      'required' => true,
      'allowEmpty' => false,
      //'validators' => array(),
    ));

    $this->addElement('Text', 'name', array(
      'label' => 'POST Key',
      'value' => 'Filedata',
    ));

    $this->addElement('Button', 'execute', array(
      'label' => 'Add',
      'type' => 'submit',
      'ignore' => true,
    ));
  }
}