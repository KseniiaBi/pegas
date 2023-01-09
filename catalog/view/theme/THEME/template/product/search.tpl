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
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <section id="content" class="searchres centered <?php echo $class; ?>"><?php echo $content_top; ?>
      <h2><?php echo $heading_title; ?></h2>
      <label class="control-label" for="input-search"><?php echo $entry_search; ?></label>
      <div class="row">
        <div class="col-sm-4">
          <input type="text" name="search" value="<?php echo $search; ?>" placeholder="<?php echo $text_keyword; ?>" id="input-search" class="form-control" />
        </div>
        <div class="col-sm-3">
          <div class="search-category">
          <select name="category_id" class="form-control m-select">
            <option value="0"><?php echo $text_category; ?></option>
            <?php foreach ($categories as $category_1) { ?>
            <?php if ($category_1['category_id'] == $category_id) { ?>
            <option value="<?php echo $category_1['category_id']; ?>" selected="selected"><?php echo $category_1['name']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $category_1['category_id']; ?>"><?php echo $category_1['name']; ?></option>
            <?php } ?>
            <?php foreach ($category_1['children'] as $category_2) { ?>
            <?php if ($category_2['category_id'] == $category_id) { ?>
            <option value="<?php echo $category_2['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $category_2['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
            <?php } ?>
            <?php foreach ($category_2['children'] as $category_3) { ?>
            <?php if ($category_3['category_id'] == $category_id) { ?>
            <option value="<?php echo $category_3['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $category_3['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
            <?php } ?>
            <?php } ?>
            <?php } ?>
            <?php } ?>
          </select>
          </div>
        </div>
        <div class="col-sm-3">
          <div class="checkbox-wrap" style="margin-top: 9px;">
          <label class="checkbox-inline ">

            <?php if ($sub_category) { ?>
            <input  type="checkbox" id="sub_ch" name="sub_category" value="1" checked="checked" /><label for="sub_ch"></label>
            <?php } else { ?>
            <input type="checkbox" id="sub_ch" name="sub_category" value="1" /><label for="sub_ch"></label>
            <?php } ?>
            <?php echo $text_sub_category; ?></label>
            </div>
            <div class="checkbox-wrap">
              <label class="checkbox-inline">
                <?php if ($description) { ?>
                <input type="checkbox" id="descr_ch" name="description" value="1" id="description" checked="checked" /><label for="descr_ch"></label>
                <?php } else { ?>
                <input type="checkbox" id="descr_ch" name="description" value="1" id="description" /><label for="descr_ch"></label>
                <?php } ?>
                <?php echo $entry_description; ?></label>
              </div>
        <input class="btn btn_grad" type="button" value="<?php echo $button_search; ?>" id="button-search" class="btn btn-primary" />
      </div>
    </div>
      <h2><?php echo $text_search; ?></h2>
      <?php if ($products) { ?>
      <p><a href="<?php echo $compare; ?>" id="compare-total"><?php echo $text_compare; ?></a></p>
      <div class="row">
        <div class="col-sm-3 hidden-xs">
          <div class="btn-group">
            <button type="button" id="list-view" class="btn btn-default" data-toggle="tooltip" title="<?php echo $button_list; ?>"><i class="fa fa-th-list"></i></button>
            <button type="button" id="grid-view" class="btn btn-default" data-toggle="tooltip" title="<?php echo $button_grid; ?>"><i class="fa fa-th"></i></button>
          </div>
        </div>
        <div class="col-sm-1 col-sm-offset-2 text-right">
          <label class="control-label" for="input-sort"><?php echo $text_sort; ?></label>
        </div>
        <div class="col-sm-3 text-right">
          <select id="input-sort" class="form-control col-sm-3" onchange="location = this.value;">
            <?php foreach ($sorts as $sorts) { ?>
            <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
            <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
            <?php } ?>
            <?php } ?>
          </select>
        </div>
        <div class="col-sm-1 text-right">
          <label class="control-label" for="input-limit"><?php echo $text_limit; ?></label>
        </div>
        <div class="col-sm-2 text-right">
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
      </div>
      <br />

      <div class="row">
        <?php foreach ($products as $product) { ?>
        <div class="product-layout product-list col-xs-12">
          <?php if($product['akchia']){ ?>
            <span class="akchia">
                <?php echo $text_akchia; ?>
                <?php if($product['discount_percent'] != 0){ ?>
                <br>
                <?php echo $product['discount_percent']; ?>%
              <?php } ?>
            </span>
          <?php } ?>
          <div class="product-thumb <?php echo ($product['special'] ? ' akcii-sell' : ''); ?>">
            <div class="image <?php echo ($product['quantity'] > 0 ? '' : 'product_not_av');?>"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" /></a></div>
            <div class="caption">
              <h2><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h2>
              <!-- <p> -->
              <?php //echo $product['description']; ?>
            <!-- </p> -->
              <?php //if ($product['price']) { ?>
              <!-- <p class="price"> -->
                <?php //if (!$product['special']) { ?>
                <?php //echo $product['price']; ?>
                <?php //} else { ?>
                <!-- <span class="price-new"> -->
                  <?php //echo $product['special']; ?>
               <!--  </span> <span class="price-old"> -->
               <?php //echo $product['price']; ?>
             <!-- </span> -->
                <?php //} ?>
                <?php //if ($product['tax']) { ?>
                <!-- <span class="price-tax"> -->
                <?php //echo $text_tax; ?> <?php //echo $product['tax']; ?>
              <!-- </span> -->
                <?php //} ?>
              <!-- </p> -->
              <?php //} ?>
              <div class="value-book" style="<?php echo $product['gallery'] > 0 ? 'display:none' : '' ;?>">
              <?php if ($product['price']) { ?>
                    <?php if ($product['price']) { ?>
                    <?php if(!$product['special']) { ?>
                      <span class="book-price"><?php echo $product['price']; ?><i><?php echo $text_currency; ?></i></span>
                    <?php }else { ?>

                      <!-- <div class="value-header"><?php //echo $text_akcia;?></div> -->
                      <span class="book-price-sell"><?php echo $product['special']; ?><i><?php echo $text_currency; ?></i></span>
                      <span class="book-price"><?php echo $product['price']; ?><i><?php echo $text_currency; ?></i></span>
                    <?php } ?>
                    <?php } ?>
                <?php } ?>
              </div>
              <?php //if ($product['rating']) { ?>
              <!-- <div class="rating"> -->
                <?php //for ($i = 1; $i <= 5; $i++) { ?>
                <?php //if ($product['rating'] < $i) { ?>
                <!-- <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span> -->
                <?php //} else { ?>
                <!-- <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span> -->
                <?php //} ?>
                <?php //} ?>
             <!--  </div> -->
              <?php //} ?>
              <button style="<?php echo $product['gallery'] > 0 ? 'display:none' : '' ;?>" class="btn-buy <?php echo ($product['quantity'] > 0 ? '' : 'product_not_av');?>" <?php if($product['quantity'] > 0) {?> onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');" <?php }else{}?>><?php echo $button_cart; ?></button>
            </div>
            <!-- <div class="button-group"> -->
              <!-- <button type="button" onclick="cart.add('<?php //echo $product['product_id']; ?>', '<?php //echo $product['minimum']; ?>');"><i class="fa fa-shopping-cart"></i> <span class="hidden-xs hidden-sm hidden-md"><?php //echo $button_cart; ?></span></button> -->
              <!-- <button type="button" data-toggle="tooltip" title="<?php //echo $button_wishlist; ?>" onclick="wishlist.add('<?php //echo $product['product_id']; ?>');"><i class="fa fa-heart"></i></button>
              <button type="button" data-toggle="tooltip" title="<?php //echo $button_compare; ?>" onclick="compare.add('<?php //echo $product['product_id']; ?>');"><i class="fa fa-exchange"></i></button> -->
            <!-- </div> -->

          </div>
        </div>
        <?php } ?>
      </div>
      <div class="row">
        <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
        <div class="col-sm-6 text-right"><?php echo $results; ?></div>
      </div>
      <?php } else { ?>
      <p><?php echo $text_empty; ?></p>
      <?php } ?>
    </section>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<script type="text/javascript"><!--
$(document).ready(function() {

    $('.btn-buy').click(function(){
      $('#cart-count').load('index.php?route=common/cart/info');
    });
});
$('#button-search').bind('click', function() {
  url = 'index.php?route=product/search';

  var search = $('#content input[name=\'search\']').prop('value');

  if (search) {
    url += '&search=' + encodeURIComponent(search);
  }

  var category_id = $('#content select[name=\'category_id\']').prop('value');

  if (category_id > 0) {
    url += '&category_id=' + encodeURIComponent(category_id);
  }

  var sub_category = $('#content input[name=\'sub_category\']:checked').prop('value');

  if (sub_category) {
    url += '&sub_category=true';
  }

  var filter_description = $('#content input[name=\'description\']:checked').prop('value');

  if (filter_description) {
    url += '&description=true';
  }

  location = url;
});

$('#content input[name=\'search\']').bind('keydown', function(e) {
  if (e.keyCode == 13) {
    $('#button-search').trigger('click');
  }
});

$('select[name=\'category_id\']').on('change', function() {
  if (this.value == '0') {
    $('input[name=\'sub_category\']').prop('disabled', true);
  } else {
    $('input[name=\'sub_category\']').prop('disabled', false);
  }
});

$('select[name=\'category_id\']').trigger('change');
--></script>
<?php echo $footer; ?>
