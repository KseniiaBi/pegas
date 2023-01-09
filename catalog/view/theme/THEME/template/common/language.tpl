<?php if (count($languages) > 1) { ?>
<div class="leng-panel ">
<form  action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-language">
    



  <div class="btn-group">
    <button class="btn btn-link dropdown-toggle hidden-md hidden-lg" data-toggle="dropdown">
   <!--  <?php foreach ($languages as $language) { ?>
    <?php if ($language['code'] == $code) { ?>
    <img src="catalog/language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" alt="<?php echo $language['name']; ?>" title="<?php echo $language['name']; ?>">
    <?php } ?>
    <?php } ?> -->
    <span class=""><?php echo $text_language; ?></span> <i class="fa fa-chevron-down"></i></button>
    <ul class="dropdown-menu on-desktop dropdown-lang">
      <?php foreach ($languages as $language) { ?>
      <li><button class="btn btn-link btn-block language-select <?php echo ($code == $language['code'] ?  'active' : ''); ?>" type="button" name="<?php echo $language['code']; ?>"> <?php echo $language['name']; ?></button>
    
      </li>
      <?php } ?>
    </ul>
  </div>
  <input type="hidden" name="code" value="" />
  <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
</form>





</div>
<?php } ?>
