<?php  
    $this->headScript()
        ->appendFile($this->layout()->staticBaseUrl . 'application/modules/Event/externals/scripts/slideGallery.js');
    $this->headLink()
        ->appendStylesheet($this->layout()->staticBaseUrl . 'application/modules/Event/externals/styles/slider.css');
?>
<script type="text/javascript">
    window.addEvent('domready', function() {
        var gallery5 = new fadeGallery($$(".gallery5"), {
            speed: 1000,
            paging: true,
            pagingEvent: "mouseenter",
            autoplay: true,
            //duration: 2000,
            onPlay: function() {
                this.fireEvent("start");
            }
        });
    });
</script>

<div id="landing-slider">
    <div class="gallery gallery5 gallery-fade">
        <div class="holder">
            <ul>
            <?php $storage = Engine_Api::_() -> getItemTable('storage_file'); ?>
            <?php foreach ($this->slides as $slide) : ?>
            <?php  $file = $storage->getFile($slide->file_id); ?>
                <li>
                    <div class="description-block">
                        <span class="description-slide">
                            <?php echo $this->translate($slide->description); ?>
                        </span>
                    </div>
                    <img src="<?php echo $file->storage_path; ?>" alt="image" width="100%"/>
                </li>
            <?php endforeach; ?>
            </ul>
        </div>
        <div class="control">
            <a href="javascript:void(0)" class="prev">prev</a>
            <a href="javascript:void(0)" class="next">next</a>
        </div>
    </div>
</div>

<?php
  // Supporting old functionality
  if ($this->viewer() and $this->viewer()->getIdentity() != '') {
    $mootoolsHref = '/members/home#layout_how_to_work_slider'; // Member Home Page
  } else {
    $mootoolsHref = '#layout_how_to_work_slider'; // Landing Page
  }
?>
<div class="generic_layout_container layout_core_html_block slider_text_wrapper">
  <div class="slider-text">
    <div>
      <div class="slider-text-btn">
        <div class="button-large button-large-orange">
          <a href="/classes/step/guest">
            <?php echo $this->translate('attend a class'); ?>
          </a>
        </div>
        <div class="button-large button-large-brown">
          <a href="/classes/step/host">
            <?php echo $this->translate('host a class'); ?>
          </a>
        </div>
        <div class="btn-light">
          <a href="<?php echo $mootoolsHref; ?>">
            <?php echo $this->translate('how it works'); ?>
          </a>
        </div>
      </div>
    </div>
  </div>
</div>