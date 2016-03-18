<?php
// +----------------------------------------------------------------------
// | Talknic 移动应用软件接口说明
// +----------------------------------------------------------------------
// | provide by ：www.baiwushi.cn
// +----------------------------------------------------------------------
// | Author : CharlesW
// +----------------------------------------------------------------------
class ImplAction extends Action{
	public function index() {
		$domain = 'http://'.$_SERVER['HTTP_HOST'].'/Talknic1.0/admin.php/api/index?cmd=';
		$res = array(
			array('model'=>'发送验证码(注册)','cmd'=>1,'params'=>"<a href='$domain&tel=' target=_blank>&tel=</a>",'tips'=>'  2：已发送，3；发送失败，4：手机号已被占用','field'=>' '),
			array('model'=>'注册','cmd'=>2,'params'=>"<a href='$domain&tel=&captcha=&identity=' target=_blank>&tel=&captcha=&identity=</a>",'tips'=>' 2：成功，3 : 验证码错误，4：手机号已被占用，5：注册失败','field'=>' '),
			array('model'=>'登录','cmd'=>3,'params'=>"<a href='$domain&tel=&password=' target=_blank>&tel=&password=</a>",'tips'=>'2：成功,3：用户不存在,4：手机号尚未注册,5：首次登录成功,6：首次登录失败,7：登录失败','field'=>' '),
			array('model'=>'第三方登录','cmd'=>333,'params'=>"<a href='$domain&login_type=&unique_identification=' target=_blank>&identity=&login_type=&unique_identification=</a>",'tips'=>'2：成功,3:登陆失败（参数错误）,5：首次登录成功,<br/>(login_type=wechat,unique_identification=[openid])<br/>(login_type=sina,unique_identification=[uid])<br/>(首次登陆需要传identity参数 1：外教，0：学员,非首次登陆不传identity)','field'=>' '),
			array('model'=>'发送验证码(找回密码)','cmd'=>4,'params'=>"<a href='$domain&tel=' target=_blank>&tel=</a>",'tips'=>'  2：已发送，3；发送失败，4：手机号尚未注册','field'=>' '),
			array('model'=>'找回密码','cmd'=>5,'params'=>"<a href='$domain&tel=&captcha=&password=&repassword=' target=_blank>&tel=&captcha=&password=&repassword=</a>",'tips'=>' 2：成功，3：手机号或验证码错误，4：手机号尚未注册','field'=>' '),
			// array('model'=>'基本信息设置','cmd'=>6,'params'=>"<a href='$domain&user_id=&identity=&user_name=&user_sex=&user_level=&favorite=&nationality=&occupation=&biography=&condition_time=' target=_blank>&user_id=&identity=&user_name=&user_sex=&user_level=&favorite=&nationality=&occupation=&biography=&condition_time=</a>",'tips'=>' 2：成功，3：设置失败，4：用户名不能为空，5：图片上传错误，6：用户ID错误','field'=>' '),
			array('model'=>'上传头像','cmd'=>6,'params'=>"<a href='$domain&user_id=' target=_blank>&user_id=</a>",'tips'=>' 2：成功，3 : 失败，4：图片上传错误，5：用户ID错误，6：图片上传失败','field'=>' content '),
			array('model'=>'基本信息设置','cmd'=>7,'params'=>"<a href='$domain&user_id=&identity=&user_name=&user_sex=&user_level=&nationality=&occupation=&biography=' target=_blank>&user_id=&identity=&user_name=&user_sex=&user_level=&nationality=&occupation=&biography=</a>",'tips'=>' 2：成功，3 : 失败，4 ：用户ID错误','field'=>' content '),
			array('model'=>'匹配信息设置','cmd'=>8,'params'=>"<a href='$domain&user_id=&identity=&start_time=&end_time=&favorite=' target=_blank>&user_id=&identity=&start_time=&end_time=&favorite=</a>",'tips'=>' 2：成功，3 : 失败，4 ：用户ID错误','field'=>' content '),
			array('model'=>'设置银行卡信息','cmd'=>9,'params'=>"<a href='$domain&user_id=&number=&name=&validity=&ccv=' target=_blank>&user_id=&number=&name=&validity&ccv=</a>",'tips'=>' 2：成功，3 : 失败，4 ：用户ID错误，5 ：银行卡号已存在','field'=>' content '),
			array('model'=>'删除银行卡信息','cmd'=>901,'params'=>"<a href='$domain&bank_number=' target=_blank>&bank_number=</a>",'tips'=>' 2：成功，3 : 失败','field'=>' content '),
			array('model'=>'发现列表','cmd'=>10,'params'=>"<a href='$domain&discover=' target=_blank>&discover=</a>",'tips'=>' 2：成功，3 : 失败','field'=>' content '),
			array('model'=>'匹配功能','cmd'=>11,'params'=>"<a href='$domain&time=&favorite=' target=_blank>&time=&favorite=</a>",'tips'=>' 2：成功，3 : 失败','field'=>' content '),
			array('model'=>'邮箱验证码','cmd'=>12,'params'=>"<a href='$domain&email=' target=_blank>&email=</a>",'tips'=>'  2：已发送，3；发送失败，4：邮箱已注册','field'=>' content '),
			array('model'=>'邮箱注册','cmd'=>13,'params'=>"<a href='$domain&email=&captcha=&identity=' target=_blank>&email=&captcha=&identity=</a>",'tips'=>' 2：成功，3 : 验证码错误，4：邮箱已注册，5：注册失败','field'=>' '),
			array('model'=>'邮箱登录','cmd'=>14,'params'=>"<a href='$domain&email=&password=' target=_blank>&email=&password=</a>",'tips'=>'2：成功,3：用户不存在,4：邮箱尚未注册,5：首次登录成功,6：首次登录失败,7：登录失败','field'=>' '),
			array('model'=>'点赞功能','cmd'=>15,'params'=>"<a href='$domain&user_id=&praise_id=' target=_blank>&user_id=&praise_id=</a>",'tips'=>' 2：成功，3 : 已点赞，4 ：点赞失败','field'=>' content '),
			array('model'=>'生成订单','cmd'=>16,'params'=>"<a href='$domain&theory_time=&student_id=&teacher_id=' target=_blank>&theory_time=&student_id=&teacher_id=</a>",'tips'=>' 2：成功，3 : 失败，5：用户余额不足','field'=>' content '),
			array('model'=>'支付管理','cmd'=>17,'params'=>"<a href='$domain&order_id=&theory_time=' target=_blank>&order_id=&theory_time=</a>",'tips'=>' 2：成功，3 : 失败，4：订单不存在，5：用户不存在','field'=>' content '),
			array('model'=>'学员回扣','cmd'=>18,'params'=>"<a href='$domain&order_id=&theory_time=&effective_time=' target=_blank>&order_id=&theory_time=&effective_time=</a>",'tips'=>' 2：成功，3 : 失败，4：订单不存在，5：用户不存在','field'=>' content '),
			array('model'=>'个人中心','cmd'=>19,'params'=>"<a href='$domain&user_id=' target=_blank>&user_id=</a>",'tips'=>' 2：成功，3 : 失败','field'=>' content '),
			array('model'=>'学员评价','cmd'=>20,'params'=>"<a href='$domain&order_id=' target=_blank>&order_id=</a>",'tips'=>' 2：成功，3 : 失败，4：订单不存在','field'=>' content '),
			array('model'=>'修改用户信息','cmd'=>21,'params'=>"<a href='$domain&user_id=&username=&biography=' target=_blank>&user_id=&username=&biography=</a>",'tips'=>' 2：成功，3 : 失败，4：用户不存在','field'=>' content '),
			array('model'=>'银行卡信息展示','cmd'=>22,'params'=>"<a href='$domain&user_id=' target=_blank>&user_id=</a>",'tips'=>' 2：成功，3 : 失败，4：用户不存在，5；该用户未添加银行卡','field'=>' content '),
			array('model'=>'交易记录','cmd'=>23,'params'=>"<a href='$domain&user_id=' target=_blank>&user_id=</a>",'tips'=>' 2：成功，3 : 失败，4：用户不存在','field'=>' content '),
			array('model'=>'充值操作','cmd'=>24,'params'=>"<a href='$domain&user_id=&recharge_money=' target=_blank>&user_id=&recharge_money=</a>",'tips'=>' 2：成功，3 : 失败，4：用户不存在，5：充值操作已取消，需返回flag=1已充值flag=0取消充值','field'=>' content '),
			array('model'=>'充值记录','cmd'=>25,'params'=>"<a href='$domain&user_id=' target=_blank>&user_id=</a>",'tips'=>' 2：成功，3 : 失败，4：用户不存在','field'=>' content '),
			array('model'=>'金额','cmd'=>26,'params'=>"<a href='$domain&user_id=&order_id=' target=_blank>&user_id=&order_id=</a>",'tips'=>' 2：成功，4：用户不存在','field'=>' content '),
			array('model'=>'发布topic','cmd'=>30,'params'=>"<a href='$domain&user_id=&topic_cat=&topic_content=&available_time=' target=_blank>&user_id=&topic_cat=&topic_content=&available_time=</a>",'tips'=>' 2：成功，3 : 失败','field'=>' content '),
			array('model'=>'发送邮件','cmd'=>31,'params'=>"<a href='$domain&mail=&name=&content=' target=_blank>&mail=&name=&content=</a>",'tips'=>' 2：成功，3 : 失败','field'=>' content '),
			
			// array('model'=>'以下请勿调用','cmd'=>以下请勿调用,'params'=>"以下请勿调用",'tips'=>' 以下请勿调用','field'=>' 以下请勿调用 '),
			// array('model'=>'交易信息','cmd'=>16,'params'=>"<a href='$domain&uid=&per_number=&p=&uid=' target=_blank>&uid=&per_number=&p=&uid=</a>",'tips'=>' 2：成功，3 : 失败','field'=>' content '),
			// array('model'=>'订单管理','cmd'=>17,'params'=>"<a href='$domain&uid=&per_number=&p=&uid=' target=_blank>&uid=&per_number=&p=&uid=</a>",'tips'=>' 2：成功，3 : 失败','field'=>' content '),
			// array('model'=>'支付管理','cmd'=>18,'params'=>"<a href='$domain&content=' target=_blank>&content=</a>",'tips'=>' 2：成功，3 : 失败','field'=>' content '),
			// array('model'=>'个人中心','cmd'=>19,'params'=>"<a href='$domain&uid=&pid=' target=_blank>&uid=&pid=</a>",'tips'=>' 2：成功，3 : 失败','field'=>' content '),
			// array('model'=>'学员评论','cmd'=>20,'params'=>"<a href='$domain&pid=' target=_blank>&pid=</a>",'tips'=>' 2：成功，3 : 失败','field'=>' content '),
			// array('model'=>'评星','cmd'=>21,'params'=>"<a href='$domain&from_uid=&to_pid=' target=_blank>&from_uid=&to_pid=</a>",'tips'=>' 2：成功，3 : 失败，4：赞过了','field'=>'  ')
					);
		echo "<title>Talknic 接口说明</title>";
		echo '<h1><center>Talknic -- 接口说明</center></h1>';
		// echo '<h3>【用户 ID ： uid 】【文章 ID : pid 】【评论 ID : cid 】【提醒 ID : mid 】</h3>';
		echo '<meta charset="utf-8">';
		echo '<table border="1" cellspacing="0">';
		echo '<tr><th>位置</th><th>cmd</th><th>请求参数</th><th>code</th><th>result</th></tr>';
		foreach($res as $v){
			echo '<tr>';
			echo '<td>'.$v['model'].'</td>';
			echo '<td>'.$v['cmd'].'</td>';
			echo '<td>'.$v['params'].'</td>';
			echo '<td>'.$v['tips'].'</td>';
			echo '<td>'.$v['field'].'</td>';
			echo '</tr>';
		}
		echo '</table>';
	}
}
?>

