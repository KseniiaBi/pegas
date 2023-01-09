<?php
class ControllerProductReserve extends Controller {
    function addReserve(){
      if($this->request->post['email']){
        $product_id = $this->request->post['productId'];
        $option_id = $this->request->post['optionId'];
        $email = $this->request->post['email'];
        $language = $this->session->data['language'] == "ua" ? 3 : 2;
        $this->db->query("INSERT INTO  " . DB_PREFIX . "reserve SET product_id = '". (int)$this->db->escape($product_id) ."',option_id = '". (int)$this->db->escape($option_id) ."',email = '" . $this->db->escape($email) . "',language = '" . (int)$this->db->escape($language) . "'");
        $json = true;
      }else{
        $json = false;
      }

      $this->response->addHeader('Content-Type: application/json');
  		$this->response->setOutput(json_encode($json));
    }
}
?>
