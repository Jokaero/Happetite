<script type="text/javascript">

function multiDelete()
{
  return confirm("<?php echo $this->translate('Are you sure you want to delete the selected content entries?');?>");
}

function selectAll()
{
  var i;
  var multidelete_form = $('multidelete_form');
  var inputs = multidelete_form.elements;
  for (i = 1; i < inputs.length; i++) {
    if (!inputs[i].disabled) {
      inputs[i].checked = inputs[0].checked;
    }
  }
}
</script>

<h2>
  <?php echo $this->translate('Content Management') ?>
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
<div class="admin_search">
    <?php echo $this->form->render($this);?>
</div>
<?php if( count($this->paginator) ): ?>
<form id='multidelete_form' method="post" action="<?php echo $this->url();?>" onSubmit="return multiDelete()">
<table class='admin_table'>
  <thead>
    <tr>
      <th class='admin_table_short'><input onclick='selectAll();' type='checkbox' class='checkbox' /></th>
      <th class='admin_table_short'>ID</th>
      <th><?php echo $this->translate("Title") ?></th>
      <th><?php echo $this->translate("URL") ?></th>
	  <th><?php echo $this->translate("Menu") ?></th>
	  <th><?php echo $this->translate("Level") ?></th>
      <th><?php echo $this->translate("Date") ?></th>
      <th><?php echo $this->translate("Order") ?></th>
      <th><?php echo $this->translate("Enabled") ?></th>
      <th><?php echo $this->translate("Options") ?></th>
    </tr>
  </thead>
  <tbody>
    <?php foreach ($this->paginator as $item): ?>
    	<?php $params = json_decode($item -> params); ?>
      <tr>
        <td><input type='checkbox' class='checkbox' name='delete_<?php echo $item->getIdentity(); ?>' value="<?php echo $item->getIdentity(); ?>" /></td>
        <td><?php echo $item->getIdentity() ?></td>
        <td><?php echo $params->title ?></td>
        <td><?php echo $params->url ?></td>
		<td><?php echo $item->getParentName($item->parent_id, $item->level) ?></td>
		<td><?php echo $item->level ?></td>
        <td><?php echo $this->locale()->toDateTime($item->creation_date) ?></td>
        <td><?php echo $item->order ?></td>
        <td><?php if($item->enabled == 1) echo "Yes"; else echo "No"; ?></td>
        <td>
          <?php echo $this->htmlLink(array(
          	  'module' => 'advmenusystem',
          	  'controller' => 'contents',
              'action' => 'edit',
              'content_id' => $item->getIdentity(),
              'route' => 'admin_default',
              'action' => 'edit',
              'reset' => true,
            ), $this->translate('edit'),
            	array('class' => 'smoothbox')
            ) ?> |
          <?php echo $this->htmlLink(
                array('route' => 'default', 'module' => 'advmenusystem', 'controller' => 'admin-contents', 'action' => 'delete', 'id' => $item->content_id),
                $this->translate("delete"),
                array('class' => 'smoothbox')) ?>
        </td>
      </tr>
    <?php endforeach; ?>
  </tbody>
</table>

<br />

<div class='buttons'>
  <button type='submit'><?php echo $this->translate("Delete Selected") ?></button>
  <a href='<?php echo $this->url(
					array(
						'module'=>'advmenusystem',
						'controller' => 'contents', 
						'action' => 'create',
						'parent_id' => $this->parent_id,
						'level' => $this->level,
					), 
					'admin_default', 
					true
				); ?>' class='smoothbox'>
		<button type="button"><?php echo $this->translate("Add New Content") ?></button> 
  </a>
</div>
</form>

<br/>
<div>
  <?php echo $this->paginationControl($this->paginator); ?>
</div>

<?php else: ?>
  <div class="tip">
    <span>
      <?php echo $this->translate("There are no content entries yet.") ?>
    </span>
  </div>
  <div class='buttons'>
    <a href='<?php echo $this->url(
					array(
						'module'=>'advmenusystem',
						'controller' => 'contents', 
						'action' => 'create',
						'parent_id' => $this->parent_id,
						'level' => $this->level,
					), 
					'admin_default', 
					true
				); ?>' class='smoothbox'>
		<button type="button"><?php echo $this->translate("Add New Content") ?></button> 
  </a>
</div>
<?php endif; ?>
