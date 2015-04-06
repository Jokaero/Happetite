<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions 
 * @package    Seaocore
 * @copyright  Copyright 2009-2010 BigStep Technologies Pvt. Ltd.
 * @license    http://www.socialengineaddons.com/license/
 * @version    $Id: index.tpl 2010-11-18 9:40:21Z SocialEngineAddOns $
 * @author     SocialEngineAddOns
 */
?>

<?php if($this->locationSpecific): ?>
    <div>
        <a class="location_arrow_wrap" href="javascript:void(0);"><?php echo $this->locationValueTitle;?><b class="location_arrow"></b></a>
        <ul id="locationValues">
            <?php foreach($this->locationsArray as $key => $locationElement): ?>
                <?php if(!empty($key) && $key == $this->locationValue) continue; ?>
                <li>
                    <a href="javascript:void(0);" onclick="changeSpecificLocation('<?php echo $key;?>')"><?php echo $locationElement; ?></a>
                </li>
            <?php endforeach; ?>
        </ul>
    </div>

    <script type="text/javascript">
        //$('locationValues').toggle();
        $$('.location_arrow_wrap').addEvent('click', function() {
            $('locationValues').toggle();
        });        
        
        $$('.location_arrow_wrap').addEvent('blur', function() {
            $('locationValues').style.display = 'none';
        });
        
        function changeSpecificLocation(specificLocation) {
            
            var request = new Request.JSON({
                url: '<?php echo $this->url(array('module' => 'seaocore', 'controller' => 'location', 'action' => 'set-specific-location'), "default"); ?>',
                method: 'post',
                data: {
                    format: 'json',
                    specificLocation: specificLocation
                },
                //responseTree, responseElements, responseHTML, responseJavaScript
                onSuccess: function(responseJSON) { 
                    window.location.reload();
                }
            });
            request.send();            
        }
    </script>    
<?php else:  ?>
    <?php $this->headLink()->prependStylesheet($this->layout()->staticBaseUrl . 'application/modules/Seaocore/externals/styles/styles.css'); ?>
    <?php $apiKey = Engine_Api::_()->seaocore()->getGoogleMapApiKey();
    $this->headScript()->appendFile("https://maps.googleapis.com/maps/api/js?libraries=places&sensor=true&key=$apiKey");?>

    <div id="region" class="seaocore_change_location">
        <?php if($this->showSeperateLink): ?>
            <?php if (isset($this->getMyLocationDetailsCookie['location']) && !empty($this->getMyLocationDetailsCookie['location'])): ?>
                <span><?php echo $this->getMyLocationDetailsCookie['location']; ?></span>
            <?php else: ?>
                <span><?php echo $this->translate("World"); ?></span>
            <?php endif; ?>
               &nbsp;<a href='javascript:void(0)' onclick='changeMyLocation()' class="change_location_link f_small">[<?php echo $this->translate("change my location"); ?>]</a>    
        <?php else: ?>
            <a href='javascript:void(0)' onclick='changeMyLocation()'>
                <?php if (isset($this->getMyLocationDetailsCookie['location']) && !empty($this->getMyLocationDetailsCookie['location'])): ?>
                    <span><?php echo $this->getMyLocationDetailsCookie['location']; ?></span>
                <?php else: ?>
                    <span><?php echo $this->translate("World"); ?></span>
                <?php endif; ?>
                <i></i>
            </a>
        <?php endif; ?>
    </div>

    <div style="display:none;" id="changeMyLocation">
      <div class="change_location_form">
          <form method="post" action="" class="global_form" enctype="application/x-www-form-urlencoded" id="seaocore_change_my_location">
              <div>
                  <div>
                      <h3><?php echo $this->translate("Change My Location"); ?></h3>
                      <p class="form-description"><?php echo $this->translate("Enter your location in the auto-suggest box. (e.g., CA or 94131, San Francisco)"); ?></p>
                      <div class="form-elements">
                          <div class="form-wrapper" id="changeMyLocationValue-wrapper">
                            <div class="form-label" id="changeMyLocationValue-label"><label class="required" for="changeMyLocationValue"><?php echo $this->translate("Location: "); ?></label>

                              </div>
                              <div class="form-element" id="changeMyLocationValue-element">
                                  <input type="text" id="changeMyLocationValue" name="changeMyLocationValue" autocomplete="off" onkeypress="unsetLatLng();" value="<?php if (isset($this->getMyLocationDetailsCookie['location']) && !empty($this->getMyLocationDetailsCookie['location'])) { echo $this->getMyLocationDetailsCookie['location']; } ?>">
                                  <p id="changeMyLocationValueError" style="display:none; color:red;"><?php echo $this->translate("Please enter the valid location!"); ?></p> 
                                  <p id="changeMyLocationValueErrorGeo" style="display:none; color:red;"><?php echo $this->translate("Oops! Something went wrong. Please try again later."); ?></p> 
                              </div>
                          </div>
                          
                          <?php if(Engine_Api::_()->hasModuleBootstrap('sitemember') && $this->showLocationPrivacy):?>
                            <div id="location-privacy-wrapper" class="form-wrapper">
                                <div id="location-privacy-label" class="form-label"><label for="location_privacy" class="optional"><?php echo $this->translate("Privacy:");?></label></div>
                                  <div id="location-privacy-element" class="form-element">
                                      <select name="location_privacy" id="location_privacy" onchange="return getSelectedOption(this.selectedIndex)">
                                          <?php foreach($this->privacyOptions as $key => $value):?>

                                             <?php if($key == $this->prevPrivacy):?>
                                              <?php $selected = 'selected="selected"';?>
                                              <?php else:?>
                                              <?php $selected = '';?>
                                              <?php endif;?>
                                             <option value='<?php echo $key;?>' <?php echo $selected;?> ><?php echo $value;?></option>
                                          <?php endforeach;?>
                                      </select>
                                  </div>
                            </div>
                          <?php endif;?>
                          
                          <?php //if(!Engine_Api::_()->hasModuleBootstrap('sitemember')):?>
                          
                            <div class="form-wrapper" id="removeLocation-wrapper">
                              <div id="removeLocation-label" class="form-label">&nbsp;</div>
                              <div class="form-element" id="removeLocation-element">
                                  <input type="hidden" value="" name="removeLocation">
                                  <input type="checkbox" id="removeLocation" name="removeLocation">
                                      <?php echo $this->translate("Remove my location.");?>
                              </div>
                            </div>
                           <?php //endif;?>
                           
                          <input type="hidden" name="latitude" value="" id="latitude" />

                          <input type="hidden" name="longitude" value="" id="longitude" />

                          <div class="form-wrapper" id="buttons-wrapper" style="display: block;margin-bottom: 0;">
                              <div class="form-label" id="buttons-label">&nbsp;</div>
                              <div class="form-element" id="buttons-element">
                                  <button type="submit" id="execute" name="execute" onclick="changeLocationSubmitForm($('seaocore_change_my_location'));
          return false;"><?php echo $this->translate("Change Location"); ?></button>
                                  
                                  <?php echo $this->translate('or');?> <a href="javascript:void(0)" onclick="parent.Smoothbox.close();"><?php echo $this->translate("cancel"); ?></a>
                              </div>
                          </div>
                          
                      </div>
                  </div>
              </div>
          </form>
        </div>
    </div>

    <script type="text/javascript">
        var selectedIndex = 0;
        function unsetLatLng() {
            $('latitude').value = 0;
            $('longitude').value = 0;
        }
        
        function getSelectedOption(selectedIndexValue) {
           selectedIndex = selectedIndexValue;
        }

        function changeMyLocation() {  
            Smoothbox.open('<div id="changeMyLocationHTML">' + $('changeMyLocation').innerHTML + '</div>');
            var autocomplete = new google.maps.places.Autocomplete($('changeMyLocationHTML').getElementById('changeMyLocationValue'));
            google.maps.event.addListener(autocomplete, 'place_changed', function() {
                var place = autocomplete.getPlace();
                if (!place.geometry) {
                    return;
                }

                $('latitude').value = place.geometry.location.lat();
                $('longitude').value = place.geometry.location.lng();
            });
        } 
        var location_privacy = 'everyone';
        function changeLocationSubmitForm(formObject) { 
        
            var previousLocationValue = '<?php if (isset($this->getMyLocationDetailsCookie['location']) && !empty($this->getMyLocationDetailsCookie['location'])) { echo $this->getMyLocationDetailsCookie['location']; } ?>'
            var newLocationValue = $('changeMyLocationHTML').getElementById('changeMyLocationValue').value;
            var latitude = $('changeMyLocation').getElementById('latitude').value;
            var longitude = $('changeMyLocation').getElementById('longitude').value;
            var updateCookies = 1;
            if($('changeMyLocationHTML').getElementById('removeLocation')) {
                var removeLocationValue = $('changeMyLocationHTML').getElementById('removeLocation').checked;
                 
                if(removeLocationValue && '<?php echo $this->updateUserLocation;?>') { 
                    Cookie.write('seaocore_myLocationDetails', '', {duration: -1, path:en4.core.baseUrl});
                    newLocationValue='';
                    latitude=0;
                    longitude=0;
                    updateCookies=0;
                    
                    //parent.Smoothbox.close();
                    //window.location.reload();
                    //return false;
                } else if(removeLocationValue) {
                  Cookie.write('seaocore_myLocationDetails', '', {duration: -1, path:en4.core.baseUrl});
                  parent.Smoothbox.close();
                  window.location.reload();
                  return false;
                }
            }
            
            if(formObject.getElementById('location_privacy') ) {
              location_privacy = formObject.getElementById('location_privacy').options[selectedIndex].value;
            }
            
            

            if(previousLocationValue == newLocationValue && (newLocationValue != '' && newLocationValue != null)) {
                //parent.Smoothbox.close();
                //return false;
            }
            
            $('changeMyLocationHTML').innerHTML = '<center><div class="seaocore_content_loader"></div></center>';
            
            var request = new Request.JSON({
                url: '<?php echo $this->url(array('module' => 'seaocore', 'controller' => 'location', 'action' => 'change-my-location'), "default"); ?>',
                method: 'post',
                data: {
                    format: 'json',
                    changeMyLocationValue: newLocationValue,
                    latitude: latitude,
                    longitude: longitude,
                    location_privacy: location_privacy,
                    updateUserLocation: '<?php echo $this->updateUserLocation;?>'
                },
                //responseTree, responseElements, responseHTML, responseJavaScript
                onSuccess: function(responseJSON) { 
                    if(responseJSON.error == 2) {
                        $('changeMyLocationHTML').getElementById('changeMyLocationValueErrorGeo').style.display = 'block';
                    }   
                    else if(responseJSON.error == 1) {
                        $('changeMyLocationHTML').getElementById('changeMyLocationValueError').style.display = 'block';
                    }    
                    else {

                        var myLocationDetails = JSON.parse(Cookie.read('seaocore_myLocationDetails'));

                        if(myLocationDetails == '') {
                            myLocationDetails = {};
                        }

                       myLocationDetails = $merge(myLocationDetails,{
                            latitude : responseJSON.latitude,
                            longitude: responseJSON.longitude,
                            location:responseJSON.location
                       });

                       if(typeof(myLocationDetails.locationmiles) == 'undefined' || myLocationDetails.locationmiles == null) {
                       myLocationDetails = $merge(myLocationDetails,{
                            locationmiles : <?php echo Engine_Api::_()->getApi('settings', 'core')->getSetting('seaocore.locationdefaultmiles', 1000); ?>
                       });
                       }                  

                        myLocationDetails = $merge(myLocationDetails, {changeLocationWidget:1});

                        if(updateCookies) {
                            en4.seaocore.locationBased.setLocationCookies(myLocationDetails);
                        }
                        parent.Smoothbox.close();
                        window.location.reload();
                    }
                }
            });
            request.send();
        }
        <?php if($this->detactLocation): ?>
            var params = {
							'detactLocation': <?php echo $this->detactLocation; ?>,
							'reloadPage': 1,
               'noSendReq': 1,
              updateUserLocation: '<?php echo $this->updateUserLocation;?>'
					};
					en4.seaocore.locationBased.startReq(params);
        <?php endif;?>
    </script>  
<?php endif; ?>


<style type="text/css">
	.global_form div.form-element {
    max-width: 340px;
	}    
</style>