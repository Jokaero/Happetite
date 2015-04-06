<?php

class  SocialConnect_Plugin_Menus
{
    public function onUserHome($row)
    {
        $viewer = Engine_Api::_() -> user() -> getViewer();
        if (is_object($viewer) && $viewer -> getIdentity())
        {
            return $row;
        }
    }

}
