<?php echo $header; ?>
  <ul class="breadcrumb">
		<?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
      <?php if($i+1<count($breadcrumbs)) { ?>
				<li>
            <a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
        </li>
      <?php } else { ?>
        <li>
          <?php echo $breadcrumb['text']; ?>
        </li>
			<?php } ?>
    <?php } ?>
	</ul>

    <section id="content" class="cart_inner centered">

      <?php if ($attention) { ?>
      <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $attention; ?>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>
      <?php } ?>
      <?php if ($success) { ?>
      <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>
      <?php } ?>
      <?php if ($error_warning) { ?>
      <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>
      <?php } ?>

      <?php echo $content_top; ?>
      <h2><?php echo $heading_title; ?></h2>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
        <div class="cart_content">

           <?php foreach ($products as $product) { ?>
              <div class="cart_item">
                <?php if ($product['thumb']) { ?>
                  <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="cart_preview" />
                <?php } ?>

               <h5> <a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h5>

                <div class="cart_item_info">
                  	<?php if ($product['filters']) {
						foreach ($product['filters'] as $product_filter) {
							if ($product_filter['filter_group_id'] == $GLOBALS['info']['book_series_filter_id']) { ?>
							<div class="info_row">
								<div class="book_prop"> <?php echo $product_filter['name']; ?></div>
								<div class="book_val"><?php echo $product_filter['value']; ?></div>
							</div>
					<?php } } } ?>
				  <?php if ($product['option']) { ?>
				  	<?php foreach ($product['option'] as $option) { ?>
	                  <div class="info_row">
	                    <div class="book_prop"><?php echo $option['text']; ?></div>
	                    <div class="book_val"><?php echo $option['value']; ?></div>
	                  </div>
              	   <?php } ?>
                  <?php } ?>
                  <?php if ($product['isbn']) { ?>
                  <div class="info_row">
                    <div class="book_prop">ISBN</div>
                    <div class="book_val"><?php echo $product['isbn']; ?></div>
                  </div>
              	  <?php } ?>
                </div>

                <div class="item_summary">
                  <div class="summary_text"><?php echo $text_price_c; ?></div>
                  <div class="item_actions">
                    <div class="item_total">
                      <?php if ($product['special']) { ?>
                      <div class="sale_price"><?php echo $product['special']; ?></div>
                      <div class="old_price"><?php echo $product['price']; ?></div>
                  	  <?php } else { ?>
                      <div class="item_total"><?php echo $product['price']; ?></div>
                  	  <?php } ?>
                    </div>
                    <div class="item_change_count cart_change<?php echo $product['cart_id']; ?>">
                      <!-- здесь вопрос по инкременту и декременту, этого функционала не было -->
                      <div class="item_btn item_less" onClick="cart_minus(<?php echo $product['cart_id']; ?>)">-</div>
                      <div data-name="quantity[<?php echo $product['cart_id']; ?>]" class="item_btn item_count"><?php echo $product['quantity']; ?></div>
                      <div class="item_btn item_more" onClick="cart_plus(<?php echo $product['cart_id']; ?>)">+</div>
                    </div>
                    <div class="delete_item"  onclick="cart.remove('<?php echo $product['cart_id']; ?>');"></div>
                  </div>
                </div>

              </div>
              <?php } ?>

              <div class="cart_promos">
                <div class="promocode">
                  <?php echo $coupon; ?>
                  <?php foreach ($totals as $total) { ?>
                  <div class="promo_info">
                    <div class="promo_field"><?php echo $total['title']; ?></div>
                    <div class="promo_value cart_total"><?php echo $total['text']; ?> <?php echo $total['text_currency']; ?></div>
                  </div>
              	  <?php } ?>
                </div>
              </div>


              <a class="btn btn_grad" href="<?php echo $checkout; ?>" ><?php echo $button_checkout; ?></a>
              <a class="btn btn_outline" href="<?php echo $continue; ?>"><?php echo $button_shopping; ?></a>

        </div>
        <?php if ($discount) { ?>
        <div class="discount_program">
          <h3>Ваша скидка:</h3>
          <div class="discount_info">
            <em>3%</em> - при сумме заказа выше 250 грн 
          </div>
          <div class="discount_info">
            <em>5%</em> - при сумме заказа выше 400 грн 
          </div>

          <div class="discount_info">
            <em>7%</em> - при сумме заказа выше 800 грн 
          </div>

          <div class="discount_info">
            <em>9%</em> - при сумме заказа выше 1200 грн 
          </div>

          <div class="discount_info">
            <em>11%</em> - при сумме заказа выше 2000 грн 
          </div>
        </div>
        <?php } ?>
        
              <?php foreach ($vouchers as $voucher) { ?>
              <tr>
                <td></td>
                <td class="text-left"><?php echo $voucher['description']; ?></td>
                <td class="text-left"></td>
                <td class="text-left"><div class="input-group btn-block" style="max-width: 200px;">
                    <input type="text" name="" value="1" size="1" disabled="disabled" class="form-control" />
                    <span class="input-group-btn">
                    <button type="button" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger" onclick="voucher.remove('<?php echo $voucher['key']; ?>');"><i class="fa fa-times-circle"></i></button>
                    </span></div></td>
                <td class="text-right"><?php echo $voucher['amount']; ?></td>
                <td class="text-right"><?php echo $voucher['amount']; ?></td>
              </tr>
              <?php } ?>
           
        </div>
      </form>
      <?php if ($modules) { ?>
      <h2><?php echo $text_next; ?></h2>
      <p><?php echo $text_next_choice; ?></p>
      <div class="panel-group" id="accordion">
        <?php foreach ($modules as $module) { ?>
        <?php echo $module; ?>
        <?php } ?>
      </div>
      <?php } ?>
      <br />
      <div class="row">
        <div class="col-sm-4 col-sm-offset-8">
          <table class="table table-bordered">
            <?php foreach ($totals as $total) { ?>
            <tr>
              
            </tr>
            <?php } ?>
          </table>
        </div>
      </div>


      <?php echo $content_bottom; ?>
    <?php echo $column_right; ?>
  </section>
<script>
  function cart_minus(cart_id) {
    let quantity = parseInt($('.cart_change' + cart_id + ' .item_count').text()) - 1;

      $.ajax({
        url: 'index.php?route=checkout/cart/edit',
        type: 'post',
        data: 'key=' + cart_id + '&quantity=' + (typeof (quantity) != 'undefined' ? quantity : 1),
        dataType: 'json',
        success: function (json) {
          $('.cart_inner form').load('index.php?route=checkout/cart .cart_inner form > *');
        },
      })
  }

  function cart_plus(cart_id) {
    let quantity = parseInt($('.cart_change' + cart_id + ' .item_count').text()) + 1;

    $.ajax({
      url: 'index.php?route=checkout/cart/edit',
      type: 'post',
      data: 'key=' + cart_id + '&quantity=' + (typeof (quantity) != 'undefined' ? quantity : 1),
      dataType: 'json',
      success: function (json) {
        $('.cart_inner form').load('index.php?route=checkout/cart .cart_inner form > *');
      },
    })
  }
</script>
<?php echo $footer; ?> 