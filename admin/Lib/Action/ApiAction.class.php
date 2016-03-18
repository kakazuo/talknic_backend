<?php
// +----------------------------------------------------------------------
// | Talknic 移动应用软件接口
// +----------------------------------------------------------------------
// | provide by ：www.baiwushi.cn
// +----------------------------------------------------------------------
// | Author : CharlesW
// +----------------------------------------------------------------------
class ApiAction extends Action{
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
						echo json_encode(array('code'=>'2','result'=>$this->switch_to_string($data)));exit;
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
							//$type = $_REQUEST['identity'] == 'chinese' ? 0 : 1 ; //1外教，0学员
							$data = array(
								'user_name' => $_REQUEST['tel'],
								'user_create_time' => time(),
								'user_type' => $_REQUEST['identity']  //
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
								'user_first_login' => 1
								// 'user_online' => 1
							);
							if($result= M('user')->where('user_name='.$_REQUEST['tel'])->save($data)){
								echo json_encode(array('code'=>'5','result'=>array('uid'=>$res['user_id'],'identity'=>$res['user_type'])));exit;
							} else {
								echo json_encode(array('code'=>'6'));exit;
							}
							
						} else {
							$data = array(
								'user_online' => 1
							);
							if(M('user')->where('user_name='.$_REQUEST['tel'].' and user_pwd="'.md5($_REQUEST['password']).'"')->find()){
								echo json_encode(array('code'=>'2','result'=>array('uid'=>$res['user_id'],'identity'=>$res['user_type'])));exit;
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
			case 333://第三方登陆
				//var_dump($_REQUEST);exit;
				if(!$_REQUEST[login_type] || !$_REQUEST['unique_identification']){
					exit(json_encode(array('code'=>'31')));//参数错误 
				}
				//var_dump($_REQUEST);exit;
				$login_type = $_REQUEST['login_type'];
				$model_user = M('user');
				switch($login_type){
					case 'wechat'://weixin登陆
						$res = $model_user->where('wechat="'.$_REQUEST['unique_identification'].'"')->find();
						if(!$res && isset($_REQUEST['identity'])){//首次登陆,并且需要传identity
							$data = array(
								'user_name' => $_REQUEST['unique_identification'],
								'user_pwd' => $_REQUEST['unique_identification'],
								'wechat' => $_REQUEST['unique_identification'],
								'user_create_time' => time(),
								'user_type' => $_REQUEST['identity']
							);
							$res_add = $model_user->add($data);
							//exit(M()->getLastSql());
							if($res_add){
								exit(json_encode(array('code'=>'5','result'=>array('uid'=>$res_add,'identity'=>$_REQUEST['identity']))));
							}else{
								exit(json_encode(array('code'=>'32')));//登陆failed
							}
						}else{//非首次登陆
							$res = $model_user->where('wechat="'.$_REQUEST['unique_identification'].'"')->find();
							//exit(M()->getLastSql());
							if($res){
								exit(json_encode(array('code'=>'2','result'=>array('uid'=>$res['user_id'],'identity'=>$res['user_type']))));
							}else{
								exit(json_encode(array('code'=>'34')));//登陆failed
							}
						}
						break;
					case 'sina':
						$res = $model_user->where('sina='.$_REQUEST['unique_identification'])->find();
						if(!$res && isset($_REQUEST['identity'])){//首次登陆,并且需要传identity
							$data = array(
								'user_name' => $_REQUEST['unique_identification'],
								'user_pwd' => $_REQUEST['unique_identification'],
								'sina' => $_REQUEST['unique_identification'],
								'user_create_time' => time(),
								'user_type' => $_REQUEST['identity']
							);
							$res_add = $model_user->add($data);
							//echo M()->getLastSql();exit;
							if($res_add){
								exit(json_encode(array('code'=>'5','result'=>array('uid'=>$res_add,'identity'=>$_REQUEST['identity']))));
							}else{
								exit(json_encode(array('code'=>'32')));//登陆failed
							}
						}else{//非首次登陆
							$res = $model_user->where('sina='.$_REQUEST['unique_identification'])->find();
							if($res){
								exit(json_encode(array('code'=>'2','result'=>array('uid'=>$res['user_id'],'identity'=>$res['user_type']))));
							}else{
								exit(json_encode(array('code'=>'34')));//登陆failed
							}
						}
						break;
					default:
						exit(json_encode(array('code'=>'35')));//参数错误 
						break;
				}
				//微波登陆
				
				
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
						//if(true){
							if(M('user')->where('user_name='.$_REQUEST['tel'].' and user_pwd="'.md5($_REQUEST['password']).'"')->find()){
								echo json_encode(array('code'=>'2'));exit;
							}else{
								$data = array('user_pwd'=>md5($_REQUEST['password']));
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
			case 6://上传头像
				if($_FILES['file']['error'] > 0 || $_FILES['file']['size'] > 1000000000) {
					echo json_encode(array('code'=>'4'));exit;//图片上传错误
				} else {
					if(!M('user')->find($_REQUEST['user_id'])) {
						echo json_encode(array('code'=>'5'));exit;//用户ID错误
					} else {
						if($_FILES['file']['size'] > 0) {
							$ext = pathinfo($_FILES['file']['name'],PATHINFO_EXTENSION);
							if(in_array($ext,array('png','jpg','jpeg','bmp'))) {
								$new_name = $this->make_uniqid($ext,$_SERVER['HTTP_HOST']."/Talknic1.0/data/uploads/");
								$res = move_uploaded_file($_FILES['file']['tmp_name'],'./data/uploads/'.$new_name);
								if($res){
									if($_FILES["file"]["size"] < 1){
										$user_pic = 'no_pic';
									}else{
										$user_pic = 'http://'.$_SERVER['HTTP_HOST'].'/Talknic1.0/data/uploads/'.$new_name;
									}
									$data = array('user_pic'=>$user_pic);
									$res = M('user')->where('user_id='.$_REQUEST['user_id'])->save($data);
									if($res) {
										echo json_encode(array('code'=>'2','result'=>$this->switch_to_string($res)));exit;
									} else {
										echo json_encode(array('code'=>'3'));exit;
									}
								}else{
									echo json_encode(array('code'=>'3'));exit;
								}
								
							}else{
								echo json_encode(array('code'=>'3'));exit;
							}
						}
						
					}
				}
				break;
			case 7://基本信息设置
				if(!M('user')->find($_REQUEST['user_id'])) {
						echo json_encode(array('code'=>'4'));exit;//用户ID错误
					} else {
						if($_REQUEST['user_sex'] == '') {
							$user_sex = 0;
						} elseif($_REQUEST['user_sex'] == 'male') {
							$user_sex = 2;
						} elseif($_REQUEST['user_sex'] == 'female') {
							$user_sex = 1;
						}
						if($_REQUEST['identity'] == 1) {
							// $data = array('user_real_name'=>$_REQUEST['user_name'],'user_sex'=>$user_sex,'nationality'=>$_REQUEST['nationality'],'occupation'=>$_REQUEST['occupation'],'biography'=>$_REQUEST['biography']);
							$sql = "UPDATE `talknic_user` SET `user_real_name`='".$_REQUEST['user_name']."',`user_sex`=".$user_sex.",`nationality`='".$_REQUEST['nationality']."',`occupation`='".$_REQUEST['occupation']."',`biography`='".$_REQUEST['biography']."' WHERE  user_id=".$_REQUEST['user_id'];
						} elseif($_REQUEST['identity'] == 0) {
							// $data = array('user_real_name'=>$_REQUEST['user_name'],'user_sex'=>$user_sex,'user_level'=>$_REQUEST['user_level']);
							$sql = "UPDATE `talknic_user` SET `user_real_name`='".$_REQUEST['user_name']."',`user_sex`=".$user_sex.",`user_level`='".$_REQUEST['user_level']."' WHERE  user_id=".$_REQUEST['user_id'];
						}
						// $res = M('user')->where('user_id='.$_REQUEST['user_id'])->save($data);
						$res= mysql_query($sql);
						if($res) {
							echo json_encode(array('code'=>'2','result'=>$this->switch_to_string($res)));exit;
						} else {
							echo json_encode(array('code'=>'3'));exit;
						}
					}
				break;
			case 8://匹配信息设置
				if(!M('user')->find($_REQUEST['user_id'])) {
						echo json_encode(array('code'=>'4'));exit;//用户ID错误
					} else {
						if($_REQUEST['identity'] == 1){
							$time = intval((strtotime($_REQUEST['end_time'])-strtotime($_REQUEST['start_time']))/60);
						} else {
							$time = '';
						}
						$data = array('user_id'=>$_REQUEST['user_id'],'condition_topic'=>$_REQUEST['favorite'],'condition_time'=>$time);
						$res = M('match_condition')->add($data);
						if($res) {
							echo json_encode(array('code'=>'2','result'=>$this->switch_to_string($res)));exit;
						} else {
							echo json_encode(array('code'=>'3'));exit;
						}
					}
				break;
			case 9://设置银行卡信息
				if(!M('user')->find($_REQUEST['user_id'])) {
					echo json_encode(array('code'=>'4'));exit;//用户ID错误
				} else {
						if(!M('bank_number')->where("bank_number='".$_REQUEST['number']."'")->find()){
							$data = array('user_id'=>$_REQUEST['user_id'],'bank_number'=>$_REQUEST['number'],'holder_name'=>$_REQUEST['name'],'validity'=>$_REQUEST['validity'],'ccv'=>$_REQUEST['ccv']);
							// var_dump($data);exit;
							// $res = M('bank_number')->add($data);
							$sql="INSERT INTO `talknic_bank_number` (`user_id`,`bank_number`,`holder_name`,`validity`,`ccv`) VALUES (".$_REQUEST['user_id'].",'".$_REQUEST['number']."','".$_REQUEST['name']."','".$_REQUEST['validity']."',".$_REQUEST['ccv'].")";
							$res=mysql_query($sql);
							if($res) {
								echo json_encode(array('code'=>'2','result'=>$this->switch_to_string($data)));exit;
							} else {
								echo json_encode(array('code'=>'3'));exit;
							}
						}else{
							echo json_encode(array('code'=>'5'));exit;
						}
					}
				break;
			case 901://删除银行卡信息
				$bank_number = $_REQUEST['bank_number'];
				// $data = array('bank_number'=>$_REQUEST['bank_number']);
				// var_dump($data);exit;
				$res = M('bank_number')->where('bank_number='.$bank_number)->delete();
				if($res){
					echo json_encode(array('code'=>'2'));exit;
				}else{
					echo json_encode(array('code'=>'3'));exit;
				}
				break;
			case 10://Discover列表
				if($_REQUEST['discover'] == 'featured') {
					$res = M('talknic_user')->table('talknic_match_condition a,talknic_user b') -> where('a.user_id=b.user_id and b.user_type=1') -> field('a.condition_time time,b.user_id uid,b.user_pic,b.user_praise praise,b.user_real_name username,b.user_praise praise,b.user_fans star,b.nationality,b.occupation,b.biography topic') -> order('b.user_online DESC') -> select();
				} elseif($_REQUEST['discover'] == 'latest') {
					$res = M('talknic_user')->table('talknic_match_condition a,talknic_user b') -> where('a.user_id=b.user_id and b.user_type=1') -> field('a.condition_time time,b.user_id uid,b.user_pic,b.user_praise praise,b.user_real_name username,b.user_praise praise,b.user_fans star,b.nationality,b.occupation,b.biography topic') -> order('b.user_id DESC') -> select();
				} elseif($_REQUEST['discover'] == 'popular') {
					$res = M('talknic_user')->table('talknic_match_condition a,talknic_user b') -> where('a.user_id=b.user_id and b.user_type=1') -> field('a.condition_time time,b.user_id uid,b.user_pic,b.user_praise praise,b.user_real_name username,b.user_praise praise,b.user_fans star,b.nationality,b.occupation,b.biography topic') -> order('b.user_praise DESC') -> select();
				}
				foreach ($res as $key => $value) {
					if($res[$key]['user_pic'] == 'user.png'){
						$res[$key]['user_pic'] = 'http://'.$_SERVER['HTTP_HOST'].'/Talknic1.0/data/uploads/'.$res[$key]['user_pic'];
					}else{
						$res[$key]['user_pic'] = $res[$key]['user_pic'];
					}
				}
				if($res){
					echo json_encode(array('code'=>'2','result'=>$this->switch_to_string($res)));exit;
				}else{
					echo json_encode(array('code'=>'3'));exit;
				}
				break;
			// case 11://匹配功能
				// $time = $_REQUEST['time'];
				// $topic = $this->string_connect(json_decode($_REQUEST['favorite']));
					// $topic = 'b';
				// $where['condition_topic'] = array("like",'"%'.$topic.'%"');
					// $res = M("match_condition")->where("condition_time>".$time." and condition_topic like '%b%'")->field("user_id")->find();
				// $res = M("match_condition")->table('talknic_match_condition a,talknic_user b')->where("a.condition_time>=".$time." and a.condition_topic like '%b%'")->field("a.user_id,a.condition_time time,b.user_real_name username,b.nationality,b.occupation,b.biography topic")->find();
					// echo M("match_condition")->getLastSql();
					// var_dump($res);
				// if($res) {
					// echo json_encode(array('code'=>'2','result'=>$this->switch_to_string($res)));exit;
				// } else {
					// echo json_encode(array('code'=>'3'));exit;
				// }
				// break;
			case 11://匹配功能
				$time = $_REQUEST['time'];				
				$topic_arr = explode(',',$_REQUEST['favorite']);		
				$topic_where = implode('%" or a.condition_topic like "%',$topic_arr);//echo $topic_where;exit;
				strlen($topic_where)>0 ? $topic_where = ' and (a.condition_topic like"%'.$topic_where.'%")' : $topic_where = '';				
				$match = M("match_condition");
				// $res = $match->table('talknic_match_condition a,talknic_user b')->where("a.condition_time>=".$time." and a.condition_topic like '%b%'")->field("a.user_id,a.condition_time time,b.user_real_name username,b.user_praise praise,b.user_fans star,b.nationality,b.occupation,b.biography topic")->find();
				//$res = $match->table('talknic_match_condition a,talknic_user b')->where("a.condition_time=".$time." and a.condition_topic='".$this->string_connect($_REQUEST['favorite'])."' and a.user_id=b.user_id")->field("a.user_id,a.condition_time time,b.user_pic,b.user_real_name username,b.user_praise praise,b.user_fans star,b.nationality,b.occupation,b.biography topic")->select();
				$res = $match
				->table('talknic_match_condition a,talknic_user b')
				->where("a.condition_time=".$time.$topic_where." and a.user_id=b.user_id")
				->field("a.user_id,a.condition_time time,b.user_pic,b.user_real_name username,b.user_praise praise,b.user_fans star,b.nationality,b.occupation,b.biography topic")
				->select();
				//echo M("match_condition")->getLastSql();
				foreach ($res as $key => $value) {
					$res[$key]['user_pic'] = 'http://'.$_SERVER['HTTP_HOST'].'/Talknic1.0/data/uploads/'.$res[$key]['user_pic'];
				}
				if($res) {
					// $res['RMB'] = $res['time']*1.5;
					echo json_encode(array('code'=>'2','result'=>$this->switch_to_string($res)));exit;
				} else {
					echo json_encode(array('code'=>'3'));exit;
				}
				break;
			case 12://邮箱验证码
				if($this->check_tel($_REQUEST['email']) == 2) {
					echo json_encode(array('code'=>'4'));exit;
				}
				$ret = $this->send_mail($_REQUEST['email']);
				if($ret['state'] != 1){
					echo json_encode(array('code'=>'3'));exit;
				}else{
					$model_captcha = M('tmp_captcha');
					$data = array('tel'=>$_REQUEST['email'],'captcha'=>$ret['captcha'],'create_time'=>time());
					$model_captcha->where("tel='".$_REQUEST['email']."'")->delete();
					if($model_captcha->add($data)){
						echo json_encode(array('code'=>'2','result'=>array('captcha'=>$this->switch_to_string($ret['captcha']))));exit;
					}else{
						echo json_encode(array('code'=>'3'));exit;
					}
				}
				break;
			case 13://邮箱注册
				if($this->check_tel($_REQUEST['email']) == 2) {
					echo json_encode(array('code'=>'4'));exit;
				}else{
					$res = M('tmp_captcha')->field('captcha')->where("tel='".$_REQUEST['email']."'")->find();
					if($res['captcha'] == $_REQUEST['captcha']) {
							//$type = $_REQUEST['identity'] == 'chinese' ? 0 : 1 ; //1外教，0学员
							$data = array(
								'user_name' => $_REQUEST['email'],
								'user_create_time' => time(),
								'user_type' => $_REQUEST['identity']
							);
							$model_user = M('user');
							$res_add = $model_user -> add($data);
							if($res_add) {
								echo json_encode(array('code' => '2','result' => array('uid' => $res_add,'tel' => $_REQUEST['email'],'type' => $_REQUEST['identity'])));exit;
							} else {
								echo json_encode(array('code' => '5'));exit;
							}
					} else {
						echo json_encode(array('code'=> '3'));exit;
					}	
				}
				break;
			case 14://邮箱登录
				if($this->check_tel($_REQUEST['email']) == 2) {
					$res = M('user')->field('user_id,user_name,user_first_login,user_type,user_status,user_online')->where("user_name='".$_REQUEST['email']."'")->find();
					if($res) {
						if($res['user_first_login'] == 0) {
							$data = array(
								'user_pwd' => md5($_REQUEST['password']),
								'user_first_login' => 1
								// 'user_online' => 1
							);
							if($result= M('user')->where("user_name='".$_REQUEST['email']."'")->save($data)){
								echo json_encode(array('code'=>'5','result'=>array('uid'=>$res['user_id'],'identity'=>$res['user_type'])));exit;
							} else {
								echo json_encode(array('code'=>'6'));exit;
							}
							
						} else {
							$data = array(
								'user_online' => 1
							);
							if(M('user')->where("user_name='".$_REQUEST['email']."' and user_pwd='".md5($_REQUEST['password'])."'")->find()){
								echo json_encode(array('code'=>'2','result'=>array('uid'=>$res['user_id'],'identity'=>$res['user_type'])));exit;
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
				case 15://点赞功能
					$user_id = $_REQUEST['user_id'];
					$praise_id = $_REQUEST['praise_id'];
					
					$res = M("praise")->where("user_id=".$user_id)->field("praise_id")->find();
					$array = explode(",",$res['praise_id']);
					// var_dump(in_array("'".$praise_id."'", $array));
					if(in_array($praise_id, $array)){
						echo json_encode(array('code'=>'3'));exit;//已点赞
					}else {
						if(empty($res['praise_id'])){
							$string_id = $_REQUEST['praise_id'];
						}else{							
							array_push($array,$praise_id);
							$string_id = $this->string_connect($array);
						}
						if(M("praise")->where("user_id=".$user_id)->find()){
							$data = array("praise_id"=>$string_id);
							$res = M("praise")->where("user_id=".$user_id)->save($data);
						}else{
							$data = array("user_id"=>$user_id,"praise_id"=>$string_id);
							$res = M("praise")->where("user_id=".$user_id)->add($data);
						}
						if($res){
							$praise_num = M("user")->where("user_id=".$user_id)->field("user_praise")->find();
							$user_praise = $praise_num['user_praise']+1;
							$data_num = array("user_praise"=>$user_praise);
							if($result=M("user")->where("user_id=".$user_id)->save($data_num)){
								echo json_encode(array('code'=>'2','result'=>$this->switch_to_string($result)));exit;
							} else {
								echo json_encode(array('code'=>'4'));exit;
							}
						} else {
							echo json_encode(array('code'=>'4'));exit;//点赞失败
						}
					}
					break;
				case 16://生成订单
					$theory_time = $_REQUEST['theory_time'];//理论时间
					$user_student_id = $_REQUEST['student_id'];
					$user_teacher_id = $_REQUEST['teacher_id'];
					$sql = M('user')->field('user_allscore')->where('user_id='.$user_student_id)->find();
					$money = $sql['user_allscore'];
					if($theory_time<=$money){
						$teacher_price = intval($theory_time)*1-intval($theory_time)*1*0.1;//网站回扣已计算在内
						$data = array('user_student_id'=>$user_student_id,'user_teacher_id'=>$user_teacher_id,'order_price'=>$teacher_price);
						$res = M('order')->add($data);
						// echo M('order')->getLastSql();exit;
						if($res) {
							echo json_encode(array('code'=>'2','order_id'=>$this->switch_to_string($res)));exit;
						} else {
							echo json_encode(array('code'=>'3'));exit;
						}
					}else{
						$margin = $theory_time-$money;
						echo json_encode(array('code'=>'5','balance'=>$margin));exit;
					}
					
					break;
				case 17://提交订单(完成支付)
					$order_id = $_REQUEST['order_id'];
					$theory_time = $_REQUEST['theory_time'];//理论时间
					$res = M('order')->where('order_id='.$order_id)->find();
					if($res) {
						$teacher_price = $res['order_price'];
						$tid = $res['user_teacher_id'];
						$sid = $res['user_student_id'];
						$t_res = M('user')->field('user_allscore')->where('user_id='.$tid)->find();
						$s_res = M('user')->field('user_allscore')->where('user_id='.$sid)->find();
						if($t_res && $s_res) {
							$t_balance = $t_res['user_allscore'] + $theory_time*1;
							$s_balance = $s_res['user_allscore'] - $theory_time*1;
							$t_data = array('user_allscore'=>$t_balance);
							$s_data = array('user_allscore'=>$s_balance);
							if(M('user')->where('user_id='.$tid)->save($t_data) && M('user')->where('user_id='.$sid)->save($s_data)){
								$sql='UPDATE `talknic_order` SET time="'.date('Y-m-d',time()).'" WHERE ( order_id='.$order_id.' )';
								mysql_query($sql);
								echo json_encode(array('code'=>'2','result'=>'success'));exit;
							} else {
								echo json_encode(array('code'=>'3'));exit;//支付失败
							}
						} else {
							echo json_encode(array('code'=>'5'));exit;//用户不存在
						}
					} else {
						echo json_encode(array('code'=>'4'));exit;//订单不存在
					}
					// $student_price = intval($teacher_price)-((intval($theory_time)*1.5-intval($theory_time)*1.5*0.1)*(intval($effective_time)/intval($theory_time)));
					break;
				case 18://学员回扣
					$order_id = $_REQUEST['order_id'];
					$effective_time = $_REQUEST['effective_time'];//有效时间
					$theory_time = $_REQUEST['theory_time'];//理论时间
					$res = M('order')->where('order_id='.$order_id)->find();
					if($res) {
						$teacher_price = $res['order_price'];
						$tid = $res['user_teacher_id'];
						$sid = $res['user_student_id'];
						$t_res = M('user')->field('user_allscore')->where('user_id='.$tid)->find();
						$s_res = M('user')->field('user_allscore')->where('user_id='.$sid)->find();
						$score = $s_res['score']+$effective_time;
						if($t_res && $s_res) {
							$t_balance = $t_res['user_allscore'] - (intval($theory_time)-intval($effective_time));
							$s_balance = $s_res['user_allscore'] + (intval($theory_time)-intval($effective_time));
							$t_data = array('user_allscore'=>$t_balance);
							$s_data = array('user_allscore'=>$s_balance,'score'=>$score);
							$sql = 'UPDATE `talknic_user` SET `score`='.$score.' WHERE ( user_id='.$sid.' )';
							$result = mysql_query($sql);
							if(M('user')->where('user_id='.$tid)->save($t_data) && M('user')->where('user_id='.$sid)->save($s_data) && $result){ 
								echo json_encode(array('code'=>'2','result'=>'success'));exit;
							} else {
								echo json_encode(array('code'=>'3'));exit;//支付失败
							}
						} else {
							echo json_encode(array('code'=>'5'));exit;//用户不存在
						}
					} else {
						echo json_encode(array('code'=>'4'));exit;//订单不存在
					}
					break;
				case 19://个人中心
					if(!M('user')->find($_REQUEST['user_id'])) {
						echo json_encode(array('code'=>'4'));exit;//用户ID错误
					} else {
						$res = M('user')->field('user_pic pic,user_fans fans,user_praise praise,nationality,user_real_name username,occupation city,biography topic')->where('user_id='.$_REQUEST['user_id'])->find();
						// var_dump($res);exit;
						if($res) {
							echo json_encode(array('code'=>'2','result'=>$this->switch_to_string($res)));exit;
						} else {
							echo json_encode(array('code'=>'3'));exit;//查询失败
						}
					}
					break;
				case 20://学员评价
					if(!M('order')->find($_REQUEST['order_id'])) {
						echo json_encode(array('code'=>'4'));exit;//订单不存在
					} else {
						$data = array('order_id'=>$_REQUEST['order_id'],'feedback_star_student'=>$_REQUEST['star'],'feedback_student'=>$_REQUEST['paid']);
						if($res = M('feedback')->add($data)) {
							echo json_encode(array('code'=>'2','result'=>$this->switch_to_string($res)));exit;
						} else {
							echo json_encode(array('code'=>'3'));exit;
						}
					}
					// $data = array
					break;
				case 21://修改用户信息
					if(!M('user')->find($_REQUEST['user_id'])) {
						echo json_encode(array('code'=>'4'));exit;//用户ID错误
					} else {
						$data = array();
						$info = M('user')->find($_REQUEST['user_id']);
						$username = ($_REQUEST['username']=='' ? $info['user_real_name'] : $_REQUEST['username']);
						$biography = ($_REQUEST['biography']=='' ? $info['biography'] : $_REQUEST['biography']);
						// var_dump($data);exit;
						// $res = M('user')->where('user_id='.$_REQUEST['user_id'])->save($data);
						$sql = "UPDATE `talknic_user` SET `user_real_name`='".$username."',`biography`='".$biography."' WHERE `user_id`=".$_REQUEST['user_id'];
						$res = mysql_query($sql);
						if($res){
							echo json_encode(array('code'=>'2','uid'=>$_REQUEST['user_id'],'result'=>$this->switch_to_string($res)));exit;
						}else{
							echo json_encode(array('code'=>'3'));exit;
						}
					}
					break;
				case 22://银行卡信息展示
					if(!M('user')->find($_REQUEST['user_id'])) {
						echo json_encode(array('code'=>'4'));exit;//用户ID错误
					} else {
						if(!M('bank_number')->find($_REQUEST['user_id'])){
							echo json_encode(array('code'=>'5'));exit;//该用户未添加银行卡
						}else{
							$res = M('bank_number')->where('user_id='.$_REQUEST['user_id'])->select();
							if($res){
								echo json_encode(array('code'=>'2','result'=>$this->switch_to_string($res)));exit;
							}else{
								echo json_encode(array('code'=>'3'));exit;
							}
						}
					}
					break;
				case 23://交易记录
					if(!M('user')->find($_REQUEST['user_id'])) {
						echo json_encode(array('code'=>'4'));exit;
					} else {
						$res = M('order')->field('order_price,time')->where('user_student_id='.$_REQUEST['user_id'])->select();
						$data = array();
						foreach($res as $key=>$val){
							if($val['time']!=null){
								$data[] = $val;
							}
						}
						if($res){
							echo json_encode(array('code'=>'2','result'=>$this->switch_to_string($data)));exit;
						}else{
							echo json_encode(array('code'=>'3'));exit;
						}
					}
					break;
				case 24://充值操作
					if(!M('user')->find($_REQUEST['user_id'])) {
						echo json_encode(array('code'=>'4'));exit;
					} else {
							$data = array(
								'user_id'=>$_REQUEST['user_id'],
								'recharge_type'=>'',
								'recharge_money'=>$_REQUEST['recharge_money'],
								'recharge_time'=>date('Y-m-d',time())
							);
							$res = M('recharge_record')->add($data);
							$result = M('user')->field('user_allscore')->where('user_id='.$_REQUEST['user_id'])->find();
							$money = $result['user_allscore']+$_REQUEST['recharge_money'];
							$data_money = array('user_allscore'=>$money);
							$res_money = M('user')->where('user_id='.$_REQUEST['user_id'])->save($data_money);
							if($res && $res_money){
								echo json_encode(array('code'=>'2','result'=>$this->switch_to_string($data)));exit;
							}else{
								echo json_encode(array('code'=>'3'));exit;
							}
					}
					break;
				case 25://充值记录
					if(!M('user')->find($_REQUEST['user_id'])) {
						echo json_encode(array('code'=>'4'));exit;
					} else {
						$res = M('recharge_record')->where('user_id='.$_REQUEST['user_id'])->select();
						if($res){
							echo json_encode(array('code'=>'2','result'=>$this->switch_to_string($res)));exit;
						}else{
							echo json_encode(array('code'=>'3'));exit;
						}
					}
					break;
				case 26://金额
					if(!M('user')->find($_REQUEST['user_id'])) {
						echo json_encode(array('code'=>'4'));exit;
					} else {
						$res = M('order')->field('order_id,order_price,time')->where('order_id='.$_REQUEST['order_id'])->select();
						foreach($res as $val){
							if($val['time']==null){
								$order_id = $val['order_id'];
								$frozen_balance = $val['order_price'];
							}else{
								$order_id = 'flag';
								$frozen_balance = 0;
							}
						}
						// echo $frozen_balance;exit;
						$res = M('user')->field('user_allscore money,score')->where('user_id='.$_REQUEST['user_id'])->find();
						$balance = $res['money'];
						$available_balance = $balance-$frozen_balance;
						$score = $res['score'];
						$data = array(
							'balance'=>$balance,
							'frozen_balance'=>$frozen_balance,
							'available_balance'=>$available_balance,
							'score'=>$score
						);
						echo json_encode(array('code'=>'2','result'=>$this->switch_to_string($data)));exit;
					}
					break;
				case 27://可领取代金券展示
					$res = M('flink')->field('id,name,url price,img,status')->where('status=1')->select();
					if($res){
						exit(json_encode(array('code'=>'2','result'=>$this->switch_to_string($res))));
					}else{
						exit(json_encode(array('code'=>'3')));
					}
					break;
				case 28://领取代金券
					if(!M('user')->find($_REQUEST['user_id'])) {
						echo json_encode(array('code'=>'4'));exit;
					} else {
						$data = array(
							voucher_id => $_REQUEST['voucher_id'],
							user_id => $_REQUEST['user_id']
						);
						if(M('voucher')->where($data)->find()){
							exit(json_encode(array('code'=>5)));//该用户已经领取该代金券
						}else{
							$result = M('voucher')->add($data);
							if($result){
								exit(json_encode(array('code'=>'2','result'=>$this->switch_to_string($data))));
							}else{
								exit(json_encode(array('code'=>'3')));
							}
						}
					}
					break;
				case 29://用户代金券展示
					if(!M('user')->find($_REQUEST['user_id'])) {
						echo json_encode(array('code'=>'4'));exit;
					} else {
						$res = M('voucher')->field('voucher_id')->where('user_id='.$_REQUEST['user_id'])->select();
						foreach($res as $val){
							$id=$val['voucher_id'];
							$result[] = M('flink')->where('id='.$id)->find();
						}
						if($result){
							// foreach($result as $val){
								
							// }
							exit(json_encode(array('code'=>'2','result'=>$this->switch_to_string($result))));
						}else{
							exit(json_encode(array('code'=>'3')));
						}
					}
					break;
				case 30:
					if($_REQUEST['user_id']>0 && strlen($_REQUEST['available_time'])>0){
						$data = array(
							'user_id'=>$_REQUEST['user_id'],
							'topic_cat'=>$_REQUEST['topic_cat'],
							'topic_content'=>$_REQUEST['topic_content'],
							'available_time'=>$_REQUEST['available_time'],
							'create_time'=>time(),
						);
						if(M('topic')->add($data)){
							exit(json_encode(array('code'=>'2')));
						}else{
							//echo M()->getLastSql();
							exit(json_encode(array('code'=>'31')));
						}
					}else{
						exit(json_encode(array('code'=>'32')));
					}
					break;
				case 31:
					$res = $this->send_mail_two($_REQUEST['mail'],'来自 Talknic - '.$_REQUEST['name'],$_REQUEST['content']);
					if($res['state'] != 1){
						echo json_encode(array('code'=>'3'));exit;
					}else{
						echo json_encode(array('code'=>'2'));exit;
					}
					break;
				
		}
	}
	//检查手机号是否已经注册
	public function check_tel($tel){
		if(M('user')->where("user_name='".$tel."'")->find()){
			return 2;
		}else{
			return 3;
		}
	}	
	// 手机发送验证码-临时用
	public function send_captcha($tel) {
		
		return array('state'=>0,'captcha'=>123456);
	}
	// 手机发送验证码-回头改回来
	public function send_captcha_right($tel) {
		$name="shdjydz";
		$pwd="SHdjydz28";
		$code=rand(111111,999999);
		$msg  = rawurlencode("验证码：".$code."【Talknic】");
		$res = file_get_contents("http://120.24.167.205/msg/HttpSendSM?account=$name&pswd=$pwd&mobile=$tel&msg=$msg");
		$state = explode(",",strip_tags($res));
		$state = $state[1];
		return array('state'=>$state,'captcha'=>$code);
	}
	public function send_captcha_test() {
		$tel = $_GET['tel'];
		$name="shdjydz";
		$pwd="SHdjydz28";
		$code=rand(111111,999999);
		$msg  = rawurlencode("验证码：".$code."【Talknic】");
		$res = file_get_contents("http://120.24.167.205/msg/HttpSendSM?account=$name&pswd=$pwd&mobile=$tel&msg=$msg");
		var_dump($res);exit;
		$state = explode(",",strip_tags($res));
		$state = $state[1];
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
	// 邮箱发送验证码
    public function send_mail($to){
		vendor("email.send");
		$obj = new send();
		// $to = '******@qq.com';
		$subject = 'Talknic验证码！';
		$code = rand(111111,999999);
		$body = "Talknic验证码:".$code;
		$res = send::go($to,$subject,$body);
		$state = strip_tags($res);
		return array('state'=>$state,'captcha'=>$code);
	}
	//发送邮件
    public function send_mail_two($to,$subject,$body){
		vendor("email.send");
		$obj = new send();
		$res = send::go($to,$subject,$body);
		$state = strip_tags($res);
		return array('state'=>$state);
	}
}
?>