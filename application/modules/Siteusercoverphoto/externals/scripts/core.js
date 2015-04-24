var Siteusercoverphoto = new Class({
  Implements:[Options],
  options:{
    element:null,
    buttons:'siteusercoverphoto_cover_options',
    photoUrl:'',
    position_url:'',
    position:{
      top:0,
      left:0
    }
  },
  block:null,
  buttons:null,
  element:null,
  changeButton:null,
  saveButton:null,

  initialize:function (options) {
    if (options.block == null) {
      return;
    }
    this.block=options.block;
    this.setOptions(options);
    //    this.block = this.element.getParent();
    this.getCoverPhoto(0, 0);
  },
  attach:function (defaultCover) {
    var self = this;
    if(!$(this.options.buttons)){
      return;
    }
    this.element = self.block.getElement('.cover_photo');
    this.buttons = $(this.options.buttons);
    this.saveButton = this.buttons.getElement('.save-button');
    this.editButton = this.buttons.getElement('.edit-button');
    if(this.saveButton){
      this.saveButton.getElement('.positions-save').addEvent('click', function () {
        self.reposition.save(defaultCover);
      });
      this.saveButton.getElement('.positions-cancel').addEvent('click', function () {
        self.reposition.stop(1);
      });
    }
  },

  get:function (type) {
    if (type == 'block') {
      return this.block;
    }

    return this.element;
  },

  getButton:function (type) {
    if (type == 'save') {
      return this.saveButton;
    }

    return this.editButton;
  },
  getCoverPhoto:function (reposition_enable, defaultCover) {
    var self = this;
    new Request.HTML({
      'method':'get',
      'url':self.options.photoUrl,
      'data':{
        'format':'html',
				 'subject': en4.core.subject.guid
      },
      'onComplete':function (responseTree, responseElements, responseHTML, responseJavaScript) {
        if ( responseHTML.length > 0) {
          self.block.set('html', responseHTML);
          Smoothbox.bind(self.block);
          self.attach(defaultCover);
		  
		  var src = self.block.getElement('.cover_photo').get('src');
		  self.block.setStyle('background-image', 'url(' + src + ')');
		  
		  jQuery('.page_main_photo_left, .page_main_photo_right').blurjs({
			source: '#siteuser_cover_photo',
			radius: 25,
			//cache: true,
			//offset: { x: 15, y: -12 },
		  });
		  
          if(reposition_enable){
            Smoothbox.close();
            self.options.position={
              top: 0,
              left : 0
            };
            setTimeout(function () {
              self.reposition.start(defaultCover)
            }, '2000');
          }
        }
      }
    }).send();
  },
  reposition:{
    drag:null,
    active:false,
    start:function (defaultCover) {
      if (this.active) {
        return;
      }

      var self = document.seaoCoverPhoto;
      var cover = self.get();
      this.active = true;
      //self.getButton().fireEvent('click');
			if($$('.seaocore_profile_cover_head_section_inner'))
			$$('.seaocore_profile_cover_head_section_inner').addClass('dnone');
// 			if($$('.siteuser_main_thumb_photo'))
// 			$$('.siteuser_main_thumb_photo').addClass('dnone');
// 			if($$('.seaocore_profile_main_photo_options'))
// 			$$('.seaocore_profile_main_photo_options').addClass('dnone');
      self.getButton().addClass('dnone');
      self.buttons.addClass('siteuser_cover_options_btm');
      self.getButton('save').removeClass('dnone');
      if(self.options.columnHeight && self.block.getElement('.cover_photo_wap')){
        self.block.setStyle('height',self.options.columnHeight+'px');
      }
      self.block.getElement('.cover_tip_wrap').removeClass('dnone');
      cover.addClass('draggable');
      var cont = cover.getParent();
      var verticalLimit = cover.offsetHeight.toInt() - cont.offsetHeight.toInt();
      var horizontalLimit = cover.offsetWidth.toInt() - cont.offsetWidth.toInt();
      var limit = {
        x:[0, 0], 
        y:[0, 0]
      };

      if (verticalLimit > 0) {
        limit.y = [-verticalLimit, 0]
      }

      if (horizontalLimit > 0) {
        limit.x = [-horizontalLimit , 0]
      }
 
      this.drag = new Drag(cover, {
        limit:limit,
        onComplete:function (el) {
          self.options.position.top = el.getStyle('top').toInt();
          self.options.position.left = el.getStyle('left').toInt();
        }
      }).detach();

      this.drag.attach(defaultCover);
    },
    stop:function(reload){
      var self =document.seaoCoverPhoto;
      self.reposition.drag.detach();
      self.getButton('save').addClass('dnone');
      self.block.getElement('.cover_tip_wrap').addClass('dnone');
      self.buttons.removeClass('siteuser_cover_options_btm');
      self.getButton().removeClass('dnone');
			if($$('.seaocore_profile_cover_head_section_inner'))
			$$('.seaocore_profile_cover_head_section_inner').removeClass('dnone');
// 			if($$('.siteuser_main_thumb_photo'))
// 			$$('.siteuser_main_thumb_photo').removeClass('dnone');
// 			if($$('.seaocore_profile_main_photo_options'))
// 			$$('.seaocore_profile_main_photo_options').removeClass('dnone');
      self.get().removeClass('draggable');
      self.reposition.drag = null;
      self.reposition.active = false;
      if(reload)
        self.getCoverPhoto(0, 0);
    },
    save:function (defaultCover) {
      if (!this.active) {
        return;
      }
      var self = document.seaoCoverPhoto;
      var current = this;
      new Request.JSON({
        method:'get',
        url:self.options.positionUrl,
        data:{
          'format':'json', 
          'position':self.options.position,
					'defaultCover':defaultCover
        },
        onSuccess:function (response) {
					if($$('.seaocore_profile_cover_head_section_inner'))
					$$('.seaocore_profile_cover_head_section_inner').removeClass('dnone');
// 					if($$('.siteuser_main_thumb_photo'))
// 					$$('.siteuser_main_thumb_photo').removeClass('dnone');
// 					if($$('.seaocore_profile_main_photo_options'))
// 					$$('.seaocore_profile_main_photo_options').removeClass('dnone');
          current.stop();
		  
		  // Main element
		  self.block.setStyle('background-image', 'url(' + self.element.get('src') + ')');
		  jQuery('.page_main_photo_left, .page_main_photo_right').blurjs({
			source: '#siteuser_cover_photo',
			radius: 25,
			//cache: true,
			//offset: { x: 15, y: -12 },
		  });
        }
      }).send();
    },
	
	blur: function () {
	  alert('blur');
	}
  }
});


var Siteusermainphoto = new Class({
  Implements:[Options],
  options:{
    element:null,
    buttons:'siteusercoverphoto_main_options',
    photoUrl:'',
    position_url:'',
		showContent:{},
    position:{
      top:0,
      left:0
    }
  },
  block:null,
  buttons:null,
  element:null,
  changeButton:null,
  saveButton:null,

  initialize:function (options) {
    if (options.block == null) {
      return;
    }
    this.block=options.block;
    this.setOptions(options);
    //    this.block = this.element.getParent();
    this.getMainPhoto();
  },
  attach:function () {
    var self = this;
    if(!$(this.options.buttons)){
      return;
    }
    this.element = self.block.getElement('.cover_photo');
  },

  getMainPhoto:function () {
    var self = this;
    new Request.HTML({
      method : 'get',
      url:self.options.photoUrl,
      data:{
        'format':'html',
				 'subject': en4.core.subject.guid,
				 'showContent':self.options.showContent
      },
      onComplete:function (responseTree, responseElements, responseHTML, responseJavaScript) {
        if ( responseHTML.length > 0) {
          self.block.set('html', responseHTML);
// 					if(window.parent.document.getElementById('profile_photo'))
// 					window.parent.document.getElementById('profile_photo').innerHTML = '<img src='+responseHTML.src+'>';
          Smoothbox.bind(self.block);
          self.attach();
					en4.core.runonce.trigger();
					Smoothbox.close();
        }
      }
    }).send();
  }
});