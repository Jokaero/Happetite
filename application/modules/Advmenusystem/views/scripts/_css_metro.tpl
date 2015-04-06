/*** ynmenu-metro ***/
.ynmenu-style-metro .ynmenu-listing .ynmenu-standard li.over>a
{
	color: #[text_color];
	background-color: #[background_color];
}

.ynmenu-style-metro li[data-level='1'] > a
{
	background-color: #[background_color];
	color: #[text_color];
}

.ynmenu-style-metro li[data-level='1'] > a span.ynmenu-icon,
.ynmenu-style-metro li[data-level='1'] > a span.ynmenu-icon-hover
{
	border: 2px solid #[text_color];
}

.ynmenu-style-metro li[data-level='1'] > ul,
.ynmenu-style-metro li[data-level='1'].ynmenu-standard ul,
.ynmenu-style-metro li[data-level='1'] > .ynmenu-mixed-main
{
	border: [dropdown_left_right_bottom_border_size] solid #[dropdown_left_right_border_bottom_color];
	border-top: [dropdown_bottom_border_size] solid #[dropdown_bottom_border_color];
}
<?php if (defined('YNRESPONSIVE')) :?>
@media (max-width: 767px) {
	.ynmenu-style-metro li[data-level='1'] > a span.ynmenu-icon,
	.ynmenu-style-metro li[data-level='1'] > a span.ynmenu-icon-hover
	{
		border: 0;
	}
}
<?php endif; ?>