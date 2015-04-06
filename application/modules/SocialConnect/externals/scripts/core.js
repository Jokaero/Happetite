function sopopup(pageURL){
	var w = 800;
	var h = 500;
	var title ="socialconnectwindow";
	var left = (screen.width/2)-(w/2);
	var top = (screen.height/2)-(h/2);
	var newwindow =  window.open (pageURL, title, 'toolbar=no,location=no,directories=no,status=no,menubar=no, scrollbars=yes,resizable=yes,copyhistory=no,width='+w+',height='+h+',top='+top+',left='+left);
		if (window.focus) {newwindow.focus();}
	return newwindow;
};

var M2b = M2b||{};
M2b.SocialConnect = {
   popupCenter:
	  function (pageURL, title,w,h){
		var left = (screen.width/2)-(w/2);
		var top = (screen.height/2)-(h/2);

		var newwindow =  window.open (pageURL, title, 'toolbar=no,location=no,directories=no,status=no,menubar=no, scrollbars=no,resizable=no,copyhistory=no,width='+w+',height='+h+',top='+top+',left='+left);
		if (window.focus) {newwindow.focus();}
	   },
   signon: 
	   function (url){
		   M2b.SocialConnect.popupCenter(url, 'socialconnectwindow', 800, 500);
		   return false;
	   }
};