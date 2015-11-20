<div style="padding: 10px;">
    <p><?php echo $this->translate("First Name of Beneficiary:") ?> <?php echo $this->event->bank_first_name ?></p>
    <p><?php echo $this->translate('Last Name of Beneficiary:') ?> <?php echo $this->event->bank_last_name ?></p>
    <p><?php echo $this->translate("Address Line #1") ?>: <?php echo $this->event->bank_address_first ?></p>
    <p><?php echo $this->translate("Address Line #2") ?>: <?php echo $this->event->bank_address_second ?></p>
    <p><?php echo $this->translate("City of Beneficiary") ?>: <?php echo $this->event->bank_city ?></p>
    <p><?php echo $this->translate("Zip Code") ?>: <?php echo $this->event->bank_zip ?></p>
    <p><?php echo $this->translate("Country of Beneficiary") ?>: <?php echo $this->event->bank_country ?></p>
    <p><?php echo $this->translate("Phone number") ?>: <?php echo $this->event->bank_phone ?></p>
    <p><?php echo $this->translate("IBAN number") ?>: <?php echo $this->event->bank_iban ?></p>
</div>