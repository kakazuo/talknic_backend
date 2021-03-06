<?php
// +----------------------------------------------------------------------
// | CharlesW Cms 移动应用软件后台管理系统
// +----------------------------------------------------------------------
// | provide by ：http://www.baiwushi.cn
// 
// +----------------------------------------------------------------------
// | Author: CharlesW
// +----------------------------------------------------------------------
class UserAction extends BaseAction{
	public function index(){
        $mod=D("user"); 
        $pagesize=8;        
        import("ORG.Util.Page");
		$where=" 1=1 ";
		if(isset($_REQUEST['keyword'])){
			$keys = $_REQUEST['keyword'];
			$this->assign('keyword',$keys);
			$where.=" and name like '%$keys%'";
		}
		$count=$mod->where($where)->count();		
		$p = new Page($count,$pagesize);		
		$list=$mod->where($where)
		// ->order("last_time desc")
		->limit($p->firstRow.','.$p->listRows)->select();
		$page=$p->show();  
		$this->assign('list',$list);
		$this->assign('page',$page);
		$this->display();
	}
	function edit(){
		if (isset($_POST['dosubmit'])) {
			$mod = D('user');		
			$user_data = $mod->create();			
			$pass=trim($_REQUEST['password']);
			
			$user_data['user_name']=$_REQUEST['name'];
			if(!empty($pass)){
				$user_data['user_pwd']=md5(trim($_REQUEST['password']));
			}
			$user_data['user_allscore']=$_REQUEST['integral'];
			$user_data['user_email']=$_REQUEST['email'];
			$user_data['user_sex']=$_REQUEST['sex'];
			$user_data['user_status']=$_REQUEST['status'];
			$result_info=$mod->where("user_id=". $_POST['id'])->save($user_data);
			if(false !== $result_info){
				$this->success(L('operation_success'), '', '', 'edit');
			}else{				
				$this->success(L('operation_failure'));
			}
		} else {
			$mod = D('user');		
			if (isset($_GET['id'])) {
				$id = isset($_GET['id']) && intval($_GET['id']) ? intval($_GET['id']) : $this->error('请选择要编辑的链接');
			}
			$user = $mod->where('user_id='. $id)->find();		
			$this->assign('info', $user);
			$this->assign('show_header', false);
			$this->display();
		}
	}
	//暂时注释掉
//	public function setscore(){
//		$setting_mod = M('setting');
//		if (isset($_POST['dosubmit'])) {
//			$setscore['user_register_score'] = isset($_POST['user_register_score']) && trim($_POST['user_register_score']) ? trim($_POST['user_register_score']) : $this->error('注册积分填写错误');
//			$setscore['user_login_score'] = isset($_POST['user_login_score']) && trim($_POST['user_login_score']) ? trim($_POST['user_login_score']) : $this->error('登陆积分填写错误');
//			$setscore['share_goods_score'] = isset($_POST['share_goods_score']) && trim($_POST['share_goods_score']) ? trim($_POST['share_goods_score']) : $this->error('分享商品积分填写错误');					
//			foreach( $setscore as $key=>$val ){				
//				$setting_mod->where("name='$key'")->save(array('data'=>$val));				
//			}			
//			$this->success('修改成功', U('user/setscore'));
//		}
//		$res = $setting_mod->where("name='user_register_score' OR name='user_login_score' OR name='share_goods_score' OR name='delete_share_goods_score'")->select();
//		foreach( $res as $val )
//		{
//			$setscore[$val['name']] = $val['data'];
//		}
//		$this->assign('setscore',$setscore);
//		$this->display();
//	}
	public function delete()
    {
		$user_mod = D('user');
		$user_platform=D('user_platform');
		
		if(!isset($_POST['id']) || empty($_POST['id'])) {
            $this->error('请选择要删除的数据！');
		}	
		if( isset($_POST['id'])&&is_array($_POST['id']) ){			
			foreach( $_POST['id'] as $val ){
				$user_mod->delete($val);
				$user_platform->where("user_id='{$val}'")->delete();					
			}			
		}else{
			$id = intval($_POST['id']);			
		    $user_mod->where('user_id='.$id)->delete();	
		    $user_platform->where("user_id='{$id}'")->delete();	
		}
		$this->success(L('operation_success'));
    }
    public function status() {
    	$id = intval($_GET['id']);
    	$type = intval($_GET['type']);
    	$status = ($type == 1) ? 0 : 1;
    	// $status_res = $status_mod -> where('id='.$id) -> save($user_data);
    	$sql = "update talknic_user set user_status=".$status." where user_id=".$id;
    	$res = mysql_query($sql);
    	if($res) {
    		$selSql = "select user_status from talknic_user where user_id=".$id;
    		$sel_res = mysql_query($selSql);
    		while($row = mysql_fetch_assoc($sel_res)) {
    			echo json_encode($row['user_status']);exit;
    		}
    	}
    }
}