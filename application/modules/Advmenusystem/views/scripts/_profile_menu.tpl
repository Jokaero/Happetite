<?php
$img = $this->itemPhoto($this->viewer(), 'thumb.icon');
if($this->viewer()->getTitle() == 'admin')
{
	echo "<a class = 'menu_core_mini core_mini_profile' href='" . $this->viewer()->getHref() . "'><div>" .$img. "</div>".$this->translate('Admin') . "</a>";
}
else
{
  	echo $this->htmlLink($this->viewer()->getHref(), '<div>'.$img.'</div>'.strip_tags($this->string()->truncate($this->viewer()->getTitle(), 12)),array('class'=> 'menu_core_mini core_mini_profile'));				 
}
?>     