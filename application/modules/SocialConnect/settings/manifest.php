<?php
return array(
	'package' => array(
		'type' => 'module',
		'name' => 'social-connect',
		'title' => 'YN - Social Connect',
		'version' => '4.08p1',
		'author' => '<a href="http://socialengine.younetco.com/" title="YouNet Company" target="_blank">YouNet Company</a>',
		'description' => 'Social Connect is a safe, faster, and easier way to log in by using existing accounts in Facebook, Twitter, Google, Yahoo, MySpace, LinkedIn, Windows Live, Hyves, up to more than 40 providers.',
		'path' => 'application/modules/SocialConnect',
		'callback' => array(
	      'path' => 'application/modules/SocialConnect/settings/install.php',
	      'class' => 'SocialConnect_Installer',
	    ),
		'dependencies' => array(
	      array(
	        'type' => 'module',
	        'name' => 'younet-core',
	        'minVersion' => '4.02p3',
	      ),
	      array(
	        'type' => 'module',
	        'name' => 'socialbridge',
	        'minVersion' => '4.01',
	      ),
	    ),
		'actions' => array(
			0 => 'install',
			1 => 'upgrade',
			2 => 'refresh',
			3 => 'enable',
			4 => 'disable',
		),
		'directories' => array(0 => 'application/modules/SocialConnect', ),
		'files' => array(0 => 'application/languages/en/social-connect.csv', ),
	),
	// Hooks ---------------------------------------------------------------------
	'hooks' => array(
		array(
			'event' => 'onUserCreateAfter',
			'resource' => 'SocialConnect_Plugin_Core'
		),
		array(
			'event' => 'onUserDeleteBefore',
			'resource' => 'SocialConnect_Plugin_Core',
		),
	),
	// Routes
	// --------------------------------------------------------------------
	'routes' => array(
		// User - General
		'socialconnect_add_email' => array(
	        'route' => 'social-connect/add-email/*',
	        'defaults' => array(
	            'module' => 'social-connect',
	            'controller' => 'index',
	            'action' => 'add-email',
	        )
	    ),
	    
		'socialconnect_add_password' => array(
	        'route' => 'social-connect/add-password/*',
	        'defaults' => array(
	            'module' => 'social-connect',
	            'controller' => 'index',
	            'action' => 'add-password',
	        )
	    ),
		
		'connect_signin' => array(
			'route' => 'openid-start/:service/*',
			'defaults' => array(
				'module' => 'social-connect',
				'controller' => 'index',
				'action' => 'openid-start'
			),
			'reqs' => array()
		),
		'connect_return' => array(
			'route' => 'openid-return/*',
			'defaults' => array(
				'module' => 'social-connect',
				'controller' => 'index',
				'action' => 'openid-return'
			),
			'reqs' => array()
		),
		'connect_exists' => array(
			'route' => 'social-connect/identity-connect/',
			'defaults' => array(
				'module' => 'social-connect',
				'controller' => 'index',
				'action' => 'identity-exists'
			),
			'reqs' => array()
		),
		'socialconnect_login' => array(
			'route' => 'social-connect/login/',
			'defaults' => array(
				'module' => 'social-connect',
				'controller' => 'index',
				'action' => 'login'
			),
			'reqs' => array()
		),
		'connect_map_user' => array(
			'route' => 'social-connect/verify-code-map-user/',
			'defaults' => array(
				'module' => 'social-connect',
				'controller' => 'index',
				'action' => 'verify-code-map-user'
			),
			'reqs' => array()
		),
		'socialconnect_signup' => array(
			'route' => 'social-connect/signup/*',
			'defaults' => array(
				'module' => 'social-connect',
				'controller' => 'signup',
				'action' => 'index'
			),
			'reqs' => array()
		),
		'connect_signup' => array(
			'route' => 'quick-signup/:service/*',
			'defaults' => array(
				'module' => 'social-connect',
				'controller' => 'index',
				'action' => 'signup'
			),
			'reqs' => array()
		),
		'connect_openid' => array(
			'route' => 'quick-signin2/:service/:identifier/*',
			'defaults' => array(
				'module' => 'social-connect',
				'controller' => 'index',
				'action' => 'openid',
				'service' => 'openid',
				'identifier' => 'none',
			),
			'reqs' => array()
		),
		'socialconnect_account' => array(
			'route' => 'social-account/:action/*',
			'defaults' => array(
				'module' => 'social-connect',
				'controller' => 'account',
				'action' => 'index'
			),
			'reqs' => array()
		),
		'socialconnect_accountlinking' => array(
			'route' => 'social-account/account-linking/*',
			'defaults' => array(
				'module' => 'social-connect',
				'controller' => 'index',
				'action' => 'account-linking'
			),
			'reqs' => array()
		),
		'socialconnect_delete_account'=> array(
			'route' => 'social-account/delete-linked/*',
			'defaults' => array(
				'module' => 'social-connect',
				'controller' => 'index',
				'action' => 'delete-linked'
			),
			'reqs' => array()
		),
	)
);
?>