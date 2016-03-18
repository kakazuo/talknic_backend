<?php
// +----------------------------------------------------------------------
// | Talknic 移动应用软件接口
// +----------------------------------------------------------------------
// | provide by ：www.baiwushi.cn
// +----------------------------------------------------------------------
// | Author : CharlesW
// +----------------------------------------------------------------------
class ApiAction extends BaseAction{
	// 接口
	public function index() {
		switch($_REQUEST['cmd']){
			case 1://发送注册验证码
				if($this->check_tel($_REQUEST['tel']) == 2) {
					echo json_encode(array('code'=>'4'));exit;
				}
				$ret = $this->send_captcha($_REQUEST['tel']);
				if($ret['state'] != 0){
					echo json_encode(array('code'=>'3'));exit;
				}else{
					$model_captcha = M('tmp_captcha');
					$data = array('tel'=>$_REQUEST['tel'],'captcha'=>$ret['captcha'],'create_time'=>time());
					$model_captcha->where('tel='.$_REQUEST['tel'])->delete();
					if($model_captcha->add($data)){
						echo json_encode(array('code'=>'2','result'=>array('captcha'=>$this->switch_to_string($ret['captcha']))));exit;
					}else{
						echo json_encode(array('code'=>'3'));exit;
					}
				}
				break;
			case 2://注册
				if($this->check_tel($_REQUEST['tel']) == 2) {
					echo json_encode(array('code'=>'4'));exit;
				}else{
					$res = M('tmp_captcha')->field('captcha')->where('tel='.$_REQUEST['tel'])->find();
					if($res['captcha'] == $_REQUEST['captcha']) {
							$type = $_REQUEST['identity'] == 'chinese' ? 0 : 1 ; //1外教，0学员
							$data = array(
								'user_name' => $_REQUEST['tel'],
								'user_create_time' => time(),
								'user_type' => $type
							);
							$model_user = M('user');
							$res_add = $model_user -> add($data);
							if($res_add) {
								echo json_encode(array('code' => '2','result' => array('uid' => $res_add,'tel' => $_REQUEST['tel'],'type' => $_REQUEST['identity'])));exit;
							} else {
								echo json_encode(array('code' => '5'));exit;
							}
					} else {
						echo json_encode(array('code'=> '3'));exit;
					}	
				}
				break;
			case 3://登录
				if($this->check_tel($_REQUEST['tel']) == 2) {
					$res = M('user')->field('user_id,user_name,user_first_login,user_type,user_status,user_online')->where('user_name='.$_REQUEST['tel'])->find();
					if($res) {
						if($res['user_first_login'] == 0) {
							$data = array(
								'user_pwd' => md5($_REQUEST['password']),
								'user_first_login' => 1,
								'user_online' => 1
							);
							if($result= M('user')->where('user_name='.$_REQUEST['tel'])->save($data)){
								echo json_encode(array('code'=>'5','result'=>array('uid'=>$res['user_id'])));exit;
							} else {
								echo json_encode(array('code'=>'6'));exit;
							}
							
						} else {
							$data = array(
								'user_online' => 1
							);
							if(M('user')->where('user_name='.$_REQUEST['tel'].' and user_pwd="'.md5($_REQUEST['password']).'"')->save($data)){
								echo json_encode(array('code'=>'2','result'=>array('uid'=>$res['user_id'])));exit;
							} else {
								echo json_encode(array('code'=>'4'));exit;
							}
						}
					} else {
						echo json_encode(array('code'=>'3'));exit;
					}
				}else {
					echo json_encode(array('code'=>'4'));exit;
				}
				break;
			case 4://发送找回密码验证码
				if($this->check_tel($_REQUEST['tel']) == 2) {
					$ret = $this->send_captcha($_REQUEST['tel']);
					if($ret['state'] != 0){
						echo json_encode(array('code'=>'3'));exit;
					}else{
						$model_captcha = M('tmp_captcha');
						$data = array('tel'=>$_REQUEST['tel'],'captcha'=>$ret['captcha'],'create_time'=>time());
						$model_captcha->where('tel='.$_REQUEST['tel'])->delete();
						if($model_captcha->add($data)){
							echo json_encode(array('code'=>'2','result'=>array('captcha'=>$this->switch_to_string($ret['captcha']))));exit;
						}else{
							echo json_encode(array('code'=>'3'));exit;
						}
					}
				} else {
					echo json_encode(array('code'=>4));exit;
				}
				
				break;
			case 5://找回密码
				if(isset($_REQUEST['tel']) && isset($_REQUEST['captcha']) && strlen($_REQUEST['password'])>0 && $_REQUEST['password'] == $_REQUEST['repassword']){
					if($this->check_tel($_REQUEST['tel']) == 3){
						echo json_encode(array('code'=>'4'));exit;
					}else{
						$model_captcha = M('tmp_captcha');
						if($model_captcha->where('tel='.$_REQUEST['tel'].' and captcha='.$_REQUEST['captcha'])->find()){
							if(M('user')->where('user_name='.$_REQUEST['tel'].' and user_pwd="'.sp_password($_REQUEST['password']).'"')->find()){
								echo json_encode(array('code'=>'2'));exit;
							}else{
								$data = array('user_pwd'=>sp_password($_REQUEST['password']));
								if(M('user')->where('user_name='.$_REQUEST['tel'])->save($data)){
									$model_captcha->where('tel='.$_REQUEST['tel'].' and captcha='.$_REQUEST['captcha'])->delete();
									echo json_encode(array('code'=>'2'));exit;
								}else{
									echo json_encode(array('code'=>'3'));exit;
								}
							}
						}else{
							echo json_encode(array('code'=>'3'));exit;
						}
					}
				}else{
					echo json_encode(array('code'=>'3'));exit;
				}
				break;
			case 6://基本信息设置
				if($_FILES['file']['error'] > 0 || $_FILES['file']['size'] > 1000000000) {
					echo json_encode(array('code'=>'5'));exit;//图片上传错误
				} elseif(strlen($_REQUEST['user_name']) < 1) {
					echo json_encode(array('code'=>'4'));exit;//用户名不能为空
				} else {
					if(!M('user')->find($_REQUEST['user_id'])) {
						echo json_encode(array('code'=>'6'));exit;//用户ID错误
					} else {
						if($_FILES['file']['size'] > 0) {
							$ext = pathinfo($_FILES['file']['name'],PATHINFO_EXTENSION);
							if(in_array($ext,array('png','jpg','jpeg','bmp'))) {
								$new_name = $this->make_uniqid($ext,$_SERVER['HTTP_HOST']."/Talknic1.0/data/uploads/");
								$res = move_uploaded_file($_FILES['file']['tmp_name'],SITE_PATH.'/data/uploads/'.$new_name);
								if($_FILES["file"]["size"] < 1){
									$user_pic = 'no_pic';
								}else{
									$user_pic = 'http://'.$_SERVER['HTTP_HOST'].'/Talknic1.0/data/upload/'.$new_name;
								}
							}
						}
						if($_REQUEST['user_sex'] == '') {
							$user_sex = 0;
						} elseif($_REQUEST['user_sex'] == 'male') {
							$user_sex = 2;
						} elseif($_REQUEST['user_sex'] == 'female') {
							$user_sex = 1;
						}
						$data_u = array('user_pic'=>$user_pic,'user_real_name'=>$_REQUEST['user_name'],'user_sex'=>$user_sex,'user_level'=>$_REQUEST['user_level']);
						$res_u = M('user')->where('user_id='.$_REQUEST['user_id'])->save($data_u);
						if(!M('match_condition')->where('user_id='.$_REQUEST['user_id'])->find()){
							$data_m = array('user_id'=>$_REQUEST['user_id'],'condition_topic'=>$this->string_connect($_REQUEST['favorite']));
							$res_m = M('match_condition')->add($data_m);
						} else {
							$data_m = array('condition_topic'=>$this->string_connect($_REQUEST['favorite']));
							$res_m = M('match_condition')->where('user_id='.$_REQUEST['user_id'])->save($data_m);
						}
						if($res_u && $res_m) {
							echo json_encode(array('code'=>'2'));exit;//成功
						} else {
							echo json_encode(array('code'=>'3'));exit;//失败
						}
					}
				}
				break;
		}
	}
	//检查手机号是否已经注册
	public function check_tel($tel){
		if(M('user')->where("user_name=$tel")->find()){
			return 2;
		}else{
			return 3;
		}
	}	
	// 手机发送验证码
	public function send_captcha($tel) {
		$name="SDK-DDCF-0229";
		$pwd  ="46DGSD";
		$code = rand(111111,999999);
		$msg  = rawurlencode("Talknic验证码：".$code);
		$res = file_get_contents("http://124.173.70.59:8081/SmsAndMms/mg?Sn=$name&Pwd=$pwd&mobile=$tel&content=$msg");
		$state = strip_tags($res);
		return array('state'=>$state,'captcha'=>$code);
	}
	public function switch_to_string(&$obj){
		if(is_array($obj)){
			if(empty($obj)){
				return '';
			}else{
				foreach($obj as $k=>&$v){
					if(is_array($v)){
						$this->switch_to_string($v);
					}elseif($v==null){
						$v = '';
					}else{
						$v = $v.'';
					}
				}
			}
		}elseif(is_null($obj==null)){
			$obj = '';
		}else{
			$obj = $obj.'';
		}
		return $obj;
	}
	/**
	 * 密码加密方法
	 * @param string $pw 要加密的字符串
	 * @return string
	 */
	function sp_password($pw){
		$decor=md5(C('DB_PREFIX'));
		$mi=md5($pw);
		return substr($decor,0,12).$mi.substr($decor,-4,4);
	}
	public function make_uniqid($ext,$path){
		$new_name = uniqid().'.'.$ext;
		if (file_exists($path . $new_name)){
			make_uniqid($ext,$path);
		}else{
			return $new_name;
		}
	}
	/**
	 * 数组连接方法
	 * @param array $array 要连接的数组
	 * @return string
	 */
	public function string_connect($array){
		$string = '';
		foreach($array as $v){
			$string .= $v.',';
		}
		$string = rtrim($string,',');
		return $string;
	}
}
?>