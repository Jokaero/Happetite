<?php if( $this->form ): ?>
	
  <?php echo $this->form->render($this) ?>

<?php elseif( $this->status ): ?>

  <div><?php echo $this->translate("Your changes have been saved.") ?></div>

<?php endif; ?>