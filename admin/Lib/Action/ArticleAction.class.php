<?php
// +----------------------------------------------------------------------
// | CharlesW Cms 移动应用软件后台管理系统
// +----------------------------------------------------------------------
// | provide by ：http://www.baiwushi.cn
// 
// +----------------------------------------------------------------------
// | Author: CharlesW
// +----------------------------------------------------------------------

class ArticleAction extends BaseAction
{
	public function index()
	{
		$article_mod = D('article');
		$article_cate_mod = D('article_cate');

		//搜索
		$where = '1=1';
		if (isset($_GET['keyword']) && trim($_GET['keyword'])) {
		    $where .= " AND title LIKE '%".$_GET['keyword']."%'";
		    $this->assign('keyword', $_GET['keyword']);
		}
		if (isset($_GET['time_start']) && trim($_GET['time_start'])) {
		    $time_start = $_GET['time_start'];
		    $where .= " AND add_time>='".$time_start."'";
		    $this->assign('time_start', $_GET['time_start']);
		}
		if (isset($_GET['time_end']) && trim($_GET['time_end'])) {
		    $time_end = $_GET['time_end'];
		    $where .= " AND add_time<='".$time_end."'";
		    $this->assign('time_end', $_GET['time_end']);
		}
		if (isset($_GET['cate_id']) && intval($_GET['cate_id'])) {
		    $where .= " AND cate_id=".$_GET['cate_id'];
		    $this->assign('cate_id', $_GET['cate_id']);
		}
		import("ORG.Util.Page");
		$count = $article_mod->where($where)->count();
		$p = new Page($count,20);
		$article_list = $article_mod->where($where)->limit($p->firstRow.','.$p->listRows)->order('add_time DESC,ordid ASC')->select();

		$key = 1;
		foreach($article_list as $k=>$val){
			$article_list[$k]['key'] = ++$p->firstRow;
			$article_list[$k]['cate_name'] = $article_cate_mod->field('name')->where('id='.$val['cate_id'])->find();
		}
		$result = $article_cate_mod->order('sort_order ASC')->select();
    	$cate_list = array();
    	foreach ($result as $val) {
    	    if ($val['pid']==0) {
    	        $cate_list['parent'][$val['id']] = $val;
    	    } else {
    	        $cate_list['sub'][$val['pid']][] = $val;
    	    }
    	}
		//网站信息/应用资讯
		$page = $p->show();
		$this->assign('page',$page);
    	$this->assign('cate_list', $cate_list);
		$this->assign('article_list',$article_list);
		$this->display();
	}

	function edit()
	{
		if(isset($_POST['dosubmit'])){
			$article_mod = D('article');	
			$data = $article_mod->create();
			if($data['cate_id']==0){
				$this->error('请选择资讯分类');
			}
			if ($_FILES['img']['name']!='') {
			    $upload_list = $this->_upload();
			    $data['img'] = $upload_list['0']['savename'];
			}			
			$result = $article_mod->save($data);
			if(false !== $result){
				$this->success(L('operation_success'),U('Article/index'));
			}else{
				$this->error(L('operation_failure'));
			}
		}else{
			$article_mod = D('article');
			if( isset($_GET['id']) ){
				$article_id = isset($_GET['id']) && intval($_GET['id']) ? intval($_GET['id']) : $this->error(L('please_select'));
			}
			$article_cate_mod = D('article_cate');
		    $result = $article_cate_mod->order('sort_order ASC')->select();
		    $cate_list = array();
		    foreach ($result as $val) {
		    	if ($val['pid']==0) {
		    	    $cate_list['parent'][$val['id']] = $val;
		    	} else {
		    	    $cate_list['sub'][$val['pid']][] = $val;
		    	}
		    }
			$article_info = $article_mod->where('id='.$article_id)->find();		
			$this->assign('show_header', false);
	    	$this->assign('cate_list',$cate_list);
			$this->assign('article',$article_info);
			$this->display();
		}


	}

	function add()
	{
		if(isset($_POST['dosubmit'])){
			$article_mod = D('article');		
			if($_POST['title']==''){
				$this->error(L('input').L('article_title'));
			}
			if(false === $data = $article_mod->create()){
				$this->error($article_mod->error());
			}
			if ($_FILES['img']['name']!='') {
				$upload_list = $this->_upload();
				$data['img'] = $upload_list['0']['savename'];
			}
			$data['add_time']=date('Y-m-d H:i:s',time());
			$result = $article_mod->add($data);
			if($result){
				$cate = M('article_cate')->field('id,pid')->where("id=".$data['cate_id'])->find();
				if( $cate['pid']!=0 ){
					M('article_cate')->where("id=".$cate['pid'])->setInc('article_nums');
					M('article_cate')->where("id=".$data['cate_id'])->setInc('article_nums');
				}else{
					M('article_cate')->where("id=".$data['cate_id'])->setInc('article_nums');
				}
				$this->success('添加成功');
			}else{
				$this->error('添加失败');
			}
		}else{
			$article_cate_mod = D('article_cate');
	    	$result = $article_cate_mod->order('sort_order ASC')->select();
	    	$cate_list = array();
	    	foreach ($result as $val) {
	    	    if ($val['pid']==0) {
	    	        $cate_list['parent'][$val['id']] = $val;
	    	    } else {
	    	        $cate_list['sub'][$val['pid']][] = $val;
	    	    }
	    	}
	    	$this->assign('cate_list',$cate_list);
	    	$this->display();
		}
	}
	function delete()
    {
		$article_mod = D('article');
		if((!isset($_GET['id']) || empty($_GET['id'])) && (!isset($_POST['id']) || empty($_POST['id']))) {
            $this->error('请选择要删除的资讯！');
		}
		if( isset($_POST['id'])&&is_array($_POST['id']) ){
			$cate_ids = implode(',',$_POST['id']);
			foreach( $_POST['id'] as $val ){
				$article = $article_mod->field("id,cate_id")->where("id=".$val)->find();
				$cate = M('article_cate')->field('id,pid')->where("id=".$article['cate_id'])->find();
				if( $cate['pid']!=0 ){
					M('article_cate')->where("id=".$cate['pid'])->setDec('article_nums');
					M('article_cate')->where("id=".$article['cate_id'])->setDec('article_nums');
				}else{
					M('article_cate')->where("id=".$article['cate_id'])->setDec('article_nums');
				}

			}
			$article_mod->delete($cate_ids);
		}else{
			$cate_id = intval($_GET['id']);
			$article = $article_mod->field("id,cate_id")->where("id=".$cate_id)->find();
			M('article_cate')->where("id=".$article['cate_id'])->setDec('article_nums');
		    $article_mod->where('id='.$cate_id)->delete();
		}
		$this->success(L('operation_success'));
    }

    public function _upload()
    {
    	import("ORG.Net.UploadFile");
        $upload = new UploadFile();
        //设置上传文件大小
        $upload->maxSize = 3292200;
        //$upload->allowExts = explode(',', 'jpg,gif,png,jpeg');
        $upload->savePath = './data/news/';

        $upload->saveRule = uniqid;
        if (!$upload->upload()) {
            //捕获上传异常
            $this->error($upload->getErrorMsg());
        } else {
            //取得成功上传的文件信息
            $uploadList = $upload->getUploadFileInfo();
        }
        return $uploadList;
    }

	function sort_order()
    {
    	$article_mod = D('article');
		if (isset($_POST['listorders'])) {
            foreach ($_POST['listorders'] as $id=>$sort_order) {
            	$data['ordid'] = $sort_order;
                $article_mod->where('id='.$id)->save($data);
            }
            $this->success(L('operation_success'));
        }
        $this->error(L('operation_failure'));
    }

    //修改状态
	function status()
	{
		$article_mod = D('article');
		$id 	= intval($_REQUEST['id']);
		$type 	= trim($_REQUEST['type']);
		$sql 	= "update ".C('DB_PREFIX')."article set $type=($type+1)%2 where id='$id'";
		$res 	= $article_mod->execute($sql);
		$values = $article_mod->field("id,".$type)->where('id='.$id)->find();
		$this->ajaxReturn($values[$type]);
	}

}
?>