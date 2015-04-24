<?php
//wget -O- "http://<yoursite>/?m=lite&name=task&module=socialbridge" > /dev/null

$application -> getBootstrap() -> bootstrap('translate');
$application -> getBootstrap() -> bootstrap('locale');
$application -> getBootstrap() -> bootstrap('hooks');


if(class_exists('Socialbridge_Plugin_Task_Queues'))
{
	Socialbridge_Plugin_Task_Queues::execute();
}
