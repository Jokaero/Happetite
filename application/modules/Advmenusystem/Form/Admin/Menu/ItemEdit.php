<?php
class Advmenusystem_Form_Admin_Menu_ItemEdit extends Advmenusystem_Form_Admin_Menu_ItemCreate
{
  public function init()
  {
    parent::init();
    $this->setTitle('Edit Menu Item');
    $this->submit->setLabel('Edit Menu Item');
  }
}