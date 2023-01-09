<?php
class ControllerAccountWishList extends Controller {
	public function index() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/wishlist', '', 'SSL');

			$this->response->redirect($this->url->link('account/login', '', 'SSL'));
		}

		$this->load->language('product/product');
		$this->load->language('account/wishlist');

		$this->load->model('account/wishlist');

		$this->load->model('catalog/product');

		$this->load->model('catalog/category');

		$this->load->model('tool/image');

		if (isset($this->request->get['remove'])) {
			// Remove Wishlist
			$this->model_account_wishlist->deleteWishlist($this->request->get['remove']);

			$this->session->data['success'] = $this->language->get('text_remove');

			$this->response->redirect($this->url->link('account/wishlist'));
		}

		$this->document->setTitle($this->language->get('heading_title'));

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_account'),
			'href' => $this->url->link('account/account', '', 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('account/wishlist')
		);

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_empty'] = $this->language->get('text_empty');

		$data['column_image'] = $this->language->get('column_image');
		$data['column_name'] = $this->language->get('column_name');
		$data['column_model'] = $this->language->get('column_model');
		$data['column_stock'] = $this->language->get('column_stock');
		$data['column_price'] = $this->language->get('column_price');
		$data['column_action'] = $this->language->get('column_action');

		$data['text_wishlist_description'] = $this->language->get('text_wishlist_description');
		$data['button_continue'] = $this->language->get('button_continue');
		$data['button_cart'] = $this->language->get('button_cart');
		$data['button_remove'] = $this->language->get('button_remove');
		$data['text_preview'] = $this->language->get('text_preview');
		$data['text_currency'] = $this->language->get('text_currency');
		$data['text_price_c'] = $this->language->get('text_price_c');

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		$data['products'] = array();

		$results = $this->model_account_wishlist->getWishlist();

		foreach ($results as $result) {
			$product_info = $this->model_catalog_product->getProduct($result['product_id']);

			if ($product_info) {
				$result = $product_info;
				$last_modified_key .= $result['product_id'];
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					$image_gallery = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height'));

				} else {
					$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					$image_gallery = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height'));

				}

				if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$price = false;
				}

				if(!$result['special']){
					$result['special'] = '';
					$sql = "SELECT price FROM " . DB_PREFIX . "product_special
					WHERE product_id = '" . $result['product_id'] . "'
					AND customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "'
					AND ((date_start = '0000-00-00' OR date_start < NOW())
					AND (date_end = '0000-00-00' OR date_end > NOW()))
					ORDER BY priority ASC, price ASC LIMIT 1";
					$sp_query = $this->db->query($sql);
					if(isset($sp_query->row['price']) && $sp_query->row['price']){
						$result['special'] = $sp_query->row['price'];
					}
				}

				if ((float)$result['special']) {
					$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$special = false;
				}

				if ($this->config->get('config_tax')) {
					$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
				} else {
					$tax = false;
				}

				if ($this->config->get('config_review_status')) {
					$rating = (int)$result['rating'];
				} else {
					$rating = false;
				}

				$product_href = $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url);


				$gallery_data = $this->model_catalog_category->getGallery($category_id);
				if (isset($gallery_data) && count($gallery_data) > 0) {
					$data['gallery'] = $gallery_data[0]['gallery'];
				}

				$akchia = false;
				$disc_percent = 0;
				$akcia_query = $this->db->query("SELECT category_id FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . $result['product_id'] . "' AND category_id = 65");
				$option_akcia_query = $this->db->query("SELECT price FROM " . DB_PREFIX . "product_option_value WHERE product_id = '" . $result['product_id'] . "' AND price_prefix = '-' AND price > 0");

				if($akcia_query->num_rows){
					$akchia = true;
					$sql = "SELECT discount_percent FROM " . DB_PREFIX . "product_special
					WHERE product_id = '" . $result['product_id'] . "'
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

				$data['products'][] = array(
					'product_id'		=> $result['product_id'],
					'thumb'				=> $image,
					'thumb_gallery' 	=> $image_gallery,
					'meta_subtitle'		=> $result['meta_subtitle'],
					'quantity'			=> $result['quantity'],
					'name'				=> $result['name'],
					'description'		=> utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
					'price'				=> $price,
					'special'			=> $special,
					'stock'				=> $result['quantity'] > 0 ? $this->language->get('text_instock') : $this->language->get('text_outofstock'),
					'tax'				=> $tax,
					'akchia'			=> $akchia,
					'discount_percent' => $disc_percent,
					'minimum'			=> $result['minimum'] > 0 ? $result['minimum'] : 1,
					'rating'			=> $result['rating'],
					'href'				=> $product_href,
					'remove'     => $this->url->link('account/wishlist', 'remove=' . $product_info['product_id'])
				);
			} else {
				$this->model_account_wishlist->deleteWishlist($product_id);
			}
		}

		$data['continue'] = $this->url->link('account/account', '', 'SSL');

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/wishlist.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/account/wishlist.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/account/wishlist.tpl', $data));
		}
	}

	public function add() {
		$this->load->language('account/wishlist');

		$json = array();

		if (isset($this->request->post['product_id'])) {
			$product_id = $this->request->post['product_id'];
		} else {
			$product_id = 0;
		}

		$this->load->model('catalog/product');

		$product_info = $this->model_catalog_product->getProduct($product_id);

		if ($product_info) {
			if ($this->customer->isLogged()) {
				// Edit customers cart
				$this->load->model('account/wishlist');

				$this->model_account_wishlist->addWishlist($this->request->post['product_id']);

				$json['success'] = sprintf($this->language->get('text_success'), $this->url->link('product/product', 'product_id=' . (int)$this->request->post['product_id']), $product_info['name'], $this->url->link('account/wishlist'));

				$json['total'] = sprintf($this->language->get('text_wishlist'), $this->model_account_wishlist->getTotalWishlist());
			} else {
				if (!isset($this->session->data['wishlist'])) {
					$this->session->data['wishlist'] = array();
				}

				$this->session->data['wishlist'][] = $this->request->post['product_id'];

				$this->session->data['wishlist'] = array_unique($this->session->data['wishlist']);

				$json['success'] = sprintf($this->language->get('text_login'), $this->url->link('account/login', '', 'SSL'), $this->url->link('account/register', '', 'SSL'), $this->url->link('product/product', 'product_id=' . (int)$this->request->post['product_id']), $product_info['name'], $this->url->link('account/wishlist'));

				$json['total'] = sprintf($this->language->get('text_wishlist'), (isset($this->session->data['wishlist']) ? count($this->session->data['wishlist']) : 0));
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}
