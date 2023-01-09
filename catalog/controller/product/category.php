<?php
class ControllerProductCategory extends Controller {
	public function index() {
		$this->load->language('product/product');
		$this->load->language('product/category');

		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$this->load->model('tool/image');

		if (isset($this->request->get['filter'])) {
			$filter = $this->request->get['filter'];
		} else {
			$filter = '';
		}

		if (isset($this->request->get['price'])) {
			$price_filter = json_decode($this->request->get['price']);
		} else {
			$price_filter = array();
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			// $sort = 'p.sort_order';
			//$sort = 'p.quantity';
			//$sort = 'p.price';
			$sort = 'p.date_added';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			//$order = 'ASC';
			$order = 'DESC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		if (isset($this->request->get['limit'])) {
			$limit = (int)$this->request->get['limit'];
		} else {
			$limit = $this->config->get('config_product_limit');
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		if (isset($this->request->get['path'])) {
			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$path = '';

			$parts = explode('_', (string)$this->request->get['path']);

			$category_id = (int)array_pop($parts);

			foreach ($parts as $path_id) {
				if (!$path) {
					$path = (int)$path_id;
				} else {
					$path .= '_' . (int)$path_id;
				}

				$category_info = $this->model_catalog_category->getCategory($path_id);

				if ($category_info) {
					$data['breadcrumbs'][] = array(
						'text' => $category_info['name'],
						'href' => $this->url->link('product/category', 'path=' . $path . $url)
					);
				}
			}
		} else {
			$category_id = 0;
		}

		$category_info = $this->model_catalog_category->getCategory($category_id);

		if ($category_info) {
			$this->document->setTitle($category_info['meta_title']);
			$this->document->setDescription($category_info['meta_description']);
			$this->document->setKeywords($category_info['meta_keyword']);

			$data['heading_title'] = $category_info['name'];

			$data['text_more'] = $this->language->get('text_more');
			$data['text_refine'] = $this->language->get('text_refine');
			$data['text_empty'] = $this->language->get('text_empty');
			$data['text_quantity'] = $this->language->get('text_quantity');
			$data['text_manufacturer'] = $this->language->get('text_manufacturer');
			$data['text_model'] = $this->language->get('text_model');
			$data['text_price'] = $this->language->get('text_price');
			$data['text_tax'] = $this->language->get('text_tax');
			$data['text_points'] = $this->language->get('text_points');
			$data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
			$data['text_sort'] = $this->language->get('text_sort');
			$data['text_limit'] = $this->language->get('text_limit');
			$data['text_filter'] = $this->language->get('text_filter');
			$data['text_close'] = $this->language->get('text_close');
			$data['text_def'] = $this->language->get('text_def');
			$data['text_price_c'] = $this->language->get('text_price_c');
			$data['text_preview'] = $this->language->get('text_preview');

			$data['button_cart'] = $this->language->get('button_cart');
			$data['button_wishlist'] = $this->language->get('button_wishlist');
			$data['button_compare'] = $this->language->get('button_compare');
			$data['button_continue'] = $this->language->get('button_continue');
			$data['button_list'] = $this->language->get('button_list');
			$data['button_grid'] = $this->language->get('button_grid');
			$data['text_showmoreProductsButtonLabel'] = $this->language->get('text_showmoreProductsButtonLabel');
			$data['currency'] = $this->language->get('currency');
			$data['text_currency'] = $this->language->get('text_currency');
			$data['text_akcia'] = $this->language->get('text_akcia');
			$data['text_akchia'] = $this->language->get('text_akchia');
			// Set the last category breadcrumb
			$data['breadcrumbs'][] = array(
				'text' => $category_info['name'],
				'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . (isset($this->request->get['price']) ? '&price=' . $this->request->get['price'] : ''))
			);

			if ($category_info['image']) {
				$data['thumb'] = $this->model_tool_image->resize($category_info['image'], $this->config->get('config_image_category_width'), $this->config->get('config_image_category_height'));
			} else {
				$data['thumb'] = '';
			}

			$data['description'] = html_entity_decode($category_info['description'], ENT_QUOTES, 'UTF-8');
			$data['compare'] = $this->url->link('product/compare');

			$url = '';

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['categories'] = array();

			$results = $this->model_catalog_category->getCategories($category_id);

			foreach ($results as $result) {
				$filter_data = array(
					'filter_category_id'  => $result['category_id'],
					'filter_sub_category' => true
				);

				$data['categories'][] = array(
					'name' => $result['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
					'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '_' . $result['category_id'] . $url . (isset($this->request->get['price']) ? '&price=' . $this->request->get['price'] : ''))
				);
			}

			$data['products'] = array();
			$this->load->model('catalog/product_filters');

			$filter_data = array(
				'filter_category_id'  => $category_id,
				'filter_sub_category' => true, // silenko 2016-04-28 / added for subcategory product display in parent category
				'filter_filter'       => $filter,
				'sort'                => $sort,
				'order'               => $order,
				'start'               => ($page - 1) * $limit,
				'limit'               => $limit,
				'price_filter'        => $price_filter,
			);

			$product_total = $this->model_catalog_product->getTotalProducts($filter_data);

			$results = $this->model_catalog_product->getProducts($filter_data);

			// $this->load->model('catalog/product'); // уже вызывается в начале
			$this->load->model('catalog/product_filters');
			$this->load->model('tool/image');
			// silenko 2016-05-24
			$this->load->model('catalog/product_modal');
			$last_modified_key = "";

			foreach ($results as $result) {
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


				// silenko 2016-05-09
				$category_product_modal = $this->model_catalog_product_modal->generateModalByID($result['product_id'], array_merge($result, array('product_href' => $product_href)));
				// end silenko 2016-05-09
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
					'filters'			=> $this->model_catalog_product_filters->getProductFilters($result['product_id']),
					'category_modal'	=> $category_product_modal,
				);
			}



			$url = '';

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['sorts'] = array();

			$data['sorts'][] = array(
				'text'  => "По новинкам",
				'value' => 'p.date_added-DESC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.date_added&order=DESC' . $url . (isset($this->request->get['price']) ? '&price=' . $this->request->get['price'] : ''))
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_default'),
				'value' => 'p.sort_order-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.sort_order&order=ASC' . $url . (isset($this->request->get['price']) ? '&price=' . $this->request->get['price'] : ''))
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_name_asc'),
				'value' => 'pd.name-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=pd.name&order=ASC' . $url . (isset($this->request->get['price']) ? '&price=' . $this->request->get['price'] : ''))
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_name_desc'),
				'value' => 'pd.name-DESC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=pd.name&order=DESC' . $url . (isset($this->request->get['price']) ? '&price=' . $this->request->get['price'] : ''))
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_price_asc'),
				'value' => 'p.price-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.price&order=ASC' . $url . (isset($this->request->get['price']) ? '&price=' . $this->request->get['price'] : ''))
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_price_desc'),
				'value' => 'p.price-DESC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.price&order=DESC' . $url . (isset($this->request->get['price']) ? '&price=' . $this->request->get['price'] : ''))
			);

			if ($this->config->get('config_review_status')) {
				$data['sorts'][] = array(
					'text'  => $this->language->get('text_rating_desc'),
					'value' => 'rating-DESC',
					'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=rating&order=DESC' . $url . (isset($this->request->get['price']) ? '&price=' . $this->request->get['price'] : ''))
				);

				$data['sorts'][] = array(
					'text'  => $this->language->get('text_rating_asc'),
					'value' => 'rating-ASC',
					'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=rating&order=ASC' . $url . (isset($this->request->get['price']) ? '&price=' . $this->request->get['price'] : ''))
				);
			}

			// $data['sorts'][] = array(
			// 	'text'  => $this->language->get('text_model_asc'),
			// 	'value' => 'p.model-ASC',
			// 	'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.model&order=ASC' . $url . (isset($this->request->get['price']) ? '&price=' . $this->request->get['price'] : ''))
			// );

			// $data['sorts'][] = array(
			// 	'text'  => $this->language->get('text_model_desc'),
			// 	'value' => 'p.model-DESC',
			// 	'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.model&order=DESC' . $url . (isset($this->request->get['price']) ? '&price=' . $this->request->get['price'] : ''))
			// );

			$url = '';

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			$data['limits'] = array();

			$limits = array_unique(array($this->config->get('config_product_limit'), 25, 50, 75, 100));

			sort($limits);

			foreach($limits as $value) {
				$data['limits'][] = array(
					'text'  => $value,
					'value' => $value,
					'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&limit=' . $value . (isset($this->request->get['price']) ? '&price=' . $this->request->get['price'] : ''))
				);
			}

			$url = '';

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$pagination = new Pagination();
			$pagination->total = $product_total;
			$pagination->page = $page;
			$pagination->limit = $limit;
			$pagination->url = $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&page={page}' . (isset($this->request->get['price']) ? '&price=' . $this->request->get['price'] : ''));

			$data['pagination'] = $pagination->render();

			$data['results'] = sprintf($this->language->get('text_pagination'), ($product_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($product_total - $limit)) ? $product_total : ((($page - 1) * $limit) + $limit), $product_total, ceil($product_total / $limit));

			// http://googlewebmastercentral.blogspot.com/2011/09/pagination-with-relnext-and-relprev.html
			if ($page == 1) {
				$this->document->addLink($this->url->link('product/category', 'path=' . $category_info['category_id'], 'SSL'), 'canonical');
			} elseif ($page == 2) {
				$this->document->addLink($this->url->link('product/category', 'path=' . $category_info['category_id'], 'SSL'), 'prev');
			} else {
				$this->document->addLink($this->url->link('product/category', 'path=' . $category_info['category_id'] . '&page='. ($page - 1), 'SSL'), 'prev');
			}

			if ($limit && ceil($product_total / $limit) > $page) {
				$this->document->addLink($this->url->link('product/category', 'path=' . $category_info['category_id'] . '&page='. ($page + 1), 'SSL'), 'next');
			}

/*
			if($category_info['category_id'] == 65){
				$key = $last_modified_key; // . '-' . date("d M Y H:i:s")
				$date = date("D, d M Y H:i:s") . " GMT";
				$page_data = $this->config->get("config_special_" . $page);
				if(!$page_data){
					//$this->config->set("config_special_" . $page, $key . '-' . $date);
					$this->db->query("INSERT INTO " . DB_PREFIX . "setting SET store_id = '0', `code` = 'config', `key` = '" . $this->db->escape("config_special_" . $page) . "', `value` = '" . $this->db->escape($key . '-' . $date)  . "'");
					$page_data = $key . '-' . $date;
				}
				// if(isset($this->request->get['test'])){
				// 	echo '<pre>';
				// 	echo $this->config->get("config_special_" . $page) . PHP_EOL;
				// 	echo $date;
				// 	echo '</pre>';
				// }
				$page_data = explode("-",$page_data);
				$cache_page = explode("-",$this->config->get("config_special_" . $page));
				if($cache_page[0] != $key){
					$this->db->query("UPDATE " . DB_PREFIX . "setting SET `value` = '" . $this->db->escape($key . '-' . $date) . "', serialized = '0'  WHERE `code` = 'config' AND `key` = '" . $this->db->escape("config_special_" . $page) . "' AND store_id = '0'");



					// $timestamp = strtotime($date_modified);
					// $LastModified_unix = $timestamp; // время последнего изменения страницы
					// $LastModified = gmdate("D, d M Y H:i:s \G\M\T", $LastModified_unix);
					// $IfModifiedSince = false;
					// if (isset($_ENV['HTTP_IF_MODIFIED_SINCE']))
					// $IfModifiedSince = strtotime(substr($_ENV['HTTP_IF_MODIFIED_SINCE'], 5));
					// if (isset($_SERVER['HTTP_IF_MODIFIED_SINCE']))
					// $IfModifiedSince = strtotime(substr($_SERVER['HTTP_IF_MODIFIED_SINCE'], 5));
					// if ($IfModifiedSince && $IfModifiedSince >= $LastModified_unix) {
					// 	header($_SERVER['SERVER_PROTOCOL'] . ' 304 Not Modified');
					// 	exit;
					// }
					$this->response->addHeader('Last-Modified: '. $date);
				} else{
					//$this->response->addHeader($_SERVER['SERVER_PROTOCOL'] . ' 304 Not Modified');
				 	$this->response->addHeader('Last-Modified: '. $cache_page[1]);
				}
			}
			*/
			$data['sort'] = $sort;
			$data['order'] = $order;
			$data['limit'] = $limit;

			$data['continue'] = $this->url->link('common/home');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');


			if ($category_id == 63) {
				return $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/product/novelty.tpl', $data));
			}

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/category.tpl')) {
				$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/product/category.tpl', $data));
			} else {
				$this->response->setOutput($this->load->view('default/template/product/category.tpl', $data));
			}
		} else {
			$url = '';

			if (isset($this->request->get['path'])) {
				$url .= '&path=' . $this->request->get['path'];
			}

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_error'),
				'href' => $this->url->link('product/category', $url)
			);

			$this->document->setTitle($this->language->get('text_error'));

			$data['heading_title'] = $this->language->get('text_error');

			$data['text_error'] = $this->language->get('text_error');

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
				$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/error/not_found.tpl', $data));
			} else {
				$this->response->setOutput($this->load->view('default/template/error/not_found.tpl', $data));
			}
		}
	}

}
