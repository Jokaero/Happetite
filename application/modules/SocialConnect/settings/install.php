<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    SocialConnect
 * @copyright  Younet
 * @license    http://www.socialengine.net/license/
 * @version    $Id: Bootstrap.php 7244 2010-09-28 01:49:53Z son $
 * @author     MinhNC
 */

/**
 * @category   Application_Extensions
 * @package    SocialConnect
 * @copyright  Younet
 * @license    http://www.socialengine.net/license/
 */
class SocialConnect_Installer extends Engine_Package_Installer_Module
{
	function onInstall()
	{
		// member homepage
		$db     = $this->getDb();
		$select = new Zend_Db_Select($db);
		$select -> from('engine4_core_pages') -> where('name = ?', 'user_index_home') -> limit(1);
		$page_id = $select -> query() -> fetchObject() -> page_id;

		// Check if it's already been placed
		$select = new Zend_Db_Select($db);
		$select -> from('engine4_core_content') -> where('page_id = ?', $page_id) -> where('type = ?', 'widget') -> where('name = ?', 'social-connect.call-popup-invite');

		$info = $select -> query() -> fetch();
		if (empty($info))
		{
			// container_id (will always be there)
			$select = new Zend_Db_Select($db);
			$select -> from('engine4_core_content') -> where('page_id = ?', $page_id) -> where('type = ?', 'container') -> limit(1);

			$container_id = $select -> query() -> fetchObject() -> content_id;

			// middle_id (will always be there)
			$select = new Zend_Db_Select($db);
			$select -> from('engine4_core_content') -> where('parent_content_id = ?', $container_id) -> where('type = ?', 'container') -> where('name = ?', 'middle') -> limit(1);
			$middle_id = $select -> query() -> fetchObject() -> content_id;

			// tab on profile
			$db -> insert('engine4_core_content', array(
				'page_id' => $page_id,
				'type' => 'widget',
				'name' => 'social-connect.call-popup-invite',
				'parent_content_id' => $middle_id,
				'params' => '',
				'order' => 999,
			));
		}
		parent::onInstall();
	}
}
?>