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


      <section class="login_inner centered">
      <?php echo $content_top; ?>
       
        <div class="login_form">
            <h2><?php echo $text_returning_customer; ?></h2>

            <form class="login" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
              <div class="form-group">
                <fieldset class="log_fields">
                  <label class="control-label" for="input-email"><?php echo $entry_email; ?></label>
                  <input type="email" name="email"  id="input-email" class="form-control" />
              </fieldset>
              </div>
              <div class="form-group">
                <fieldset class="log_fields">
                  <label class="control-label" for="input-password"><?php echo $entry_password; ?></label>
                  <input type="password" name="password"   id="input-password" class="form-control" />
                  <div class="showpass"></div>
                </fieldset>
              </div>

                <div class="log_links">
                <span class="remember">
                  <!-- запомнить пользователя -->
                  <input id="rememberme" type="checkbox" name="rememberme">
                  <label for="rememberme"></label>
                  Запомнить меня  
                </span>
                <span id="forgot" class="forgot"><?php echo $text_forgotten; ?></span>
              </div>
              <input class="btn btn_grad" type="submit" value="<?php echo $button_login; ?>" class="btn btn-primary" />
              <?php if ($redirect) { ?>
              <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
              <?php } ?>
            </form>
        </div>

        <!-- сюда нужно пробросить текст  -->
        <div class="goto_register">
          <img src="./catalog/view/theme/THEME/stylesheet/img/newacc.svg" alt="">
          <h3>Новый аккаунт</h3>
          <p>У вас еще нет аккаунта?</p>
          <a href="./simpleregister" class="btn btn_grad">Создать</a>
        </div>


        

        <?php if ($success) { ?>
        <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?></div>
        <?php } ?>
        <?php if ($error_warning) { ?>
        <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
        <?php } ?>

      </section>


      <div id="restore_pass" class="modal">
        <div class="modal_content">
          <div class="closebtn"></div>
          <h2>Восстановление пароля</h2>
          <p><?php echo $text_email; ?></p>
          
          <form id="enter_mail" class="restore" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
            <fieldset class="log_fields">
            <div class="form-group required">
              <label class="col-sm-2 control-label" for="restore-email"><?php echo $entry_email; ?></label>
                <input type="email" name="email"   id="restore-email" class="form-control" />
            </div>
          </fieldset>
            <input id="restore_pass_submit" type="submit" value="<?php echo $button_continue; ?>" class="btn btn_grad" /> 
            <!-- Отправить мне письмо - vslue -->
          </form>
        </div>
      </div>


      <div id="restore_pass2" class="modal">
        <div class="modal_content">
          <div class="closebtn"></div>
          <h2>Проверьте почту</h2>
          <p>Мы отправили инструкции по восстановлению пароля на вашу электронную почту</p>

          <a class="btn btn_grad" href="#">Открыть почту</a>
          
          <div class="notget">Не получили письмо? <a href="#">Отправить&nbsp;повторно</a></div>
        </div>
      </div>

      <div id="restore_pass3" class="modal">
        <div class="modal_content">
          <div class="closebtn"></div>
          <h2>Создайте новый пароль</h2>
          <p>Создайте новый надежный пароль, который будет легко запомнить для вас</p>
          
          <form class="restore">
            <fieldset class="log_fields">
              <label>Пароль </label>
              <input type="password" name="emailrestore">
              <div class="showpass"></div>
              <label>Должен содержать не менее 8 символов </label>
            </fieldset>
            <input class="btn btn_grad" type="submit" value="Сменить пароль">
          </form>
        </div>
      </div>

      <div id="restore_success" class="modal">
        <div class="modal_content">
          <div class="closebtn"></div>
          <h2>Пароль восстановлен</h2>
          <p>Вы успешно восстановили пароль. Теперь вам будет нужно войти в свою учетную запись используя новый&nbsp;пароль</p>

          <a class="btn btn_grad" href="#">Войти в аккаунт</a>
        </div>
      </div>

<!-- 
  <div class="inform-log">
  <?php echo $text_advantages; ?>
  </div> -->

  <script>
    $('#forgot').click(()=>$('#restore_pass').css({'display': 'flex'}));

    $('#restore_pass_submit').click((e) => {
          $.ajax({
          url: 'index.php?route=account/forgotten/ajaxForgotten',
          type: 'post',
          dataType: 'json',
          data: $("#enter_mail").serialize(),
          success: function(json) {
            $('.alert-success, .alert-danger').remove();

            if (json['error']) {
              $('.restore').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
            }

            if (json['success']) {
              $('.restore').after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');

              $('#restore-email').val('');
            }
          }
        });
    });


  </script>

<?php echo $footer; ?>