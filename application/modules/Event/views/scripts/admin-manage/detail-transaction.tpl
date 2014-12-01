<div class="global_form_popup admin_member_stats">
  <h3>Transaction Statistics</h3>
  <ul>
    <li>
      <?php echo $this->htmlLink($this->user, $this->itemPhoto($this->user, 'thumb.icon', $this->user->getTitle())) ?>
      <span><?php echo $this->htmlLink($this->event, $this->itemPhoto($this->event, 'thumb.icon', $this->event->getTitle())) ?></span>
    </li>
    <li>
      <?php echo $this->translate('Transaction ID:') ?>
      <span><?php echo $this->transaction->getIdentity(); ?></span>
    </li>
    <li>
      <?php echo $this->translate('Status:') ?>
      <span style="text-transform: uppercase;"><?php echo $this->transaction->status; ?></span>
    </li>
    <li>
      <?php echo $this->translate('Course Price:') ?>
      <span><?php echo $this->event->price; ?> <?php echo $this->event->currency; ?></span>
    </li>
    <li>
      <?php echo $this->translate('Service Fee:') ?>
      <span><?php echo abs($this->transaction->price) - $this->event->price; ?> <?php echo $this->transaction->currency; ?></span>
    </li>
    <li>
      <?php echo $this->translate('Total Price:') ?>
      <span><?php echo $this->transaction->price; ?> <?php echo $this->transaction->currency; ?></span>
    </li>
    <li>
      <?php echo $this->translate('Creation Date:') ?>
      <span><?php echo $this->locale()->toDateTime($this->transaction->creation_date); ?></span>
    </li>
    <li>
      <?php echo $this->translate('Modified Date:') ?>
      <span><?php echo $this->locale()->toDateTime($this->transaction->modified_date); ?></span>
    </li>
  </ul>
  <br />
  <h3>Billing Information</h3>
  <ul>
    <li>
      <?php echo $this->translate('Transaction ID:') ?>
      <span><?php echo $this->transaction->tid; ?></span>
    </li>
    <li>
      <?php echo $this->translate('Type:') ?>
      <span style="text-transform: uppercase;"><?php echo $this->transaction->ttype; ?></span>
    </li>
  </ul>
  <br/>
  <button type="submit" onclick="parent.Smoothbox.close();return false;" name="close_button" value="Close">Close</button>
</div>