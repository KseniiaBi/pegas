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


  <div class="cabinet_inner centered">
       <?php echo $column_left; ?>


    <section class="user_space mails">
      <h2><?php echo $heading_title; ?></h2>
      <p><?php echo $text_subsc; ?></p>
      <p><?php echo $entry_newsletter; ?></p>

      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal user_subscr">
        
        <?php if ($newsletter) { ?>
        <span class="remember">
          <input type="radio" id="subscr1" name="newsletter" value="1" checked="checked" />
          <label for="subscr1"> </label><?php echo $text_yes; ?> 
        </span>
        <span class="remember">
          <input type="radio" id="subscr2" name="newsletter" value="0" />
          <label for="subscr2"> </label><?php echo $text_no; ?>
        </span>
        <?php } else { ?>
        <span class="remember">
          <input type="radio" id="subscr1" name="newsletter" value="1" />
          <label for="subscr1"> </label><?php echo $text_yes; ?>
        </span>
        <span class="remember">
          <input type="radio" id="subscr2" name="newsletter" value="0" checked="checked" />
          <label for="subscr2"> </label><?php echo $text_no; ?>
        </span>
        <?php } ?>
        
        <input type="submit" value="<?php echo $button_continue; ?>" class="btn btn_grad" />

      </form>
    </section>
</div>
<?php echo $footer; ?>