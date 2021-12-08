<div class="popular-books">
	<div class="block-head">
		<span><?php echo $gallery > 0 ? '<a href='.$category_url.'>'.$carusel_name.'</a>' : $carusel_name ; ?></span>
	</div>
	<div id="<?php echo $gallery > 0 ? 'gallery-carousel' : 'books-carousel'; ?>" class="owl-carousel">
		<?php foreach ($products as $product) { ?>
			<div class="item">
				<?php if($product['akchia']){ ?>
					<span class="akchia">
							<?php echo $text_akchia; ?>
							<?php if($product['discount_percent'] != 0){ ?>
							<br>
							<?php echo $product['discount_percent']; ?>%
						<?php } ?>
					</span>
				<?php } ?>
				<div class="product <?php echo ($product['special'] ? ' akcii-sell' : ''); ?>">
					<div class="pic <?php echo ($product['quantity'] > 0 ? '' : 'product_not_av');?>">
						<a href="<?php echo $product['href']; ?>#product-start" class="link-modal">
							<img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>">
						</a>
					</div>

					<div class="txt">
						<div class="info-book">
							<a href="<?php echo $product['href']; ?>#product-start" id="link-product">
								<h2><?php echo $product['name']; ?></h2>
								<?php
									if ($product['filters']) {
										foreach ($product['filters'] as $product_filter) {
											if ($product_filter['filter_group_id'] == $GLOBALS['info']['book_series_filter_id']) { // если это фильтр "Серия (книги)"
												echo "<p>$product_filter[name]: $product_filter[value]</p>";
											}
										}
									}
								?>
							</a>
						</div>
						<div class="value-book" style="<?php echo $gallery > 0 ? 'display:none' : ''; ?>">
							<?php if ($product['price']) { ?>
								<?php if(!$product['special']) { ?>
											<span class="book-price"><?php echo $product['price']; ?><i><?php echo $text_currency; ?></i></span>
								<?php }else { ?>

											<!-- <div class="value-header"><?php //echo $text_akcia;?></div> -->
											<span class="book-price-sell"><?php echo $product['special']; ?><i><?php echo $text_currency; ?></i></span>
											<span class="book-price"><?php echo $product['price']; ?><i><?php echo $text_currency; ?></i></span>
								<?php } ?>
							<?php } ?>
						</div>
						<div class="button" style="<?php echo $gallery > 0 ? 'display:none' : ''; ?>">
							<button id="featured_buy" class="btn-buy <?php echo ($product['quantity'] > 0 ? '' : 'product_not_av');?>" <?php if($product['quantity'] > 0) {?> onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');" <?php }else{}?>><?php echo $button_cart; ?></button>
						</div>
					</div>
				 </div>
			</div>
		<?php } ?>
	</div>
</div>


<?php
	foreach ($products as $product) {
		echo $product['modal'];
	}
?>


<script type="text/javascript">
	$(document).ready(function() {
		bindBuyActionToButton('.btn-modal-buy', '.book-modal.modal.fade.in', function() {
			$('.book-modal.modal.fade.in').modal('toggle');
		});

		//оповещение о покупке на главной
	$('.btn-buy').click(function(){
		var product_not_av = $(this).hasClass('product_not_av');
		if(!product_not_av) {
			var book_title = $(this).parent().parent().find('.info-book a h2').text(),
				book_href = $(this).parent().parent().find('.info-book a').attr('href'),
				message = '<div class="buy-success"><?php echo $text_cart_product;?><a href="		'+book_href+'"> '+book_title+' </a><?php echo $text_cart_add;?><a 		href="https://pegas-publishing.com.ua/cart"> <?php echo $text_cart;?></a>!<div id="close_cart_tooltip">X</div></div>';
			// console.log(book_title);
			if($('body').find('buy-success')) {
				console.log('OK');
				$('.buy-success').remove();
				$('.main-top-wrap').before(message);
			}else {
				$('.main-top-wrap').before(message);
			}




			$('#cart-count').load('index.php?route=common/cart/info');
			$('#close_cart_tooltip').click(function(){
			$('.buy-success').remove();

			});
		} else {
			return false;
		}
	});
	});
</script>
