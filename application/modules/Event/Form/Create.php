<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Create.php 9747 2012-07-26 02:08:08Z john $
 * @author     Sami
 */

/**
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Event_Form_Create extends Engine_Form
{
  protected $_parent_type;

  protected $_parent_id;
  
  public function setParent_type($value)
  { 
    $this->_parent_type = $value;
  }

  public function setParent_id($value)
  {
    $this->_parent_id = $value;
  }

  public function init()
  {
    $user = Engine_Api::_()->user()->getViewer();

    $this->setAttrib('id', 'event_create_form')
      ->setMethod("POST")
      ->setAction(Zend_Controller_Front::getInstance()->getRouter()->assemble(array()));
    
    // Title
    $this->addElement('Text', 'title', array(
      'label' => 'Event Name',
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

    $title = $this->getElement('title');
    
    // Category
    $this->addElement('Select', 'category_id', array(
      'label' => 'Event Category',
      'allowEmpty' => false,
      'required' => true,
      'validators' => array(
        array('NotEmpty', true),
      ),
      'multiOptions' => array(
        '0' => ' '
      ),
    ));
    
    // Description
    $this->addElement('Textarea', 'description', array(
      'label' => 'Event Description',
      'required' => true,
      'maxlength' => '10000',
      'filters' => array(
        'StripTags',
        new Engine_Filter_Censor(),
        new Engine_Filter_EnableLinks(),
        new Engine_Filter_StringLength(array('max' => 10000)),
      ),
    ));
    
    // Takeaways
    $this->addElement('Textarea', 'class_takeaways', array(
      'label' => 'Takeaways',
      'required' => true,
      'validators' => array(
        array('StringLength', false, array(1, 1024)),
      ),
      'filters' => array(
        'StripTags',
        new Engine_Filter_Censor(),
      ),
    ));
    
    // meal heading
    $this->addElement('Dummy', 'meal_heading', array(
      'content' => '<h2>Meal:</h2>'
    ));
    
    // under meal heading notice
    $this->addElement('Dummy', 'meal_notice', array(
      'content' => sprintf(
        '<span class="meal_notice notice">%s</span>',
        Zend_Registry::get('Zend_Translate')->_('At least on course must contain entry!')
      )
    ));
    
    // Courses
    $this->addElement(
      new Event_Form_Element_MultiTextarea('class_starter', array(
        'label' => 'Add Starter',
        //'rows' => 5,
        'style' => 'height: 16px; min-height: 16px;',
        'filters' => array(
          'StripTags',
          new Engine_Filter_Censor(),
        ),
      ))
    );
    
    $this->addElement(
      new Event_Form_Element_MultiTextarea('class_main', array(
        'label' => 'Add Main Course',
        //'rows' => 5,
        'style' => 'height: 16px; min-height: 16px;',
        'allowEmpty' => false,
        'required' => false,
        //'validators' => array(
        //  array('NotEmpty', true),
        //  array('StringLength', false, array(1, 1024)),
        //),
        'filters' => array(
          'StripTags',
          new Engine_Filter_Censor(),
        ),
      ))
    );
    
    $this->addElement(
      new Event_Form_Element_MultiTextarea('class_dessert', array(
        'label' => 'Add Dessert',
        //'rows' => 5,
        'style' => 'height: 16px; min-height: 16px;',
        'filters' => array(
          'StripTags',
          new Engine_Filter_Censor(),
        ),
      ))
    );
    
    // Beverages
    $this->addElement(
      new Event_Form_Element_MultiTextarea('class_beverages', array(
        'label' => 'Add Beverages',
        //'rows' => 5,
        'style' => 'height: 16px; min-height: 16px;',
        'filters' => array(
          'StripTags',
          new Engine_Filter_Censor(),
        ),
      ))
    );
    
    // meal heading
    $this->addElement('Dummy', 'class_details', array(
      'content' => '<h2>' . Zend_Registry::get('Zend_Translate')->_('Class Details') . '</h2>'
    ));
    
    // Start time
    $start = new Event_Form_Element_CalendarDateTime('starttime');
    $start->setLabel("Start Time");
    $start->setRequired(true);
    $start->setAllowEmpty(false);
    $this->addElement($start);

    // End time
    //$end = new Engine_Form_Element_CalendarDateTime('endtime');
    //$end->setLabel("End Time");
    //$end->setAllowEmpty(false);
    //$this->addElement($end);
    
    // Duration
    $this->addElement('Select', 'duration', array(
      'label' => 'Approximate duration',
      'multiOptions' => array(
        '' => '',
        '1' => '1 hour',
        '1.5' => '1.5 hours',
        '2' => '2 hours',
        '2.5' => '2.5 hours',
        '3' => '3 hours',
        '3.5' => '3.5 hours',
        '4' => '4 hours',
        '4.5' => '4.5 hours',
        '5' => '5 hours',
        '5.5' => '5.5 hours',
        '6' => '6 hours',
        '6.5' => '6.5 hours',
        '7' => '7 hours',
      ),
      'allowEmpty' => false,
      'required' => true,
      'validators' => array(
        array('NotEmpty', true),
      ),
    ));
    
    // Location
    //$this->addElement('Text', 'location', array(
    //  'label' => 'Location',
    //  'allowEmpty' => false,
    //  'required' => true,
    //  'validators' => array(
    //    array('NotEmpty', true),
    //  ),
    //  'filters' => array(
    //    new Engine_Filter_Censor(),
    //  )
    //));
    
    //$this->addElement('Text', 'country', array(
    //  'label' => 'Country',
    //  'allowEmpty' => false,
    //  'required' => true,
    //  'validators' => array(
    //    array('NotEmpty', true),
    //  ),
    //  'filters' => array(
    //    new Engine_Filter_Censor(),
    //    'StripTags',
    //  )
    //));
    
    $this->addElement('Text', 'address', array(
      'label' => 'Address',
      'allowEmpty' => false,
      'required' => true,
      'validators' => array(
        array('NotEmpty', true),
      ),
      'filters' => array(
        'StripTags',
        new Engine_Filter_Censor(),
      )
    ));
    
    $this->addElement('Text', 'city', array(
      'label' => 'City',
      'allowEmpty' => false,
      'required' => true,
      'validators' => array(
        array('NotEmpty', true),
      ),
      'filters' => array(
        new Engine_Filter_Censor(),
        'StripTags',
      )
    ));
    
    $this->addElement('Text', 'zipcode', array(
      'label' => 'Zip Code',
      'allowEmpty' => false,
      'required' => true,
      'validators' => array(
        array('NotEmpty', true),
      ),
      'filters' => array(
        new Engine_Filter_Censor(),
        'StripTags',
      )
    ));
    
    $this->addElement(
      new Fields_Form_Element_Country('country', array(
        'label' => 'Country',
        'allowEmpty' => false,
        'required' => true,
        'validators' => array(
          array('NotEmpty', true),
        ),
        'filters' => array(
          new Engine_Filter_Censor(),
          'StripTags',
        ),
      ))
    );
    
    // Photo
    $this->addElement('File', 'photo', array(
      'label' => 'Main Photo',
      'required' => true,
    ));
    $this->photo->addValidator('Extension', false, 'jpg,png,gif,jpeg');
    
    // photo notice
    $this->addElement('Dummy', 'photo_notice', array(
      'content' => sprintf(
        '<span class="photo_notice notice">%s</span>',
        Zend_Registry::get('Zend_Translate')->_('NOTE: The main picture is the one that will be shown in the previews')
      )
    ));
    
    // Max members
    $this->addElement('Select', 'max_users', array(
      'label' => '# of Participants',      
      'validators' => array(
        array('Int', true),
      ),
      'multiOptions' => range(0, 100)
    ));
    
    // participants notice
    $this->addElement('Dummy', 'participants-notice', array(
      'content' => sprintf(
        '<span class="participants-notice notice">%s</span>',
        Zend_Registry::get('Zend_Translate')->_('Note: If you leave this field empty, participant will be able to apply for the class until you press the "mark class as fully booked" button in the class profile.')
      ),
      'required' => false,
    ));
    
    // Currency
    $currenciesOptions = array_merge(
      Engine_Api::_()->event()->getCurrencies()
    );

    $this->addElement('Select', 'currency', array(
      'label' => 'Currency',
      'multiOptions' => $currenciesOptions,
      'allowEmpty' => false,
      'required' => true,
      'validators' => array(
        array('NotEmpty', true),
      ),
    ));
    
    /*
    $this->addElement('Dummy', 'price_chf', array(
      'label' => 'CHF',
      //'content' => $content
    ));
    */
   
    // Price
    $this->addElement('Text', 'price', array(
      'label' => 'Price',
      'description' => 'This is the payment you receive per guest',
      'allowEmpty' => false,
      'required' => true,
      'validators' => array(
        array('NotEmpty', true),
        array('Float', true, array('locale' => 'en_US')),
        array('greaterThan', true, array('min' => 0)),
        array('stringLength', true, array(1, 12)),
      ),
    ));
    $this->price->getDecorator('Description')->setOption('placement', 'APPEND');
    
    $this->addDisplayGroup(array('price_chf', 'price'), 'price_group', array());
    
    
    $content = '<span id="service_free"></span>';
    $content .= '<span id="total_price_percent"><span class="total_price">0</span></span>';
    
    $this->addElement('Dummy', 'price_percent', array(
      'label' => 'Total Price:',
      'content' => $content
    ));
    
    // price_percent notice
    $this->addElement('Dummy', 'price_percent_notice', array(
      'content' => sprintf(
        '<span class="price_percent_notice notice">%s</span>',
        Zend_Registry::get('Zend_Translate')->_('Price incl. service fee (price guests pay to attend)')
      ),
    ));
    
    // Bank Account Information
    //$this->addElement('Heading', 'bank_info', array(
    //  'value' => 'Bank Account Information',
    //));
    //
    //$this->getElement('bank_info')->removeDecorator('Label')
    //      ->removeDecorator('HtmlTag')
    //      ->getDecorator('HtmlTag2')
    //      ->setOption('class', 'form-wrapper-heading')
    //      ->setOption('style', 'clear:both;');
    //
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
    
    // Search
    $this->addElement('Hidden', 'search', array(
      'label' => 'People can search for this event',
      'value' => 1
    ));

    // Approval
    $this->addElement('Hidden', 'approval', array(
      'label' => 'People must be invited to RSVP for this event',
    ));

    // Invite
    $this->addElement('Hidden', 'auth_invite', array(
      'label' => 'Invited guests can invite other people as well',
      'value' => 1
    ));

    // Privacy
    $viewOptions = (array) Engine_Api::_()->authorization()->getAdapter('levels')->getAllowed('event', $user, 'auth_view');
    $commentOptions = (array) Engine_Api::_()->authorization()->getAdapter('levels')->getAllowed('event', $user, 'auth_comment');
    $photoOptions = (array) Engine_Api::_()->authorization()->getAdapter('levels')->getAllowed('event', $user, 'auth_photo');
    
    if( $this->_parent_type == 'user' ) {
      $availableLabels = array(
        'everyone'            => 'Everyone',
        'registered'          => 'All Registered Members',
        'owner_network'       => 'Friends and Networks',
        'owner_member_member' => 'Friends of Friends',
        'owner_member'        => 'Friends Only',
        'member'              => 'Event Guests Only',
        'owner'               => 'Just Me'
      );
      $viewOptions = array_intersect_key($availableLabels, array_flip($viewOptions));
      $commentOptions = array_intersect_key($availableLabels, array_flip($commentOptions));
      $photoOptions = array_intersect_key($availableLabels, array_flip($photoOptions));

    } else if( $this->_parent_type == 'group' ) {

      $availableLabels = array(
        'everyone'      => 'Everyone',
        'registered'    => 'All Registered Members',
        'parent_member' => 'Group Members',
        'member'        => 'Event Guests Only',
        'owner'         => 'Just Me',
      );
      $viewOptions = array_intersect_key($availableLabels, array_flip($viewOptions));
      $commentOptions = array_intersect_key($availableLabels, array_flip($commentOptions));
      $photoOptions = array_intersect_key($availableLabels, array_flip($photoOptions));
    }

    // View
    if( !empty($viewOptions) && count($viewOptions) >= 1 ) {
      // Make a hidden field
      if(count($viewOptions) == 1) {
        $this->addElement('hidden', 'auth_view', array('value' => key($viewOptions)));
      // Make select box
      } else {
        $this->addElement('Select', 'auth_view', array(
            'label' => 'Privacy',
            'description' => 'Who may see this event?',
            'multiOptions' => $viewOptions,
            'value' => key($viewOptions),
        ));
        $this->auth_view->getDecorator('Description')->setOption('placement', 'append');
      }
    }

    // Comment
    if( !empty($commentOptions) && count($commentOptions) >= 1 ) {
      // Make a hidden field
      if(count($commentOptions) == 1) {
        $this->addElement('hidden', 'auth_comment', array('value' => key($commentOptions)));
      // Make select box
      } else {
        $this->addElement('Select', 'auth_comment', array(
            'label' => 'Comment Privacy',
            'description' => 'Who may post comments on this event?',
            'multiOptions' => $commentOptions,
            'value' => key($commentOptions),
        ));
        $this->auth_comment->getDecorator('Description')->setOption('placement', 'append');
      }
    }

    // Photo
    if( !empty($photoOptions) && count($photoOptions) >= 1 ) {
      // Make a hidden field
      if(count($photoOptions) == 1) {
        $this->addElement('hidden', 'auth_photo', array('value' => key($photoOptions)));
      // Make select box
      } else {
        $this->addElement('Select', 'auth_photo', array(
            'label' => 'Photo Uploads',
            'description' => 'Who may upload photos to this event?',
            'multiOptions' => $photoOptions,
            'value' => key($photoOptions)
        ));
        $this->auth_photo->getDecorator('Description')->setOption('placement', 'append');
      }
    }



    // Buttons
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