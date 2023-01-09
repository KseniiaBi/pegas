<?php echo $header; ?>
<div class="centered">
   <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
</div>

  <section class="cart_inner centered">
    <h2>Корзина</h2>

    <div class="ch_tabs tabs" data-id="checkout_tbs">
      <div class="checkout_steps">
        <div class=" checkout_step checkout_tbs " data-id="ch1">
          <img src="./catalog/view/theme/THEME/stylesheet/img/checkout_1.svg" alt="">
          <div class="ch_step_name">Получатель</div>
        </div>
        <div class=" checkout_step checkout_tbs" data-id="ch2">
          <img src="./catalog/view/theme/THEME/stylesheet/img/checkout_2.svg" alt="">
          <div class="ch_step_name">Доставка</div>
        </div>
        <div class=" checkout_step checkout_tbs" data-id="ch3">
          <img src="./catalog/view/theme/THEME/stylesheet/img/checkout_3.svg" alt="">
          <div class="ch_step_name">Оплата</div>
        </div>
        <div class=" checkout_step checkout_tbs active" data-id="ch4">
          <img src="./catalog/view/theme/THEME/stylesheet/img/checkout_4.svg" alt="">
          <div class="ch_step_name">Готово</div>
        </div>
      </div>

      <div class="checkout_content ">


        <div id="ch4" class="tab ch_c_item checkout_tbs active">
          <h2>Готово</h2>

          <div class="ready_msg">
            <img src="./catalog/view/theme/THEME/stylesheet/img/ready.svg" alt="готово!">
            <h5><?php echo $heading_title; ?></h5>
            <div class="ready_content"><?php echo $text_message; ?></div>
            <a href="<?php echo $continue; ?>" class="btn btn_grad"><?php echo $button_continue; ?></a>
          </div>
        </div>

      </div>

  </section>
  
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>



<?php echo $footer; ?>