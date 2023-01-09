<h5 class="promo_heading"><?php echo $heading_title; ?></h5>
<input type="text" name="coupon" value="<?php echo $coupon; ?>" placeholder="<?php echo $entry_coupon; ?>" id="input-coupon" class="form-control" />
<input type="button" value="<?php echo $button_coupon; ?>" id="button-coupon" class="btn btn_grad" data-loading-text="<?php echo $text_loading; ?>" />

<script type="text/javascript"><!--
  $('#button-coupon').on('click', function() {
    $.ajax({
      url: 'index.php?route=total/coupon/coupon',
      type: 'post',
      data: 'coupon=' + encodeURIComponent($('input[name=\'coupon\']').val()),
      dataType: 'json',
      success: function(json) {
        $('.alert').remove();

        if (json['error']) {
          $('.breadcrumb').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');

          $('html, body').animate({ scrollTop: 0 }, 'slow');
        }

        if (json['redirect']) {
          location = json['redirect'];
        }
      }
    });
  });
  //--></script>
