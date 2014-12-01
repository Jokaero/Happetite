<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: fields.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */
?>

<?php
  /* Include the common user-end field switching javascript */
  echo $this->partial('_jsSwitch.tpl', 'fields', array(
    'topLevelId' => $this->form->getTopLevelId(),
    'topLevelValue' => $this->form->getTopLevelValue(),
  ));
?>

<?php echo $this->form->render($this) ?>
