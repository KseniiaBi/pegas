<footer>
	<div class="container">
		<div class="footer-holder clearfix">
			<div class="col-md-6 col-sm-4">
				<div class="logo hidden-xs ">
					<a class="logo-link" href="<?php echo $home; ?>">
						<img src="catalog/view/image/catalog/lgo.png" alt="">
					</a>
				</div>
			</div>
			<div class="col-md-6 col-sm-8">
				<div class="connect clearfix">
					<div class="row">
						<div class="col-md-12 col-sm-6">
							<div class="social">
								<ul class="social-list">
									<li><a href="https://vk.com/club30769713" target="_blank"><i class="ico vk-ico"></i></a></li>
									<li><a href="https://www.facebook.com/pegaspublishing" target="_blank"><i class="ico fa-ico"></i></a></li>
									<li><a href="#"><i class="ico inst-ico"></i></a></li>
									<li><a href="#"><i class="ico google-ico"></i></a></li>
								</ul>
							</div>
							<div class="connect-boss hidden-xs">
								<button class="btn-writeboss" data-toggle="modal" data-target="#writeboss-modal"><?php echo $text_writeboss; ?></button>
							</div>
						</div> 
						<div class="col-md-12 col-sm-6">
							<div class="phones clearfix">
								<table class="phones-table mobile-phones">
									<tr><td><?php echo $text_contact_number1; ?>: <br><?php echo $GLOBALS['contact']['number1']; ?></td></tr>
									<tr><td><?php echo $text_contact_number2; ?>: <br><?php echo $GLOBALS['contact']['number2']; ?></td></tr>
								</table>
								<table class="phones-table city-phones hidden-sm hidden-xs">
									<tr><td><?php echo $text_contact_number4; ?>: <br><?php echo $GLOBALS['contact']['number4']; ?></td></tr>
									<tr><td><?php echo $text_contact_number5; ?>: <br><?php echo $GLOBALS['contact']['number5']; ?></td></tr>
								</table>
								<table class="phones-table inter-phones">
									<tr><td>E-mail: <br><?php echo $GLOBALS['contact']['email']; ?></td></tr>
									<tr><td>Skype: <br><?php echo $GLOBALS['contact']['skype']; ?></td></tr>
								</table>
							</div>
							<div class="connect-boss hidden-lg hidden-md hidden-sm">
								<button class="btn-writeboss"><?php echo $text_writeboss; ?></button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<p class="copyright"><?php echo $powered; ?></p>
		</div>
	</div>
</footer>

<div class="modal fade" id="writeboss-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="re-call-label" data-success=""><?php echo $text_writeboss; ?></h4>
			</div>
			<form id="write_in_footer">
			<div class="modal-body">
				<p style="display: none;" data-success="<?php echo $text_information_sent; ?>"></p>
				<input id="form_footer" type="hidden" name="form" value="Форма: сообщить об ошибке">
				<div class="inp_error_email"><?php echo $text_email_error; ?></div>
				<div class="inp_error_email_valid"><?php echo $text_email_valid; ?></div>
				<input id="form_footer_email" name="email" type="text" placeholder="<?php echo $text_writeboss_email; ?>">
				<div class="inp_error"><?php echo $text_textarea_error; ?></div>
				<textarea id="form_footer_text" name="text" placeholder="<?php echo $text_writeboss_text; ?>" style="margin-top: 10px; height: 150px;"></textarea>
			</div>
			<div class="modal-footer">
				<button type="submit" class="btn-call"><?php echo $text_writeboss; ?></button>
			</div>
			</form>
		</div>
	</div>
</div>

<!-- Yandex.Metrika informer -->
<a href="https://metrika.yandex.ru/stat/?id=12431506&amp;from=informer"
target="_blank" rel="nofollow"><img src="https://informer.yandex.ru/informer/12431506/1_1_FFFFFFFF_EFEFEFFF_0_pageviews"
style="width:80px; height:15px; border:0;" alt="Яндекс.Метрика" title="Яндекс.Метрика: данные за сегодня (просмотры)" class="ym-advanced-informer" data-cid="12431506" data-lang="ru" /></a>
<!-- /Yandex.Metrika informer -->

<!-- Yandex.Metrika counter -->
<script type="text/javascript">
    (function (d, w, c) {
        (w[c] = w[c] || []).push(function() {
            try {
                w.yaCounter12431506 = new Ya.Metrika({
                    id:12431506,
                    clickmap:true,
                    trackLinks:true,
                    accurateTrackBounce:true,
                    webvisor:true
                });
            } catch(e) { }
        });

        var n = d.getElementsByTagName("script")[0],
            s = d.createElement("script"),
            f = function () { n.parentNode.insertBefore(s, n); };
        s.type = "text/javascript";
        s.async = true;
        s.src = "https://mc.yandex.ru/metrika/watch.js";

        if (w.opera == "[object Opera]") {
            d.addEventListener("DOMContentLoaded", f, false);
        } else { f(); }
    })(document, window, "yandex_metrika_callbacks");
</script>
<noscript><div><img src="https://mc.yandex.ru/watch/12431506" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
<!-- /Yandex.Metrika counter -->


</body></html>