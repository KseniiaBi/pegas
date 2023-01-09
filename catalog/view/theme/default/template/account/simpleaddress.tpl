<?php if (!$ajax && !$popup && !$as_module) { ?>
<?php $simple_page = 'simpleaddress'; include $simple_header; ?>


<div class="cabinet_inner centered">

    <aside class="user_nav">
        <a href="./index.php?route=account/simpleedit" class="user_link">
            <img src="/catalog/view/theme/THEME/stylesheet/img/account.svg" alt="Личные данные">
            Личные данные
        </a>
        <a href="./order-history/" class="user_link">
            <img src="/catalog/view/theme/THEME/stylesheet/img/list.svg" alt="Мои заказы">
            Мои заказы
        </a>
        <a href="./wishlist/" class="user_link">
            <img src="/catalog/view/theme/THEME/stylesheet/img/heart.svg" alt="Закладки">
            Закладки
        </a>
        <a href="#" class="user_link">
            <img src="/catalog/view/theme/THEME/stylesheet/img/my_rev.svg" alt="Мои отзывы">
            Мои отзывы
        </a>
        <a href="./newsletter/" class="user_link">
            <img src="/catalog/view/theme/THEME/stylesheet/img/notifications.svg" alt="Подписка на рассылку">
            Подписка на рассылку
        </a>
        <a href="./index.php?route=account/simpleaddress/" class="user_link active">
            <img src="/catalog/view/theme/THEME/stylesheet/img/adress.svg" alt="Адресная книга">
            Адресная книга
        </a>
        <a href="./logout/" class="user_link">
            <img src="/catalog/view/theme/THEME/stylesheet/img/logout.svg" alt="Выйти из аккаунта">
            Выйти из аккаунта
        </a>
    </aside>


    <section class="user_space">
        <h2>Адресная книга</h2>

        <div class="simple-content">
        <?php } ?>
            <?php if (!$ajax || ($ajax && $popup)) { ?>
            <script type="text/javascript">
                var startSimpleInterval = window.setInterval(function(){
                    if (typeof jQuery !== 'undefined' && typeof Simplepage === "function" && jQuery.isReady) {
                        window.clearInterval(startSimpleInterval);

                        var simplepage = new Simplepage({
                            additionalParams: "<?php echo $additional_params ?>",
                            additionalPath: "<?php echo $additional_path ?>",
                            mainUrl: "<?php echo $action; ?>",
                            mainContainer: "#simplepage_form",
                            useAutocomplete: <?php echo $use_autocomplete ? 1 : 0 ?>,
                            useGoogleApi: <?php echo $use_google_api ? 1 : 0 ?>,
                            scrollToError: <?php echo $scroll_to_error ? 1 : 0 ?>,
                            notificationDefault: <?php echo $notification_default ? 1 : 0 ?>,
                            notificationToasts: <?php echo $notification_toasts ? 1 : 0 ?>,
                            notificationCheckForm: <?php echo $notification_check_form ? 1 : 0 ?>,
                            notificationCheckFormText: "<?php echo $notification_check_form_text ?>",
                            languageCode: "<?php echo $language_code ?>",
                            javascriptCallback: function() {<?php echo $javascript_callback ?>}
                        });

                        if (typeof toastr !== 'undefined') {
                            toastr.options.positionClass = "<?php echo $notification_position ? $notification_position : 'toast-top-right' ?>";
                            toastr.options.timeOut = "<?php echo $notification_timeout ? $notification_timeout : '5000' ?>";
                            toastr.options.progressBar = true;
                        }

                        simplepage.init();
                    }
                },0);
            </script>
            <?php } ?>
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="simplepage_form" class="user_data">    
                <div class="simpleregister" id="simpleaddress">
                    <div class="simpleregister-block-content">
                        <?php foreach ($rows as $row) { ?>
                          <?php echo $row ?>
                        <?php } ?>
                        <?php foreach ($hidden_rows as $row) { ?>
                          <?php echo $row ?>
                        <?php } ?>
                    </div>
                    <div class="simpleregister-button-block buttons">
                        <div class="simpleregister-button-right">
                            <a class="button btn_grad button_oc btn" data-onclick="submit" id="simpleregister_button_confirm"><span><?php echo $button_continue; ?></span></a>
                        </div>
                    </div>
                </div>
                <?php if ($redirect) { ?>
                    <input type="hidden" id="simple_redirect_url" value="<?php echo $redirect ?>">
                <?php } ?>
            </form>
        <?php if (!$ajax && !$popup && !$as_module) { ?>
        </div>
    </section>
</div>
<?php include $simple_footer ?>
<?php } ?>