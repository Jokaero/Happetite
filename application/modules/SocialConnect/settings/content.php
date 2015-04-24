<?php
return array(
    array(
        'title' => 'Quick Sign-Up',
        'description' => 'Sign-Up using social connect.',
        'category' => 'Social Connect',
        'type' => 'widget',
        'name' => 'social-connect.quick-signup',
    	'adminForm' => array(
    		'elements' => array(
    					array(
								'Text',
								'iconsize',
								array(
										'label' => 'Provider icon size in pixel (without "px")',
										'validators' => array('Int'),
										'value' => 32,
										'validators' => array(
											array(
												'Int',
												true
											),
											array(
												'GreaterThan',
												true,
												array(0)
											)
										)
								),
						),
						array(
							'Text', 
							'margintop', 
								array(
									'label' => 'Icon Margin Top in pixel (without "px")',
									'validators' => array('Int'),
									'value' => 0,
									'validators' => array(
										array(
											'Int',
											true
										)
									)
								)
						),
						array(
							'Text', 
							'marginright', 
								array(
									'label' => 'Icon Margin Right in pixel (without "px")',
									'validators' => array('Int'),
									'value' => 0,
									'validators' => array(
										array(
											'Int',
											true
										)
									)
								)
						),
    		)
    	)
    ),
    array(
        'title' => 'Quick Login',
        'description' => 'Login using social connect.',
        'category' => 'Social Connect',
        'type' => 'widget',
        'name' => 'social-connect.quick-login',
    	'adminForm' => array(
    		'elements' => array(
    					array(
								'Text',
								'iconsize',
								array(
										'label' => 'Provider icon size in pixel (without "px")',
										'validators' => array('Int'),
										'value' => 32,
										'validators' => array(
											array(
												'Int',
												true
											),
											array(
												'GreaterThan',
												true,
												array(0)
											)
										)
								),
						),
						array(
							'Text', 
							'margintop', 
								array(
									'label' => 'Icon Margin Top in pixel (without "px")',
									'validators' => array('Int'),
									'value' => 0,
									'validators' => array(
										array(
											'Int',
											true
										)
									)
								)
						),
						array(
							'Text', 
							'marginright', 
								array(
									'label' => 'Icon Margin Right in pixel (without "px")',
									'validators' => array('Int'),
									'value' => 0,
									'validators' => array(
										array(
											'Int',
											true
										)
									)
								)
						),
    		)
    	)
    ),
    array(
        'title' => 'Login or Sign-Up',
        'description' => 'Login or sign-up using social connect.',
        'category' => 'Social Connect',
        'type' => 'widget',
        'name' => 'social-connect.login-or-signup',
    	'adminForm' => array(
    		'elements' => array(
    					array(
								'Text',
								'iconsize',
								array(
										'label' => 'Provider icon size in pixel (without "px")',
										'validators' => array('Int'),
										'value' => 24,
										'validators' => array(
											array(
												'Int',
												true
											),
											array(
												'GreaterThan',
												true,
												array(0)
											)
										)
								),
						),
						array(
							'Text', 
							'margintop', 
								array(
									'label' => 'Icon Margin Top in pixel (without "px")',
									'validators' => array('Int'),
									'value' => 0,
									'validators' => array(
										array(
											'Int',
											true
										)
									)
								)
						),
						array(
							'Text', 
							'marginright', 
								array(
									'label' => 'Icon Margin Right in pixel (without "px")',
									'validators' => array('Int'),
									'value' => 0,
									'validators' => array(
										array(
											'Int',
											true
										)
									)
								)
						),
    		)
    	)
    ),
    array(
        'title' => 'Call Popup Invite Friends',
        'description' => 'Call popup invite friends after sign up using contact importer plugin',
        'category' => 'Social Connect',
        'type' => 'widget',
        'name' => 'social-connect.call-popup-invite',
    ),
	)
?>