<?php
class ModelPaymentCustomCashless extends Model {
	public function getMethod($address, $total) {
		$this->load->language('payment/custom_cashless');

		if ($total <= 0.00) {
			$status = true;
		} else {
			$status = false;
		}

		$method_data = array();

		if ($status) {
			$method_data = array(
				'code'       => 'custom_cashless',
				'title'      => $this->language->get('text_title'),
				'terms'      => '',
				'sort_order' => $this->config->get('custom_cashless_sort_order')
			);
		}

		return $method_data;
	}
}