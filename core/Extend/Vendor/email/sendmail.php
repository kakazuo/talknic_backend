<?php
    //Author ：XuLiang
	//WebSite：http://www.sunchis.com  
	//$mailTo：是一个数组，表示收件人地址 和收件人姓名，格式为array('邮箱地址','姓名') 
	//$subject 表示邮件标题 
	//$body  ：表示邮件正文 
	//$AddAttachment 附件地址 
	//error_reporting(E_ALL); 
	//www.sunchis.com
	function sendmail_sunchis_com($mailTo,$subject,$body,$AddAttachment){
		if(count($mailTo)==0){ 
			echo "收件人不能为空！已退出发送邮件……"; 
			exit(); 
		} 
		
		error_reporting(E_STRICT); 
		date_default_timezone_set("Asia/Shanghai"); //设定时区东八区
		require_once('class.phpmailer.php'); 
		include_once("class.smtp.php");
		$mail             = new PHPMailer();        //new一个PHPMailer对象出来 
		$body             = eregi_replace("[\]",'',$body); //对邮件内容进行必要的过滤
		$mail->CharSet    = "UTF-8";                //设定邮件编码，默认ISO-8859-1，如果发中文此项必须设置，否则乱码 
		$mail->IsSMTP();                            // 设定使用SMTP服务 
		$mail->SMTPDebug  = 1;                      // 启用SMTP调试功能 
													// 1 = errors and messages 
													// 2 = messages only 
		$mail->SMTPAuth   = true;                   // 启用 SMTP 验证功能
		//$mail->SMTPSecure = "ssl";                // 安全协议
       
        $mail->Host       = "smtp.sina.com";          // SMTP 服务器
        $mail->Port       = 25;                     // SMTP服务器的端口号
        $mail->Username   = "maopan1@sina.com";    // SMTP服务器用户名
        $mail->Password   = "xiaoxian1069";        	// SMTP服务器密码

		$mail->SetFrom('maopan1@sina.com', 'Talknic');
		$mail->AddReplyTo("maopan1@sina.com","Talknic");
		$mail->Subject    = $subject; 
		$mail->AltBody    = "To view the message, please use an HTML compatible email viewer! - From www.sunchis.com"; // optional, comment out and test 
        $mail->MsgHTML($body);
		
		foreach($mailTo as $k => $v){ 
			$mail->AddAddress($mailTo[$k][0], $mailTo[$k][1]);
		} 
		 
		if(count($AddAttachment) > 0){ 
			foreach($AddAttachment as $k => $AttachmentAddress){
				$mail->AddAttachment($AttachmentAddress); 
			} 
		}
		if(!$mail->Send()) { 
			return "ERROR:" . $mail->ErrorInfo;
		}else { 
			return true;
		}
} 
 

?>