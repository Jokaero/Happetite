<div class="ynmenu-mixed-main">
	<div class="listing-main-content">
		<ul class="listing">
			<?php $i = 0;?>
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
				<?php $arr_child = $this-> parent -> toArray();
					$child = array();
					if(!empty($arr_child['children']))
						$child = $arr_child['children'];
					if (in_array($menu2 -> submenu_id, $child)):?>
					<li	<?php echo ($menu2_main_menu_background_color) ? ('style="background-color: #' . $menu2_main_menu_background_color . '"') : (""); ?> data-level=2 class="item-listing ajax-loading ynmenu-level2-idmenu-<?php echo $menu2->submenu_id; ?>" data-content=<?php echo $i;?> id="<?php echo $menu2->submenu_id;?>">
						<span class="toggle"></span>
						<a href="<?php echo $menu2 -> getHref()?>"
							target ="<?php echo ( !empty($menu2_params['target']) ? $menu2_params['target'] : null )?>"
						>
							<!-- hover text color -->
							<?php if($menu2_main_menu_hover_color) :?>
							<style rel="stylesheet" type="text/css">
								li.ynmenu-level2-idmenu-<?php echo $menu2->submenu_id; ?>.over > a span.text
								{
									color: <?php echo "#".$menu2_params['main_menu_hover_color']; ?> !important;
								}
							</style>
							<?php endif;?>
							
							<!-- icon -->
							<?php if(empty($menu2_icon)):?>
								<span class="ynmenu-icon"><i class="fa fa-cog"></i></span>
							<?php else: ?>
								<span class="ynmenu-icon"><?php echo $this->htmlImage($menu2_icon);?></span>	
							<?php endif;?>
							
							<!-- hover-active icon -->
							<?php if(empty($menu2_hover_active_icon)):?>
								<span class="ynmenu-icon-hover"><i class="fa fa-cog"></i></span>
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
					</li>
				<?php $i++;?>
				<?php endif;?>
				<?php endif;?>
			<?php endforeach;?>
		</ul>
		<div class="listing-content">
			<?php $arr_parent = $this -> parent -> toArray(); ?>
			<?php foreach ($this->menuLevel2 as $menu2): ?>
				<?php if (in_array($menu2 -> submenu_id, $arr_parent['children'])):?>
					<ul class="content content-waiting" id="ynadvmenusystem-menu-children-<?php echo $menu2->submenu_id;?>">
					</ul>
				<?php endif;?>
			<?php endforeach;?>
		</div>
	</div>				
</div>				
			