<style type="text/css">
  #global_content{
	width: 970px;
  }
</style>
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
  <?php echo $this->translate("EVENT_VIEWS_SCRIPTS_ADMINMANAGE_USERS_DESCRIPTION") ?>
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
        <th><?php echo $this->translate("Name") ?></th>
        <th><?php echo $this->translate("Owner in Active Courses") ?></th>
        <th><?php echo $this->translate("Guest in Active Courses") ?></th>
        <th><?php echo $this->translate("Accumulated received money") ?></th>
        <th><?php echo $this->translate("Accumulated paid money") ?></th>
        <th><?php echo $this->translate("Actions") ?></th>
      </tr>
    </thead>
    <tbody>
      <?php foreach ($this->paginator as $item):
          $user = Engine_Api::_()->getItem('user', $item->user_id); ?>
        <?php if (empty($user)) continue; ?>
      <tr>
        <td><?php echo $user->getIdentity() ?></td>
        <td><?php echo $user->getTitle() ?></td>
        <td><?php echo Engine_Api::_()->event()->getEventCountInfoAs($user, array('type' => 'owner', 'when' => 'not_later')) ?></td>
        <td><?php echo Engine_Api::_()->event()->getEventCountInfoAs($user, array('type' => 'guest', 'when' => 'not_later')) ?></td>
        <td>
          <?php echo Engine_Api::_()->event()->getFinanceInfo($user, array('type' => 'received')) ?>
        </td>
        <td>
          <?php echo Engine_Api::_()->event()->getFinanceInfo($user, array('type' => 'paid')) ?>
        </td>
        <td>
          <?php echo $this->htmlLink(array('route' => 'admin_default', 'module' => 'event', 'controller' => 'manage', 'action' => 'transactions', 'user_id' => $item->user_id),
				$this->translate('transactions'),
				array('target' => '_blank')); ?>
          |
          <?php echo $this->htmlLink(array(
            'route' => 'admin_default',
            'module' => 'event',
            'controller' => 'manage',
            'action' => 'users-courses',
            'user_id' => $user->getIdentity()
          ), $this->translate('courses')); ?>
        </td>
      </tr>
      <?php endforeach; ?>
    </tbody>
  </table>
<?php else : ?>
  <div class="tip">
    <span>
      <?php echo $this->translate("No members.") ?>
    </span>
  </div>
<?php endif; ?>