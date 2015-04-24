<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Album
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Controller.php 9791 2012-09-28 20:41:41Z pamela $
 * @author     Sami
 */

/**
 * @category   Application_Extensions
 * @package    Album
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Album_Widget_ListRecentPhotosController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    // Should we consider creation or modified recent?
    $recentType = $this->_getParam('recentType', 'creation');
    if( !in_array($recentType, array('creation', 'modified')) ) {
      $recentType = 'creation';
    }
    $this->view->recentType = $recentType;
    $this->view->recentCol = $recentCol = $recentType . '_date';
    
    // Get paginator
    $parentTable = Engine_Api::_()->getItemTable('album');
    $parentTableName = $parentTable->info('name');
    $table = Engine_Api::_()->getItemTable('album_photo');
    $tableName = $table->info('name');
    $select = $table->select()
      ->from($tableName)
      ->joinLeft($parentTableName, $parentTableName . '.album_id=' . $tableName . '.album_id', null)
      ->where($parentTableName . '.search = ?', true);
    if( $recentType == 'creation' ) {
      // using primary should be much faster, so use that for creation
      $select->order('photo_id DESC');
    } else {
      $select->order($table->info('name') . '.' . $recentCol . ' DESC');
    }

    // Create new array filtering out private photos
    $viewer = Engine_Api::_()->user()->getViewer();
    $photo_select = $select;
    $new_select = array();
    $i = 0;
    foreach($photo_select->getTable()->fetchAll($photo_select) as $photo )  {
      if (Engine_Api::_()->authorization()->isAllowed($photo, $viewer, 'view')){
        $new_select[$i++] = $photo;
      }
    }
    
    $this->view->paginator = $paginator = Zend_Paginator::factory($new_select);

    // Set item count per page and current page number
    $paginator->setItemCountPerPage($this->_getParam('itemCountPerPage', 4));
    $paginator->setCurrentPageNumber($this->_getParam('page', 1));

    // Do not render if nothing to show
    if( $paginator->getTotalItemCount() <= 0 ) {
      return $this->setNoRender();
    }
  }
}