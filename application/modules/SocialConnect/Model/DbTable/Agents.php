<?php

class SocialConnect_Model_DbTable_Agents extends Engine_Db_Table
{

    protected static $_inst;

    protected $_rowClass = 'SocialConnect_Model_Agent';

    /**
     *
     * get instance
     * @return   SocialConnect_Model_DbTable_Identity
     *
     */
    public static function factory()
    {
        if (null == self::$_inst)
        {
            self::$_inst = new self();
        }
        return self::$_inst;
    }

    /**
     * @param   midxed $identity
     * @param   mixed $service
     * @return  Zend_Model_DbTable_Row
     *
     */
    public static function getAgent($identity = null, $service = null)
    {
        if (empty($identity))
        {
            throw new Exception('no indentity exists');
        }
        if (empty($service))
        {
            throw new Exception('no service assoc');
        }

        $provider = SocialConnect_Model_DbTable_Services::getService($service);
        $inst = self::factory();
        $select = $inst -> select() -> where('identity=?', $identity) -> where('service_id=?', $provider -> service_id);
        return $inst -> fetchRow($select);
    }

    /**
     * @param int $agent_id
     * @return array [service_id:[$agent]]
     */
    public function getAssociateAgents($user = null)
    {
        if (null == $user)
        {
            $user = Engine_Api::_() -> user() -> getViewer();
        }

        $result = array();

        $select = $this -> select() -> where('user_id=?', (int)$user -> getIdentity())->order('login_time ASC');
        
        
        
        foreach ($this->fetchAll($select) as $row)
        {
            $result[$row -> service_id][] = $row;
        }
        
        
        return $result;
    }

}
