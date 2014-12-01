<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: invite.tpl 9747 2012-07-26 02:08:08Z john $
 * @access	   Sami
 */
?>
<?php if( $this->count > 0 ): ?>
  <script type="text/javascript">
    en4.core.runonce.add(function(){
      $('selectall').addEvent('click', function(event) {
        var el = $(event.target);
        $$('input[type=checkbox]').set('checked', el.get('checked'));
      });
    });
  </script>

  <?php echo $this->form->setAttrib('class', 'global_form_popup')->render($this) ?>
<?php else: ?>
  <div>
    <?php echo $this->translate('You have no friends you can invite.');?>
    <?php echo $this->htmlLink('javascript:void(0);', $this->translate('Close'), array('onclick' => 'parent.Smoothbox.close();')) ?>
  </div>
<?php endif; ?>