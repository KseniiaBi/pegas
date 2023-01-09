
	
	<footer>
		<svg id="footer_top" viewBox="0 0 1440 622" >
			<path fill-rule="evenodd" clip-rule="evenodd" d="M0 122C45.5 89.6837 188.7 39.2438 391.5 78.0233C636.829 124.935 779.59 79.551 835.683 61.7186C837.551 61.1247 839.324 60.5614 841 60.033C845.482 58.6204 850.982 56.8035 857.389 54.6873C930.305 30.6005 1120.64 -32.2741 1264.5 20.5539C1389.7 66.5294 1434.17 105.842 1440 122L1440 622H0V122Z" fill="url(#paint0_linear)"/>
			<defs>
			<linearGradient id="paint0_linear" x1="1.46771e-05" y1="326.55" x2="1440" y2="326.55" gradientUnits="userSpaceOnUse">
			<stop stop-color="#587A41"/>
			<stop offset="1" stop-color="#79AB49"/>
			</linearGradient>
			</defs>
		</svg>

		<div class="footercol">
			<h3><?php echo $text_publisher; ?></h3>
			<a class="footerlink" href="<?php echo $about_us; ?>"><?php echo $text_about_us; ?></a>
			<a class="footerlink" href="<?php echo $blog; ?>"><?php echo $text_blog; ?></a>
			<a class="footerlink" href="<? echo $contact; ?>"><?php echo $text_contact; ?></a>
		</div>


		<div class="footercol">
			<h3><?php echo $text_information; ?></h3>
			<a class="footerlink" href="<?php echo $special; ?>"><?php echo $text_special; ?></a>
			<a class="footerlink" href="<?php echo $dropshipping; ?>"><?php echo $text_affiliate; ?></a>
			<a class="footerlink" href="<?php echo $payment; ?>"><?php echo $text_payment; ?></a>
			<a class="footerlink" href="#"><?php echo $text_garant; ?></a>
			<a class="footerlink" href="<?php echo $return; ?>"><?php echo $text_return; ?></a>
		</div>

		<div class="footercol">
			<h3><?php echo $text_extra; ?></h3>
			<a class="footerlink" href="<?php echo $account; ?>"><?php echo $text_account; ?></a>
			<a class="footerlink" href="<?php echo $personal; ?>"><?php echo $text_personal; ?></a>
			<a class="footerlink" href="<?php echo $order; ?>"><?php echo $text_order; ?></a>
			<a class="footerlink" href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a>
			<a class="footerlink" href="<?php echo $my_cart; ?>"><?php echo $text_my_cart; ?></a>
		</div>

		<div class="footercol">
			<h3><?php echo $text_contact; ?></h3>
			<div class="phones_selectbox">
					<a class="phone selected" href="tel:0507164195">(050) 716 41 95</a>
					<div class="phones">
						<a class="phone" href="tel:0507164195">(050) 716 41 95</a>
						<a class="phone" href="tel:0961990177">(096) 199 01 77</a>
						<a class="phone" href="tel:0633208956">(063) 320 89 56</a>

						<a class="phone" href="viber://chat?number=%2B380952357425">Viber: (095) 235 74 25</a>
					</div>
					<div class="carret"></div>
				</div>

			<h3><?php echo $text_social; ?></h3>
			<div class="socials">
				<a href="https://www.instagram.com/pegas.books/" target="_blank"><img src="./catalog/view/theme/THEME/img/instagram.svg" alt="instagram"></a>
				<a href="https://www.youtube.com/channel/UCMqXkwLBv5xwGG44a3zDfXg" target="_blank"><img src="./catalog/view/theme/THEME/img/youtube.svg" alt="youtube"></a>
				<a href="https://www.facebook.com/pegasbooks" target="_blank"><img src="./catalog/view/theme/THEME/img/facebook.svg" alt="facebook"></a>
			</div>
		</div>
		
		<div class="copyrights">
			<p class="copy"><?php echo $text_powered; ?></p>
			<a href="https://goo.gl/maps/z8UmyZBj6Gm2CjGb6" target="_blank" class="adress"><?php echo $text_addr; ?></a>
		</div>

	</footer>




	<script type="text/javascript">
		window.showmoreProductsButtonLabel = '<?php echo $text_pagination_show_more; ?>';
	</script>

	<!-- modal show book preview -->

	<div id="showbook" class="modal"></div>
	<script src="/catalog/view/javascript/main.js"></script>

</body>
</html>
