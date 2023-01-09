<?php
class ModelModuleFilters extends Model {
    public function getAttributes($where_category,$tag_id=false)
    {
        $poles = " agd.`attribute_group_id`,agd.`name` AS name_group,afv.`attribute_id`,ad.`name`,afvl.`text` ";
        $poles .= ", (SELECT `seo_url` FROM " . DB_PREFIX . "url_filter_vier ufv WHERE key_param = CONCAT('attrb_',afv.attr_text)) AS seo_url ";
        $poles .= ",afv.`attr_text`,afv.`text_id` ";
        $where = null;
        $where .= " WHERE " . $where_category . " ";
        $where .= " AND afvl.`language_id`=" . $this->config->get('config_language_id') . " ";
        $where .= " AND ad.`language_id`=" . $this->config->get('config_language_id') . " ";
        $where .= " AND agd.`language_id`=" . $this->config->get('config_language_id') . " ";
        $query_str = "SELECT " . $poles . " FROM `" . DB_PREFIX . "attribute_filter_vier` afv ";
        $query_str .= " JOIN `" . DB_PREFIX . "product` p ON(afv.`product_id`=p.`product_id`)";
        $query_str .= " JOIN `" . DB_PREFIX . "attribute_filter_vier_lang` afvl ON(afv.`attr_text`=afvl.`attr_text`)";

        $query_str .= " JOIN `" . DB_PREFIX . "product_to_category` p2c ON(p2c.`product_id`=p.`product_id`)";
  
        $query_str .= " LEFT JOIN `" . DB_PREFIX . "attribute` a ON(afv.`attribute_id`=a.`attribute_id`) LEFT JOIN `" . DB_PREFIX . "attribute_description` ad ON(a.`attribute_id`=ad.`attribute_id`)LEFT JOIN `" . DB_PREFIX . "attribute_group_description` agd ON(a.`attribute_group_id`=agd.`attribute_group_id`) LEFT JOIN `" . DB_PREFIX . "attribute_group` ag ON(agd.`attribute_group_id`=ag.`attribute_group_id`)";

        $query_str .= " " . $where . " ";
        $query_str .= " GROUP BY afv.`attribute_id`,afv.`attr_text` ";
        $query_str .= " ORDER BY ag.`sort_order`,a.`sort_order`,ad.`name`,(afvl.`text`+0),afvl.`text`";

        $query = $this->db->query($query_str);

        return $query->rows;
    }
}