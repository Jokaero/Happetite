<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.net/license/
 * @version    $Id: index.tpl 7250 2010-09-01 07:42:35Z john $
 * @author     John
 */
?>

<script type="text/javascript">

  var SortablesInstance;

  window.addEvent('domready', function() {
    $$('.item_label').addEvents({
      mouseover: showPreview,
      mouseout: showPreview
    });
  });

  var showPreview = function(event) {
    try {
      element = $(event.target);
      element = element.getParent('.admin_menus_item').getElement('.item_url');
      if( event.type == 'mouseover' ) {
        element.setStyle('display', 'block');
      } else if( event.type == 'mouseout' ) {
        element.setStyle('display', 'none');
      }
    } catch( e ) {
      //alert(e);
    }
  }


  window.addEvent('load', function() {
    SortablesInstance = new Sortables('menu_list', {
      clone: true,
      constrain: false,
      handle: '.item_label',
      onComplete: function(e) {
        reorder(e);
      }
    });
  });

 var reorder = function(e) {
     var menuitems = e.parentNode.childNodes;
     var ordering = {};
     var i = 1;
     for (var menuitem in menuitems)
     {
       var child_id = menuitems[menuitem].id;

       if ((child_id != undefined) && (child_id.substr(0, 5) == 'admin'))
       {
         ordering[child_id] = i;
         i++;
       }
     }
    ordering['menu'] = '<?php echo $this->selectedMenu->name;?>';
    ordering['format'] = 'json';

    // Send request
    var url = '<?php echo $this->url(array('action' => 'order')) ?>';
    var request = new Request.JSON({
      'url' : url,
      'method' : 'POST',
      'data' : ordering,
      onSuccess : function(responseJSON) {
      }
    });

    request.send();
  }

  function ignoreDrag()
  {
    event.stopPropagation();
    return false;
  }
  var is_select = false;
	function getItemsSelect(active)
	{
	       
	    var Checkboxs = document.forms[1].elements;
	    var values = "";
	    for(var i = 0; i < Checkboxs.length; i++) 
	    {    
	        var type = Checkboxs[i].type;
	        if (type=="checkbox" && Checkboxs[i].checked )
	        {                 
	            values += "," + Checkboxs[i].value;                
	        }
	    }
	    if(values != "")
	    {
	        values = "(" + values + ",)";
	        is_select = true;
	    }
	    else
	    {
	        is_select = false;
	        alert('Please select a items!');
	    }
	    if ( active > -1)
	    {
	        $('is_set_submenu').value = active;
	        $('submenus').value = values;    
	    }
	    else
	    {
	            
	        return is_select ;
	    }
	    return false;
	}
</script>
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

<br />
<form id='multisubmenu_form' method="post" action="">
<ul class="admin_menus_items" id='menu_list'>
  <?php foreach( $this->menuItems as $menuItem ): ?>
    <li class="admin_menus_item<?php if( isset($menuItem->enabled) && !$menuItem->enabled ) echo ' disabled' ?>"<?php if ($menuItem->submenu == 1) echo "style='padding-left:25px;'" ?> id="admin_menus_item_<?php echo $menuItem->name ?>">
      <span style="float: left; padding-top: 5px;"><input type="checkbox" value="<?php echo $menuItem->name?>" /></span>
      <span class="item_wrapper" style="clear: none">
        <span class="item_options">
          <?php echo $this->htmlLink(array('reset' => false, 'action' => 'edit', 'name' => $menuItem->name,'flag_unique'=>$menuItem->flag_unique), $this->translate('edit'), array('class' => 'smoothbox')) ?>
          <?php if( $menuItem->custom ): ?>
            | <?php echo $this->htmlLink(array('reset' => false, 'action' => 'delete', 'name' => $menuItem->name, 'flag_unique'=>$menuItem->flag_unique), $this->translate('delete'), array('class' => 'smoothbox')) ?>
          <?php endif; ?>
        </span>
        <span class="item_label">
          <?php echo $this->translate($menuItem->label) ?>
        </span>
        <span class="item_url">
          <?php
            $href = '';
            if( isset($menuItem->params['uri']) ) {
              echo $this->htmlLink($menuItem->params['uri'], $menuItem->params['uri']);
            } else if( !empty($menuItem->plugin) ) {
              echo '<a>(' . $this->translate('variable') . ')</a>';
            } else {
              echo $this->htmlLink($this->htmlLink()->url($menuItem->params), $this->htmlLink()->url($menuItem->params));
            }
          ?>
        </span>
      </span>
    </li>
  <?php endforeach; ?>
</ul>
<div class='buttons'>
  <button type='button' name="submenu" onclick ="getItemsSelect(1);if (is_select){document.getElementById('multisubmenu_form').submit();}"><?php echo $this->translate("Submenu Selected") ?></button>
  <button type='button' name="unsubmenu" onclick ="getItemsSelect(0);if (is_select){document.getElementById('multisubmenu_form').submit();}"><?php echo $this->translate("Un-Submenu Selected") ?></button>
</div>
 <input type="hidden" value="1" name="is_set_submenu" id="is_set_submenu"/>
 <input type="hidden" value="" name="submenus" id="submenus"/>
</form>

