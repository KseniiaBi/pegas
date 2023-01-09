<?php echo $header; ?>

<style type="text/css">
  .button-continue {
    border: none;
    border-radius: 0;
    font-size: 21px;
    font-weight: 100;
    color: #fff;
    background: #33a6b2;
    padding: 16px 58px 14px 58px;
  }
  .button-continue:hover {
    background: #de2544;
  }
</style>

<div class="container">
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
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <h1><?php echo $heading_title; ?></h1>
<!--      <p><?php echo $text_error; ?></p> -->

<!--- моя вставка     ---> 
<div class="container" align="center">
      <img class="img-responsive" src="https://pegas.ua/catalog/view/theme/THEME/image/404.jpg" width="607" height="500" alt="404 error"/>
      <div class="row" align="center">
           	<div class="btn btn-default btn-lg"> <a href="https://pegas.ua/" title="Главная"><span class="seria">На главную</span></a></div>
            <div class="btn btn-default btn-lg"> <a href="https://pegas.ua/literature-catalog" title="Каталог литературы">Полный список всех книг</a></div>
            <div class="btn btn-default btn-lg"> <a href="https://pegas.ua/fairy-tales" title="Сказки">Сказки</a></div>
            <div class="btn btn-default btn-lg"> <a href="https://pegas.ua/encyclopedia" title="Энциклопедии">Детские энциклопедии</a></div>
            <div class="btn btn-default btn-lg"> <a href="https://pegas.ua/novelty" title="Новинки издательского дома ПЕГАС">Новинки</a></div>

      </div>
      
</div>
<!--- моя вставка    ---> 

<!--- <div class="buttons">

    <div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary button-continue"><?php echo $button_continue; ?></a></div>
      </div> ---> 
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>  
<?php echo $footer; ?>