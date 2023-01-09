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
  <?php if ($error_warning) { ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
  <?php } ?>

    <div id="content" class="login_inner centered">
      <?php echo $content_top; ?>

      <div id="restore_pass" class="modal">
        <div class="modal_content">
          <div class="closebtn"></div>
          <h2><?php echo $heading_title; ?></h2>
          <p><?php echo $text_email; ?></p>
          
          <form class="restore" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
            <fieldset class="log_fields">
            <div class="form-group required">
              <label class="col-sm-2 control-label" for="input-email"><?php echo $entry_email; ?></label>
                <input type="email" name="email"   id="input-email" class="form-control" />
            </div>
          </fieldset>
            <input type="submit" value="<?php echo $button_continue; ?>" class="btn btn_grad" /> 
            <!-- Отправить мне письмо - vslue -->
          </form>
        </div>
      </div>
    </div>
<!-- 
          <h1><?php echo $heading_title; ?></h1>
      <p><?php echo $text_email; ?></p>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
        <fieldset class="log_fields">
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-email"><?php echo $entry_email; ?></label>
              <input type="email" name="email" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" />
          </div>
        </fieldset>
        <div class="buttons clearfix">
          <div class="pull-left"><a href="<?php echo $back; ?>" class="btn btn-default"><?php echo $button_back; ?></a></div>
          <div class="pull-right">
            <input type="submit" value="<?php echo $button_continue; ?>" class="btn btn-primary" />
          </div>
        </div>
      </form> -->


<?php echo $footer; ?>