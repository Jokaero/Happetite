<h2><?php echo $this->translate("Social Connect"); ?></h2>
<p class="description"><?php echo $this->translate("_SOCIAL_CONNECT_ACCOUNT_DESCRIPTION"); ?></p>

<table cellpadding="5px" cellspacing="5px" style="border-collapse: separate">
<tbody>
<?php foreach ($this->items as $item): ?>
    <tr>
        <td valign="top">
            <a title="<?php echo $item->title;?>" href="javascript:void(0)" onclick="sopopup('<?php echo $item->getHref();?>')">
                <img src=" <?php echo $this->layout()->staticBaseUrl;?>application/modules/SocialConnect/externals/images/trans.gif?c=401" class="ynsc_sprite ynsc_sprite_<?php echo strtolower($item->name); ?>"/>
            </a>
        </td>    
        <td valign="top">
            <?php echo $item->title; ?>
        </td>
        <td valign="top">
            <?php if(isset($this->agents[$item->getIdentity()])): ?>
                <?php foreach($this->agents[$item->getIdentity()] as $agent): ?>
                    <div>
                        <span><?php echo isset($agent->status)?$agent->status:$this->translate('united name'); ?></span> - <span class="timestap"><?php echo $this->timestamp($agent->login_time)?></span>
                    </div>
                <?php endforeach; ?>
            <?php endif; ?>            
        </td>
    </tr>   
    <?php endforeach; ?> 
</tbody>    
</table>