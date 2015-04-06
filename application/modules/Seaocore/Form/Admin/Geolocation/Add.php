<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Seaocore
 * @copyright  Copyright 2013-2014 BigStep Technologies Pvt. Ltd.
 * @license    http://www.socialengineaddons.com/license/
 * @version    $Id: Add.php 6590 2014-06-02 00:00:00Z SocialEngineAddOns $
 * @author     SocialEngineAddOns
 */
class Seaocore_Form_Admin_Geolocation_Add extends Engine_Form {

    public function init() {

        $this
                ->setTitle('Add Location');

        $this->addElement('Text', 'title', array(
            'label' => 'Location Title',
            'required' => true
        ));

        $this->addElement('Text', 'location', array(
            'label' => 'Location Address',
            'required' => true,
            'onkeypress' => 'unsetLatLng()',
        ));
        
        $this->addElement('Hidden', 'latitude', array(
            'order' => 998,
            'label' => 'Latitude',
        ));
        
        $this->addElement('Hidden', 'longitude', array(
            'order' => 999,
            'label' => 'Longitude',
        ));        

        $this->addElement('Button', 'submit', array(
            'label' => 'Add',
            'type' => 'submit',
            'ignore' => true,
            //'decorators' => array('ViewHelper')
        ));

        $this->addElement('Cancel', 'cancel', array(
            'label' => 'cancel',
            'link' => true,
            'prependText' => ' or ',
            'href' => '',
            'onClick' => 'javascript:parent.Smoothbox.close();',
//            'decorators' => array(
//                'ViewHelper'
//            )
        ));
    }

}