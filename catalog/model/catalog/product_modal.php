<?php
// author:	Silenko Alexander
// date:	2016-05-24
class ModelCatalogProductModal extends Model {
	public function generateModalByID($product_id, $additional_data) {
		$product_modal_data = array();
		$product_modal_data['product_id'] = $product_id;
		$product_modal_data['text_select'] = $this->language->get('text_select');
		$product_modal_data['button_cart'] = $this->language->get('button_cart');
		$product_modal_data['book_overview'] = $this->language->get('book_overview');
		$product_modal_data['seria_overview'] = $this->language->get('seria_overview');
		$product_modal_data['seria_all_books'] = $this->language->get('seria_all_books');
		$product_modal_data['full_product_desc'] = $this->language->get('full_product_desc');
		$product_modal_data['text_currency'] = $this->language->get('text_currency');
		$product_modal_data['text_akcia'] = $this->language->get('text_akcia');
		$product_modal_data['link'] = $additional_data['product_href'];
		$product_modal_data['link_series'] = $GLOBALS['lnk']['literature_catalog'];
		$product_info_for_modal = $this->model_catalog_product->getProduct($product_modal_data['product_id']);
		if ($product_info_for_modal) {
			$product_modal_data['heading_title'] = $product_info_for_modal['name'];
			$product_modal_data['quantity'] = $product_info_for_modal['quantity'];
			$product_modal_data['heading_subtitle'] = $product_info_for_modal['meta_subtitle'];
			$product_modal_data['product_filters'] = $this->model_catalog_product_filters->getProductFilters($product_modal_data['product_id']);
			$product_modal_data['description'] = html_entity_decode($product_info_for_modal['description'], ENT_QUOTES, 'UTF-8');

			if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
				$product_modal_data['price'] = $this->currency->format($this->tax->calculate($additional_data['price'], $additional_data['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$product_modal_data['price'] = false;
			}

			if ((float)$additional_data['special']) {
				$product_modal_data['special'] = $this->currency->format($this->tax->calculate($additional_data['special'], $additional_data['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$product_modal_data['special'] = false;
			}

			$product_modal_data['options'] = array();

			foreach ($this->model_catalog_product->getProductOptions($product_modal_data['product_id']) as $option) {
				$product_option_value_data = array();

				foreach ($option['product_option_value'] as $option_value) {
					if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
						if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
							$price_2 = $this->currency->format($this->tax->calculate($option_value['price'], $product_info_for_modal['tax_class_id'], $this->config->get('config_tax') ? 'P' : false));
						} else {
							$price_2 = false;
						}

						$product_option_value_data[] = array(
							'product_option_value_id' => $option_value['product_option_value_id'],
							'option_value_id'         => $option_value['option_value_id'],
							'name'                    => $option_value['name'],
							'image'                   => $this->model_tool_image->resize($option_value['image'], 50, 50),
							'price'                   => $price_2,
							'price_prefix'            => $option_value['price_prefix']
						);
					}
				}

				$product_modal_data['options'][] = array(
					'product_option_id'    => $option['product_option_id'],
					'product_option_value' => $product_option_value_data,
					'option_id'            => $option['option_id'],
					'name'                 => $option['name'],
					'type'                 => $option['type'],
					'value'                => $option['value'],
					'required'             => $option['required']
				);
			}

			if ($product_info_for_modal['image']) {
				$product_modal_data['popup'] = $this->model_tool_image->resize($product_info_for_modal['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height'));
			} else {
				$product_modal_data['popup'] = '';
			}

			if ($product_info_for_modal['image']) {
				$product_modal_data['thumb'] = $this->model_tool_image->resize($product_info_for_modal['image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height'));
			} else {
				$product_modal_data['thumb'] = '';
			}

			$product_modal_data['images'] = array();

			$results_2 = $this->model_catalog_product->getProductImages($product_modal_data['product_id']);

			foreach ($results_2 as $result_2) {
				$product_modal_data['images'][] = array(
					'popup' => $this->model_tool_image->resize($result_2['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height')),
					'thumb' => $this->model_tool_image->resize($result_2['image'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height'))
				);
			}
		}
		$product_filters = $this->model_catalog_product_filters->getProductFilters($product_id);
		foreach ($product_filters as $product_filter) {
			if ($product_filter['filter_group_id'] == $GLOBALS['info']['book_series_filter_id']) { // если это фильтр "Серия (книги)" 
				$product_modal_data['link_series'] = $GLOBALS['lnk']['literature_catalog'] . "&filter=" . $product_filter['filter_id'];
			}
		}
		
		return $this->load->view($this->config->get('config_template') . '/template/product/category_product_modal.tpl', $product_modal_data);
	}
}