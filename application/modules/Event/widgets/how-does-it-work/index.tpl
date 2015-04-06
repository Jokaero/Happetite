<script type="text/javascript">
  //when the dom is ready
  window.addEvent('domready',function() {
    //smooooooth scrolling enabled
    //new SmoothScroll({ options }, window);
    new SmoothScroll({ duration:700 }, window); //700 milliseconds to get there
  });
  
  window.addEvent('domready', function() {
    var gallery_how_does_it_work = new slideGallery($$("#layout_how_to_work_slider"), {
      steps: 1,
      mode: "callback",
      nextItem: ".how_to_img_right",
      prevItem: ".how_to_img_left",
      duration: 5000,
      autoplay: true,
      paging: false,
      pagingHolder: ".paging",
      onPlay: function() {
        this.fireEvent("start");
      }
    });
  });
</script>

<style type="text/css">
  .layout_how_to_work .holder {
    width: 100%;
    overflow: hidden;
    padding-top: 50px;
    margin-top: -50px;
  }
  .layout_how_to_work .holder > ul {
    width: 30000px;
    margin: 0;
    padding: 0;
    
  }
  .layout_how_to_work .holder > ul > li {
    width: 960px;
    position: relative;
    float: left;
  }
  .layout_how_to_work .holder > ul > li > div {
    text-align: center;
    position: relative;
    font-family: "QuattrocentoSans-Regular";
    line-height: 22px;
    z-index: 23;
    padding-top: 90px;
    width: 240px;
  }
  .layout_how_to_work .holder > ul > li > div span {
    font-family: "QuattrocentoSans-Bold";
  }
  .layout_how_to_work .slide_header {
    position: absolute;
    font-size: 18px;
    font-family: "Lato-Black";
    text-transform: uppercase;
    top: -47px;
    width: 20%;
  left: 40%;
  text-align: center;
  }
  .layout_how_to_work > h3 {
    position: relative;
  }
  .layout_how_to_work > h3 > .how_to_left,
  .layout_how_to_work > h3 > .how_to_right
  {
    position: absolute;
    z-index: 9999;
    width: 30%;
  }
  .layout_how_to_work > h3 > .how_to_left {
    left: 13%;
  }
  .layout_how_to_work > h3 > .how_to_left .how_to_line,
  .layout_how_to_work > h3 > .how_to_right  .how_to_line
  {
    width: 75% !important;
    
  }
  .layout_how_to_work > h3 > .how_to_right {
    right: 13%;
  }
  .layout_event_how_does_it_work > h3 {
    margin-bottom: 80px !important;
  }
  .layout_how_to_work h3 span.how_to_img_left,
  .layout_how_to_work h3 span.how_to_img_right {
    width: 15% !important;
  }
</style>

<div class="layout_how_to_work" id="layout_how_to_work_slider">
  <h3>
    <span class="how_to_left">
      <span class="how_to_line"></span> 
      <span class="how_to_img_left"></span>
    </span>
    <span class="how_to_right">
      <span class="how_to_img_right"></span>
      <span class="how_to_line"></span>
    </span>
  </h3>
  
  <div class="holder steps">
    <ul>
      <li>
        <span class="slide_header">
          <?php echo $this->translate('Steps for hosts'); ?>
        </span>
        <div class="step_one">
          <?php echo $this->translate('HOW_DOES_IT_WORK_STEP_ONE'); ?>
        </div>
        <div class="step_third">
          <?php echo $this->translate('HOW_DOES_IT_WORK_STEP_THIRD'); ?>
        </div>
        <div class="step_second">
          <?php echo $this->translate('HOW_DOES_IT_WORK_STEP_SECOND'); ?>
        </div>
        <span class="outer">
          <span class="inner"></span>
        </span>
      </li>
      <li>
        <span class="slide_header">
          <?php echo $this->translate('Steps for guest'); ?>
        </span>
        <div class="step_one">
          <?php echo $this->translate('HOW_DOES_IT_WORK_STEP_GUEST_ONE'); ?>
        </div>
        <div class="step_third">
          <?php echo $this->translate('HOW_DOES_IT_WORK_STEP_GUEST_THIRD'); ?>
        </div>
        <div class="step_second">
          <?php echo $this->translate('HOW_DOES_IT_WORK_STEP_GUEST_SECOND'); ?>
        </div>
        <span class="outer">
          <span class="inner"></span>
        </span>
      </li>
    </ul>
  </div>
  <div class="slider-text-btn">
    <span class="slider-text-btn-line"></span>
    <div class="button-large button-large-orange">
      <?php
          echo $this->htmlLink(array(
            'route' => 'event_steps',
            'action' => 'guest'
          ), $this->translate('attend a class'));       
      ?>
    </div>
    <?php echo $this->translate('- or -'); ?>
    <div class="button-large button-large-orange become">
      <?php
          echo $this->htmlLink(array(
            'route' => 'event_steps',
            'action' => 'host'
          ), $this->translate('become a host'));
      ?>
    </div>
    <span class="slider-text-btn-line"></span>
  </div>
</div>
