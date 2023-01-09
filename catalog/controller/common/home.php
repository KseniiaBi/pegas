<?php
class ControllerCommonHome extends Controller {
	public function index() {
		$this->document->setTitle($this->config->get('config_meta_title'));
		$this->document->setDescription($this->config->get('config_meta_description'));
		$this->document->setKeywords($this->config->get('config_meta_keyword'));

		if (isset($this->request->get['route'])) {
			$this->document->addLink(HTTP_SERVER, 'canonical');
		}

		$this->load->model('catalog/category');

		$this->load->model('module/filters');

		$where_category = " 1 AND afv.`attribute_id`='14' ";

		$query_rows = $this->model_module_filters->getAttributes($where_category, false);

		$results = array();
		
            foreach ($query_rows as $column) {
                $attr_text = $column['seo_url'];

                $name = ($column['text']);
                $href = $this->url->link('product/category', 'category_id=60').'/vik_'. $attr_text.'/';

                $results[] = array(
                	'name' => $name,
                	'href' => $href
                );
            }

        $data['filters'] = $results;

		$data['literature_catalog_filters'] = $this->model_catalog_category->getCategoryFilters(60);

		$filters_count = count($data['literature_catalog_filters']);
		while ($filters_count--) {
			$filters_count2 = count($data['literature_catalog_filters'][$filters_count]['filter']);
			while ($filters_count2--) {
				$data['literature_catalog_filters'][$filters_count]['filter'][$filters_count2]['filter_link'] = $this->url->link('product/category', 'path=60&filter=' .
					$data['literature_catalog_filters'][$filters_count]['filter'][$filters_count2]['filter_id']
					);
			}
		}

		$data['literature_catalog_link'] = $this->url->link('product/category', 'path=60');
		$data['text_discount_and_bonus'] = $this->language->get('text_discount_and_bonus');
		$data['text_ecologically_clear'] = $this->language->get('text_ecologically_clear');
		$data['text_gifts_to_every_order'] = $this->language->get('text_gifts_to_every_order');
		$data['text_gift_selection'] = $this->language->get('text_gift_selection');
		$data['text_gift_selection2'] = $this->language->get('text_gift_selection2');
		$data['text_book_by_age'] = $this->language->get('text_book_by_age');
		$data['text_book_by_age2'] = $this->language->get('text_book_by_age2');
		$data['text_to_catalog'] = $this->language->get('text_to_catalog');
		$data['text_for_all'] = $this->language->get('text_for_all');
		$data['text_any'] = $this->language->get('text_any');
		$data['text_any2'] = $this->language->get('text_any2');
		$data['text_price'] = $this->language->get('text_price');
		$data['text_from'] = $this->language->get('text_from');
		$data['text_to'] = $this->language->get('text_to');
		$data['text_pick'] = $this->language->get('text_pick');

		// silenko 2016-05-17 / main banner
		$this->load->model('design/banner');
		$data['banners'] = array();
		$results = $this->model_design_banner->getBanner(7);
		foreach ($results as $result) {
			if (is_file(DIR_IMAGE . $result['image_'.$this->config->get('config_language_id')])) {
				$data['banners'][] = array(
					'title' => $result['title'],
					'link'  => $result['link'],
					'image' => $result['image_'.$this->config->get('config_language_id')],
				);
			}
		}

		// silenko 2016-05-17 / main page content
		$this->load->model('catalog/information');

		$main_page_content = $this->model_catalog_information->getInformation(10);
		$data['main_page_content'] = '';
		if ($main_page_content) {
			$data['main_page_content'] = html_entity_decode($main_page_content['description'], ENT_QUOTES, 'UTF-8');
		}

		$main_page_content2 = $this->model_catalog_information->getInformation(11);
		$data['main_page_content2'] = '';
		if ($main_page_content2) {
			$data['main_page_content2'] = html_entity_decode($main_page_content2['description'], ENT_QUOTES, 'UTF-8');
		}

		$main_page_content3 = $this->model_catalog_information->getInformation(12);
		$data['main_page_content3'] = '';
		if ($main_page_content3) {
			$data['main_page_content3'] = html_entity_decode($main_page_content3['description'], ENT_QUOTES, 'UTF-8');
		}


		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		$data['maxPriceFilter'] = $this->model_catalog_category->getMaxProductPrice();
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/home.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/common/home.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/common/home.tpl', $data));
		}
	}
}
