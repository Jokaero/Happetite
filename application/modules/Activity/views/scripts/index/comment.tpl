<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Activity
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: comment.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     Steve
 */
/**
 * This view script is only visible when using captcha on the comment form.
 */
?>
<p><?php echo $this->message ?></p>
<script type="text/javascript">
//<![CDATA[
parent.en4.activity.viewComments(<?php echo $this->action_id ?>);
parent.Smoothbox.close();
//]]>
</script>