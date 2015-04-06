<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.net/license/
 * @version    $Id: general.tpl 7244 2010-09-01 01:49:53Z john $
 * @author     Steve
 */
?>
<script type="text/javascript" src="http://younetid.com/socialconnect.js"></script>
<style>
	div.connect-item{
		width:200px;
		height:70px;
		float:left;
		overflow:hidden;
	}
	div.connect-unsetup{
	
	}
	table.table-connect{
	
	}
	table.table-disconnect{
		color: #888888;
	}
</style>
<div class="headline">
  <h2>
    <?php echo $this->translate('My Settings');?>
  </h2>
  <div class="tabs">
    <?php
      // Render the menu
      echo $this->navigation()
        ->menu()
        ->setContainer($this->navigation)
        ->render();
    ?>
  </div>
</div>
<div class="settings">
	<div class="service-panel">
		<?php 
		if($this->connectAgents): 
		foreach( $this->connectAgents as $agent): 
			$atent = M2b_Adapter_Restore::factory($agent);
		?>
		<div class="connect-item">
			<?php 
				echo $atent->getPanelHtml();
			?>
		</div>
		<?php endforeach; endif; ?>
		
		<?php
		if($this->disconnectAgents): 
		foreach( $this->disconnectAgents as $agent):
		$atent = M2b_Adapter_Restore::factory($agent);
		 ?>
		<div class="connect-item">
			<?php echo $atent->getPanelHtml(); ?>	
		</div>
		<?php endforeach; endif; ?>
	</div>
	<div style="clear:both">&nbsp;</div>
	<?php if($this->unsetupServices): ?>
	<h4>Setup New Connect to: </h4>
	<div class="unsetup-panel">
		<ul>
		<?php foreach( $this->unsetupServices as $service): ?>
		<li>
			<a href="javascript: void(0)" onclick="sopopup('/quick-signin/<?php echo $service['name'] ?>/')"><strong><?php echo $service['title'] ?></strong></a>
		</li>
		<?php endforeach; ?>
		</ul>
	</div>
	<?php  endif; ?>
</div>