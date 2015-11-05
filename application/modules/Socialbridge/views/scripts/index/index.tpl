<?php

 echo $this->partial('_manage_social.tpl', array(
		'callbackUrl' => $this->callbackUrl,
		'disconnect'  => $this->disconnect
		));?>