<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Network
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Networks.php 9747 2012-07-26 02:08:08Z john $
 * @author     Sami
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Network
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Network_Model_DbTable_Networks extends Engine_Db_Table
{
  protected $_rowClass = 'Network_Model_Network';

  protected $_serializedColumns = array('pattern');

  public function recalculate(User_Model_User $member, $values = null)
  {
    if( null === $values ) {
      $values = Engine_Api::_()->fields()->getFieldsValues($member);
    }

    foreach( $this->fetchAll() as $network )
    {
      $network->recalculate($member, $values);
    }

    return $this;
  }
}
