<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Messages
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Compose.php 10246 2014-05-30 21:34:20Z andres $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Messages
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Messages_Form_Compose extends Engine_Form
{
  public function init()
  {
    $this->setTitle('Compose Message');
    $this->setDescription('Create your new message with the form below. Your message can be addressed to up to 10 recipients.')
       ->setAttrib('id', 'messages_compose');;
    $user_level = Engine_Api::_()->user()->getViewer()->level_id;
    
    // init to
    $this->addElement('Text', 'to',array(
        'label'=>'Send To',
        'autocomplete'=>'off'));

    Engine_Form::addDefaultDecorators($this->to);

    // Init to Values
    $this->addElement('Hidden', 'toValues', array(
      'label' => 'Send To',
      'required' => true,
      'allowEmpty' => false,
      'order' => 2,
      'validators' => array(
        'NotEmpty'
      ),
      'filters' => array(
        'HtmlEntities'
      ),
    ));
    Engine_Form::addDefaultDecorators($this->toValues);

    // init title
    $this->addElement('Text', 'title', array(
      'label' => 'Subject',
      'order' => 3,
      'filters' => array(
        new Engine_Filter_Censor(),
        new Engine_Filter_HtmlSpecialChars(),
      ),
    ));
    
    // init body - editor
    $editor = Engine_Api::_()->getDbtable('permissions', 'authorization')->getAllowed('messages', $user_level, 'editor');
    
    if ( $editor == 'editor' ) {
      $editorOptions = array(
          'bbcode' => true,
          'html' => true,
      );

      if(Engine_Api::_()->authorization()->isAllowed('album', $user, 'create')){
        $upload_url = Zend_Controller_Front::getInstance()->getRouter()->assemble(array('action' => 'upload-photo'), 'messages_general', true);
      }

      if (!empty($upload_url))
      {
        $editorOptions['upload_url'] = $upload_url;

        $editorOptions['plugins'] = array(
          'table', 'fullscreen', 'media', 'preview', 'paste',
          'code', 'image', 'textcolor', 'jbimages', 'link'
        );

        $editorOptions['toolbar1'] = array(
          'undo', 'redo', 'removeformat', 'pastetext', '|', 'code',
          'media', 'image', 'jbimages', 'link', 'fullscreen',
          'preview'
        );
      }

      $this->addElement('TinyMce', 'body', array(
        'disableLoadDefaultDecorators' => true,
        'order' => 4,
        'required' => true,
        'editorOptions' => $editorOptions,
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
        'label' => 'Message',
        'order' => 4,
        'required' => true,
        'allowEmpty' => false,
        'filters' => array(
          new Engine_Filter_HtmlSpecialChars(),
          new Engine_Filter_Censor(),
          new Engine_Filter_EnableLinks(),
        ),
      ));
    }
    // init submit
    $this->addElement('Button', 'submit', array(
      'label' => 'Send Message',
      'order' => 5,
      'type' => 'submit',
      'ignore' => true
    ));
  }
}