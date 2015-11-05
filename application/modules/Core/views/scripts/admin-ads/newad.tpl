<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: newad.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     Jung
 */
?>
<script type="text/javascript">

var updateTextFields = function(media_element)
{

  var file_element = document.getElementById("upload_image-wrapper");
  var insert_element = document.getElementById("html_code-wrapper");
  var submit_element = document.getElementById("submit-wrapper");

  file_element.style.display = "none";
  insert_element.style.display = "none";
  submit_element.style.display = "none";


  if (media_element.value == 0)
  {
    file_element.style.display = "block";
    insert_element.style.display = "none";
    return;
  }

  if (media_element.value == 1)
  {
    file_element.style.display = "none";
    insert_element.style.display = "block";
    return;
  }

}

var preview = function (){
  alert("this is preview");
}

en4.core.runonce.add(updateTextFields);

</script>

<div class='settings'>
  <?php echo $this->form->render($this); ?>
</div>