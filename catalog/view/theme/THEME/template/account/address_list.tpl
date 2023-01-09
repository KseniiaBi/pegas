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

  <?php if ($success) { ?>
  <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?></div>
  <?php } ?>
  <?php if ($error_warning) { ?>
  <div class="alert alert-warning"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
  <?php } ?>

  <div class="cabinet_inner centered">
    <?php echo $column_left; ?>

  <section class="user_space user_saved">
      <div class="user_saved_text">
        <?php echo $content_top; ?>
      <h2><?php echo $text_address_book; ?></h2>
      <?php if ($addresses) { ?>
      <div class="table-responsive">
        <table class="table table-bordered table-hover">
          <?php foreach ($addresses as $result) { ?>
          <tr>
            <td class="text-left"><?php echo $result['address']; ?></td>
            <td class="text-right"><a href="<?php echo $result['update']; ?>" class="btn btn btn_bordered"><span><?php echo $button_edit; ?></span></a> &nbsp; 
            <a href="<?php echo $result['delete']; ?>" class="btn btn_bordered dislike"><img src="./catalog/view/theme/THEME/stylesheet/img/trash.svg" alt="удалить"></a></td>
          </tr>
          <?php } ?>
        </table>
      </div>
      <?php } else { ?>
      <p><?php echo $text_empty; ?></p>
      <?php } ?>
      <div class="buttons clearfix">
        <a href="<?php echo $back; ?>" class="btn btn_bordered"><span><?php echo $button_back; ?></span></a>
        <a href="<?php echo $add; ?>" class="btn btn_grad"><?php echo $button_new_address; ?></a>
      </div>
      <?php echo $content_bottom; ?>
    </div>
  </section>
    <?php echo $column_right; ?>
  </div>

<?php echo $footer; ?>