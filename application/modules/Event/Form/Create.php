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

    $this->setTitle('Create New Event')
      ->setAttrib('id', 'event_create_form')
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

    // Description
    $this->addElement('Textarea', 'description', array(
      'label' => 'Event Description',
      'maxlength' => '10000',
      'filters' => array(
        'StripTags',
        new Engine_Filter_Censor(),
        new Engine_Filter_EnableLinks(),
        new Engine_Filter_StringLength(array('max' => 10000)),
      ),
    ));

    // Start time
    $start = new Engine_Form_Element_CalendarDateTime('starttime');
    $start->setLabel("Start Time");
    $start->setAllowEmpty(false);
    $this->addElement($start);

    // End time
    //$end = new Engine_Form_Element_CalendarDateTime('endtime');
    //$end->setLabel("End Time");
    //$end->setAllowEmpty(false);
    //$this->addElement($end);
    
    // Duration
    $this->addElement('Select', 'duration', array(
      'label' => 'Estimated class duration',
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
    $this->addElement('Text', 'location', array(
      'label' => 'Location',
      'allowEmpty' => false,
      'required' => true,
      'validators' => array(
        array('NotEmpty', true),
      ),
      'filters' => array(
        new Engine_Filter_Censor(),
      )
    ));

    // Photo
    $this->addElement('File', 'photo', array(
      'label' => 'Main Photo'
    ));
    $this->photo->addValidator('Extension', false, 'jpg,png,gif,jpeg');

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
    
    // Max members
    $this->addElement('Text', 'max_users', array(
      'label' => '# of Participants',
      'description' => 'If you leave this field empty, participant will be able to apply for the class until you press the "mark class as fully booked" button in the class profile.',
      'validators' => array(
        array('Int', true),
      ),
    ));
    
    // Price
    $this->addElement('Text', 'price', array(
      'label' => 'Price*',
      'allowEmpty' => false,
      'required' => true,
      'validators' => array(
        array('NotEmpty', true),
        array('Float', true, array('locale' => 'en_US')),
        array('greaterThan', true, array('min' => 0)),
        array('stringLength', true, array(1, 12)),
      ),
    ));
    
    $content = '<span id="service_free"></span>';
    $content .= '<span id="total_price_percent">0</span>';
    $content .= "<br />* This is the payment you receive per guest<br />**	Price incl. service fee (price guests pay to attend)";
    
    $this->addElement('Dummy', 'price_percent', array(
      'label' => 'Total Price**',
      'content' => $content
    ));
    
    // Currency
    $currenciesOptions = array_merge(
      array('' => 'Select Currency'),
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
    
    // Bank Account Information
    $this->addElement('Heading', 'bank_info', array(
      'value' => 'Bank Account Information',
    ));
    
    $this->getElement('bank_info')->removeDecorator('Label')
          ->removeDecorator('HtmlTag')
          ->getDecorator('HtmlTag2')->setOption('class', 'form-wrapper-heading');
    
    $this->addElement('Text', 'bank_iban', array(
      'label' => 'IBAN',
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
    
    $this->addElement('Text', 'bank_bic', array(
      'label' => 'BIC',
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
    
    $this->addElement('Text', 'bank_name', array(
      'label' => 'Name',
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
    
    $this->addElement('Text', 'bank_address', array(
      'label' => 'Address',
      'allowEmpty' => false,
      'required' => true,
      'validators' => array(
        array('NotEmpty', true),
        array('StringLength', false, array(1, 255)),
      ),
      'filters' => array(
        'StripTags',
        new Engine_Filter_Censor(),
      ),
    ));
    
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
    
    // Courses
    $this->addElement(
      new Event_Form_Element_MultiTextarea('class_starter', array(
        'label' => 'Starter',
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
        'label' => 'Main Course',
        //'rows' => 5,
        'style' => 'height: 16px; min-height: 16px;',
        'allowEmpty' => false,
        'required' => true,
        'validators' => array(
          array('NotEmpty', true),
          array('StringLength', false, array(1, 1024)),
        ),
        'filters' => array(
          'StripTags',
          new Engine_Filter_Censor(),
        ),
      ))
    );
    
    $this->addElement(
      new Event_Form_Element_MultiTextarea('class_dessert', array(
        'label' => 'Dessert',
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
        'label' => 'Beverages',
        //'rows' => 5,
        'style' => 'height: 16px; min-height: 16px;',
        'filters' => array(
          'StripTags',
          new Engine_Filter_Censor(),
        ),
      ))
    );
    
    // Takeaways
    $this->addElement('Textarea', 'class_takeaways', array(
      'label' => 'Takeaways',
      'style' => 'height: 16px; min-height: 16px;',
      'validators' => array(
        array('StringLength', false, array(1, 1024)),
      ),
      'filters' => array(
        'StripTags',
        new Engine_Filter_Censor(),
      ),
    ));
    
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
      'prependText' => ' or ',
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