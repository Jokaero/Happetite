<?php 
$description = $this->translate("Email %1s already exists, please enter your details below to login or click %2s to connect 2 accounts or click %3s to create a separate account.",$this->email, "<a href = '".$this->url(array(),"connect_map_user", true)."'>".$this->translate("here")."</a>", "<a href = '".$this->url(array(),"socialconnect_add_email", true)."'>".$this->translate("here")."</a>");
$this->form->setDescription($description);
$this->form->setAction($this->url(array(),"user_login"));
echo $this->form->render($this); ?>