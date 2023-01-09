<div id="tab_login" class="log_reg_tabs tab login_inner">
<div class="login_form">
    <div class="simplecheckout-block" id="simplecheckout_login" <?php echo $has_error ? 'data-error="true"' : '' ?>>
        <div class="simplecheckout-block-content">
            <div id="simple_login_header"></div>
            <?php if ($error_login) { ?>
            <div class="alert alert-danger simplecheckout-warning-block"><?php echo $error_login ?></div>
            <?php } ?>
            <fieldset>
                <div class="form-group">
                    <label class="control-label"><?php echo $entry_email; ?></label>
                    <input class="form-control login_email" type="text" name="lemail" value="<?php echo $email; ?>" /></label>
                </div>
                <div class="form-group login_result">
                    <label class="control-label"><?php echo $entry_password; ?></label>
                    <input class="form-control login_password" type="password" name="lpassword" value="" /></label>
                </div>
                    <div class="log_links">
                        <span class="remember">
                            <input id="rememberme" type="checkbox" name="rememberme">
                            <label for="rememberme"></label>
                            <?php echo $text_remember; ?>
                        </span>
                                                    
                        <a class="forgot" href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a>
                    </div>
                <a id="login-btn" class="button  btn btn_grad"><span><?php echo $button_login; ?></span></a>
            </fieldset>
        </div>     
    </div>
</div>
<div class="goto_register">
    <img src="image/checkout/newacc.svg" alt="">
    <h3><?php echo $text_n_account; ?></h3>
    <p><?php echo $text_n_descr; ?></p>
    <a href="<?php echo $create; ?>" class="btn btn_grad"><?php echo $text_n_create; ?></a>
</div>
</div>
<script type="text/javascript"><!--
	$('#login-btn').on('click', function () {

		$.ajax({
			url: 'index.php?route=account/login/json',
			type: 'post',
			dataType: 'json',
			data: $('.login_form input[type=\'text\'], .login_form input[type=\'password\']'),
			success: function (json) {
				$('.login_result .simplecheckout-error-text').remove();

				if (json['error']) {
					$('.login_result').append('<div class="simplecheckout-error-text simplecheckout-rule">' + json['error'] + '</div>');
				}

				if (json['success']) {
					location.reload();
				}
			},
			error: function (xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	});
	//--></script>
