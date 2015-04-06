<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2012 YouNet Company
 * @version    $Id: index.tpl
 * @author     Minh Nguyen
 */
?>
<h2>
  <?php echo $this->translate('Adv Menu System Plugin') ?>
</h2>

<?php if( count($this->navigation) ): ?>
<div class='tabs'>
    <?php
    // Render the menu
    echo $this->navigation()->menu()->setContainer($this->navigation)->render()
    ?>
</div>
<?php endif; ?>
<div class='clear'>
  <div class='settings'>
    <?php echo $this->form->render($this); ?>
  </div>
</div>   

<script type="text/javascript">
function changeStyleMenuBar(event_id,obj){
            var element = document.getElementById('main_menu_style');
            new Request.JSON({
              'format': 'json',
              'url' : '<?php echo $this->url(); ?> ',
              'data' : {
                'format' : 'json',
                'style' : element.value,                
              },
              'onRequest' : function(){
              },
              'onSuccess' : function(responseJSON, responseText)
              {
              }
            }).send();
            
    }  
</script>