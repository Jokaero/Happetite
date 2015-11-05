<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: PageLinks.php 9747 2012-07-26 02:08:08Z john $
 * @author     Sami
 */

/**
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Core_View_Helper_PageLinks extends Engine_View_Helper_HtmlLink
{
  public function pageLinks($href, $itemCountPerPage = 10, $pageCount = null,
    $spanClass = 'pagelinks')
  {
      
    if( ($href instanceof Core_Model_Item_Abstract) ) {
      if( method_exists($href, 'getLastPage') ) {
        $pageCount = $href->getLastPage($itemCountPerPage);
      }
    }
    if( !is_array($href) && !($href instanceof Core_Model_Item_Abstract) ) {
      return '';
    }
    if( $pageCount <= 1 ) {
      return '';
    }

    $pageCount = (int) $pageCount;
    $pages = array_flip(array(1, 2, 3, $pageCount - 2, $pageCount - 1, $pageCount));
    $content = '';
    foreach( $pages as $pageIndex => $null ) {
      if( $pageIndex < 1 || $pageIndex > $pageCount ) {
        continue;
      }
      if( ($href instanceof Core_Model_Item_Abstract) ) {
        $content .= $this->htmlLink($href->getHref(array('page' => $pageIndex)), $pageIndex);
      } else {
        $href['page'] = $pageIndex;
        $content .= $this->htmlLink($href['page'], $pageIndex);
      }
      $content .= ' ';
      if( $pageIndex == 3 && $pageCount > 6 ) {
        $content .= '...';
      }
    }

    if( '' !== $content ) {
      $content = '<span class="' . $this->view->escape($spanClass) . '">'
          . $content
          . '</span>';
    }

    return $content;
  }
}