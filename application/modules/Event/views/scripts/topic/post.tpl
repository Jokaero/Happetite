<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: post.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     Sami
 */
?>

<h2>
  <?php echo $this->event->__toString()." ".$this->translate("&#187; Discussions") ?>
</h2>

<h3>
  <?php echo $this->topic->__toString() ?>
</h3>

<br />

<?php if( $this->message ) echo $this->message ?>

<?php if( $this->form ) echo $this->form->render($this) ?>