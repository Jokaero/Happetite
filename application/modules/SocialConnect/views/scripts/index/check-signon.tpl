<script type="text/javascript">
	<?php if ($this->redirectUrl):?>
	opener.location = '<?php echo $this->redirectUrl ?>';
	<?php else: ?>
	opener.location = opener.location;
	<?php endif; ?>
	self.close();
</script>