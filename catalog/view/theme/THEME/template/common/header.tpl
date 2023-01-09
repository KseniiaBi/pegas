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

	<?php if ($hreflang) { ?>
		<link rel="alternate" hreflang="<?php echo $hreflang; ?>" href="<?php echo $hreflang_link; ?>" />
	<?php } ?>

	<script src="catalog/view/javascript/jquery/jquery-2.1.1.min.js"></script>

<!-- 	<link href="catalog/view/javascript/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen" />
	<link rel="stylesheet" href="catalog/view/javascript/select2/select2.css">
	<link href="catalog/view/javascript/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" /> -->
	

	<!-- <link href="catalog/view/theme/THEME/stylesheet/stylesheet.css?v=<?php echo rand(123, 432432243); ?>" rel="stylesheet">

 -->

<!-- 	<?php foreach ($styles as $style) { ?>
		<link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
	<?php } ?> -->
	<script async src="catalog/view/javascript/select2/select2.js"></script>


	<!-- share -->
	<script src="catalog/view/javascript/share42/share42.js"></script>

	<script src="catalog/view/javascript/simple.js?v=4.9.7"></script>
	<script src="catalog/view/javascript/simplepage.js?v=4.9.7"></script>


	<!-- maskedinput -->
	<script src="catalog/view/javascript/jquery/maskedinput/jquery.maskedinput.min.js"></script>

	<script src="catalog/view/javascript/jquery.cookie.js"></script>
	<script src="catalog/view/javascript/common.js?v=<?php echo rand(1123,123123123); ?>"></script>
<!-- 
	<?php foreach ($links as $link) { ?>
		<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
	<?php } ?> -->

	<?php foreach ($scripts as $script) { ?>
		<script src="<?php echo $script; ?>"></script>
	<?php } ?>

	<?php foreach ($analytics as $analytic) { ?>
		<?php echo $analytic; ?>
	<?php } ?>

	<!-- <link href="catalog/view/javascript/dt_showmore/dt_showmore.css" type="text/css" rel="stylesheet" media="screen" /> -->
	<script src="catalog/view/javascript/dt_showmore/button_autopager_loader.js"></script>
	<script src="catalog/view/javascript/dt_showmore/jquery.autopager.js"></script>


<!-- Facebook Pixel Code -->
<script>
	!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?
	n.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;
	n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;
	t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,
		document,'script','https://connect.facebook.net/en_US/fbevents.js');
		fbq('init', '1285097358206295'); // Insert your pixel ID here.
		fbq('track', 'PageView');
</script>
<!-- End Facebook Pixel Code -->

	<!-- redesigned -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,400;0,500;0,600;0,700;1,500&family=Philosopher:wght@700&display=swap" rel="stylesheet">
	<link href="catalog/view/theme/THEME/stylesheet/main.css" rel="stylesheet">
<!-- end redesigned styles -->

</head>

<body class="<?php echo $class; ?>">

	<noscript><img height="1" width="1" style="display:none"
	src="https://www.facebook.com/tr?id=1285097358206295&ev=PageView&noscript=1" alt="facebook" /></noscript>
	<!-- DO NOT MODIFY -->
	<div id="fb-root"></div>
	<script>(function(d, s, id) {
			var js, fjs = d.getElementsByTagName(s)[0];
			if (d.getElementById(id)) return;
			js = d.createElement(s); js.id = id;
			js.src = "//connect.facebook.net/ru_RU/sdk.js#xfbml=1&version=v2.9";
			fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk'));
	</script>
				

	<header>
		<div class="header_top">

			<?php if ($informations) { ?>
				<nav class="topnav">
					<?php foreach ($informations as $information) { ?>
						<?php if($information['color_code'] != ""){ ?>
							<a class="h_top_link" href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a>
						<?php }else{ ?>
							<a class="h_top_link" href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a>
						<?php } ?>
					<?php } ?>


					<!-- LK -->
					<?php if ($logged) { ?>
					<div class="top_acc">
						<div class="h_top_link has_inner"><?php echo $text_my_lk; ?></div>
						<div class="top_acc_submenu">			
							<a class="user_link" href="<?php echo $edit; ?>">
								<img src="./catalog/view/theme/THEME/stylesheet/img/account.svg"> 
								<?php echo $text_my_account; ?></a>
							<a class="user_link" href="<?php echo $order; ?>">
								<img src="./catalog/view/theme/THEME/stylesheet/img/list.svg">
								<?php echo $text_my_orders; ?></a>
							<a class="user_link" href="<?php echo $wishlist; ?>">
								<img src="./catalog/view/theme/THEME/stylesheet/img/heart.svg">
								<?php echo $text_wishlist; ?></a>
								<!-- ссылка на страницу с отзывами пользователя -->
								<a href="#" class="user_link">
									<img src="./catalog/view/theme/THEME/stylesheet/img/my_rev.svg">
									Мои отзывы
								</a>
							<a class="user_link" href="<?php echo $newsletter; ?>">
								<img src="./catalog/view/theme/THEME/stylesheet/img/notifications.svg">
								<?php echo $text_newsletter; ?></a>
							<a class="user_link" href="<?php echo $address; ?>">
								<img src="./catalog/view/theme/THEME/stylesheet/img/adress.svg">
								<?php echo $text_address; ?></a>
							<a class="user_link" href="<?php echo $logout; ?>">
								<img src="./catalog/view/theme/THEME/stylesheet/img/logout.svg">
								<?php echo $text_logout_new; ?></a>
							
						</div>
					</div>
					<?php } ?>
				</nav>
			<?php } ?>

			<div class="top_right">
				<?php echo $language; ?>
				

				<!-- <div class="lang language-select" type="button" name="ua">Укр</div>
				<div class="lang active language-select" type="button" name="ru">Рус</div> -->

				<a href="<?php echo $wishlist; ?>" class="h_top_link my_fav"><img src="./catalog/view/theme/THEME/img/heart.svg" alt="Закладки"><?php echo $text_wishlist; ?></a>
				<a class="h_top_link login log-link" href="<?php echo $account; ?>"> 
					<img src="./catalog/view/theme/THEME/img/login.svg" alt="Войти">
					<?php echo $text_login; ?>
					<!-- <span class="ico-enter hidden-lg hidden-md"><?php echo $text_login; ?></span> -->
				</a>
			</div>
		</div>

		<div class="header_mid">

			<?php if ($logo) { ?>
				<a class="logo" href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" /></a>
				
			<?php } else { ?>
				<h1><a href="<?php echo $home; ?>"><?php echo $name; ?></a></h1>
			<?php } ?>

			<div class="sitesearch" id="search">
				<?php echo $search; ?>
			</div>
			<div class="search_icon_btn"></div>

			<div class="contact">
				<div class="phones_selectbox">
					<a class="phone selected" href="tel:0507164195"><?php echo $GLOBALS['contact']['number2']; ?></a>
					<div class="phones">
						<a class="phone" href="tel:0961990177"><?php echo $GLOBALS['contact']['number4']; ?></a>
						<a class="phone" href="tel:0633208956"><?php echo $GLOBALS['contact']['number5']; ?></a>

						<a class="phone" href="viber://chat?number=%2B38<?php echo $GLOBALS['contact']['number3']; ?>">Viber: <?php echo $GLOBALS['contact']['number3']; ?></a>
					</div>
					<div class="carret"></div>
				</div>

				<button class="callback" data-toggle="modal" data-target="#re-call-modal"><?php echo $text_call_me_back; ?></button>
			</div>
			<a href="<?php echo $wishlist; ?>" class="h_top_link my_fav <?php echo $wishlist_active; ?>"><img src="./catalog/view/theme/THEME/img/heart.svg" alt="<?php echo $text_wishlist; ?>"><?php echo $text_wishlist; ?></a>

			<?php echo $cart; ?>

			<div class="menubtn">
				<span></span>
				<span></span>
				<span></span>
			</div>

		</div>

		<ul class="menu">
			<!-- Main page text var -->
			<li class="menuitem showmobile active"><a href="<?php echo $home; ?>">Главная</a></li>

				<?php foreach ($categories as $key => $category) { ?>
				<li class="menuitem">
					<?php if ($key == '0') { ?>
						<a href="#">Каталог</a>
					<?php } ?>
					<?php if ($category['children']) { ?>
						
					<ul class="submenu">
						<?php foreach (array_chunk($category['children'], ceil(count($category['children']) / $category['column'])) as $children) { ?>
							<?php foreach ($children as $child) { ?>
								<li class="submenuitem">
									<a href="<?php echo $child['href'];?>#category-start">
										<?php echo $child['name']; ?>
									</a>
								</li>
							<?php } ?>
						<?php } ?>
					</ul>
					<?php } else { ?>
					<a href="<?php echo $category['href'];?>#category-start">
						<?php echo $category['name']; ?>
					</a>
					<?php } ?>
				</li>
				<?php } ?>


<!-- 			<li class="menuitem"><a href="#">Акции</a></li>
			<li class="menuitem"><a href="#">Новинки</a></li>
			<li class="menuitem"><a href="#">Подарочные издания</a></li>
			<li class="menuitem"><a href="#">Развлечения</a></li> -->
		</ul>
	</header>


<!-- callback modal -->

<div class="modal" id="re-call-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal_content">
		<div class="closebtn"></div>
			<h2><?php echo $text_callback; ?></h2>
			<p class="modal-title" id="re-call-label" data-success=""><?php echo $text_call_me_back_text; ?></p>
			

			<p style="display: none;"><?php echo $text_information_sent; ?></p>
			<form id="callback_in_header" class="login">
				<fieldset class="log_fields">
					<input id="form_header" type="hidden" name="form" value="Форма: обратный звонок">
					<div class="inp_error_tel"><?php echo $text_input_error; ?></div>
					<input id="form_header_phone" type="text" placeholder="+ 38 ( _ _ _ ) _ _ _   _ _   _ _">
				</fieldset>
				<button	 type="submit" class="btn-call btn btn_grad"><?php echo $text_call_me_back; ?></button>
			</form>
		</div>
	</div>
</div>	
