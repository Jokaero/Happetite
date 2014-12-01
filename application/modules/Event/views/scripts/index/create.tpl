<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: create.tpl 9987 2013-03-20 00:58:10Z john $
 * @author     Sami
 */
?>

<?php if( $this->parent_type == 'group' ) { ?>
  <h2>
    <?php echo $this->group->__toString() ?>
    <?php echo '&#187; '.$this->translate('Events');?>
  </h2>
<?php } ?>

<?php echo $this->form->render() ?>

<script type="text/javascript">
  //var cal_starttime_onHideStart = function(){
  //  // check end date and make it the same date if it's too
  //  cal_endtime.calendars[0].start = new Date( $('starttime-date').value );
  //  // redraw calendar
  //  cal_endtime.navigate(cal_endtime.calendars[0], 'm', 1);
  //  cal_endtime.navigate(cal_endtime.calendars[0], 'm', -1);
  //}
  //var cal_endtime_onHideStart = function(){
  //  // check start date and make it the same date if it's too
  //  cal_starttime.calendars[0].end = new Date( $('endtime-date').value );
  //  // redraw calendar
  //  cal_starttime.navigate(cal_starttime.calendars[0], 'm', 1);
  //  cal_starttime.navigate(cal_starttime.calendars[0], 'm', -1);
  //}
  
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
      
      $('service_free').set('html', '+' + site_percent_price.toFixed(2) + ' service fee');
      $('total_price_percent').set('html', parseFloat(site_price) + parseFloat(site_percent_price));
    }
    
    price_percent_calculate();
    
    $('price').addEvent('keyup', function() {
      price_percent_calculate();
    });
  });
</script>


<script type="text/javascript">
  $$('.core_main_event').getParent().addClass('active');
</script>
