<section class="books <?php echo $class;?>">
	
		<h2><?php echo $carusel_name ?></h2>
		<a class="btn btn_grad" href='<?php echo $category_url ?>'><?php echo $text_all_books; ?></a>
	 
	
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
							<h4><a href="<?php echo $product['href']; ?>" class="book_href"><?php echo $product['name']; ?></a></h4>
							
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
								<span class="prop_name"><?php echo $text_price_c; ?></span>
												<?php echo $product['price']; ?> <?php echo $text_currency; ?>
									<?php } else { ?>
									<span class="prop_name"><?php echo $text_price; ?></span>
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
							<?php if ($product['other_lang']) { ?>
							<div class="book_lang">
								<?php foreach ($product['other_lang'] as $lang) { ?>
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
