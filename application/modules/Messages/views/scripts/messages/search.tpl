<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Messages
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: search.tpl 10009 2013-03-26 23:25:57Z jung $
 * @author     John
 */
?>

<div>
  <?php echo $this->translate(array('%1$s message match your search', '%1$s messages match your search', $this->paginator->getTotalItemCount()),
                              $this->locale()->toNumber($this->paginator->getTotalItemCount())) ?>
  <form action="messages/search" method="GET" style="float: right;">
    <input type="text" placeholder="Search" name="query" value="<?php echo htmlspecialchars(!empty($this->queryStr) ? $this->queryStr : '', ENT_QUOTES, 'UTF-8') ?>"  />
  </form>
</div>
<br />

<?php if( $this->paginator->getTotalItemCount() <= 0 ): ?>
  <div class="tip">
    <span>
      <?php echo $this->translate('No results'); ?>
    </span>
  </div>
  <br />
<?php endif; ?>

<?php if( count($this->paginator) ): ?>
  <div class="messages_list">
    <ul>
      <?php foreach( $this->paginator as $message ):       
        $conversation = Engine_Api::_()->getItem('messages_conversation', $message->conversation_id);

        $recipient = $conversation->getRecipientInfo($this->viewer());
        $resource = "";
        $sender   = "";
        if( $conversation->hasResource() &&
                  ($resource = $conversation->getResource()) ) {
          $sender = $resource;
        } else if( $conversation->recipients > 1 ) {
          $sender = $this->viewer();
        } else {
          foreach( $conversation->getRecipients() as $tmpUser ) {
            if( $tmpUser->getIdentity() != $this->viewer()->getIdentity() ) {
              $sender = $tmpUser;
            }
          }
        }
        if( (!isset($sender) || !$sender) && $this->viewer()->getIdentity() !== $conversation->user_id ){
          $sender = Engine_Api::_()->user()->getUser($conversation->user_id);
        }
        if( !isset($sender) || !$sender ) {
          //continue;
          $sender = new User_Model_User(array());
        }
        ?>
        <li<?php if( !$recipient->inbox_read ): ?> class='messages_list_new'<?php endif; ?> id="message_conversation_<?php echo $conversation->conversation_id ?>">
          <!-- div class="messages_list_checkbox">
            <input class="checkbox" type="checkbox" value="<?php echo $conversation->conversation_id ?>" />
          </div -->
          <div class="messages_list_photo">
            <?php echo $this->htmlLink($sender->getHref(), $this->itemPhoto($sender, 'thumb.icon')) ?>
          </div>
          <div class="messages_list_from">
            <p class="messages_list_from_name">
              <?php if( !empty($resource) ): ?>
                <?php echo $resource->toString() ?>
              <?php elseif( $conversation->recipients == 1 ): ?>
                <?php echo $this->htmlLink($sender->getHref(), $sender->getTitle()) ?>
              <?php else: ?>
                <?php echo $this->translate(array('%s person', '%s people', $conversation->recipients),
                    $this->locale()->toNumber($conversation->recipients)) ?>
              <?php endif; ?>
            </p>
            <p class="messages_list_from_date">
              <?php echo $this->timestamp($message->date) ?>
            </p>
            </div>
            <div class="messages_list_info">
              <p class="messages_list_info_title">
                <?php
                  ! isset($conversation) && '' != ($title = trim($conversation->getTitle())) ||
                  ! ( isset($message) && '' != ($title = trim($message->getTitle())) ||
                  $title = '<em>' . $this->translate('(No Subject)') . '</em>' );
                ?>
                <?php echo $this->htmlLink($conversation->getHref(), $title) ?>
            </p>
            <p class="messages_list_info_body">
              <?php echo html_entity_decode($message->body) ?>
            </p>
          </div>
        </li>
      <?php endforeach; ?>
    </ul>
  </div>

  <!--
  <br />

  <button id="delete"><?php echo $this->translate('Delete Selected') ?></button>
  <script type="text/javascript">
  $('checkall').addEvent('click', function() {
    var hasUnchecked = false;
    $$('.messages_list input[type="checkbox"]').each(function(el) {
      if( !el.get('checked') ) {
        hasUnchecked = true;
      }
    });
    $$('.messages_list input[type="checkbox"]').set('checked', hasUnchecked);
  });
  $('delete').addEvent('click', function(){
    var selected_ids = new Array();
    $$('div.messages_list input[type=checkbox]').each(function(cBox) {
      if (cBox.checked)
        selected_ids[ selected_ids.length ] = cBox.value;
    });
    var sb_url = '<?php echo $this->url(array('action'=>'delete'), 'messages_general', true) ?>?place=inbox&message_ids='+selected_ids.join(',');
    if (selected_ids.length > 0)
      Smoothbox.open(sb_url);
  });
  </script>
  <br />
  <br />
  -->
<?php endif; ?>

<?php echo $this->paginationControl($this->paginator); ?>
