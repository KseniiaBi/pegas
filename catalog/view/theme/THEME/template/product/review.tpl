<?php if ($reviews) { ?>
<div class="rev_content">
<?php foreach ($reviews as $review) { ?>

  <div class="review_item">
    <p class="review_text">
      <?php echo $review['text']; ?>
    </p>
    <div class="rev_author">
      <div class="rev_name"><?php echo $review['author']; ?></div>
      <div class="rev_date">
        <?php echo $review['date_added']; ?>
      </div>
    </div>
    <div class="rev_rating rating">

      <?php for ($i = 1; $i <= 5; $i++) { ?>
      <?php if ($review['rating'] < $i) { ?>
      <div class="star not_filled"></div>
      <?php } else { ?>
      <div class="star filled"></div>
      <?php } ?>
      <?php } ?>
    </div>
  </div>

<?php } ?>

</div>

<!-- <div class="text-right"><?php echo $pagination; ?></div> -->
<?php } else { ?>
<div class="review_item no_reviews">
  <img src="./catalog/view/theme/THEME/stylesheet/img/review.svg" alt="">
  <p><?php echo $text_no_reviews; ?></p>
</div>
<?php } ?>


<script>
  initReviews();
</script>