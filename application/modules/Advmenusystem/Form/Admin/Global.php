<?php
class Advmenusystem_Form_Admin_Global extends Engine_Form
{
  public function init()
  {
    
    $this
      ->setTitle('Global Settings')
      ->setDescription('These settings affect all members in your community.');
      
       $this->addElement('Radio', 'avdmenusystem_makeall', array(
        'label' => 'Mark All Read?',
        'description' => 'Allow users to mark all read when clicking on notification icon? ',
        'multiOptions' => array(
          1 => 'Yes',
          0 => 'No'
        ),
        'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('avdmenusystem.makeall', 0),
      ));  
      $this->addElement('Radio', 'avdmenusystem_submenu', array(
        'label' => 'Use Sub Menu?',
        'description' => 'Allow admin to add sub menu? ',
        'multiOptions' => array(
          1 => 'Yes',
          0 => 'No'
        ),
        'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('avdmenusystem.submenu', 1),
      ));
    // Add submit button
    $this->addElement('Button', 'submit', array(
      'label' => 'Save Changes',
      'type' => 'submit',
      'ignore' => true
    ));
  }
}