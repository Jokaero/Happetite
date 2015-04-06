<?php
try
{
	$viewer_id = isset($_REQUEST['viewer_id']) ? $_REQUEST['viewer_id'] : 0;
	if (!$viewer_id)
	{
		exit('{notification:0,freq:0,msg: 0}');
	}
	$notificationTb = Engine_Api::_() -> getDbtable('notifications', 'activity');
	$tbName = $notificationTb -> info('name');
	$db = $notificationTb -> getAdapter();
	$notif_friend = $db -> query("SELECT (SELECT COUNT(*) FROM $tbName WHERE `user_id` = {$viewer_id} AND `mitigated` = 0 AND `type` NOT IN ('friend_request','message_new')) as update_count, (SELECT COUNT(*) FROM $tbName WHERE `user_id` = {$viewer_id} AND `mitigated` = 0 AND `type` = 'friend_request') as frequest_count, (SELECT COUNT(*) FROM $tbName WHERE `user_id` = {$viewer_id} AND `mitigated` = 0 AND `type` = 'message_new') as message_count") -> fetch();
	$data = array(
		'notification' => $notif_friend['update_count'],
		'freq' => $notif_friend['frequest_count'],
		'msg' => $notif_friend['message_count']
	);
	echo Zend_Json::encode($data);

}
catch(exception $e)
{
	echo '{notification:0,freq:0,msg: 0}';
}
