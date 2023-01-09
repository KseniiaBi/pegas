<?php echo $header; ?>

<style type="text/css">
	button.refresh, button.delete-item {
			background: none;
			border: none;
	}
</style>

<div class="cart-page">
	<div class="container">
		<div class="row">
			<div class="col-md-12 hidden-sm hidden-xs ">
				<h1><?php echo $text_head; ?></h1>
			</div>
			<div class="col-md-6 col-xs-12 col-md-push-6">
				<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
					<div class="product-cart">
						<table class="cart-table">
							<thead>
								<tr>
									<td><?php echo $column_name; ?></td>
									<td >
										<table class="sub-table hidden-xs">
											<tr>  <td><?php echo $column_quantity; ?></td>
												<td><?php echo $column_price; ?></td>
												<td></td></tr>
											</table>
										</td>
									</tr>
								</thead>
								<tbody>

<?php //print_r($products); ?>
									<?php foreach ($products as $product) { ?>
										<tr>
											<td>
												<div class="media product-item">
													<?php if ($product['thumb']) { ?>
														<div class="media-left">
															<a href="<?php echo $product['href']; ?>">
																<img class="media-object" src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>">
															</a>
														</div>
													<?php } ?>
													<div class="media-body">
													 <h4 class="media-heading">
														<span class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></span> <br>
														<?php
															if ($product['filters']) {
																foreach ($product['filters'] as $product_filter) {
																	if ($product_filter['filter_group_id'] == $GLOBALS['info']['book_series_filter_id']) { // если это фильтр "Серия (книги)" 
																		echo "<span class=\"seria\">$product_filter[name]: $product_filter[value]</span><br>";
																	}
																}
															}
														?>
														 
														
													</h4>
													<ul class="about-book">
														<?php
															if ($product['option']) {
																// print_r($product['option']);
																foreach ($product['option'] as $option) {
																	foreach($option['code'] as $options) {
																		// if($options['name'] === $option['value']) {
																		echo
																		"<span class=\"code\">$book_code $options[code]</span><br>";
																		}
																	// }
																

																	//if ($option['type'] !== 'select') {
																		//echo "<li><span>$option[name]: </span><span>$option[value]</span></li>";
																	//} else {
																		//echo "<li class=\"book-lang\"><span>$option[name]: </span><span><select id=\"select-lang\" class=\"m-select\" data-option-id=\"$option[id]\" data-cart-id=\"$product[cart_id]\">";
																		// foreach ($option['values'] as $option_value) {
																			// if ($option_value['name'] === $option['value']) {
																				echo 
																				"<span class=\"code\">$book_lang $option[value]</span><br>";//"<option value=\"$option_value[product_option_value_id]\" selected>$option_value[name]</option>";
																			// } else {
																			// 	echo "<option value=\"$option_value[product_option_value_id]\">$option_value[name]</option>";
																			// }
																		// }
																		//echo "</select></span></li>";
																	// }
																}
															}
														?>

														</ul>
													</div>
												</div>
											</td>
											<td>
												<table class="sub-table">
													<tr class="sub-head visible-xs">
														<td>Кол-во:</td>
														<td>Цена:</td>
														<td>Убрать:</td>
													</tr>
													<tr>
														<td>
															<div class="product-amount">
																<input type="text" name="quantity[<?php echo $product['cart_id']; ?>]" value="<?php echo $product['quantity']; ?>" />
																<button class="refresh" type="submit" data-toggle="tooltip" title="<?php echo $button_update; ?>"><i class="fa fa-refresh"></i></button>
															</div>
														</td>
														<td>
															<span class="book-cost"><?php echo $product['price']; ?></span> <?php echo $text_currency; ?>
														</td>
														<td>
															<button type="button" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="delete-item" onclick="cart.remove('<?php echo $product['cart_id']; ?>'); setTimeout(window.location.reload.bind(window.location), 250);"><i class="fa fa-times"></i></button>
														</td>
													</tr>
												</table>
											</td>
										</tr>
									<?php } ?>				
									


								</tbody>
								<tfoot>
									<tr>
										<td colspan="2">
											<?php foreach ($totals as $total) { ?>
												<?php echo $total['title']; ?>: <span><?php echo $total['text']; ?></span> <?php echo $total['text_currency']; ?>
											<?php } ?>
										</td>
									</tr>
								</tfoot>
						</table>
						</div>
					</form>
				</div>
				<div class="col-md-6 col-xs-12 col-md-pull-6">
					<div class="forms-order">
						<!-- Nav tabs -->
						<ul class="nav nav-tabs" role="tablist">
							<li role="presentation" class="active"><a href="#fast-order" aria-controls="home" role="tab" data-toggle="tab"><?php echo $text_quick_order; ?><i></i></a></li>
							<li role="presentation"><a href="#full-order" aria-controls="profile" role="tab" data-toggle="tab"><?php echo $text_standart_order; ?><i></i></a></li>
						</ul>

						<!-- Tab panes -->
						<div class="tab-content">

							<div role="tabpanel" class="tab-pane active" id="fast-order">
								<form class="fast-form">
									<p><?php echo $text_quick_order_head; ?></p>

										<div class="input-wrap">
											<input class="phone" name="easycart-telephone" type="text" placeholder="+38 (___) ___ __ __" value="<?php echo $user_telephone;
													?>">
											<input type="hidden" name="easycart-firstname" value="&nbsp;&nbsp;&nbsp;">
											<input type="hidden" name="easycart-lastname" value="&nbsp;&nbsp;&nbsp;">
											<input type="hidden" name="easycart-address_1" value="&nbsp;&nbsp;&nbsp;">
											<input type="hidden" name="easycart-city" value="&nbsp;&nbsp;&nbsp;">
										</div>
										<div class="bottom-btns">
											<button class="btn-checkout"><?php echo $quick_order_checkout; ?></button>
											<a href="" class="continue-buy hidden-xs ">
											<?php echo $quick_order_cont_shoping; ?></a>
										</div>
									</form>
									<div class="fast-rules">
										<?php echo $text_fast_rules; ?>
									</div>

										</div>
										<div role="tabpanel" class="tab-pane" id="full-order">
										 <form class="long">
											<ol class="rules">
												<?php echo $text_rules_head; ?>
											</ol>

											<ul class="long-form">
												<li>
													<label for="">*<?php echo $text_username; ?></label><br>
													<input type="text" name="easycart-firstname" placeholder="<?php echo $username; ?>" value="<?php echo $user_name; ?>">
													<input type="hidden" name="easycart-lastname" value="&nbsp;&nbsp;&nbsp;">
												</li>
												<li>
													<label for="">*<?php echo $text_phone; ?></label><br>
													<input type="text" name="easycart-telephone" placeholder="+38 (___) ___ __ __" value="<?php echo $user_telephone;
													?>">
												</li>
												
												<li>
													<label for="">*<?php echo $text_email; ?></label><br>
													<input type="text" name="easycart-email" placeholder="<?php echo $email; ?>" value="<?php echo $user_email; ?>">
												</li>
												<li>
													<label for="">*<?php echo $text_address; ?></label><br>
													<input name="easycart-address_1" type="text" placeholder="<?php echo $address; ?>">
													<input type="hidden" name="easycart-city" value="&nbsp;&nbsp;&nbsp;">
												</li>
												<li >
													<label for=""><?php echo $text_delivery; ?></label><br>
													<select class="order-select" name="easycart-shipping_method_text">
														<option value="Самовывоз"><?php echo $delivery_pickup; ?></option>
														<option value="Новая почта"><?php echo $delivery_nova; ?></option>
														<option value="Интайм"><?php echo $delivery_intime; ?></option>
														<option value="Деливери"><?php echo $delivery_delivery; ?></option>
														<option value="Укрпочта"><?php echo $delivery_ukrposhta; ?></option>
														<option value="Автолюкс"><?php echo $delivery_avtolux; ?></option>
													</select>
												</li>
												<?php if ($payment_methods) { ?>
													<li>
														<label for=""><?php echo $text_payment_method; ?></label><br>
														<select class="order-select" name="easycart-payment_method_text">
															<?php foreach ($payment_methods as $payment_method) { ?>
																<option value="<?php echo $payment_method['code']; ?>"><?php echo $payment_method['title']; ?></option>
															<?php } ?>
														</select>
													</li>
												<?php } ?>
												<li>
													<label for=""><?php echo $text_comment; ?></label><br>
													<input type="text" name="easycart-comment">
												</li>
											</ul>



											<div class="bottom-btns">
												<button class="btn-checkout"><?php echo $quick_order_checkout; ?></button>
												<a href="" class="continue-buy hidden-xs "><?php echo $quick_order_cont_shoping; ?></a>
											</div>
										</form>
										<div class="fast-rules">
										 	<?php echo $text_standart_rules; ?>
										</div>
									</div>

								</div>









							</div>

						</div>
						<div id="discount-wrap" class="col-md-6 col-xs-12 col-sm-12 col-md-offset-6">
							<div class="discount">
								<?php echo $text_discount; ?>
								<?php echo $text_discount_guest; ?>
							</div>
						</div>

					</div>
				</div>
			</div>


<script type="text/javascript">
	$(document).ready(function() {
		$('input[name="easycart-telephone"]').mask('+38 (999) 999 99 99');

		$('#select-lang').change(function() { cart.updateOption(this); });

		$('form.fast-form, form.long').submit(function(e) {
			e.preventDefault();
			disableCartInputs(true);
			
			$.ajax({
				url: '<?php echo $checkout; ?>',
				type: 'POST', // dataType: 'json';
				data: $(this).serialize(),
				success: function(data) {
					console.log(data);
					var result = processEasycartAction(data);
					disableCartInputs(result);
				},
				error: function(data) {
					var result = processEasycartAction(data);
					disableCartInputs(result);
				},
			});
		});
	});



	function disableCartInputs(state) { // true or false
		$('.btn-checkout').attr('disabled', state).css('background-color', (state ? '#DDD' : ''));
	}

	function processEasycartAction(data) {
		

		if (typeof data.responseText !== 'undefined') {
			var reMatch = data.responseText.match(/{(.*)}/m);
			if (Array.isArray(reMatch) && reMatch.length >= 1) {
				data = JSON.parse(reMatch[0]);
				console.log(data);
			}
		}

		if (typeof data.error !== 'undefined') {
			var message = '';
			$.each(data.error, function(index, value) {
				message += value + '\n';
			});
			alert(message);

			return false;
		}

		if (typeof data.success !== 'undefined' && typeof data.redirect !== 'undefined') {
			location.href = data.redirect;
			return true;
		}   
	}
</script>

<?php echo $footer; ?>