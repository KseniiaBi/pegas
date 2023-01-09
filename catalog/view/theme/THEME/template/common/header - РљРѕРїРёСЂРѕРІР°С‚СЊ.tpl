<?php
	function getCategoryClasses($category_id) {
		switch ($category_id) {
			case 60: // Каталог литературы
				return 'left-line right-line';
				break;

			case 61: // Подарочные издания
				return 'left-line right-line';
				break;

			case 62: // Новинки
				return 'right-line';
				break;

			case 63: // Наши серии
				return 'nav-corner right-line';
				break;

			case 64: // Раскраски и альбомы
				return 'right-line';
				break;

			case 65: // Популярные
				return 'left-line';
				break;

			default:
				return 'left-line right-line';
				break;
		}
	}
?>
<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<!--<![endif]-->
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<meta name="p:domain_verify" content="ec9ff6cb250d7b0e235209b999f0008d"/>

<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content= "<?php echo $keywords; ?>" />
<?php } ?>

<script src="catalog/view/javascript/jquery/jquery-2.1.1.min.js" type="text/javascript"></script>

<link href="catalog/view/javascript/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen" />
<link rel="stylesheet" href="catalog/view/javascript/select2/select2.css">
<link href="catalog/view/javascript/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<link href="//fonts.googleapis.com/css?family=Open+Sans:400,400i,300,700" rel="stylesheet" type="text/css" />
<link href="catalog/view/theme/THEME/stylesheet/stylesheet.css" rel="stylesheet">
<link href="catalog/view/theme/THEME/stylesheet/media.css" rel="stylesheet">
<link rel="stylesheet" href="catalog/view/theme/THEME/stylesheet/blueimp-gallery.min.css">
<?php foreach ($styles as $style) { ?>
<link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<script async src="catalog/view/javascript/select2/select2.js" type="text/javascript"></script>

<script async src="catalog/view/javascript/gallery/blueimp-gallery.js"></script>
<script async src="catalog/view/javascript/gallery/blueimp-gallery-indicator.js"></script>
<!-- vk -->
<script type="text/javascript" src="//vk.com/js/api/openapi.js?136"></script>

<!-- share -->
<script async type="text/javascript" src="catalog/view/javascript/share42/share42.js"></script>

<!-- owl -->
<!-- <link rel="stylesheet" href="catalog/view/javascript/jquery/owl-carousel/owl.carousel.css">
<script async src="catalog/view/javascript/jquery/owl-carousel/owl.carousel.min.js"></script>
 -->
<!-- smoothproducts -->
<!-- <link rel="stylesheet" href="catalog/view/javascript/smoothproducts/smoothproducts.css">
<script async src="catalog/view/javascript/smoothproducts/smoothproducts.js"></script>
 -->
<!-- slider http https -->
<!-- <link rel="stylesheet" href="https://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script async src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
<script async type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jqueryui-touch-punch/0.2.3/jquery.ui.touch-punch.min.js"></script>
 -->
<!-- maskedinput -->
<script async src="catalog/view/javascript/jquery/maskedinput/jquery.maskedinput.min.js" type="text/javascript"></script>

<script async src="catalog/view/javascript/jquery.matchHeight.js" type="text/javascript"></script>

<script async src="catalog/view/javascript/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="catalog/view/javascript/simple.js?v=4.9.7"></script>
<script src="catalog/view/javascript/simplepage.js?v=4.9.7"></script>

<script async src="catalog/view/javascript/jquery.cookie.js" type="text/javascript"></script>
<script async src="catalog/view/javascript/common.js" type="text/javascript"></script>

<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<?php foreach ($scripts as $script) { ?>
<script src="<?php echo $script; ?>" type="text/javascript"></script>
<?php } ?>
<?php foreach ($analytics as $analytic) { ?>
<?php echo $analytic; ?>
<?php } ?>

<link href="catalog/view/javascript/dt_showmore/dt_showmore.css" type="text/css" rel="stylesheet" media="screen" />
<script async src="catalog/view/javascript/dt_showmore/button_autopager_loader.js" type="text/javascript"></script>
<script async src="catalog/view/javascript/dt_showmore/jquery.autopager.js" type="text/javascript"></script>

<script>

$(document).ready( function () {

// удаляем модальное окно на маленьких экранах
function windowSize(){
    if ($(window).width() <= '992'){
        $('.product .link-modal').removeAttr('data-toggle');
     	   
    }
   
}

$(window).load(windowSize); // при загрузке
$(window).resize(windowSize); // при изменении размеров
// или "два-в-одном", вместо двух последних строк:
$(window).on('ready load resize',windowSize);

});


jQuery(document).ready(function(){
	function getHeight(){
	$('.product .txt p').matchHeight();
    $('.product .txt h2').matchHeight();
    $('.product-thumb  .caption h2').matchHeight();
    $('.product-grid').matchHeight();
    }

    $(window).click(getHeight); // при добавлении
    $(window).load(getHeight); // при загрузке
$(window).resize(getHeight); // при изменении размеров
// или "два-в-одном", вместо двух последних строк:
$(window).on('ready load resize',getHeight);
    })

</script>

</head>


<body class="<?php echo $class; ?>" onLoad="location.href='#product-start'">

<!--
<div id="blueimp-gallery" class="blueimp-gallery">
    <div class="slides"></div>

    <a class="prev">‹</a>
    <a class="next">›</a>
    <a class="close">×</a>
    <a class="play-pause"></a>
    <ol class="indicator"></ol>
</div>
-->

<nav id="top">
	<div class="container">
		<div class="header_top">
			<?php if ($informations) { ?>
				<div id="top_nav">
					<button type="submit" class="top_nav_btn hidden-lg hidden-md ">
					</button>
					<ul class="list-inline">
					<?php foreach ($informations as $information) { ?>
						<li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
					<?php } ?>
					</ul>
				</div>
			<?php } ?>




		<?php echo $language; ?>
		<button type="submit" class="btn_open_search btn-search hidden-sm hidden-lg hidden-md ">
									</button>
		<div class="top_search hidden-md hidden-lg ">
		<?php echo $search; ?>
		</div>


		<div  class="user-links">
										<a class="log-link dash-top hidden-xs" href="<?php echo $account; ?>" title="<?php echo $text_account; ?>"><span class="hidden-sm hidden-xs"><?php echo $text_account; ?></span><span class="ico-enter hidden-lg hidden-md">Вход</span></a>
									
				<a class="cart-link" href="<?php echo $shopping_cart; ?>" title="
											<?php echo $text_shopping_cart; ?>
											">
											<span class="hidden-sm hidden-xs">
												<?php echo $text_shopping_cart; ?></span> 
												<!-- <i class="cart-ico"></i> -->
												<span class="ico-cart" ></span>
											<span class="buy" id="cart-count"></span>
										</a>


		</div>
		</div>
	</div>
</nav>





<header>
	<div class="container">
		<div class="row">
			<div class="col-md-3 col-sm-3 col-xs-5">
			 <div class="logo">
					<?php if ($logo) { ?>
					<a class="logo-link" href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" /></a>
					<?php } else { ?>
					<h1><a href="<?php echo $home; ?>"><?php echo $name; ?></a></h1>
					<?php } ?>
					</div>
			</div>
			<div class="col-md-5 col-sm-4 col-sm-offset-1 col-md-offset-0 col-lg-offset-0 hidden-xs ">

					<div class="header-contact">
						<ul class="contact-list">
							<li><span><?php echo $text_contact_number1; ?>:</span><span><?php echo $GLOBALS['contact']['number1']; ?></span></li>
							<li><span><?php echo $text_contact_number2; ?>:</span><span><?php echo $GLOBALS['contact']['number2']; ?></span></li>
							<li><span><?php echo $text_contact_number3; ?>:</span><span><?php echo $GLOBALS['contact']['number3']; ?></span></li>
						</ul>
<div class="btn-wrap hidden-md hidden-lg">
		<button class="contact-more"><span>Другие города</span> <i class="fa fa-angle-down"></i>
</button>
</div>
						<ul class="contact-list list-more">
							<li><span><?php echo $text_contact_number4; ?>:</span><span><?php echo $GLOBALS['contact']['number4']; ?></span></li>
							<li><span><?php echo $text_contact_number5; ?>:</span><span><?php echo $GLOBALS['contact']['number5']; ?></span></li>
						</ul>

					</div>
			

			</div>
			<div id="no-relative" class="col-md-3 col-sm-4 col-xs-7">
			<div class="header_search hidden-sm hidden-xs ">
					<?php echo $search; ?>
					</div>
					<div class="re-call-wrap clearfix">
						<button class="btn-call" data-toggle="modal" data-target="#re-call-modal"><?php echo $text_call_me_back; ?></button>
					</div>
					<div class="timing hidden-sm hidden-xs">
							<span><?php echo $text_working_hours; ?> </span><i class="fa fa-caret-down"></i>
							<div class="timing-drop"><?php echo $text_working_hours_text; ?></div>
					</div>
<!-- КОНТАКТЫ -->
		<div class="header-contact hidden-sm hidden-md hidden-lg">
						<div class="btn-wrap ">
				 <button class="contact-more"><span>Контакты</span> <i class="fa fa-angle-down"></i></button>
</div>
							
		
						<ul class="contact-list list-more">
							<li><span><?php echo $text_contact_number1; ?>:</span><span><?php echo $GLOBALS['contact']['number1']; ?></span></li>
							<li><span><?php echo $text_contact_number2; ?>:</span><span><?php echo $GLOBALS['contact']['number2']; ?></span></li>
							<li><span><?php echo $text_contact_number3; ?>:</span><span><?php echo $GLOBALS['contact']['number3']; ?></span></li>
							<li><span><?php echo $text_contact_number4; ?>:</span><span><?php echo $GLOBALS['contact']['number4']; ?></span></li>
							<li><span><?php echo $text_contact_number5; ?>:</span><span><?php echo $GLOBALS['contact']['number5']; ?></span></li>
						</ul>

					</div>

				</div>
		</div>
	</div>

<!-- Меню категорий -->

	<?php if ($categories) { ?>
		<nav id="bottom-nav">
			<div class="container">
				<div class="categories-nav clearfix">
					<button class="btn-category hidden-md hidden-lg">
						<span><?php echo $text_show_category; ?></span><span><?php echo $text_hide_category; ?></span><i class="ico-bar"></i>
					</button>

					<ul class="category-list">
						<?php foreach ($categories as $category) { ?>
							<?php if ($category['children']) { ?>
								<li class="dropdown <?php echo getCategoryClasses($category['id']); ?>">
									<a href="<?php echo $category['href'];?>#category-start">
                                    	<?php echo $category['name']; ?>
                                    </a>
									<ul class="dropdown-menu catalog-drop">
										<?php foreach (array_chunk($category['children'], ceil(count($category['children']) / $category['column'])) as $children) { ?>
											<?php foreach ($children as $child) { ?>
												<li>
                                                	<a href="<?php echo $child['href'];?>#category-start">
                                                    	<?php echo $child['name']; ?>
                                                    </a>
                                                </li>
											<?php } ?>
										<?php } ?>
									</ul>
								</li>
							<?php } else { ?>
								<li class="<?php echo getCategoryClasses($category['id']); ?>">
                                	<a href="<?php echo $category['href'];?>#category-start">
                                    	<?php echo $category['name']; ?>
                                    </a>
                                </li>
							<?php } ?>
						<?php } ?>
					</ul>
				</div>
			</div>
		</nav>
	<?php } ?>
</header>

<div class="modal fade" id="re-call-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="re-call-label" data-success=""><?php echo $text_call_me_back_text; ?></h4>
			</div>
			<p style="display: none;"><?php echo $text_information_sent; ?></p>
			<form id="callback_in_header">
			<div class="modal-body">
				
				<input id="form_header" type="hidden" name="form" value="Форма: обратный звонок">
				<div class="inp_error_tel"><?php echo $text_input_error; ?></div>
				<input id="form_header_phone" type="text" placeholder="+ 38 ( _ _ _ ) _ _ _   _ _   _ _">
			</div>
			<div class="modal-footer">
				<button type="submit" class="btn-call"><?php echo $text_call_me_back; ?></button>
			</div>
			</form>
		</div>
	</div>
</div>