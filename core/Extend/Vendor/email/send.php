<?php
class send{
	public function go($to,$subject,$body,$is_alert=0){
		if(!is_array($to)){
			$tmp = explode(',',$to);
			foreach($tmp as $v){
				$mailTo[][] = $v;
			}
		}else{
			$mailTo = $to;
		}
		include 'sendmail.php';
		$AddAttachment = array();
		$mailResult = sendmail_sunchis_com($mailTo,$subject,$body,$AddAttachment);
		if($is_alert > 0 ){
			echo "<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />";
			if($mailResult === true){
				return 2;
			}else{
				return 3;
			}
		}else{
			return $mailResult;
		}
	}
}
