UPDATE `engine4_activity_notificationtypes`
SET `body` = "Your request to join the event {item:$object} has been approved."
WHERE `type` = "event_accepted";