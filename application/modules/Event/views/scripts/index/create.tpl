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

<div class="form-outer-title"><?php echo $this->translate('Create Event'); ?></div>
<div class="form-outer-description"><?php echo nl2br($this->translate('FORM_CREATE_DESCRIPTION')); ?></div>
<?php echo $this->form->render() ?>
<div class="form-outer-notice"><?php echo $this->translate('Fields marked with an asterisk %s are mandatory', '<span>*</span>'); ?></div>

<script type="text/javascript">
  
  window.addEvent('domready', function() {
    var site_percent = <?php echo Engine_Api::_()->getApi('settings', 'core')->getSetting('event_percent', 10) ?>;
    var site_percent_price = 0;
    
    price_percent_calculate = function() {
      var site_price = parseFloat($('price').value);
      site_percent_price = site_price * (site_percent / 100);
      var currency = $('currency').value;
      if (currency == undefined || currency.length == 0){
          currency = 'USD';
      }
        console.log(currency);

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
        + '<span class="total_price"><span class="currency_price">'
        + currency + '</span> '
        + Math.ceil(parseFloat(site_price) + parseFloat(site_percent_price))
        + '</span>';
        
      $('total_price_percent').set('html', priceString);
    }
    
    price_percent_calculate();
    
    $('price').addEvent('keyup', function() {
      price_percent_calculate();
    });

      $('currency').addEvent('change', function() {
      price_percent_calculate();
    });
  });
</script>


<script type="text/javascript">
  $$('.core_main_event').getParent().addClass('active');
</script>
