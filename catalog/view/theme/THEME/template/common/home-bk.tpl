<?php echo $header; ?>
<div class="main">
	<div class="container">
		<div class="main-top-wrap clearfix">
			<div class="row">
				<div class="col-md-9 col-lg-9 col-sm-12">
					<div id="main-carousel" class="owl-carousel hidden-xs">
						<?php foreach ($banners as $banner) { ?>
							<div class="item">
								<div class="img-carousel"><img src="image/<?php echo $banner['image']; ?>" alt=""></div>
								<div class="txt-carousel"><p><?php echo $banner['title']; ?></p></div>
								<a href="<?php echo $banner['link']; ?>" class="link-slider-more"></a>
							</div>
						<?php } ?>
					</div>
					<div class="row">
						<button class="btn-drop-style by-age-btn hidden-sm hidden-md hidden-lg"><?php echo $text_gift_selection; ?></button>
						<div class="col-md-12 col-lg-12 col-xs-12 col-sm-6">
							<?php foreach ($literature_catalog_filters as $filter) { ?>
								<?php if ($filter['filter_group_id'] == 7) { ?>
									<div class="by-age">
										<span class="head-box hidden-xs"><?php echo $text_book_by_age2; ?></span>
										<ul class="age-list">
											<?php foreach ($filter['filter'] as $filter_filter) { ?>
												<li>
													<a href="<?php echo $filter_filter['filter_link']; ?>">
														<span class="top-block"><?php echo str_replace('-', ' - ', $filter_filter['name']); ?></span>
														<span class="bottom-block"><?php echo $text_to_catalog; ?></span>
													</a>
												</li>
											<?php } ?>
										</ul>
									</div>
								<?php } ?>
							<?php } ?>
						</div>
					</div>
				</div>
				<button class="btn-drop-style present-btn hidden-sm hidden-md hidden-lg"><?php echo $text_book_by_age; ?></button>
				<div id="present-tablet" class="col-md-3 col-lg-3 col-sm-6">
					<div class="present">
						<span class="box-head"><?php echo $text_gift_selection2; ?></span>
						<form class="present-gen-form" action="<?php echo $literature_catalog_link; ?>" method="GET">
							<ul>
								<?php foreach ($literature_catalog_filters as $filter) { ?>
									<?php if ($filter['filter_group_id'] == 8) { ?>
										<li>
											<label for="gender"><?php echo $filter['name']; ?>:</label>
											<select id="gender" class="m-select" name="filter<?php echo $filter['filter_group_id']; ?>">
												<option value="" class="label"><?php echo $text_for_all; ?></option>
												<?php foreach ($filter['filter'] as $filter_filter) { ?>
													<option value="<?php echo $filter_filter['filter_id']; ?>"><?php echo $filter_filter['name']; ?></option>
												<?php } ?>
											</select>
										</li>
									<?php } ?>
								<?php } ?>

								<?php foreach ($literature_catalog_filters as $filter) { ?>
									<?php if ($filter['filter_group_id'] == 7) { ?>
										<li>
											<label for="age-sel"><?php echo $filter['name']; ?>:</label>
											<select id="age-sel" class="m-select" name="filter<?php echo $filter['filter_group_id']; ?>">
												<option value="" class="label"><?php echo $text_any; ?></option>
												<?php foreach ($filter['filter'] as $filter_filter) { ?>
													<option value="<?php echo $filter_filter['filter_id']; ?>"><?php echo str_replace('-', ' - ', $filter_filter['name']); ?></option>
												<?php } ?>
											</select>
										</li>
									<?php } ?>
								<?php } ?>

								<li class="value-slider">
									<p class="pslider clearfix">
										<label for="amount"><?php echo $text_price; ?></label><br>
										<span class="wrap-amount-start">
											<?php echo $text_from; ?>
											<input type="text" id="amount-start"  class="input-amount"> 
											<input type="hidden" id="price-start" value="<?php echo $GLOBALS['filter']['amount_start'];?>">
										</span>
										<span class="wrap-amount-finish">
											<?php echo $text_to; ?>
											<input type="text" id="amount-finish" class="input-amount">
											<input type="hidden" id="price-finish" value="<?php echo $GLOBALS["filter"]["amount_finish"];?>">
										</span>
									</p>
									<div id="slider-range"></div>
								</li>

								<?php foreach ($literature_catalog_filters as $filter) { ?>
									<?php if ($filter['filter_group_id'] == 1) { ?>
										<li>
											<label for="age-sel"><?php echo $filter['name']; ?>:</label>
											<select id="age-sel" class="m-select" name="filter<?php echo $filter['filter_group_id']; ?>">
												<option value="" class="label"><?php echo $text_any2; ?></option>
												<?php foreach ($filter['filter'] as $filter_filter) { ?>
													<option value="<?php echo $filter_filter['filter_id']; ?>"><?php echo str_replace('-', ' - ', $filter_filter['name']); ?></option>
												<?php } ?>
											</select>
										</li>
									<?php } ?>
								<?php } ?>
							</ul>
							<button type="submit" class="btn-gen"><?php echo $text_pick; ?></button>
						</form>
					</div>
				</div>
			</div>
 		</div>
 		<?php echo $content_top; ?>
 		<?php echo $main_page_content; ?>
 		<?php echo $content_bottom; ?>
 		<?php echo $main_page_content2; ?>
 		<?php echo $main_page_content3; ?>
		<div class="company-plus hidden-sm hidden-xs">
			<ul>
				<li class="skidki-ico"><?php echo $text_discount_and_bonus; ?></li>
				<li class="ekolog-ico"><?php echo $text_ecologically_clear; ?></li>
				<!-- <li class="present-ico"><?php //echo $text_gifts_to_every_order; ?></li> -->
			</ul>
		</div>
	</div>
</div>


<script type="text/javascript">
	$(document).ready(function() {
		$('form.present-gen-form').submit(function(e) {
			e.preventDefault();

			var $this = $(this);
			var amountStart = $('#amount-start', this).val();
			var amountFinish = $('#amount-finish', this).val();
			var navLink = $this.attr('action');
			navLink += (navLink.indexOf("?") >= 0 ? '&' : '?') + 'filter=';
			
			$.each($('select', this), function(index, value) {
				if (value.value) {
					navLink += value.value + ',';
				}
			});
			navLink = navLink.replace(/,\s*$/, "");

			navLink += '&price=[' + amountStart + ',' + amountFinish + ']';

			window.location.href = navLink;
		});

		$('form.subscribe-form').submit(function(e) {
			e.preventDefault();
		});
	});
</script>

<?php echo $footer; ?>