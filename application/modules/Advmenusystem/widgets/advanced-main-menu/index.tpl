<link rel="stylesheet" href="<?php echo $this->baseUrl() ?>/application/modules/Advmenusystem/externals/styles/font-awesome.min.css"></link>
<style type="text/css" media="screen">	
	
<?php echo $this->cssMenuStyle; ?>
<?php if(!$this->arrow_sign) :?>
	.ynmenu-standard  > a span.text:after,
	.ynmenu-multi > a span.text:after,
	.ynmenu-content > a span.text:after,
	.ynmenu-mixed > a span.text:after {
		display: none !important;
	}
<?php else: ?>
#ynmenu-level1-idmenu-more li[data-level='1'].ynmenu-standard > a span.text:after, .ynmenu-style-simple li[data-level='1'].ynmenu-multi > a span.text:after, .ynmenu-style-simple li[data-level='1'].ynmenu-content > a span.text:after, .ynmenu-style-simple li[data-level='1'].ynmenu-mixed > a span.text:after
{
	background-image: none;
}
<?php endif;?>
</style>
<div class="ynmenu-style-<?php echo $this->style_menu;?>">
	<div class="ynadvanced-menu-checked"></div>
	<div class="ynadvanced-menu-system">	
		<div class="ynmenu-container">
			<div class="icon-menu-responsive">
				<span class="icon-menu"></span>
				<?php echo $this->translate('Menu'); ?>
			</div>
			<ul class="ynmenu-listing ynhide">
			<?php $totalMenus = 0; ?>
			<?php foreach ($this->menuLevel1 as $k => $menu1):?>
				<?php 
					if ($totalMenus == $this->number_tabs)
					{
						$needMoreButton = true;
						break;
					}
					$canView = true;
					if(isset($menu1 -> advparams['login']) && $menu1 -> advparams['login'] && !$this->viewer->getIdentity())
					{
						$canView = false;
					}
					
					if(isset($menu1 -> advparams['logout']) && $menu1 -> advparams['logout'] && $this->viewer->getIdentity())
					{
						$canView = false;
					}
					if(isset($menu1 -> advparams['logout']) && $menu1 -> advparams['logout'] && isset($menu1 -> advparams['login']) && $menu1 -> advparams['login'])
					{
						$canView = true;
					}
					if(isset($menu1 -> advparams['logout']) && !$menu1 -> advparams['logout'] && isset($menu1 -> advparams['login']) && !$menu1 -> advparams['login'])
					{
						$canView = false;
					}
				?>
				<?php if($canView) :?>
				<?php	
					$totalMenus++;
					$main_menu_background_color = (isset($menu1 -> advparams['main_menu_background_color'])?$menu1 -> advparams['main_menu_background_color']:"");
					$hover_active_icon = (isset($menu1 -> advparams['hover_active_icon'])? $menu1 -> advparams['hover_active_icon'] : "");
					$icon = (isset($menu1 -> advparams['icon'])? $menu1 -> advparams['icon'] : "");
					$main_menu_text_color = (isset($menu1 -> advparams['main_menu_text_color'])? $menu1 -> advparams['main_menu_text_color'] : "");
					$main_menu_hover_color = (isset($menu1 -> advparams['main_menu_hover_color'])? $menu1 -> advparams['main_menu_hover_color'] : "");
				?>
				<?php 
					
					$menuType = (!isset($menu1->advparams['style']) || $menu1->advparams['style'] == "") ? "standard" : $menu1->advparams['style'];
					
					$arr_menu1 = $menu1-> toArray();
					$children = $arr_menu1['children'];
					if(!count($children) && $menuType != 'content')
					{
						$menuType = "no_child";
					}
					if($menuType == 'content')
					{
						$tableContentTable = Engine_Api::_() -> getItemTable('advmenusystem_content');
						$hasContent = $tableContentTable -> checkHasContentLevel1($arr_menu1['id'], 1);
						if(!$hasContent)
						{
							$menuType = "no_child";
						}
					}
				?>
				<li class="ynmenu-<?php echo $menuType;?> ynmenu-level1-idmenu-<?php echo $menu1->id;?>" data-level="1">
					<span class="toggle"></span>
					    <a <?php if(!empty($main_menu_background_color)):?>style="background-color:<?php echo "#".$main_menu_background_color;?>"<?php endif;?> href="<?php echo $menu1 -> getHref()?>" 
					    	target ="<?php echo ( !empty($menu1 -> advparams['target']) ? $menu1 -> advparams['target'] : null )?>"
					     >
							<!-- hover text color -->
							
							<style rel="stylesheet" type="text/css">
								<?php if(!empty($main_menu_hover_color)) :?>
									li.ynmenu-level1-idmenu-<?php echo $menu1->id; ?>.over > a span.text
									{
										color: <?php echo "#".$menu1->advparams['main_menu_hover_color']; ?> !important;
									}
								<?php endif;?>
								.ynmenu-style-metro li[data-level='1'].ynmenu-level1-idmenu-<?php echo $menu1->id; ?> > a {
									background-color: <?php echo "#".$main_menu_background_color;?>;			
								}
								<?php if(!empty($main_menu_background_color)) :?>
								.ynmenu-style-metro li[data-level='1'].ynmenu-level1-idmenu-<?php echo $menu1->id; ?>.ynmenu-standard li.over > a {
									background-color: <?php echo "#".$main_menu_background_color;?>;		
								}
								
								.ynmenu-style-metro li[data-level='1'].ynmenu-level1-idmenu-<?php echo $menu1->id; ?> > ul,
								.ynmenu-style-metro li[data-level='1'].ynmenu-level1-idmenu-<?php echo $menu1->id; ?>.ynmenu-standard ul,
								.ynmenu-style-metro li[data-level='1'].ynmenu-level1-idmenu-<?php echo $menu1->id; ?> > .ynmenu-mixed-main {
									border-color: <?php echo "#".$main_menu_background_color;?>;
									border-top-color: 4px solid <?php echo "#".$main_menu_background_color;?>;
								}
								<?php endif;?>
								
								<?php if(!empty($main_menu_text_color)) :?>
								.ynmenu-style-metro li[data-level='1'].ynmenu-level1-idmenu-<?php echo $menu1->id; ?>.ynmenu-multi li a { 
									color: <?php echo "#".$main_menu_text_color;?>; 
								}
								<?php endif;?>
								
								<?php if(!empty($main_menu_hover_color)) :?>
								.ynmenu-style-metro li[data-level='1'].ynmenu-level1-idmenu-<?php echo $menu1->id; ?>.ynmenu-multi li li.over > a > .text { 
									color: <?php echo "#".$main_menu_hover_color;?>; 
								}
								<?php endif;?>

								<?php if(!empty($main_menu_background_color)) :?>
								.ynmenu-style-metro li[data-level='1'].ynmenu-level1-idmenu-<?php echo $menu1->id; ?>.ynmenu-multi li li.over > a > .text { 
									background-color: <?php echo "#".$main_menu_background_color;?>; 
								}
								<?php endif;?>
								
							</style>
							
							
							<!-- icon -->
							<?php if(empty($icon)):?>
							<span class="ynmenu-icon"><i class="fa fa-list-alt"></i></span>
							<?php else: ?>
							<span class="ynmenu-icon"><?php echo $this->htmlImage($icon);?></span>	
							<?php endif;?>
							
							<!-- hover-active icon -->
							<?php if(empty($hover_active_icon)):?>
							<span class="ynmenu-icon-hover"><i class="fa fa-list-alt"></i></span>
							<?php else: ?>
							<span class="ynmenu-icon-hover"><?php echo $this->htmlImage($hover_active_icon);?></span>	
							<?php endif;?>
							
							<!-- label -->	
							<?php if(empty($main_menu_text_color)):?>
								<span style="color:<?php echo "#".$main_menu_text_color; ?>" class="text"><?php echo $this -> string() -> truncate($this->translate($menu1->getLabel()), $this->title_truncation);?></span>
							<?php else: ?>
								<span style="color:<?php echo "#".$main_menu_text_color; ?>" class="text"><?php echo $this -> string() -> truncate($this->translate($menu1->getLabel()), $this->title_truncation);?></span>	
							<?php endif;?>
						</a>
					<?php
						if (count($children) && $menuType != 'content')
						{
							echo $this->partial("_{$menuType}_type.tpl", "advmenusystem", array(
								'parent' => $menu1,
								'menuLevel2'=> $this->menuLevel2,
								'menuLevel3'=> $this->menuLevel3,
								'viewer' => $this->viewer,
							));	
						} 
						else if($menuType == 'content')
						{
							
							$contentsTable = Engine_Api::_() -> getDbtable('contents', 'advmenusystem');
							$contents = $contentsTable->getContentByMenu($menu1, 1, 10);
							if (count($contents))
							{
								echo $this->partial("_{$menuType}_type.tpl", "advmenusystem", array(
									'parent' => $menu1,
									'contents' => $contents 
								));	
							}
						}
					?>
				</li>
				<?php endif;?>
			<?php endforeach;?>
			<?php if ($this->show_more_link):?>
				<?php if (isset($needMoreButton) && $needMoreButton == true):?>
					<li class="ynmenu-standard ynmenu-level1-idmenu-more" data-level="1">
						<span class="toggle"></span>
					    <a href="#" onclick="javascript::void(0);">
							<span class="ynmenu-icon"><i class="fa fa-list-alt"></i></span>
							<span class="ynmenu-icon-hover"><i class="fa fa-list-alt"></i></span>
							<span class="text"><?php echo $this->translate("More");?></span>
						</a>
						<ul class="">
						<?php foreach ($this->menuLevel1 as $k => $menu1):?>
							<?php
								$canViewMore = true;
								if(isset($menu1 -> advparams['login']) && $menu1 -> advparams['login'] && !$this->viewer->getIdentity())
								{
									$canViewMore = false;
								}
								
								if(isset($menu1 -> advparams['logout']) && $menu1 -> advparams['logout'] && $this->viewer->getIdentity())
								{
									$canViewMore = false;
								}
								if(isset($menu1 -> advparams['logout']) && $menu1 -> advparams['logout'] && isset($menu1 -> advparams['login']) && $menu1 -> advparams['login'])
								{
									$canViewMore = true;
								}
								if(isset($menu1 -> advparams['logout']) && !$menu1 -> advparams['logout'] && isset($menu1 -> advparams['login']) && !$menu1 -> advparams['login'])
								{
									$canViewMore = false;
								}
							?>
							<?php if($canViewMore) :?>
							<?php	
								$main_menu_background_color = (isset($menu1 -> advparams['main_menu_background_color'])?$menu1 -> advparams['main_menu_background_color']:"");
								$hover_active_icon = (isset($menu1 -> advparams['hover_active_icon'])? $menu1 -> advparams['hover_active_icon'] : "");
								$icon = (isset($menu1 -> advparams['icon'])? $menu1 -> advparams['icon'] : "");
								$main_menu_text_color = (isset($menu1 -> advparams['main_menu_text_color'])? $menu1 -> advparams['main_menu_text_color'] : "");
								$main_menu_hover_color = (isset($menu1 -> advparams['main_menu_hover_color'])? $menu1 -> advparams['main_menu_hover_color'] : "");
							?>
							<?php if ($k >= $this->number_tabs): ?>
								<li data-level=2 data-level="2">
									<a <?php if(!empty($main_menu_background_color)):?>style="background-color:<?php echo "#".$main_menu_background_color;?>"<?php endif;?> href="<?php echo $menu1 -> getHref()?>" 
								    	target ="<?php echo ( !empty($menu1 -> advparams['target']) ? $menu1 -> advparams['target'] : null )?>"
								     >
										<!-- icon -->
										<?php if(empty($icon)):?>
										<span class="ynmenu-icon"><i class="fa fa-cog"></i></span>
										<?php else: ?>
										<span class="ynmenu-icon"><?php echo $this->htmlImage($icon);?></span>	
										<?php endif;?>
										
										<!-- hover-active icon -->
										<?php if(empty($hover_active_icon)):?>
										<span class="ynmenu-icon-hover"><i class="fa fa-cog"></i></span>
										<?php else: ?>
										<span class="ynmenu-icon-hover"><?php echo $this->htmlImage($hover_active_icon);?></span>	
										<?php endif;?>
										
										<!-- label -->	
										<?php if(empty($main_menu_text_color)):?>
											<span style="color:<?php echo "#".$main_menu_text_color; ?>" class="text"><?php echo $this -> string() -> truncate($this->translate($menu1->getLabel()), $this->title_truncation);?></span>
										<?php else: ?>
											<span style="color:<?php echo "#".$main_menu_text_color; ?>" class="text"><?php echo $this -> string() -> truncate($this->translate($menu1->getLabel()), $this->title_truncation);?></span>	
										<?php endif;?>
									</a>
								</li>
							<?php endif;?>
							<?php endif;?>
						<?php endforeach;?>
						</ul>
					</li>
				<?php endif;?>		
			<?php endif;?>
			</ul>
		</div>
	</div>
</div>

<script type="text/javascript">
	// issue hover on desktop	
	$$('.ynmenu-listing li').addEvents({
    	mouseover: function(){
    		var ynmenu_container = document.getSize();
    		var responsive = <?php if (defined('YNRESPONSIVE')) echo 1; else echo 0; ?>;
    		if ( ynmenu_container.x > 750 || !responsive) {    			

    			// remove over when resize screen
    			$$('.ynmenu-listing li[data-level='+this.get('data-level')+']').removeClass('over');

	    		if ( this.hasClass('item-listing') ) {

	    			$$('.ynmenu-listing li.item-listing').removeClass('over');
	    			this.addClass('over');	

	    			// set data-content value in ynlisting item
	    			var ul_listing_content = this.getParent('.listing').getNext('.listing-content');
		   			ul_listing_content.getElements('.content').hide();
	    			ul_listing_content.getElements('.content')[ this.get('data-content') ].show();

	    			var ul_listing_content = this.getParent('.listing').getNext('.listing-content');
                    ul_listing_content.getElements('.content').hide();
                   	ul_listing_content.getElements('.content')[ this.get('data-content') ].show();
                   
					if ( this.hasClass('ajax-loading'))
					{
						//call ajax
						var menuId = this.get("id");
						var eThis = this;
						eThis.removeClass('ajax-loading');
						new Request.HTML({
							method: 'post',
							url: '<?php echo $this->url(Array('module'=>'advmenusystem', 'controller'=>'index', 'action'=>'getcontent'), 'default', true);?>',
							data: {
								format: 'html',
								menu_id: menuId,
								level:	2,
								limit: 8
							},
							onSuccess: function(responseJSON, responseText, responseHTML, responseJavaScript) 
							{
								$("ynadvmenusystem-menu-children-"+menuId).innerHTML = responseHTML;
								$("ynadvmenusystem-menu-children-"+menuId).removeClass('content-waiting');
									
							}
						}).send();
					}

	    		} else {
	    			this.addClass('over');
	    		}	   

	    		if ( this.hasClass('ynmenu-mixed') ) {
                    var first = this.getElement('.item-listing');

                    if ( !this.getElement('.over') ) {
                    	first.addClass('over');
                    }

                    
                    if ( first.hasClass('ajax-loading') )
                    {
                        //call ajax
                        var menuId = first.get("id");
                        first.removeClass('ajax-loading');
                        new Request.HTML({
                            method: 'post',
                            url: '<?php echo $this->url(Array('module'=>'advmenusystem', 'controller'=>'index', 'action'=>'getcontent'), 'default', true);?>',
                            data: {
                                format: 'html',
                                menu_id: menuId,
                                level:    2,
                                limit: 8
                            },
                            onSuccess: function(responseJSON, responseText, responseHTML, responseJavaScript) 
                            {
                                $("ynadvmenusystem-menu-children-"+menuId).show();
                                $("ynadvmenusystem-menu-children-"+menuId).innerHTML = responseHTML;
                                $("ynadvmenusystem-menu-children-"+menuId).removeClass('content-waiting'); 
                            }
                        }).send();
                    }
                } 		   
	    	}
	    },
	    mouseout: function(){
	    	var ynmenu_container = document.getSize();
	    	if ( ynmenu_container.x > 750 ) {
		    	if ( !this.hasClass('item-listing') ) {
	    			this.removeClass('over');
	    		}

	    		$$('.ynmenu-listing li').removeClass('ynhide');
	    	}
	    },
    });	
	
    // issue click function on mobile
    $$('.ynmenu-listing li .toggle').addEvents({
    	click: function(){    		
    		var ynmenu_container = document.getSize();
    		if ( ynmenu_container.x < 750 ) {
	    		var parent = this.getParent('li');
	    			level =	this.getParent('li').get('data-level');

	    		// reset menu 
	    		if (level == 1) {
	    			$$('.ynmenu-listing li[data-level=2]').removeClass('ynhide');
	    			$$('.ynmenu-listing li[data-level=3]').removeClass('ynhide');
	    		}

	    		if ( parent.hasClass('over') ) {
	    			$$('.ynmenu-listing li[data-level='+level+']').removeClass('ynhide');
	    			parent.removeClass('over');	    	
	    			parent.getElements('li').removeClass('over');
	    			$$('.content').hide();
	    		} else {
	    			if ( parent.hasClass('item-listing') ) {
	    				$$('.ynmenu-listing li.item-listing').removeClass('over');
		    			parent.addClass('over');	
		    			$$('.ynmenu-listing li[data-level='+level+']:not(.over)').addClass('ynhide');

		    			var ul_listing_content = this.getParent('.listing').getNext('.listing-content');
                    	ul_listing_content.getElements('.content').hide();
                   		ul_listing_content.getElements('.content')[ parent.get('data-content') ].show();
                   		
                   		if ( parent.hasClass('ajax-loading') )
    					{
    						//call ajax
    						var menuId = parent.get("id");
    						var eThis = parent;
    						eThis.removeClass('ajax-loading');
    						new Request.HTML({
    							method: 'post',
    							url: '<?php echo $this->url(Array('module'=>'advmenusystem', 'controller'=>'index', 'action'=>'getcontent'), 'default', true);?>',
    							data: {
    								format: 'html',
    								menu_id: menuId,
    								level:	2,
    								limit: 8
    							},
    							onSuccess: function(responseJSON, responseText, responseHTML, responseJavaScript) 
    							{
    								$("ynadvmenusystem-menu-children-"+menuId).innerHTML = responseHTML;
    								$("ynadvmenusystem-menu-children-"+menuId).removeClass('content-waiting');
    							}
    						}).send();    						
    					}
                   		
	    			} else {
		    			parent.addClass('over');
		    			$$('.ynmenu-listing li[data-level='+level+']:not(.over)').addClass('ynhide');	
	    			}
	    		}	    		
    		}    		
	    },
    });

	// toggle menu if smaller 768px;
	$$('.icon-menu-responsive').addEvents({
		click: function(){    		
			if ( $$('.ynmenu-listing').hasClass('ynhide') ) {
				$$('.ynhide:not(.ynmenu-listing)').removeClass('ynhide');
				$$('.over').removeClass('over');
				$$('.content').hide();
			} 

			$$('.ynmenu-listing').toggleClass('ynhide');				
	    }
	});	

	<?php if ($this->fix_menu_position):?>
	// scroll fixed 
	window.addEvent('scroll',function(e) {
	    var menu = $$('.ynadvanced-menu-system')[0],
	    	check = $$('.ynadvanced-menu-checked')[0];

	    var ynmenu_container = document.getSize();
    	
	    if ( window.pageYOffset > check.getPosition().y ) {
	    	if ( !menu.hasClass('menu-fixed') ) {
	    		menu.addClass('menu-fixed');
	    	
	    		// improve
	    		if ( ynmenu_container.x > 750 ) {
	    			check.setStyle('height', menu.getSize().y );
	    		}
	    	}
	    } else {
	    	menu.removeClass('menu-fixed');

	    	// improve
	    	check.erase('style');
	    }
	});	
	<?php endif;?>

	<?php if ($this->style_menu == 'flat'):?>
	// fix flat
	var ynadvanced_menu = $$('.ynmenu-container')[0];

    $$('.ynadvanced-menu-checked')[0].setStyle('height', ynadvanced_menu.getSize().y );
    $$('.ynadvanced-menu-system')[0].setStyles({
    	'margin-top': -ynadvanced_menu.getSize().y-4,
    	'height': ynadvanced_menu.getSize().y+4
    });

	window.addEvent('resize:throttle', function(){		
	    // Will only fire once every 250 ms
	    var ynadvanced_menu = $$('.ynmenu-container')[0];

	    $$('.ynadvanced-menu-checked')[0].setStyle('height', ynadvanced_menu.getSize().y );
	    $$('.ynadvanced-menu-system')[0].setStyles({
	    	'margin-top': -ynadvanced_menu.getSize().y-4,
	    	'height': ynadvanced_menu.getSize().y+4
	    });
	});
	<?php endif; ?>
</script>
