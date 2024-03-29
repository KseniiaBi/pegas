<?php
class ControllerModuleBanner extends Controller {
	public function index($setting) {
		static $module = 0;

		$this->load->model('design/banner');
		$this->load->model('tool/image');
//
//		$this->document->addStyle('catalog/view/javascript/jquery/owl-carousel/owl.carousel.css');
//		$this->document->addStyle('catalog/view/javascript/jquery/owl-carousel/owl.transitions.css');
//		$this->document->addScript('catalog/view/javascript/jquery/owl-carousel/owl.carousel.min.js');

		$data['banners'] = array();

		$results = $this->model_design_banner->getBanner($setting['banner_id']);

		foreach ($results as $result) {
			if (is_file(DIR_IMAGE . $result['image_'.$this->config->get('config_language_id')])) {
				$data['banners'][] = array(
					'title' => $result['title'],
					'description' => $result['description'],
					'link'  => $result['link'],
					'image' => $this->model_tool_image->resize($result['image_'.$this->config->get('config_language_id')], $setting['width'], $setting['height'])
				);
			}
		}

		$data['module'] = $module++;

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/banner.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/module/banner.tpl', $data);
		} else {
			return $this->load->view('default/template/module/banner.tpl', $data);
		}
	}
}