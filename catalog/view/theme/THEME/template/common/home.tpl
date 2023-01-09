<?php echo $header; ?>

<div class="main">	

 	<?php echo $content_top; ?>				
	
	<section class="select_book centered">

		<div class="select_filter">
			<h3><?php echo $text_gift_selection2; ?></h3>
			
					<div class="select_book_cat">
			<?php foreach ($literature_catalog_filters as $filter) { ?>
				<?php if ($filter['filter_group_id'] == 7) { ?>
							
						<div class="sbc_name"><?php echo $filter['name']; ?>:</div>
						<div id="sel_age" class="selectbox sbc_selectbox">
							<div class="val_selected sbc_selected  sbc_age_selected"><?php echo $text_any; ?></div>
							<div class="sel_options sbc_options">
								<?php foreach ($filter['filter'] as $filter_filter) { ?>
								<div class="sel_option sbc_value"  data-value="vik_<?php echo str_replace('–', '-', $filter_filter['name']); ?>"><?php echo str_replace('-', ' - ', $filter_filter['name']); ?></div>
									
							<?php } ?>
							</div>
						</div>
						<?php } ?>
				<?php } ?>
					</div>


					<div class="select_book_cat">
			<?php foreach ($literature_catalog_filters as $filter) { ?>
				<?php if ($filter['filter_group_id'] == 8) { ?>
						<div class="sbc_name"><?php echo $filter['name']; ?>:</div>
		
						<div id="sel_gender" class="selectbox sbc_selectbox">
							<div class="val_selected sbc_selected sbc_gen_selected" data-value=""><?php echo $text_for_all; ?></div>

							<div class="sel_options sbc_options">
								<div class="sel_option sbc_value"><?php echo $text_for_all; ?></div>
								
								<?php foreach ($filter['filter'] as $filter_filter) { ?>
									<?php if ($filter_filter['filter_id'] == '17') { ?>
									<div class="sel_option sbc_value" data-value="stat_dlya-divchat"><?php echo $filter_filter['name']; ?></div>
									<?php }else{ ?>
									<div class="sel_option sbc_value" data-value="stat_dlya-hlopchikiv"><?php echo $filter_filter['name']; ?></div>
										<?php } ?>
									<?php } ?>
							</div>
						<?php } ?>
					<?php } ?>
				</div>
			</div>

			<div class="select_book_cat select_book_price">
				<div class="sbc_name"><?php echo $text_price; ?></div>

				<div id="sel_pricerange" class="price_range" data-max="<?php echo $maxPriceFilter ?>">
					<div class="sel_price start_sum"><?php echo $GLOBALS['filter']['amount_start'];?></div>
					<div class="sel_price end_sum"><?php echo $maxPriceFilter ?></div>
					<div class="price_bar">
						<span class="price_bullet start_price"></span>
						<span class="price_bullet end_price"></span>
					</div>
				</div>
			</div>
			<button id="sel_book_btn" class="btn btn_grad"><?php echo $text_pick; ?></button>

		</div>

		<div class="select_carousel">
			<h3><?php echo $text_book_by_age2; ?></h3>

			<div class="select_carousel_wrap">
				<div class="select_carousel_content">
					<?php foreach ($filters as $filter_filter) { ?>
						
						<div class="sc_item">
							<img src="./catalog/view/theme/THEME/img/books<?php echo str_replace('–', '-', $filter_filter['name']); ?>.svg" alt="<?php echo $text_book_by_age2; ?>">
							<p class="sc_txt"><?php echo str_replace('–', ' - ', $filter_filter['name']); ?>
								<!-- сюда можно пробросить текст "года/лет"? -->
							</p>
							<a class="btn btn_grad" href="<?php echo $filter_filter['href']; ?>">Подробнее</a>
						</div>
					<?php } ?>
				</div>
			</div>
			<div class="btn_prev sc_prev inactive"></div>
			<div class="btn_next sc_next"></div>
		</div>
	</section>

			
 		<?php echo $content_bottom; ?>


</div>


<script type="text/javascript">
	$(document).ready(function() {
		$('form.present-gen-form').submit(function(e) {
			e.preventDefault();

			var $this = $(this);
			var amountStart = $('#amount-start', this).val();
			var amountFinish = $('#amount-finish', this).val();
			var navLink = $this.attr('action');
			//navLink += (navLink.indexOf("?") >= 0 ? '&' : '?') + 'filter=';
			navLink += '';

			$.each($('select', this), function(index, value) {
				if (value.value) {
					navLink += value.value + '/';
				}
			});
			//navLink = navLink.replace(/,\s*$/, "");

			//navLink += '/cena_' + amountStart + '~' + amountFinish + '/';

			//https://pegas.ua/literature-catalog/vik_3–4/stat_dlya-divchat/
			//https://pegas.ua/literature-catalog/vik_3-4/stat_dlya-divchat/ - ок

			window.location.href = navLink;
			//vik_0-3/stat_dlya-divchat/cena_6-50~648-26/
		});

		$('form.subscribe-form').submit(function(e) {
			e.preventDefault();
		});
	});
</script>

<?php echo $footer; ?>
