<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Network
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: search.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     Sami
 * @author     John
 */
?>

<div class='clear'>
    <div class='form box admin_search'>
      <form action="<?php echo $this->url(array('action' => 'index')) ?> ">
      <div>
        <input type='text' class='text' name='search'>
      </div>
      <div>      
        <div class='buttons'>
          <button type='submit'><?php echo $this->translate("Search") ?></button>
        </div>
      </div>
      </form>
    </div>
  </div>
