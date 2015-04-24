<?php $this->headScript()->appendFile('http://w.sharethis.com/button/buttons.js'); ?>

<div class="classes-steps-guest-share-content" id="classes-steps-guest-share-content">
  <h3 class="title">
    <span class="main"><?php echo $this->translate('CLASSES_STEP_GUEST_SHARE_TITLE'); ?></span>
    <span class="more"><?php echo $this->translate('CLASSES_STEP_GUEST_SHARE_TITLE_MORE'); ?></span>
  </h3>
  <div class="description">
    <?php echo nl2br($this->translate('CLASSES_STEP_GUEST_SHARE_DESCRIPTION')); ?>
  </div>
  <div class="share-buttons">
    <div class="email">
      <a href="javascript:void(0)">
        <span class="email-button" id="email-button"></span>
      </a>
    </div>
    <div class="twitter">
      <a href="javascript:void(0)">
        <span class="twitter-button" id="twitter-button"></span>
      </a>
    </div>
    <div class="facebook">
      <a href="javascript:void(0)">
        <span class="facebook-button" id="facebook-button"></span>
      </a>
    </div>
  </div>
  <div class="skip">
    <?php echo $this->htmlLink(array('route' => 'event_profile', 'id' => $this->eventId), $this->translate('Skip this step')); ?>
  </div>
</div>

<script type="text/javascript">
  stLight.options({
    publisher: "0f711e1f-43fa-44eb-9a5c-b14fc0c026fe",
    shorten: false,
  });
</script>

<script>
  stWidget.addEntry({
    "service":"facebook",
    "element":document.getElementById('facebook-button'),
    "url":'<?php echo Engine_Api::_()->event()->getSiteUrl() . $this->url(array('id' => $this->eventId), 'event_profile'); ?>',
    "title":'<?php echo $this->translate('SHARED_GUEST_TITLE_FACEBOOK'); ?>',
    "type":"custom",
    "image":"/application/modules/Event/externals/images/fb.png",
  });
</script>

<script>
  stWidget.addEntry({
    "service":"twitter",
    "element":document.getElementById('twitter-button'),
    "url":'<?php echo Engine_Api::_()->event()->getSiteUrl() . $this->url(array('id' => $this->eventId), 'event_profile'); ?>',
    "title":'<?php echo $this->translate('SHARED_GUEST_TITLE_TWITTER'); ?>',
    "type":"custom",
    "image":"/application/modules/Event/externals/images/twitter.png",
  });
  
  <?php $url = Engine_Api::_()->event()->getSiteUrl() . $this->url(array('id' => $this->eventId), 'event_profile'); ?>
  stWidget.addEntry({
    "service":"email",
    "element":document.getElementById('email-button'),
    "url": "<?php echo addslashes($this->translate('SHARED_GUEST_TEXT_EMAIL %s', $url)); ?>",
    "title":'<?php echo $this->translate('SHARED_GUEST_TITLE_EMAIL'); ?>',
    "type":"custom",
    "image":"/application/themes/happetite/images/attend3-soc-mail.png",
  });
</script>





