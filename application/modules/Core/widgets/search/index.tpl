<?php
/**
 * SocialEngine - Search Widget Smarty Template
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2012 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: index.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     Matthew
 */
?>

<div id='core_search_widget'>
  <?php if($this->search_check):?>
    <div id="searchform" class="global_form_box">
      <?php echo $this->form->setAttrib('class', '')->render($this) ?>
    </div>
  </div>
<br/>
<br />
<?php endif;?>

