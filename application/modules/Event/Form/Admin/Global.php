<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Global.php 9802 2012-10-20 16:56:13Z pamela $
 * @author     Jung
 */

/**
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Event_Form_Admin_Global extends Engine_Form
{
  public function init()
  {
    $this
      ->setTitle('Global Settings')
      ->setDescription('These settings affect all members in your community.');

   // Create Elements
    $bbcode = new Engine_Form_Element_Radio('bbcode');
    $bbcode
      ->addMultiOptions(array(
        1 => 'Yes, members can use BBCode tags.',
        0 => 'No, do not let members use BBCode.'
      ));
    $bbcode->setValue(1);
    $bbcode->setLabel("Enable BBCode");

    $html = new Engine_Form_Element_Radio('html');

    $html
      ->addMultiOptions(array(
        1 => 'Yes, members can use HTML in their posts.',
        0 => 'No, strip HTML from posts.'
      ));
    $html->setValue(0);
    $html->setLabel("Enable HTML");

    $billingHeading = new Engine_Form_Element_Heading('billingheading');
    $billingHeading->setLabel('Billing Information');
    
    $percent = new Engine_Form_Element_Integer('event_percent');
    $percent
      ->setLabel('Site Percent')
      ->setRequired(true);
    
    $environment = new Engine_Form_Element_Select('environment');
    $environment
      ->setLabel('Billing Mode')
      ->setRequired(true)
      ->addMultiOptions(array(
      'sandbox' => 'Test',
      'production' => 'Production'
    ));
    
    $merchantId = new Engine_Form_Element_Text('merchant_id');
    $merchantId
      ->setLabel('Merchant Id')
      ->setRequired(true);
    
    $publicKey = new Engine_Form_Element_Text('public_key');
    $publicKey
      ->setLabel('Public Key')
      ->setRequired(true);
    
    $privateKey = new Engine_Form_Element_Text('private_key');
    $privateKey
      ->setLabel('Private Key')
      ->setRequired(true);
    
    // Merchant Accounts
    $merchantAccountUsd = new Engine_Form_Element_Text('merchant_account_usd');
    $merchantAccountUsd
      ->setLabel('Merchant Account ID (USD)')
      ->setRequired(true);
    
    $merchantAccountChf = new Engine_Form_Element_Text('merchant_account_chf');
    $merchantAccountChf
      ->setLabel('Merchant Account ID (CHF)')
      ->setRequired(true);
    
    $merchantAccountEur = new Engine_Form_Element_Text('merchant_account_eur');
    $merchantAccountEur
      ->setLabel('Merchant Account ID (EUR)')
      ->setRequired(true);
    
    $merchantAccountGbp = new Engine_Form_Element_Text('merchant_account_gbp');
    $merchantAccountGbp
      ->setLabel('Merchant Account ID (GBP)')
      ->setRequired(true);
    
    // Add elements
    $this->addElements(array(
      $bbcode,
      $html,
      $billingHeading,
      $percent,
      $environment,
      $merchantId,
      $publicKey,
      $privateKey,
      $merchantAccountUsd,
      $merchantAccountChf,
      $merchantAccountEur,
      $merchantAccountGbp
    ));    

    // Add submit button
    $this->addElement('Button', 'submit', array(
      'label' => 'Save Changes',
      'type' => 'submit',
      'ignore' => true
    ));
  }
}