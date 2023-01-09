<div id="main-slider" class="slider banner">
  <ul class="slidernavs">
    <?php foreach ($banners as $banner) { ?>
    <li class="sl_dot "></li>
    <?php } ?>
  </ul>

  <?php foreach ($banners as $banner) { ?>
  <a href="<?php echo $banner['link']; ?>">
    <div class="slide ">
        
          <img class="banner_img" src="<?php echo $banner['image']; ?>" alt="">
        
        <!-- <div class="banner_content">
          <div class="banner_descr">
              <p><?php echo $banner['title']; ?></p>
              <p><?php echo $banner['description']; ?></p>
          </div>  
        </div> -->
    </div>
  </a>
  <?php } ?>
</div>

