<?php if ($this->status):?>
<span class="none"><?php echo $this->message?></span>
<?php else:?>
	<span class="none"><?php echo $this->error?></span>
<?php endif;?>
