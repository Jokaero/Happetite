<?php
$baseUrl = $this->baseUrl();
$this->headScript()->appendFile($baseUrl . '/application/modules/Advmenusystem/externals/scripts/jquery.min-1.7.2.js');
$this->headScript()->appendFile($baseUrl . '/application/modules/Advmenusystem/externals/scripts/jquery.nestable.js'); 
function findChildren($parentId, $menuList, $level)
{
	$aResult = array();
	foreach ($menuList as $key => $menu)
	{
		if ($menu->parent_id == $parentId && $menu->level == $level)
		{
			$aResult[] = $menu;
		}
	}
	return $aResult;
}
?>

<h2>
  <?php echo $this->translate('Adv Menu System Plugin') ?>
</h2>

<?php if( count($this->navigation) ): ?>
<div class='tabs'>
    <?php
    // Render the menu
    //->setUlClass()
    echo $this->navigation()->menu()->setContainer($this->navigation)->render()
    ?>
</div>
<?php endif; ?>

<h2>
  <?php echo $this->translate('Menu Editor') ?>
</h2>
<p>
  <?php echo $this->translate('CORE_VIEWS_SCRIPTS_ADMINMENU_INDEX_DESCRIPTION') ?>
</p>

<br />

<div class="admin_menus_filter">
  <form action="<?php echo $this->url() ?>" method="get">
    <h3><?php echo $this->translate("Editing:") ?></h3>
    <?php echo $this->formSelect('name', $this->selectedMenu->name, array('onchange' => '$(this).getParent(\'form\').submit();'), $this->menuList) ?>
  </form>
</div>

<br />

<div class="admin_menus_options">
  <?php echo $this->htmlLink(array('reset' => false, 'action' => 'create', 'name' => $this->selectedMenu->name), $this->translate('Add Item'), array('class' => 'buttonlink admin_menus_additem smoothbox')) ?>
</div>
<div id="ynadvmenusystem-setting-message" class="hidden"><?php echo $this->translate("(*)You have changed something...");?></div>
<br />
<form id="form_order_menu" method="post">
<div class="dd" id="nestable3">
	<ol class="dd-list">
		<?php $submenu = $this->submenu; ?>
		<?php foreach( $this->menuItems as $menuItem ): ?>
		<?php
			$enable_content = 0;
			$params = $menuItem->params;	
			$style = $params['style'];
			if($style == "content")
			{
				$enable_content = 1;
			}
			if($enable_content)
			{
				$contentLink = " | ".$this->htmlLink(array('reset' => false,'controller' => 'contents', 'parent_id'=> $menuItem -> id, 'level' => '1' ), $this->translate('manage content'), array('target'=>'_blank'));
			}
			else {
				$contentLink = "";
			}
		?>	
	    <li class="dd-item dd3-item" data-id="<?php echo 'core_' . $menuItem->id;?>">
			<div class="dd-handle dd3-handle">Drag</div>
			<div class="dd3-content">
				<?php echo $this -> string() -> truncate($this->translate($menuItem->label), 15) ?>
				<span class="item_options">
        			<?php echo $this->htmlLink(array('reset' => false, 'action' => 'create-sub','name' => $this->selectedMenu->name,'level' => '1', 'parent_id' => $menuItem->id), $this->translate('create sub item'), array('class' => 'smoothbox')) ?>  | 
					<?php echo $this->htmlLink(array('reset' => false, 'action' => 'edit', 'name' => $menuItem->name,'menu'=>'main_menu','flag_unique'=>$menuItem->flag_unique), $this->translate('edit'), array('class' => 'smoothbox')) ?>
          			<?php echo $contentLink; ?>
          			<?php if( $menuItem->custom  && !(Engine_Api::_()->advmenusystem()->checklevel1HasModuleInSub($menuItem->id)) ): ?>
            			| <?php echo $this->htmlLink(array('reset' => false, 'action' => 'delete', 'name' => $menuItem->name, 'flag_unique'=>$menuItem->flag_unique), $this->translate('delete'), array('class' => 'smoothbox')) ?>
          			<?php endif; ?>
        		</span>
			</div>
			<?php
			/**
			 * Get child menu
			 */
			if (count($submenu)) 
			{
				$menuLevel1 = findChildren($menuItem->id, $submenu, 2);
				if (count($menuLevel1))
				{	$enable_content_sub = 0;
					$params = $menuItem->params;	
					$style = $params['style'];
					if($style == "mixed")
					{
						$enable_content_sub = 1;
					}
					echo "<ol class='dd-list'>";
					foreach ($menuLevel1 as $menu1)
					{
						$createLink = $this->htmlLink(array('reset' => false, 'action' => 'create-sub','name' => $this->selectedMenu->name,'level' => '2','parent_id' => $menu1->submenu_id), $this->translate('create sub item'), array('class' => 'smoothbox'));
						$editLink = $this->htmlLink(array('reset' => false, 'action' => 'edit-sub', 'submenu_id' => $menu1->submenu_id, 'name' => $this->selectedMenu->name), $this->translate('edit'), array('class' => 'smoothbox'));
						$coremenu1 = $menu1->getCoreMenu();
						$deleteLink = ((is_null($coremenu1) || $coremenu1->custom) && (!$menu1->checklevel2HasModuleInSub()))
							? (" | ". $this->htmlLink(array('reset' => false, 'action' => 'delete-sub', 'submenu_id' => $menu1->submenu_id), $this->translate('delete'), array('class' => 'smoothbox')) ) 
							: ("");
						if($enable_content_sub)
						{
							$contentLink = " | ".$this->htmlLink(array('reset' => false,'controller' => 'contents', 'parent_id'=> $menu1 -> submenu_id, 'level' => $menu1 -> level ), $this->translate('manage content'));
						}
						else {
							$contentLink = "";
						}
						echo "<li class='dd-item dd3-item' data-id='{$menu1->submenu_id}'>";
						echo "<div class='dd-handle dd3-handle'>Drag</div><div class='dd3-content'>". $this -> string() -> truncate($this->translate($menu1->label), 15)."<span class='item_options'> {$createLink} | {$editLink}{$deleteLink}{$contentLink}</span></div>";
						$menuLevel2 = findChildren($menu1->submenu_id, $submenu, 3);
						if (count($menuLevel2))
						{
							echo "<ol class='dd-list'>";
							foreach ($menuLevel2 as $menu2)
							{
								$editLink = $this->htmlLink(array('reset' => false, 'action' => 'edit-sub', 'submenu_id' => $menu2->submenu_id, 'name' => $this->selectedMenu->name), $this->translate('edit'), array('class' => 'smoothbox'));
								$coremenu2 = $menu2->getCoreMenu();
								$deleteLink = (is_null($coremenu2) || $coremenu2->custom) 
									? (" | ". $this->htmlLink(array('reset' => false, 'action' => 'delete-sub', 'submenu_id' => $menu2->submenu_id), $this->translate('delete'), array('class' => 'smoothbox')))
									: ("");
								echo "<li class='dd-item dd3-item' data-id='{$menu2->submenu_id}'>";
								echo "<div class='dd-handle dd3-handle'>Drag</div><div class='dd3-content'>". $this -> string() -> truncate($this->translate($menu2->label), 15)."<span class='item_options'> {$editLink}{$deleteLink}</span></div>";
								echo "</li>";
							}
							echo '</ol>';
						}
						echo "</li>";
					}
					echo '</ol>';
				}
			}
			?>
		</li>
		<?php endforeach; ?>
	</ol>
</div>

<div style="clear:both;">
<textarea id="nestable3-output" style="width: 100%; display: none;" name="list_ordered_menus"></textarea>
<textarea id="fist-status" style="width: 100%; display: none;" name="list_original_menus"></textarea>
<button name="btnSave" onclick="save();"><?php echo $this->translate("Save Change");?></button>
<button name="btnSitemap" onclick="renderSitemap();"><?php echo $this->translate("Save as Sitemap");?></button>
</div>
</form>
<script type="text/javascript">
jQuery.noConflict();
jQuery(document).ready(function(){
	var updateOrder = function(e)
    {
        var list   = e.length ? e : jQuery(e.target),
            output = list.data('output');
        if (window.JSON) 
        {
            output.val(window.JSON.stringify(list.nestable('serialize')));//, null, 2));
            if (jQuery("#ynadvmenusystem-setting-message").hasClass("hidden"))
    	    {
    	    	jQuery("#ynadvmenusystem-setting-message").removeClass("hidden");
    	    }
        } 
        else 
        {
            output.val('');
        }
    };
    var updateOrderFirst = function(e)
    {
        var list   = e.length ? e : jQuery(e.target),
            output = list.data('output');
        if (window.JSON) 
        {
            output.val(window.JSON.stringify(list.nestable('serialize')));//, null, 2));
        } 
        else 
        {
            output.val('');
        }
    };
	jQuery('#nestable3').nestable({
			maxDepth : 3
	}).on('change', updateOrder);
	updateOrderFirst(jQuery('#nestable3').data('output', jQuery('#nestable3-output')));
	jQuery('#fist-status').val(jQuery('#nestable3-output').val());
});
function save()
{
	jQuery("form#form_order_menu").submit();
	/*
	jQuery(window).bind('beforeunload', function(){
	    return '<?php echo $this->translate("(*)You have changed something...");?>';
	});
	*/
}
function renderSitemap()
{
	jQuery("form#form_order_menu").submit();
}
</script>

