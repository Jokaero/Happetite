/*** style simple ****/
.ynmenu-style-simple .ynmenu-container
{
	background-color: #[background_color];
}

.ynmenu-style-simple li[data-level='1']
{
	border-right: 1px [separated_line] #769cbc;
}

.ynmenu-style-simple li[data-level='1'] > a
{
	color: #[text_color];
}

.ynmenu-style-simple li[data-level='1'].over
{
	background-color: #[active_hover_background_color];
	color: #[hover_text_color];
}

.ynmenu-style-simple li[data-level='1'] > ul,
.ynmenu-style-simple li[data-level='1'].ynmenu-standard ul,
.ynmenu-style-simple li[data-level='1'] > .ynmenu-mixed-main
{
	background-color: #ffffff;
	-moz-box-shadow: 0 0 [dropdown_border_size] 0 #[dropdown_border_color];
	-webkit-box-shadow: 0 0 [dropdown_border_size] 0 #[dropdown_border_color];
	box-shadow: 0 0 [dropdown_border_size] 0 #[dropdown_border_color];
	border: [dropdown_border_size] solid #[dropdown_border_color];
}

.ynmenu-style-simple li[data-level='1'].ynmenu-multi li > a:hover > .text
{
	background-color: #[active_hover_background_color];
	color: #[hover_text_color];
}

.ynmenu-style-simple .ynmenu-listing .ynmenu-standard li.over > a {
	background-color: #[active_hover_background_color];
	color: #[hover_text_color];
}