<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: index.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */
?>

<h2>
  <?php echo ( $this->title ? $this->translate($this->title) : '' ) ?>
</h2>

<script type="text/javascript">
  function skipForm() {
    document.getElementById("skip").value = "skipForm";
    $('SignupForm').submit();
  }
  function finishForm() {
    document.getElementById("nextStep").value = "finish";
  }
</script>

<?php echo $this->partial($this->script[0], $this->script[1], array(
  'form' => $this->form
)) ?>
