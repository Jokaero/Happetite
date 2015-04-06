/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Store
 * @copyright  Copyright Hire-Experts LLC
 * @license    http://www.hire-experts.com
 * @version    $Id: AdminFieldsController.php 2011-08-19 17:22:12 mirlan $
 * @author     Mirlan
 */

/**
 * @category   Application_Extensions
 * @package    Store
 * @copyright  Copyright Hire-Experts LLC
 * @license    http://www.hire-experts.com
 */


var StoreBasket = new Class({
	Implements: Chain,

	box: 'store-basket-box',
	button: 'store-basket-button',
	productBox: 'store-basket-items',
	counterBoxes: '.store-counters',
  basketCounter: null,
	priceBoxes: '.store-prices',
	tempBox: 'store-basket-temp',
	checkoutBox: 'store-basket-checkout',
	emptyBox: 'store-basket-empty',
  totalPriceBasket: 'store-basket-total-price',

	btSlider: 'store-basket-slider',
	prSlider: 'store-basket-items-slider',

	basketUrl: '',
	cartUrl:'',

	html: '',
	count: 10000,

	init: function ()
  {
		var self = this;
		var $div = new Element('div', {'id': self.box});

		$div.set('html', self.html);
    $div.setStyle('opacity', 0);
		document.body.appendChild($div);

		self.box = $(self.box);
		self.button = $(self.button);
		self.productBox = $(self.productBox);
		self.counterBoxes = $$(self.counterBoxes);
    self.basketCounter = self.button.getElement("div[class='store-counters']");
		self.priceBoxes = $$(self.priceBoxes);
		self.tempBox = $(self.tempBox);
		self.checkoutBox = $(self.checkoutBox);
		self.emptyBox = $(self.emptyBox);
    self.totalPriceBasket = $(self.totalPriceBasket);

		self.initSlider();

		self.button.addEvent('click', function(){
			self.slide();
		});


		setTimeout(function(){ self.checkBasket(); }, 1000);
	},

	initSlider:function(){
		var self = this;

		self.prSlider = new Fx.Slide(self.prSlider, {
			duration: '100',
			offset: {
				'y': '200',
				'x': '200'
			}
		}).slideOut();

    self.btSlider = new Fx.Slide(self.btSlider, {
      mode: 'horizontal',
      duration: '100'
    }).slideOut().chain(function(){
      self.prSlider.element.setStyle('width', '1px');
    });
	},

	slide:function( $do ){
		var self = this;

    if ( $do == 'out' || ( $do != 'in' && self.btSlider.open)) {
			self.prSlider.slideOut().chain(function(){
				self.prSlider.element.setStyle('width', '1px');
				self.btSlider.slideOut().chain(function(){self.executeChains();});
			});
		} else if (  $do == 'in' || ( $do != 'out' && !self.btSlider.open)) {
      self.btSlider.slideIn().chain(function(){
        self.prSlider.element.setStyle('width', '300px');
				self.prSlider.slideIn().chain(function(){self.executeChains();});
			});
		}

		return self;
	},

	executeChains: function(){
		var self = this;
		self["$chain"].each(function($f){
			if ($type($f) == 'function') $f();
		});
		self.clearChain();
    self.checkScroll();
    self.checkBasket();
  },

	product:{
		add: function( $product_id, $rand ){
			var self = store_basket;
      var href = '';
			var $params = {
					'format': 'json',
					'product_id': $product_id,
					'do':'add'
				};

			new Request.JSON({
				'url': self.cartUrl,
				'method': 'post',
				'data': $params,
				'onRequest':function(){
          if ($rand != undefined) {
            $('product_button_'+$product_id+'_'+$rand).setStyle('display', 'none');
            $('product_loader_'+$product_id+'_'+$rand).setStyle('display', 'block');
          } else {
            var button_el = $$('.product_button')[0];
            href = button_el.getAttribute('href');
            button_el.setStyle('background-image', 'url(application/modules/Store/externals/images/loader.gif)');
            button_el.setAttribute('href', 'javascript://');
            button_el.innerHTML = en4.core.language.translate('Loading ...');
          }
				},

				'onSuccess': function( $response ){
					if ( $response.status ){
            self.chain(
              function(){
                if(self.checkoutBox.hasClass('hidden')){
                  self.emptyBox.addClass('hidden');
                  self.checkoutBox.removeClass('hidden');
                }
              },
              function(){ self.tempBox.set('html', $response.html); },
              function(){
                $('basketitem-id-' + $response.item_id).inject(self.checkoutBox, 'before');
                self.counterBoxes.each(function($box){
                  $box.set('text', parseInt($box.get('text')) + 1);
                });
                self.priceBoxes.each(function($box){
                  $box.set('text', $response.totalPrice);
                });

              },
              function(){ self.slide('in'); },
              function(){ self.prSlider.element.scrollTop = self.prSlider.element.scrollHeight; },
              function(){ setTimeout( function(){
                new Fx.Tween('basketitem-id-' + $response.item_id).start('background-color', document.body.getStyle('background-color')); }, '1000');
              }
            ).slide('in');
            
            if ($rand != undefined) {
              $('product_button_'+$product_id+'_'+$rand).setStyle('display', 'block');
              $('product_loader_'+$product_id+'_'+$rand).setStyle('display', 'none');
            } else {
              var button_el = $$('.product_button')[0];
              button_el.setStyle('background-image', 'url(application/modules/Store/externals/images/icons/basket_top_cart_blue.png)');
              button_el.setAttribute('href', href);
              button_el.innerHTML = en4.core.language.translate('STORE_Add to Cart');
            }
					};
				}
			}).post();
		},

		remove: function($product_id, $item_id ){
			var self = store_basket;

			var $params = {
					'format': 'json',
					'product_id': $product_id,
					'item_id': $item_id,
					'do':'remove'
				};

			new Request.JSON({
				'url': self.cartUrl,
				'method': 'post',
				'data': $params,
				'onRequest':function(){
          if ($('remove_loader_'+$product_id+'_'+$item_id)) {
            $('remove_basket_'+$product_id+'_'+$item_id).setStyle('display', 'none');
            $('remove_loader_'+$product_id+'_'+$item_id).setStyle('display', 'block');
          }
          $('basketitem-id-'+$item_id).addClass('remove_loader');
          $('basketitem-id-'+$item_id).getElement('.store-basket-item-remove').setStyle('display', 'none');
				},

				'onSuccess': function( $response ) {
					if ( $response.status ){
						new Fx.Tween('basketitem-id-'+$item_id).start('opacity', 1, 0).chain(
              function(){
							self.counterBoxes.each(function($box) {
                $box.set('text', parseInt($box.get('text')) - 1);
              });

							if ($type(self.counterBoxes[0]) == 'element'){
								if (parseInt(self.basketCounter.get('text')) == 0){
									if(self.emptyBox.hasClass('hidden')){
										self.checkoutBox.addClass('hidden');
										self.emptyBox.removeClass('hidden');
									}
								}
							}

							self.priceBoxes.each(function($box){
                $box.set('text', $response.totalPrice);
              });

              this.element.destroy();
              self.slide('in');
						});

            var $li = $('store-basket-product-' + $item_id);
            if ( $li != undefined ) {
						  new Fx.Tween($li).start('opacity', 1, 0).chain(function(){this.element.destroy();});
              product_manager.setPage()
            }

            var $checkout = $$('.layout_right').getElement('.layout_store_basket_checkout')[0];
            if ($checkout != undefined) {
							self.totalPriceBasket.set('text', $response.totalBasketPrice);
            }
					}
				}
			}).post();
		}
	},

	checkout: function(){
		location.href = this.basketUrl;
	},

  checkScroll: function(){
    var self = this;

    var $h = parseInt(self.productBox.getStyle('height'));

    if ( $h > 400 ){
      self.prSlider.element.setStyle('height', '400px');
    } else {
      self.prSlider.element.setStyle('height', 'auto');
    }
  },

  checkBasket: function(){
    var self = store_basket;

    if ( parseInt(self.basketCounter.get('text')) == 0 && !self.btSlider.open){
      self.box.setStyle('opacity', 0.2);
    } else {
      self.box.setStyle('opacity', 1);
    }
  }

});

var store_basket = new StoreBasket();

en4.core.runonce.add(function(){
	store_basket.init();
});