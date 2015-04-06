<?php

class SocialConnect_Model_DbTable_Settings extends Engine_Db_Table{
    
    protected static $inst;
        
    public static function factory(){
        if(null == self::$inst){
            self::$inst =  new self();    
        }
        return self::$inst;
    }
    
    /**
     * get all settings of a service provider
     * @param    string   $service
     * @return   array
     * */
    public function getSettings($service = ''){
        
        $return =  array();
        
        if(!is_string($service)){
            return $return ;    
        }
        
        $inst = self::factory();
        
        $select  =  $inst -> select()
                          -> where('service = ?', $service);
                          
        $rs     = $inst->fetchAll($select);
        
        foreach($rs as $r){
            $return[$r->name]    = $r->value;           
        }
        
        return $return;
    }
    
    /**
     * get specified settings of a service provider
     * 
     * @param    string   $service
     * @param    string   $name
     * @return   mixed
     */
    public function getSetting($service, $name, $defaultValue  = null){
        $select  =  $this -> select ()
                    -> where ('service = ?', $service)
                    -> where ('name    = ?', $name);
                    
        $r      = $this->fetchRow($select);
        
        if($r){
            return $r->value;
        }
        
        return $defaultValue;
    }
    
    /**
     * set setting for a service with name and value and save to database.
     * 
     * @param   string   $service
     * @param   string   $name
     * @param   string   $value
     * 
     * */
    public function setSetting($service, $name, $value){
        
        $select = $this -> select()
                  -> where('service = ?', $service)
                  -> where('name    = ?', $name);
                  
        $item =  $this->fetchRow($select);
        
        if($item == null){
            $item =  $this->fetchNew();
            $item->service = $service;
            $item->name    = $name;
        }
        
        $item->value = $value;
        
        return $item->save();        
    }
    
}