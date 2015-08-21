<?php echo $this->form->render($this); ?>

<script type="text/javascript">
  $('explanation_link').addEvents({
    'mouseover': function() {
      $('cvv_image').setStyle('display', 'block');
    },
    'focus': function() {
      $('cvv_image').setStyle('display', 'block');
    }
  });
  
  $('explanation_link').addEvent('mouseout', function() {
    $('cvv_image').setStyle('display', 'none');
  });
</script>