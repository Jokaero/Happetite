<?php if( $this->parent_type !== 'group' ) { ?>
<div class="headline">
  <h2>
    <?php echo $this->translate('Events') ?>
  </h2>
  <div class="tabs">
    <?php
      // Render the menu
      echo $this->navigation()
        ->menu()
        ->setContainer($this->navigation)
        ->render();
    ?>
  </div>
</div>
<?php } ?>
