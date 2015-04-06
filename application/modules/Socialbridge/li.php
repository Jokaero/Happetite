<?php
if (!function_exists('curPageURL'))
{
	function curPageURL()
	{
		$pageURL = 'http';
		if (isset($_SERVER["HTTPS"]) && $_SERVER["HTTPS"] == "on")
		{
			$pageURL .= "s";
		}
		$pageURL .= "://";
		if ($_SERVER["SERVER_PORT"] != "80")
		{
			$pageURL .= $_SERVER["SERVER_NAME"] . ":" . $_SERVER["SERVER_PORT"] . $_SERVER["REQUEST_URI"];
		}
		else
		{
			$pageURL .= $_SERVER["SERVER_NAME"] . $_SERVER["REQUEST_URI"];
		}
		return $pageURL;
	}

}
@session_start();
@ob_start();

// prevent 304 redirect permanently
header('HTTP/1.1 200 OK');

try
{
    $is_from_socialpublisher = 0;
    if (!empty($_GET['is_from_socialpublisher'])) {
        $is_from_socialpublisher = 1;
    }

  $obj = Engine_Api::_()->socialbridge()->getInstance('linkedin');
  $_REQUEST[$obj->getGetType()] = (isset($_REQUEST[$obj->getGetType()])) ? $_REQUEST[$obj->getGetType()] : 'initiate';
  switch($_REQUEST[$obj->getGetType()])
  {
    case 'initiate':
	  $_GET['oauth_callback'] = curPageURL().'&' . $obj->getGetType() . '=initiate&' . $obj->getGetResponse() . '=1';
	  $obj = Engine_Api::_()->socialbridge()->getInstance('linkedin');
      $_GET[$obj->getGetResponse()] = (isset($_GET[$obj->getGetResponse()])) ? $_GET[$obj->getGetResponse()] : '';

      if(!$_GET[$obj->getGetResponse()])
      {
      	$params = array();
      	if($_GET['scope'])
		{
			$params['url_request'] = 'https://api.linkedin.com/uas/oauth/requestToken?scope='.$_GET['scope'];
		}
		$response = $obj->retrieveTokenRequest($params);
        if($response['success'] === TRUE)
        {
          // split up the response and stick the LinkedIn portion in the user session
          $_SESSION['oauth']['linkedin']['request'] = $response['linkedin'];

          // redirect the user to the LinkedIn authentication/authorisation page to initiate validation.
          header('Location: ' . $obj->getUrlAuth() . $_SESSION['oauth']['linkedin']['request']['oauth_token']);

        }
        else
        {
		    if ( isset($response['linkedin']['oauth_problem']) && $response['linkedin']['oauth_problem'] == 'timestamp_refused')
			  {
				  $tmp = (int)$response['linkedin']['oauth_acceptable_timestamps'];
				  $_SESSION['delta_time_stamp'] = $tmp-time();

				  $response = $obj->retrieveTokenRequest($params);
				  if($response['success'] === TRUE) {
				  // split up the response and stick the LinkedIn portion in the user session
				  $_SESSION['oauth']['linkedin']['request'] = $response['linkedin'];

				  // redirect the user to the LinkedIn authentication/authorisation page to initiate validation.
				  header('Location: ' . $obj->getUrlAuth() . $_SESSION['oauth']['linkedin']['request']['oauth_token']);
				}

			  }
		      // bad token request
        }
      }
      else
      {
      	if(isset($_GET['oauth_token']) && isset($_GET['oauth_verifier']))
		{
	        // LinkedIn has sent a response, user has granted permission, take the temp access token, the user's secret and the verifier to request the user's real secret key
			$response = $obj->retrieveTokenAccess($_GET['oauth_token'], $_SESSION['oauth']['linkedin']['request']['oauth_token_secret'], $_GET['oauth_verifier']);
	        if($response['success'] === TRUE)
	        {
	          // the request went through without an error, gather user's 'access' tokens
	          $_SESSION['oauth']['linkedin']['access'] = $response['linkedin'];
	          // set the user as authorized for future quick reference
	          $_SESSION['oauth']['linkedin']['authorized'] = TRUE;

	          // now we have the session 'access' tokens, request the linkedin id for the user and store that with keys in SESSION
			  $response = $obj->getProfile();
	          if($response['info']['http_code'] == 200)
	          {
	            // data request using user's access keys successful, store data and send user back to demo page

	            /**
	             * Use SimpleXMLElement to convert the XML response from the previous
	             * LinkedIn->profile() call into an object and store the LinkedIn
	             * user ID for future reference.
	             *
	             * http://php.net/manual/en/book.simplexml.php
	             *
	             * NOTE: we need to cast the LinkedIn ID explicitly to a string as
	             * there are known issues with SimpleXMLElement treating the XML
	             * object as a resource, which breaks the SESSION's ability to store
	             * the data properly.
	             */
	            if(class_exists('SimpleXMLElement')) {
	              $response['linkedin'] = new SimpleXMLElement($response['linkedin']);
	              $_SESSION['oauth']['linkedin']['id'] = (string)$response['linkedin']->id;
	            } else {
	              echo "Missing SimpleXMLElement class...  please install this extension or use a different method to process the XML response.";
	            }
					$datatopost = array('_q'=>1);
					$index = 0;
					$datatopost['contact'] = "mycontact";
					$datatopost['service'] = "linkedin";
					$_SESSION['socialbridge_session']['linkedin']['access_token'] = $_SESSION['oauth']['linkedin']['access']['oauth_token'];
					$_SESSION['socialbridge_session']['linkedin']['secret_token'] = $_SESSION['oauth']['linkedin']['access']['oauth_token_secret'];
					$obj->saveToken();
					$url = $_GET['callbackUrl'];
					$params =http_build_query($datatopost)."&oauth_tok3n=".$_SESSION['oauth']['linkedin']['access']['oauth_token']."&oauth_token_secret=".$_SESSION['oauth']['linkedin']['access']['oauth_token_secret'];
					?>
					<?php if (!$is_from_socialpublisher): ?>
    					<form method="post" id="connect_form" action="<?php echo $url."?".$params?>">
    					<input type="hidden" name="task" value="get_contacts" />
    					</form>
    					<script> document.getElementById('connect_form').submit(); </script>
    					<script>self.close();</script>
                    <?php endif; ?>
    				<?php
    	                echo "<script>opener.parent.frames['TB_iframeContent'].document.location.reload();</script>";
    	                echo "<script>self.close();</script>";
    	            ?>
				<?php
	          } else {
	            // bad data returned from LinkedIn get call
	            echo "Bad get data returned:\n\nRESPONSE:\n\n" . print_r($response, TRUE) . "\n\nLINKEDIN OBJ:\n\n" . print_r($obj, TRUE);
	          }
	        }
			else
			{
	          // bad token access
	          echo "Bad access token call:\n\nRESPONSE:\n\n" . print_r($response, TRUE) . "\n\nLINKEDIN OBJ:\n\n" . print_r($obj, TRUE);
	        }
	      }
		  else
		  {
		  	$url = $_GET['callbackUrl'];
		  ?>
			 	<form method="post" id="connect_form" action="<?php echo $url?>">
					<input type="hidden" name="task" value="get_contacts" />
				</form>
				<script> document.getElementById('connect_form').submit(); </script>
				<script>self.close();</script>
		  <?php
		  }
	    }
		break;
	}
}
catch(LinkedInException $e) {
// exception raised by library call
echo $e->getMessage();
}
?>
