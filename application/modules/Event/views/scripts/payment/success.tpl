<div class="tip">
  <span>
    <?php if ($this->subject) : ?>
      <?php echo $this->translate('Thank you for your payment. You are now fully approved for the class %s.', $this->htmlLink($this->subject, $this->subject->getTitle()));?>
    <?php else : ?>
      <?php echo $this->translate('Thank you for your payment. You are now fully approved for the class.');?>
    <?php endif; ?>
  </span>
</div>