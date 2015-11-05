<h2><?php echo $this->translate("SOCIAL_CONNECT") ?></h2>

<?php if( count($this->navigation) ): ?>
  <div class='tabs'>
    <?php
      echo $this->navigation()->menu()->setContainer($this->navigation)->render()
    ?>
  </div>
<?php endif; ?>
<p>
	<?php echo $this->translate("SOCIAL_CONNECT_PROVIDER_DESC") ?>
</p><br/>
  <div class='clear'>
    <div class='settings'>
		<table class='admin_table'>
		  <thead>
		    <tr>
		      <th class='admin_table_short'>ID</th>
				  <th style="width: 50%"><?php echo $this->translate("Service") ?></th>
				  <th><?php echo $this->translate("Users") ?></th>
				  <th><?php echo $this->translate("Returning Users") ?></th>
				  <th><?php echo $this->translate("Enable") ?></th>
				  <th><?php echo $this->translate("Option") ?></th>
		    </tr>
		  </thead>
		  <tbody>
		    <?php foreach ($this->paginator as $item): ?>
		      <tr>
		        <td><?php echo $item->service_id ?></td>
		        <td><?php echo $item->title ?></td>
		        <td><?php echo Engine_Api::_() -> getDbTable('Accounts', 'SocialConnect')->getTotalUsers($item->name); ?></td>
		        <td><?php echo Engine_Api::_() -> getDbTable('Accounts', 'SocialConnect')->getTotalReturningUsers($item->name); ?></td>
		        <td><?php
				if ($item -> privacy > 0)
				{
					echo '<a href="' . $this -> url(array(
						'module' => 'social-connect',
						'controller' => 'settings',
						'action' => 'change-enable',
						'service_id' => $item -> service_id
					)) . '" class="smoothbox" title="click to disable this provider">Enable</a>';
				}
				else
				{
					echo '<a href="' . $this -> url(array(
						'module' => 'social-connect',
						'controller' => 'settings',
						'action' => 'change-enable',
						'service_id' => $item -> service_id
					)) . '" class="smoothbox" title="click to enable this provider">Disabled</a>';
				}
		        ?></td>
		        <td>
		      		<a class="smoothbox" href="<?php echo $this->url(array('module' => 'social-connect', 'controller' => 'settings', 'action' => 'map','service'=>$item->name)) ?>"><?php echo $this->translate("Edit");?></a>
		        </td>
		      </tr>
		    <?php endforeach; ?>
		  </tbody>
		</table>
    </div>
  </div>


