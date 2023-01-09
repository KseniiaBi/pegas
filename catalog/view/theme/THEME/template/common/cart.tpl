      <div class="cart">
        <a href="<?php echo $cart; ?>" title="<?php echo $text_shopping_cart; ?> " class="cart_btn <?php if ($active_cart) { echo "active"; } ?>">
          <img src="./catalog/view/theme/THEME/img/cart.svg" alt="<?php echo $text_cart; ?>">
        </a>
        <div class="cart_info">
          <!-- <strong><?php echo $text_title_cart; ?></strong> -->
          <div class="cart_info" id="cart-count"><?php echo $text_items; ?></div>
        </div>
      </div>