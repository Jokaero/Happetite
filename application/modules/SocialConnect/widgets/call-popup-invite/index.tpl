<?php if(isset($_SESSION['social_connect_invite'])):
	$service = $_SESSION['social_connect_invite'];?>
	<script type="text/javascript">
		Smoothbox.open("<?php echo $this->url(array('provider'=>$service, 'type' => 'email'),'contactimporter_popup') ?>");
	</script>
<?php unset($_SESSION['social_connect_invite']);
endif;?>