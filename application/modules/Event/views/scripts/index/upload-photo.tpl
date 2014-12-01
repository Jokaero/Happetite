<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Blog
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id$
 * @author     Jung
 */
?>
﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<script language="javascript" type="text/javascript">
	window.parent.window.jbImagesDialog.uploadFinish({
		filename: '<?php echo $this->photo_url ?>',
		result: '<?php $this->status ? 'file_uploaded' : $this->error ?>',
		resultCode: '<?php $this->status ? 'ok' : 'failed' ?>'
	});
</script>
<style type="text/css">
	body {font-family: Courier, "Courier New", monospace; font-size:11px;}
</style>
</head>

<body>

Result: <?php $this->status ? 'file_uploaded' : $this->error ?>

</body>
</html>
