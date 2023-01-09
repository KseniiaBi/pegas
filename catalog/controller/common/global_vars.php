<?php

class ControllerCommonGlobalVars extends Controller {
	public function index() {
		// links to categories, accessible from anywhere (links)
		$GLOBALS['lnk'] = array();
		$GLOBALS['lnk']['literature_catalog'] = $this->url->link('product/category', 'path=60');

		$GLOBALS['info'] = array();
		$GLOBALS['info']['book_series_filter_id'] = 6; // ID фильтра "Серия (книг)", используется для выделения текста особым образом в карточке товара и для того, чтобы отображать серию книг в корзине рядом с названием книги

		// common contacts
		$GLOBALS['contact'] = array();
		$GLOBALS['contact']['number1'] = '&nbsp;(057) 712 53 92';
		$GLOBALS['contact']['number2'] = '&nbsp;(050) 716 41 95';
		$GLOBALS['contact']['number3'] = '&nbsp;(095) 235 74 25';
		$GLOBALS['contact']['number4'] = '&nbsp;(096) 199 01 77';
		$GLOBALS['contact']['number5'] = '&nbsp;(063) 320 89 56';
		$GLOBALS['contact']['email'] = $this->config->get('config_email');
		$GLOBALS['contact']['skype'] = 'booktrade.kharkov@gmail.com';

		// some custom language translations
		$GLOBALS['ru'] = array();
		$GLOBALS['ru']['text'] = array();
		$GLOBALS['ru']['text']['number1']			= 'Харьков';
		$GLOBALS['ru']['text']['number2']			= 'Vodafone';
		$GLOBALS['ru']['text']['number3']			= 'Viber';
		$GLOBALS['ru']['text']['number4']			= 'КС';
		$GLOBALS['ru']['text']['number5']			= 'Life';
		$GLOBALS['ru']['text']['writeboss']			= 'Сообщить об ошибке';
		$GLOBALS['ru']['text']['writeboss_email']	= 'E-mail для связи';
		$GLOBALS['ru']['text']['writeboss_text']	= 'Текст вашего обращения';
		$GLOBALS['ru']['text']['book_overview']		= 'Обзор книги';
		$GLOBALS['ru']['text']['seria_overview']	= 'Обзор серии';
		$GLOBALS['ru']['text']['seria_all_books']	= 'Все книги серии';
		$GLOBALS['ru']['text']['full_product_desc']	= 'Полное описание товара';
		$GLOBALS['ru']['text']['text_currency']		= 'грн';
		$GLOBALS['ru']['text']['text_akcia']		= 'Цена по акции:';
		$GLOBALS['ru']['text']['form_footer_value'] = 'Форма: написать руководителю';

		// some custom language translations
		$GLOBALS['ua'] = array();
		$GLOBALS['ua']['text'] = array();
		$GLOBALS['ua']['text']['number1']			= 'Харків';
		$GLOBALS['ua']['text']['number2']			= 'Vodafone';
		$GLOBALS['ua']['text']['number3']			= 'Viber';
		$GLOBALS['ua']['text']['number4']			= 'КС';
		$GLOBALS['ua']['text']['number5']			= 'Life';
		$GLOBALS['ua']['text']['writeboss']			= 'Повідомити про помилку';
		$GLOBALS['ua']['text']['writeboss_email']	= 'E-mail для зв’язку';
		$GLOBALS['ua']['text']['writeboss_text']	= 'Текст вашого звернення';
		$GLOBALS['ua']['text']['book_overview']		= 'Огляд книги';
		$GLOBALS['ua']['text']['seria_overview']	= 'Огляд серії';
		$GLOBALS['ua']['text']['seria_all_books']	= 'Всі книги серії';
		$GLOBALS['ua']['text']['full_product_desc']	= 'Повний опис товару';
		$GLOBALS['ua']['text']['text_currency']		= 'грн';
		$GLOBALS['ua']['text']['form_footer_value'] = 'Форма: написати керівнику';

		// some custom language translations
		$GLOBALS['en'] = array();
		$GLOBALS['en']['text'] = array();
		$GLOBALS['en']['text']['number1'] = 'MTS';
		$GLOBALS['en']['text']['number2'] = 'KS';
		$GLOBALS['en']['text']['number3'] = 'Life';
		$GLOBALS['en']['text']['number4'] = 'Kharkiv';
		$GLOBALS['en']['text']['number5'] = 'Kharkiv';
		$GLOBALS['en']['text']['writeboss'] = 'Write to a head';
		$GLOBALS['en']['text']['writeboss_email'] = 'Enter your E-mail';
		$GLOBALS['en']['text']['writeboss_text'] = 'Enter your message';
		$GLOBALS['en']['text']['book_overview'] = 'Book Review';
		$GLOBALS['en']['text']['seria_overview'] = 'Browsing';
		$GLOBALS['en']['text']['seria_all_books'] = 'All books series';
		$GLOBALS['en']['text']['full_product_desc'] = 'Full description of goods';
		$GLOBALS['en']['text']['text_currency']		= '₴';
		$GLOBALS['en']['text']['form_footer_value'] = 'Form: write to a head';

		//filter price
		$GLOBALS['filter'] = array();
		$GLOBALS['filter']['amount_start'] = '0';
		$GLOBALS['filter']['amount_finish'] = '200';
	}
}
