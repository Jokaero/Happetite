<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Messages
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Message.php 10009 2013-03-26 23:25:57Z jung $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Messages
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Messages_Model_Message extends Core_Model_Item_Abstract
{
  protected $_searchTriggers = false;
  
  public function getConversation($message){
    
  }
  
  public function getRecipientInfo(User_Model_User $user)
  {
    return $this->getRecipientsInfo()->getRowMatching('user_id', $user->getIdentity());
  }
  
  public function getRecipientsInfo()
  {
    if( empty($this->store()->recipientsInfo) )
    {
      $table = Engine_Api::_()->getDbtable('recipients', 'messages');
      $select = $table->select()
        ->where('conversation_id = ?', $this->getIdentity());
      $this->store()->recipientsInfo = $table->fetchAll($select);
    }

    return $this->store()->recipientsInfo;
  }
  
  public function getHref($params = array())
  {
    $params = array_merge(array(
      'route' => 'messages_general',
      'reset' => true,
      'action' => 'view',
      'id' => $this->conversation_id,
      'message_id' => $this->getIdentity()
    ), $params);
    $route = $params['route'];
    $reset = $params['reset'];
    unset($params['route']);
    unset($params['reset']);
    return Zend_Controller_Front::getInstance()->getRouter()
      ->assemble($params, $route, $reset);
  }

  public function getAttachment()
  {
    if( !empty($this->attachment_type) && !empty($this->attachment_id) )
    {
      return Engine_Api::_()->getItem($this->attachment_type, $this->attachment_id);
    }
  }
}