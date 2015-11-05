/*** style flat ****/

.ynmenu-style-flat .ynmenu-listing a {
	color: #[text_color];
}

.ynmenu-style-flat .ynadvanced-menu-system {
	background-color: #[background_color];
	border-top: [top_border_size] solid #[top_border_color];
	border-bottom: [bottom_border_size] solid #[bottom_border_color];
}

.ynmenu-style-flat li[data-level='1'] 
{
	background-color: #[background_color];			
	border-right: 1px [separated_line] #e8ebec;
}

.ynmenu-style-flat li[data-level='1'] > .toggle { 
	display: none; 
}

.ynmenu-style-flat li[data-level='1'] > a .ynmenu-icon,
.ynmenu-style-flat li[data-level='1'] > a .ynmenu-icon-hover {
	background-color: #[active_hover_background_color];
	color: #[hover_text_color];
}

.ynmenu-style-flat li[data-level='1'] > a .ynmenu-icon-hover {
	background-color: #[hover_text_color];
	color: #[active_hover_background_color];
}

.ynmenu-style-flat li[data-level='1'].over {
	background-color: #[active_hover_background_color];
}

.ynmenu-style-flat li[data-level='1'].over > a {			
	color: #[hover_text_color];
}
	
.ynmenu-style-flat li[data-level='1'] > ul,
.ynmenu-style-flat li[data-level='1'].ynmenu-standard ul,
.ynmenu-style-flat li[data-level='1'] > .ynmenu-mixed-main {
	border-bottom: [dropdown_bottom_border_size] solid #[dropdown_bottom_border_color];
	border-left: [dropdown_left_right_border_size] solid #[dropdown_left_right_border_color];
	border-right: [dropdown_left_right_border_size] solid #[dropdown_left_right_border_color];
}

.ynmenu-style-flat .ynmenu-standard li.over > a {
	background-color: #[active_hover_background_color];		
}

.ynmenu-style-flat .ynmenu-multi li > a:hover > .text {
	background-color: #[active_hover_background_color];
}
