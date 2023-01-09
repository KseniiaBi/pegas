<?php
class ModelTotalTotal extends Model {
	public function getTotal(&$total_data, &$total, &$taxes) {
		$this->load->language('total/total');

		$total_data[] = array(
			'code'       => 'total',
			'title'      => $this->language->get('text_total'),
			'value'      => max(0, $total),
			'text_currency'      => $this->language->get('text_currency'),
			'sort_order' => $this->config->get('total_sort_order')
		);
	}
}