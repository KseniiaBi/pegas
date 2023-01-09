/******************************************************
 * @package Showmore product Module Opencart Theme Framework for Opencart 2.x
 * @version 1.0.1
 * @author http://dev-trust.com
 * @copyright Copyright (C) 2015 dev-trust.com <@emai:developer.trust@gmail.com.>.All rights reserved.
 * @license   GNU General Public License version 3
*******************************************************/
function declension(a){switch(a){case 1:return text_d1_items;break;case 2:case 3:case 4:return text_d2_items;break;default:return text_d3_items;}}
function button_autopager(callback) {
	var e_length,e_length_s,appendTodiv,e_total,e_total_p;
	var pagenum = 1;

        var pagelink = window.location.href;
        var page = pagelink.match(/page=(\d+)/);
	if(page) pagenum = page[1];

	appendTodiv = '.book_grid';

	var e_length = $(appendTodiv + '> div.book_item').length;
	if ($('a').is('.btn_next')){
		e_total = $(".pagination div:last").text().replace(/[^\d]/gi, '.').split('.').filter(function(number) {return number > 0;});
		e_length_s = e_total[1] - e_total[0]+1;
		e_total_p = e_total[2] - (pagenum-1)*e_length_s;
		if ((e_total_p - e_length) < e_length_s) e_length_s = e_total_p - e_length;
		var next_url = $("a.btn_next").attr('href');
		$(".pagination").before('<a href="'+next_url+'" class="btn btn_grad show-btn" rel="next">' + window.showmoreProductsButtonLabel + '</a>');
	} else {
		$(".pagination").show();
	}
	$.autopager({
		autoLoad	: false,
		link 		: 'a[rel=next]',
		content 	: 'div.book_item',
		pagination	: '.pagination',
		appendTo	: appendTodiv,
		start		: function(current, next) {
				$('div.book_item').removeClass("new-element");
				$(".pagination").before('<div class="col-sm-12 text-center" id="block_autopager_loading"><img alt="Loading" src="catalog/view/javascript/dt_showmore/loading.gif" /></div>');
				$('.show-btn').hide();
		},
		load		: function(current, next) {
				$('.show-btn').show();
				if (next.url == undefined) {
					$('.show-btn').html();
					$('.show-btn').fadeOut(2000, function () {
						$(this).remove();
					})
				} else {
					$('a[rel=next]').attr('href', next.url)
				}

				if (next.pagination !== undefined) {
					$('.pagination').remove();
					$('.catalog_actions').html(next.pagination);
				}

				$('#block_autopager_loading').remove();
				$('.show-btn').remove();

				if (callback && typeof (callback) === "function") {
					callback();
				}

				button_autopager();
		}
	});

	$('.show-btn').click(function() {
		window.autopagerLoadCallback = function() {
			// select
			try {
				$('span.select2').remove();

				$(".m-select").select2({
					minimumResultsForSearch: Infinity
				});

				$(".sort-select").select2({
					minimumResultsForSearch: Infinity
				});

				$(".order-select").select2({
					minimumResultsForSearch: Infinity
				});
			} catch (e) {
				console.warn('ВНИМАНИЕ, ПРОИЗОШЛА ОШИБКА!', e);
			}
		};

		$.autopager('load');

		return false;
	});
	e_length = $(appendTodiv + '> div.book_item').length;
}

$(document).ready(function(){
	button_autopager();
	var hash = window.location.href;
	function hashchange(){ 
		var hash = location.hash;
		button_autopager();
	}
	window.addEventListener('hashchange', hashchange);
});