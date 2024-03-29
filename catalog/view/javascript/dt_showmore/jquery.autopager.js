/*
 * jQuery.autopager v1.0.0
 *
 * Copyright (c) lagos
 * Dual licensed under the MIT and GPL licenses.
 */
(function($) {
	var window = this, options = {},
		content, currentUrl, nextUrl, nextPagination,
		active = false,
		defaults = {
			autoLoad: true,
			page: 1,
			content: '.catalog_inner',
			pagination: '.pagination',
			link: 'a[rel=next]',
			insertBefore: null, 
			appendTo: null, 
			start: function() {},
			load: function() {},
			disabled: false
		};

	$.autopager = function(_options) {
		var autopager = this.autopager;

		if (typeof _options === 'string' && $.isFunction(autopager[_options])) {
			var args = Array.prototype.slice.call(arguments, 1),
				value = autopager[_options].apply(autopager, args);

			return value === autopager || value === undefined ? this : value;
		}

		_options = $.extend({}, defaults, _options);
		autopager.option(_options);

		content = $(_options.content).filter(':last');
		if (content.length) {
			if (!_options.insertBefore && !_options.appendTo) {
				var insertBefore = content.next();
				if (insertBefore.length) {
					set('insertBefore', insertBefore);
				} else {
					set('appendTo', content.parent());
				}
			}
		}

		setUrl();

		return this;
	};

	$.extend($.autopager, {
		option: function(key, value) {
			var _options = key;

			if (typeof key === "string") {
				if (value === undefined) {
					return options[key];
				}
				_options = {};
				_options[key] = value;
			}

			$.each(_options, function(key, value) {
				set(key, value);
			});
			return this;
		},

		enable: function() {
			set('disabled', false);
			return this;
		},

		disable: function() {
			set('disabled', true);
			return this;
		},

		destroy: function() {
			this.autoLoad(false);
			options = {};
			content = currentUrl = nextUrl = nextPagination = undefined;
			return this;
		},

		autoLoad: function(value) {
			return this.option('autoLoad', value);
		},

		load: function() {
			if (active || !nextUrl || options.disabled ) {
				return;
			}

			active = true;
			options.start(currentHash(), nextHash());
//			$.get(nextUrl, insertContent);

			var frame = createIFrame(nextUrl);
			frame.onSendComplete = function() {
				var doc = getIFrameXML(frame);
				insertContent(doc.body.innerHTML);
				$(frame).parent().remove();

				if ($.isFunction(window.autopagerLoadCallback)) {
					window.autopagerLoadCallback.call();
				}
			};
			return this;
		}

	});

	function createIFrame(url) {
		var id = 'f' + Math.floor(Math.random() * 99999);
		var div = document.createElement('div');
		div.innerHTML = "<iframe style=\"display:none;width:100%;\" src=\""+url+"\" id=\""+id+"\" name=\""+id+"\" onload=\"sendComplete('"+id+"')\"></iframe>";
		document.body.appendChild(div);
		return document.getElementById(id);
	}

	function getIFrameXML(iframe) {
		var doc=iframe.contentDocument;
		if (!doc && iframe.contentWindow) doc=iframe.contentWindow.document;
		if (!doc) doc=window.frames[iframe.id].document;
		if (!doc) return null;
		if (doc.location=="about:blank") return null;
		if (doc.XMLDocument) doc=doc.XMLDocument;
		return doc;
	}

	function set(key, value) {
		switch (key) {
			case 'autoLoad':
				if (value && !options.autoLoad) {
					$(window).scroll(loadOnScroll);
				} else if (!value && options.autoLoad) {
					$(window).unbind('scroll', loadOnScroll);
				}
				break;
			case 'insertBefore':
				if (value) {
					options.appendTo = null;
				}
				break
			case 'appendTo':
				if (value) {
					options.insertBefore = null;
				}
				break
		}
		options[key] = value;
	}

	function setUrl(context) {
		currentUrl = nextUrl || window.location.href;
		nextUrl = $(options.link, context).attr('href');
		nextPagination = $(context).find(options.pagination);
	}

	function loadOnScroll() {
		if (content.offset().top + content.height() < $(document).scrollTop() + $(window).height()) {
			$.autopager.load();
		}
	}

	function insertContent(res) {
		var _options = options,
		nextPage = $('<div/>').append(res.replace(/<script(.|\s)*?\/script>/g, "")),
		nextContent = nextPage.find(_options.content);

		set('page', _options.page + 1);
		setUrl(nextPage);
		if (nextContent.length) {
			nextContent.addClass("new-element");
			if (_options.insertBefore) {
				nextContent.insertBefore(_options.insertBefore);
			} else {
				nextContent.appendTo(_options.appendTo);
			}
			_options.load.call(nextContent.get(), currentHash(), nextHash());
			content = nextContent.filter(':last');
		}
		active = false;
	}

	function currentHash() {
		return {
			page: options.page,
			url: currentUrl,
		};
	}

	function nextHash() {
		return {
			page: options.page + 1,
			url: nextUrl,
			pagination: nextPagination
		};
	}
})(jQuery);

	function sendComplete(id) {
		var iframe=document.getElementById(id);if (iframe.onSendComplete &&  typeof(iframe.onSendComplete) == 'function')  iframe.onSendComplete();
	}