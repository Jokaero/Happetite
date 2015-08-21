<script type="text/javascript">	
var redirectUrl = "<?php echo $this->redirectUrl ?>";

if(opener == null || opener == undefined)
{
	window.location.href = redirectUrl;
}else{
	opener.location=redirectUrl;
	self.close();
}
</script>