<?php
class Advmenusystem_Form_Admin_Menu_ItemCoreMainEdit extends Advmenusystem_Form_Admin_Menu_ItemCoreMainCreate
{
  public function init()
  {
    parent::init();
    $this->setTitle('Edit Core Main Menu Item');
    $this->submit->setLabel('Edit Core Main Menu Item');
  }
}