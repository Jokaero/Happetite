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
  <?php echo $this->translate("EVENT_VIEWS_SCRIPTS_ADMINMANAGE_TRANSACTIONS_DESCRIPTION") ?>
</p>

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
      <?php echo $this->translate(array("%s transaction found", "%s transactions found", $count),
          $this->locale()->toNumber($count)) ?>
      <?php echo $this->htmlLink(array('route' => 'admin_default', 'module' => 'event', 'controller' => 'manage', 'action' => 'export-transactions'), $this->translate('Export CSV')); ?>
    </div>
  </div>
  
  <br />
  
  <table class='admin_table'>
    <thead>
      <tr>
        <th>ID</th>
        <th><?php echo $this->translate('Name'); ?></th>
        <th><?php echo $this->translate('Role'); ?></th>
        <th><?php echo $this->translate('Course'); ?></th>
        <th><?php echo $this->translate('Course Status'); ?></th>
        <th><?php echo $this->translate('Transaction Status'); ?></th>
        <th><?php echo $this->translate('Date'); ?></th>
        <th><?php echo $this->translate('Payment'); ?></th>
        <th><?php echo $this->translate('Actions'); ?></th>
      </tr>
    </thead>
    <tbody>
      <?php foreach ($this->paginator as $item) : ?>
	  <?php $event = $item->getEvent(); ?>
	  <?php $user = $item->getOwner(); ?>
      <tr>
        <td><?php echo $item->getIdentity(); ?></td>
        <td>
		  <?php if ($user->getIdentity()) : ?>
			<?php echo $this->htmlLink($user, $user->getTitle()); ?>
		  <?php elseif ($item->user_title) : ?>
			<?php echo $item->user_title; ?>
		  <?php else : ?>
			<span style="font-style: italic; color: #ccc;"><?php echo $this->translate('Deleted User'); ?></span>
		  <?php endif; ?>
		</td>
        <td>
          <?php echo $item->user_status; ?>
        </td>
        <td>
		  <?php if ($event) : ?>
			<?php echo $this->htmlLink($event, $event->getTitle()); ?>
		  <?php elseif ($item->event_title) : ?>
			<?php echo $item->event_title; ?>
		  <?php else : ?>
			<span style="font-style: italic; color: #ccc;"><?php echo $this->translate('Deleted'); ?></span>
		  <?php endif; ?>
		</td>
        <td>
		  <?php if ($event) : ?>
			<?php echo strtoupper($event->status); ?>
		  <?php else : ?>
			<span style="font-style: italic; color: #ccc;"><?php echo $this->translate('DELETED'); ?></span>
		  <?php endif; ?>
		</td>
        <td><?php echo strtoupper($item->status) ?></td>
        <td><?php echo $this->locale()->toDateTime($item->creation_date); ?></td>
        <td><?php echo $item->price; ?> <?php echo $item->currency; ?></td>
        <td>
          <?php echo $this->htmlLink(array('route' => 'admin_default', 'module' => 'event', 'controller' => 'manage', 'action' => 'detail-transaction', 'transaction_id' => $item->getIdentity()),
				$this->translate('detail'),
				array('class' => 'smoothbox')); ?>
          |
          <?php echo $this->htmlLink(array('route' => 'admin_default', 'module' => 'event', 'controller' => 'manage', 'action' => 'edit-transaction', 'transaction_id' => $item->getIdentity()),
				$this->translate('edit'),
				array('class' => 'smoothbox')); ?>
        </td>
      </tr>
      <?php endforeach; ?>
    </tbody>
  </table>
<?php else : ?>
  <div class="tip">
    <span>
      <?php echo $this->translate("No transactions.") ?>
    </span>
  </div>
<?php endif; ?>