<?php
class ControllerFeedUnixmlSaver extends Controller {

  public function index() {

    set_time_limit(0);
    ini_set('max_execution_time', 3600);
    ini_set('memory_limit', '1G');

    $this->load->model('catalog/category');
    $this->load->model('catalog/product');
    $this->load->model('catalog/manufacturer');
    $this->load->model('tool/image');

    $this->language->load('feed/unixml');

    //configs
    $unixml_rozetka_status = $this->config->get('unixml_rozetka_status');
    $unixml_rozetka_name = $this->config->get('unixml_rozetka_name');
    $unixml_rozetka_language = $this->db->query("SELECT language_id FROM " . DB_PREFIX . "language WHERE code = '" . $this->config->get('unixml_rozetka_language') . "'")->row['language_id'];
    $unixml_rozetka_option_multiplier_status = $this->config->get('unixml_rozetka_option_multiplier_status');
    $unixml_rozetka_option_multiplier_id = $this->config->get('unixml_rozetka_option_multiplier_id');
    $unixml_rozetka_categories = $this->config->get('unixml_rozetka_categories');
    $unixml_rozetka_manufacturers = $this->config->get('unixml_rozetka_manufacturers');

    //custom nik
    if($this->config->get('unixml_rozetka_products')){
      $unixml_rozetka_categories_query_array = array();
      $unixml_rozetka_categories_query = $this->db->query("SELECT category_id FROM " . DB_PREFIX . "product_to_category WHERE product_id IN (" . $this->db->escape($this->config->get('unixml_rozetka_products')) . ") GROUP BY category_id");

      if($unixml_rozetka_categories_query->num_rows){
        foreach($unixml_rozetka_categories_query->rows as $unixml_rozetka_categories_query_row){
          $unixml_rozetka_categories_query_array[$unixml_rozetka_categories_query_row['category_id']] = $unixml_rozetka_categories_query_row['category_id'];
        }
        $unixml_rozetka_categories = implode(",", $unixml_rozetka_categories_query_array);
      }

      $unixml_rozetka_manufacturers_query_array = array();
      $unixml_rozetka_manufacturers_query = $this->db->query("SELECT manufacturer_id FROM " . DB_PREFIX . "product WHERE product_id IN (" . $this->db->escape($this->config->get('unixml_rozetka_products')) . ") GROUP BY manufacturer_id");
      if($unixml_rozetka_manufacturers_query->num_rows){
        foreach($unixml_rozetka_manufacturers_query->rows as $unixml_rozetka_manufacturers_query_row){
          $unixml_rozetka_manufacturers_query_array[$unixml_rozetka_manufacturers_query_row['manufacturer_id']] = $unixml_rozetka_manufacturers_query_row['manufacturer_id'];
        }
        $unixml_rozetka_manufacturers = implode(",", $unixml_rozetka_manufacturers_query_array);
      }

    }
    //custom nik

    $unixml_rozetka_genname = $this->config->get('unixml_rozetka_genname');
    $unixml_rozetka_replacename = $this->getReplaceNameList();
    $unixml_rozetka_additional_params = $this->getAdditionalParamList();
    $unixml_rozetka_attributes = $this->getAttributeList();
    //configs

    if ($unixml_rozetka_status) {
      $category_query = $this->getCategories($unixml_rozetka_categories,$unixml_rozetka_language);
      $products_query = $this->getProducts($unixml_rozetka_categories,$unixml_rozetka_manufacturers,$unixml_rozetka_language);

      $categories = $this->formCategories($category_query);
      $products = $this->formProducts($products_query,$unixml_rozetka_additional_params,$unixml_rozetka_language,$unixml_rozetka_option_multiplier_status,$unixml_rozetka_option_multiplier_id);

      $products = $this->generateNames($products,$unixml_rozetka_genname);

      $products = $this->replaceNames($products,$unixml_rozetka_replacename);

      $products = $this->prepareDescription($products);
      // echo '<pre>';
      // print_r($products);
      // echo '</pre>';
      // exit();

      $xml  = '<?xml version="1.0" encoding="UTF-8"?>';
      // $xml .= '<!DOCTYPE yml_catalog>';
      // $xml .= '<yml_catalog date="' . date('Y-m-d H:i', time()) . '">';
      $xml .= '<shop>';
      $xml .= '<name>' . $unixml_rozetka_name . '</name>';
      $xml .= '<company>' . $unixml_rozetka_name . '</company>';
      $xml .= '<platform>Opencart</platform>';
      $xml .= '<url>' . HTTPS_SERVER . '</url>';
      $xml .= '<currencies>';
      $xml .= '<currency id="UAH" rate="1"/>';
      $xml .= '</currencies>';

      if($categories) {
        $xml .= '<categories>';
        foreach($categories as $category) {
          if($category['parent_id']){
            $xml .= '<category id="' . $category['category_id'] .'" parentId="' . $category['parent_id'] . '">' . $category['name'] .'</category>';
          } else{
            $xml .= '<category id="' . $category['category_id'] .'">' . $category['name'] .'</category>';
          }
        }
        $xml .= '</categories>';
      }

      if($products){
        $xml .= '<offers>';
        foreach($products as $index=>$product){
          $xml .= '<offer id="' . $index . '-' . $product['product_id'] . '" available="true">';
          $xml .= '<url>' . $product['url'] .  '</url>';
          $xml .= '<price>' . $product['price'] .  '</price>';
          $xml .= '<currencyId>' . $product['currencyId'] .  '</currencyId>';
          $xml .= '<categoryId>' . $product['categoryId'] .  '</categoryId>';
          if($product['image']){
            $xml .= '<picture>' . $product['image'] .  '</picture>';
          }

          foreach($product['images'] as $image){
          $xml .= '<picture>' . $image .  '</picture>';
          }
          $xml .= '<ISBN>' . $product['code'] . '</ISBN>';
          $xml .= '<vendor>' . $product['manufacturer'] .  '</vendor>';
          $xml .= '<stock_quantity>' . $product['quantity'] .  '</stock_quantity>';
          $xml .= '<name>' . $product['name'] .  '</name>';
          $xml .= '<description>' . $product['description'] .  '</description>';
          foreach($product['attributes'] as $attribute){
            $xml .= '<param name="' . $attribute['name'] . '">' . $attribute['text'] .  '</param>';
          }
          $xml .= '</offer>';
        }
        $xml .= '</offers>';
      }

      $xml .= '</shop>';
      // $xml .= '</yml_catalog>';
     // $this->response->addHeader('Content-Type: application/xml');
     // $this->response->setOutput($xml);

      $outPutYml=$xml;
      $filePath='market.xml';
      if(isset($this->request->get['turbo'])) $filePath=DIR_ROOT.'turbo_pages/yandex_turbo_sgraf'.intval($this->request->get['start']).'.xml';
      $fp = fopen($filePath, 'w');
      fwrite($fp, $outPutYml);
      fclose($fp);

    }  else {

      $this->response->setOutput("");
    }
  }


  private function formProducts($products_query,$additional_params,$lang,$multiply_options_status,$multiply_options_id){
    $products = array();

    foreach($products_query as $product){

      if($multiply_options_status) {
        $options = $this->db->query("SELECT ovd.name as value, od.name, pov.price_prefix, pov.price, pov.code FROM " . DB_PREFIX . "option_description od INNER JOIN " . DB_PREFIX . "option_value_description " .
        "ovd ON (od.option_id = ovd.option_id) INNER JOIN " . DB_PREFIX . "product_option_value pov ON (pov.option_value_id = ovd.option_value_id) WHERE pov.product_id = '" . $product['product_id'] . "' AND ovd.language_id = '" . $lang . "' AND od.language_id = '" . $lang . "' AND pov.option_id = '" . $multiply_options_id  . "'");

        if($options->num_rows){
          foreach($options->rows as $row){
            $item = $this->formProduct($product,$additional_params,$lang);
            if($row['price_prefix'] == '+'){
              $item['price'] += $row['price'];
            } elseif($row['price_prefix'] == '-'){
              $item['price'] -= $row['price'];
            }
            $item['code'] = $row['code'];
            $item['attributes'][] = array(
              'name' => $row['name'],
              'text' => $row['value']
            );
            $products[] = $item;
          }
        } else{
          $item = $this->formProduct($product,$additional_params,$lang);
          $products[] = $item;
        }
      } else{

        $item = $this->formProduct($product,$additional_params,$lang);
        $products[] = $item;
      }
    }

    return $products;
  }

  private function formProduct($product,$additional_params,$lang){
    $item = array();
    $item['product_id'] = $product['product_id'];
    $item['url'] = $this->url->link('product/product', 'product_id=' . (int) $product['product_id']);
    $item['currencyId'] = 'UAH';
    $item['categoryId'] = $product['category_id'];
    $item['price'] = $product['price'];
    $item['sku'] = $product['sku'];
    $item['manufacturer'] = $product['manufacturer'];
    $item['model'] = $product['model'];
    $item['name'] = $product['name'];
    $item['code'] = $product['code'];
    $item['description'] = $product['description'];
    if(isset($product['image']) && $product['image'] != ''){
        $item['image'] = HTTPS_SERVER . 'image/' . $product['image'];
    } else{
        $item['image'] = '';
    }

    $item['quantity'] = $product['quantity'];
    $item['weight'] = $product['weight'];
    $item['type'] = '';
    $item['size'] = '';
    $item['color'] = '';
    $item['attributes'] = array();
    $product_attributes = $this->db->query("SELECT pa.attribute_id,pa.text,ura.rozetka_name FROM " . DB_PREFIX . "product_attribute pa INNER JOIN " . DB_PREFIX . "unixml_rozetka_attributes ura ON (ura.attribute_id = pa.attribute_id AND ura.language_id = pa.language_id) WHERE product_id ='" . $product['product_id'] . "' ");
    // echo '<pre>';
    // print_r($product_attributes);
    // echo '</pre>';
    foreach($product_attributes->rows as $p_attribute){
      $item['attributes'][] = array(
        'name'  => $p_attribute['rozetka_name'],
        'text'  => $p_attribute['text']
      );
    }

    foreach($additional_params as $attr){
      $item['attributes'][] = array(
        'name'  => $attr['param_name'],
        'text'  => $attr['param_text']
      );
    }

    $item['images'] = array();
    $product_image_query = $this->db->query("SELECT image FROM " . DB_PREFIX . "product_image WHERE product_id = '" . $item['product_id'] . "'");
    if($product_image_query->num_rows){
      foreach($product_image_query->rows as $image){
        $item['images'][] = HTTPS_SERVER . 'image/' . $image['image'];
      }
    }

    return $item;
  }

  private function formCategories($category_query){
    $categories = array();

    foreach($category_query as $cat){
      $categories[] = array(
        'category_id' => $cat['category_id'],
        'name'        => $cat['name'],
        'parent_id'   => $cat['parent_id']
      );
    }
    return $categories;
  }

  private function generateNames($products,$genname){
    $new_products = $products;
    if($genname){
      $from = array("{brand}", "{type}", "{sku}","{size}","{color}","{model}");
      foreach($new_products as &$product){
        $to = array($product['manufacturer'], $product['type'], $product['sku'],$product['size'],$product['color'],$product['model']);

        $product['name'] = trim(str_replace($from, $to, $genname));

      }
    }
    return $new_products;
  }

  private function prepareDescription($products){
    $new_products = $products;

    foreach($new_products as &$product){
      $product['description'] = $this->ymlTextPrepare($product['description']);
    }

    return $new_products;
  }
  private function replaceNames($products,$replace_array){
    $new_products = $products;

    if(!empty($replace_array)){
      $from = array_column($replace_array,'name_from');
      $to =   array_column($replace_array,'name_to');

      foreach($new_products as &$product){
        $product['name'] = str_replace($from, $to, $product['name']);
      }
    }
    return $new_products;
  }


  private function getProducts($allowed_categories, $allowed_manufacturers,$lang) {
    if($allowed_categories && $allowed_manufacturers){
      $sql = "SELECT p.*, ps.price as special,
      wcd.unit AS weight_unit, wcd.title AS weight_title,
      pd.name, pd.description, m.name AS manufacturer, p2c.category_id, p.price AS price, pd.image as image
      FROM " . DB_PREFIX . "product p
      JOIN " . DB_PREFIX . "product_to_category AS p2c ON (p.product_id = p2c.product_id)
      JOIN " . DB_PREFIX . "manufacturer m ON (p.manufacturer_id = m.manufacturer_id)
      LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id)
      LEFT JOIN " . DB_PREFIX . "weight_class_description wcd ON (p.weight_class_id = wcd.weight_class_id)
      LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id)
      LEFT JOIN " . DB_PREFIX . "product_special ps ON (p.product_id = ps.product_id)
      AND ps.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "'
      AND ps.date_start < NOW()
      AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())
      WHERE p2c.category_id IN (" . $this->db->escape($allowed_categories) . ")
      AND p.manufacturer_id IN (" . $this->db->escape($allowed_manufacturers) . ")
      AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'
      AND pd.language_id = '" . (int)$lang . "'
      AND p.status = '1'
      AND p.quantity > '0'
      GROUP BY p.product_id ORDER BY p.sort_order ASC";
      $query = $this->db->query($sql);

      if($this->config->get('unixml_rozetka_products')){
        $sql = "SELECT p.*, ps.price as special,
        wcd.unit AS weight_unit, wcd.title AS weight_title,
        pd.name, pd.description, m.name AS manufacturer, p2c.category_id, p.price AS price
        FROM " . DB_PREFIX . "product p
        JOIN " . DB_PREFIX . "product_to_category AS p2c ON (p.product_id = p2c.product_id)
        JOIN " . DB_PREFIX . "manufacturer m ON (p.manufacturer_id = m.manufacturer_id)
        LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id)
        LEFT JOIN " . DB_PREFIX . "weight_class_description wcd ON (p.weight_class_id = wcd.weight_class_id)
        LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id)
        LEFT JOIN " . DB_PREFIX . "product_special ps ON (p.product_id = ps.product_id)
        AND ps.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "'
        AND ps.date_start < NOW()
        AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())
        WHERE p.product_id IN (" . $this->db->escape($this->config->get('unixml_rozetka_products')) . ")
        AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'
        AND pd.language_id = '" . (int)$lang . "'
        AND p.status = '1'
        AND p.quantity > '0'
        GROUP BY p.product_id ORDER BY p.sort_order ASC";
        // print_r($sql);
        $query = $this->db->query($sql);
      }
      return $query->rows;
    }else{
      return array();
    }

  }

  private function getCategories($allowed_categories,$lang_id) {

    $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE c.category_id IN (" . $this->db->escape($allowed_categories) . ") AND cd.language_id = '" . $lang_id . "' AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND c.status = '1' ORDER BY c.sort_order, LCASE(cd.name)");

    return $query->rows;
  }

  private function getAttributeList(){
    $attributes = array();
    $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "unixml_rozetka_attributes");
    foreach($query->rows as $row){
      $attributes[] = array(
        'attribute_id'   => $row['attribute_id'],
        'language_id'    => $row['language_id'],
        'attribute_name' => $row['attribute_name'],
        'rozetka_name'   => $row['rozetka_name']
      );
    }
    return $attributes;
  }


  private function getAdditionalParamList(){
    $attributes = array();
    $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "unixml_rozetka_additional_params");
    foreach($query->rows as $row){
      $attributes[] = array(
        'param_name' => $row['param_name'],
        'param_text'   => $row['param_text']
      );
    }
    return $attributes;
  }

  private function getReplaceNameList(){
    $replace = array();
    $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "unixml_rozetka_replace_name");
    foreach($query->rows as $row){
      $replace[] = array(
        'name_from'   => $row['name_from'],
        'name_to'    => $row['name_to'],
      );
    }
    return $replace;
  }

  private function delete_duplicates_words($text){
    $text = implode(array_reverse(preg_split('//u', $text)));
    $text = preg_replace('/(\b[\pL0-9]++\b)(?=.*?\1)/siu', '', $text);
    $text = implode(array_reverse(preg_split('//u', $text)));
    return $text;
  }

  private function ymlTextPrepare($text){
    $text = htmlspecialchars_decode(trim($text));
    $text = strip_tags($text);
    $search = array('"', '&', '>', '<', '\'');
    $replace = array(' ', ' ', ' ', ' ', ' ');
    $text = str_replace($search, $replace, $text);
    $text = preg_replace('#[\x00-\x08\x0B-\x0C\x0E-\x1F]#is', ' ', $text);
    $str1= array("/nbsp;/","/quot;/","/amp;/","/bull;/","/apos;/","/laquo;/","/raquo;/","/rdquo;/","/ldquo;/",);
    $str2 = array(" "," "," "," "," "," "," "," "," ");
    $text = preg_replace($str1,$str2,$text);
    $text = str_replace("&nbsp;"," ", $text);
    return trim($text);
  }

  private function description($field) {
    $field = preg_replace('/[\x00-\x08\x10\x0B\x0C\x0E-\x19\x7F]'.
    '|[\x00-\x7F][\x80-\xBF]+'.
    '|([\xC0\xC1]|[\xF0-\xFF])[\x80-\xBF]*'.
    '|[\xC2-\xDF]((?![\x80-\xBF])|[\x80-\xBF]{2,})'.
    '|[\xE0-\xEF](([\x80-\xBF](?![\x80-\xBF]))|(?![\x80-\xBF]{2})|[\x80-\xBF]{3,})/S',
    '?', $field );

    $field = strip_tags($field);

    return trim($field);
  }

  protected function prepareField($field) {
    $field = htmlspecialchars_decode($field);
    if (strpos($field, '<![CDATA[') === 0) {
      return trim($field);
    }
    $field = strip_tags($field);
    $from = array('"', '&', '>', '<', '\'', '&nbsp;');
    $to = array('&quot;', '&amp;', '&gt;', '&lt;', '&apos;', ' ');
    $field = str_replace($from, $to, $field);

    $field = preg_replace('#[\x00-\x08\x0B-\x0C\x0E-\x1F]+#is', ' ', $field);

    return trim($field);
  }





}
