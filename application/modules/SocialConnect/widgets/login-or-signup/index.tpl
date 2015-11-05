<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.net/license/
 * @version    $Id: index.tpl 9595 2012-01-11 20:49:39Z john $
 * @author     John
 */
?>
<style>
.ynsc_sprite
{
	width: <?php echo $this->iconsize;?>px;
	height: <?php echo $this->iconsize;?>px;
	margin-top: <?php echo $this->margintop;?>px;
	margin-right: <?php echo $this->marginright;?>px;
	padding: 2px;
}
</style>


<?php if( !$this->noForm ): ?>

  <h3>
    <?php echo $this->translate('Sign In or %1$sJoin%2$s', '<a href="'.$this->url(array(), "user_signup").'">', '</a>'); ?>
  </h3>

  <?php echo $this->form->setAttrib('class', 'global_form_box')->render($this) ?>

  <?php if( !empty($this->fbUrl) ): ?>

    <script type="text/javascript">
      var openFbLogin = function() {
        Smoothbox.open('<?php echo $this->fbUrl ?>');
      }
      var redirectPostFbLogin = function() {
        window.location.href = window.location;
        Smoothbox.close();
      }
    </script>

  <?php endif; ?>

<?php else: ?>
    
  <h3 style="margin-bottom: 0px;">
    <?php echo $this->htmlLink(array('route' => 'user_login'), $this->translate('Sign In')) ?>
    <?php echo $this->translate('or') ?>
    <?php echo $this->htmlLink(array('route' => 'user_signup'), $this->translate('Join')) ?>
  </h3>
  <?php echo $this->form->setAttrib('class', 'global_form_box no_form')->render($this) ?>
<?php endif; ?>
<script type="text/javascript">
	 var toggleIt =  function(id2,id1)
	 {
			var e = document.getElementById(id2);
			var m = e.getAttribute('mode');
			function k(n){
				$$('.ld44').each(function(a,b){a.style.display=n;});
			}
			if(m =='close'){
				k('none');
				e.setAttribute('mode','open');
				e.innerHTML = '<img title = "<?php echo $this->translate('More')?>" src = "./application/modules/SocialConnect/externals/images/more.png" width = "26px" height = "26px"/>';
			}else{
				e.setAttribute('mode','close');
				e.innerHTML = '<img title = "<?php echo $this->translate('Hide')?>" src = "./application/modules/SocialConnect/externals/images/hide.png" width = "26px" height = "26px"/>';
				k('');
			}
	 }
</script>