<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

function kirimNotifikasiTelegram($telegram_id, $message_text)
{
	$ci = get_instance();
	$url = "https://api.telegram.org/bot" .$ci->config->item('telegram_bot_token'). "/sendMessage?parse_mode=markdown&chat_id=" . $telegram_id;
	$url = $url . "&text=" . urlencode($message_text);
	$ch = curl_init();
	$optArray = array(
		CURLOPT_URL => $url,
		CURLOPT_RETURNTRANSFER => true
	);
	curl_setopt_array($ch, $optArray);
	$result = curl_exec($ch);
	$err = curl_error($ch);
	curl_close($ch);

	if ($err) {
		return $err;
	} else {
		return 'sukses';
	}
}
