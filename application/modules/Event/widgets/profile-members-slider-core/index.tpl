<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: index.tpl 9867 2013-02-12 21:17:02Z jung $
 * @access	   John
 */
?>


<?php
  // add script and style
  $this->headScript()
    ->appendFile($this->layout()->staticBaseUrl . 'application/modules/Event/externals/scripts/slideGallery.js');
  $this->headLink()
    ->appendStylesheet($this->layout()->staticBaseUrl . 'application/modules/Event/externals/styles/slider.css');
?>

<script type="text/javascript">
  window.addEvent('domready', function() {
    var gallery_profile_members_slider = new slideGallery($$("#profile_members_slider"), {
      steps: 1,
      mode: "callback",
      autoplay: false,
      paging: false,
      pagingHolder: ".paging",
      onPlay: function() {
        this.fireEvent("start");
      }
    });
  });
</script>

<a id="event_profile_members_anchor"></a>

<script type="text/javascript">
  function StartCountDown(myDiv, myTargetDate, endTime) {
    var dthen	= new Date(myTargetDate);
    var dnow	= new Date(endTime);
    ddiff		= new Date(dthen-dnow);
    gsecs		= Math.floor(ddiff.valueOf() / 1000);
    CountBack(myDiv, gsecs);
  }
  
  function Calcage(secs, num1, num2) {
    s = ((Math.floor(secs/num1))%num2).toString();
    if (s.length < 2)  {	
      s = "0" + s;
    }
    
    return (s);
  }
  
  function CountBack(myDiv, secs) {
    var DisplayStr;
    var DisplayFormat = "%%D%%day(s) %%H%%h %%M%%min";//"%%H%%h %%M%%min %%S%%sec";
    var DisplayDiv;
    if (secs < 86400) {
      DisplayFormat = "%%H%%h %%M%%min";
      DisplayStr = DisplayFormat.replace(/%%H%%/g, Calcage(secs, 3600, 24));
    } else {
      DisplayStr = DisplayFormat.replace(/%%D%%/g, Calcage(secs, 86400, 4).toString()[1]);
      DisplayStr = DisplayStr.replace(/%%H%%/g, Calcage(secs, 3600, 24));
    }
    
    DisplayStr = DisplayStr.replace(/%%M%%/g, Calcage(secs, 60, 60));
    DisplayStr = DisplayStr.replace(/%%S%%/g,		Calcage(secs, 1, 60));
    
    DisplayDiv = document.getElementById(myDiv);
    
    if (secs > 0) {
      
      if (DisplayDiv != null) {
        DisplayDiv.innerHTML = DisplayStr;
        setTimeout("CountBack('" + myDiv + "'," + (secs - 1) + ");", 990);
      }
    } else {
      
      if (DisplayDiv != null) {
        DisplayDiv.innerHTML = "<b><?php echo $this->translate("Please wait..."); ?></b>";
        
        new Request.HTML({
          'url' : '<?php echo $this->url(array('action' => 'job'), 'event_general', true); ?>',
          'onComplete' : function(responseTree, responseElements, responseHTML, responseJavaScript) {
            if( responseHTML ) {
              $(myDiv).getParent().getParent().getParent().destroy();
              //document.getElementById(myDiv).innerHTML = "<b><?php //echo $this->translate("Expired"); ?></b>";
            }
          }
        }).send();
      }
    }
  }
</script>

