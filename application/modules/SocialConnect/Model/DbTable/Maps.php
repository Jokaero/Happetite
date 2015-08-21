<?php

class SocialConnect_Model_DbTable_Maps extends Engine_Db_Table{
	
  protected static $inst;
  
  protected static $profileFields;
  /**
   * factory
   * 
   * @return SocialConnect_Model_DbTable_Maps
   */
	public static function factory(){
    
		if(self::$inst == NULL){
			self::$inst = new self();
		}
		return self::$inst;
	}
	
  /**
   * get all profile fields
   * 
   */
	public static function getProfileFields(){
    
		if(self::$profileFields == null){
			$prefix = Engine_Db_Table::getTablePrefix();
			$adapter = Engine_Db_Table::getDefaultAdapter();
			$sql = "SELECT engine4_user_fields_meta.* FROM `engine4_user_fields_maps` 
					join  engine4_user_fields_meta on (engine4_user_fields_maps.child_id = engine4_user_fields_meta.field_id )
					where engine4_user_fields_maps.option_id =  1 
					and engine4_user_fields_meta.type NOT IN ('profile_type','heading','gender','birthdate')
					";
			
			self::$profileFields =  $adapter->fetchAll($sql);
		}
		return self::$profileFields;
	}
  
  /**
   *
   *
   *
   */
	public static function getMaps($service){
		$adapter = Engine_Db_Table::getDefaultAdapter();
		$sql = "
            select t2.name, t1.field_id as value
            from engine4_socialconnect_maps as t1
            left join engine4_socialconnect_options as t2 on(t1.opt_id = t2.opt_id)
            where t1.service = '$service' and t1.opt_id is NOT NULL";

		return $adapter->fetchPairs($sql);;
	}
  
  public function getValues($service){
    
    $return = array();
    
    if(!is_string($service)){
        return $return;    
    }    
    
    $adapter = Engine_Db_Table::getDefaultAdapter();
		$sql = "
            select concat('pfid_',t1.field_id) as name, t1.opt_id as value
            from engine4_socialconnect_maps as t1
            where t1.service = '$service'";

    $rs = $adapter->fetchPairs($sql);;
    
    return $rs;
  }
  
  public function getItem($service, $field_id){
    
    $select = $this->select()->where('service = ?', $service)
                             ->where('field_id = ?', $field_id);
                             
    $item  = $this->fetchRow($select);
    
    if(!$item){
        $item =  $this->fetchNew();
        $item->service = $service;
        $item->field_id = $field_id;
    }
    return $item;
  }
}