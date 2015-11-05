/*** ynmenu-white ***/

.ynmenu-style-white li[data-level='1']
{
	border-right: 1px [separated_line] #e7e7e7;
}


.ynmenu-style-white li[data-level='1'] > a
{
	color: #[text_color];
}

.ynmenu-style-white li[data-level='1'].over > a
{
	color: #[hover_text_color];
	border-top: 4px solid #[active_hover_border_color];
	border-bottom: 4px solid #[active_hover_border_color];
}

.ynmenu-style-white li[data-level='1'].over > a:after
{
	border-top: 6px solid #[active_hover_border_color];
}

.ynmenu-style-white li[data-level='1'] > ul,
.ynmenu-style-white li[data-level='1'].ynmenu-standard ul,
.ynmenu-style-white li[data-level='1'] > .ynmenu-mixed-main
{
	-moz-box-shadow: 0 0 [dropdown_border_size] 0 #[dropdown_border_color];
	-webkit-box-shadow: 0 0 [dropdown_border_size] 0 #[dropdown_border_color];
	box-shadow: 0 0 [dropdown_border_size] 0 #[dropdown_border_color];
	border: solid [dropdown_border_size] #[dropdown_border_color];
}

.ynmenu-style-white .ynmenu-standard li.over > a
{
	background-color: #[hover_text_color];
}

.ynmenu-style-white .ynmenu-multi li > a:hover > .text
{
	background-color: #[hover_text_color];
}