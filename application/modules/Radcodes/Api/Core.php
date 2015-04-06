<?php

/**
 * Radcodes - SocialEngine Module
 *
 * @category   Application_Extensions
 * @package    Radcodes
 * @copyright  Copyright (c) 2009-2010 Radcodes LLC (http://www.radcodes.com)
 * @license    http://www.radcodes.com/license/
 * @version    $Id$
 * @author     Vincent Van <vincent@radcodes.com>
 */
 
class Radcodes_Api_Core extends Core_Api_Abstract
{
  public function serverToLocalTime($server_time, $user = null)
  {
    if (!($user instanceof User_Model_User))
    {
      $user = Engine_Api::_()->user()->getViewer();
    }    
    
    $end = strtotime($server_time);
    $oldTz = date_default_timezone_get();
    date_default_timezone_set($user->timezone);
    $local_time = date('Y-m-d H:i:s', $end);
    date_default_timezone_set($oldTz);
    
    return $local_time;
  }
  // serverToLocalTime
  
  public function filterEmptyParams($values)
  {
    foreach ($values as $key => $value)
    {
      if (is_array($value))
      {
        foreach ($value as $value_k => $value_v)
        {
          if (!strlen($value_v))
          {
            unset($value[$value_k]);
          }
        }
      }
      
      if (is_array($value) && count($value) == 0)
      {
        unset($values[$key]);
      }
      else if (!is_array($value) && !strlen($value))
      {
        unset($values[$key]);
      }
    }
    
    return $values;
  }
  // filterEmptyParams
  
	/**
	 * @param string $type
	 * @return Radcodes_Lib_Rest_Store
	 */
	public function getRest($type)
	{
		if (strtolower($type) == 'store')
		{
			$rest = new Radcodes_Lib_Rest_Store();
		}
		else {
		  $rest = new Radcodes_Lib_Rest();
		}
		return $rest;
	}
	
	public function varPrint($var, $name=null)
	{
		echo "<pre>";
		if ($name) echo "$name ::\n";
		print_r($var);
		echo "</pre>";
	}
	
	
  public function varClass($var, $name=null)
  {
    echo "<pre>";
    if ($name) echo "$name ::\n";
    echo get_class($var);
    echo "</pre>";
  }
	
  
  public function varDump($var, $name=null)
  {
    echo "<pre>";
    if ($name) echo "$name ::\n";
    var_dump($var);
    echo "</pre>";
  }
  
  public function getPopularTags($resource_type, $options=array())
  {
    $tag_table = Engine_Api::_()->getDbtable('tags', 'core');
    $tagmap_table = $tag_table->getMapTable();
    
    $tName = $tag_table->info('name');
    $tmName = $tagmap_table->info('name');
    
    if (isset($options['order']))
    {
      $order = $options['order'];
    }
    else
    {
    	$order = 'text';
    }
    
    if (isset($options['sort']))
    {
    	$sort = $options['sort'];
    }
    else
    {
    	$sort = $order == 'total' ? SORT_DESC : SORT_ASC;
    }
    
    $limit = isset($options['limit']) ? $options['limit'] : 50;
    
    $select = $tag_table->select()
        ->setIntegrityCheck(false)
        ->from($tmName, array('total' => "COUNT(*)"))
        ->join($tName, "$tName.tag_id = $tmName.tag_id")
        ->where('resource_type = ?', $resource_type)
        ->where('tag_type = ?', 'core_tag')
        ->group("$tName.tag_id")
        ->order("total desc")
        ->limit("$limit");

    $tags = $tag_table->fetchAll($select);   
    
    $records = array();
    
    $columns = array();
    if (!empty($tags))
    {
	    foreach ($tags as $k => $tag)
	    {
	      $records[$k] = $tag;
	      $columns[$k] = $order == 'total' ? $tag->total : $tag->text; 
	    }
    }

    $tags = array();
    if (count($columns))
    {
      asort($columns, $sort);
	    foreach ($columns as $k => $name)
	    {
	      $tags[$k] = $records[$k];
	    }
    }

    return $tags; 
  }


  public function query($sql)
  {
    $db = Engine_Db_Table::getDefaultAdapter();
    $db->beginTransaction();
    
    try 
    {
	    $db->query($sql);
      $db->commit();
      return $this;
    }
    catch( Exception $e )
    {
      $db->rollBack();
      throw $e;
    }
  }

  public function unlink($file)
  {
    @unlink(substr($file,0,1) === '/' ? $file : APPLICATION_PATH.DS.$file);
    return $this;
  }

  public function validateLicense($module)
  {
    $license = Engine_Api::_()->getApi('settings', 'core')->getSetting($module.'.license');
    return (trim($license) && $license != 'XXXX-XXXX-XXXX-XXXX');
  }  
  
  public function getTinyMceEditorOptions($params = array())
  {
    $default_options = array(
      'upload_url' => false,
      'remove_script_host' => '',
      'convert_urls' => false,
      'relative_urls' => '',
      'mode' => 'exact',
      'elements' => 'body',
      'width' => "540px",
      'height' => "320px",
      'media_strict' => false,
      'extended_valid_elements' => '*[*],**,object[width|height|classid|codebase|id|name],param[name|value],embed[src|type|width|height|flashvars|wmode|id|name],iframe[src|style|width|height|scrolling|marginwidth|marginheight|frameborder|id|name|class],video[src|type|width|height|flashvars|wmode|class|poster|preload|id|name],source[src]',
      'plugins' => "table,fullscreen,media,preview,paste,code,image,textcolor,link,anchor,charmap,emoticons",
      'toolbar1' => "cut,copy,|,undo,redo,removeformat,pastetext,|,code,media,image,link,fullscreen,preview",
      'toolbar2' => "fontselect,fontsizeselect,bold,italic,underline,strikethrough,forecolor,backcolor",
    	'toolbar3' => "alignleft,aligncenter,alignright,alignjustify,|,bullist,numlist,|,outdent,indent,blockquote,|,table,emoticons,charmap",
	  );

    $core_module = Engine_Api::_()->getDbtable('modules', 'core')->getModule('core');
    if (version_compare($core_module->version, '4.8.0', '>=')) {
      $default_options['plugins'] = "table,fullscreen,media,preview,paste,code,image,textcolor,link,anchor,charmap,emoticons,jbimages";
      $default_options['toolbar1'] = "cut,copy,|,undo,redo,removeformat,pastetext,|,code,media,image,jbimages,link,fullscreen,preview";

      if (isset($params['upload_url']) && !empty($params['upload_url']) && !isset($params['keep_upload_url'])) {

        // always with trailing /
        $path = Zend_Controller_Front::getInstance()->getRequest()->getScheme()
          . '://' .Zend_Controller_Front::getInstance()->getRequest()->getHttpHost();

        $url = rtrim($path, '/') . '/' . ltrim($params['upload_url'], '/');

        $router = clone Zend_Controller_Front::getInstance()->getRouter();
        $uri = Zend_Uri::factory($url);
        $request = new Zend_Controller_Request_Http($uri);

        $request = $router->route($request);

        if ($request->getActionName() == 'upload-photo') {
          $new_upload_url = Zend_Controller_Front::getInstance()->getRouter()->assemble(array('action' => 'upload-photo', 'm'=>$request->getModuleName()), 'radcodes_general', true);
          $params['upload_url'] = $new_upload_url;
        }

      }
    }

	  $options = array_merge($default_options, $params);
	  return $options;
  }

  public function getSpecialAlbum(User_Model_User $user, $type = 'radcodes')
  {
    $table = Engine_Api::_()->getDbtable('albums', 'album');

    $translate = Zend_Registry::get('Zend_Translate');
    $title = $translate->_(ucfirst($type) . ' Photos');

    $select = $table->select()
      ->where('owner_type = ?', $user->getType())
      ->where('owner_id = ?', $user->getIdentity())
      ->where('title = ?', $title)
      ->order('album_id ASC')
      ->limit(1);

    $album = $table->fetchRow($select);

    // Create wall photos album if it doesn't exist yet
    if( null === $album )
    {
      $album = $table->createRow();
      $album->owner_type = $user->getType();
      $album->owner_id = $user->getIdentity();
      $album->title = $title;
      //$album->type = $type;

      $album->search = 0;

      $album->save();

      // Authorizations
      $auth = Engine_Api::_()->authorization()->context;
      $auth->setAllowed($album, 'everyone', 'view',    true);
      $auth->setAllowed($album, 'everyone', 'comment', true);

    }

    return $album;
  }
}