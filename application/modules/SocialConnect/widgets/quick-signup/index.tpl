<style>
.ynsc_quick_signup
{
	width: <?php echo $this->iconsize;?>px;
	height: <?php echo $this->iconsize;?>px;
	margin-top: <?php echo $this->margintop;?>px;
	margin-right: <?php echo $this->marginright;?>px;
	padding: 4px;
	padding-left: 0px;
}
</style>

<?php
$base_path = $this -> layout() -> staticBaseUrl;

$str = '<form method="post" action="return false;" class="global_form" enctype="application/x-www-form-urlencoded">
   <div>
     <div>
       <span style="float:left;padding-top:7px;letter-spacing:-1px;padding-right:1.0em;font-size:1.3em;font-weight:bold;color: #717171;">' . $this -> translate('Sign-Up Using') . ': </span>';
foreach ($this->rs as $o)
{
	$str .= '<a title="' . $o -> title . '" href="javascript: void(0);" ';
	$str .= ' onclick="javascript: sopopup(\'' . $o -> getHref() . '\')"><img src="' . $base_path . 'application/modules/SocialConnect/externals/images/'.strtolower($o -> name).'.png" width="1px" height="1px" class="ynsc_quick_signup"/></a>';
}
$str .= '</div>
    </div>
  </form>
  <br />';

echo $str;
