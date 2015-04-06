<?php
?>

<h2><?php echo $this->translate("Social Connect") ?></h2>

<?php if( count($this->navigation) ): ?>
  <div class='tabs'>
    <?php
      echo $this->navigation()->menu()->setContainer($this->navigation)->render()
    ?>
  </div>
<?php endif; ?>

  <div class='clear'>
    <div class='settings'>

      
<h3>Social Connect</h3>
<p>
	Your site user Social Connect from <a target="_default" href="http://module2buy.com">younetco</a>.
</p>
<?php echo $this->message ?>

    </div>
  </div>



