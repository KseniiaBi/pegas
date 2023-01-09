<?php
class ControllerModuleFeatured extends Controller {
	public function index($setting) {
		static $module = 0;

		$this->load->language('product/product');
		$this->load->language('module/featured');

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_tax'] = $this->language->get('text_tax');
		$data['currency'] = $this->language->get('currency');
		$data['text_currency'] = $this->language->get('text_currency');
		$data['text_cart_product'] = $this->language->get('text_cart_product');
		$data['text_cart_add'] = $this->language->get('text_cart_add');
		$data['text_cart'] = $this->language->get('text_cart');
		$data['text_price_c'] = $this->language->get('text_price_c');
		$data['text_akchia'] = $this->language->get('text_akchia');
		$data['button_cart'] = $this->language->get('button_cart');
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');
		$data['heading_title_gallery'] = $this->language->get('heading_title_gallery');
		$data['text_more'] = $this->language->get('text_more');

		$data['text_all_books'] = $this->language->get('text_all_books');
		$data['text_preview'] = $this->language->get('text_preview');

		$data['carusel_name'] = $setting['title_'.$this->config->get('config_language_id')];

		$data['class'] = $setting['class'];

		$this->load->model('catalog/product');
		if (!empty($setting['product'])) {
			$data['category_url'] = HTTPS_SERVER . $this->model_catalog_product->getUrlCategory($setting['product'][0]);
		}
		if(!empty($setting['product_category'])) {
			$data['category_url'] = HTTPS_SERVER . $this->model_catalog_product->getUrlCategoryById($setting['product_category'][0]);
		}

		$this->load->model('tool/image');
		$this->load->model('catalog/product_filters');
		$this->load->model('catalog/product_modal');

		$data['products'] = array();

		if (!$setting['limit']) {
			$setting['limit'] = 200;
		}

		if (!empty($setting['product'])) {
			$products = array_slice($setting['product'], 0, (int)$setting['limit']);
		}

		if(!empty($setting['product_category'])) {
			$products = $this->model_catalog_product->getAllProducts($setting['product_category'][0], $setting['limit']);
		}
			foreach ($products as $product_id) {
				if(!empty($setting['product_category'])) {
				$product_info = $this->model_catalog_product->getProduct($product_id['product_id']);

				$gallery_data = $this->model_catalog_product->getGallery($product_id['product_id']);
				$data['gallery'] = $gallery_data[0]['gallery'];
				} else {
				$product_info = $this->model_catalog_product->getProduct($product_id);

				$gallery_data = $this->model_catalog_product->getGallery($product_id);
				$data['gallery'] = $gallery_data[0]['gallery'];
				}

				if ($product_info) {
					if ($product_info['image']) {
						$image = $this->model_tool_image->resize($product_info['image'], $setting['width'], $setting['height']);
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
					}

					$images = [];

					$results = $this->model_catalog_product->getProductImages($product_info['product_id']);

					foreach ($results as $result) {
						$images[] = array(
							'popup' => $this->model_tool_image->resize($result['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height')),
							'thumb' => $this->model_tool_image->resize($result['image'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height'))
						);
					}

					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}

					if ((float)$product_info['special']) {
						$special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}

					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$product_info['special'] ? $product_info['special'] : $product_info['price']);
					} else {
						$tax = false;
					}

					if ($this->config->get('config_review_status')) {
						$rating = $product_info['rating'];
					} else {
						$rating = false;
					}

					// silenko 2016-05-18
					$product_modal = $this->model_catalog_product_modal->generateModalByID($product_info['product_id'],
						array_merge($product_info, array('product_href' => $this->url->link('product/product', 'product_id=' . $product_info['product_id'])))
						);


					// end silenko 2016-05-18

					$akchia = false;
					$disc_percent = 0;
					$akcia_query = $this->db->query("SELECT category_id FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . $product_info['product_id'] . "' AND category_id = 65");
					$option_akcia_query = $this->db->query("SELECT price FROM " . DB_PREFIX . "product_option_value WHERE product_id = '" . $product_info['product_id'] . "' AND price_prefix = '-' AND price > 0");
					if($akcia_query->num_rows){
						$akchia = true;
						$sql = "SELECT discount_percent FROM " . DB_PREFIX . "product_special
						WHERE product_id = '" . $product_info['product_id'] . "'
						AND customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "'
						AND ((date_start = '0000-00-00' OR date_start < NOW())
						AND (date_end = '0000-00-00' OR date_end > NOW()))
						ORDER BY priority ASC, price ASC LIMIT 1";
						$sp_query = $this->db->query($sql);
						if(isset($sp_query->row['discount_percent']) && $sp_query->row['discount_percent']){
							$disc_percent = $sp_query->row['discount_percent'];
						}
					}elseif($option_akcia_query->num_rows){
						$akchia = true;
					}

                    $other_lang = [];
                    $results = $this->model_catalog_product->getAlternativeProductList($product_info['product_id']);
                    foreach ($results as $result) {
                        $other_lang[] = [
                            'name' => $result['name'],
                            'href' => $this->url->link('product/product', 'product_id=' . $result['product_id']),
                            'active' => $result['language_id'] == $product_info['lang']
                        ];
                    }


                    $data['products'][] = array(
						'product_id'  => $product_info['product_id'],
						'thumb'       => $image,
						'name'        => $product_info['name'],
						'quantity'    => $product_info['quantity'],
						'minimum'	  => $product_info['minimum'],
						'description' => utf8_substr(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
						'price'       => $price,
						'akchia'			=> $akchia,
						'discount_percent' => $disc_percent,
						'stock'		  => $product_info['quantity'] > 0 ? $this->language->get('text_instock') : $this->language->get('text_outofstock'),
						'special'     => $special,
						'images'	  => $images,
						'tax'         => $tax,
						'rating'      => $rating,
						'other_lang'  => $other_lang,
						'isbn'	      => $product_info['isbn'], 
						'href'        => $this->url->link('product/product', 'product_id=' . $product_info['product_id']),
						'filters'     => $this->model_catalog_product_filters->getProductFilters($product_info['product_id']),
						'modal'       => $product_modal,
					);
				}
			}

		$data['module'] = $module++;

		if ($data['products']) {
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/featured.tpl')) {
				return $this->load->view($this->config->get('config_template') . '/template/module/featured.tpl', $data);
			} else {
				return $this->load->view('default/template/module/featured.tpl', $data);
			}
		}
	}
}
