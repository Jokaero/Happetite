<div class="ynmenu-footer-iconsocial">
<?php if($this->show_facebook && $this->facebook): ?>
	<?php if((strpos($this->facebook['uri'],'http://') === false) && (strpos($this->facebook['uri'],'https://') === false)) : ?>
		<?php
			$this->facebook['uri'] = 'http://'.$this->facebook['uri'];
		?>
	<?php endif; ?>	
	<?php if($this->facebook['icon']) :?>
        <?php echo $this->htmlLink($this->facebook['uri'], $this->htmlImage($this->facebook['icon'], array('alt'=>$this->facebook['title'])))?>
	<?php else:?>
		<span>-</span>  <?php echo $this->htmlLink($this->facebook['uri'], $this->facebook['title']);?>
	<?php endif; ?>	
<?php endif; ?>

<?php if($this->show_twitter && $this->twitter): ?>
	<?php if((strpos($this->twitter['uri'],'http://') === false) && (strpos($this->twitter['uri'],'https://') === false)) : ?>
	<?php
		$this->twitter['uri'] = 'http://'.$this->twitter['uri'];
	?>
	<?php endif; ?>	
    <?php if($this->twitter['icon']) :?>
        <?php echo $this->htmlLink($this->twitter['uri'], $this->htmlImage($this->twitter['icon'], array('alt'=>$this->twitter['title'])))?>
	<?php else:?>
		<span>-</span> <?php echo $this->htmlLink($this->twitter['uri'], $this->twitter['title']);?>
	<?php endif; ?>
<?php endif; ?>

<?php if($this->show_pinterest && $this->pinterest): ?>
	<?php if((strpos($this->pinterest['uri'],'http://') === false) && (strpos($this->pinterest['uri'],'https://') === false)) : ?>
	<?php
		$this->pinterest['uri'] = 'http://'.$this->pinterest['uri'];
	?>
	<?php endif; ?>	
    <?php if($this->pinterest['icon']) :?>
        <?php echo $this->htmlLink($this->pinterest['uri'], $this->htmlImage($this->pinterest['icon'], array('alt'=>$this->pinterest['title'])))?>
	<?php else:?>
		<span>-</span> <?php echo $this->htmlLink($this->pinterest['uri'], $this->pinterest['title']);?>
	<?php endif; ?> 
<?php endif; ?>

<?php if($this->show_youtube && $this->youtube): ?>
	<?php if((strpos($this->youtube['uri'],'http://') === false) && (strpos($this->youtube['uri'],'https://') === false)) : ?>
	<?php
		$this->youtube['uri'] = 'http://'.$this->youtube['uri'];
	?>
	<?php endif; ?>	
      <?php if($this->youtube['icon']) :?>
        <?php echo $this->htmlLink($this->youtube['uri'], $this->htmlImage($this->youtube['icon'], array('alt'=>$this->youtube['title'])))?>
	<?php else:?>
		<span>-</span> <?php echo $this->htmlLink($this->youtube['uri'], $this->youtube['title']);?>
	<?php endif; ?> 
<?php endif; ?>
</div>

<div class="ynmenu-footer-main">
<?php echo $this->translate('Copyright &copy;%s', date('Y')) ?>
<?php foreach( $this->navigation as $item ):
  $attribs = array_diff_key(array_filter($item->toArray()), array_flip(array(
    'reset_params', 'route', 'module', 'controller', 'action', 'type',
    'visible', 'label', 'href'
  )));
  ?>
  &nbsp;-&nbsp; <?php echo $this->htmlLink($item->getHref(), $this->translate($item->getLabel()), $attribs) ?>
<?php endforeach; ?>
<?php if($this->show_language_dropdown) :?>
<?php if( 1 !== count($this->languageNameList) ): ?>
    &nbsp;-&nbsp;
    <form method="post" action="<?php echo $this->url(array('controller' => 'utility', 'action' => 'locale'), 'default', true) ?>" style="display:inline-block">
      <?php $selectedLanguage = $this->translate()->getLocale() ?>
      <?php echo $this->formSelect('language', $selectedLanguage, array('onchange' => '$(this).getParent(\'form\').submit();'), $this->languageNameList) ?>
      <?php echo $this->formHidden('return', $this->url()) ?>
    </form>
<?php endif; ?>
<?php endif; ?>

<?php if( !empty($this->affiliateCode) ): ?>
  <div class="affiliate_banner">
    <?php 
      echo $this->translate('Powered by %1$s', 
        $this->htmlLink('http://www.socialengine.com/?source=v4&aff=' . urlencode($this->affiliateCode), 
        $this->translate('SocialEngine Community Software'),
        array('target' => '_blank')))
    ?>
  </div>
<?php endif; ?>
</div>