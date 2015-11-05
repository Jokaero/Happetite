<?php
class Advmenusystem_Widget_LoginOrSignupController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
  	$this-> view -> socialconnect_enable = $socialconnect_enable = Engine_Api::_() -> advmenusystem() -> checkYouNetPlugin('social-connect');
    // Do not show if logged in
    if( Engine_Api::_()->user()->getViewer()->getIdentity() ) {
      $this->setNoRender();
      return;
    }
    
    // DON'T SHOW WIDGET, IF PLUGIN NOT ACTIVATED.
    $isPluginActivate = Engine_Api::_()->getApi('settings', 'core')->getSetting('advmenusystem.isActivate', true);
    if(empty($isPluginActivate))
      return $this->setNoRender();
    
    // Display form
    $form = $this->view->form = new User_Form_Login();
    $form->setTitle(null)->setDescription(null);
    $form->return_url->setValue('64-' . base64_encode($_SERVER['REQUEST_URI']));
    $form->removeElement('forgot');

  }
  
  public function getCacheKey()
  {
    return false;
  }
}
