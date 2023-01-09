<?php
class ControllerCommonFooter extends Controller {
	public function index() {
		$this->load->language('common/footer');

		$data['scripts'] = $this->document->getScripts('footer');

		$data['text_information'] = $this->language->get('text_information');
		$data['text_service'] = $this->language->get('text_service');
		$data['text_extra'] = $this->language->get('text_extra');

		$data['text_sitemap'] = $this->language->get('text_sitemap');
		$data['text_manufacturer'] = $this->language->get('text_manufacturer');
		$data['text_voucher'] = $this->language->get('text_voucher');

		$data['text_newsletter'] = $this->language->get('text_newsletter');

		$data['text_about_us'] = $this->language->get('text_about_us');
		$data['text_blog'] = $this->language->get('text_blog');
		$data['text_contact'] = $this->language->get('text_contact');

		$data['text_special'] = $this->language->get('text_special');
		$data['text_affiliate'] = $this->language->get('text_affiliate');
		$data['text_payment'] = $this->language->get('text_payment');
		$data['text_garant'] = $this->language->get('text_garant');
		$data['text_return'] = $this->language->get('text_return');

		$data['text_pagination_show_more'] = $this->language->get('text_pagination_show_more');
		$data['text_account'] = $this->language->get('text_account');
		$data['text_order'] = $this->language->get('text_order');
		$data['text_wishlist'] = $this->language->get('text_wishlist');
		$data['text_my_cart'] = $this->language->get('text_my_cart');

		// silenko 2016-05-11
		$data['text_contact_number1'] = $this->language->get('text_contact_number1');
		$data['text_contact_number2'] = $this->language->get('text_contact_number2');
		$data['text_contact_number3'] = $this->language->get('text_contact_number3');
		$data['text_contact_number4'] = $this->language->get('text_contact_number4');
		$data['text_contact_number5'] = $this->language->get('text_contact_number5');
		$data['text_writeboss'] = $this->language->get('text_writeboss');
		$data['text_writeboss_email'] = $this->language->get('text_writeboss_email');
		$data['text_writeboss_text'] = $this->language->get('text_writeboss_text');
		$data['text_information_sent'] = $this->language->get('text_information_sent');
		$data['form_footer_value'] = $this->language->get('form_footer_value');
		$data['text_email_error'] = $this->language->get('text_email_error');
		$data['text_email_valid'] = $this->language->get('text_email_valid');
		$data['text_textarea_error'] = $this->language->get('text_textarea_error');
		$data['text_addr'] = $this->language->get('text_addr');
		$data['text_powered'] = $this->language->get('text_powered');
		$data['text_publisher'] = $this->language->get('text_publisher');
		$data['text_social'] = $this->language->get('text_social');

		$this->load->model('catalog/information');

		$data['informations'] = array();

		foreach ($this->model_catalog_information->getInformations() as $result) {
			if ($result['bottom']) {
				$data['informations'][] = array(
					'title' => $result['title'],
					'href'  => $this->url->link('information/information', 'information_id=' . $result['information_id'])
				);
			}
		}

		$data['about_us'] = $this->url->link('information/information', 'information_id=4');
		$data['blog'] = $this->url->link('information/information', 'information_id=6');
		$data['contact'] = $this->url->link('information/information', 'information_id=9');

		$data['dropshipping'] = $this->url->link('inforamtion/information', 'information_id=40');
		$data['payment'] = $this->url->link('inforamtion/information', 'information_id=7');

		$data['personal'] = $this->url->link('account/address', '', 'SSL');
		$data['my_cart'] = $this->url->link('checkout/cart', '', 'SSL');

		$data['return'] = $this->url->link('account/return/add', '', 'SSL');
		$data['sitemap'] = $this->url->link('information/sitemap');
		$data['manufacturer'] = $this->url->link('product/manufacturer');
		$data['voucher'] = $this->url->link('account/voucher', '', 'SSL');
		$data['affiliate'] = $this->url->link('affiliate/account', '', 'SSL');
		$data['special'] = $this->url->link('product/special');
		$data['account'] = $this->url->link('account/account', '', 'SSL');
		$data['order'] = $this->url->link('account/order', '', 'SSL');
		$data['wishlist'] = $this->url->link('account/wishlist', '', 'SSL');
		$data['newsletter'] = $this->url->link('account/newsletter', '', 'SSL');

		$data['powered'] = sprintf($this->language->get('text_powered'), $this->config->get('config_name'), date('Y', time()));
		$data['home'] = $this->url->link('common/home');

		// Whos Online
		if ($this->config->get('config_customer_online')) {
			$this->load->model('tool/online');

			if (isset($this->request->server['REMOTE_ADDR'])) {
				$ip = $this->request->server['REMOTE_ADDR'];
			} else {
				$ip = '';
			}

			if (isset($this->request->server['HTTP_HOST']) && isset($this->request->server['REQUEST_URI'])) {
				$url = 'http://' . $this->request->server['HTTP_HOST'] . $this->request->server['REQUEST_URI'];
			} else {
				$url = '';
			}

			if (isset($this->request->server['HTTP_REFERER'])) {
				$referer = $this->request->server['HTTP_REFERER'];
			} else {
				$referer = '';
			}

			$this->model_tool_online->addOnline($ip, $this->customer->getId(), $url, $referer);
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/footer.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/common/footer.tpl', $data);
		} else {
			return $this->load->view('default/template/common/footer.tpl', $data);
		}
	}
}
