<aside class="user_nav">
            <a href="<?php echo $edit; ?>" class="user_link<?php if ($route == 'account/simpleedit') { echo ' active'; } ?>">
                <img src="/catalog/view/theme/THEME/stylesheet/img/account.svg" alt="<?php echo $text_edit; ?>">
                <?php echo $text_edit; ?>
            </a>
            <a href="<?php echo $order; ?>" class="user_link<?php if ($route == 'account/order') { echo ' active'; } ?>">
                <img src="/catalog/view/theme/THEME/stylesheet/img/list.svg" alt="<?php echo $text_my_orders; ?>">
                <?php echo $text_my_orders; ?>
            </a>
            <a href="<?php echo $wishlist; ?>" class="user_link<?php if ($route == 'account/wishlist') { echo ' active'; } ?>">
                <img src="/catalog/view/theme/THEME/stylesheet/img/heart.svg" alt="<?php echo $text_wishlist; ?>">
                <?php echo $text_wishlist; ?>
            </a>
            <a href="<?php echo $reviews; ?>" class="user_link<?php if ($route == 'account/reviews') { echo ' active'; } ?>">
                <img src="/catalog/view/theme/THEME/stylesheet/img/my_rev.svg" alt="<?php echo $text_my_reviews; ?>">
                <?php echo $text_my_reviews; ?>
            </a>
            <a href="<?php echo $newsletter; ?>" class="user_link<?php if ($route == 'account/newsletter') { echo ' active'; } ?>">
                <img src="/catalog/view/theme/THEME/stylesheet/img/notifications.svg" alt="<?php echo $text_newsletter; ?>">
                <?php echo $text_newsletter; ?>
            </a>
            <a href="<?php echo $address; ?>" class="user_link<?php if ($route == 'account/address') { echo ' active'; } ?>">
                <img src="/catalog/view/theme/THEME/stylesheet/img/adress.svg" alt="<?php echo $text_my_address_book; ?>">
                <?php echo $text_my_address_book; ?>
            </a>
            <a href="<?php echo $logout; ?>" class="user_link<?php if ($route == 'account/logout') { echo ' active'; } ?>">
                <img src="/catalog/view/theme/THEME/stylesheet/img/logout.svg" alt="<?php echo $text_logout_new; ?>">
                <?php echo $text_logout_new; ?>
            </a>
        </aside>
