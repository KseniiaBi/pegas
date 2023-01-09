<?php echo $header; ?>

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



    <section class="lk_inner centered">
      
      <?php if ($success) { ?>
      <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?></div>
      <?php } ?>

      <?php echo $content_top; ?>
      <h2><?php echo $text_my_account; ?></h2>



<!-- пробросить текст на укр и имя юзера -->
    <div class="welcome">
      <img src="./catalog/view/theme/THEME/stylesheet/img/welcome.svg" alt="">
      <h3><?php echo $text_account_welcome; ?></h3>
      <p><?php echo $text_account_sub_welcome; ?></p>
    </div>


    <div class="cab_links">
      <a class="cab_link" href="<?php echo $edit; ?>">
        <img src="./catalog/view/theme/THEME/stylesheet/img/lk1.svg" alt="">
        <h5><?php echo $text_edit; ?></h5>
      </a>

      <a class="cab_link" href="<?php echo $order_progress; ?>">
        <img src="./catalog/view/theme/THEME/stylesheet/img/lk2.svg" alt="">
        <h5><?php echo $text_my_order; ?></h5>
      </a>

      <a class="cab_link" href="<?php echo $order; ?>">
        <img src="./catalog/view/theme/THEME/stylesheet/img/lk3.svg" alt="">
        <h5><?php echo $text_order; ?></h5>
      </a>

      <a class="cab_link" href="<?php echo $cart; ?>">
        <img src="./catalog/view/theme/THEME/stylesheet/img/lk4.svg" alt="">
        <h5><?php echo $text_my_cart; ?></h5>
      </a>

      <a class="cab_link" href="<?php echo $wishlist; ?>">
        <img src="./catalog/view/theme/THEME/stylesheet/img/lk5.svg" alt="">
        <h5><?php echo $text_wishlist; ?></h5>
      </a>

      <a class="cab_link" href="<?php echo $address; ?>">
        <img src="./catalog/view/theme/THEME/stylesheet/img/lk6.svg" alt="">
        <h5><?php echo $text_address; ?></h5>
      </a>
    </div>
</section>
<?php echo $footer; ?> 