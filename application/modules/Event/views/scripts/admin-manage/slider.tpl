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
  <?php echo $this->translate("EVENT_VIEWS_SCRIPTS_ADMINMANAGE_SLIDER_DESCRIPTION") ?>
</p>

<?php if (count($this->slides) == 0): ?>
  
  <div class="tip">
    <span>
      <?php echo $this->translate('You do not slide!'); ?>
    </span>
  </div>
  
<?php else : ?>
  

    <table class='admin_table'>
          <thead>
            <tr>
              <th><?php echo $this->translate("Slide"); ?></th>
              <th><?php echo $this->translate("Description"); ?></th>
              <th><?php echo $this->translate("Options"); ?></th>
            </tr>

          </thead>
          <tbody>
              <?php $count = 1; ?>
              <?php foreach ($this->slides as $slide): ?>
                    <tr>
                      <td><?php echo $count++; ?></td>
                      <td><?php echo $slide->description; ?></td>
                      <td>
                        <?php echo $this->htmlLink(
                                        array('route' => 'default', 'module' => 'event', 'controller' => 'admin-manage', 'action' => 'remove', 'id' => $slide->slide_id),
                                        $this->translate('delete'),
                                        array('class' => 'smoothbox',
                        )) ?>

                      </td>
                    </tr>

            <?php endforeach; ?>
          </tbody>
        </table>
  

<?php endif; ?>
<?php echo $this->form->render($this); ?>