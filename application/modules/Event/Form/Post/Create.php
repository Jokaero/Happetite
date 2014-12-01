<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Create.php 10264 2014-06-06 22:08:42Z lucas $
 * @author     John
 */

/**
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Event_Form_Post_Create extends Engine_Form
{
  public function init()
  {
    $this
      ->setTitle('Reply')
      ->setAction(
        Zend_Controller_Front::getInstance()->getRouter()
        ->assemble(array('action' => 'post', 'controller' => 'topic'), 'event_extended', true)
      );
    
    $viewer = Engine_Api::_()->user()->getViewer();
    $settings = Engine_Api::_()->getApi('settings', 'core');
    
    $allowHtml = (bool) $settings->getSetting('event_html', 0);
    $allowBbcode = (bool) $settings->getSetting('event_bbcode', 0);
    
    if( !$allowHtml ) {
      $filter = new Engine_Filter_HtmlSpecialChars();
    } else {
      $filter = new Engine_Filter_Html();
      $filter->setForbiddenTags();
      $allowed_tags = array_map('trim', explode(',', Engine_Api::_()->authorization()->getPermission($viewer->level_id, 'event', 'commentHtml')));
      $filter->setAllowedTags($allowed_tags);
    }
    
    if ( $allowHtml || $allowBbcode ) {
     $upload_url = "";
    
      if(Engine_Api::_()->authorization()->isAllowed('album', $user, 'create')){
        $upload_url = Zend_Controller_Front::getInstance()->getRouter()->assemble(array('action'=>'upload-photo'),'event_photo',true);

      }

      $editorOptions = array(
        'upload_url' => $upload_url,
        'bbcode' => $settings->getSetting('forum_bbcode', 0),
        'html' => $settings->getSetting('forum_html', 0)
      );

      if (!empty($upload_url))
      {
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
        'editorOptions' => $editorOptions,
        'required' => true,
        'allowEmpty' => false,
        'decorators' => array('ViewHelper'),
        'filters' => array(
          $filter,
          new Engine_Filter_Censor(),
        ),
      ));     
    } else {    
      $this->addElement('Textarea', 'body', array(
        'label' => 'Body',
        'allowEmpty' => false,
        'required' => true,
        'filters' => array(
          new Engine_Filter_HtmlSpecialChars(),
          new Engine_Filter_Censor(),
          //new Engine_Filter_EnableLinks(),
        ),
      ));
      
    }

    $this->addElement('Checkbox', 'watch', array(
      'label' => 'Send me notifications when other members reply to this topic.',
      'value' => '1',
    ));

    $this->addElement('Button', 'submit', array(
      'label' => 'Post Reply',
      'ignore' => true,
      'type' => 'submit',
    ));

    $this->addElement('Hidden', 'topic_id', array(
      'order' => '920',
      'filters' => array(
        'Int'
      )
    ));
    
    $this->addElement('Hidden', 'ref');
  }
}