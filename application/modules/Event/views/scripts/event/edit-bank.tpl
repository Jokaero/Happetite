<div class="generic_layout_container layout_middle">
    <div class="generic_layout_container layout_core_html_block">
        <div class="page_main_photo">
            <div>
                <div class="page_main_photo_center">
                        <img src="/application/themes/happetite/images/host-img.jpg" alt="">
                </div>
                <div class="page_main_photo_triangle"></div>
                <div class="page_main_photo_pattern"></div>
            </div>
        </div>
    </div>
</div>

<div class="form-outer-title"><?php echo $this->translate('BANK ACCOUNT INFORMATION'); ?></div>
<div class="form-outer-description"><?php echo nl2br($this->translate('We will not share your banking details with third parties. Please Check our %s for more details', $this->htmlLink('/help/privacy', $this->translate('Privacy Policy')))); ?></div>
<?php echo $this->form->render($this) ?>
<div class="form-outer-notice"><?php echo $this->translate('Fields marked with an asterisk %s are mandatory', '<span>*</span>'); ?></div>
