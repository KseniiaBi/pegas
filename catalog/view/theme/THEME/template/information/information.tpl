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
  <?php echo $column_left; ?>
    
    <div id="content">
      <?php echo $content_top; ?>
      <!-- <h1><?php echo $heading_title; ?></h1> -->
      <?php echo $description; ?><?php echo $content_bottom; ?>
      </div>
    <?php echo $column_right; ?>

<?php echo $footer; ?>