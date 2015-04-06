<ul class="content">
	<?php foreach ($this->contents as $content):?>
		<?php 
			$params = Zend_Json::decode($content->params);
			$url = (isset($params['url']) && $params['url'] != '') ? $params['url'] : "#";
			$title = (isset($params['title']) && $params['title'] != '') ? $params['title'] : $this->translate("Untitled");
			$photoUrl = ($content->photo_id) ? $content->getPhotoUrl() : "";
		?>
		<li class="item-content">
			<a href="<?php echo $url;?>" title="<?php echo $title;?>" style="background-image: url(<?php echo $photoUrl;?>);"
				target ="<?php echo ( !empty($this->parent -> advparams['target']) ? $this->parent -> advparams['target'] : null )?>"
			>
				<span><?php echo $this->string()->truncate($this->escape($title),65);?></span>
			</a>
		</li>
	<?php endforeach;?>
</ul>