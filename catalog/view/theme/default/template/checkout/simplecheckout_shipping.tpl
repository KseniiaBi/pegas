<div class="simplecheckout-block checkout_tbs" id="simplecheckout_shipping" <?php echo $hide ? 'data-hide="true"' : '' ?> <?php echo $display_error && $has_error ? 'data-error="true"' : '' ?>>
    <?php if ($display_header) { ?>
        <h2 class="checkout-heading panel-heading"><?php echo $text_checkout_shipping_method ?></h2>
    <?php } ?>
    <div class="alert alert-danger simplecheckout-warning-block" <?php echo $display_error && $has_error_shipping ? '' : 'style="display:none"' ?>><?php echo $error_shipping ?></div>
    <div class="simplecheckout-block-content deliv_tabs tabs" data-id="deliv_tabs">
        <div class="deliv_btns">
            <div data-id="deliv_multiflat" class="tab_name deliv_tabs <?php if ($active_tab == '1') { echo 'active'; } ?>">
                <img src="image/checkout/delivery_post.svg" alt="">
                <div class="deliv_type">Доставка <br>почтой</div>
            </div>
            <div data-id="deliv_flat" class="tab_name deliv_tabs <?php if ($active_tab == '2') { echo 'active'; } ?>">
                <img src="image/checkout/delivery_courier.svg" alt="">
                <div class="deliv_type">Курьерская <br>доставка</div>
            </div>
            <div data-id="deliv_pickup" class="tab_name deliv_tabs <?php if ($active_tab == '3') { echo 'active'; } ?>">
                <img src="image/checkout/delivery_self.svg" alt="">
                <div class="deliv_type">Пункт выдачи</div>
            </div>
        </div>
        <div class="deliv_content">
        <?php if (!empty($shipping_methods)) { ?>
            <?php if ($display_type == 2 ) { ?>
                <?php $current_method = false; ?>
                <select data-onchange="reloadAll" name="shipping_method">
                    <?php foreach ($shipping_methods as $shipping_method) { ?>
                        <?php if (!empty($shipping_method['title'])) { ?>
                        <optgroup label="<?php echo $shipping_method['title']; ?>">
                        <?php } ?>
                        <?php if (empty($shipping_method['error'])) { ?>
                            <?php foreach ($shipping_method['quote'] as $quote) { ?>
                                <option value="<?php echo $quote['code']; ?>" <?php echo !empty($quote['dummy']) ? 'disabled="disabled"' : '' ?> <?php echo !empty($quote['dummy']) ? 'data-dummy="true"' : '' ?> <?php if ($quote['code'] == $code) { ?>selected="selected"<?php } ?>><?php echo $quote['title']; ?><?php echo !empty($quote['text']) && !$hide_cost ? ' - '.$quote['text'] : ''; ?></option>
                                <?php if ($quote['code'] == $code) { $current_method = $quote; } ?>
                            <?php } ?>
                        <?php } else { ?>
                            <option value="<?php echo $shipping_method['code']; ?>" disabled="disabled"><?php echo $shipping_method['error']; ?></option>
                        <?php } ?>
                        <?php if (!empty($shipping_method['title'])) { ?>
                        </optgroup>
                        <?php } ?>
                    <?php } ?>
                </select>
                <?php if ($current_method) { ?>
                    <?php if (!empty($current_method['description'])) { ?>
                        <div class="simplecheckout-methods-description"><?php echo $current_method['description']; ?></div>
                    <?php } ?>
                    <?php if (!empty($rows)) { ?>
                        <?php foreach ($rows as $row) { ?>
                          <?php echo $row ?>
                        <?php } ?>
                    <?php } ?>
                <?php } ?>
            <?php } else { ?>
                <?php $x = 0; ?>
                <?php foreach ($shipping_methods as $shipping_method) { $x++; ?>
                    <div id="deliv_<?php echo $shipping_method['code']; ?>" class="tab deliv_tabs <?php if ($x == $active_tab) {?>active<?php } ?>">
                    <?php if (!empty($shipping_method['warning'])) { ?>
                        <div class="simplecheckout-error-text"><?php echo $shipping_method['warning']; ?></div>
                    <?php } ?>
                    <?php if (empty($shipping_method['error'])) { ?>
                        <?php foreach ($shipping_method['quote'] as $quote) { ?>
                                <div class="deliv_block">
                                    <div class="radiobtn">
                                        <input type="radio" data-onchange="reloadAll" name="shipping_method"  <?php echo !empty($quote['dummy']) ? 'disabled="disabled"' : '' ?> <?php echo !empty($quote['dummy']) ? 'data-dummy="true"' : '' ?> value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>" <?php if ($quote['code'] == $code) { ?>checked="checked"<?php } ?> />
                                        <label for="<?php echo $quote['code']; ?>"></label>  
                                    </div>
                                    <div class="deliv_title"><?php echo !empty($quote['title']) ? $quote['title'] : ''; ?><?php echo !empty($quote['text']) && !$hide_cost ? ' - ' . $quote['text'] : ''; ?></div>
                                    <?php if (!empty($quote['description']) && (!$display_for_selected || ($display_for_selected && $quote['code'] == $code))) { ?>
                                    <div class="deliv_text">
                                        <?php echo $quote['description']; ?>
                                    </div>
                                    <?php } ?>
                                </div>
                                <?php if ($quote['code'] == $code && !empty($rows)) { ?>
                                    <?php foreach ($rows as $row) { ?>
                                      <?php echo $row ?>
                                    <?php } ?>
                                <?php } ?>
                        <?php } ?>
                    <?php } else { ?>
                        <div class="simplecheckout-error-text"><?php echo $shipping_method['error']; ?></div>
                    <?php } ?>  
                    </div>
                <?php } ?>

            <?php } ?>
            <input type="hidden" name="shipping_method_current" value="<?php echo $code ?>" />
            <input type="hidden" name="shipping_method_checked" value="<?php echo $checked_code ?>" />
        <?php } ?>

        <?php if (empty($shipping_methods) && $address_empty && $display_address_empty) { ?>
            <div class="simplecheckout-warning-text"><?php echo $text_shipping_address; ?></div>
        <?php } ?>
        <?php if (empty($shipping_methods) && !$address_empty) { ?>
            <div class="simplecheckout-warning-text"><?php echo $error_no_shipping; ?></div>
        <?php } ?>
        </div>
    </div>
</div>
<script>
    if(typeof Tabs == 'function') {
        let tabs = document.querySelectorAll('.tabs');

        if(tabs.length > 0){
            for(let i = 0; i < tabs.length; i++){
                let tabId = tabs[i].dataset.id;
                let t = new Tabs(tabs[i],tabId);
            }
        }
    }
</script>