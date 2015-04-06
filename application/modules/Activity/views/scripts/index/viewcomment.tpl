<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Activity
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: viewcomment.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     Steve
 */
/**
 * This view script is only visible when using captcha on the comment form.
 */
?>

<?php if( !isset($this->form) ) return; ?>


<?php echo $this->translate("Comment:") ?>
<?php echo $this->form->render($this) ?>

<script type="text/javascript">
//<![CDATA[
document.getElementsByTagName('form')[0].style.display = 'block';
//]]>
</script>
