/* Adv.Menu Notification */
li.ynadvmenu_notification
{
	padding-top: [notification_padding_top]!important;
}
li.ynadvmenu_notification div.ynadvmenu_mini_wrapper a.ynadvmenu_NotifiIcon
{
	background-image: url([notification_background_image])!important;
}



/* Sub main menu*/
li.ynadvmenu_downservicesMain ul.ynadvmenu_pulldownMainWrapper
{
	background-color: #[main_menu_sub_menu_background_color];	
}
li.ynadvmenu_downservicesMain ul.ynadvmenu_pulldownMainWrapper > li a
{
	color: #[main_menu_sub_menu_link_color];
}
li.ynadvmenu_downservicesMain ul.ynadvmenu_pulldownMainWrapper > li a:hover
{
	color: #[main_menu_sub_menu_link_hover_color];
}
li.ynadvmenu_downservicesMain > a:link, li.ynadvmenu_downservicesMain > a:visited,
li.ynadvmenu_downservicesMain:hover > a:link, li.ynadvmenu_downservicesMain:hover > a:visited
{
 	background-position: right [main_menu_sub_menu_vertical_arrow] !important;
}