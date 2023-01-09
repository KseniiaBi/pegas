<?php echo $header; ?>
<div class="container">
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

<div class="cabinet_inner centered">

   <?php echo $column_left; ?>


    <section class="user_space">
        <h2><?php echo $heading_title; ?></h2>
      <?php if ($orders) { ?>


    <div class="accordeon account_accordeon">

      <?php foreach ($orders as $order) { ?>
        <div class="accordeon_item acc_orders ">
          <div class="accordeon_title">
            <div class="order_info">
              <div class="order_date"><?php echo str_replace('/', '.', $order['date_added']); ?></div>
              <div class="order_num">
                <?php echo $column_order_id; ?>  
                <?php echo $order['order_id']; ?>
                </div>
            </div>
            <div class="order_amount">
              <div class="amount_text"><?php echo $column_total; ?></div>
              <div class="amount_sum"><?php echo $order['total']; ?></div>
            </div>
          </div>
          <div class="accordeon_content">
            <?php if ($order['products']) { ?>
              <?php foreach ($order['products'] as $product) { ?>

                <!-- data-id="" - пробросить id книги -->
                <div class="order_item" data-id="<?php echo $product['product_id']; ?>">
                  <img class="order_preview" src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>">
                  <div class="order_book_info">
                    <div class="order_book_det">
                      <div class="ordered_name"><?php echo $product['name']; ?></div>

                      <?php if ($product['filters']) { ?>
                      
                      <?php foreach ($product['filters'] as $product_filter) {
                        if ($product_filter['sort_order'] < 100) {
                          if ($product_filter['filter_group_id'] == $GLOBALS['info']['book_series_filter_id']) { ?>
                            <div class="ordered_row">
                              <div class="ordered_prop"><?php echo $product_filter['name']; ?></div>
                              <div class="ordered_val"><?php echo $product_filter['value']; ?></div>
                            </div>
                        <?php 
                          }
                        }
                      } ?>
                      
                    <?php } ?>
                    

                      <?php if ($product['option']) { ?>
                        <?php foreach ($product['option'] as $option) { ?>
                          <div class="ordered_row">
                            <div class="ordered_prop"><?php echo $option['name']; ?></div>
                            <div class="ordered_val"><?php echo $option['value']; ?></div>
                          </div>
                        <?php } ?> 
                      <?php } ?>
                      <?php if ($product['isbn']) { ?>
                      <div class="ordered_row">
                        <div class="ordered_prop">ISBN</div>
                        <div class="ordered_val"><?php echo $product['isbn']; ?></div>
                      </div>
                      <?php } ?>
                    </div>
                    <div class="order_book_sum">
                      <span class="ordered_count"><?php echo $product['quantity']; ?></span>
                      <span class="ordered_amount"><?php echo $product['total']; ?></span>
                    </div>
                  </div>
                </div>
              <?php } ?>

            <?php } ?>

            <div class="client_info">
              <div class="cl_info_name"><?php echo $order['name']; ?></div>
              <div class="cl_info_tel"><?php echo $order['telephone']; ?></div>
              <div class="cl_info_addr"><?php echo $order['shipping_address']; ?></div>
            </div>

            <?php if ($order['totals']) { ?>
              <div class="order_summary">
              <?php foreach ($order['totals'] as $total) { ?>
                  <div class="order_info_row">
                    <div class="o_i_prop"><?php echo $total['title']; ?></div>
                    <div class="o_i_val"><?php echo $total['text']; ?></div>
                  </div>
              <?php } ?>
              </div>
            <?php } ?>

            <div class="order_actions">
              <button class="btn btn_bordered show_rev_md"><span>Оставить отзыв</span></button>
              <a href="<?php echo $reorder; ?>" class="btn btn_grad">Повторить заказ</a>
            </div>

          </div>
        </div>
        <?php } ?>
    </div>


      <div class="text-right"><?php echo $pagination; ?></div>
      <?php } else { ?>
      <p><?php echo $text_empty; ?></p>
      <?php } ?>
      
      <a href="<?php echo $continue; ?>" class="btn btn_grad"><?php echo $button_continue; ?></a>
    </section>
</div>


<!-- modal select book for review -->


  <div id="book_for_review" class="modal">
    <div class="modal_content">
      <div class="closebtn"></div>
      <h2>Оставьте отзыв о книге</h2>

      <main></main>

    </div>
  </div>

<!-- modal leave review -->

  <div class="modal" id="leave_rev_md">
    <div class="modal_content">
      <div class="closebtn"></div>
      <h2><?php echo $text_write; ?></h2>
      <form class="review_form form-horizontal" id="form-review">

        <?php if ($review_guest) { ?>

        <div class="form-group required rev_stars">
          <div class="rev_star">
            <input id="r1" type="radio" name="rating" value="1" />
            <label for="r1">
              <div class="star not_filled"></div>
              <div class="rev_descr"><?php echo $entry_bad; ?></div>
            </label>
          </div>
          <div class="rev_star">
            <input id="r2" type="radio" name="rating" value="2" />
            <label for="r2">
              <div class="star not_filled"></div>
              <div class="rev_descr">Так себе</div>
            </label>
          </div>
          <div class="rev_star">
            <input id="r3" type="radio" name="rating" value="3" />
            <label for="r3">
              <div class="star not_filled"></div>
              <div class="rev_descr">Нормальная</div>
            </label>
          </div>
          <div class="rev_star">
            <input id="r4" type="radio" name="rating" value="4" />
            <label for="r4">
              <div class="star not_filled"></div>
              <div class="rev_descr"><?php echo $entry_good; ?></div>
            </label>
          </div>
          <div class="rev_star">
            <input id="r5" type="radio" name="rating" value="5" />
            <label for="r5">
              <div class="star not_filled"></div>
              <div class="rev_descr">Отличная</div>
            </label>
          </div>

        </div>
        <fieldset>
            <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
            <input type="text" name="name" value="<?php echo $customer_name; ?>" id="input-name" class="form-control" />
        </fieldset>
        <fieldset>
            <label class="control-label" for="input-review"><?php echo $entry_review; ?></label>
            <textarea name="text" rows="5" id="input-review" class="form-control"></textarea>
            <div class="help-block"><?php echo $text_note; ?></div>
        </fieldset>
        <?php echo $captcha; ?>
          <button type="reset" class="reset_review btn btn_bordered "><span>Отменить</span></button>
          
          <button type="button" id="button-review" data-loading-text="<?php echo $text_loading; ?>" class="btn btn_grad"><?php echo $button_continue; ?></button>
        <?php } else { ?>
        <?php echo $text_login; ?>
        <?php } ?>
      </form>
    </div>
  </div>


<script>
  $('#button-review').on('click', function() {
    let bookID = $('#button-review').dataset.id;
    $.ajax({
      url: `index.php?route=product/product/write&product_id=${bookID}`,
      type: 'post',
      dataType: 'json',
      data: $("#form-review").serialize(),
      success: function(json) {
        $('.alert-success, .alert-danger').remove();

        if (json['error']) {
          $('#form-review').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
        }

        if (json['success']) {
          $('#form-review').after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');

          $('input[name=\'name\']').val('');
          $('textarea[name=\'text\']').val('');
          $('input[name=\'rating\']:checked').prop('checked', false);
        }
      }
    });
  });
</script>

<?php echo $footer; ?>