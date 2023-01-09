<?php echo $header; ?>

	<ul class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
		<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
		<?php } ?>
	</ul>

		<?php echo $column_left; ?>
		

		<div id="content" >
			<?php echo $content_top; ?>
			<!-- <h1><?php echo $heading_title; ?></h1> -->

			<section class="centered blog_top">
				<div class="blog_top_inner">
					<h2>Блог</h2>
					<h3>Волшебный мир детской литературы</h3>
					<p>Идем вместе в сентябре на замечательный праздник Книги во Львове! С нетерпением ждем Вас на стенде Издательского Дома «Пегас». Конечно же, мы приедем туда не с пустыми руками. На нашем стенде каждый посетитель форума найдет свою полюбившуюся детскую книгу и сможет ознакомиться с новинками, которые мы для вас подготовили.</p>
				</div>

				<img src="./catalog/view/theme/THEME/stylesheet/img/writing.svg" alt="Блог">
			</section>

			<?php if ($news_list) { ?>
			<!-- <div class="row">
				<div class="col-md-3">
					<div class="btn-group hidden-xs">
						<button type="button" id="list-view" class="btn btn-default" data-toggle="tooltip" title="<?php echo $button_list; ?>"><i class="fa fa-th-list"></i></button>
						<button type="button" id="grid-view" class="btn btn-default" data-toggle="tooltip" title="<?php echo $button_grid; ?>"><i class="fa fa-th"></i></button>
					</div>
				</div>
				<div class="col-md-2 text-right">
					<label class="control-label" for="input-sort"><?php echo $text_sort; ?></label>
				</div>
				<div class="col-md-3 text-right">
					<select id="input-sort" class="form-control" onchange="location = this.value;">
						<?php foreach ($sorts as $sorts) { ?>
						<?php if ($sorts['value'] == $sort . '-' . $order) { ?>
						<option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
						<?php } else { ?>
						<option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
						<?php } ?>
						<?php } ?>
					</select>
				</div>
				<div class="col-md-2 text-right">
					<label class="control-label" for="input-limit"><?php echo $text_limit; ?></label>
				</div>
				<div class="col-md-2 text-right">
					<select id="input-limit" class="form-control" onchange="location = this.value;">
						<?php foreach ($limits as $limits) { ?>
						<?php if ($limits['value'] == $limit) { ?>
						<option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
						<?php } else { ?>
						<option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
						<?php } ?>
						<?php } ?>
					</select>
				</div>
			</div> -->


			<div class="post_loop centered">
				<?php foreach ($news_list as $news_item) { ?>

				<article class="blog_post">
					<?php if($news_item['thumb']) { ?>
					<img class="post_preview" src="<?php echo $news_item['thumb']; ?>" alt="<?php echo $news_item['title']; ?>" title="<?php echo $news_item['title']; ?>">
					<?php }?>

					<h3><?php echo $news_item['title']; ?></h3>
					<p><?php echo $news_item['description']; ?></p>
					<a href="<?php echo $news_item['href']; ?>" class="btn btn_grad"><?php echo $text_more; ?></a>
				</article>

				<!-- <div class="product-layout product-list col-xs-12">
					<div class="product-thumb">
						<?php if($news_item['thumb']) { ?>
						<div class="image"><a href="<?php echo $news_item['href']; ?>"><img src="<?php echo $news_item['thumb']; ?>" alt="<?php echo $news_item['title']; ?>" title="<?php echo $news_item['title']; ?>" class="img-responsive" /></a></div>
						<?php }?>
						<div>
							<div class="caption">
								<h4><a href="<?php echo $news_item['href']; ?>"><?php echo $news_item['title']; ?></a></h4>
								<p><?php echo $news_item['description']; ?></p>
							</div>
							<div class="button-group">
								<button type="button" onclick="location.href = ('<?php echo $news_item['href']; ?>');" data-toggle="tooltip" title="<?php echo $text_more; ?>"><i class="fa fa-share"></i>&nbsp;<span class="hidden-xs hidden-sm hidden-md"><?php echo $text_more; ?></span></button>
								<button type="button" data-toggle="tooltip" title="<?php echo $news_item['posted']; ?>"><i class="fa fa-clock-o"></i></button>
								<button type="button" data-toggle="tooltip" title="<?php echo $news_item['viewed']; ?>"><i class="fa fa-eye"></i></button>
							</div>
						</div>
					</div>
				</div> -->
				<?php } ?>
			</div>
			<div class="row centered">
				<div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
				<div class="col-sm-6 text-right"><?php echo $results; ?></div>
			</div>
			<?php } else { ?>
			<p><?php echo $text_empty; ?></p>
			<div class="buttons centered">
				<div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a></div>
			</div>
			<?php } ?>
		<?php echo $content_bottom; ?></div>
	<?php echo $column_right; ?></div>



<?php echo $footer; ?>