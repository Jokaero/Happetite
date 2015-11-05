<h2>
  <?php echo $this->translate('Social Link Management') ?>
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

<form id='multidelete_form' method="post" action="<?php echo $this->url();?>">
<table class='admin_table'>
  <thead>
    <tr>
      <th><?php echo $this->translate("Title") ?></th>
      <th><?php echo $this->translate("URL") ?></th>
      <th><?php echo $this->translate("Icon") ?></th>
      <th><?php echo $this->translate("Options") ?></th>
    </tr>
  </thead>
  <tbody>
      <!-- Facebook -->
      <tr>
        <td><?php echo $this->facebook['title'] ?></td>
        <td><?php echo $this->facebook['uri'] ?></td>
        <td><?php echo $this->facebook['icon']?></td>
        <td>
          <?php echo $this->htmlLink(array(
          	  'module' => 'advmenusystem',
          	  'controller' => 'socials',
              'action' => 'edit',
              'edit_name' => $this->facebook['title'],
              'route' => 'admin_default',
              'action' => 'edit',
              'reset' => true,
            ), $this->translate('edit'),
            	array('class' => 'smoothbox')
            ) ?>
        </td>
      </tr>
      <!-- Twitter -->
      <tr>
        <td><?php echo $this->twitter['title'] ?></td>
        <td><?php echo $this->twitter['uri'] ?></td>
        <td><?php echo $this->twitter['icon']?></td>
        <td>
          <?php echo $this->htmlLink(array(
          	  'module' => 'advmenusystem',
          	  'controller' => 'socials',
              'action' => 'edit',
              'edit_name' => $this->twitter['title'],
              'route' => 'admin_default',
              'action' => 'edit',
              'reset' => true,
            ), $this->translate('edit'),
            	array('class' => 'smoothbox')
            ) ?>
        </td>
      </tr>
      <!-- Pinterest -->
      <tr>
        <td><?php echo $this->pinterest['title'] ?></td>
        <td><?php echo $this->pinterest['uri'] ?></td>
        <td><?php echo $this->pinterest['icon']?></td>
        <td>
          <?php echo $this->htmlLink(array(
          	  'module' => 'advmenusystem',
          	  'controller' => 'socials',
              'action' => 'edit',
              'edit_name' => $this->pinterest['title'],
              'route' => 'admin_default',
              'action' => 'edit',
              'reset' => true,
            ), $this->translate('edit'),
            	array('class' => 'smoothbox')
            ) ?>
        </td>
      </tr>
      <!-- Youtube -->
      <tr>
        <td><?php echo $this->youtube['title'] ?></td>
        <td><?php echo $this->youtube['uri'] ?></td>
        <td><?php echo $this->youtube['icon']?></td>
        <td>
          <?php echo $this->htmlLink(array(
          	  'module' => 'advmenusystem',
          	  'controller' => 'socials',
              'action' => 'edit',
              'edit_name' => $this->youtube['title'],
              'route' => 'admin_default',
              'action' => 'edit',
              'reset' => true,
            ), $this->translate('edit'),
            	array('class' => 'smoothbox')
            ) ?>
        </td>
      </tr>
  </tbody>
</table>

