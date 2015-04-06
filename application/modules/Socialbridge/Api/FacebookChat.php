<?php
class Socialbridge_Api_FacebookChat extends Core_Api_Abstract
{

	// Copyright 2004-present Facebook. All Rights Reserved.

	private $_senderJid;
	private $_connection = NULL;
	private $_bIsDebug = false;

	public function xmpp_message($to, $body, $subject = null, $type = 'chat', $payload = null)
	{
		if (is_null($type))
		{
			$type = 'chat';
		}

		$to = htmlspecialchars($to);
		$body = htmlspecialchars($body);
		$subject = htmlspecialchars($subject);

		$out = "<message from=\"-" . $this -> _senderJid . "@chat.facebook.com\" to=\"-" . $to . "@chat.facebook.com\" type='$type'>";
		if ($subject)
			$out .= "<subject>$subject</subject>";
		$out .= "<body>$body</body>";
		if ($payload)
			$out .= $payload;
		$out .= "</message>";

		$this -> send_xml($this -> _connection, $out);
		$this -> recv_xml($this -> _connection);
		//		if (!$this->find_xmpp($this->_connection, 'STREAM:ERROR')) {
		//			return true;
		//		}

		return true;

	}

	function custom_print($str)
	{
		print $str;
	}

	function open_connection($server)
	{
		if ($this -> _bIsDebug)
			$this -> custom_print("[INFO] Opening connection... ");

		$fp = fsockopen($server, 5222, $errno, $errstr);
		if (!$fp)
		{
			if ($this -> _bIsDebug)
				$this -> custom_print("$errstr ($errno)<br>");
		}
		else
		{
			if ($this -> _bIsDebug)
				$this -> custom_print("connnection open<br>");
		}

		return $fp;
	}

	function send_xml($fp, $xml)
	{
		$this -> print_req($xml);
		fwrite($fp, $xml);
	}

	function recv_xml($fp, $size = 4096)
	{
		$xml = fread($fp, $size);
		$this -> print_res($xml);
		if ($xml === "")
		{
			return null;
		}

		//fix bug when response xml lack of "<" at first character we add it
		if (substr($xml, 0, 1) != '<')
		{
			$xml = '<' . $xml;
		}

		// parses xml
		$xml_parser = xml_parser_create();
		xml_parse_into_struct($xml_parser, $xml, $val, $index);
		xml_parser_free($xml_parser);

		return array(
			$val,
			$index
		);
	}

	function find_xmpp($fp, $tag, $value = null, &$ret = null)
	{
		static $val = null, $index = null;

		do
		{
			if ($val === null && $index === null)
			{
				list($val, $index) = $this -> recv_xml($fp);
				if ($val === null || $index === null)
				{
					return false;
				}
			}

			foreach ($index as $tag_key => $tag_array)
			{
				if ($tag_key === $tag)
				{
					if ($value === null)
					{
						if (isset($val[$tag_array[0]]['value']))
						{
							$ret = $val[$tag_array[0]]['value'];
						}
						return true;
					}
					foreach ($tag_array as $i => $pos)
					{
						if ($val[$pos]['tag'] === $tag && isset($val[$pos]['value']) && $val[$pos]['value'] === $value)
						{
							$ret = $val[$pos]['value'];
							return true;
						}
					}
				}
			}
			//			if($tag == 'STREAM:ERROR')
			//			{
			//				return false;
			//			}
			$val = $index = null;
		}
		while (!feof($fp));

		return false;
	}

	function print_req($str)
	{
		if ($this -> _bIsDebug)
			$this -> custom_print('request: ' . $str . '<br>');
	}

	function print_res($xml)
	{
		if ($this -> _bIsDebug)
			$this -> custom_print('response: ' . $xml . '<br>');
	}

	function xmpp_connect($options, $access_token)
	{

		if ($this -> _connection)
		{
			return true;
		}

		$STREAM_XML = '<stream:stream ' . 'xmlns:stream="http://etherx.jabber.org/streams" ' . 'version="1.0" xmlns="jabber:client" to="chat.facebook.com" ' . 'xml:lang="en" xmlns:xml="http://www.w3.org/XML/1998/namespace">';

		$AUTH_XML = '<auth xmlns="urn:ietf:params:xml:ns:xmpp-sasl" ' . 'mechanism="X-FACEBOOK-PLATFORM"></auth>';

		$RESOURCE_XML = '<iq type="set" id="3">' . '<bind xmlns="urn:ietf:params:xml:ns:xmpp-bind">' . '<resource>fb_xmpp_script</resource></bind></iq>';

		$SESSION_XML = '<iq type="set" id="4" to="chat.facebook.com">' . '<session xmlns="urn:ietf:params:xml:ns:xmpp-session"/></iq>';

		$START_TLS = '<starttls xmlns="urn:ietf:params:xml:ns:xmpp-tls"/>';

		$fp = $this -> open_connection($options['server']);
		if (!$fp)
		{
			return false;
		}

		// initiates auth process (using X-FACEBOOK_PLATFORM)

		$this -> send_xml($fp, $STREAM_XML);

		if (!$this -> find_xmpp($fp, 'STREAM:STREAM'))
		{
			return false;
		}
		if (!$this -> find_xmpp($fp, 'MECHANISM', 'X-FACEBOOK-PLATFORM'))
		{
			return false;
		}

		// starting tls - MANDATORY TO USE OAUTH TOKEN!!!!
		$this -> send_xml($fp, $START_TLS);

		if (!$this -> find_xmpp($fp, 'PROCEED', null, $proceed))
		{
			return false;
		}
		stream_socket_enable_crypto($fp, true, STREAM_CRYPTO_METHOD_TLS_CLIENT);

		$this -> send_xml($fp, $STREAM_XML);
		if (!$this -> find_xmpp($fp, 'STREAM:STREAM'))
		{
			return false;
		}
		if (!$this -> find_xmpp($fp, 'MECHANISM', 'X-FACEBOOK-PLATFORM'))
		{
			return false;
		}

		// gets challenge from server and decode it
		$this -> send_xml($fp, $AUTH_XML);
		if (!$this -> find_xmpp($fp, 'CHALLENGE', null, $challenge))
		{
			return false;
		}
		$challenge = base64_decode($challenge);
		$challenge = urldecode($challenge);
		parse_str($challenge, $challenge_array);

		// creates the response array
		$resp_array = array(
			'method' => $challenge_array['method'],
			'nonce' => $challenge_array['nonce'],
			'access_token' => $access_token,
			'api_key' => $options['app_id'],
			'call_id' => 0,
			'v' => '1.0',
		);
		// creates signature
		$response = http_build_query($resp_array);

		// sends the response and waits for success
		$xml = '<response xmlns="urn:ietf:params:xml:ns:xmpp-sasl">' . base64_encode($response) . '</response>';
		$this -> send_xml($fp, $xml);
		if (!$this -> find_xmpp($fp, 'SUCCESS'))
		{
			return false;
		}

		// finishes auth process
		$this -> send_xml($fp, $STREAM_XML);
		if (!$this -> find_xmpp($fp, 'STREAM:STREAM'))
		{
			return false;
		}
		if (!$this -> find_xmpp($fp, 'STREAM:FEATURES'))
		{
			return false;
		}
		$this -> send_xml($fp, $RESOURCE_XML);
		if (!$this -> find_xmpp($fp, 'JID'))
		{
			return false;
		}

		$this -> send_xml($fp, $SESSION_XML);
		if (!$this -> find_xmpp($fp, 'SESSION'))
		{
			return false;
		}
		// we made it!

		//set local variable
		$this -> _senderJid = $options['uid'];
		$this -> _connection = $fp;
		return true;
	}

	function xmpp_close($fp = null)
	{
		if (!$this -> _connection)
		{
			return false;
		}
		$CLOSE_XML = '</stream:stream>';
		$this -> send_xml($this -> _connection, $CLOSE_XML);
		fclose($this -> _connection);
		$this -> _connection = NULL;

		return true;
	}

	//Gets access_token with xmpp_login permission
	function get_access_token($app_id, $app_secret, $my_url)
	{

		$code = $_REQUEST["code"];

		if (empty($code))
		{
			$dialog_url = "http://www.facebook.com/dialog/oauth?scope=xmpp_login" . "&client_id=" . $app_id . "&redirect_uri=" . urlencode($my_url);
			echo("<script>top.location.href='" . $dialog_url . "'</script>");
		}
		$token_url = "https://graph.facebook.com/oauth/access_token?client_id=" . $app_id . "&redirect_uri=" . urlencode($my_url) . "&client_secret=" . $app_secret . "&code=" . $code;
		$access_token = file_get_contents($token_url);
		parse_str($access_token, $output);

		return ($output['access_token']);
	}

}
?>
