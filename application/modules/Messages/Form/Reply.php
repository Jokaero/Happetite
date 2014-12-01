<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Messages
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Reply.php 9835 2012-11-29 00:35:00Z pamela $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Messages
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Messages_Form_Reply extends Engine_Form
{
  public function init()
  {
    $this
      //->setAttrib('class', 'global_form_box')
      //->setDecorators(array('FormElements', 'Form'))
      ->setAction(Zend_Controller_Front::getInstance()->getRouter()->assemble(array()))
      ;
      
    // init body - editor
    $user_level = Engine_Api::_()->user()->getViewer()->level_id;
    $editor = Engine_Api::_()->getDbtable('permissions', 'authorization')->getAllowed('messages', $user_level, 'editor');
    
    if ( $editor == 'editor' ) {
      $this->addElement('TinyMce', 'body', array(
        'disableLoadDefaultDecorators' => true,
        //'order' => 1,
        'required' => true,
        'editorOptions' => array(
          'bbcode' => true,
          'html' => true,
        ),
        'allowEmpty' => false,
        'decorators' => array(
            'ViewHelper',
            'Label',
            array('HtmlTag', array('style' => 'display: block;'))),
        'filters' => array(
          new Engine_Filter_HtmlSpecialChars(),
          new Engine_Filter_Censor(),
          new Engine_Filter_EnableLinks(),
        ),
      )); 
    } else {
      // init body - plain text
      $this->addElement('Textarea', 'body', array(
        'allowEmpty' => false,
        'required' => true,
        'filters' => array(
          new Engine_Filter_HtmlSpecialChars(),
          new Engine_Filter_Censor(),
          new Engine_Filter_EnableLinks(),
        ),
      ));
    }
    // init submit
    $this->addElement('Button', 'submit', array(
      'label' => 'Send Reply',
      'type' => 'submit',
      'ignore' => true
    ));
  }
}