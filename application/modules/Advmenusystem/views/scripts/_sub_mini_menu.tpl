<span onmouseover = "ynAdvMenu.mouseoverMiniMenuPulldown(event, this, '4');" onmouseout = "ynAdvMenu.mouseoutMiniMenuPulldown(event, this, '4');" style="display: inline-block;" class="updates_pulldown"> 
	<?php if(!$this->parent_item && strpos($this->key, "core_mini_yntour") ):?>
		<a href="javascript:en4.yntour.startTour();" class="menu_core_mini core_mini_yntour"><?php echo $this->translate("Tour Guide");?></a>
	<?php elseif($this->parent_item->name == 'core_mini_profile'): ?>
		<?php
			$img = $this->itemPhoto($this->viewer(), 'thumb.icon');
			if($this->viewer()->getTitle() == 'admin')
			{
				echo "<a class = 'menu_core_mini core_mini_profile' href='" . $this->viewer()->getHref() . "'><div>" .$img. "</div>".$this->translate('Admin') . "</a>";
			}
			else
			{				
			  	echo $this->htmlLink($this->viewer()->getHref(), '<div>'.$img.'</div>'.strip_tags(substr($this->viewer()->getTitle(), 0, 12)),array('class'=> 'menu_core_mini core_mini_profile')); if (strlen($this->viewer()->getTitle()) > 19) echo $this->translate("...");				 
			}
			?> 
	<?php else:?>
		<?php if($this->parent_item->name != "core_mini_auth" || $this->return_url == ""):?>
			<a class=" <?php echo $this->parent_item->class?> " href="<?php echo $this->parent_item->getHref();?>"><?php echo $this->translate($this->parent_item->getLabel())?></a>
		<?php else:?>
			<a class=" <?php echo $this->parent_item->class?>" href="<?php echo $this->return_url;?>"><?php echo $this->translate($this->parent_item->getLabel())?></a>
		<?php endif;?>
	<?php endif;?>				

	<div class="pulldown_contents_wrapper">
		<div class="pulldown_contents">
			<ul class="notifications_menu">
				<?php foreach($this->sub_menus as $item):?>
					<?php if($item->name != "core_mini_auth" && $item->name != 'core_mini_signup'):?>		
					<li>				
						<?php echo $this->htmlLink($item->getHref(), $this->translate($item->getLabel()), array_filter(array(
					        'class' => ( !empty($item->class) ? $item->class : null ),
					        'alt' => ( !empty($item->alt) ? $item->alt : null ),
					        'target' => ( !empty($item->target) ? $item->target : null ),
					      )));?>
					</li>	
				 <?php endif;?>
				<?php endforeach;?>				
			</ul>
		</div>
	</div>
	
</span>