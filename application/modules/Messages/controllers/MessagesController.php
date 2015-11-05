<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Messages
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: MessagesController.php 10246 2014-05-30 21:34:20Z andres $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Messages
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Messages_MessagesController extends Core_Controller_Action_User
{
  protected $_form;

  public function init()
  {
    $this->_helper->requireUser();
    $this->_helper->requireAuth()->setAuthParams('messages', null, 'create');
  }
  
  public function inboxAction()
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $this->view->paginator = $paginator = Engine_Api::_()->getItemTable('messages_conversation')
        ->getInboxPaginator($viewer);
    $paginator->setCurrentPageNumber($this->_getParam('page'));
    $this->view->unread = Engine_Api::_()->messages()->getUnreadMessageCount($viewer);
    
    // Render
    $this->_helper->content
        //->setNoRender()
        ->setEnabled()
        ;
  }

  public function outboxAction()
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $this->view->paginator = $paginator = Engine_Api::_()->getItemTable('messages_conversation')->getOutboxPaginator($viewer);
    $paginator->setCurrentPageNumber($this->_getParam('page'));
    $this->view->unread = Engine_Api::_()->messages()->getUnreadMessageCount($viewer);
    
    // Render
    $this->_helper->content
        //->setNoRender()
        ->setEnabled()
        ;
  }

  public function viewAction()
  {
    // Render
    $this->_helper->content
        //->setNoRender()
        ->setEnabled()
        ;
    
    $id = $this->_getParam('id');
    $viewer = Engine_Api::_()->user()->getViewer();

    // Get conversation info
    $this->view->conversation = $conversation = Engine_Api::_()->getItem('messages_conversation', $id);

    // Make sure the user is part of the conversation
    if( !$conversation || !$conversation->hasRecipient($viewer) ) {
      return $this->_forward('inbox');
    }

    // Check for resource
    if( !empty($conversation->resource_type) &&
        !empty($conversation->resource_id) ) {
      $resource = Engine_Api::_()->getItem($conversation->resource_type, $conversation->resource_id);
      if( !($resource instanceof Core_Model_Item_Abstract) ) {
        return $this->_forward('inbox');
      }
      $this->view->resource = $resource;
    }
    // Otherwise get recipients
    else {
      $this->view->recipients = $recipients = $conversation->getRecipients();
      
      $blocked = false;
      $blocker = "";

      // This is to check if the viewered blocked a member
      $viewer_blocked = false;
      $viewer_blocker = "";

      foreach($recipients as $recipient){
        if ($viewer->isBlockedBy($recipient)){
          $blocked = true;
          $blocker = $recipient;
        }
        elseif ($recipient->isBlockedBy($viewer)){
          $viewer_blocked = true;
          $viewer_blocker = $recipient;
        }
      }
      $this->view->blocked = $blocked;
      $this->view->blocker = $blocker;
      $this->view->viewer_blocked = $viewer_blocked;
      $this->view->viewer_blocker = $viewer_blocker;
    }


    // Can we reply?
    $this->view->locked = $conversation->locked;
    if( !$conversation->locked ) {
      
      // Assign the composing junk
      $composePartials = array();
      foreach( Zend_Registry::get('Engine_Manifest') as $data )
      {
        if( empty($data['composer']) ) continue;
        foreach( $data['composer'] as $type => $config )
        {
          $composePartials[] = $config['script'];
        }
      }
      $this->view->composePartials = $composePartials;


      // Process form
      $this->view->form = $form = new Messages_Form_Reply();
      if( $this->getRequest()->isPost() && $form->isValid($this->getRequest()->getPost()) )
      {
        $db = Engine_Api::_()->getDbtable('messages', 'messages')->getAdapter();
        $db->beginTransaction();
        try
        {
          // Try attachment getting stuff
          $attachment = null;
          $attachmentData = $this->getRequest()->getParam('attachment');
          if( !empty($attachmentData) && !empty($attachmentData['type']) ) {
            $type = $attachmentData['type'];
            $config = null;
            foreach( Zend_Registry::get('Engine_Manifest') as $data )
            {
              if( !empty($data['composer'][$type]) )
              {
                $config = $data['composer'][$type];
              }
            }
            if( $config ) {
              $plugin = Engine_Api::_()->loadClass($config['plugin']);
              $method = 'onAttach'.ucfirst($type);
              $attachment = $plugin->$method($attachmentData);

              $parent = $attachment->getParent();
              if($parent->getType() === 'user'){
                $attachment->search = 0;
                $attachment->save();
              }
              else {
                $parent->search = 0;
                $parent->save();
              }

            }
          }

          $values = $form->getValues();
          $values['conversation'] = (int) $id;

          $conversation->reply(
            $viewer,
            $values['body'],
            $attachment
          );
          /*
          Engine_Api::_()->messages()->replyMessage(
            $viewer,
            $values['conversation'],
            $values['body'],
            $attachment
          );
           *
           */

          // Send notifications
          foreach( $recipients as $user )
          {
            if( $user->getIdentity() == $viewer->getIdentity() )
            {
              continue;
            }
            Engine_Api::_()->getDbtable('notifications', 'activity')->addNotification(
              $user,
              $viewer,
              $conversation,
              'message_new'
            );
          }

          // Increment messages counter
          Engine_Api::_()->getDbtable('statistics', 'core')->increment('messages.creations');

          $db->commit();
        }
        catch( Exception $e )
        {
          $db->rollBack();
          throw $e;
        }

        $form->populate(array('body' => ''));
        return $this->_helper->redirector->gotoRoute(array('action' => 'view', 'id' => $id));
      }
    }

    // Make sure to load the messages after posting :P
    $this->view->messages = $messages = $conversation->getMessages($viewer);

    $conversation->setAsRead($viewer);
  }

  public function composeAction()
  {
    // Render
    $this->_helper->content
       //->setNoRender()
       ->setEnabled()
       ;

    // Make form
    $this->view->form = $form = new Messages_Form_Compose();
    //$form->setAction($this->view->url(array('to' => null, 'multi' => null)));

    // Get params
    $multi = $this->_getParam('multi');
    $to = $this->_getParam('to');
    $viewer = Engine_Api::_()->user()->getViewer();
    $toObject = null;

    // Build
    $isPopulated = false;
    if( !empty($to) && (empty($multi) || $multi == 'user') ) {
      $multi = null;
      // Prepopulate user
      $toUser = Engine_Api::_()->getItem('user', $to);
      $isMsgable = ( 'friends' != Engine_Api::_()->authorization()->getPermission($viewer, 'messages', 'auth') ||
          $viewer->membership()->isMember($toUser) );
      if( $toUser instanceof User_Model_User &&
          (!$viewer->isBlockedBy($toUser) && !$toUser->isBlockedBy($viewer)) &&
          isset($toUser->user_id) &&
          $isMsgable ) {
        $this->view->toObject = $toObject = $toUser;
        $form->toValues->setValue($toUser->getGuid());
        $isPopulated = true;
      } else {
        $multi = null;
        $to = null;
      }
    } else if( !empty($to) && !empty($multi) ) {
      // Prepopulate group/event/etc
      $item = Engine_Api::_()->getItem($multi, $to);
      // Potential point of failure if primary key column is something other
      // than $multi . '_id'
      $item_id = $multi . '_id';
      if( $item instanceof Core_Model_Item_Abstract &&
          isset($item->$item_id) && (
            $item->isOwner($viewer) ||
            $item->authorization()->isAllowed($viewer, 'edit')
          )) {
        $this->view->toObject = $toObject = $item;
        $form->toValues->setValue($item->getGuid());
        $isPopulated = true;
      } else {
        $multi = null;
        $to = null;
      }
    }
    $this->view->isPopulated = $isPopulated;

    // Build normal
    if( !$isPopulated ) {
      // Apparently this is using AJAX now?
//      $friends = $viewer->membership()->getMembers();
//      $data = array();
//      foreach( $friends as $friend ) {
//        $data[] = array(
//          'label' => $friend->getTitle(),
//          'id' => $friend->getIdentity(),
//          'photo' => $this->view->itemPhoto($friend, 'thumb.icon'),
//        );
//      }
//      $this->view->friends = Zend_Json::encode($data);
    }
    
    // Assign the composing stuff
    $composePartials = array();
    foreach( Zend_Registry::get('Engine_Manifest') as $data ) {
      if( empty($data['composer']) ) {
        continue;
      }
      foreach( $data['composer'] as $type => $config ) {
        // is the current user has "create" privileges for the current plugin
        $isAllowed = Engine_Api::_()
            ->authorization()
            ->isAllowed($config['auth'][0], null, $config['auth'][1]);
            
        if( !empty($config['auth']) && !$isAllowed ) {
          continue;
        }
        $composePartials[] = $config['script'];
      }
    }
    $this->view->composePartials = $composePartials;
    // $this->view->composePartials = $composePartials;

    // Get config
    $this->view->maxRecipients = $maxRecipients = 10;


    // Check method/data
    if( !$this->getRequest()->isPost() ) {
      return;
    }

    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }

    // Process
    $db = Engine_Api::_()->getDbtable('messages', 'messages')->getAdapter();
    $db->beginTransaction();

    try {
      // Try attachment getting stuff
      $attachment = null;
      $attachmentData = $this->getRequest()->getParam('attachment');
      if( !empty($attachmentData) && !empty($attachmentData['type']) ) {
        $type = $attachmentData['type'];
        $config = null;
        foreach( Zend_Registry::get('Engine_Manifest') as $data )
        {
          if( !empty($data['composer'][$type]) )
          {
            $config = $data['composer'][$type];
          }
        }
        if( $config ) {
          $plugin = Engine_Api::_()->loadClass($config['plugin']);
          $method = 'onAttach'.ucfirst($type);
          $attachment = $plugin->$method($attachmentData);
          $parent = $attachment->getParent();
          if($parent->getType() === 'user'){
            $attachment->search = 0;
            $attachment->save();
          }
          else {
            $parent->search = 0;
            $parent->save();
          }
        }
      }
      
      $viewer = Engine_Api::_()->user()->getViewer();
      $values = $form->getValues();

      // Prepopulated
      if( $toObject instanceof User_Model_User ) {
        $recipientsUsers = array($toObject);
        $recipients = $toObject;
        // Validate friends
        if( 'friends' == Engine_Api::_()->authorization()->getPermission($viewer, 'messages', 'auth') ) {
          if( !$viewer->membership()->isMember($recipients) ) {
            return $form->addError('One of the members specified is not in your friends list.');
          }
        }
        
      } else if( $toObject instanceof Core_Model_Item_Abstract &&
          method_exists($toObject, 'membership') ) {
        $recipientsUsers = $toObject->membership()->getMembers();
//        $recipients = array();
//        foreach( $recipientsUsers as $recipientsUser ) {
//          $recipients[] = $recipientsUser->getIdentity();
//        }
        $recipients = $toObject;
      }
      // Normal
      else {
        $recipients = preg_split('/[,. ]+/', $values['toValues']);
        // clean the recipients for repeating ids
        // this can happen if recipient is selected and then a friend list is selected
        $recipients = array_unique($recipients);
        // Slice down to 10
        $recipients = array_slice($recipients, 0, $maxRecipients);
        // Get user objects
        $recipientsUsers = Engine_Api::_()->getItemMulti('user', $recipients);
        // Validate friends
        if( 'friends' == Engine_Api::_()->authorization()->getPermission($viewer, 'messages', 'auth') ) {
          foreach( $recipientsUsers as &$recipientUser ) {
            if( !$viewer->membership()->isMember($recipientUser) ) {
              return $form->addError('One of the members specified is not in your friends list.');
            }
          }
        }
      }

      // Create conversation
      $conversation = Engine_Api::_()->getItemTable('messages_conversation')->send(
        $viewer,
        $recipients,
        $values['title'],
        $values['body'],
        $attachment
      );

      // Send notifications
      foreach( $recipientsUsers as $user ) {
        if( $user->getIdentity() == $viewer->getIdentity() ) {
          continue;
        }
        Engine_Api::_()->getDbtable('notifications', 'activity')->addNotification(
          $user,
          $viewer,
          $conversation,
          'message_new'
        );
      }

      // Increment messages counter
      Engine_Api::_()->getDbtable('statistics', 'core')->increment('messages.creations');

      // Commit
      $db->commit();
    } catch( Exception $e ) {
      $db->rollBack();
      throw $e;
    }
    
    if( $this->getRequest()->getParam('format') == 'smoothbox' ) {
      return $this->_forward('success', 'utility', 'core', array(
        'messages' => array(Zend_Registry::get('Zend_Translate')->_('Your message has been sent successfully.')),
        'smoothboxClose' => true,
      ));
    } else {
      return $this->_forward('success', 'utility', 'core', array(
        'messages' => array(Zend_Registry::get('Zend_Translate')->_('Your message has been sent successfully.')),
        'redirect' => $conversation->getHref(), //$this->getFrontController()->getRouter()->assemble(array('action' => 'inbox'))
      ));
    }
  }
  
  public function successAction()
  {
    
  }

  public function deleteAction()
  {
    if( !$this->_helper->requireUser()->isValid() ) return;
    
    $message_ids = $this->view->message_ids = $this->getRequest()->getParam('message_ids');
    $messages = explode(',', $message_ids);

    $place = $this->view->place = $this->getRequest()->getParam('place');
    
    if (!$this->getRequest()->isPost())
      return;
    
    // In smoothbox
    $this->_helper->layout->setLayout('default-simple');

    $viewer_id = Engine_Api::_()->user()->getViewer()->getIdentity();
    $this->view->deleted_conversation_ids = array();
    
    $db = Engine_Api::_()->getDbtable('messages', 'messages')->getAdapter();
    $db->beginTransaction();
    try {
      foreach ($messages as $message_id) {
        $recipients = Engine_Api::_()->getItem('messages_conversation', $message_id)->getRecipientsInfo();
        //$recipients = Engine_Api::_()->getApi('core', 'messages')->getConversationRecipientsInfo($message_id);
        foreach ($recipients as $r) {
          if ($viewer_id == $r->user_id) {
            $this->view->deleted_conversation_ids[] = $r->conversation_id;
            $r->inbox_deleted  = true;
            $r->outbox_deleted = true;
            $r->save();
          }
        }
      }
      $db->commit();
    } catch (Exception $e) {
      $db->rollback();
      throw $e;
    }

    $this->view->status = true;
    $this->view->message = Zend_Registry::get('Zend_Translate')->_('The selected messages have been deleted.');
    
    if ($place != 'view') {
      return $this->_forward('success' ,'utility', 'core', array(
        'smoothboxClose' => true,
        'format'=> 'smoothbox',
        'parentRefresh' => true,        
        'messages' => Array($this->view->message)
      ));
    }
    else {
    
      return $this->_forward('success' ,'utility', 'core', array(
        'smoothboxClose' => true,
        'format'=> 'smoothbox',
        'parentRedirect' => Zend_Controller_Front::getInstance()->getRouter()->assemble(array('action' => 'inbox')),        
        'messages' => Array($this->view->message)
      ));
    }
  }
  
  public function searchAction()
  {
    $this->view->isSearchPage = true;
    $this->view->queryStr = $queryStr =  $this->getRequest()->getParam('query');
    
    $viewer = Engine_Api::_()->user()->getViewer();
    
    $table = Engine_Api::_()->getDbtable('messages', 'messages');
    $query = $table->select()
        ->from('engine4_messages_messages')
        ->joinRight('engine4_messages_recipients', 'engine4_messages_recipients.conversation_id = engine4_messages_messages.conversation_id', null)
        //->joinRight('engine4_messages_messages', 'engine4_messages_messages.conversation_id=engine4_messages_recipients.conversation_id', null)
        ->where('engine4_messages_recipients.user_id = ?', $viewer->user_id)
        ->where('(engine4_messages_messages.title LIKE ? || engine4_messages_messages.body LIKE ?)', '%' . $queryStr . '%')
        ->order('engine4_messages_messages.message_id DESC')
        ;
        
    $paginatorAdapter = new Zend_Paginator_Adapter_DbTableSelect($query);
    $paginator = new Zend_Paginator($paginatorAdapter);
    $this->view->paginator = $paginator;
    $paginator->setCurrentPageNumber($this->_getParam('page'));
    
    // Render
    $this->_helper->content
        //->setNoRender()
        ->setEnabled()
        ;
  }

  public function uploadPhotoAction()
  {
    $viewer = Engine_Api::_()->user()->getViewer();

    $this->_helper->layout->disableLayout();

    if( !Engine_Api::_()->authorization()->isAllowed('album', $viewer, 'create') ) {
      return false;
    }

    if( !$this->_helper->requireAuth()->setAuthParams('album', null, 'create')->isValid() ) return;

    if( !$this->_helper->requireUser()->checkRequire() )
    {
      $this->view->status = false;
      $this->view->error = Zend_Registry::get('Zend_Translate')->_('Max file size limit exceeded (probably).');
      return;
    }

    if( !$this->getRequest()->isPost() )
    {
      $this->view->status = false;
      $this->view->error = Zend_Registry::get('Zend_Translate')->_('Invalid request method');
      return;
    }
    if( !isset($_FILES['userfile']) || !is_uploaded_file($_FILES['userfile']['tmp_name']) )
    {
      $this->view->status = false;
      $this->view->error = Zend_Registry::get('Zend_Translate')->_('Invalid Upload');
      return;
    }

    $db = Engine_Api::_()->getDbtable('photos', 'album')->getAdapter();
    $db->beginTransaction();

    try
    {
      $viewer = Engine_Api::_()->user()->getViewer();

      $photoTable = Engine_Api::_()->getDbtable('photos', 'album');
      $photo = $photoTable->createRow();
      $photo->setFromArray(array(
        'owner_type' => 'user',
        'owner_id' => $viewer->getIdentity()
      ));
      $photo->save();

      $photo->setPhoto($_FILES['userfile']);

      $this->view->status = true;
      $this->view->name = $_FILES['userfile']['name'];
      $this->view->photo_id = $photo->photo_id;
      $this->view->photo_url = $photo->getPhotoUrl();

      $table = Engine_Api::_()->getDbtable('albums', 'album');
      $album = $table->getSpecialAlbum($viewer, 'message');

      $photo->album_id = $album->album_id;
      $photo->save();

      if( !$album->photo_id )
      {
        $album->photo_id = $photo->getIdentity();
        $album->save();
      }

      $auth      = Engine_Api::_()->authorization()->context;
      $auth->setAllowed($photo, 'everyone', 'view',    true);
      $auth->setAllowed($photo, 'everyone', 'comment', true);
      $auth->setAllowed($album, 'everyone', 'view',    true);
      $auth->setAllowed($album, 'everyone', 'comment', true);


      $db->commit();

    } catch( Album_Model_Exception $e ) {
      $db->rollBack();
      $this->view->status = false;
      $this->view->error = $this->view->translate($e->getMessage());
      throw $e;
      return;

    } catch( Exception $e ) {
      $db->rollBack();
      $this->view->status = false;
      $this->view->error = Zend_Registry::get('Zend_Translate')->_('An error occurred.');
      throw $e;
      return;
    }
  }
}