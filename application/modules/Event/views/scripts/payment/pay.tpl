<?php echo $this->form->render($this); ?>

<script type="text/javascript">
  $('cvv').addEvents({
    'mouseover': function() {
      $('cvv_image').setStyle('display', 'block');
    },
    'focus': function() {
      $('cvv_image').setStyle('display', 'block');
    }
  });
  
  $('cvv').addEvent('mouseout', function() {
    $('cvv_image').setStyle('display', 'none');
  });
</script>