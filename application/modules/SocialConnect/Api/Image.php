<?php

class SocialConnect_Api_Image
{
	
	protected $_session = NULL;
	

	function getSession()
	{
		{
			if (is_null($this -> _session))
			{
				$this -> _session = new Zend_Session_Namespace('User_Plugin_Signup_Photo');
				if (!isset($this -> _session -> active))
				{
					$this -> _session -> active = true;
				}
			}
			return $this -> _session;
		}
	}

	protected function _resizeImages($file)
	{
		$name = basename($file);
		$path = dirname($file);

		// Resize image (main)
		$iMainPath = $path . '/m_' . $name;
		$image = Engine_Image::factory();
		$image -> open($file) -> resize(720, 720) -> write($iMainPath) -> destroy();

		// Resize image (profile)
		$iProfilePath = $path . '/p_' . $name;
		$image = Engine_Image::factory();
		$image -> open($file) -> resize(200, 400) -> write($iProfilePath) -> destroy();

		// Resize image (icon.normal)
		$iNormalPath = $path . '/n_' . $name;
		$image = Engine_Image::factory();
		$image -> open($file) -> resize(48, 120) -> write($iNormalPath) -> destroy();

		// Resize image (icon.square)
		$iSquarePath = $path . '/s_' . $name;
		$image = Engine_Image::factory();
		$image -> open($file);
		$size = min($image -> height, $image -> width);
		$x = ($image -> width - $size) / 2;
		$y = ($image -> height - $size) / 2;
		$image -> resample($x, $y, $size, $size, 48, 48) -> write($iSquarePath) -> destroy();

		// Cloud compatibility, put into storage system as temporary files
		$storage = Engine_Api::_() -> getItemTable('storage_file');

		// Save/load from session
		if (empty($this -> getSession() -> tmp_file_id))
		{
			// Save
			$iMain = $storage -> createTemporaryFile($iMainPath);
			$iProfile = $storage -> createTemporaryFile($iProfilePath);
			$iNormal = $storage -> createTemporaryFile($iNormalPath);
			$iSquare = $storage -> createTemporaryFile($iSquarePath);

			$iMain -> bridge($iProfile, 'thumb.profile');
			$iMain -> bridge($iNormal, 'thumb.normal');
			$iMain -> bridge($iSquare, 'thumb.icon');

			$this -> getSession() -> tmp_file_id = $iMain -> file_id;
		}
		else
		{
			// Overwrite
			$iMain = $storage -> getFile($this -> getSession() -> tmp_file_id);
			$iMain -> store($iMainPath);

			$iProfile = $storage -> getFile($this -> getSession() -> tmp_file_id, 'thumb.profile');
			$iProfile -> store($iProfilePath);

			$iNormal = $storage -> getFile($this -> getSession() -> tmp_file_id, 'thumb.normal');
			$iNormal -> store($iNormalPath);

			$iSquare = $storage -> getFile($this -> getSession() -> tmp_file_id, 'thumb.icon');
			$iSquare -> store($iSquarePath);
		}

		// Save path to session?
		$_SESSION['TemporaryProfileImg'] = $iMain -> map();
		$_SESSION['TemporaryProfileImgProfile'] = $iProfile -> map();
		$_SESSION['TemporaryProfileImgSquare'] = $iSquare -> map();
		$_SESSION['main_photo_file_id'] = $iMain->file_id;
		
		// Remove temp files
		@unlink($path . '/p_' . $name);
		@unlink($path . '/m_' . $name);
		@unlink($path . '/n_' . $name);
		@unlink($path . '/s_' . $name);
	}

	protected function _resizeThumbnail($user)
	{
		$storage = Engine_Api::_() -> storage();

		$iProfile = $storage -> get($user -> photo_id, 'thumb.profile');
		$iSquare = $storage -> get($user -> photo_id, 'thumb.icon');

		// Read into tmp file
		$pName = $iProfile -> getStorageService() -> temporary($iProfile);
		$iName = dirname($pName) . '/nis_' . basename($pName);

		list($x, $y, $w, $h) = explode(':', $this -> getSession() -> coordinates);

		$image = Engine_Image::factory();
		$image -> open($pName) -> resample((int)$x, (int)$y, (int)$w, (int)$h, 48, 48) -> write($iName) -> destroy();

		$iSquare -> store($iName);

		@unlink($iName);
	}

	public function _fetchImage($photo_url)
	{
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $photo_url);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
		curl_setopt($ch, CURLOPT_MAXREDIRS, 5);
		$data = curl_exec($ch);
		curl_close($ch);
		$tmpfile = APPLICATION_PATH_TMP . DS . md5($photo_url) . '.jpg';
		@file_put_contents($tmpfile, $data);
		$this -> _resizeImages($tmpfile);
	}

}
