<?php
class Event_Form_Bank extends Engine_Form
{
    public function init()
    {
        $this->setAttrib('id', 'event_create_form')
          ->setMethod("POST")
          ->setAction(Zend_Controller_Front::getInstance()->getRouter()->assemble(array()));
          
        //$this->addElement('Text', 'bank_iban', array(
        //  'label' => 'IBAN',
        //  'allowEmpty' => false,
        //  'required' => true,
        //  'validators' => array(
        //    array('NotEmpty', true),
        //    array('StringLength', false, array(1, 64)),
        //  ),
        //  'filters' => array(
        //    'StripTags',
        //    new Engine_Filter_Censor(),
        //  ),
        //));
        //
        //$this->addElement('Text', 'bank_bic', array(
        //  'label' => 'BIC',
        //  'allowEmpty' => false,
        //  'required' => true,
        //  'validators' => array(
        //    array('NotEmpty', true),
        //    array('StringLength', false, array(1, 64)),
        //  ),
        //  'filters' => array(
        //    'StripTags',
        //    new Engine_Filter_Censor(),
        //  ),
        //));
        //
        //$this->addElement('Text', 'bank_name', array(
        //  'label' => 'Name',
        //  'allowEmpty' => false,
        //  'required' => true,
        //  'validators' => array(
        //    array('NotEmpty', true),
        //    array('StringLength', false, array(1, 64)),
        //  ),
        //  'filters' => array(
        //    'StripTags',
        //    new Engine_Filter_Censor(),
        //  ),
        //));
        //
        //$this->addElement('Text', 'bank_address', array(
        //  'label' => 'Address',
        //  'allowEmpty' => false,
        //  'required' => true,
        //  'validators' => array(
        //    array('NotEmpty', true),
        //    array('StringLength', false, array(1, 255)),
        //  ),
        //  'filters' => array(
        //    'StripTags',
        //    new Engine_Filter_Censor(),
        //  ),
        //));
        //
        //$this->addElement(
        //  new Fields_Form_Element_Country('bank_country', array(
        //    'label' => 'Country of Beneficiary',
        //    'allowEmpty' => false,
        //    'required' => true,
        //    'validators' => array(
        //      array('NotEmpty', true),
        //    ),
        //  ))
        //);
        
        // first name
        $this->addElement('Text', 'bank_first_name', array(
          'label' => 'First Name of Beneficiary:',
          'allowEmpty' => false,
          'required' => true,
          'validators' => array(
            array('NotEmpty', true),
            array('StringLength', false, array(1, 64)),
          ),
          'filters' => array(
            'StripTags',
            new Engine_Filter_Censor(),
          ),
        ));
        
        // last name
        $this->addElement('Text', 'bank_last_name', array(
          'label' => 'Last Name of Beneficiary:',
          'allowEmpty' => false,
          'required' => true,
          'validators' => array(
            array('NotEmpty', true),
            array('StringLength', false, array(1, 64)),
          ),
          'filters' => array(
            'StripTags',
            new Engine_Filter_Censor(),
          ),
        ));
        
        // address line #1
        $this->addElement('Text', 'bank_address_first', array(
          'label' => 'Address Line #1',
          'allowEmpty' => false,
          'required' => true,
          'validators' => array(
            array('NotEmpty', true),
            array('StringLength', false, array(1, 64)),
          ),
          'filters' => array(
            'StripTags',
            new Engine_Filter_Censor(),
          ),
        ));
        
        // address line #2
        $this->addElement('Text', 'bank_address_second', array(
          'label' => 'Address Line #2',
          'filters' => array(
            'StripTags',
            new Engine_Filter_Censor(),
          ),
        ));
        
        // City of Beneficiary
        $this->addElement('Text', 'bank_city', array(
          'label' => 'City of Beneficiary',
          'allowEmpty' => false,
          'required' => true,
          'validators' => array(
            array('NotEmpty', true),
            array('StringLength', false, array(1, 64)),
          ),
          'filters' => array(
            'StripTags',
            new Engine_Filter_Censor(),
          ),
        ));
        
        // Zip Code
        $this->addElement('Text', 'bank_zip', array(
          'label' => 'Zip Code',
          'allowEmpty' => false,
          'required' => true,
          'validators' => array(
            array('NotEmpty', true),
            array('StringLength', false, array(1, 64)),
          ),
          'filters' => array(
            'StripTags',
            new Engine_Filter_Censor(),
          ),
        ));
        
        // Country of Beneficiary
        $this->addElement(
          new Fields_Form_Element_Country('bank_country', array(
            'label' => 'Country of Beneficiary',
            'allowEmpty' => false,
            'required' => true,
            'validators' => array(
              array('NotEmpty', true),
            ),
          ))
        );
        
        // Phone number
        $this->addElement('Text', 'bank_phone', array(
          'label' => 'Phone number',
          'filters' => array(
            'StripTags',
            new Engine_Filter_Censor(),
          ),
        ));
        
        // IBAN number
        $this->addElement('Text', 'bank_iban', array(
          'label' => 'IBAN number',
          'allowEmpty' => false,
          'required' => true,
          'placeholder' => Zend_Registry::get('Zend_Translate')->_('AT611904300234573201'),
          'validators' => array(
            array('NotEmpty', true),
            array('StringLength', false, array(1, 64)),
            //new Zend_Validate_Iban(array('locale' => false))
          ),
          'filters' => array(
            'StripTags',
            new Engine_Filter_Censor(),
          ),
        ));
        
        $this->addElement('Button', 'submit', array(
          'label' => 'Save Changes',
          'type' => 'submit',
          'ignore' => true,
          'decorators' => array(
            'ViewHelper',
          ),
        ));
    
        $this->addElement('Cancel', 'cancel', array(
          'label' => 'cancel',
          'link' => true,
          'prependText' => '- or -',
          'decorators' => array(
            'ViewHelper',
          ),
        ));
    
        $this->addDisplayGroup(array('submit', 'cancel'), 'buttons', array(
          'decorators' => array(
            'FormElements',
            'DivDivDivWrapper',
          ),
        ));
    }
}