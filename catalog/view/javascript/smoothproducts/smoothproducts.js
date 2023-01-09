/*
 * Smoothproducts version 2.0.2
 * http://kthornbloom.com/smoothproducts.php
 *
 * Copyright 2013, Kevin Thornbloom
 * Free to use and abuse under the MIT license.
 * http://www.opensource.org/licenses/mit-license.php
 */

(function($) {
	$.fn.extend({
		smoothproducts: function() {

			// Add some markup & set some CSS

			$('.sp-loading').hide();
			$('.sp-wrap').each(function() {
				$(this).addClass('sp-touch');
				var thumbQty = $('a', this).length;

				// If more than one image
				if (thumbQty > 1) {
					$(this).append('<div class="sp-large"></div><div class="sp-thumbs sp-tb-active"></div>');
					$('a', this).each(function() {
						var thumb = $('img', this).attr('src'),
							large = $(this).attr('href');
						$(this).parents('.sp-wrap').find('.sp-thumbs').append('<a href="' + large + '" style="background-image:url(' + thumb + ')"></a>');
						$(this).remove();
					});
					$('.sp-thumbs a:first', this).addClass('sp-current');
					var firstLarge = $('.sp-thumbs a:first', this).attr('href'),
						firstThumb = get_url_from_background($('.sp-thumbs a:first', this).css('backgroundImage'));
						//alert(firstThumb);
					$('.sp-large', this).append('<a href="' + firstLarge + '" class="sp-current-big"><img src="' + firstThumb + '" alt="" /></a>');
					$('.sp-wrap').css('display', 'inline-block');
				// If only one image
				} else {
					$(this).append('<div class="sp-large"></div>');
					$('a', this).appendTo($('.sp-large', this)).addClass('.sp-current-big');
					$('.sp-wrap').css('display', 'inline-block');
				}
			});


			// Prevent clicking while things are happening
			$(document.body).on('click', '.sp-thumbs', function(event) {
				event.preventDefault();
			});


			// Is this a touch screen or not?
			$(document.body).on('mouseover', function(event) {
				$('.sp-wrap').removeClass('sp-touch').addClass('sp-non-touch');
				event.preventDefault();
			});

			$(document.body).on('touchstart', function() {
				$('.sp-wrap').removeClass('sp-non-touch').addClass('sp-touch');
			});

			// Clicking a thumbnail
			$(document.body).on('click', '.sp-tb-active a', function(event) {

				event.preventDefault();
				$(this).parent().find('.sp-current').removeClass();
				$(this).addClass('sp-current');
				$(this).parents('.sp-wrap').find('.sp-thumbs').removeClass('sp-tb-active');
				// $(this).parents('.sp-wrap').find('.sp-zoom').remove();

				var currentHeight = $(this).parents('.sp-wrap').find('.sp-large').height(),
					currentWidth = $(this).parents('.sp-wrap').find('.sp-large').width();
				$(this).parents('.sp-wrap').find('.sp-large').css({
					overflow: 'hidden',
					height: currentHeight + 'px',
					width: currentWidth + 'px'
				});

				$(this).addClass('sp-current').parents('.sp-wrap').find('.sp-large a').remove();

				var nextLarge = $(this).parent().find('.sp-current').attr('href'),
					nextThumb = get_url_from_background($(this).parent().find('.sp-current').css('backgroundImage'));

				$(this).parents('.sp-wrap').find('.sp-large').html('<a href="' + nextLarge + '" class="sp-current-big"><img src="' + nextThumb + '"/></a>');
				$(this).parents('.sp-wrap').find('.sp-large').hide().fadeIn(250, function() {

					var autoHeight = $(this).parents('.sp-wrap').find('.sp-large img').height();

					$(this).parents('.sp-wrap').find('.sp-large').animate({
						height: autoHeight
					}, 'fast', function() {
						$('.sp-large').css({
							height: 'auto',
							width: 'auto'
						});
					});

					$(this).parents('.sp-wrap').find('.sp-thumbs').addClass('sp-tb-active');
				});
			});

			// Zoom In non-touch
			// $(document.body).on('mouseenter', '.sp-non-touch .sp-large', function(event) {
			// 	var largeUrl = $('a', this).attr('href');
			// 	$(this).append('<div class="sp-zoom"><img src="' + largeUrl + '"/></div>');
			// 	$(this).find('.sp-zoom').fadeIn(250);
			// 	event.preventDefault();
			// });

			// Zoom Out non-touch
			// $(document.body).on('mouseleave', '.sp-non-touch .sp-large', function(event) {
			// 	$(this).find('.sp-zoom').fadeOut(250, function() {
			// 		$(this).remove();
			// 	});
			// 	event.preventDefault();
			// });

			


			// Panning zoomed image (non-touch)

			// $('.sp-large').mousemove(function(e) {
			// 	var viewWidth = $(this).width(),
			// 		viewHeight = $(this).height(),
			// 		largeWidth = $(this).find('.sp-zoom').width(),
			// 		largeHeight = $(this).find('.sp-zoom').height(),
			// 		parentOffset = $(this).parent().offset(),
			// 		relativeXPosition = (e.pageX - parentOffset.left),
			// 		relativeYPosition = (e.pageY - parentOffset.top),
			// 		moveX = Math.floor((relativeXPosition * (viewWidth - largeWidth) / viewWidth)),
			// 		moveY = Math.floor((relativeYPosition * (viewHeight - largeHeight) / viewHeight));

			// 	$(this).find('.sp-zoom').css({
			// 		left: moveX,
			// 		top: moveY
			// 	});

			// });

			function get_url_from_background(bg){
				return bg.match(/url\([\"\']{0,1}(.+)[\"\']{0,1}\)+/i)[1];
			}
		}
	});
})(jQuery);
