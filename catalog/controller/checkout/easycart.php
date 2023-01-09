<?php

// INPUT NAMES FOR FORM IN TPL FILE:
// easycart-firstname
// easycart-lastname
// easycart-company
// easycart-address_1
// easycart-address_2
// easycart-city
// easycart-postcode
// easycart-country_id
// easycart-zone_id
// easycart-shipping_method
// easycart-payment_method
// easycart-comment
// easycart-email
// easycart-telephone
// easycart-shipping_address

class ControllerCheckoutEasycart extends Controller {
	public function index() {
		// $this->load->language('checkout/easycart');
		// $data['text_head'] = $this->language->get('text_head');
		$this->registry->set('payment_method', $this->load->controller('checkout/payment_method'));
		$this->registry->set('shipping_method', $this->load->controller('checkout/shipping_method'));

		$this->load->controller('checkout/cart');
	}

	public function confirm() {
		$this->config->set('flat_cost', 0);
		$this->config->set('shipping_method', $this->request->post['easycart-shipping_method_text']);
		$this->config->set('payment_method', $this->request->post['easycart-payment_method_text']);
		
		$this->load->model('checkout/order');

		// ОБЩИЕ ДАННЫЕ
		$this->request->get['country_id'] = (isset($this->request->post['easycart-country_id']) ? $this->request->post['easycart-country_id'] : '220'); // UKRAINE - 220
		$this->request->post['firstname'] = (isset($this->request->post['easycart-firstname']) ? $this->request->post['easycart-firstname'] : '');
		$this->request->post['lastname'] = (isset($this->request->post['easycart-lastname']) ? $this->request->post['easycart-lastname'] : '');
		$this->request->post['company'] = (isset($this->request->post['easycart-company']) ? $this->request->post['easycart-company'] : '');
		$this->request->post['address_1'] = (isset($this->request->post['easycart-address_1']) ? $this->request->post['easycart-address_1'] : '');
		$this->request->post['address_2'] = (isset($this->request->post['easycart-address_2']) ? $this->request->post['easycart-address_2'] : '');
		$this->request->post['city'] = (isset($this->request->post['easycart-city']) ? $this->request->post['easycart-city'] : '');
		$this->request->post['postcode'] = (isset($this->request->post['easycart-postcode']) ? $this->request->post['easycart-postcode'] : '');
		$this->request->post['country_id'] = (isset($this->request->post['easycart-country_id']) && $this->request->post['easycart-country_id'] ? $this->request->post['easycart-country_id'] : '220'); // UKRAINE - 220
		$this->request->post['zone_id'] = (isset($this->request->post['easycart-zone_id']) && $this->request->post['easycart-zone_id'] ? $this->request->post['easycart-zone_id'] : '3490'); // KIEV - 3490

		$this->request->post['shipping_method'] = (isset($this->request->post['easycart-shipping_method']) && $this->request->post['easycart-shipping_method'] ? $this->request->post['easycart-shipping_method'] : 'flat.flat'); // flat.flat
		$this->request->post['comment'] = (isset($this->request->post['easycart-comment']) ? $this->request->post['easycart-comment'] : '');

		// silenko 2016-06-13 BUGFIX
		// $this->request->post['payment_method'] = (isset($this->request->post['easycart-payment_method']) && $this->request->post['easycart-payment_method'] ? $this->request->post['easycart-payment_method'] : 'cod'); // cod
		$this->request->post['payment_method'] = (isset($this->request->post['easycart-payment_method']) && $this->request->post['easycart-payment_method'] ? $this->request->post['easycart-payment_method'] : 'custom_cash'); // cod
		$this->request->post['comment'] = (isset($this->request->post['easycart-comment']) ? $this->request->post['easycart-comment'] : '');
		$this->request->post['agree'] = '1';

		$this->request->get['_'] = (time() . '000'); // timestamp + 3 digits

		if ($this->customer->isLogged()) { // клиент залогинен
			$this->request->post['payment_address'] = 'existing';
			$this->request->post['address_id'] = '1';
			$this->request->post['shipping_address'] = 'existing';

			$this->load->controller('checkout/payment_address');
			if (strpos($this->response->getOutput(), '"error"') !== false) {return;}
			//// проблема здесь
			$this->load->controller('checkout/payment_address/save');
			if (strpos($this->response->getOutput(), '"error"') !== false) {return;}
			////
			$this->load->controller('checkout/shipping_address');
			if (strpos($this->response->getOutput(), '"error"') !== false) {return;}
			$this->load->controller('checkout/payment_address');
			if (strpos($this->response->getOutput(), '"error"') !== false) {return;}
			$this->load->controller('checkout/checkout/country');
			if (strpos($this->response->getOutput(), '"error"') !== false) {return;}
			$this->load->controller('checkout/shipping_address/save');
			if (strpos($this->response->getOutput(), '"error"') !== false) {return;}
			$this->load->controller('checkout/shipping_method');
			if (strpos($this->response->getOutput(), '"error"') !== false) {return;}
			$this->load->controller('checkout/payment_address');
			if (strpos($this->response->getOutput(), '"error"') !== false) {return;}
			$this->load->controller('checkout/shipping_address');
			if (strpos($this->response->getOutput(), '"error"') !== false) {return;}
			$this->load->controller('checkout/checkout/country');
			if (strpos($this->response->getOutput(), '"error"') !== false) {return;}
			$this->load->controller('checkout/shipping_method/save');
			if (strpos($this->response->getOutput(), '"error"') !== false) {return;}
			$this->load->controller('checkout/payment_method');
			if (strpos($this->response->getOutput(), '"error"') !== false) {return;}
			$this->load->controller('checkout/payment_method/save');
			if (strpos($this->response->getOutput(), '"error"') !== false) {return;}
			$this->load->controller('checkout/confirm');
			
			// fix for retailCRM
			$order_id = $this->session->data['order_id'];
			$this->model_checkout_order->updateOrderData($order_id, 'shipping_method', $this->config->get('shipping_method'));
			$this->model_checkout_order->updateOrderData($order_id, 'payment_method', $this->config->get('payment_method'));
			
			if (strpos($this->response->getOutput(), '"error"') !== false) {return;}
			$this->model_checkout_order->addOrderHistory($this->session->data['order_id'], 1);
			// уже не нужно
			// $this->load->controller('payment/cod/confirm');
			// if (strpos($this->response->getOutput(), '"error"') !== false) {return;}
			// end уже не нужно

		} else { // клиент не залогинен
			$this->request->get['customer_group_id'] = '1';
			$this->request->get['country_id'] = (isset($this->request->post['easycart-country_id']) ? $this->request->post['easycart-country_id'] : '220'); // UKRAINE - 220
			$this->request->post['customer_group_id'] = '1';
			$this->request->post['email'] = (isset($this->request->post['easycart-email']) && $this->request->post['easycart-email'] ? $this->request->post['easycart-email'] : $this->config->get('config_email'));
			$this->request->post['telephone'] = (isset($this->request->post['easycart-telephone']) ? $this->request->post['easycart-telephone'] : '');
			$this->request->post['fax'] = (isset($this->request->post['easycart-telephone']) ? $this->request->post['easycart-telephone'] : '');
			$this->request->post['shipping_address'] = (isset($this->request->post['easycart-telephone']) ? $this->request->post['easycart-telephone'] : '');
			
			$this->load->controller('checkout/guest');
			if (strpos($this->response->getOutput(), '"error"') !== false) {return;}
			$this->load->controller('checkout/checkout/customfield');
			if (strpos($this->response->getOutput(), '"error"') !== false) {return;}
			$this->load->controller('checkout/checkout/country');
			if (strpos($this->response->getOutput(), '"error"') !== false) {return;}
			$this->load->controller('checkout/guest/save');
			if (strpos($this->response->getOutput(), '"error"') !== false) {return;}
			$this->load->controller('checkout/shipping_method');
			if (strpos($this->response->getOutput(), '"error"') !== false) {return;}
			$this->load->controller('checkout/guest_shipping');
			if (strpos($this->response->getOutput(), '"error"') !== false) {return;}
			$this->load->controller('checkout/checkout/country');
			if (strpos($this->response->getOutput(), '"error"') !== false) {return;}
			$this->load->controller('checkout/shipping_method/save');
			if (strpos($this->response->getOutput(), '"error"') !== false) {return;}
			$this->load->controller('checkout/payment_method');
			if (strpos($this->response->getOutput(), '"error"') !== false) {return;}
// тут была бажина - пофиксил vv
			$this->load->controller('checkout/payment_method/save');
			if (strpos($this->response->getOutput(), '"error"') !== false) {return;}
// тут была бажина - пофиксил  ^^
			$this->load->controller('checkout/confirm');
			
			// fix for retailCRM
			$order_id = $this->session->data['order_id'];
			$this->model_checkout_order->updateOrderData($order_id, 'shipping_method', $this->config->get('shipping_method'));
			$this->model_checkout_order->updateOrderData($order_id, 'payment_method', $this->config->get('payment_method'));
			
			if (strpos($this->response->getOutput(), '"error"') !== false) {return;}
			$this->model_checkout_order->addOrderHistory($this->session->data['order_id'], 1);

			// уже не нужно
			// $this->load->controller('payment/cod/confirm');
			// if (strpos($this->response->getOutput(), '"error"') !== false) {return;}
			// end уже не нужно
		}
// ТОВАРЫ НЕ УБИРАЮТСЯ ИЗ КОРЗИНЫ ПОСЛЕ УСПЕШНОГО ОФОРМЛЕНИЯ ЗАКАЗА
// ПЕРЕДЕЛАТЬ ВЫПАДАЮЩИЕ СПИСКИ ДОСТАВКИ И ОПЛАТЫ НА СТАНДАРТНЫЕ
		$this->load->model('checkout/order');
		if (!isset($this->request->post['easycart-shipping_method_text'])) {$this->request->post['easycart-shipping_method_text'] = '';}
		if (!isset($this->request->post['easycart-payment_method_text'])) {$this->request->post['easycart-payment_method_text'] = '';}
		$order_id = $this->session->data['order_id'];
		$this->model_checkout_order->updateOrderData($order_id, 'shipping_method', $this->config->get('shipping_method'));
		$this->model_checkout_order->updateOrderData($order_id, 'payment_method', $this->config->get('payment_method'));

		$json = array(
			'success'	=> 'true',
			'redirect'	=> $this->url->link('checkout/success'),
			'order_id'	=> $this->session->data['order_id'],
		);

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
		// $this->response->redirect($this->url->link('checkout/success')); // уже не нужно, корзина будет аяксовая
	}

	public function setOrder() {

		if (isset($this->request->get['order_id'])) {
			$price_filter = json_decode($this->request->get['order_id']);

					$this->load->model('checkout/order');
					$this->model_checkout_order->addOrderHistory($this->request->get['order_id'], 1);
		}
	}
}
