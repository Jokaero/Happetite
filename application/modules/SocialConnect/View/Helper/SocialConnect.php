<?php
class SocialConnect_View_Helper_SocialConnect extends Zend_View_Helper_Abstract
{

	public function socialConnect($title = 'Sign In Using')
	{
		$rs = Engine_Api::_() -> getDbTable('Services', 'SocialConnect') -> getServices(100, 1);
		if ($rs -> count() == 0)
		{
			return '';
		}
		$front = Zend_Controller_Front::getInstance();
		$view = Zend_Registry::get('Zend_View');
		$base_path = $view -> layout() -> staticBaseUrl;
		$str = '<form method="post" action="return false;" class="global_form" enctype="application/x-www-form-urlencoded">
   <div>
     <div>
       <span style="float:left;padding-top:2px;letter-spacing:-1px;padding-right:1.0em;font-size:1.3em;font-weight:bold;color: #717171;">' . $title . ': </span>';
		foreach ($rs as $o)
		{
			$str .= '<a title="' . $o -> title . '" href="javascript: void(0);" ';
			$str .= ' onclick="javascript: sopopup(\'' . $o -> getHref() . '\')"><img src="' . $base_path . 'application/modules/SocialConnect/externals/images/trans.gif?c=401" width="1px" height="1px" class="ynsc_sprite ynsc_sprite_' . strtolower($o -> name) . '"/></a>';
		}
		$str .= '</div>
    </div>
  </form>
  <br />';
		return $str;
	}

}
