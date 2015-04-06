<div class="classes-steps-host-content" id="classes-steps-host-content">
  <div class="image-block">
    <div class="main-image"></div>
  </div>
  <div class="description-block">
    <h3 class="title">
      <span class="line"></span>
      <span><?php echo $this->translate(sprintf('%1$sBe%2$s a %3$sH%4$sost!', '<span class="first-wrapper">', '</span>', '<span class="second-wrapper">', '</span>')); ?></span>
      <span class="line"></span>
    </h3>
    <div class="description">
      <?php echo nl2br($this->translate('CLASSES_FIRST_STEP_HOST_DESCRIPTION')); ?>
    </div>
    <div class="next-step-button">
      <?php echo $this->htmlLink(array('route' => 'event_general', 'action' => 'create'), '<button>' . $this->translate('Be a Host!') . '</button>');
      ?>
    </div>
  </div>
</div>