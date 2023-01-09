<?php
// author:	Silenko Alexander
// date:	2016-04-27
class ModelCatalogProductFilters extends Model {
	public function getProductFilters($product_id) {
		$query = $this->db->query("SELECT fg.`filter_group_id`, f.`filter_id`, fgd.`name`, fd.`name` AS `value`, fg.`sort_order` FROM `" . DB_PREFIX . "product_filter` pf
									LEFT JOIN `" . DB_PREFIX . "filter` f ON (pf.filter_id = f.filter_id)
									LEFT JOIN `" . DB_PREFIX . "filter_description` fd ON (fd.filter_id = f.filter_id AND fd.language_id = '" . (int)$this->config->get('config_language_id') . "')
									LEFT JOIN `" . DB_PREFIX . "filter_group` fg ON (f.filter_group_id = fg.filter_group_id)
									LEFT JOIN `" . DB_PREFIX . "filter_group_description` fgd ON (fgd.filter_group_id = fg.filter_group_id AND fgd.language_id = '" . (int)$this->config->get('config_language_id') . "')
									WHERE product_id = '" . (int)$product_id . "'
									ORDER BY fg.`sort_order` ASC");

		return $query->rows;
	}
}