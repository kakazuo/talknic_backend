<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><?php echo ($page["title"]); ?></title>
<link href="__TMPL__Public/css/install.css" rel="stylesheet" type="text/css" charset="utf-8" />
</head>

<body>
<div class="header">
	<div class="logo fl"></div>
    <div class="fr">
    	<ul class="top_nav fr">
        	<li><a href="http://bbs.wego360.com/" target="_blank"><?php echo (L("official_bbs")); ?></a></li>
            <li><a href="http://www.wego360.com/" target="_blank"><?php echo (L("user_manual")); ?></a></li>
        </ul>
        <h2 class="fr"><?php echo (L("wellcom_user_appnav")); ?></h2>
    </div>
</div>
<div class="content">
	<div class="step fl">
    	<h3></h3>
        <ul>
        	<li <?php if($step_curr == 'eula'): ?>class="curr"<?php endif; ?>><span>1</span><h4><?php echo (L("step_eula")); ?></h4></li>
            <li <?php if($step_curr == 'check'): ?>class="curr"<?php endif; ?>><span>2</span><h4><?php echo (L("step_check")); ?></h4></li>
            <li <?php if($step_curr == 'setconf'): ?>class="curr"<?php endif; ?>><span>3</span><h4><?php echo (L("step_setconf")); ?></h4></li>
            <li <?php if($step_curr == 'install'): ?>class="curr"<?php endif; ?>><span>4</span><h4><?php echo (L("step_install")); ?></h4></li>
            <li <?php if($step_curr == 'finish'): ?>class="curr"<?php endif; ?>><span>5</span><h4><?php echo (L("step_finish")); ?></h4></li>
        </ul>
    </div>
<div class="c_main fr">
<form action="" method="POST" id="post_form">
	<div class="c_main_title"><span class="fr padding5">Powered by(phonegap100.com)</span><?php echo (L("step_setconf_desc")); ?></div>
	<div class="c_main_body setconf">
    	<?php if(isset($error_msg)): ?><div class="error_msg"><?php echo ($error_msg); ?></div><?php endif; ?>
        <fieldset>
        	<legend><?php echo (L("setconf_database")); ?></legend>
            <ul>
            	<li><span class="field"><?php echo (L("database_host")); ?>：</span><input type="text" name="db_host" id="db_host" class="text_input" size="30" value="<?php echo ($db_host); ?>" /><span class="field port"><?php echo (L("database_port")); ?>：</span><input type="text" name="db_port" id="db_port" class="text_input" size="8" value="<?php echo ($db_port); ?>" /></li>
                <li><span class="field"><?php echo (L("database_user")); ?>：</span><input type="text" name="db_user" id="db_user" class="text_input" size="30" value="<?php echo ($db_user); ?>" /><span class="field_tip"><?php echo (L("database_user_tip")); ?></span></li>
                <li><span class="field"><?php echo (L("database_pass")); ?>：</span><input type="password" name="db_pass" id="db_pass" class="text_input" size="30" value="<?php echo ($db_pass); ?>" /><span class="field_tip"><?php echo (L("database_pass_tip")); ?></span></li>
                <li><span class="field"><?php echo (L("database_name")); ?>：</span><input type="text" name="db_name" id="db_name" class="text_input" size="30" value="<?php echo ($db_name); ?>" /><span class="field_tip"><?php echo ($database_name_tip); ?></span></li>
                <li><span class="field"><?php echo (L("table_prefix")); ?>：</span><input type="text" name="db_prefix" id="db_prefix" class="text_input" size="30" value="<?php echo ($db_prefix); ?>" /><span class="field_tip"><?php echo (L("table_prefix_tip")); ?></span></li>
            </ul>
        </fieldset>
        <fieldset class="admin_info">
        	<legend>管理员信息配置</legend>
            <ul>
                <li><span class="field"><?php echo (L("admin_user")); ?>：</span><input type="text" name="admin_user" id="admin_user" class="text_input" size="30" value="<?php echo ($admin_user); ?>" /></li>
                <li><span class="field"><?php echo (L("admin_pass")); ?>：</span><input type="password" name="admin_pass" id="admin_pass" class="text_input" size="30" value="<?php echo ($admin_pass); ?>" /></li>
                <li><span class="field"><?php echo (L("admin_pass_confirm")); ?>：</span><input type="password" name="admin_pass_confirm" id="admin_pass_confirm" class="text_input" size="30" value="<?php echo ($admin_pass_confirm); ?>" /></li>
                <li><span class="field"><?php echo (L("admin_email")); ?>：</span><input type="text" name="admin_email" id="admin_email" class="text_input" size="30" value="<?php echo ($admin_email); ?>" /></li>
            </ul>
        </fieldset>
    </div>
    <div class="act">
        <div class="btn"><input type="submit" name="dosubmit" id="submit_button"  value="<?php echo (L("next")); ?>" class="btn_next" /></div>
    </div>
</form>
</div>
</div>
</body>
</html>