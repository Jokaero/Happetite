<?php
class Advmenusystem_Form_Admin_Content_Edit extends Advmenusystem_Form_Admin_Content_Create
{
  public function init()
  {
    parent::init();
    $this->setTitle('Edit Menu Content');
    $this->submit->setLabel('Edit Menu Content');
  }
}