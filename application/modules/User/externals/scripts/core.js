
/* $Id: core.js 9984 2013-03-20 00:00:04Z john $ */



(function() { // START NAMESPACE
var $ = 'id' in document ? document.id : window.$;



en4.user = {

  viewer : {
    type : false,
    id : false
  },

  attachEmailTaken : function(element, callback)
  {
    var bind = this;
    element.addEvent('blur', function(){
      bind.checkEmailTaken(element.value, callback);
    });

    /*
    var lastElementValue = element.value;
    (function(){
      if( element.value != lastElementValue )
      {

        lastElementValue = element.value;
      }
    }).periodical(500, this);
    */
  },

  attachUsernameTaken : function(element, callback)
  {
    var bind = this;
    element.addEvent('blur', function(){
      bind.checkUsernameTaken(element.value, callback);
    });
    
    /*
    var lastElementValue = element.value;
    (function(){
      if( element.value != lastElementValue )
      {
        bind.checkUsernameTaken(element.value, callback);
        lastElementValue = element.value;
      }
    }).periodical(500, this);
    */
  },

  checkEmailTaken : function(email, callback)
  {
    en4.core.request.send(new Request.JSON({
      url : en4.core.baseUrl + 'user/signup/taken',
      data : {
        format : 'json',
        email : email
      },
      onSuccess : function(responseObject)
      {
        if( $type(responseObject.taken) ){
          callback(responseObject.taken);
        }
      }
    }));
    
    return this;
  },

  checkUsernameTaken : function(username)
  {
    en4.core.request.send(new Request.JSON({
      url : en4.core.baseUrl + 'user/signup/taken',
      data : {
        format : 'json',
        username : username
      },
      onSuccess : function(responseObject)
      {
        if( $type(responseObject.taken) ){
          callback(responseObject.taken);
        }
      }
    }));

    return this;
  },

  clearStatus : function() {
    var request = new Request.JSON({
      url : en4.core.baseUrl + 'user/edit/clear-status',
      method : 'post',
      data : {
        format : 'json'
      }
    });
    request.send();
    if( $('user_profile_status_container') ) {
      $('user_profile_status_container').empty();
    }
    return request;
  },
  
  buildFieldPrivacySelector : function(elements) {
    var idEx = {};
    
    // Clear when body click, if not inside selector
    document.addEvent('click', function(event) {
      if( event.target.hasClass('field-privacy-selector') ) {
        return;
      } else if( event.target.getParent('.field-privacy-selector') ) {
        return;
      } else {
        $$('.field-privacy-selector').removeClass('active');
      }
    });
    
    // Register selectors
    elements.each(function(el) {
      if( el.get('tag') == 'span' ) {
        return;
      }
      var fuid = el.get('id');
      var tmp;
      if( (tmp = fuid.match(/^\d+_\d+_\d+/)) ) {
        fuid = tmp[0];
      }
      var id = el.get('data-field-id');
      if( id in idEx ) {
        return;
      }
      idEx[id] = true;
      var wrapperEl = el.getParent('.form-wrapper');
      var privacyValue = el.get('data-privacy');
      
      var selector = new Element('div', {
        'class' : 'field-privacy-selector',
        'data-privacy' : privacyValue || 'everyone',
        'html' : '\
                  <span class="icon"></span>\n\
                  <span class="caret"></span>\n\
                  <ul>\n\
                    <li data-value="everyone" class="field-privacy-option-everyone"><span class="icon"></span><span class="text">' 
                      + en4.core.language.translate('Everyone') + '</span></li>\n\
                    <li data-value="registered" class="field-privacy-option-registered"><span class="icon"></span><span class="text">' 
                      + en4.core.language.translate('All Members') + '</span></li>\n\
                    <li data-value="friends" class="field-privacy-option-friends"><span class="icon"></span><span class="text">' 
                      + en4.core.language.translate('Friends') + '</span></li>\n\
                    <li data-value="self" class="field-privacy-option-self"><span class="icon"></span><span class="text">' 
                      + en4.core.language.translate('Only Me') + '</span></li>\n\
                  </ul>\n\
                  <input type="hidden" name="privacy[' + fuid + ']" />'
      });
      selector.inject(wrapperEl);
      selector.addEvent('click', function(event) {
        var prevState = selector.hasClass('active');
        $$('.field-privacy-selector').removeClass('active');
        if( !prevState ) {
          selector.addClass('active');
        }
      });
      selector.getElements('li').addEvent('click', function(event) {
        var el = event.target;
        if( el.get('tag') != 'li' ) {
          el = el.getParent();
        }
        var value = el.get('data-value');
        selector.getElement('input').set('value', value);
        selector.getElement('.active').removeClass('active');
        el.addClass('active');
        selector.set('data-privacy', value);
      })
      selector.getElement('*[data-value="' + (privacyValue || 'everyone') + '"]').addClass('active');
      selector.getElement('input').set('value', privacyValue || 'everyone');
    });
  }
  
};

en4.user.friends = {

  refreshLists : function(){
    
  },
  
  addToList : function(list_id, user_id){
    var request = new Request.JSON({
      url : en4.core.baseUrl + 'user/friends/list-add',
      data : {
        format : 'json',
        friend_id : user_id,
        list_id : list_id
      }
    });
    request.send();
    return request;

    /*
    $('profile_friends_lists_menu_' + user_id).style.display = 'none';

    var bind = this;
    en4.core.request.send(new Request.JSON({
      url : en4.core.baseUrl + 'user/friends/list-add',
      data : {
        format : 'json',
        friend_id : user_id,
        list_id : list_id
      }
    }), {
      'element' : $('user_friend_' + user_id)
    });

    return this;
    */
  },

  removeFromList : function(list_id, user_id){
    var request = new Request.JSON({
      url : en4.core.baseUrl + 'user/friends/list-remove',
      data : {
        format : 'json',
        friend_id : user_id,
        list_id : list_id
      }
    });
    request.send();
    return request;
    /*
    var bind = this;
    en4.core.request.send(new Request.JSON({
      url : en4.core.baseUrl + 'user/friends/list-remove',
      data : {
        format : 'json',
        friend_id : user_id,
        list_id : list_id
      }
    }), {
      'element' : $('user_friend_' + user_id)
    });

    return this;
    */
  },

  createList : function(title, user_id){
    var request = new Request.JSON({
      url : en4.core.baseUrl + 'user/friends/list-create',
      data : {
        format : 'json',
        friend_id : user_id,
        title : title
      }
    });
    request.send();
    return request;

    /*
    $('profile_friends_lists_menu_' + user_id).style.display = 'none';
    var bind = this;
    en4.core.request.send(new Request.JSON({
      url : en4.core.baseUrl + 'user/friends/list-create',
      data : {
        format : 'json',
        friend_id : user_id,
        list_title : title
      }
    }), {
      'element' : $('user_friend_' + user_id)
    });

    return this;
    */
  },

  deleteList : function(list_id){

    var bind = this;
    en4.core.request.send(new Request.JSON({
      url : en4.core.baseUrl + 'user/friends/list-delete',
      data : {
        format : 'json',
        user_id : en4.user.viewer.id,
        list_id : list_id
      }
    }));

    return this;
  },


  showMenu : function(user_id){
    $('profile_friends_lists_menu_' + user_id).style.visibility = 'visible';
    $('friends_lists_menu_input_' + user_id).focus();
    $('friends_lists_menu_input_' + user_id).select();
  },

  hideMenu : function(user_id){
    $('profile_friends_lists_menu_' + user_id).style.visibility = 'hidden';
  },

  clearAddList : function(user_id){
    $('friends_lists_menu_input_' + user_id).value = "";
  }

};



})(); // END NAMESPACE
