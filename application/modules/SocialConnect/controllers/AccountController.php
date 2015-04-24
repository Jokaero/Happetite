<?php

class SocialConnect_AccountController extends Core_Controller_Action_User
{
    public function indexAction(){
        
        $this->view->items   = SocialConnect_Model_DbTable_Services::getServices();
        $tableAgent = new SocialConnect_Model_DbTable_Agents;
        $this->view->agents =  $tableAgent->getAssociateAgents();
        
    }
}
