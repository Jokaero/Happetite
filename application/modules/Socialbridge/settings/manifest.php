<?php
return array(
	'package' => array(
		'type' => 'module',
		'name' => 'socialbridge',
		'version' => '4.04p3',
		'path' => 'application/modules/Socialbridge',
		'title' => 'Social Bridge',
		'description' => 'This is Social Bridge plugin.',
		'author' => '<a href="http://socialengine.younetco.com/" title="YouNet Company" target="_blank">YouNet Company</a>',
		'callback' => array(
			'class' => 'Socialbridge_Installer',
			'path' => 'application/modules/Socialbridge/settings/install.php',
		 ),
		'actions' => array(
			0 => 'install',
			1 => 'upgrade',
			2 => 'refresh',
			3 => 'enable',
			4 => 'disable',
		),
		'directories' => array(0 => 'application/modules/Socialbridge', ),
		'files' => array(0 => 'application/languages/en/socialbridge.csv', ),
	),
	// Items ---------------------------------------------------------------------
	  'items' => array(
		'socialbridge_apisetting',
		'socialbridge_token',
	  ),
	 // Hooks ---------------------------------------------------------------------
	  'hooks' => array(
	    array(
	      'event' => 'onUserLogoutBefore',
	      'resource' => 'Socialbridge_Plugin_Core',
	    ),
  	),
	'routes' =>
		array(
			'socialbridge_general' =>
			array(
				'route' => 'socialbridge/:action/*',
				'defaults' =>
				array(
					'module' => 'socialbridge',
					'controller' => 'index',
					'action' => 'index',
				),
				'reqs' => array('action' => '(index|get-contacts|disconnect)'),
			),
		),
);
?>