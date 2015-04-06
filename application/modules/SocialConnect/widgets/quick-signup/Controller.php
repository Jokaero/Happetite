<?php
class SocialConnect_Widget_QuickSignupController extends Engine_Content_Widget_Abstract
{
	public function indexAction()
	{
		$rs = $this -> view -> rs = Engine_Api::_() -> getDbTable('Services', 'SocialConnect') -> getServices(100, 1);
		
		// Get Params
		$this->view->iconsize = $this->_getParam('iconsize', 32);
		$this->view->margintop = $this->_getParam('margintop', 0);
		$this->view->marginright = $this->_getParam('marginright', 0);
		if ($rs -> count() == 0)
		{
			$this -> setNoRender(TRUE);
		}
	}

}
