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
			array('model'=>'发送验证码(注册)','cmd'=>1,'params'=>'tel','tips'=>'  2：已发送，3；发送失败，4：手机号已被占用','field'=>' '),
			array('model'=>'注册','cmd'=>2,'params'=>'tel,captcha,identity','tips'=>' 2：成功，3 : 验证码错误，4：手机号已被占用，5：注册失败','field'=>' '),
			array('model'=>'登录','cmd'=>3,'params'=>'tel,password','tips'=>'2：成功，3：手机号或密码错误，4：手机号尚未注册，5：首次登录成功，6：首次登录失败','field'=>' '),
			array('model'=>'发送验证码(找回密码)','cmd'=>4,'params'=>'tel','tips'=>'  2：已发送，3；发送失败，4：手机号尚未注册','field'=>' '),
			array('model'=>'找回密码','cmd'=>5,'params'=>"tel,captcha,password,repassword",'tips'=>' 2：成功，3：手机号或验证码错误，4：手机号尚未注册','field'=>' '),
			array('model'=>'基本信息设置','cmd'=>6,'params'=>"<a href='$domain&user_id=&user_name=&user_sex=&user_level=&favorite=' target=_blank>&user_id=&user_name=&user_sex=&user_level=&favorite=</a>",'tips'=>' 2：成功，3：设置失败，4：用户名不能为空，5：图片上传错误，6：用户ID错误','field'=>' '),
			
			array('model'=>'发现列表','cmd'=>7,'params'=>"<a href='$domain&per_number=&p=' target=_blank>&per_number=&p=</a>",'tips'=>' 2：成功，3 : 失败','field'=>' content '),
			array('model'=>'匹配功能','cmd'=>8,'params'=>"<a href='$domain&uid=&per_number=&p=' target=_blank>&uid=&per_number=&p=</a>",'tips'=>' 2：成功，3 : 失败','field'=>' content '),
			array('model'=>'交易信息','cmd'=>9,'params'=>"<a href='$domain&uid=&per_number=&p=&uid=' target=_blank>&uid=&per_number=&p=&uid=</a>",'tips'=>' 2：成功，3 : 失败','field'=>' content '),
			array('model'=>'订单管理','cmd'=>10,'params'=>"<a href='$domain&uid=&per_number=&p=&uid=' target=_blank>&uid=&per_number=&p=&uid=</a>",'tips'=>' 2：成功，3 : 失败','field'=>' content '),
			array('model'=>'支付管理','cmd'=>11,'params'=>"<a href='$domain&content=' target=_blank>&content=</a>",'tips'=>' 2：成功，3 : 失败','field'=>' content '),
			array('model'=>'个人中心','cmd'=>12,'params'=>"<a href='$domain&uid=&pid=' target=_blank>&uid=&pid=</a>",'tips'=>' 2：成功，3 : 失败','field'=>' content '),
			array('model'=>'学员评论','cmd'=>13,'params'=>"<a href='$domain&pid=' target=_blank>&pid=</a>",'tips'=>' 2：成功，3 : 失败','field'=>' content '),
			array('model'=>'评星','cmd'=>14,'params'=>"<a href='$domain&from_uid=&to_pid=' target=_blank>&from_uid=&to_pid=</a>",'tips'=>' 2：成功，3 : 失败，4：赞过了','field'=>'  ')
					);
		echo "<title>Talknic 接口说明</title>";
		echo '<h1>Talknic -- 接口说明</h1>';
		echo '<h3>【用户 ID ： uid 】【文章 ID : pid 】【评论 ID : cid 】【提醒 ID : mid 】</h3>';
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