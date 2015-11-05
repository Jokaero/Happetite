<script type="text/javascript">	
if(opener == null || opener == undefined){
	window.location.href = "<?php echo $this->redirectUrl ?>";
}else{
	opener.location="<?php echo $this->redirectUrl ?>";
	self.close();
}
</script>
