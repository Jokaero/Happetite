<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: index.tpl 9916 2013-02-15 03:13:27Z alex $
 * @author     Jung
 */
?>

<script type="text/javascript">

function multiDelete()
{
  return confirm("<?php echo $this->translate('Are you sure you want to delete the selected events?');?>");
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



<h2><?php echo $this->translate("Events Plugin") ?></h2>

<?php if( count($this->navigation) ): ?>
  <div class='tabs'>
    <?php
      // Render the menu
      //->setUlClass()
      echo $this->navigation()->menu()->setContainer($this->navigation)->render()
    ?>
  </div>
<?php endif; ?>

<p>
  <?php echo $this->translate("EVENT_VIEWS_SCRIPTS_ADMINMANAGE_INDEX_DESCRIPTION") ?>
</p>
<?php
$settings = Engine_Api::_()->getApi('settings', 'core');
if( $settings->getSetting('user.support.links', 0) == 1 ) {
	echo '     More info: <a href="http://support.socialengine.com/questions/195/Admin-Panel-Plugins-Events" target="_blank">See KB article</a>.';	
} 
?>	
<br />
<br />

<div class='admin_search'>
  <?php echo $this->formFilter->render($this) ?>
</div>

<br />

  <?php if( count($this->paginator) ): ?>
  <div class='admin_results'>
    <div>
      <?php echo $this->paginationControl($this->paginator, null, null, array(
        'pageAsQuery' => true,
        'query' => $this->formValues,
        //'params' => $this->formValues,
      )); ?>
    </div>
    <div>
      <?php $count = $this->paginator->getTotalItemCount() ?>
      <?php echo $this->translate(array("%s class found", "%s classes found", $count),
          $this->locale()->toNumber($count)) ?>
    </div>
  </div>
  
  <br />
  
  <form id='multidelete_form' method="post" action="<?php echo $this->url();?>" onSubmit="return multiDelete()" style="overflow: auto;">
    <table class='admin_table'>
      <thead>
        <tr>
          <th class='admin_table_short'><input onclick='selectAll();' type='checkbox' class='checkbox' /></th>
          <th class='admin_table_short'>ID</th>
          <th><?php echo $this->translate("Title") ?></th>
          <th><?php echo $this->translate("Owner") ?></th>
          <th><?php echo $this->translate("Price") ?></th>
          <th><?php echo $this->translate("Course Date") ?></th>
          <th><?php echo $this->translate("Creation Date") ?></th>
          <th><?php echo $this->translate("Guests Status") ?></th>
          <th><?php echo $this->translate("Course Status") ?></th>
          <th><?php echo $this->translate("Admin action pending") ?></th>
          <th><?php echo $this->translate("Options") ?></th>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($this->paginator as $item): ?>
          <tr>
            <td><input type='checkbox' class='checkbox' name='delete_<?php echo $item->event_id; ?>' value='<?php echo $item->event_id; ?>' /></td>
            <td><?php echo $item->event_id ?></td>
            <td><?php echo $this->htmlLink($item->getHref(), $item->getTitle()); ?></td>
            <td><?php echo $this->htmlLink($item->getOwner()->getHref(), $item->getOwner()->getTitle()); ?></td>
			<?php $sitePercent = Engine_Api::_()->getApi('settings', 'core')->getSetting('event_percent', 10); ?>
			<td><?php echo ceil($item->price * (1 + $sitePercent / 100)) ?> <?php echo $item->currency ?></td>
			<td><?php echo $this->locale()->toDateTime($item->starttime) ?></td>
			<td><?php echo $this->locale()->toDateTime($item->creation_date) ?></td>
			<td>
			  <?php echo $this->translate('All: %s', $item->getMemberCount(array(10, 0, 1, 2, 3, 4))); ?><br />
			  <?php echo $this->translate('Host: %s', $item->getMemberCount(array(10))); ?><br />
			  <?php echo $this->translate('Applied: %s', $item->getMemberCount(array(0))); ?><br />
			  <?php echo $this->translate('Accepted: %s', $item->getMemberCount(array(1, 2))); ?><br />
			  <?php echo $this->translate('Paid: %s', $item->getMemberCount(array(3))); ?><br />
			  <?php echo $this->translate('Refund: %s', $item->getMemberCount(array(4))); ?><br />
			</td>
			<td><?php echo strtoupper($item->status) ?></td>
			<td>
			  <?php if ($item->is_action) : ?>
				<?php echo $this->translate('YES'); ?>
			  <?php else : ?>
				<?php echo $this->translate('NO'); ?>
			  <?php endif; ?>
			</td>
            <td>
              <a href="<?php echo $this->url(array('action' => 'edit', 'event_id' => $item->event_id), 'event_specific') ?>" target="_blank">
                <?php echo $this->translate("edit") ?>
              </a>
              |
              <?php echo $this->htmlLink(
                array('route' => 'default', 'module' => 'event', 'controller' => 'admin-manage', 'action' => 'delete', 'id' => $item->event_id),
                $this->translate('delete'),
                array('class' => 'smoothbox',
              )) ?>
			  <br />
			  <?php echo $this->htmlLink(array(
				'route' => 'admin_default',
				'module' => 'event',
				'controller' => 'manage',
				'action' => 'courses-users',
				'event_id' => $item->event_id
			  ), $this->translate('users')); ?>
			  |
			  <?php echo $this->htmlLink(
				array('route' => 'admin_default', 'module' => 'event', 'controller' => 'manage', 'action' => 'transactions', 'event_id' => $item->event_id),
				$this->translate('transactions'),
				array('target' => '_blank')); ?>
            </td>
          </tr>
        <?php endforeach; ?>
      </tbody>
    </table>
      <br />

    <div class='buttons'>
      <button type='submit'><?php echo $this->translate("Delete Selected") ?></button>
    </div>
  </form>

<?php else:?>
  <div class="tip">
    <span>
      <?php echo $this->translate("There are no events posted by your members yet.") ?>
    </span>
  </div>
<?php endif; ?>
