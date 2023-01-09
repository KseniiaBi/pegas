<?php echo $header; ?>
<div class="product-page">

    <!-- Хлебные крошки -->
	<ul class="breadcrumb">
		<?php $seria_link = ''; foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
        	<?php if($i+1<count($breadcrumbs)) { $seria_link = $breadcrumb['href']; ?>
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

    <!-- описание товара -->
	<div class="book_view centered book-info <?php echo $gallery > 0 ? 'children-event' : '';?> <?php echo ($special ? 'akcii-sell' : '');?> <?php echo ($stock_count > 0 ? '' : 'outofstock'); ?>">
		<?php if ($category_name) { ?><h2><?php echo $category_name; ?></h2><?php } ?>

		<?php if ($thumb || $images) { ?>
		<div class="book_preview">
			<?php if ($thumb) { ?>
				<div class="main_img">
					<img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" />
				</div>
			<?php } ?>

			<?php if ($images) { ?>

				<div class="book_pictures carousel">
					<div class="miniatures_prev btn_prev"></div>
					<div class="book_carousel_outer">
						<div class="book_preview_wrap">
							<?php foreach ($images as $image) { ?>
								<img class="book_miniature" src="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" />
							<?php } ?>
						</div>
					</div>
					<div class="miniatures_next btn_next"></div>
				</div>

			<?php } elseif ($thumb) { ?>
				<div class="book_pictures carousel">
						<div class="miniatures_prev btn_prev inactive"></div>
						<div class="book_carousel_outer">
							<div class="book_preview_wrap">
									<img class="book_miniature" src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" alt="">	
							</div>
						</div>
						<div class="miniatures_next btn_next inactive"></div>
				</div>
			<?php } ?>
		</div>
		<?php } ?>
		<div class="book_info">
			<div class="book_name"><?php echo $heading_title; ?></div>
			<div class="book_short_descr"><?php echo $heading_subtitle; ?></div>

			<div class="rating rating-<?php echo $rating; ?>" data-rating="<?php echo $rating; ?>">
				<div class="star filled"></div>
				<div class="star filled"></div>
				<div class="star filled"></div>
				<div class="star filled"></div>
				<div class="star filled"></div>
			</div>
			<div class="price <?php if ($special) { ?>sale<?php } ?>">
				<?php if ($price) { ?>
					<?php if(!$special) { ?>
							<span class="prop_name"><?php echo $text_price_c; ?></span><?php echo $price; ?> <?php echo $text_currency; ?>
					<?php } else { ?>
					<span class="prop_name"><?php echo $text_price_c; ?></span>
					<div class="price_new">
						<?php echo $special; ?><i><?php echo $text_currency; ?>
					</div>
					<div class="price_old">
						<div class="full_price">
							<?php echo $price; ?> <?php echo $text_currency; ?>
						</div>
						<?php if($akchia){ ?>
							<div class="disc_amount">
									<?php echo $text_akchia; ?>
									<?php if($discount_percent != 0){ ?>
									<br>
									<?php echo $discount_percent; ?>%
								<?php } ?>
							</div>
						<?php } ?>
					</div>
					
						<?php } ?>
				<?php } ?>
			</div>

							<?php  foreach ($options as $option) { ?>
								<div class="book-lang<?php echo ($option['required'] ? ' required' : ''); ?>" id="input-option<?php echo $option['product_option_id']; ?>">
									 <?php
										 if($lang_code == 3){ //ua
											 $option['product_option_value'] = array_reverse($option['product_option_value']);
										 }
									 ?>
									 <?php foreach ($option['product_option_value'] as $option_value) { ?>
									 <div class="radio custom_select_lang">
											 <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="<?php echo $option_value['product_option_value_id']; ?>" />
											 <label class="cliked_label book_lang_item" data-prefix="<?php echo $option_value['price_prefix']; ?>" data-price="<?php echo str_replace(",", ".", $option_value['price']); ?>" data-code="<?php echo $option_value['code']; ?>" data-quantity="<?php echo $option_value['quantity']; ?>" data-stock="<?php echo $option_value['stock']; ?>" id="lang_label_<?php echo ($option_value['name'] == 'русский' || $option_value['name'] == 'російська')?2:3; ?>" title="<?php echo $option['name']; ?> - <?php echo $option_value['name']; ?> <?php if ($option_value['price']) { ?>(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)<?php } ?>" for="<?php echo $option_value['product_option_value_id']; ?>">
												 <?php echo $option_value['name']; ?>
											 </label>
									 </div>
									 <!-- reservation block -->
									 <?php if($option_value['quantity'] <= 0) { ?>
										<div class="reserve_form">
											<span class="reserve_title"><?php echo $text_uon; ?></span>
									  	<form class="reserveBook" action="index.php?route=product/reserve/addReserve" method="post">
										 		<input type="email" name="email" value="" placeholder=" Ваш e-mail">
										 		<input type="hidden" name="productId" value="<?php echo $product_id; ?>">
										 		<input type="hidden" name="optionId" value="<?php echo $option_value['product_option_value_id']; ?>">
										 		<input type="submit" value="<?php echo $text_uon_send; ?>">
										  </form>
										</div>
									<?php } ?>
									 <!-- reservation block -->
									 <?php } ?>
								 </div>
							<?php } ?>
			<?php if ($other_lang) { ?>
			<div class="book_lang">
			<?php foreach ($other_lang as $lang) { ?>
				<a class="book_lang_item <?php if ($lang['active']) { echo ' active'; } ?>" href="<?php echo $lang['href']; ?>"><?php echo $lang['name']; ?></a>
			<?php } ?>
			</div>
			<?php } ?>
			<div class="book_actions">
				<div class="buy btn btn_grad  btn-buy <?php echo ($product['quantity'] > 0 ? '' : 'product_not_av');?>" 
					<?php if($product['quantity'] > 0) {?> onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');" <?php }else{}?>><?php echo $button_cart; ?>
					<img src="catalog/view/theme/THEME/img/cart.svg" alt="корзина">
				</div>
				<!-- <div class="buy btn btn_grad">Добавить в  <img src="img/cart.svg" alt="корзина"></div> -->
				<div class="btn btn_bordered like"><img src="./catalog/view/theme/THEME/img/heart_grad.svg" alt=""></div>
			</div>

					<?php if ($product_filters) { ?>
						<div class="book_series">
						<?php foreach ($product_filters as $product_filter) {
							if ($product_filter['sort_order'] < 100) {
								if ($product_filter['filter_group_id'] == $GLOBALS['info']['book_series_filter_id']) { // если это фильтр "Серия (книги)"
									echo " $product_filter[name]: $product_filter[value]";
								}
							}
						} ?>
						</div>
					<?php } ?>
			<?php if ($isbn) { ?>
			<div class="isbn">
				<span class="prop_name">ISBN</span> <?php echo $isbn; ?>
			</div>
			<?php } ?>
			<div class="available <?php if($stock_count > 0) {?>instock<?php } else {?>outofstock<?php } ?>"><?php echo $stock; ?></div>

			<p class="book_fulldescr">
				<?php echo $description; ?>
			</p>
		</div>

		<div class="book_tabs tabs" data-id="book_inner_tabs">
			<div class="tabs_names">
				<div data-id="tab_ch" class="book_inner_tabs tab_name active"><?php echo $tab_attribute; ?></div>
				<div data-id="tab_delivery" class="book_inner_tabs tab_name"><?php echo $text_block_head1; ?></div>
				<div data-id="tab_rev" class="book_inner_tabs tab_name "><?php echo $tab_review; ?></div>
			</div>

			<div class="tabs_content">
				<div id="tab_ch" class="tab book_inner_tabs active">
					<div class="details">
						<div id="det_col1"  class="details_col">
							<?php
										if ($product_filters) {
											foreach ($product_filters as $product_filter) {
												if ($product_filter['sort_order'] < 100) {
													
														echo "<div class='details_row'><div class='details_name'>$product_filter[name]: </div> <div class='details_text'>$product_filter[value]</div></div>";
													
												}
											}
										}
									?>
						</div>

						<!-- <div class="det_actions showmobile">
							<div class="btn_prev dc_prev inactive"></div>
							<div class="dc_next btn_next"></div>
						</div>	 -->
					</div>

				</div>
				<div id="tab_delivery" class="tab book_inner_tabs">
					<p><?php echo $text_block_ship;?> 
                        <?php echo $text_block_ship_days;?>
                    </p>
                    <p><?php echo $text_block_ship_pay;?></p>
				</div>
				<div id="tab_rev" class="tab book_inner_tabs">
					<div class="rev_carousel">
						<div class="btn_prev rev_prev inactive"></div>

						<div class="review_wrap">
							
						</div>
						<div class="btn_next rev_next inactive"></div>
					</div>
					<?php if ($count_reviews > 5 ) { ?>}
					<button disabled class="view_all_rev btn btn_bordered">
						<span><?php echo $text_view_all; ?></span>
					</button>
					<?php } ?>
					<button class="btn_grad btn leave_rev"><?php echo $text_com_prod; ?></button>

				</div>
			</div>
		</div>

	</div>


	<?php if ($video_link) { ?>
		<section class="book_video centered">
			<h2>Youtube канал</h2>
			<div class="video">
				<iframe class="morevid" width="100%" height="366px" src="<?php echo $video_link; ?>" frameborder="0" allowfullscreen></iframe>
			</div>
		</section>
	<?php } ?>


			<div class="col-md-6 col-sm-6">
				<div class="wrap-info">
					


                    <div class="row">

                    <!-- описание  для галереи -->
						<div class="text-gallery" style="<?php echo $gallery > 0 ? '' : 'display:none';?>">
							<?php echo $description; ?>
						</div>

						<div class="col-md-6" id="product" style="<?php echo $gallery > 0 ? 'display:none' : '';?>">

						</div>

					</div>
				</div>
		</div>
		


			 </div>
		 </div> <!-- окончание описания товара -->


	<?php if ($products) { ?>
		<section class="books <?php echo $class;?>">
	
		<h2><?php echo $gallery > 0 ? $text_gallery_carusel : $text_related; ?></h2>
			<div class="book_carousel grid_faded">
				<div class="mask_prev"></div>
				<div class="btn_prev books_prev invisible"></div>

				<div class="books_wrap">
					<?php foreach ($products as $product) { ?>
						<div class="book_item <?php if($product['quantity'] > 0) {?>instock<?php } else {?>outofstock<?php } ?>">
							<div class="book_inner ">
								<div class="closebtn"></div>
								<div class="book_preview">
									<div class="main_img">
										<img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>">
										<div class="book_show">	
											<button class="book_show_preview btn btn_grad"><?php echo $text_preview; ?></button>
										</div>
									</div>
									<?php if ($product['images']) { ?>
									<div class="book_pictures carousel">
										<div class="miniatures_prev btn_prev"></div>
										<div class="book_carousel_outer">
											<div class="book_preview_wrap">
												<?php foreach ($product['images'] as $image) { ?>
												<img class="book_miniature" src="<?php echo $image['popup']; ?>" alt="">	
												<?php } ?>
											</div>
										</div>
										<div class="miniatures_next btn_next"></div>
									</div>
									<?php } ?>
								</div>

								<div class="book_info">
									<a href="<?php echo $product['href']; ?>" class="book_href"><?php echo $product['name']; ?></a>
									
									<!-- пробросить рейтинг -->
									<?php if ($product['rating']) { ?>

									<div class="rating">
										<?php for ($i = 1; $i <= 5; $i++) { ?>
								          <?php if ($product['rating'] < $i) { ?>
								          <div class="star filled"></div>
								          <?php } else { ?>
								          <div class="star not_filled"></div>
								          <?php } ?>
								         <?php } ?>
									</div>
									<?php } ?>
									<div class="price <?php if ($product['special']) { ?>sale<?php } ?>">
										<?php if ($product['price']) { ?>
											<?php if(!$product['special']) { ?>
														<?php echo $product['price']; ?> <?php echo $text_currency; ?>
											<?php } else { ?>
											<span class="prop_name"><?php echo $text_price_c;?></span>
											<div class="price_new">
												<?php echo $product['special']; ?><i><?php echo $text_currency; ?>
											</div>
											<div class="price_old">
												<div class="full_price">
													<?php echo $product['price']; ?> <?php echo $text_currency; ?>
												</div>
												<?php if($product['akchia']){ ?>
													<div class="disc_amount">
															<?php echo $text_akchia; ?>
															<?php if($product['discount_percent'] != 0){ ?>
															<br>
															<?php echo $product['discount_percent']; ?>%
														<?php } ?>
													</div>
												<?php } ?>
											</div>
											
												<?php } ?>
										<?php } ?>
									</div>

						

									<div class="book_lang">
										<a class="book_lang_item active" href="#">Русский</a>
										<a class="book_lang_item" href="#">Украинский</a>
									</div>

									<div class="book_actions">
										<div class="buy btn btn_grad  btn-buy <?php echo ($product['quantity'] > 0 ? '' : 'product_not_av');?>" 
											<?php if($product['quantity'] > 0) {?> onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');" <?php }else{}?>><?php echo $button_cart; ?>
											<img src="catalog/view/theme/THEME/img/cart.svg" alt="корзина">
										</div>
										<!-- <div class="buy btn btn_grad">Добавить в  <img src="img/cart.svg" alt="корзина"></div> -->
										<div class="btn btn_bordered like" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><img src="catalog/view/theme/THEME/img/heart_grad.svg" alt=""></div>
									</div>

									<div class="book_series">
										<?php
												if ($product['filters']) {
													foreach ($product['filters'] as $product_filter) {
														if ($product_filter['filter_group_id'] == $GLOBALS['info']['book_series_filter_id']) { // если это фильтр "Серия (книги)"
															echo " $product_filter[name]: $product_filter[value] ";
														}
													}
												}
											?>
									</div>
									 <!-- пробросить isbn -->
									 <?php if (!empty($product['isbn'])) { ?>
									<div class="isbn">
										<span class="prop_name">ISBN</span> <?php $product['isbn']; ?>
									</div>
									<?php } ?>
									<!-- второй класс меняется instock : outofstock -->
									<div class="available <?php if($product['quantity'] > 0) {?>instock<?php } else {?>outofstock<?php } ?>"><?php echo $product['stock']; ?></div>
									

									<!-- Длинное описание книги -->
									<p class="book_fulldescr"> 
										<?php echo $product['description']; ?>
									</p>

									<a href="<?php echo $product['href']; ?>" class="btn btn_bordered"><span><?php echo $text_more; ?></span> </a>
								</div>
							</div>

						</div>
					<?php } ?>
				</div>
				<div class="mask_next"></div>
				<div class="btn_next books_next"></div>
			</div>
		</section>
	<?php } ?>
	<?php if($stock_count <= 0) { ?>
			<div class="col-md-12 col-sm-6 block-position">

				<div class="book-story clearfix">
					<div class="seria-video hidden-sm hidden-xs">

					<?php if ($video_link) { ?>
						<div class="video">
							<iframe width="100%" height="366px" src="<?php echo $video_link; ?>" frameborder="0" allowfullscreen></iframe>
						</div>
					<?php } ?>
				<div class="link-serii">
					<?php
						if ($product_filters) {
							foreach ($product_filters as $product_filter) {
								if ($product_filter['filter_group_id'] == $GLOBALS['info']['book_series_filter_id']) { // если это фильтр "Серия (книги)"
									//echo "<a href=\"" . $GLOBALS['lnk']['literature_catalog'] . "&filter=$product_filter[filter_id]\" class=\"obzor\">$seria_overview</a>";
									echo "<a href=\"" . $GLOBALS['lnk']['literature_catalog'] . "&filter=$product_filter[filter_id]\" class=\"all-books link-hover\">$seria_all_books<i class=\"arrow-ico\"></i></a>";
								}
							}
						}
					?>
				</div>
					</div>
					<div class="text">
						<?php echo $description; ?>
					</div>
					<button class="btn-show-opisanie visible-sm visible-xs"><?php echo $text_show_more; ?> <i class="fa fa-chevron-down"></i></button>
				</div>
		</div>
	<?php } ?>

	<?php if ($review_status) { ?>

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


	$('.review_wrap').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

	$('#button-review').on('click', function() {
		$.ajax({
			url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
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
	<?php } ?>

<!-- FB page -->
<?php /*
<div class="fb-page" data-href="https://www.facebook.com/pegaspublishing/" data-tabs="timeline, events" data-width="500" data-height="300" data-small-header="true" data-adapt-container-width="true" data-hide-cover="true" data-show-facepile="true"><blockquote cite="https://www.facebook.com/pegaspublishing/" class="fb-xfbml-parse-ignore"><a href="https://www.facebook.com/pegaspublishing/" rel="nofollow" target="_blank">Пегас, Видавничий дім</a></blockquote></div>
*/?>
<!-- FB page -->



	<?php echo $content_bottom; ?>
</div>



	<script type="text/javascript">

	$(document).ready(function() {
		bindBuyActionToButton('#button-cart', '.book-info');
		bindBuyActionToButton('.btn-modal-buy', '.book-modal.modal.fade.in', function() {
			$('.book-modal.modal.fade.in').modal('toggle');
		});
		$('.btn-buy').click(function(){
			$('#cart-count').load('index.php?route=common/cart/info');
		});

		$('#reviews_text').on('click', function(e){
			e.preventDefault();
			get_rev();
		});
		$('img.starsCard').on('click', function(){
			get_rev();
		});
		$(".reserveBook").submit(function(e){
			e.preventDefault();
      var $form = $(this);
	    $.ajax({
		     type     : "POST",
		     cache    : false,
		     url      : "index.php?route=product/reserve/addReserve",
		     data     : $form.serialize(),
		     success  : function(json) {
					 if(json == true){
						 $('.reserve_form').html('<?php echo $text_reserve_success; ?>');
	 					setTimeout(function(){
	 						$('.reserve_form').fadeOut('500');
	 					}, 2000);
					}else{
						$('.reserve_form [name="email"]').addClass('redb');
						setTimeout(function(){
	 						$('.reserve_form [name="email"]').removeClass('redb');
	 					}, 1000);
					}
		     }
	    });
 		});

		function get_rev(){
			$('html, body').animate({
					scrollTop: $("#tab-review1").offset().top
			}, 1000);
			$('#input-name').focus();
		}

	});
<?php /*
var productStarsLink = "image/stars-<?php echo $rating; ?>.png";
var starsCardSelector = $("img.starsCard");
var starsWidth = starsCardSelector.width();
var currentStars = 0;

$("img.starsCard").mousemove(function (e) {
  var offset = $(this).offset();
  var userSelectedStars = Math.floor(((e.pageX - offset.left) / starsWidth * 5) + 1);
  if (currentStars != userSelectedStars) {
    currentStars = userSelectedStars;
    starsCardSelector.attr('src', "image/stars-" + userSelectedStars + ".png");
    // console.log(userSelectedStars);
  }
});
$("img.starsCard").mouseleave(function () {
  starsCardSelector.attr('src', productStarsLink);
  currentStars = 0;
});

// console.log('before',$.cookie('rating'));

$("img.starsCard").click(function (e) {
  var offset = $(this).offset(),
      userSelectedStars = Math.floor(((e.pageX - offset.left) / starsWidth * 5) + 1),
      products = null,
	  vote = +($(this).attr('data-vote'))+1,
      idn,
      product_id = $("#reviews_text").attr('data-id');
      $('#reviews_text').text('<?php echo $text_review_success; ?>');
   if(product_id !==''){idn = product_id;}

   if(!$.cookie('rating')){
      products = idn;
   }else{
      products = ($.cookie('rating')) + ' ' +idn;
   }

   function find(id){
      var index = $.cookie('rating').indexOf(id);
      return index;
   }

   if($.cookie('rating') ===null){
    $.cookie('rating', products, {expires: 30, path: '/'});
  }else{
   var pos = find(idn);

     if(pos !== -1){
          $("#reviews_text").text("<?php echo $text_review_reject; ?>");
          return;
     }else{
     	$.cookie('rating', products, {expires: 30, path: '/'});

     }

  }

  $.ajax({
    url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
    type: 'post',
    dataType: 'json',
    data: 'vote='+vote+'&rating=' + encodeURIComponent(userSelectedStars),
    success: function(json) {
      if (json['success']) {
      	// console.log('OK');
        ('#reviews_text').text('<?php echo $text_review_success; ?>');
        starsCardSelector.attr('src', 'image/stars-' + userSelectedStars + '.png');
        $('img.starsCard').unbind('mousemove');
        $('img.starsCard').unbind('mouseleave');
        $('img.starsCard').unbind('click');
        $('img.starsCard').css('cursor', 'default');

      }
    }
  });
}); */ ?>
</script>





<?php echo $footer; ?>
