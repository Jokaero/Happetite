<?php

$fields = Engine_Api::_() -> getDbTable('Fields', 'SocialConnect') -> getProfileFieldStructure('facebook');

var_dump($fields);
