<?php
echo $this->partial($this->script[0], $this->script[1], array(
  'form' => $this->form
)); 
?>

<script type="text/javascript">
  if( $("user_signup_form") ) $("user_signup_form").getElements(".form-errors").destroy();
  
  function skipForm() {
    document.getElementById("skip").value = "skipForm";
    $('SignupForm').submit();
  }
  
  function finishForm() {
    document.getElementById("nextStep").value = "finish";
  }
</script>