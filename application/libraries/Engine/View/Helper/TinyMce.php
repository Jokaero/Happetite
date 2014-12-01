<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: TinyMce.php 10118 2013-11-20 17:15:32Z andres $
 */

/**
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Engine_View_Helper_TinyMce extends Zend_View_Helper_Abstract
{
  protected $_enabled = false;
  protected $_defaultScript = 'externals/tinymce/tinymce.min.js';
  protected $_html = true;
  protected $_bbcode = false;
  protected $_supported = array(
    'mode' => array(
      'textareas', 'specific_textareas', 'exact', 'none'
    ),
    'theme' => array(
      'modern'
    ),
    'format' => array(
      'html', 'xhtml'
    ),
    'languages' => array(
      'ar', 'bg_BG', 'bs', 'ca', 'cs', 'cy', 'da', 'de', 'de_AT', 'el', 'en',
      'es', 'et', 'eu', 'fa', 'fi', 'fo', 'fr_FR', 'gl', 'he_IL', 'hr', 'hu_HU',
      'hy', 'id', 'it', 'ja', 'ka_GE', 'ko_KR', 'lb', 'lt', 'lv', 'nb_NO', 'nl',
      'pl', 'pt_BR', 'pt_PT', 'ro', 'ru', 'si_LK', 'sk', 'sl_SI', 'sr', 'sv_SE',
      'ta', 'ta_IN', 'tg', 'th_TH', 'tr_TR', 'ug', 'uk', 'uk_UA', 'vi', 'vi_VN',
      'zh_CN', 'zh_TW'
    ),
    'directionality' => array(
      'rtl', 'ltr',
    ),
    'plugins' => array(
      'advlist', 'anchor', 'autolink', 'autoresize', 'autosave', 'bbcode',
      'charmap', 'code', 'compat3x', 'contextmenu', 'directionality',
      'emoticons', 'example', 'example_dependency', 'fullpage', 'fullscreen',
      'hr', 'image', 'insertdatetime', 'layer', 'legacyoutput', 'link', 'lists',
      'importcss', 'media', 'nonbreaking', 'noneditable', 'pagebreak', 'paste',
      'preview', 'print', 'save', 'searchreplace', 'spellchecker', 'tabfocus',
      'table', 'template', 'textcolor', 'visualblocks', 'visualchars',
      'wordcount', 'jbimages'
    ),
  );
  protected $_config = array(
    'mode' => 'textareas',
    'plugins' => array(
      'table', 'fullscreen', 'media', 'preview', 'paste', 'code', 'image',
      'textcolor'
    ),
    'theme' => 'modern',
    'menubar' => false,
    'statusbar' => false,
    'toolbar1' => array(
      'undo', 'redo', 'removeformat', 'pastetext', '|', 'code', 'media',
      'image', 'link', 'fullscreen', 'preview'
    ),
    'toolbar2' => '',
    'toolbar3' => '',
    'element_format' => 'html',
    'height' => '225px',
    'convert_urls' => false
  );
  protected $_scriptPath;
  protected $_scriptFile;

  public function __set($name, $value)
  {
	  $method = 'set' . $name;
	  if( !method_exists($this, $method) ) {
      throw new Engine_Exception('Invalid tinyMce property');
    }
    $this->$method($value);
  }

  public function __get($name)
  {
    $method = 'get' . $name;
    if( !method_exists($this, $method) ) {
      throw new Engine_Exception('Invalid tinyMce property');
    }
    return $this->$method();
  }

  public function setOptions(array $options)
  {
    $methods = get_class_methods($this);
    foreach( $options as $key => $value ) {
      $method = 'set' . ucfirst($key);
      if( in_array($method, $methods) ) {
        $this->$method($value);
      } else {
        $this->_config[$key] = $value;
      }
    }
    return $this;
  }

  public function TinyMce()
  {
    return $this;
  }

  public function setBbcode($value)
  {
    $this->_bbcode = (bool) $value;
    $this->updateSettings();
  }

  public function setHtml($value)
  {
    $this->_html = (bool) $value;
    $this->updateSettings();
  }

  public function setLanguage($language)
  {
    if( !in_array($language, $this->_supported['languages']) ) {
      list($language) = explode('_', $language);
      if( !in_array($language, $this->_supported['languages']) ) {
        return $this;
      }
    }

    $this->_config['language'] = $language;

    return $this;
  }

  public function setDirectionality($directionality)
  {
    if( in_array($directionality, $this->_supported['directionality']) ) {
      $this->_config['directionality'] = $directionality;
    }

    return $this;
  }

  public function updateSettings()
  {
    if( $this->_html ) { // HTML
      $this->_config['toolbar2'] = array(
        'fontselect', 'fontsizeselect', 'bold', 'italic', 'underline',
        'strikethrough', 'forecolor', 'backcolor', '|', 'alignleft',
        'aligncenter', 'alignright', 'alignjustify', '|', 'bullist',
        'numlist', '|', 'outdent', 'indent', 'blockquote',
      );
    } else if( $this->_bbcode ) { // BBCODE
      $this->_config['plugins'][] = 'bbcode';
      $this->_config['content_css'] = "bbcode.css";
      $this->_config['entity_encoding'] = "raw";
      $this->_config['add_unload_trigger'] = 0;
      $this->_config['remove_linebreaks'] = false;
      $this->_config['toolbar1'] = array(
        'bold', 'italic', 'underline', 'undo', 'redo', 'link', 'unlink',
        'image', 'forecolor', 'removeformat', 'code',
      );
    } else { // Nothing
      $this->_config['toolbar1'] = '';
    }
  }

  public function setScriptPath($path)
  {
    $this->_scriptPath = rtrim($path, '/');
    return $this;
  }

  public function setScriptFile($file)
  {
    $this->_scriptFile = (string) $file;
  }

  public function render()
  {
    if( false === $this->_enabled ) {
      $this->_renderScript();
      $this->_renderEditor();
    }
    $this->_enabled = true;
  }

  protected function _renderScript()
  {
    if( null === $this->_scriptFile ) {
      $script = $this->view->baseUrl() . '/' . $this->_defaultScript;
    } else {
      if( null === $this->_scriptPath ) {
        $this->_scriptPath = $this->view->baseUrl();
      }
      $script = $this->_scriptPath . '/' . $this->_scriptFile;
    }

    $this->view->headScript()->appendFile($script);
    return $this;
  }

  protected function _renderEditor()
  {
    $script = 'tinymce.init({' . PHP_EOL;

    $length = count($this->_config);
    $i = 0;
    foreach( $this->_config as $name => $value ) {
      if( is_array($value) ) {
        $value = implode(',', $value);
      }
      if( !is_bool($value) ) {
        $value = '"' . $value . '"';
      } else {
        $value = ( $value ? 'true' : 'false' );
      }
      $script .= $name . ': ' . $value . ($i == $length - 1 ? '' : ',') . PHP_EOL;
      $i++;
    }

    $script .= '});';

    $this->view->headScript()->appendScript($script);
    return $this;
  }
}
