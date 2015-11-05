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
  <?php echo $this->translate("EVENT_VIEWS_SCRIPTS_ADMINMANAGE_COURSES_USERS_DESCRIPTION") ?>
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
      <?php echo $this->translate(array("%s member found", "%s members found", $count),
          $this->locale()->toNumber($count)) ?>
    </div>
  </div>

  <br />
  
  <table class='admin_table'>
    <thead>
      <tr>
        <th>ID</th>
        <th><?php echo $this->translate('Name'); ?></th>
        <th><?php echo $this->translate('Course'); ?></th>
        <th><?php echo $this->translate('Role'); ?></th>
        <th><?php echo $this->translate('Guest Status'); ?></th>
        <th><?php echo $this->translate('Last Status Change'); ?></th>
        <th><?php echo $this->translate('Admin action pending'); ?></th>
        <th><?php echo $this->translate('Payment'); ?></th>
        <th><?php echo $this->translate('Actions'); ?></th>
      </tr>
    </thead>
    <tbody>
      <?php foreach ($this->paginator as $item) : ?>
      <?php $user = Engine_Api::_()->getItem('user', $item->user_id); ?>
      <?php $event = Engine_Api::_()->getItem('event', $item->resource_id); ?>
      <tr>
        <td><?php echo $user->getIdentity(); ?></td>
        <td><?php echo $user->getTitle(); ?></td>
        <td><?php echo $event->getTitle(); ?></td>
        <td>
          <?php if ($event->isOwner($user)) : ?>
            <?php echo $this->translate('Owner'); ?>
          <?php else : ?>
            <?php echo $this->translate('Guest'); ?>
          <?php endif; ?>
        </td>
        <td><?php echo $this->translate('EVENT_MEMBER_STATUS_' . $item->rsvp); ?></td>
        <td><?php echo $this->locale()->toDateTime($item->rsvp_update); ?></td>
        <td>
          <?php if ($event->isOwner($user)) : ?>
            <?php if ($event->status == 'verified') : ?>
              <?php echo $this->translate('YES'); ?>
            <?php else : ?>
              <?php echo $this->translate('NO'); ?>
            <?php endif; ?>
          <?php else : ?>
            <?php if ($item->rsvp == 4) : ?>
              <?php echo $this->translate('YES'); ?>
            <?php else : ?>
              <?php echo $this->translate('NO'); ?>
            <?php endif; ?>
          <?php endif; ?>
        </td>
        <td>
          <?php echo Engine_Api::_()->getItemTable('event_transaction')->getPayment($user, $event); ?>
        </td>
        <td>
          <?php if ($item->rsvp == 4) : ?>
          <?php echo $this->htmlLink(array(
              'route' => 'admin_default',
              'module' => 'event',
              'controller' => 'manage',
              'action' => 'user-refund',
              'user_id' => $item->user_id,
              'event_id' => $item->resource_id
          ), $this->translate('refund'),
          array('class' => 'smoothbox')); ?>
          |
          <?php endif; ?>
          
          <?php echo $this->htmlLink(array(
              'route' => 'admin_default',
              'module' => 'event',
              'controller' => 'manage',
              'action' => 'transactions',
              'user_id' => $item->user_id,
              'event_id' => $item->resource_id
          ), $this->translate('transactions'),
          array('target' => '_blank')); ?>
        </td>
      </tr>
      <?php endforeach; ?>
    </tbody>
  </table>
  
<?php else : ?>
  <div class="tip">
    <span>
      <?php echo $this->translate("No items.") ?>
    </span>
  </div>
<?php endif; ?>
  