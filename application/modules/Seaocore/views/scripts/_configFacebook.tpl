<div id="facebook_helpsteps">
<div class="tabs">
  <ul class="navigation">
    <li class='active' id="facebookapp_help">
        <a class="menu_seaocore_admin_main seaocore_admin_upgrade" href="javascript:void(0);" onclick= "show_fbseacorehelp ('facebookapp');">App Configuration</a>
    </li>
    <?php $facebookse = Engine_Api::_()->getDbtable('modules', 'core')->getModule('facebookse');?>
    <?php if(!empty($facebookse) && $facebookse->version > '4.7.1' && 0):?>
    <li id="fbpostreview_help">
        <a class="menu_seaocore_admin_main seaocore_admin_info" href="javascript:void(0);" onclick= "show_fbseacorehelp ('fbpostreview');">Post Reivew for a Like Action</a>
    </li>
    <?php endif;?>
  </ul>
</div>

<!--Facebook App Configuration Help Section-->

<div id="facebookapp_helpsteps">
	<h3><?php echo $this->translate("Guidelines to configure Facebook Application") ?></h3>
	<p><?php echo $this->translate('Please follow the steps given below.') ?></p><br />

  <div class="admin_seaocore_guidelines_wrapper">
    <ul class="admin_seaocore_guidelines" id="guideline_1">
			<li>
				<div class="steps">
					<a href="javascript:void(0);" onClick="guideline_show('fbstep-1');"><?php echo $this->translate("Step 1");?></a>
					<div id="fbstep-1" style='display: none;'>
						<p>
            	<?php echo $this->translate("Go to this URL for steps to configure basic Facebook Integration on your SocialEngine website : ");?><a href="https://www.youtube.com/watch?v=HAAbCFyP8ts&feature=youtu.be 
" target="_blank" style="color:#5BA1CD;">https://www.youtube.com/watch?v=HAAbCFyP8ts&feature=youtu.be</a><br/>    
            </p>
					</div>
				</div>	
			</li>	
			
			<li>	
				<div class="steps">
					<a href="javascript:void(0);" onClick="guideline_show('fbstep-2');"><?php echo $this->translate("Step 2");?></a>
					<div id="fbstep-2" style='display: none;'>
						<h3><?php echo $this->translate(" Details to be filled while creating Facebook Application: ");?><br /></h3>
						
						<p>
						     <?php echo $this->translate("a)  <b>Your site's domain</b> => <b>" . $_SERVER['HTTP_HOST'] . "</b> in the 'App Domain' field in the 'Basic Info' section. Please note that the domain should not contain 'www.' prefix. ");?><br />
                 <?php echo $this->translate("b) <b>'Namespace'</b> section. This will be the name which will be used by your Facebook App as App Name.")?><br />
                 
                  <?php //echo $this->translate("c) Make sure the \"Sandbox Mode\" is disabled.")?><br />
                 
	              <?php echo $this->translate("c) <b>Your site's url</b>") . ' => <b>' . ( _ENGINE_SSL ? 'https://' : 'http://' ) . $_SERVER['HTTP_HOST'] . Zend_Controller_Front::getInstance()->getBaseUrl() . "/</b> in the 'Site URL' field in the 'Website' section.";?><br />                
	             
						</p>						
					</div>
				</div>
			</li>			
		</ul>
	</div>
</div>


<!--End Here-->

<!--Post Review for a Facebook Like action Help Section-->

<div id="fbpostreview_helpsteps" style="display:none;">
	<h3><?php echo $this->translate("Guidelines to post review and create custom action type on Facebbook for an action type used") ?></h3>
	<p><?php echo $this->translate('Please follow the steps given below.') ?></p><br />
  <div class="admin_seaocore_guidelines_wrapper">
    <ul class="admin_seaocore_guidelines" id="guideline_1">
			<li>
				<div class="steps">
					<a href="javascript:void(0);" onClick="guideline_show('fbreviewstep-1');"><?php echo $this->translate("1) Post Review for an action type on Facebook");?></a>
					<div id="fbreviewstep-1" style='display: none;'>
						<p>
            	<?php echo $this->translate("Go to this URL for steps to post review on Facebook for an action type : ");?><a href="https://developers.facebook.com/docs/opengraph/submission-process/#submitbuiltin" target="_blank" style="color:#5BA1CD;">https://developers.facebook.com/docs/opengraph/submission-process/</a><br/>    
            </p>
					</div>
				</div>	
			</li>
      
      <li>
				<div class="steps">
					<a href="javascript:void(0);" onClick="guideline_show('fbreviewstep-2');"><?php echo $this->translate("2) Creating Custom Action");?></a>
					<div id="fbreviewstep-2" style='display: none;'>
						<p>
            	<?php echo $this->translate("Go to this URL for steps to create custom action types for your Facebook App : ");?><a href="https://developers.facebook.com/docs/opengraph/creating-action-types/" target="_blank" style="color:#5BA1CD;">https://developers.facebook.com/docs/opengraph/creating-action-types/</a><br/>    
            </p>
					</div>
				</div>	
			</li>
      
    </ul>
    
  </div>
  
</div>
</div>

<script type="text/javascript">
  function guideline_show(id) {
    if($(id).style.display == 'block') {
      $(id).style.display = 'none';
    } else {
      $(id).style.display = 'block';
    }
  }
  
  var previous_tabfb = 'facebookapp';
  function show_fbseacorehelp(active_tab) { 
  	
  	if (active_tab != previous_tabfb) {
	    $(previous_tabfb + '_help').removeClass ('active');
	    $(active_tab + '_help').addClass ('active');
	    $(active_tab + '_helpsteps').style.display= 'block';
	    $(previous_tabfb + '_helpsteps').style.display= 'none';
	    previous_tabfb =active_tab; 
  	}
   
  }
</script>


<!--End Here-->