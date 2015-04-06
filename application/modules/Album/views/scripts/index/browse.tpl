<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Album
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: browse.tpl 10217 2014-05-15 13:41:15Z lucas $
 * @author     Sami
 */
?>

  <?php if( $this->paginator->getTotalItemCount() > 0 ): ?>

    <ul class="thumbs">
      <?php foreach( $this->paginator as $album ): ?>
        <li>
          <a class="thumbs_photo" href="<?php echo $album->getHref(); ?>">
            <span style="background-image: url(<?php echo $album->getPhotoUrl('thumb.normal'); ?>);"></span>
          </a>
          <p class="thumbs_info">
            <span class="thumbs_title">
              <?php echo $this->htmlLink($album, $this->string()->chunk($this->string()->truncate($album->getTitle(), 45), 10)) ?>
            </span>
            <?php echo $this->translate('By');?>
            <?php echo $this->htmlLink($album->getOwner()->getHref(), $album->getOwner()->getTitle(), array('class' => 'thumbs_author')) ?>
            <br />
            <?php echo $this->translate(array('%s photo', '%s photos', $album->count()),$this->locale()->toNumber($album->count())) ?>
          </p>
        </li>
      <?php endforeach;?>
    </ul>

    <?php if( $this->paginator->count() > 1 ): ?>
      <br />
      <?php echo $this->paginationControl(
        $this->paginator, null, null, array(
          'pageAsQuery' => false,
          'query' => $this->searchParams
          )); ?>
    <?php endif; ?>
  
    <?php elseif( $this->searchParams['category_id'] ): ?>
    <div class="tip">
      <span id="no-album-criteria">
        <?php echo $this->translate('Nobody has created an album with that criteria.');?>
        <?php if( $this->canCreate ): ?>
          <?php $create = $this->translate('Be the first to %1$screate%2$s one!', 
                          '<a href="'.$this->url(array('action' => 'upload')).'">', '</a>'); 
          ?>
          <script type="text/javascript">
            if(!DetectMobileQuick() && !DetectIpad()){
              var create = '<?php echo $create ?>';
              var text = document.getElementById('no-album-criteria');
              text.innerHTML = text.innerHTML + create ;
            }
          </script>
        <?php endif; ?>
      </span>
    </div>    
    
    <?php else: ?>
    <div class="tip">
      <span id="no-album">
        <?php echo $this->translate('Nobody has created an album yet.');?>
        <?php if( $this->canCreate ): ?>
          <?php 
           $create = $this->translate('Get started by %1$screating%2$s your first album!', 
                     '<a href="'.$this->url(array('action' => 'upload')).'">', '</a>');
          ?>
          <script type="text/javascript">
            if(!DetectMobileQuick() && !DetectIpad()){
              var create = '<?php echo $create ?>';
              var text = document.getElementById('no-album');
              text.innerHTML = text.innerHTML + create ;
            }
          </script>
        <?php endif; ?>
      </span>
    </div>
  <?php endif; ?>