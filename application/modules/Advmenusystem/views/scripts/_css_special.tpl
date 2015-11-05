/*** ynmenu-special ***/
.ynmenu-style-special .ynadvanced-menu-system .ynmenu-container
{
	background-color: #[background_color];
}

.ynmenu-style-special li[data-level='1'] > a
{
	color: #[text_color];
}

.ynmenu-style-special li[data-level='1'] > a span.ynmenu-icon-hover,
.ynmenu-style-special li[data-level='1'] > a  span.ynmenu-icon
{
	background-color: #[background_icon_color];
	color: #[text_color];
}

.ynmenu-style-special li[data-level='1'].over > a > span.ynmenu-icon-hover
{
	background-color: #[hover_background_icon_color];
}

.ynmenu-style-special li[data-level='1'] > ul,
.ynmenu-style-special li[data-level='1'].ynmenu-standard ul,
.ynmenu-style-special li[data-level='1'] > .ynmenu-mixed-main
{
	border: [dropdown_border_size] solid #[dropdown_border_color];
}

.ynmenu-style-special .ynmenu-standard li.over > a
{
	background-color: #[background_color];
}

.ynmenu-style-special .ynmenu-multi li > a:hover > .text
{
	background-color: #[background_color];
}