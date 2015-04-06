<?php if((isset($this->parent->advparams['background_multicolumn_color'])) && (empty($this->parent->advparams['background_multicolumn_image']))): ?>
	<ul style="background-color: #<?php echo $this->parent->advparams['background_multicolumn_color'];?>" class="">
<?php elseif(isset($this->parent->advparams['background_multicolumn_image'])):?>
	<ul style="background-image:url(<?php echo $this->baseUrl()."/".$this->parent->advparams['background_multicolumn_image'];?>)" class="">
<?php endif;?>
<?php foreach ($this->menuLevel2 as $menu2): ?>
	<?php 
		$menu2_params = $menu2['params'];
		$menu2_main_menu_background_color = (isset($menu2_params['main_menu_background_color'])?$menu2_params['main_menu_background_color']:"");
		$menu2_hover_active_icon = (isset($menu2_params['hover_active_icon'])?$menu2_params['hover_active_icon']:"");
		$menu2_icon = (isset($menu2_params['icon'])?$menu2_params['icon']:"");
		$menu2_main_menu_text_color = (isset($menu2_params['main_menu_text_color'])?$menu2_params['main_menu_text_color']:"");
		$menu2_main_menu_hover_color = (isset($menu2_params['main_menu_hover_color'])?$menu2_params['main_menu_hover_color']:"");
	?>
	<?php $canView = $menu2 -> canView();?>
	<?php if($canView) :?>
	<?php $arr_child = $this->parent -> toArray();
		$child = $arr_child['children'];
	if (in_array($menu2 -> submenu_id, $child)):?>
		<li class='ynmenu-level2-idmenu-<?php echo $menu2->submenu_id; ?>' <?php if(!empty($menu2_main_menu_background_color)):?> style="background-color:<?php echo "#".$menu2_main_menu_background_color;?>"<?php endif;?> data-level=2>
			<span class="toggle"></span>
			<a href="<?php echo $menu2 -> getHref()?>"
				target ="<?php echo ( !empty($menu2_params['target']) ? $menu2_params['target'] : null )?>"
			>
				<!-- hover text color -->
					<?php if($menu2_main_menu_hover_color) :?>
					<style rel="stylesheet" type="text/css">
						li.ynmenu-level2-idmenu-<?php echo $menu2->submenu_id; ?> > a:hover > span.text
						{
							color: <?php echo "#".$menu2_params['main_menu_hover_color']; ?> !important;
						}
					</style>
					<?php endif;?>
					
					<!-- icon -->
					<?php if(empty($menu2_icon)):?>
						<span class="ynmenu-icon"><i class="fa fa-circle"></i></span>
					<?php else: ?>
						<span class="ynmenu-icon"><?php echo $this->htmlImage($menu2_icon);?></span>	
					<?php endif;?>
					
					<!-- hover-active icon -->
					<?php if(empty($menu2_hover_active_icon)):?>
						<span class="ynmenu-icon-hover"><i class="fa fa-circle"></i></span>
					<?php else: ?>
						<span class="ynmenu-icon-hover"><?php echo $this->htmlImage($menu2_hover_active_icon);?></span>	
					<?php endif;?>
					
					<!-- label -->	
					<?php if(empty($menu2_main_menu_text_color)):?>
						<span class="text"><?php echo $menu2->label;?></span>
					<?php else: ?>
						<span style="color:<?php echo "#".$menu2_main_menu_text_color; ?>" class="text"><?php echo $menu2->label;?></span>	
					<?php endif;?>
			</a>
			<?php if (count($menu2->children)) :?>
			<ul>
				<?php foreach ($this->menuLevel3 as $menu3): ?>
				<?php
					$menu3_params = $menu3['params'];
					$menu3_main_menu_background_color = (isset($menu3_params['main_menu_background_color'])?$menu3_params['main_menu_background_color']:"");
					$menu3_hover_active_icon = (isset($menu3_params['hover_active_icon'])?$menu3_params['hover_active_icon']:"");
					$menu3_icon = (isset($menu3_params['icon'])?$menu3_params['icon']:"");
					$menu3_main_menu_text_color = (isset($menu3_params['main_menu_text_color'])?$menu3_params['main_menu_text_color']:"");
					$menu3_main_menu_hover_color = (isset($menu3_params['main_menu_hover_color'])?$menu3_params['main_menu_hover_color']:"");
				?>
				<?php $canView = $menu3 -> canView();?>
				<?php if($canView) :?>
					<?php if (in_array($menu3 -> submenu_id, $menu2->children)):?>
						<li class='ynmenu-level3-idmenu-<?php echo $menu3->submenu_id; ?>' <?php if(!empty($menu3_main_menu_background_color)):?> style="background-color:<?php echo "#".$menu3_main_menu_background_color;?>"<?php endif;?> data-level=3>
							<a href="<?php echo $menu3 -> getHref()?>"
								target ="<?php echo ( !empty($menu3_params['target']) ? $menu3_params['target'] : null )?>"
							>
								<!-- hover text color -->
									<?php if($menu3_main_menu_hover_color) :?>
									<style rel="stylesheet" type="text/css">
										li.ynmenu-level3-idmenu-<?php echo $menu3->submenu_id; ?>.over > a span.text
										{
											color: <?php echo "#".$menu3_params['main_menu_hover_color']; ?> !important;
										}
									</style>
									<?php endif;?>
									<!-- icon -->
									<?php if(empty($menu3_icon)):?>
										<span class="ynmenu-icon"><i class="fa fa-automobile"></i></span>
									<?php else: ?>
										<span class="ynmenu-icon"><?php echo $this->htmlImage($menu3_icon);?></span>	
									<?php endif;?>
									
									<!-- hover-active icon -->
									<?php if(empty($menu3_hover_active_icon)):?>
										<span class="ynmenu-icon-hover"><i class="fa fa-automobile"></i></span>
									<?php else: ?>
										<span class="ynmenu-icon-hover"><?php echo $this->htmlImage($menu3_hover_active_icon);?></span>	
									<?php endif;?>
									
									<!-- label -->	
									<?php if(empty($menu3_main_menu_text_color)):?>
										<span class="text"><?php echo $menu3->label;?></span>
									<?php else: ?>
										<span style="color:<?php echo "#".$menu3_main_menu_text_color; ?>" class="text"><?php echo $menu3->label;?></span>	
									<?php endif;?>
							</a>
						</li>
					<?php endif;?>
					<?php endif;?>
				<?php endforeach;?>
			</ul>
			<?php endif;?>
		</li>	
	<?php endif;?>	
	<?php endif;?>
<?php endforeach;?>
</ul>
