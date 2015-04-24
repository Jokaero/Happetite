<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: edit.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     Sami
 */
?>

<?php
$this->headScript()
  ->appendFile($this->layout()->staticBaseUrl . 'externals/calendar/calendar.compat.js');
$this->headLink()
  ->appendStylesheet($this->layout()->staticBaseUrl . 'externals/calendar/styles.css');
?>
<script type="text/javascript">
  var myCalStart = false;
  var myCalEnd = false;

  en4.core.runonce.add(function init() 
  {
    monthList = [];
    myCal = new Calendar({ 'starttime[date]': 'M d Y', 'endtime[date]' : 'M d Y' }, {
      classes: ['event_calendar'],
      pad: 0,
      direction: 0
    });
});

  window.addEvent('domready', function() {
    var site_percent = <?php echo Engine_Api::_()->getApi('settings', 'core')->getSetting('event_percent', 10) ?>;
    var site_percent_price = 0;
    
    price_percent_calculate = function() {
      var site_price = parseFloat($('price').value);
      site_percent_price = site_price * (site_percent / 100);
      
      if (isNaN(site_percent_price)) {
        $('service_free').set('html', '');
        $('total_price_percent').set('html', '0');
        return false;
      }
      
      site_percent_price = site_percent_price.toFixed(2);
      
      //$('service_free').set('html', '+' + Math.ceil(site_percent_price) + ' service fee');
      var priceString = parseFloat(site_price)
        + ' + '
        + Math.ceil(site_percent_price)
        + ' service fee'
        + ' = '
        + '<span class="total_price">'
        + Math.ceil(parseFloat(site_price) + parseFloat(site_percent_price))
        + '</span>';
        
      $('total_price_percent').set('html', priceString);
    }
    
    price_percent_calculate();
    
    $('price').addEvent('keyup', function() {
      price_percent_calculate();
    });
  });
</script>


<div class="form-outer-title"><?php echo $this->translate('Edit Event'); ?></div>
<div class="form-outer-description"><?php echo nl2br($this->translate('FORM_EDIT_DESCRIPTION')); ?></div>
<?php echo $this->form/*->setAttrib('class', 'global_form_popup')*/->render($this) ?>
<div class="form-outer-notice"><?php echo $this->translate('Fields marked with an asterisk %s are mandatory.', '<span>*</span>'); ?></div>

<script type="text/javascript">
  en4.core.runonce.add(function(){
    cal_starttime_onHideStart();
    cal_endtime_onHideStart();
  });
</script>