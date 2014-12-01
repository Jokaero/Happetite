<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: index.tpl 9981 2013-03-19 22:17:08Z john $
 * @access	   John
 */
?>

<?php if( $this->paginator->count() > 1 || $this->canUpload ): ?>
  <div class="event_album_options">
    <?php if( $this->paginator->count() > 1 ): ?>
      <?php echo $this->htmlLink(array(
          'route' => 'event_extended',
          'controller' => 'photo',
          'action' => 'list',
          'subject' => $this->subject()->getGuid(),
        ), $this->translate('View All Photos'), array(
          'class' => 'buttonlink icon_event_photo_view'
      )) ?>
    <?php endif; ?>
    
    <?php if( $this->canUpload ): ?>
      <?php echo $this->htmlLink(array(
          'route' => 'event_extended',
          'controller' => 'photo',
          'action' => 'upload',
          'subject' => $this->subject()->getGuid(),
        ), $this->translate('Upload Photos'), array(
          'class' => 'buttonlink icon_event_photo_new'
      )) ?>
    <?php endif; ?>
  </div>
  <br />
<?php endif; ?>

<?php if( $this->paginator->getTotalItemCount() > 0 ): ?>

  <ul class="thumbs">
    <?php foreach( $this->paginator as $photo ): ?>
      <li>
        <a class="thumbs_photo" href="<?php echo $photo->getHref(); ?>">
          <span style="background-image: url(<?php echo $photo->getPhotoUrl('thumb.normal'); ?>);"></span>
        </a>
        <p class="thumbs_info">
          <?php echo $this->translate('By');?>
          <?php echo $this->htmlLink($photo->getOwner()->getHref(), $photo->getOwner()->getTitle(), array('class' => 'thumbs_author')) ?>
          <br />
          <?php echo $this->timestamp($photo->creation_date) ?>
        </p>
      </li>
    <?php endforeach;?>
  </ul>

<?php else: ?>

  <div class="tip">
    <span>
      <?php echo $this->translate('No photos have been uploaded to this event yet.');?>
    </span>
  </div>

<?php endif; ?>