<?php

class SocialConnect_Model_DbTable_Assocs extends Engine_Db_Table{
  
  protected static $_inst;
  
  /**
   * Model Singleton
   * 
   * @return   User_Model_DbTable_Connectors
   * 
   */
  public static function getInstance(){
    if(null == self::$_inst){
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
  public static function getAssoc($identity = null, $service =null){
    if(empty($identity)){
            throw new Exception('no indentity exists');
    }
    if(empty($service)){
            throw new Exception('no service assoc');
    }
    
    $inst   = self::getInstance();
    $select = $inst->select()->where('identity=?', $identity)
            ->where('service=?', $service);
    return $inst->fetchRow($select);
  }
  
  /**
   *
   * @param   array  $data
   *
   */
  public static function addAssoc(array $data){
    if(empty($data['user_id']) || empty($data['identity']) || empty($data['service'])){
      throw new Exception('not enought intergrity for table assoc');
    }
    
    $data['created_time']  = $data['logged_time'] = $data['updated_time'] = time();
    $inst =  self::getInstance();
    return $inst->insert($data);
  }    
}