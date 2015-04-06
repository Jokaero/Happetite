<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.net/license/
 * @version    $Id: create.tpl 8235 2011-01-18 00:28:14Z john $
 * @author     John
 */
?>

<?php if( $this->form ): ?>
  <?php echo $this->form->render($this) ?>
	<script type="text/javascript">
  	function loadDropBox(event_id,obj){
            var element = document.getElementById('style');
            if(element.value == 'multi')
            {
            	$$('.multicolumn_title').setStyle('display','block');
            	$('background_multicolumn_color-wrapper').setStyle('display','block');
            	$('background_multicolumn_image-wrapper').setStyle('display','block');
            }
            else
            {
            	$$('.multicolumn_title').setStyle('display','none');
            	$('background_multicolumn_color-wrapper').setStyle('display','none');
            	$('background_multicolumn_image-wrapper').setStyle('display','none');
            }
    } 
     window.addEvent('domready', function() {
     	$$('.multicolumn_title').setStyle('display','none');
    	$('background_multicolumn_color-wrapper').setStyle('display','none');
    	$('background_multicolumn_image-wrapper').setStyle('display','none');
	});
     </script>
<?php elseif( $this->status ): ?>

  <div><?php echo $this->translate("Your changes have been saved.") ?></div>

  <script type="text/javascript">
    setTimeout(function() {
      parent.window.location.replace( '<?php echo $this->url(array('action' => 'index', 'name' => $this->selectedMenu->name)) ?>' )
    }, 500);
  </script>

<?php endif; ?>