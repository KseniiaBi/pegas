<?php

class ControllerCommonAjaxHandler extends Controller {
	public function index() {

		$headers  = "Content-type: text/html; charset=utf-8 \r\n";
		$to = $this->config->get('config_email');
		if(isset($_POST['form']) && $_POST['form'] == 'Форма: сообщить об ошибке') {

			$email = $_POST['email'];
			$text = $_POST['text'];
			$headers .= $_POST['form'];

			$subject = "Форма обратной связи";
			$message = "Форма: сообщить об ошибке<br/> Мой email: ".$email."<br/> Мое обращение: ".$text;
			//  mail($to, $subject, $message, $headers);
			$mail = new Mail();
			$mail->protocol = $this->config->get('config_mail_protocol');
			$mail->parameter = $this->config->get('config_mail_parameter');
			$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
			$mail->smtp_username = $this->config->get('config_mail_smtp_username');
			$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
			$mail->smtp_port = $this->config->get('config_mail_smtp_port');
			$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');


			$mail->setTo($to);
			//	$mail->setFrom($this->config->get('config_email'));
			$mail->setFrom($this->config->get('config_mail_smtp_username'));
			$mail->setSender("PEGAS");
			$mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
			$mail->setHtml($message);
			//$mail->setText($text);
			$mail->send();
		}

		if(isset($_POST['form']) && $_POST['form'] == 'Форма: обратный звонок') {

			$phone = $_POST['phone'];
			$headers .= $_POST['form'];

			$subject = "Форма обратной связи";
			$message = "Форма: обратный звонок<br/> Мой телефон: ".$phone;
			// mail($to, $subject, $message, $headers);
			$mail = new Mail();
			$mail->protocol = $this->config->get('config_mail_protocol');
			$mail->parameter = $this->config->get('config_mail_parameter');
			$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
			$mail->smtp_username = $this->config->get('config_mail_smtp_username');
			$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
			$mail->smtp_port = $this->config->get('config_mail_smtp_port');
			$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');


			$mail->setTo($to);
			//	$mail->setFrom($this->config->get('config_email'));
			$mail->setFrom($this->config->get('config_mail_smtp_username'));
			$mail->setSender("PEGAS");
			$mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
			$mail->setHtml($message);
			//$mail->setText($text);
			$mail->send();
		}

		if(isset($_POST['form']) && $_POST['form'] == 'Форма: быстрый заказ в карточке товара') {

			$phone = $_POST['phone'];
			$url = $_POST['url'];
			$headers .= $_POST['form'];

			$subject = "Форма обратной связи";
			$message = "Форма: быстрый заказ в карточке товара<br/> Мой телефон: ".$phone."<br/> Товар, который хотелось бы приобрести: ".$url;
			// mail($to, $subject, $message, $headers);
			$mail = new Mail();
			$mail->protocol = $this->config->get('config_mail_protocol');
			$mail->parameter = $this->config->get('config_mail_parameter');
			$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
			$mail->smtp_username = $this->config->get('config_mail_smtp_username');
			$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
			$mail->smtp_port = $this->config->get('config_mail_smtp_port');
			$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');


			$mail->setTo($to);
			//	$mail->setFrom($this->config->get('config_email'));
			$mail->setFrom($this->config->get('config_mail_smtp_username'));
			$mail->setSender("PEGAS");
			$mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
			$mail->setHtml($message);
			//$mail->setText($text);
			$mail->send();
		}

		if(isset($_POST['form']) && $_POST['form'] == 'Форма: подписаться на новости') {

			$email = $_POST['mail'];
			$headers .= $_POST['form'];

			$subject = "Форма обратной связи";
			$message = "Форма: подписаться на новости<br/> Мой электронный адресс: ".$email;
			// mail($to, $subject, $message, $headers);
			$mail = new Mail();
			$mail->protocol = $this->config->get('config_mail_protocol');
			$mail->parameter = $this->config->get('config_mail_parameter');
			$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
			$mail->smtp_username = $this->config->get('config_mail_smtp_username');
			$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
			$mail->smtp_port = $this->config->get('config_mail_smtp_port');
			$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');


			$mail->setTo($to);
			//	$mail->setFrom($this->config->get('config_email'));
			$mail->setFrom($this->config->get('config_mail_smtp_username'));
			$mail->setSender("PEGAS");
			$mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
			$mail->setHtml($message);
			//$mail->setText($text);
			$mail->send();
		}



	}
}
