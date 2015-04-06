<div class="classes-steps-guest-content" id="classes-steps-guest-content">
  <div class="image-block">
    <div class="main-image"></div>
  </div>
  <div class="description-block">
    <h3 class="title">
      <span class="line"></span>
      <span><?php echo $this->translate(sprintf('%1$sBe%2$s a %3$sG%4$suest!', '<span class="first-wrapper">', '</span>', '<span class="second-wrapper">', '</span>')); ?></span>
      <span class="line"></span>
    </h3>
    <div class="description">
      <?php echo nl2br($this->translate('CLASSES_FIRST_STEP_GUEST_DESCRIPTION')); ?>
    </div>
    <div class="next-step-button">
      <?php echo $this->htmlLink(array('route' => 'event_extended'), '<button>' . $this->translate('Be a Guest!') . '</button>');
      ?>
    </div>
  </div>
</div>