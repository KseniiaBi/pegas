// silenko 2016-05-10 / associate buy button with buy action
$(document).ready(function(){
	//cart-info
	$('#cart-count').load('index.php?route=common/cart/info');

	// protect from copy
	 //document.ondragstart = noselect;     // запрет на перетаскивание
	 //document.onselectstart = noselect;     // запрет на выделение элементов страницы
	 //document.oncontextmenu = noselect;     // запрет на выведение контекстного меню
	 //function noselect() {return false;}


	//remove product-modal for mobile
	$('.pic a').each(function() {
	if (window.matchMedia("(max-width: 992px)").matches) {
		var link_product = $(this).parent().parent().find('#link-product').attr('href');
			$(this).attr('href', link_product);
			$(this).removeAttr('data-target');
		// console.log(link_product);
	}
	});
});



function bindBuyActionToButton(buttonIdentifier, productOptionsBlock, successCallback) {
	// $(buttonIdentifier).on('click', function() {
	$('body').delegate(buttonIdentifier, 'click', function() {


		$.ajax({
			url: 'index.php?route=checkout/cart/add',
			type: 'post',
			data: $(productOptionsBlock + ' input[type=\'text\'], ' + productOptionsBlock + ' input[type=\'hidden\'], ' + productOptionsBlock + ' input[type=\'radio\']:checked, ' + productOptionsBlock + ' input[type=\'checkbox\']:checked, ' + productOptionsBlock + ' select, ' + productOptionsBlock + ' textarea'),
			dataType: 'json',
			beforeSend: function() {
				$('#button-cart, .btn-buy').button('loading');
			},
			complete: function() {
				$('#button-cart, .btn-buy').button('reset');
			},
			success: function(json) {
				console.log(json);
				$('.alert, .text-danger').remove();
				$('.form-group').removeClass('has-error');

				if (json['error']) {
					var errorsString = '';
					if (json['error']['option']) {
						for (i in json['error']['option']) {
							errorsString += json['error']['option'][i] + '\n';
							var element = $('#input-option' + i.replace('_', '-'));

							if (element.parent().hasClass('input-group')) {
								element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
							} else {
								element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
							}
						}
					}

					if (json['error']['recurring']) {
						$('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
					}

					// Highlight any found errors
					$('.text-danger').parent().addClass('has-error');
					alert(errorsString);
				}

				if (json['success']) {
					if (typeof successCallback === 'function') {
						successCallback.call(this);
					}

					$('.breadcrumb').after('<div class="alert alert-success">' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
					// $('<div class="alert alert-success">' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>').insertBefore('.book-info');
					// $('<div class="alert alert-success">' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>').insertBefore('.popular-books');

					// $('#cart > button').html('<i class="fa fa-shopping-cart"></i> ' + json['total']);
					// $('html, body').animate({ scrollTop: 0 }, 'slow');
					

					$('#cart-count').load('index.php?route=common/cart/info');

					// var count = json.total.split('-')[0],
					// 	cart_count = parseInt(count.split(' ')[1]);
					// console.log(load('index.php?route=common/cart/info ul li'));
					// 	$('#cart-count').html(cart_count);

				}
			},
					error: function(xhr, ajaxOptions, thrownError) {
							alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					}
		});

	});
}
function mapInputs(jquerySelector) {
	if (typeof jquerySelector === 'string') {
		jquerySelector = $(jquerySelector);
	}

	var resultObject = {};
	jquerySelector.map(function(index, value) {
	    resultObject[value.name] = value.value;
	});

	return resultObject;
}

function findParentElement(element, name, maxNesting) {
	if (typeof maxNesting === 'undefined') {maxNesting = 10;}
	name = name.toUpperCase();
	for (var i = 0; i < maxNesting; i++) {
		if (element.prop("tagName") == name) {return element;}
		element = $(element).parent();
	}
	return null;
}

function getElementProperties(element) {
	var elementData = {};
	if (element.length) {
		$.each(element[0], function(index, value) {
			if (typeof value === 'string' || typeof value === 'number') {
				elementData[index] = value;
			}
		});

		if (!elementData.length) {
			for (attr in element[0]) {
				if (typeof element[0][attr] === 'string' || typeof element[0][attr] === 'number') {
					elementData[attr] = element[0][attr];
				}
			}
		}
	}
	return elementData;
}

function getURLVar(key) {
	var value = [];

	var query = String(document.location).split('?');

	if (query[1]) {
		var part = query[1].split('&');

		for (i = 0; i < part.length; i++) {
			var data = part[i].split('=');

			if (data[0] && data[1]) {
				value[data[0]] = data[1];
			}
		}

		if (value[key]) {
			return value[key];
		} else {
			return '';
		}
	}
}


$(document).ready(function() {

	// $('.undone').attr('data-toggle', 'tooltip').attr('data-original-title', 'Функционал в разработке');

	// $('body').delegate('.btn-ajax-submit', "click", function(evt) {
		// var form = findParentElement($(this), 'form');
		// var form_value = form.val();
		// if (form_value !== '') {
		// 	var mainData = mapInputs($('input,textarea', form));
		// 	var elementData = getElementProperties(form);
	$('#phone_fast_order').focus(function() {
          $(this).removeAttr('style');
          $(this).parent().find('.inp_error_tel').hide();
          // console.log('OK');

	});

	$('.btn-ajax-submit').click (function(e) {
		e.preventDefault();
		var
		form = $('#form_order').val();
		form2 = $('#form_fast_order');
		phone = $('#phone_fast_order').val();
		url = window.location.href;
		// console.log(url);
		// var lang = localStorage.getItem('language');
		if(phone !=='') {
			$.ajax({
				url: 'index.php?route=common/ajax_handler/index',
				type: 'post',
				data: {form: form, phone: phone, url: url},
				success: function() {
					$(form2).hide();
					$('#mess_success').show();
					// $.each($('[data-success]', form2), function(index, value) {
						// console.log(value);
						// value = $(value);
						// value.text(value.attr('data-success')).show();

					// });

				}
				// error: function(response) {
				// 	console.log('err');
				// },
				// complete: function(response) {
				// 	console.log(response);
				// },
			});
		}else {
			if (phone == '') {

		            $('#phone_fast_order').css({'border-color':'red'});
		            $('.inp_error_tel').show();
			}
		}
	});

	$('#subscribe_email').focus(function() {
          $(this).removeAttr('style');
          $(this).parent().find('.inp_error_email, .inp_error_email_valid').hide();
          // console.log('OK');

	});

	$('#form_subscribe_sub').click (function(e) {
		e.preventDefault();
		var form = $('#form_val').val();
		var form2 = $('#form_subscribe');
		var mail = $('#subscribe_email').val();
		// var lang = localStorage.getItem('language');
		if(mail !=='' && mail.match(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,6})+$/i)) {
			$.ajax({
				url: 'index.php?route=common/ajax_handler/index',
				type: 'post',
				data: {form: form, mail: mail},
				success: function() {
					$(form2).hide();
					$('#subscribe p').show();
					// $.each($('[data-success]', form2), function(index, value) {
						// console.log(value);
						// value = $(value);
						// value.text(value.attr('data-success')).show();

					// });

				}
				// error: function(response) {
				// 	console.log('err');
				// },
				// complete: function(response) {
				// 	console.log(response);
				// },
			});
		}else {
			if (mail == '') {
		            $('#subscribe_email').css({'border-color':'red'});
		            $('.inp_error_email').show();

			}
			if (!mail.match(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,6})+$/i)) {

		            $('#subscribe_email').css({'border-color':'red'});
		            $('.inp_error_email_valid').show();

			}
		}
	});

	$('#form_header_phone').focus(function() {
          $(this).removeAttr('style');
          $(this).parent().find('.inp_error_tel').hide();
          // console.log('OK');

	});

	$('#form_header_phone, #phone_fast_order, #input-telephone').mask("+38(999)999-99-99");

	$('#callback_in_header').submit (function(e) {
		e.preventDefault();
		var form = $('#form_header').val();
		var phone = $('#form_header_phone').val();
		// var lang = localStorage.getItem('language');
		// var elementData = getElementProperties($('.modal.fade.in'));
		if(phone !=='') {
		$.ajax({
			url: 'index.php?route=common/ajax_handler/index',
			type: 'post',
			// dataType: 'json',
			data: {form: form, phone: phone},
			success: function() {
				$('#callback_in_header').hide();
				$('#callback_in_header').parent().parent().hide();

				$('.modal-content p').show();

				// console.log(mainData);
			}
			// error: function(response) {
			// 	console.log('err');
			// },
			// complete: function(response) {
			// 	console.log(response);
			// },
		});

		}else {
			if (phone == '') {
		            $('#form_header_phone').css({'border-color':'red'});
		            $('.inp_error_tel').show();

			}

		}
	});

	$('#form_footer_email').focus(function() {
          $(this).removeAttr('style');
          $(this).parent().find('.inp_error_email, .inp_error_email_valid').hide();
          // console.log('OK');

	});
	$('#form_footer_text').focus(function() {
          $(this).removeAttr('style');
          $(this).parent().find('.inp_error').hide();
          // console.log('OK');

	});

	$('#write_in_footer').submit (function(e) {
		e.preventDefault();
		var email = $('#form_footer_email').val();
		var text = $('#form_footer_text').val();
		var form = $('#form_footer').val();
		// var lang = localStorage.getItem('language');
		// var elementData = getElementProperties($('.modal.fade.in'));
		if(email !=='' && text !=='' && email.match(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,6})+$/i)) {
		$.ajax({
			url: 'index.php?route=common/ajax_handler/index',
			type: 'post',
			// dataType: 'json',
			data: {form: form, text: text, email: email},
			success: function() {
				$('input,textarea,button', '.modal.fade.in').hide();
				$.each($('[data-success]', '.modal.fade.in'), function(index, value) {
					value = $(value);
					value.text(value.attr('data-success')).show();
				});
				console.log(mainData);
			}
			// error: function(response) {
			// 	console.log('err');
			// },
			// complete: function(response) {
			// 	console.log(response);
			// },
		});

		}else {
			if (email == '') {
		            $('#form_footer_email').css({'border-color':'red'});
		            $('.inp_error_email').show();

			}
			if (!email.match(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,6})+$/i)) {

		            $('#form_footer_email').css({'border-color':'red'});
		            $('.inp_error_email_valid').show();

			}
			if (text =='') {

		            $('#form_footer_text').css({'border-color':'red'});
		            $('.inp_error').show();

			}
		}
	});

	// Highlight any found errors
	$('.text-danger').each(function() {
		var element = $(this).parent().parent();

		if (element.hasClass('form-group')) {
			element.addClass('has-error');
		}
	});

	// Currency
	$('#form-currency .currency-select').on('click', function(e) {
		e.preventDefault();

		$('#form-currency input[name=\'code\']').attr('value', $(this).attr('name'));

		$('#form-currency').submit();
	});


	// Language


	$('#form-language .language-select').on('click', function(e) {
		e.preventDefault();

		if($(this).hasClass('active')){
			return false; 
		}

		$('#form-language input[name=\'code\']').attr('value', $(this).attr('name'));
		// var language = $('#form-language input[name=\'code\']').attr('value');
		// if(language == 'ru') {
		// 	localStorage.setItem('language', 'ru');
		// }else {
		// 	localStorage.setItem('language', 'ua');
		// }

		// console.log(localStorage.getItem('language'));
		$('#form-language').submit();
	});

	/* Search */
	$('#search input[name=\'search\']').parent().find('button').on('click', function() {
	  var url = $('base').attr('href') + 'index.php?route=product/search';

	  var value = $('#search input[name=\'search\']').val();

	  if (value) {
	    url += '&search=' + encodeURIComponent(value);
	  }

	  location = url;
	});

	$('#search input[name=\'search\']').on('keydown', function(e) {
	  if (e.keyCode == 13) {
	    $('#search input[name=\'search\']').parent().find('button').trigger('click');
	  }
	});

	/* Search */
	$('#search_mobile input[name=\'search\']').parent().find('button').on('click', function() {
	  var url = $('base').attr('href') + 'index.php?route=product/search';

	  var value = $('#search_mobile input[name=\'search\']').val();

	  if (value) {
	    url += '&search=' + encodeURIComponent(value);
	  }

	  location = url;
	});

	$('#search_mobile input[name=\'search\']').on('keydown', function(e) {
	  if (e.keyCode == 13) {
	    $('#search_mobile input[name=\'search\']').parent().find('button').trigger('click');
	  }
	});

	// Menu
	$('#menu .dropdown-menu').each(function() {
		var menu = $('#menu').offset();
		var dropdown = $(this).parent().offset();

		var i = (dropdown.left + $(this).outerWidth()) - (menu.left + $('#menu').outerWidth());

		if (i > 0) {
			$(this).css('margin-left', '-' + (i + 5) + 'px');
		}
	});

	// Product List
	$('#list-view').click(function() {
		$('#content .product-grid > .clearfix').remove();

		$('#content .row > .product-grid').attr('class', 'product-layout product-list col-xs-12');

		localStorage.setItem('display', 'list');
	});

	// Product Grid
	$('#grid-view').click(function() {
		// What a shame bootstrap does not take into account dynamically loaded columns
		var cols = $('#column-right, #column-left').length;

		if (cols == 2) {
			$('#content .product-list').attr('class', 'product-layout product-grid col-lg-6 col-md-6 col-sm-12 col-xs-12');
		} else if (cols == 1) {
			$('#content .product-list').attr('class', 'product-layout product-grid col-lg-4 col-md-4 col-sm-6 col-xs-12');
		} else {
			$('#content .product-list').attr('class', 'product-layout product-grid col-lg-3 col-md-3 col-sm-6 col-xs-12');
		}

		localStorage.setItem('display', 'grid');
	});

	if (localStorage.getItem('display') == 'list') {
		$('#list-view').trigger('click');
	} else {
		$('#grid-view').trigger('click');
	}

	// Checkout
	$(document).on('keydown', '#collapse-checkout-option input[name=\'email\'], #collapse-checkout-option input[name=\'password\']', function(e) {
		if (e.keyCode == 13) {
			$('#collapse-checkout-option #button-login').trigger('click');
		}
	});

	// tooltips on hover
	// $('[data-toggle=\'tooltip\']').tooltip({container: 'body'});

	// Makes tooltips work on ajax generated content
	$(document).ajaxStop(function() {
		// $('[data-toggle=\'tooltip\']').tooltip({container: 'body'});
	});
});

// Cart add remove functions
var cart = {
	'add': function(product_id, quantity) {
		$.ajax({
			url: 'index.php?route=checkout/cart/add',
			type: 'post',
			data: 'product_id=' + product_id + '&quantity=' + (typeof(quantity) != 'undefined' ? quantity : 1),
			dataType: 'json',
			beforeSend: function() {
				// $('#cart > button').button('loading');
			},
			complete: function() {
				// $('#cart > button').button('reset');
			},
			success: function(json) {
				// $('.alert, .text-danger').remove();

				// if (json['redirect']) {
				// 	location = json['redirect'];
				// }

				if (json['success']) {
						$('footer').before('<div class="alert alert-success">' + json['success'].substr(0,json['success'].length -2) + '</div>');
					setTimeout(function() {
						$('.alert-success').fadeOut(1500)
						}, 4000);
					// Need to set timeout otherwise it wont update the total
					setTimeout(function () {
						$('.cart_info').html( json['total'] );
						$('.cart_btn').addClass('active');
					}, 100);

					//$('html, body').animate({ scrollTop: 0 }, 'slow');


					$('#cart > ul').load('index.php?route=common/cart/info ul li');
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	},
	'update': function(key, quantity) {
		$.ajax({
			url: 'index.php?route=checkout/cart/edit',
			type: 'post',
			data: 'key=' + key + '&quantity=' + (typeof(quantity) != 'undefined' ? quantity : 1),
			dataType: 'json',
			beforeSend: function() {
				$('#cart > button').button('loading');
			},
			complete: function() {
				$('#cart > button').button('reset');
			},
			success: function(json) {
				// Need to set timeout otherwise it wont update the total
				setTimeout(function () {
					$('#cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');
				}, 100);

				if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
					location = 'index.php?route=checkout/cart';
				} else {
					$('#cart > ul').load('index.php?route=common/cart/info ul li');
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	},
	'updateOption': function(element) {
		var cartID = $(element).attr('data-cart-id');
		var optionID = $(element).attr('data-option-id');
		var selectedOptionID = $('option:selected', element).val();

		// console.log(cartID, optionID, selectedOptionID);

		var selectBoxUI = $(element);
		if (selectBoxUI.next().hasClass('select2')) {
			selectBoxUI = selectBoxUI.next().find('.select2-selection');
		}

		$.ajax({
			url: 'index.php?route=checkout/cart/editOption',
			type: 'post',
			data: 'cart_id=' + cartID + '&option_id=' + optionID + '&value_id=' + selectedOptionID,
			dataType: 'json',
			beforeSend: function() {
				// selectBoxUI.css('background-color', '#D0D0D0');
			},
			complete: function() {
				// selectBoxUI.css('background-color', '');
			},
		// 	success: function(json) {
		// 	},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	},
	'remove': function(key) {
		$.ajax({
			url: 'index.php?route=checkout/cart/remove',
			type: 'post',
			data: 'key=' + key,
			dataType: 'json',
			success: function(json) {
				// Need to set timeout otherwise it wont update the total
				setTimeout(function () {
					$('#cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');
				}, 100);

				if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
					location = 'index.php?route=checkout/cart';
				} else {
					$('#cart > ul').load('index.php?route=common/cart/info ul li');
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	}
}

var voucher = {
	'add': function() {

	},
	'remove': function(key) {
		$.ajax({
			url: 'index.php?route=checkout/cart/remove',
			type: 'post',
			data: 'key=' + key,
			dataType: 'json',
			beforeSend: function() {
				$('#cart > button').button('loading');
			},
			complete: function() {
				$('#cart > button').button('reset');
			},
			success: function(json) {
				// Need to set timeout otherwise it wont update the total
				setTimeout(function () {
					$('#cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');
				}, 100);

				$('.cart_inner form').load('index.php?route=checkout/cart .cart_inner form > *');
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	}
}

var wishlist = {
	'add': function(product_id) {
		$.ajax({
			url: 'index.php?route=account/wishlist/add',
			type: 'post',
			data: 'product_id=' + product_id,
			dataType: 'json',
			success: function(json) {
				$('.alert').remove();

				if (json['redirect']) {
					location = json['redirect'];
				}

				if (json['success']) {
					$('footer').before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');
					setTimeout(function() {
						$('.alert-success').fadeOut(1000)
					}, 4000);
				}

				$('#wishlist-total span').html(json['total']);
				$('#wishlist-total').attr('title', json['total']);

				//$('html, body').animate({ scrollTop: 0 }, 'slow');
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	},
	'remove': function() {

	}
}

var compare = {
	'add': function(product_id) {
		$.ajax({
			url: 'index.php?route=product/compare/add',
			type: 'post',
			data: 'product_id=' + product_id,
			dataType: 'json',
			success: function(json) {
				$('.alert').remove();

				if (json['success']) {
					$('footer').before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');
					setTimeout(function() {
						$('.alert-success').fadeOut(1000)
					}, 4000);
					$('#compare-total').html(json['total']);

					//$('html, body').animate({ scrollTop: 0 }, 'slow');
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	},
	'remove': function() {

	}
}

/* Agree to Terms */
$(document).delegate('.agree', 'click', function(e) {
	e.preventDefault();

	$('#modal-agree').remove();

	var element = this;

	$.ajax({
		url: $(element).attr('href'),
		type: 'get',
		dataType: 'html',
		success: function(data) {
			html  = '<div id="modal-agree" class="modal">';
			html += '  <div class="modal-dialog">';
			html += '    <div class="modal-content">';
			html += '      <div class="modal-header">';
			html += '        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>';
			html += '        <h4 class="modal-title">' + $(element).text() + '</h4>';
			html += '      </div>';
			html += '      <div class="modal-body">' + data + '</div>';
			html += '    </div';
			html += '  </div>';
			html += '</div>';

			$('body').append(html);

			$('#modal-agree').modal('show');
		}
	});
});

// Autocomplete */
(function($) {
	$.fn.autocomplete = function(option) {
		return this.each(function() {
			this.timer = null;
			this.items = new Array();

			$.extend(this, option);

			$(this).attr('autocomplete', 'off');

			// Focus
			$(this).on('focus', function() {
				this.request();
			});

			// Blur
			$(this).on('blur', function() {
				setTimeout(function(object) {
					object.hide();
				}, 200, this);
			});

			// Keydown
			$(this).on('keydown', function(event) {
				switch(event.keyCode) {
					case 27: // escape
						this.hide();
						break;
					default:
						this.request();
						break;
				}
			});

			// Click
			this.click = function(event) {
				event.preventDefault();

				value = $(event.target).parent().attr('data-value');

				if (value && this.items[value]) {
					this.select(this.items[value]);
				}
			}

			// Show
			this.show = function() {
				var pos = $(this).position();

				$(this).siblings('ul.dropdown-menu').css({
					top: pos.top + $(this).outerHeight(),
					left: pos.left
				});

				$(this).siblings('ul.dropdown-menu').show();
			}

			// Hide
			this.hide = function() {
				$(this).siblings('ul.dropdown-menu').hide();
			}

			// Request
			this.request = function() {
				clearTimeout(this.timer);

				this.timer = setTimeout(function(object) {
					object.source($(object).val(), $.proxy(object.response, object));
				}, 200, this);
			}

			// Response
			this.response = function(json) {
				html = '';

				if (json.length) {
					for (i = 0; i < json.length; i++) {
						this.items[json[i]['value']] = json[i];
					}

					for (i = 0; i < json.length; i++) {
						if (!json[i]['category']) {
							html += '<li data-value="' + json[i]['value'] + '"><a href="#">' + json[i]['label'] + '</a></li>';
						}
					}

					// Get all the ones with a categories
					var category = new Array();

					for (i = 0; i < json.length; i++) {
						if (json[i]['category']) {
							if (!category[json[i]['category']]) {
								category[json[i]['category']] = new Array();
								category[json[i]['category']]['name'] = json[i]['category'];
								category[json[i]['category']]['item'] = new Array();
							}

							category[json[i]['category']]['item'].push(json[i]);
						}
					}

					for (i in category) {
						html += '<li class="dropdown-header">' + category[i]['name'] + '</li>';

						for (j = 0; j < category[i]['item'].length; j++) {
							html += '<li data-value="' + category[i]['item'][j]['value'] + '"><a href="#">&nbsp;&nbsp;&nbsp;' + category[i]['item'][j]['label'] + '</a></li>';
						}
					}
				}

				if (html) {
					this.show();
				} else {
					this.hide();
				}

				$(this).siblings('ul.dropdown-menu').html(html);
			}

			$(this).after('<ul class="dropdown-menu"></ul>');
			$(this).siblings('ul.dropdown-menu').delegate('a', 'click', $.proxy(this.click, this));

		});
	}
})(window.jQuery);




// $(document).ready( function () {

// // удаляем модальное окно на маленьких экранах
// function windowSize(){
//     if ($(window).width() <= '992'){
//         $('.product .link-modal').removeAttr('data-toggle');

//     }

// }

// $(window).load(windowSize); // при загрузке
// $(window).resize(windowSize); // при изменении размеров
// // или "два-в-одном", вместо двух последних строк:
// $(window).on('ready load resize',windowSize);

// });

// События на клик

// $('#drop-mob').on('tap', function () {

//      //your awesome code here


// console.log('happy')
// })







// $(document).ready( function () {
//    var join = $('.drop-menu-mob'),
//         joinLink = $('#drop-mob'),
//         indexClick = 0;
// $ ( function() {
//     joinLink.click( function(event) {

//         if (indexClick === 0) {
//             join.fadeIn(1);
//             // join.addClass('active')
//             indexClick = 1;
//            join.css('display', 'flex');
//         }
//         else {
//             join.fadeOut(1);
//             indexClick = 0;
//             // joinLink.css('background', '#1abc9c');

//         }
//         event.stopPropagation();
//         console.log('fuck')
//     });
// });


// $(document).click(function(event) {
//     if ($(event.target).closest(" .tablet-top .drop-menu-mob").length)
//     	    return;
//             join.fadeOut(1);
//             indexClick = 0;

//     event.stopPropagation();
// });



//     });


$(document).ready( function () {

// перестановка блоков
function windowSize(){
    if ($(window).width() <= '480'){
        $('.subscribe').after($(".child-expert"));
    } else {
        $('.category-books').after($(".child-expert"));
    }
}

$(window).load(windowSize); // при загрузке
$(window).resize(windowSize); // при изменении размеров
// или "два-в-одном", вместо двух последних строк:
$(window).on('ready load resize',windowSize);

});


$(document).ready( function () {

// перестановка блоков
function windowSize(){
    if ($(window).width() >= '1368'){
        $('.product-cart').after($(".discount"));
    } else {
        $('#discount-wrap').append($(".discount"));
    }
}

$(window).load(windowSize); // при загрузке
$(window).resize(windowSize); // при изменении размеров
// или "два-в-одном", вместо двух последних строк:
$(window).on('ready load resize',windowSize);

});




$(document).ready( function () {






$(".top_nav_btn").click(function(){
	$(this).next().slideToggle();
});


$(".btn_open_search ").click(function(){
	$(".top_search").slideToggle();
	return false;
});

jQuery(document).click( function(event){
	if( $(event.target).closest(".top_search").length )
	return;
	jQuery(".top_search").fadeOut("fast");
	event.stopPropagation();
});




$(".contact-more ").click(function(){
	$(".list-more").slideToggle();
});

$(".btn-category ").click(function(){
	$(".category-list").slideToggle();
	$(".btn-category span").toggle();
});


$(".present-btn").click(function(){
	$(".present").slideToggle();
});
$(".by-age-btn").click(function(){
	$(".by-age").slideToggle();
});

$(".filtr-drop").click(function(){
	$(this).next().slideToggle();
	$(this).children('b').toggleClass("hide-triangle");
});

$(".filter-btn").click(function(){
	$(".filters").slideToggle();
	return false;
});

$(".open-shipinfo").click(function(){
	$(this).next('.ship-drop').slideToggle();
	// $(".ship-drop").slideToggle();
});


$(".btn-show-opisanie").click(function(){
	$('.text').slideToggle();
});
// фильтры на планшете


// jQuery('.open-filters-btn').click(
// 	function() {
// 		jQuery('.filters').show("slide", { direction: "left" }, 500);
// 		return false;
// 	});

// jQuery(document).click( function(event){
// 	if( $(event.target).closest(".filters").length )
// 	return;
// 	jQuery(".filters").fadeOut("slow");
// 	event.stopPropagation();
// });


//carousel



// select
// try {
// 	$(".m-select").select2({
// 		minimumResultsForSearch: Infinity
// 	});

// 	$(".sort-select").select2({
// 		minimumResultsForSearch: Infinity
// 	});

// 	$(".order-select").select2({
// 		minimumResultsForSearch: Infinity
// 	});
// } catch (e) {
// 	console.warn('ВНИМАНИЕ, ПРОИЗОШЛА ОШИБКА!', e);
// }



 // Табы регистрации
//  $('#log-tabs a').click(function (e) {
//   e.preventDefault()
//   $(this).tab('show')
// })

// ГАЛЕРЕЯ ДЛЯ ПРОДУКТОВ
// $(document).ready(function() {
// $('.sp-wrap').click(function(event) {
//     event = event || window.event;
//     var target = event.target || event.srcElement,
//         link = target.src ? target.parentNode : target,
//         options = {index: link, event: event},
//         links = $(this).find('.sp-thumbs a');
//     blueimp.Gallery(links, options);
// });
// });

// ГАЛЕРЕЯ ДЛЯ РИСУНКОВ
// $(document).ready(function() {
// $('.gallery-wrap').click(function(event) {
//     event = event || window.event;
//     var target = event.target || event.srcElement,
//         link = target.src ? target.parentNode : target,
//         options = {index: link, event: event},
//         links = $(this).find('a');
//     blueimp.Gallery(links, options);
// });
// });

// $(window).load(function() {
// 	try {
// 		$('.sp-wrap').smoothproducts();

// 		// $('.sp-wrap').magnificPopup({
// 		// 		type:'image',
// 		// 		delegate: 'a',
// 		// 		gallery: {
// 		// 			enabled:true
// 		// 		}
// 		// 	});
// 	} catch (e) {
// 		console.warn('ВНИМАНИЕ, ПРОИЗОШЛА ОШИБКА!', e);
// 	}
// });


// try {
// 	$( "#format" ).buttonset();
// } catch (e) {
// 	console.warn('ВНИМАНИЕ, ПРОИЗОШЛА ОШИБКА!', e);
// }

//убираем модальное на планшете

// checkbox

});

//slider amount
// $(document).ready( function () {
// var price_start = parseInt($('#price-start').val()),
// price_finish = parseInt($('#price-finish').val());
// $(function() {
// 	try {
// 	    $( "#slider-range" ).slider({
// 	      range: true,
// 	      min: price_start,
// 	      max: price_finish,
// 	      values: [ price_start, price_finish ],
// 	      slide: function( event, ui ) {
// 	        $( "#amount-start" ).val( ui.values[ 0 ] );
// 	        $( "#amount-finish" ).val(ui.values[ 1 ] );
// 	      },

// 	      change: function(event, ui) {
// 	      // $( "#amount-start" ).attr( ui.values[ 0 ] );
// 	        // $( "#amount-finish" ).attr(ui.values[ 1 ] );
// 	    	}
// 	    });

// 	    $('input.input-amount[type=text]').keyup(function() {
// 	    	$('#slider-range').slider('values', [$('#amount-start').val(), $('#amount-finish').val()])
// 	    });




// 	    $( "#amount-start" ).val( $( "#slider-range" ).slider( "values", 0 ) );

// 	    $( "#amount-finish" ).val($( "#slider-range" ).slider( "values", 1 ) );
// 	} catch (e) {
// 		console.warn('ВНИМАНИЕ, ПРОИЗОШЛА ОШИБКА!', e);
// 	}




//   });

// });



// news
// добавление класса при определённом разрешении



// $(document).ready( function () {
// 	try {
// 		$('#main-carousel').owlCarousel({
// 			items:1,
// 			loop:true,
// 			autoplay: true,
// 		autoplayTimeout:5000,
// 		smartSpeed:1000,
// 		});

// 		//popular books carousel
// 		$('#books-carousel').owlCarousel({
// 		    loop:true,
// 		    margin:40,
// 		    nav:true,
// 		    autoplay: true,
// 		    autoplayHoverPause:true,
// 			autoplayTimeout:2000,
// 			smartSpeed:1000,
// 			navText: [
// 		      "<i class='fa fa-angle-left'></i>",
// 		      "<i class='fa fa-angle-right'></i>"
// 		      ],
// 		    responsive:{
// 		        0:{
// 		            items:1
// 		        },
// 		        768:{
// 		            items:2
// 		        },
// 		        1000:{
// 		            items:4
// 		        }
// 		    }
// 		});

// 		$('#gallery-carousel').owlCarousel({
// 		    loop:true,
// 		    margin:40,
// 		    nav:true,
// 		    autoplay: true,
// 		    autoplayHoverPause:true,
// 			autoplayTimeout:1000,
// 			smartSpeed:1000,
// 		    navText: [
// 		      "<i class='fa fa-angle-left'></i>",
// 		      "<i class='fa fa-angle-right'></i>"
// 		      ],
// 		    responsive:{
// 		        0:{
// 		            items:1
// 		        },
// 		        768:{
// 		            items:2
// 		        },
// 		        1000:{
// 		            items:4
// 		        }
// 		    }
// 		});
// 	} catch (e) {
// 		console.warn('ВНИМАНИЕ, ПРОИЗОШЛА ОШИБКА!', e);
// 	}

// 	$('#main-carousel .item').click(function(){
// 		var link = $(this).find('a').attr('href');
// 		$(location).attr("href", link);
// 	});
// });

// $(document).ready( function () {
// 	try {
// 		$('#news-carousel').owlCarousel({
// 		    loop:true,
// 		    margin:100,
// 		    nav:true,
// 		    mouseDrag:false,
// 		     navText: [
// 		      "<i class='fa fa-angle-left'></i>",
// 		      "<i class='fa fa-angle-right'></i>"
// 		      ],
// 		    responsive:{
// 		        0:{
// 		            items:1,
// 		            touchDrag:true
// 		        },
// 		        600:{
// 		            items:1,
// 		            margin:0
// 		        },
// 		        1000:{
// 		            items:3,
// 		            touchDrag:false
// 		        }
// 		    }
// 		})
// 	} catch (e) {
// 		console.warn('ВНИМАНИЕ, ПРОИЗОШЛА ОШИБКА!', e);
// 	}

// });


// qty-box
jQuery(document).ready(function(){

// This button will increment the value
$(".plus").click( function(e) {

    e.preventDefault();

    // Define field variable
    field = "input[name=" + $(this).attr("field") + "]";

    // Get its current value
    var currentVal = parseInt($(field).val());

    // If is not undefined
    if ( !isNaN(currentVal) && currentVal < 20 ) {

        // Increment
        $(field).val(currentVal + 1);

    }

});

// This button will decrement the value till 0
$(".minus").click( function(e) {

    e.preventDefault();

    // Define field variable
    field = "input[name=" + $(this).attr("field") + "]";

    // Get its current value
    var currentVal = parseInt($(field).val());

    // If it isn't undefined or its greater than 0
    if ( !isNaN(currentVal) && currentVal > 1 ) {
        // Decrement one
        $(field).val(currentVal - 1);
    }

});
});
/* отключение правой кнопки мыши*/
// var message="Правый клик запрещен!";
// ///////////////////////////////////
//       function clickIE4(){
//       if (event.button==2){
//       alert(message);
//       return false;
//       }
//       }
// function clickNS4(e){
//       if (document.layers||document.getElementById&&!document.all){
//       if (e.which==2||e.which==3){
//       alert(message);
//       return false;
//       }
//       }
//       }
// if (document.layers){
//       document.captureEvents(Event.MOUSEDOWN);
//       document.onmousedown=clickNS4;
//       }
//       else if (document.all&&!document.getElementById){
//       document.onmousedown=clickIE4;
//       }
// document.oncontextmenu=new Function("alert(message);return false")
// /* отключение правой кнопки мыши*/

//  document.ondragstart = noselect;
// // запрет на перетаскивание
// document.onselectstart = noselect;
// // запрет на выделение элементов страницы
// document.oncontextmenu = noselect;
// // запрет на выведение контекстного меню
// function noselect() {return false;}
