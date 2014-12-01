<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: view.tpl 10166 2014-04-14 16:59:00Z lucas $
 * @author     Sami
 */
?>

<?php
  $this->headScript()
    ->appendFile($this->layout()->staticBaseUrl . 'externals/moolasso/Lasso.js')
    ->appendFile($this->layout()->staticBaseUrl . 'externals/moolasso/Lasso.Crop.js');

  if (APPLICATION_ENV == 'production')
    $this->headScript()
      ->appendFile($this->layout()->staticBaseUrl . 'externals/autocompleter/Autocompleter.min.js');
  else
    $this->headScript()
      ->appendFile($this->layout()->staticBaseUrl . 'externals/autocompleter/Observer.js')
      ->appendFile($this->layout()->staticBaseUrl . 'externals/autocompleter/Autocompleter.js')
      ->appendFile($this->layout()->staticBaseUrl . 'externals/autocompleter/Autocompleter.Local.js')
      ->appendFile($this->layout()->staticBaseUrl . 'externals/autocompleter/Autocompleter.Request.js');

  $this->headScript()
    ->appendFile($this->layout()->staticBaseUrl . 'externals/tagger/tagger.js');
  $this->headTranslate(array(
    'Save', 'Cancel', 'delete',
  ));
?>

<script type="text/javascript">
  var taggerInstance;
  en4.core.runonce.add(function() {
    taggerInstance = new Tagger('media_photo_next', {
      'title' : '<?php echo $this->translate('ADD TAG');?>',
      'description' : '<?php echo $this->translate('Type a tag or select a name from the list.');?>',
      'createRequestOptions' : {
        'url' : '<?php echo $this->url(array('module' => 'core', 'controller' => 'tag', 'action' => 'add'), 'default', true) ?>',
        'data' : {
          'subject' : '<?php echo $this->subject()->getGuid() ?>'
        }
      },
      'deleteRequestOptions' : {
        'url' : '<?php echo $this->url(array('module' => 'core', 'controller' => 'tag', 'action' => 'remove'), 'default', true) ?>',
        'data' : {
          'subject' : '<?php echo $this->subject()->getGuid() ?>'
        }
      },
      'cropOptions' : {
        'container' : $('media_photo_next')
      },
      'tagListElement' : 'media_tags',
      'existingTags' : <?php echo $this->action('retrieve', 'tag', 'core', array('sendNow' => false)) ?>,
      'suggestProto' : 'request.json',
      'suggestParam' : '<?php echo $this->url(array('module' => 'user', 'controller' => 'friends', 'action' => 'suggest', 'includeSelf' => true), 'default', true) ?>',
      'guid' : <?php echo ( $this->viewer()->getIdentity() ? "'".$this->viewer()->getGuid()."'" : 'false' ) ?>,
      'enableCreate' : <?php echo ( $this->canEdit ? 'true' : 'false') ?>,
      'enableDelete' : <?php echo ( $this->canEdit ? 'true' : 'false') ?>
    });

    // Remove the href attrib while tagging
    var nextHref = $('media_photo_next').get('href');
    taggerInstance.addEvents({
      'onBegin' : function() {
        $('media_photo_next').erase('href');
      },
      'onEnd' : function() {
        $('media_photo_next').set('href', nextHref);
      }
    });
    
  });
</script>


<h2>
  <?php echo $this->event->__toString(); ?>
  <?php echo $this->translate('&#187;'); ?>
  <?php echo $this->htmlLink(array(
          'route' => 'event_extended',
          'controller' => 'photo',
          'action' => 'list',
          'subject' => $this->event->getGuid(),
      ), $this->translate('Photos')) ?>
</h2>

<div class='layout_middle'>
<div class='event_photo_view'>
  <div class="event_photo_nav">
    <div>
      <?php echo $this->translate('Photo');?> <?php echo $this->photo->getCollectionIndex() + 1 ?>
      <?php echo $this->translate('of');?> <?php echo $this->album->count() ?>
    </div>
    <div>
      <?php if ($this->album->count() > 1): ?>
        <?php echo $this->htmlLink($this->photo->getPrevCollectible()->getHref(), $this->translate('Prev')) ?>
        <?php echo $this->htmlLink($this->photo->getNextCollectible()->getHref(), $this->translate('Next')) ?>
      <?php else: ?>
        &nbsp;
      <?php endif; ?>
    </div>
  </div>
  <div class='event_photo_info'>
    <div class='event_photo_container' id='media_photo_div'>
      <a id='media_photo_next'  href='<?php echo $this->photo->getNextCollectible()->getHref() ?>'>
        <?php echo $this->htmlImage($this->photo->getPhotoUrl(), $this->photo->getTitle(), array(
          'id' => 'media_photo'
        )); ?>
      </a>
    </div>
    <br />
    <a></a>
    <?php if( $this->photo->getTitle() ): ?>
      <div class="event_photo_title">
        <?php echo $this->photo->getTitle(); ?>
      </div>
    <?php endif; ?>
    <?php if( $this->photo->getDescription() ): ?>
      <div class="event_photo_description">
        <?php echo $this->photo->getDescription() ?>
      </div>
    <?php endif; ?>
    <div class="event_photo_owner">
      <?php echo $this->translate('By')?> <?php echo $this->htmlLink($this->photo->getOwner()->getHref(), $this->photo->getOwner()->getTitle()) ?>
    </div>
    <div class="event_photo_tags" id="media_tags" class="tag_list" style="display: none;">
      <?php echo $this->translate('Tagged:')?>
    </div>
    <div class="event_photo_date">
      <?php echo $this->translate('Added');?> <?php echo $this->timestamp($this->photo->creation_date) ?>
      <?php if( $this->canEdit): ?>
        - <a href='javascript:void(0);' onclick='taggerInstance.begin();'><?php echo $this->translate('Add Tag');?></a>
        - <?php echo $this->htmlLink(array('route' => 'event_extended', 'controller' => 'photo', 'action' => 'edit', 'photo_id' => $this->photo->getIdentity(), 'format' => 'smoothbox'), $this->translate('Edit'), array('class' => 'smoothbox')) ?>
        - <?php echo $this->htmlLink(array('route' => 'event_extended', 'controller' => 'photo', 'action' => 'delete', 'photo_id' => $this->photo->getIdentity(), 'format' => 'smoothbox'), $this->translate('Delete'), array('class' => 'smoothbox')) ?>
      <?php endif; ?>
      - <?php echo $this->htmlLink(Array('module'=>'activity', 'controller'=>'index', 'action'=>'share', 'route'=>'default', 'type'=>$this->photo->getType(), 'id'=>$this->photo->getIdentity(), 'format' => 'smoothbox'), $this->translate("Share"), array('class' => 'smoothbox')); ?>
      - <?php echo $this->htmlLink(Array('module'=>'core', 'controller'=>'report', 'action'=>'create', 'route'=>'default', 'subject'=>$this->photo->getGuid(), 'format' => 'smoothbox'), $this->translate("Report"), array('class' => 'smoothbox')); ?>
      - <?php echo $this->htmlLink(array('route' => 'user_extended', 'module' => 'user', 'controller' => 'edit', 'action' => 'external-photo', 'photo' => $this->photo->getGuid(), 'format' => 'smoothbox'), $this->translate('Make Profile Photo'), array('class' => 'smoothbox')) ?>
    </div>
  </div>

  <?php echo $this->action("list", "comment", "core", array("type"=>"event_photo", "id"=>$this->photo->getIdentity())); ?>
</div>
</div>