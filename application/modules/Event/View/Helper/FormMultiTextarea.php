<?php
/**
 * SocialEngine
 *
 * @category   Engine
 * @package    Engine_View
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: FormMultiText.php 9747 2012-07-26 02:08:08Z john $
 * @todo       documentation
 */

/**
 * @category   Engine
 * @package    Engine_View
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Event_View_Helper_FormMultiTextarea extends Zend_View_Helper_FormTextarea
{
  public function formMultiTextarea($name, $value = null, $attribs = null)
  {
    $valueUnserialized = unserialize($value);
    if (is_array($valueUnserialized)) {
      $value = $valueUnserialized;
    }
    
    if( null !== $value && is_scalar($value) ) {
      $value = array($value);
    } else if( !is_array($value) ) {
      $value = array();
    }
    $value = array_values($value);

    $separator = '<br class="multi-textarea-separator" />';
    $content = '';
    for( $i = 0, $l = count($value) ? count($value) : 1; $i < $l; $i++ ) {
      //if( $i !== 0 ) {
      //  $content .= $separator;
      //}
      $cAttr = $attribs;
      $cAttr['id'] = trim($name, '[]') . '-' . ($i + 1);
      $cVal = ( isset($value[$i]) ? $value[$i] : '' );
      $content .= $this->formTextarea($name, $cVal, $cAttr);
      $content .= $separator;
    }

    // Add javascript for adding anothing text link
    // Add anchor for haxing
    $tName = trim($name, '[]');
    $content .= '<a href="javascript:void(0);" id="' . $tName . '">' . $this->view->translate(strtoupper('Add_' . $tName)) . '</a>';
    $script = <<<EOF
window.addEvent('domready', function() {
  var anchor = $('$tName');
  if( !anchor ) return;
  anchor.addEvent('click', function(event) {
    event.preventDefault();
    
    var ref = anchor.getParent();
    var children = ref.getChildren('textarea');
    if( !anchor || !ref || !children || children.length == 0 ) {
      return false;
    }

    var child = children[0];
    child.clone().set('value', '').inject(anchor, 'before');
    (new Element('br', {class:'multi-textarea-separator'})).inject(anchor, 'before');
  });
});
EOF;
    $this->view->headScript()->appendScript($script);

    return $content;
  }
}