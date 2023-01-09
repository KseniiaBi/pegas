<?php echo $header; ?>

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
  <div class="row centered"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <h2><?php echo $text_error; ?></h2>
<!--  <h1><?php echo $heading_title; ?></h1>
      <p><?php echo $text_error; ?></p> -->

<div class="container" align="center">
      <img class="img-responsive" src="https://pegas-publishing.com.ua/catalog/view/theme/THEME/image/404.jpg" width="607" height="500" alt="404 error"/>
      
</div>


      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>  
<?php echo $footer; ?>