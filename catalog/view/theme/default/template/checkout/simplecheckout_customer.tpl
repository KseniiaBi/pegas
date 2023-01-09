<style>

.row-shipping_address_field20{display:none!important;}
.quantity input{padding:0!important;}
.simplecheckout-left-column label{text-align:left!important;}
.simplecheckout-left-column .simplecheckout-block-content{padding:0!important;}
#simplecheckout_customer .form-group .control-label{margin-bottom:3px;}
.simplecheckout-left-column input[type="text"], #comment, .simplecheckout-left-column input[type="tel"], .simplecheckout-left-column textarea, .simplecheckout-left-column input[type="email"], .simplecheckout-left-column input[type="password"]{height:auto;border-radius:0;width: 100%;border: 1px solid #3b3b3b;font-size: 18px;color: #000;padding: 15px 20px;line-height: 110%;}
.checkout-simplecheckout .breadcrumb{display:none;}
.simplecheckout-cart col.image{width:0!important;}
.quantity .btn-success{display:none!important;}
.simplecheckout .btn-primary{width:auto!important;}
.checkout-heading panel-heading{font-size: 20px;font-weight: bold;}
</style>
<div class="simplecheckout-block" id="simplecheckout_customer" <?php echo $hide ? 'data-hide="true"' : '' ?> <?php echo $display_error && $has_error ? 'data-error="true"' : '' ?>>

  <?php /* echo $rules; */ ?>
<div class="tabs" data-id="log_reg_tabs">
  <?php if ($display_header || $display_login) { ?>
  <div class="tabs_names">
    <div data-id="tab_register" class="log_reg_tabs tab_name active"><?php echo $text_checkout_customer ?></div>
    <?php if (!$logged) { ?>
    <div data-id="tab_login" class="log_reg_tabs tab_name"><?php echo $text_checkout_customer_login ?></div>
    <?php } ?>
  </div>
<!--   <div class="checkout-heading panel-heading"><span></span><?php if ($display_login) { ?><span class="checkout-heading-button"><a href="javascript:void(0)" data-onclick="openLoginBox"><?php echo $text_checkout_customer_login ?></a></span><?php } ?></div> -->
  <?php } ?>
  <div class="tabs_content">
  <div id="tab_register" class="simplecheckout-block-content log_reg_tabs tab register_inner active">
    <div class="register_form">
    <?php if ($display_registered) { ?>
      <div class="alert alert-success"><?php echo $text_account_created ?></div>
    <?php } ?>
    <?php if ($display_you_will_registered) { ?>
      <div class="you-will-be-registered"><?php echo $text_you_will_be_registered ?></div>
    <?php } ?>
    <?php foreach ($rows as $row) { $row = str_replace(array('col-sm-4','col-sm-8'), array('col-sm-12','col-sm-12'), $row); ?>
      <?php echo $row ?>
    <?php } ?>
    </div>
    <div class="goto_register">
                  <img src="image/checkout/newacc.svg" alt="">
                  <h3><?php echo $text_r_register; ?></h3>
                  <p><?php echo $text_r_descr; ?></p>
    </div>
  </div>
  <?php echo $simplecheckout_login; ?>
</div>
</div>
</div>
