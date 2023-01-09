<?php
/**
 * Created by ANH To <anh.to87@gmail.com>.
 * User: baoan
 * Date: 11/8/15
 * Time: 00:23
 */

class ControllerModuleAdvancedNewsletter extends Controller
{
    public function index($setting)
    {
        $this->load->language('module/advanced_newsletter');

        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_button_submit'] = $this->language->get('text_button_submit');
        $data['text_placeholder_input'] = $this->language->get('text_placeholder_input');
        if ($this->config->get('advanced_newsletter_display_as') == 'popup')
        {
            $template = 'advanced_newsletter_popup';
        }
        else
        {
            $template = 'advanced_newsletter_box';
        }
        return $this->load->view('default/template/module/'.$template.'.phtml', $data);
    }
}