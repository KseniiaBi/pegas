<?php //echo $heading_title; ?>

<div class="open-filters hidden-md hidden-lg">
	<button class="btn-drop-style filter-btn hidden-sm hidden-md hidden-lg">Фильтр</button>
	<button class="open-filters-btn hidden-xs">Настроить фильтры <i></i></button>
</div>
<div class="filters">
	<div class="filter-btns">
		<button class="btn-sbros" onclick="$('input[type=checkbox]').attr('checked', false); $('#amount-start').val($('#price-start').val()); $('#amount-finish').val($('#price-finish').val()); $('#amount-finish').trigger('keyup');"><?php echo $reset_filter;?><b></b></button>
		<button class="btn-podbor"><?php echo $button_filter; ?></button>
	</div>

	<div class="filters-parent">
		<ul id="CheckBoxes">

			<?php foreach ($filter_groups as $filter_group) { ?>
				<li>
					<button class="filtr-drop"><?php echo $filter_group['name']; ?>:<b></b></button>
					<ul>
						<?php foreach ($filter_group['filter'] as $filter) { ?>
							<li>
								<label>
									<?php
										$checked = (in_array($filter['filter_id'], $filter_category) ? 'checked="checked"' : '');
										echo "<input type=\"checkbox\" name=\"filter[]\" value=\"$filter[filter_id]\" $checked>$filter[name]";
									?>
								</label>
							</li>
						<?php } ?>
					</ul>
				</li>


				<?php if ($filter_group['filter_group_id'] == 7) { // слайдер цены после возраста ?>
					<li class="value-slider">
						<p class="pslider clearfix">
							<label for="amount"><?php echo $price;?></label><br>
							<span class="wrap-amount-start">
								<input type="text" id="amount-start"  class="input-amount">
								<input type="hidden" id="price-start" value="<?php echo $GLOBALS['filter']['amount_start'];?>">
							</span>
							<span class="wrap-amount-finish">
								<input type="text" id="amount-finish" class="input-amount">
								<!-- <input type="hidden" id="price-finish" value="<?php echo $GLOBALS["filter"]["amount_finish"];?>"> -->
									<input type="hidden" id="price-finish" value="<?php echo $maxPriceFilter ?>">
							</span>
						</p>
						<div id="slider-range"></div>
					</li>
				<?php } ?>
			<?php } ?>
		</ul>
	</div>

	<div class="filter-btns">
		<button class="btn-sbros" onclick="$('input[type=checkbox]').attr('checked', false); $('#amount-start').val($('#price-start').val()); $('#amount-finish').val($('#price-finish').val()); $('#amount-finish').trigger('keyup');"><?php echo $reset_filter;?></button>
		<button class="btn-podbor"><?php echo $button_filter; ?></button>
	</div>
</div>


<script type="text/javascript">
	$('.btn-podbor').click(function() {
		filter = [];

		$('input[name^=\'filter\']:checked').each(function(element) {
			filter.push(this.value);
		});


		var priceAmountStart = $('#amount-start');
		var priceAmountFinish = $('#amount-finish');

		location = '<?php echo $action; ?>&filter=' + filter.join(',') + (priceAmountStart.length && priceAmountFinish.length ? '&price=[' + priceAmountStart.val() + ',' + priceAmountFinish.val() + ']' : '');
	});
</script>
