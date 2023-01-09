<!-- Модальное окно для товара -->
<div class="book-modal modal fade" id="book-modal-<?php echo $product_id; ?>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="container-fluid">
				<div class="row">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i class="ico-close"></i></span></button>
					<div class="col-md-5">
						<?php if ($thumb || $images) { ?>
							<div class="book-pic clearfix <?php echo ($quantity > 0 ? '' : 'product_not_av');?>">
								<div class="sp-wrap">
									<?php if ($thumb) { ?>
										<a href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>"><img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a>
									<?php } ?>
									<?php if ($images) { ?>
										<?php foreach ($images as $image) { ?>
											<a href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>"><img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a>
										<?php } ?>
									<?php } ?>
								</div>
							</div>
						<?php } ?>
						<div class="btn-obzor">
								<button class="obzor-book" onclick="location.href = '<?php echo $link; ?>';"><?php echo $book_overview; ?></button>
								<button class="obzor-serii" onclick="location.href = '<?php echo $link_series; ?>';"><?php echo $seria_overview; ?></button>
						</div> 
					</div>
					<div class="col-md-3">
						<div class="wrap-info <?php echo ($special ? ' akcii-sell' : ''); ?>">
							<div class="block-top">
								<span class="book-name"><?php echo $heading_title; ?></span>
								<span class="years"><?php echo $heading_subtitle; ?></span>
							</div>
							<div class="block-middle">
								<ul class="about-book">
									<?php
										if ($product_filters) {
											foreach ($product_filters as $product_filter) {
												if ($product_filter['sort_order'] < 100) {
													if ($product_filter['filter_group_id'] == $GLOBALS['info']['book_series_filter_id']) { // если это фильтр "Серия (книги)" 
														echo "<li class=\"seria\"><a href=\"" . $GLOBALS['lnk']['literature_catalog'] . "&filter=$product_filter[filter_id]\"><span>$product_filter[name]: </span><span>$product_filter[value]</span></a></li>";
													} else {
														echo "<li><span>$product_filter[name]: </span><span>$product_filter[value]</span></li>";
													}
												}
											}
										}
									?>

									<?php foreach ($options as $option) { ?>
										<?php if ($option['type'] == 'select') { ?>
											<li class="book-lang<?php echo ($option['required'] ? ' required' : ''); ?>">
												<span><?php echo $option['name']; ?>: </span>
												<span>
													<select name="option[<?php echo $option['product_option_id']; ?>]" id="select-lang" class="m-select">
														<option value=""><?php echo $text_select; ?></option>
														<?php foreach ($option['product_option_value'] as $option_value) { ?>
															
															<option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
																<?php if ($option_value['price']) { ?>
																	(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
																<?php } ?>
															</option>
														<?php } ?>
													</select>
												</span>
											</li>
										<?php } ?>
									<?php } ?>

								</ul>
							</div>
							<div class="block-bottom">
								<div class="value-book">
									<?php if ($price) { ?>
										<?php if(!$special) { ?>
											<span class="book-price"><?php echo $price; ?><i><?php echo $text_currency; ?></i></span>
										<?php }else { ?>

											<div class="value-header"><?php echo $text_akcia;?></div>
											<span class="book-price-sell"><?php echo $special; ?><i><?php echo $text_currency; ?></i></span>
											<span class="book-price"><?php echo $price; ?><i><?php echo $text_currency; ?></i></span>
										<?php } ?>
									
									<?php } ?>
								</div>
								<div class="button">
									<input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
									<?php if($quantity > 0) { ?>
											<button class="btn-buy btn-modal-buy"><?php echo $button_cart; ?></button>
											<?php } else { ?>
											<div class="btn-buy product_not_av"><?php echo $button_cart; ?></div>
											<?php }?>
									
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="wrap-description">
							<div class="description">
								<?php $description = strip_tags($description);?>
								<?php if($description) { ?>
								<?php echo substr(rtrim($description, "!,.-"), 0, 1200).'...'; ?>
								<?php } ?>
							</div>
							<div class="link-m">
								<a class="link-hover" href="<?php echo $link; ?>"><?php echo $full_product_desc; ?> <i class="arrow-ico"></i></a>
							</div>
						</div>
					</div>  
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Конец модальное окно для товара -->