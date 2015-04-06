<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.net/license/
 * @version    $Id: edit.tpl 7244 2010-09-01 01:49:53Z john $
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
		 	<?php if($this->style == 'multi') :?>
			 	$$('.multicolumn_title').setStyle('display','block');
				$('background_multicolumn_color-wrapper').setStyle('display','block');
				$('background_multicolumn_image-wrapper').setStyle('display','block');
			<?php else:?>
			 	$$('.multicolumn_title').setStyle('display','none');
				$('background_multicolumn_color-wrapper').setStyle('display','none');
				$('background_multicolumn_image-wrapper').setStyle('display','none');
			<?php endif;?>
		});
 </script>
	
<?php elseif( $this->status ): ?>

  <div><?php echo $this->translate("Changes saved!") ?></div>

  <script type="text/javascript">
    var name = '<?php echo $this->name ?>';
    var label = '<?php echo $this->escape($this->menuItem->label) ?>';
    setTimeout(function() {
      parent.$('admin_menus_item_' + name).getElement('.item_label').set('html', label);
      parent.Smoothbox.close();
    }, 500);
  </script>

<?php endif; ?>