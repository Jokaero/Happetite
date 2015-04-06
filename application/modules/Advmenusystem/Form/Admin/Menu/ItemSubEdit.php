<?php
class Advmenusystem_Form_Admin_Menu_ItemSubEdit extends Advmenusystem_Form_Admin_Menu_ItemSubCreate
{
  public function init()
  {
    parent::init();
    $this->setTitle('Edit Sub Menu Item');
    $this->submit->setLabel('Edit Sub Menu Item');
  }
}