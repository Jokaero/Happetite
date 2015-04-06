<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: index.tpl 9987 2013-03-20 00:58:10Z john $
 * @author     Sami
 */
?>

<h3>
  <?php echo $this->translate('Meal Details') ?>
</h3>

<?php if( !empty($this->subject->description) ): ?>
<div class='event_stats class_menu description-wrapper'>
  <ul class="description-list">
    <li class="list_label description-title"><?php echo $this->translate('Class Description')?></li>
    <li class="description"><?php echo nl2br($this->subject->description) ?></li>
  </ul>
</div>
<?php endif; ?>

<?php if( !empty($this->subject->class_takeaways) ): ?>
<div class='event_stats class_menu takeaways-wrapper'>
  <ul class="takeaways-list">
    <li class="list_label takeaways-title"><?php echo $this->translate('Takeaways')?></li>
    <li class="takeaways"><?php echo nl2br($this->subject->class_takeaways) ?></li>
  </ul>
</div>
<?php endif; ?>

<div class='event_stats class_menu starter-wrapper'>
  <h3><?php echo $this->translate('Menu:'); ?></h3>
  <div class="starter-list-main">
    <ul class="starter-list">
      <?php $class_starters = unserialize($this->subject->class_starter); ?>
      <?php if (!empty($this->subject->class_starter) and is_array($class_starters) and !empty($class_starters)) : ?>
        <li class="list_label starter-title"><?php echo $this->translate('Starter')?></li>
        
        <?php foreach($class_starters as $class_starter) : ?>
          <li><?php echo nl2br($class_starter); ?></li>
        <?php endforeach; ?>
      <?php endif; ?>
      
      <?php $class_mains = unserialize($this->subject->class_main); ?>
      <?php if (!empty($this->subject->class_main) and is_array($class_mains) and !empty($class_mains)) : ?>
        <li class="list_label main-course-title"><?php echo $this->translate('Main Course')?></li>
        
        <?php foreach($class_mains as $class_main) : ?>
          <li><?php echo nl2br($class_main); ?></li>
        <?php endforeach; ?>
      <?php endif; ?>
      
      <?php $class_desserts = unserialize($this->subject->class_dessert); ?>
      <?php if (!empty($this->subject->class_dessert) and is_array($class_desserts) and !empty($class_desserts)) : ?>
      <li class="list_label dessert-title"><?php echo $this->translate('Dessert')?></li>
      
      <?php foreach($class_desserts as $class_dessert) : ?>
        <li><?php echo nl2br($class_dessert); ?></li>
      <?php endforeach; ?>
      <?php endif; ?>
      
      <?php $class_beverages = unserialize($this->subject->class_beverages); ?>
      <?php if (!empty($this->subject->class_beverages) and is_array($class_beverages) and !empty($class_beverages)) : ?>
        <li class="list_label beverages-title"><?php echo $this->translate('Beverages')?></li>
        
        <?php foreach($class_beverages as $beverage) : ?>
          <li><?php echo nl2br($beverage); ?></li>
        <?php endforeach; ?>
      <?php endif; ?>
    </ul>
  </div>
  <button class="download-recipe"><?php echo $this->translate('Download a Recipe'); ?></button>
</div>

<script type="text/javascript">
  $$('.core_main_event').getParent().addClass('active');
</script>
