<form class="global_form" method="POST">
	<div>
		<div>
			<h3><?php echo $this->translate("Verify Code") ?></h3>
			<p class="form-description"><?php echo $this->translate("Please check mail %s to get verify code and confirm following form to synchronize your account.", $this->email)?></p>
			<div class="form-elements">
				<?php if($this->message):?>
				<div class="tip" style="margin-bottom: 0px; margin-top: 10px">
				    <span>
				    	<?php echo $this->message;?>
				    </span>
				</div>
				<?php endif; ?>
				<div id="code-wrapper" class="form-wrapper">
					<div id="code-label" class="form-label">
						<label for="code" class="required"><?php echo $this->translate("Code")?></label>
					</div>
					<div id="code-element" class="form-element">
						<input type="text" name="code" id="code" value="" tabindex="1" autofocus="autofocus" class="text">
					</div>
				</div>
				<div id="submit-wrapper" class="form-wrapper">
					<div id="submit-label" class="form-label">&nbsp;</div>
					<div id="submit-element" class="form-element">
						<button name="submit" id="submit" type="submit" tabindex="3"><?php echo $this->translate("Verify Code") ?></button>
					</div>
				</div>
			</div>
				
		</div>
	</div>
</form>