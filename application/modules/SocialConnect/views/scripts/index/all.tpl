<h4>OR SIGN IN USING:</h4>
	<?php foreach ($this->providers as $o): ?>
		<a title="<?php echo $o->name ?>" href="<?php echo $this->url(array('service'=>$o->name), 'connect_signin') ?>">
            <?php echo $this->htmlImage('./externals/openid/'.$o->name.'.png', $o->name, array('style' => 'width:22px;margin:3px;')) ?>
            
        </a>
	<? endforeach; ?>