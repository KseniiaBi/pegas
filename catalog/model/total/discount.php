<?php
class ModelTotalDiscount extends Model {
	public function getTotal(&$total_data, &$total, &$taxes) {
		$this->load->language('total/discount');

		$sub_total = $this->cart->getSubTotal();

		if ($sub_total > 2000) {
			$percent = 11;
		} elseif ($sub_total >= 1200) {
			$percent = 9;
		} elseif ($sub_total >= 800) {
			$percent = 7;
		} elseif ($sub_total >= 400) {
			$percent = 5;
		} elseif ($sub_total >= 250) {
			$percent = 3;
		} else {
			$percent = 0;
		}

		if ($percent) {
			$discount = ($sub_total / 100) * $percent;

			$total_data[] = array(
				'code'       => 'discount',
				'title'      => sprintf($this->language->get('text_discount_total'), $percent) . '%',
				'value'      => -$discount,
				'text_currency'      => $this->language->get('text_currency'),
				'sort_order' => $this->config->get('discount_sort_order')
			);

			$total -= $discount;
		}
	}
}