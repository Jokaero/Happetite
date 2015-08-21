<?php

class SocialConnect_Model_DbTable_Options extends Engine_Db_Table{
    
    protected static $inst;
    
    public static function factory(){
        if(self::$inst == null){
            self::$inst =  new self();
        }
        return self::$inst;
    }
        
    public function getOptions($service){  
        $pairs  =  array('None');
        $select =  $this->select()->where('service = ?', $service);
        $rs = $this->fetchAll($select);
        foreach($rs as $r){
            $pairs[$r->opt_id] =  $r->label;
        }
        return $pairs ;
    }
}