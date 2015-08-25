<?php
if($this->socialconnect_enable)
{
	echo $this->content()->renderWidget('social-connect.quick-login'); 
}
$tabIndex = 15;
if (!empty($this->form)) : 
    foreach ($this->form->getElements() as $el) :
        $el->setAttrib('tabindex', $tabIndex++);
    endforeach;
endif;
?>
  <?php echo $this->form->render($this) ?>
<script type="text/javascript">
function advancedMenuUserLoginFormAction()
{
	if (typeof jQuery != 'undefined') { 
		jQuery.noConflict();
	}
  // INJECT FORGOT PASSWORD LINK
  var wrapperDiv = document.createElement("div");
  wrapperDiv.id = "forgot_password";
  wrapperDiv.innerHTML = "<span class='fright'><a href='"+en4.core.baseUrl+"user/auth/forgot'>"+en4.core.language.translate('Forgot Password?')+"</a></span>";
  wrapperDiv.inject(jQuery('password-wrapper'), 'after');
  jQuery("remember-wrapper").inject(jQuery("forgot_password"), 'before');
  
}
advancedMenuUserLoginFormAction();
</script>