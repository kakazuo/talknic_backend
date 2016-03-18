-- phpMyAdmin SQL Dump
-- version 3.3.7
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2016 年 02 月 25 日 06:43
-- 服务器版本: 5.1.30
-- PHP 版本: 5.2.14

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";



--
-- 数据库: `talknic`
--

-- --------------------------------------------------------

--
-- 表的结构 `talknic_access`
--

CREATE TABLE IF NOT EXISTS `talknic_access` (
  `role_id` int(5) NOT NULL,
  `node_id` int(5) NOT NULL,
  KEY `role_id` (`role_id`),
  KEY `node_id` (`node_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `talknic_access`
--


-- --------------------------------------------------------

--
-- 表的结构 `talknic_ad`
--

CREATE TABLE IF NOT EXISTS `talknic_ad` (
  `id` smallint(5) NOT NULL AUTO_INCREMENT,
  `board_id` smallint(5) NOT NULL,
  `type` varchar(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `url` varchar(255) NOT NULL,
  `code` text NOT NULL,
  `start_time` int(10) NOT NULL,
  `end_time` int(10) NOT NULL,
  `clicks` int(10) NOT NULL DEFAULT '0',
  `add_time` int(10) NOT NULL,
  `ordid` int(10) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `board_id` (`board_id`,`start_time`,`end_time`,`status`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- 转存表中的数据 `talknic_ad`
--

INSERT INTO `talknic_ad` (`id`, `board_id`, `type`, `name`, `url`, `code`, `start_time`, `end_time`, `clicks`, `add_time`, `ordid`, `status`) VALUES
(6, 6, 'code', '网络白武士', 'http://www.baiwushi.cn', '<script type="text/javascript">alimama_pid="mm_30949159_3378420_11349182";alimama_width=950;alimama_height=90;</script><script src="http://a.alimama.cn/inf.js" type="text/javascript"></script>', 1333595088, 1365217491, 104, 1333681516, 1, 1),
(7, 5, 'image', '凡客', '', '512ad36e181c5.png', 1333683143, 1365219146, 11, 1333683151, 2, 0),
(9, 5, 'text', '测试', 'http://192.168.1.51/wegou_news/uc_client', '测试广告', 1360598400, 1361462400, 0, 1361773236, 0, 1);

-- --------------------------------------------------------

--
-- 表的结构 `talknic_adboard`
--

CREATE TABLE IF NOT EXISTS `talknic_adboard` (
  `id` smallint(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `type` varchar(20) NOT NULL,
  `width` smallint(5) NOT NULL,
  `height` smallint(5) NOT NULL,
  `description` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- 转存表中的数据 `talknic_adboard`
--

INSERT INTO `talknic_adboard` (`id`, `name`, `type`, `width`, `height`, `description`, `status`) VALUES
(4, '详细页横幅', 'banner', 950, 100, '', 1),
(5, '详细页右侧', 'banner', 226, 226, '', 1),
(6, '首页下方横幅', 'banner', 960, 100, '', 1);

-- --------------------------------------------------------

--
-- 表的结构 `talknic_admin`
--

CREATE TABLE IF NOT EXISTS `talknic_admin` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `add_time` int(10) DEFAULT NULL,
  `last_time` int(10) DEFAULT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `role_id` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `talknic_admin`
--

INSERT INTO `talknic_admin` (`id`, `user_name`, `password`, `add_time`, `last_time`, `status`, `role_id`) VALUES
(1, 'admin', 'e08392bb89dedb8ed6fb298f8e729c15', 1446539150, 1456366739, 1, 1),
(2, 'test', '6dabc82a09a216bd691e8c70a6a4408e', 1446795651, 1446795844, 0, 1),
(3, 'wang', '89823788b6530348e0eac4c15d124271', 1446795898, 1446795898, 1, 1);

-- --------------------------------------------------------

--
-- 表的结构 `talknic_article`
--

CREATE TABLE IF NOT EXISTS `talknic_article` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cate_id` tinyint(4) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `orig` varchar(255) NOT NULL,
  `img` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `abst` varchar(255) NOT NULL,
  `info` mediumtext NOT NULL,
  `add_time` datetime NOT NULL,
  `ordid` tinyint(4) NOT NULL,
  `is_hot` tinyint(1) NOT NULL DEFAULT '0',
  `is_best` tinyint(1) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-待审核 1-已审核',
  `seo_title` varchar(255) NOT NULL,
  `seo_keys` varchar(255) NOT NULL,
  `seo_desc` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `is_best` (`is_best`),
  KEY `add_time` (`add_time`),
  KEY `cate_id` (`cate_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `talknic_article`
--


-- --------------------------------------------------------

--
-- 表的结构 `talknic_article_cate`
--

CREATE TABLE IF NOT EXISTS `talknic_article_cate` (
  `id` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `alias` varchar(50) NOT NULL,
  `pid` smallint(4) unsigned NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `article_nums` int(10) unsigned NOT NULL,
  `sort_order` smallint(4) unsigned NOT NULL,
  `seo_title` varchar(255) NOT NULL,
  `seo_keys` varchar(255) NOT NULL,
  `seo_desc` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- 转存表中的数据 `talknic_article_cate`
--

INSERT INTO `talknic_article_cate` (`id`, `name`, `alias`, `pid`, `status`, `article_nums`, `sort_order`, `seo_title`, `seo_keys`, `seo_desc`) VALUES
(1, '网站信息', 'sites', 11, 1, 4, 4, '', '', ''),
(5, '新手入门', 'rumen', 11, 1, 2, 2, '', '', ''),
(9, '热门活动', 'activity', 10, 1, 6, 5, '网站在线帮助说明', '111111111111111111111', '2222222222222222'),
(10, '资讯活动', 'news', 0, 1, 2, 1, '网站资讯', '', ''),
(11, '网站帮助', 'sites', 0, 1, 0, 0, '', '', '');

-- --------------------------------------------------------

--
-- 表的结构 `talknic_bank_number`
--

CREATE TABLE IF NOT EXISTS `talknic_bank_number` (
  `user_id` int(11) NOT NULL COMMENT '用户编号',
  `bank_number` char(20) DEFAULT NULL COMMENT '银行卡号',
  `holder_name` varchar(20) DEFAULT NULL COMMENT '开户名',
  `validity` varchar(20) DEFAULT NULL COMMENT '有效期',
  `ccv` int(11) DEFAULT NULL COMMENT '信用卡背面后三位'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='银行卡信息表';

--
-- 转存表中的数据 `talknic_bank_number`
--

INSERT INTO `talknic_bank_number` (`user_id`, `bank_number`, `holder_name`, `validity`, `ccv`) VALUES
(7, '1231231231231231', '123', '123123123', 123),
(8, '8888812312312312', '12312', '21324', 222),
(6, '6217888963255335', '咯哦', '8566', 889),
(13, '6217888855554123', '555', '555', 866),
(14, '6217888899995554', '5555', '455', 555),
(15, '9217856555655566', '56', '888', 866),
(16, '621661050003108', '111', '1111', 222),
(18, '1279487128791285', '12356', '123123', 123),
(5, '6217664753255655', '跟我', '555', 556),
(5, '6217999944443215', '哈鱼', '1267', 865),
(22, '6217566574556657', '85', '8866', 855),
(29, '111111111111111', 'addad', '11', 11),
(30, '6217566687555687', '好咯哦', '256', 566),
(31, '6217596677566545', '哈啦啦啦', '5566', 556),
(37, '6666666666666666', '111', '123', 111),
(41, '7372473237234544', '11', '21', 22),
(57, '2423452345234523', '245', '2452', 234),
(2, '6217569644426613', 'know', '566', 555),
(94, '1231234412341234', 'rex', '0616', 123),
(96, '1111111111111111', 'Diff', '1111', 111),
(98, '1234567812345678', 'Lily', '6016', 123),
(134, '464664649494949', '工资嘻嘻YY', '4444', 444),
(135, '1234567899874563', '家', '1234', 123),
(139, '1231231234323232', 'E', '1233', 123);

-- --------------------------------------------------------

--
-- 表的结构 `talknic_chat`
--

CREATE TABLE IF NOT EXISTS `talknic_chat` (
  `chat_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '聊天编号',
  `chat_number` int(11) NOT NULL COMMENT '会话场次',
  `user_id` int(11) DEFAULT NULL COMMENT '说话人ID',
  `chat_time` char(20) DEFAULT NULL COMMENT '聊天时间',
  `chat_content` text COMMENT '聊天内容',
  PRIMARY KEY (`chat_id`)
) ENGINE=BLACKHOLE DEFAULT CHARSET=utf8 COMMENT='聊天表' AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `talknic_chat`
--


-- --------------------------------------------------------

--
-- 表的结构 `talknic_fans`
--

CREATE TABLE IF NOT EXISTS `talknic_fans` (
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `fans_id` text COMMENT '粉丝ID'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='粉丝表';

--
-- 转存表中的数据 `talknic_fans`
--


-- --------------------------------------------------------

--
-- 表的结构 `talknic_feedback`
--

CREATE TABLE IF NOT EXISTS `talknic_feedback` (
  `feedback_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '反馈编号',
  `order_id` int(11) NOT NULL COMMENT '订单编号',
  `feedback_star_teacher` char(20) DEFAULT NULL COMMENT '外教对学员评星',
  `feedback_star_student` char(20) DEFAULT NULL COMMENT '学员对外教评星',
  `feedback_teacher` text COMMENT '外教对学员评价',
  `feedback_student` text COMMENT '学员对外教评价',
  PRIMARY KEY (`feedback_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='教学反馈表' AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `talknic_feedback`
--


-- --------------------------------------------------------

--
-- 表的结构 `talknic_flink`
--

CREATE TABLE IF NOT EXISTS `talknic_flink` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cate_id` smallint(4) NOT NULL DEFAULT '1',
  `img` varchar(255) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `url` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `ordid` smallint(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `talknic_flink`
--

INSERT INTO `talknic_flink` (`id`, `cate_id`, `img`, `name`, `url`, `status`, `ordid`) VALUES
(1, 1, '56ce8a5180815.jpg', '代金券1', '20', 1, 1),
(4, 1, '56ce8a5da25f1.jpg', '代金券2', '20', 1, 99);

-- --------------------------------------------------------

--
-- 表的结构 `talknic_flink_cate`
--

CREATE TABLE IF NOT EXISTS `talknic_flink_cate` (
  `id` smallint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `talknic_flink_cate`
--

INSERT INTO `talknic_flink_cate` (`id`, `name`) VALUES
(1, '友情链接'),
(2, '合作伙伴');

-- --------------------------------------------------------

--
-- 表的结构 `talknic_friends`
--

CREATE TABLE IF NOT EXISTS `talknic_friends` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `friends_id` text COMMENT '朋友ID',
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='朋友表' AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `talknic_friends`
--


-- --------------------------------------------------------

--
-- 表的结构 `talknic_group`
--

CREATE TABLE IF NOT EXISTS `talknic_group` (
  `id` smallint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL,
  `title` varchar(50) NOT NULL,
  `create_time` int(11) unsigned NOT NULL,
  `update_time` int(11) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `sort` smallint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `sort` (`sort`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=29 ;

--
-- 转存表中的数据 `talknic_group`
--

INSERT INTO `talknic_group` (`id`, `name`, `title`, `create_time`, `update_time`, `status`, `sort`) VALUES
(4, 'article', '内容管理', 1222841259, 1222841259, 1, 3),
(1, 'system', '系统设置', 1222841259, 1222841259, 1, 6),
(8, 'member', '会员管理', 0, 0, 1, 4),
(9, 'home', '起始页', 0, 1341386748, 1, 0),
(27, 'seller', '商家管理', 1340586215, 0, 0, 1);

-- --------------------------------------------------------

--
-- 表的结构 `talknic_match_condition`
--

CREATE TABLE IF NOT EXISTS `talknic_match_condition` (
  `condition_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '匹配条件编号',
  `condition_time` char(40) DEFAULT NULL COMMENT '匹配时间段',
  `condition_topic` text COMMENT '匹配话题',
  `user_id` int(11) NOT NULL COMMENT '设置匹配条件用户的ID',
  PRIMARY KEY (`condition_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='匹配条件表' AUTO_INCREMENT=51 ;

--
-- 转存表中的数据 `talknic_match_condition`
--

INSERT INTO `talknic_match_condition` (`condition_id`, `condition_time`, `condition_topic`, `user_id`) VALUES
(1, '', '', 1),
(2, '', '', 3),
(3, '', '', 5),
(4, '', '', 5),
(5, '0', '', 7),
(6, '0', '', 8),
(7, '0', '', 13),
(8, '0', '', 14),
(9, '0', '', 15),
(10, '-2759', '', 16),
(11, '0', '', 18),
(12, '', '', 20),
(13, '0', '', 22),
(14, '0', '', 23),
(15, '0', '', 24),
(16, '0', '', 25),
(17, '0', '', 26),
(18, '0', '', 27),
(19, '0', '', 28),
(20, '0', '', 29),
(21, '0', '', 30),
(22, '0', '', 31),
(23, '', '', 32),
(24, '', '', 34),
(25, '1440', '', 37),
(26, '-24270780', '', 41),
(27, '', '', 43),
(28, '', '', 44),
(29, '', '', 46),
(30, '0', '', 50),
(31, '0', '', 57),
(32, '', '', 77),
(33, '', '', 92),
(34, '', '', 95),
(35, '', '', 96),
(36, '-1440', '', 94),
(37, '30', '', 97),
(38, '30', '', 97),
(39, '30', 'sports,film', 97),
(40, '', NULL, 103),
(41, '', NULL, 113),
(42, '', NULL, 124),
(43, '', NULL, 126),
(44, '', NULL, 128),
(45, '24273457', NULL, 131),
(46, '', NULL, 132),
(47, '0', NULL, 134),
(48, '0', NULL, 135),
(49, '0', NULL, 139),
(50, '0', NULL, 141);

-- --------------------------------------------------------

--
-- 表的结构 `talknic_nav`
--

CREATE TABLE IF NOT EXISTS `talknic_nav` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `alias` varchar(50) NOT NULL,
  `url` varchar(255) NOT NULL,
  `sort_order` smallint(4) NOT NULL,
  `system` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1-系统 0-自定义',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '导航位置1-顶部 2-底部',
  `in_site` tinyint(1) NOT NULL COMMENT '1-本站内 0-站外',
  `is_show` tinyint(1) NOT NULL DEFAULT '1',
  `seo_title` varchar(255) NOT NULL,
  `seo_keys` text NOT NULL,
  `seo_desc` text NOT NULL,
  `items_cate_id` int(11) DEFAULT NULL COMMENT '//分类id',
  PRIMARY KEY (`id`),
  KEY `is_show` (`is_show`),
  KEY `type` (`type`),
  KEY `sort_order` (`sort_order`),
  KEY `alias` (`alias`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=21 ;

--
-- 转存表中的数据 `talknic_nav`
--

INSERT INTO `talknic_nav` (`id`, `name`, `alias`, `url`, `sort_order`, `system`, `type`, `in_site`, `is_show`, `seo_title`, `seo_keys`, `seo_desc`, `items_cate_id`) VALUES
(1, '发现', 'search', '', 1, 1, 1, 1, 0, '', '', '', 0),
(2, '母婴', 'album', '', 2, 1, 1, 1, 1, '', '', '', 0),
(3, '搞笑', 'promo', '', 3, 1, 1, 1, 1, '', '', '', 0),
(4, '返现商家', 'seller', '', 4, 1, 1, 1, 1, '', '', '', NULL),
(5, '视频', 'exchange_goods', '', 5, 1, 1, 1, 0, '', '', '', NULL),
(6, '杂谈', 'xiezi', '', 8, 0, 1, 1, 1, '', '', '', 2),
(7, '帮助中心', 'bangzhu', 'http://bbs.phonegap100.com', 0, 0, 1, 0, 0, '', '', '', 0);

-- --------------------------------------------------------

--
-- 表的结构 `talknic_node`
--

CREATE TABLE IF NOT EXISTS `talknic_node` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `module` varchar(255) NOT NULL,
  `module_name` varchar(50) NOT NULL,
  `action` varchar(255) NOT NULL,
  `action_name` varchar(50) DEFAULT NULL,
  `data` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0',
  `remark` varchar(255) DEFAULT NULL,
  `sort` smallint(6) unsigned NOT NULL DEFAULT '0',
  `auth_type` tinyint(1) NOT NULL DEFAULT '0',
  `group_id` tinyint(3) unsigned DEFAULT '0',
  `often` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-不常用 1-常用',
  `is_show` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-不常用 1-常用',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `module` (`module`),
  KEY `auth_type` (`auth_type`),
  KEY `is_show` (`is_show`),
  KEY `group_id` (`group_id`),
  KEY `sort` (`sort`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=158 ;

--
-- 转存表中的数据 `talknic_node`
--

INSERT INTO `talknic_node` (`id`, `module`, `module_name`, `action`, `action_name`, `data`, `status`, `remark`, `sort`, `auth_type`, `group_id`, `often`, `is_show`) VALUES
(1, 'Node', '菜单管理', '', '', '', 1, '', 0, 0, 1, 0, 0),
(2, 'Node', '菜单管理', 'index', '菜单列表', '', 1, '', 0, 1, 1, 0, 0),
(3, 'Node', '菜单管理', 'add', '添加菜单', '', 1, '', 0, 2, 1, 0, 0),
(4, 'Node', '菜单管理', 'edit', '编辑菜单', '', 1, '', 0, 2, 1, 0, 0),
(5, 'Node', '菜单管理', 'delete', '删除菜单', '', 1, '', 0, 2, 1, 0, 0),
(6, 'Role', '角色管理', '', '', '', 0, '', 370, 0, 1, 0, 0),
(7, 'Role', '角色管理', 'index', '角色管理', '', 0, '', 0, 1, 1, 0, 0),
(8, 'Role', '角色管理', 'add', '添加角色', '', 0, '', 0, 2, 1, 0, 0),
(9, 'Role', '角色管理', 'edit', '编辑角色', '', 0, '', 0, 2, 1, 0, 0),
(10, 'Role', '角色管理', 'delete', '删除角色', '', 0, '', 0, 2, 1, 0, 0),
(11, 'Role', '角色管理', 'auth', '角色授权', '', 0, '', 0, 2, 1, 0, 0),
(12, 'Admin', '管理员管理', '', '', '', 1, '', 380, 0, 1, 0, 0),
(13, 'Admin', '管理员管理', 'index', '管理员列表', '', 1, '', 0, 1, 1, 0, 0),
(14, 'Admin', '管理员管理', 'add', '添加管理员', '', 1, '', 0, 2, 1, 0, 0),
(15, 'Admin', '管理员管理', 'edit', '编辑管理员', '', 1, '', 0, 2, 1, 0, 0),
(16, 'Admin', '管理员管理', 'delete', '删除管理员', '', 1, '', 0, 2, 1, 0, 0),
(50, 'Setting', '网站设置', '', '', '', 0, '', 399, 0, 1, 0, 0),
(51, 'Setting', '网站设置', 'index', '网站设置', '', 0, '', 0, 1, 1, 0, 0),
(99, 'Flink', '友情链接', '', '', '', 0, '', 98, 0, 4, 0, 0),
(100, 'Flink', '代金券', 'index', '代金券列表', '', 1, '', 0, 1, 4, 0, 0),
(101, 'Article', '资讯管理', '', '', '', 0, '', 100, 0, 4, 0, 0),
(102, 'Article', '资讯管理', 'index', '资讯列表', '', 0, '', 0, 1, 4, 0, 0),
(103, 'Article', '资讯管理', 'add', '添加资讯', '', 0, '', 0, 1, 4, 0, 0),
(104, 'ArticleCate', '资讯分类', '', '', '', 0, '', 99, 0, 4, 0, 0),
(105, 'Article', '资讯管理', 'edit', '编辑资讯', '', 0, '', 0, 2, 4, 0, 0),
(106, 'Article', '资讯管理', 'delete', '删除资讯', '', 0, '', 0, 2, 4, 0, 0),
(107, 'ArticleCate', '资讯分类', 'index', '分类列表', '', 0, '', 0, 1, 4, 0, 0),
(108, 'ArticleCate', '资讯分类', 'add', '添加分类', '', 0, '', 0, 2, 4, 0, 0),
(109, 'ArticleCate', '资讯分类', 'edit', '编辑分类', '', 0, '', 0, 2, 4, 0, 0),
(110, 'ArticleCate', '资讯分类', 'delete', '删除分类', '', 0, '', 0, 2, 4, 0, 0),
(135, 'SellerCate', '商家分类管理', '', '', '', 1, '', 0, 0, 27, 0, 0),
(136, 'SellerCate', '商家分类管理', 'index', '分类列表', '', 1, '', 0, 1, 27, 0, 0),
(137, 'SellerCate', '商家分类管理', 'add', '增加分类', '', 1, '', 0, 2, 27, 0, 0),
(121, 'Nav', '导航管理', '', '', '', 0, '', 2, 0, 4, 0, 0),
(122, 'Nav', '导航管理', 'index', '导航列表', '', 0, '', 0, 1, 4, 0, 0),
(123, 'Nav', '导航管理', 'add', '添加导航', '', 0, '', 0, 2, 4, 0, 0),
(124, 'Nav', '导航管理', 'edit', '编辑导航', '', 0, '', 0, 2, 4, 0, 0),
(125, 'Nav', '导航管理', 'delete', '删除导航', '', 0, '', 0, 2, 4, 0, 0),
(126, 'Public', '起始页', '', '', '', 1, '', 0, 0, 9, 0, 0),
(127, 'Public', '起始页', 'main', '后台首页', '', 1, '', 0, 1, 9, 0, 0),
(128, 'Group', '菜单分类管理', '', '', '', 0, '菜单分类管理', 10, 0, 1, 0, 0),
(129, 'Group', '菜单分类管理', 'index', '分类列表', '', 0, '', 0, 1, 1, 0, 0),
(130, 'Group', '菜单分类管理', 'add', '增加分类', '', 0, '', 0, 2, 1, 0, 0),
(131, 'Group', '菜单分类管理', 'edit', '编辑分类', '', 0, '', 0, 2, 1, 0, 0),
(132, 'Group', '菜单分类管理', 'delete', '删除分类', '', 0, '', 0, 2, 1, 0, 0),
(138, 'SellerCate', '商家分类管理', 'edit', '编辑分类', '', 1, '', 0, 2, 27, 0, 0),
(139, 'SellerCate', '商家分类管理', 'delete', '删除分类', '', 1, '', 0, 2, 27, 0, 0),
(140, 'SellerList', '商家管理', '', '', '', 1, '', 0, 0, 27, 0, 0),
(141, 'SellerList', '商家管理', 'index', '商家列表', '', 1, '', 0, 1, 27, 0, 0),
(142, 'SellerList', '商家管理', 'add', '增加商家', '', 1, '', 0, 2, 27, 0, 0),
(143, 'SellerList', '商家管理', 'edit', '编辑商家', '', 1, '', 0, 2, 27, 0, 0),
(144, 'SellerList', '商家管理', 'delete', '删除商家', '', 1, '', 0, 2, 27, 0, 0),
(145, 'Adboard', '广告位置', '', '', '', 0, '', 0, 0, 4, 0, 0),
(146, 'Adboard', '广告位置', 'index', '广告位置', '', 0, '', 0, 1, 4, 0, 0),
(147, 'Adboard', '广告位置', 'add', '添加广告位置', '', 0, '', 0, 2, 4, 0, 0),
(148, 'Adboard', '广告位置', 'edit', '编辑广告位置', '', 0, '', 0, 2, 4, 0, 0),
(149, 'Adboard', '广告位置', 'delete', '删除广告位置', '', 0, '', 0, 2, 4, 0, 0),
(150, 'Ad', '广告管理', '', '', '', 0, '', 0, 0, 4, 0, 0),
(151, 'Ad', '广告管理', 'index', '广告列表', '', 0, '', 0, 1, 4, 0, 0),
(152, 'Ad', '广告位置', 'add', '添加广告', '', 0, '', 0, 2, 4, 0, 0),
(153, 'Ad', '广告位置', 'edit', '编辑广告', '', 0, '', 0, 2, 4, 0, 0),
(154, 'Ad', '广告位置', 'delete', '删除广告', '', 0, '', 0, 2, 4, 0, 0),
(155, 'User', '会员管理', '', '', '', 1, '', 0, 0, 8, 0, 0),
(156, 'User', '会员管理', 'index', '会员列表', '', 1, '', 0, 1, 8, 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `talknic_order`
--

CREATE TABLE IF NOT EXISTS `talknic_order` (
  `order_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '订单编号',
  `user_student_id` int(11) NOT NULL COMMENT '下单学员',
  `user_teacher_id` int(11) NOT NULL COMMENT '接单外教',
  `order_price` char(20) NOT NULL COMMENT '订单价格',
  `time` varchar(30) DEFAULT NULL COMMENT '完成交易时间',
  PRIMARY KEY (`order_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='订单表' AUTO_INCREMENT=75 ;

--
-- 转存表中的数据 `talknic_order`
--

INSERT INTO `talknic_order` (`order_id`, `user_student_id`, `user_teacher_id`, `order_price`, `time`) VALUES
(1, 2, 4, '13.5', NULL),
(2, 2, 4, '13.5', NULL),
(3, 2, 4, '13.5', NULL),
(4, 2, 4, '13.5', NULL),
(5, 2, 4, '13.5', NULL),
(6, 2, 4, '13.5', NULL),
(7, 5, 4, '13.5', NULL),
(8, 6, 7, '13.5', NULL),
(9, 6, 7, '13.5', NULL),
(10, 6, 7, '13.5', NULL),
(11, 6, 4, '13.5', NULL),
(12, 6, 7, '13.5', NULL),
(13, 6, 8, '13.5', NULL),
(14, 6, 9, '13.5', NULL),
(15, 6, 8, '13.5', NULL),
(16, 6, 8, '13.5', NULL),
(17, 6, 8, '13.5', NULL),
(18, 6, 7, '13.5', NULL),
(19, 6, 7, '13.5', NULL),
(20, 10, 8, '13.5', NULL),
(21, 6, 7, '13.5', NULL),
(22, 6, 8, '13.5', NULL),
(23, 6, 8, '13.5', NULL),
(24, 6, 14, '13.5', NULL),
(25, 6, 15, '13.5', NULL),
(26, 5, 16, '13.5', NULL),
(27, 5, 18, '13.5', NULL),
(28, 5, 18, '13.5', NULL),
(29, 5, 18, '13.5', NULL),
(30, 5, 18, '13.5', NULL),
(31, 5, 16, '13.5', NULL),
(32, 5, 14, '13.5', NULL),
(33, 5, 14, '13.5', NULL),
(34, 5, 14, '13.5', NULL),
(35, 5, 14, '13.5', NULL),
(36, 5, 14, '13.5', NULL),
(37, 32, 13, '13.5', NULL),
(38, 34, 16, '13.5', NULL),
(39, 34, 37, '13.5', NULL),
(40, 34, 37, '13.5', NULL),
(41, 34, 7, '13.5', NULL),
(42, 34, 8, '13.5', NULL),
(43, 34, 14, '13.5', NULL),
(44, 34, 23, '13.5', NULL),
(45, 34, 37, '13.5', NULL),
(46, 34, 37, '13.5', NULL),
(47, 34, 7, '13.5', NULL),
(48, 1, 4, '9', '2016-02-23'),
(49, 1, 4, '9', NULL),
(50, 44, 7, '13.5', NULL),
(51, 44, 7, '13.5', NULL),
(52, 44, 7, '13.5', NULL),
(53, 44, 7, '13.5', NULL),
(54, 44, 7, '13.5', NULL),
(55, 43, 8, '13.5', NULL),
(56, 44, 7, '13.5', NULL),
(57, 44, 7, '13.5', NULL),
(58, 44, 7, '13.5', NULL),
(59, 44, 7, '13.5', NULL),
(60, 44, 7, '13.5', '2016-02-23'),
(61, 34, 18, '13.5', NULL),
(62, 34, 22, '13.5', NULL),
(63, 34, 22, '13.5', NULL),
(64, 2, 7, '13.5', NULL),
(65, 77, 7, '13.5', NULL),
(66, 93, 13, '13.5', NULL),
(67, 96, 94, '13.5', NULL),
(68, 96, 94, '13.5', NULL),
(69, 96, 94, '13.5', NULL),
(70, 96, 7, '13.5', NULL),
(71, 96, 7, '13.5', NULL),
(72, 96, 7, '13.5', NULL),
(73, 77, 7, '13.5', NULL),
(74, 96, 94, '13.5', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `talknic_pay`
--

CREATE TABLE IF NOT EXISTS `talknic_pay` (
  `pay_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '支付方式编号',
  `pay_name` char(20) NOT NULL COMMENT '支付方式名称',
  `pay_pic` char(40) NOT NULL COMMENT '支付方式LOGO',
  PRIMARY KEY (`pay_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='支付方式表' AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `talknic_pay`
--


-- --------------------------------------------------------

--
-- 表的结构 `talknic_praise`
--

CREATE TABLE IF NOT EXISTS `talknic_praise` (
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `praise_id` text COMMENT '点赞人ID'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='点赞表';

--
-- 转存表中的数据 `talknic_praise`
--

INSERT INTO `talknic_praise` (`user_id`, `praise_id`) VALUES
(4, '2'),
(7, '6'),
(8, '6,95'),
(30, '43'),
(41, '34'),
(94, '96,95');

-- --------------------------------------------------------

--
-- 表的结构 `talknic_recharge_record`
--

CREATE TABLE IF NOT EXISTS `talknic_recharge_record` (
  `recharge_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '充值ID',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `recharge_type` varchar(30) NOT NULL COMMENT '充值类型',
  `recharge_money` varchar(30) NOT NULL COMMENT '充值金额',
  `recharge_time` varchar(30) NOT NULL COMMENT '充值时间',
  PRIMARY KEY (`recharge_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='充值记录表' AUTO_INCREMENT=40 ;

--
-- 转存表中的数据 `talknic_recharge_record`
--

INSERT INTO `talknic_recharge_record` (`recharge_id`, `user_id`, `recharge_type`, `recharge_money`, `recharge_time`) VALUES
(1, 1, '', '10', '2016-02-23'),
(2, 1, '', '10', '2016-02-23'),
(3, 1, '', '10', '2016-02-23'),
(4, 44, '', '10', '2016-02-23'),
(5, 44, '', '10', '2016-02-23'),
(6, 44, '', '0.01', '2016-02-23'),
(7, 44, '', '10', '2016-02-23'),
(8, 44, '', '10', '2016-02-23'),
(9, 44, '', '10', '2016-02-23'),
(10, 44, '', '10', '2016-02-23'),
(11, 44, '', '10', '2016-02-23'),
(12, 44, '', '10', '2016-02-23'),
(13, 44, '', '10', '2016-02-23'),
(14, 44, '', '10', '2016-02-23'),
(15, 44, '', '10', '2016-02-23'),
(16, 44, '', '10', '2016-02-23'),
(17, 44, '', '10', '2016-02-23'),
(18, 44, '', '10', '2016-02-23'),
(19, 96, '', '10', '2016-02-24'),
(20, 44, '', '10', '2016-02-25'),
(21, 44, '', '10', '2016-02-25'),
(22, 44, '', '10', '2016-02-25'),
(23, 44, '', '10', '2016-02-25'),
(24, 44, '', '10', '2016-02-25'),
(25, 44, '', '10', '2016-02-25'),
(26, 44, '', '10', '2016-02-25'),
(27, 44, '', '10', '2016-02-25'),
(28, 44, '', '10', '2016-02-25'),
(29, 44, '', '10', '2016-02-25'),
(30, 44, '', '10', '2016-02-25'),
(31, 44, '', '10', '2016-02-25'),
(32, 44, '', '10', '2016-02-25'),
(33, 44, '', '10', '2016-02-25'),
(34, 44, '', '10', '2016-02-25'),
(35, 44, '', '10', '2016-02-25'),
(36, 44, '', '10', '2016-02-25'),
(37, 44, '', '10', '2016-02-25'),
(38, 129, '', '10', '2016-02-25'),
(39, 44, '', '10', '2016-02-25');

-- --------------------------------------------------------

--
-- 表的结构 `talknic_role`
--

CREATE TABLE IF NOT EXISTS `talknic_role` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `status` tinyint(1) unsigned DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `create_time` int(11) unsigned NOT NULL,
  `update_time` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `talknic_role`
--

INSERT INTO `talknic_role` (`id`, `name`, `status`, `remark`, `create_time`, `update_time`) VALUES
(1, '管理员', 1, '管理员1', 1208784792, 1254325558),
(2, '编辑', 1, '编辑', 1208784792, 1254325558),
(4, 'SEO', 1, '优化', 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `talknic_seller_cate`
--

CREATE TABLE IF NOT EXISTS `talknic_seller_cate` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `cid` int(8) NOT NULL,
  `name` varchar(200) NOT NULL,
  `count` int(8) NOT NULL,
  `seller_status` int(1) NOT NULL DEFAULT '1',
  `status` int(1) NOT NULL,
  `sort` int(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cid` (`cid`),
  KEY `index_status` (`status`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=123 ;

--
-- 转存表中的数据 `talknic_seller_cate`
--

INSERT INTO `talknic_seller_cate` (`id`, `cid`, `name`, `count`, `seller_status`, `status`, `sort`) VALUES
(122, 22, '食品饮料', 31, 1, 1, 10),
(121, 21, '箱包皮具', 29, 1, 1, 10),
(120, 20, '宠物用品', 1, 0, 1, 10),
(119, 19, '成人保健', 6, 0, 1, 10),
(118, 18, '饰品配饰', 31, 1, 1, 10),
(117, 17, '汽车用品', 7, 0, 1, 10),
(116, 16, '旅游订票', 1, 0, 1, 10),
(115, 15, '钟表眼镜', 17, 1, 1, 10),
(103, 3, '电脑笔记本', 15, 1, 1, 10),
(102, 2, '手机数码', 19, 1, 1, 10),
(114, 14, '药品保健', 8, 1, 1, 10),
(113, 13, '数字卡软件', 2, 0, 1, 10),
(112, 12, '玩具礼品', 6, 0, 1, 10),
(111, 11, '办公用品', 6, 0, 1, 10),
(110, 10, '母婴用品', 14, 1, 1, 10),
(109, 9, '居家生活', 24, 1, 1, 10),
(108, 8, '家用电器', 19, 1, 1, 10),
(107, 7, '户外休闲', 3, 0, 1, 10),
(106, 6, '综合百货', 22, 1, 1, 10),
(105, 5, '化妆美容', 41, 1, 1, 10),
(104, 4, '服装服饰', 85, 1, 1, 10),
(101, 1, '图书音像', 15, 1, 1, 10);

-- --------------------------------------------------------

--
-- 表的结构 `talknic_seller_list`
--

CREATE TABLE IF NOT EXISTS `talknic_seller_list` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `sid` int(8) NOT NULL,
  `cate_id` int(8) NOT NULL,
  `name` varchar(200) NOT NULL,
  `site_logo` varchar(200) DEFAULT NULL,
  `net_logo` varchar(200) NOT NULL,
  `recommend` int(1) NOT NULL,
  `click_url` varchar(400) NOT NULL,
  `sort` int(6) NOT NULL,
  `description` varchar(200) NOT NULL,
  `freeshipment` int(1) NOT NULL,
  `installment` int(1) NOT NULL,
  `has_invoice` int(1) NOT NULL,
  `cash_back_rate` varchar(64) NOT NULL,
  `status` int(1) NOT NULL,
  `update_time` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_status` (`status`),
  KEY `index_recommend` (`recommend`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=41 ;

--
-- 转存表中的数据 `talknic_seller_list`
--


-- --------------------------------------------------------

--
-- 表的结构 `talknic_seller_list_cate`
--

CREATE TABLE IF NOT EXISTS `talknic_seller_list_cate` (
  `list_id` int(11) NOT NULL,
  `cate_id` int(11) NOT NULL,
  KEY `list_id` (`list_id`),
  KEY `cate_id` (`cate_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `talknic_seller_list_cate`
--


-- --------------------------------------------------------

--
-- 表的结构 `talknic_setting`
--

CREATE TABLE IF NOT EXISTS `talknic_setting` (
  `name` varchar(100) NOT NULL,
  `data` text NOT NULL,
  KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `talknic_setting`
--

INSERT INTO `talknic_setting` (`name`, `data`) VALUES
('site_name', 'Talknic移动后台管理系统'),
('site_title', 'Talknic移动后台管理系统'),
('site_keyword', 'Talknic移动后台管理系统,www.baiwushi.cn,网络白武士'),
('site_description', 'Talknic是一款移动互联网应用软件，由www.baiwushi.cn 提供'),
('site_status', '1'),
('site_icp', '京ICP备88888888号'),
('statistics_code', ''),
('closed_reason', '升级'),
('site_domain', 'http://www.baiwushi.cn'),
('weibo_url', 'http://www.weibo.com'),
('qqzone_url', ''),
('douban_url', ''),
('attachment_size', '3145728'),
('template', 'default'),
('taobao_app_key', '12504724'),
('qq_app_key', ''),
('qq_app_Secret', ''),
('sina_app_key', '100308089'),
('sina_app_Secret', '25ee4d31ca98edea230885985e1cf2e1'),
('taobao_app_secret', '9d6877190386092d4288dcae32811081'),
('url_model', '0'),
('attachment_path', 'data/uploads'),
('client_hash', ''),
('attachment_type', 'jpg,gif,png,jpeg'),
('miao_appkey', '1003336'),
('miao_appsecret', '0847c5008f99150de65fad8e8ec342fa'),
('mail_smtp', 'smtp.163.com'),
('mail_username', 'ho1000003@163.com\r\nho1000004@163.com\r\nho1000005@163.com\r\nhml100000@163.com'),
('mail_password', 'PassWord01!'),
('mail_port', '25'),
('mail_fromname', 'CharlesWCms'),
('check_code', '1'),
('comment_time', '10'),
('site_share', '<meta property=\\"qc:admins\\" content=\\"271503564761116217636\\" />'),
('ban_sipder', 'youdaobot|bingbot'),
('ban_ip', '192.168.1.50'),
('site_logo', './data/setting/524a5cbde8499.jpg'),
('article_count', '10'),
('html_suffix', '.html'),
('mail_username', 'ho1000003@163.com\r\nho1000004@163.com\r\nho1000005@163.com\r\nhml100000@163.com'),
('mail_receive_username', ''),
('mail_content', '<body style=\\"margin: 10px;\\">\r\n<div align=\\"center\\"><img src=\\"http://www.baiwushi.cn/static/images/common/logo.png\\"></div><br>\r\n<br>\r\n <h3>欢迎使用 CharlesW cms 此系统由网络白武士 <a href=\\"http://www.baiwushi.cn\\" target=\\"_blank\\">baiwushi.cn</a>提供 </h3>\r\n<br>\r\n\r\n在使用中遇到任何问题，请到phonegap中文网提出，感谢大家对此程序的支持，我们的qq群：295402925\r\n\r\n</body>'),
('mail_title', '欢迎使用CharlesW cms，这是一封感谢信');

-- --------------------------------------------------------

--
-- 表的结构 `talknic_student_tmp`
--

CREATE TABLE IF NOT EXISTS `talknic_student_tmp` (
  `tmp_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '临时用户编号',
  `tmp_name` char(10) NOT NULL COMMENT '临时用户登录账号',
  `tmp_status` int(11) DEFAULT '0' COMMENT '临时账号的状态',
  `tmp_createtime` char(20) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`tmp_id`),
  UNIQUE KEY `tmp_name` (`tmp_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='临时用户表' AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `talknic_student_tmp`
--


-- --------------------------------------------------------

--
-- 表的结构 `talknic_tmp_captcha`
--

CREATE TABLE IF NOT EXISTS `talknic_tmp_captcha` (
  `captcha_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tel` varchar(255) NOT NULL COMMENT '电话号码',
  `captcha` varchar(20) NOT NULL COMMENT '验证码',
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`captcha_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='验证码表' AUTO_INCREMENT=188 ;

--
-- 转存表中的数据 `talknic_tmp_captcha`
--

INSERT INTO `talknic_tmp_captcha` (`captcha_id`, `tel`, `captcha`, `create_time`) VALUES
(1, '13261301673', '123456', 1455876935),
(2, '13333333333', '123456', 1455877093),
(3, '13261301674', '123456', 1455877122),
(4, '13810170477', '123456', 1455877136),
(5, '13810170476', '123456', 1456064758),
(6, '13355552222', '123456', 1456105502),
(7, '13261301690', '123456', 1456105521),
(173, '13300000000', '123456', 1456374420),
(9, '13312344321', '123456', 1456106472),
(10, '13300009999', '123456', 1456106528),
(11, '13378900987', '123456', 1456107651),
(12, '13377773333', '123456', 1456111501),
(13, '18833332222', '123456', 1456119779),
(14, '18844445555', '123456', 1456120229),
(15, '18877778888', '123456', 1456121605),
(16, '18888889999', '123456', 1456121819),
(17, '17722223333', '123456', 1456122320),
(18, '15556669999', '123456', 1456122655),
(19, '13333330000', '123456', 1456123179),
(20, '18888880000', '123456', 1456123270),
(21, '13333344444', '123456', 1456128393),
(22, '15555566666', '123456', 1456128520),
(23, '13222222222', '123456', 1456131435),
(24, '18866669999', '123456', 1456133966),
(25, '13233333333', '123456', 1456135685),
(26, '13244444444', '123456', 1456135803),
(27, '13255555555', '123456', 1456135952),
(28, '13266666666', '123456', 1456136076),
(29, '13277777777', '123456', 1456136176),
(30, '13288888888', '123456', 1456136258),
(31, '13788889999', '123456', 1456136674),
(32, '15666666666', '123456', 1456136926),
(33, '15222222222', '123456', 1456137044),
(34, '13666666666', '123456', 1456137348),
(39, '18099965336', '123456', 1456203022),
(75, '13522238604', '123456', 1456225234),
(38, '15210648180', '123456', 1456203004),
(45, '13811112222', '123456', 1456203858),
(128, '13822223333', '123456', 1456280875),
(46, '13911112222', '123456', 1456203871),
(47, '13422223333', '123456', 1456204049),
(49, '13611112222', '123456', 1456204220),
(53, '13678787878', '123456', 1456204610),
(54, '13789898989', '123456', 1456204686),
(127, '13866667777', '123456', 1456280571),
(59, '15010713631', '123456', 1456204946),
(58, '13899990000', '123456', 1456204885),
(60, '15010713632', '123456', 1456204966),
(61, '13877779999', '123456', 1456205001),
(73, '13300004444', '123456', 1456222263),
(72, '13521626327', '123456', 1456218036),
(65, '13810170466', '123456', 1456205509),
(66, '13810170455', '123456', 1456205607),
(67, '13633334444', '123456', 1456205882),
(76, '13822222222', '123456', 1456225421),
(77, '15811151831', '123456', 1456225759),
(78, '13555555555', '123456', 1456225804),
(99, '15701690165', '123456', 1456232888),
(85, '15538181022', '123456', 1456226609),
(88, '15701690166', '123456', 1456226968),
(106, '15010713630', '123456', 1456277902),
(93, '98u9upu@qq.cp', '962863', 1456227258),
(94, '13718694706', '123456', 1456227304),
(95, 'Addams@qq.co', '518500', 1456227926),
(96, 'Add@qq.co', '322184', 1456227958),
(97, '13261111111', '123456', 1456228057),
(98, 'Afdsafdafa@asd.co', '869439', 1456228711),
(100, '13822225555', '123456', 1456235800),
(101, '13655552222', '123456', 1456235912),
(102, '13655552223', '123456', 1456235938),
(103, '13288888887', '123456', 1456277746),
(104, '15701690163', '123456', 1456277814),
(105, '15701690169', '123456', 1456277840),
(107, '13260000000', '123456', 1456278019),
(108, '13210000000', '123456', 1456278090),
(109, '18206429501', '123456', 1456278226),
(110, '18206429503', '123456', 1456278411),
(111, '13220000000', '123456', 1456278441),
(112, '18206429504', '123456', 1456278648),
(113, '13230000000', '123456', 1456278812),
(118, '441196110@qq.com', '735405', 1456279067),
(116, '441196110@qq.co', '420789', 1456278935),
(117, '13240000000', '123456', 1456279005),
(119, '13250000000', '123456', 1456279432),
(120, '13270000000', '123456', 1456279508),
(121, '13280000000', '123456', 1456279628),
(122, '13211111111', '123456', 1456279643),
(123, '13290000000', '123456', 1456280043),
(124, '13211111112', '123456', 1456280147),
(125, '13211111113', '123456', 1456280360),
(126, '13855556666', '123456', 1456280498),
(129, '13856565656', '123456', 1456281214),
(130, '13756565656', '123456', 1456281293),
(131, '13710140476', '123456', 1456281581),
(132, '15899998888', '123456', 1456281686),
(133, '15866667777', '123456', 1456281954),
(134, '13566667777', '123456', 1456282073),
(135, '13241111111', '123456', 1456282157),
(136, '13511111111', '123456', 1456282208),
(138, '13122924103', '123456', 1456293461),
(139, '15538181021', '123456', 1456296495),
(140, 'lingyi.kong@talknic.cn', '122884', 1456297244),
(142, '13344556677', '123456', 1456309904),
(143, '13366669999', '123456', 1456366950),
(144, '13344440000', '123456', 1456367295),
(145, '13344445555', '123456', 1456367356),
(146, '18822223333', '123456', 1456369508),
(147, '18833334444', '123456', 1456369690),
(148, '13212345678', '123456', 1456369825),
(149, '13212221122', '123456', 1456370381),
(150, '13212312311', '123456', 1456370856),
(151, '13223121121', '123456', 1456371108),
(152, '13212231221', '123456', 1456371382),
(153, '13212234122', '123456', 1456371496),
(154, '13261381231', '123456', 1456371643),
(155, '13212312312', '123456', 1456371732),
(156, '13212321211', '123456', 1456371824),
(157, '13256421312', '123456', 1456371946),
(158, '13256321224', '123456', 1456372083),
(159, '13256123121', '123456', 1456372220),
(160, '13251123232', '123456', 1456372289),
(161, '13251343454', '123456', 1456372349),
(162, '13267890987', '123456', 1456372410),
(163, '13261234543', '123456', 1456372454),
(164, '13267231211', '123456', 1456372531),
(165, '13267896672', '123456', 1456372611),
(166, '13267832123', '123456', 1456372939),
(167, '13366668888', '123456', 1456373602),
(168, '13256789087', '123456', 1456373725),
(169, '13355556666', '123456', 1456373836),
(170, '13444444444', '123456', 1456373911),
(171, '13256789752', '123456', 1456373912),
(172, '13245654345', '123456', 1456374048),
(174, '13455558888', '123456', 1456374575),
(175, '13412345622', '123456', 1456374659),
(176, '13212312323', '123456', 1456375053),
(177, '13655554444', '123456', 1456375447),
(179, '13699998888', '123456', 1456375906),
(180, '13261472581', '123456', 1456376719),
(181, '13212323423', '123456', 1456376990),
(182, '13212342351', '123456', 1456377333),
(183, '15538181000', '123456', 1456377371),
(184, '13287123213', '123456', 1456377730),
(185, '15844445555', '123456', 1456380879),
(186, '15833335555', '123456', 1456380957),
(187, 'rex.zou@talknic.cn', '765055', 1456381815);

-- --------------------------------------------------------

--
-- 表的结构 `talknic_topic`
--

CREATE TABLE IF NOT EXISTS `talknic_topic` (
  `topic_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '话题编号',
  `user_id` int(10) unsigned NOT NULL COMMENT '用户ID',
  `topic_cat` char(40) DEFAULT NULL COMMENT '话题名称（话题分类）',
  `available_time` char(40) NOT NULL COMMENT '可用时间',
  `topic_content` varchar(450) DEFAULT NULL COMMENT 'topic内容',
  `create_time` char(20) NOT NULL COMMENT '插入时间',
  PRIMARY KEY (`topic_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='话题表' AUTO_INCREMENT=52 ;

--
-- 转存表中的数据 `talknic_topic`
--

INSERT INTO `talknic_topic` (`topic_id`, `user_id`, `topic_cat`, `available_time`, `topic_content`, `create_time`) VALUES
(1, 14, 'travel,film', '12:55-12:00', NULL, '1456123762'),
(2, 14, 'travel,sports,design,cook,film,tech,arts', '1:00-1:00', NULL, '1456123789'),
(3, 14, 'travel,sports,design,cook,film,tech,arts', '1:00-1:00', NULL, '1456123859'),
(4, 14, 'travel,sports,design,cook,film,tech,arts', '1:00-1:00', NULL, '1456124056'),
(5, 14, 'travel,sports,design,cook,film,tech,arts', '1:00-1:00', NULL, '1456124065'),
(6, 14, 'travel,sports,design,cook,film,tech,arts', '1:15-2:00', NULL, '1456124085'),
(7, 14, 'travel,sports,design,cook,film,tech,arts', '12:15-7:00', NULL, '1456124221'),
(8, 14, 'travel,sports,design,cook,film,tech,arts', '12:15-7:00', NULL, '1456124237'),
(9, 14, 'cook', '12:55-12:55', NULL, '1456126786'),
(10, 14, 'book', '1:00-1:00', NULL, '1456127502'),
(11, 33, 'travel,sports,design,cook,film,tech,arts', '1:00-2:00', NULL, '1456203324'),
(12, 33, 'travel,sports,design,cook,film,tech,arts', '1:00-2:00', NULL, '1456203331'),
(13, 33, 'travel,sports,design,cook,film,tech,arts', '1:00-2:00', NULL, '1456203640'),
(14, 94, 'travel,sports,design', '8:30-8:40', NULL, '1456294804'),
(15, 94, 'travel,sports,design', '8:30-8:40', NULL, '1456294813'),
(16, 97, 'travel,sports', '1:10-1:40', NULL, '1456296780'),
(17, 97, 'travel,sports', '1:10-1:40', NULL, '1456296787'),
(18, 50, 'sports', '1:00-3:00', NULL, '1456367928'),
(19, 50, 'design', '1:00-3:00', NULL, '1456368043'),
(20, 50, 'design', '1:00-3:00', NULL, '1456368278'),
(21, 50, 'design', '1:00-3:00', NULL, '1456368538'),
(22, 50, 'sports', '1:00-4:00', NULL, '1456369111'),
(23, 50, 'design', '1:00-4:00', NULL, '1456369497'),
(24, 50, 'design', '1:00-3:00', NULL, '1456369681'),
(25, 50, 'sports,design', '1:00-7:00', NULL, '1456370194'),
(26, 50, 'sports', '1:00-7:00', NULL, '1456370328'),
(27, 50, 'design', '1:00-3:00', NULL, '1456370555'),
(28, 50, 'design', '1:00-2:00', NULL, '1456370724'),
(29, 50, 'design', '1:00-2:00', NULL, '1456370740'),
(30, 50, 'sports', '1:00-8:00', NULL, '1456370755'),
(31, 50, 'sports', '1:00-2:00', NULL, '1456370797'),
(32, 50, 'design', '1:00-1:00', NULL, '1456370827'),
(33, 50, 'sports', '1:00-2:00', NULL, '1456370900'),
(34, 50, 'sports', '1:10-1:00', NULL, '1456371033'),
(35, 50, 'sports,film', '12:00-1:00', NULL, '1456371120'),
(36, 50, 'travel,film', '3:00-1:10', NULL, '1456371221'),
(37, 127, 'design,book', '1:00-8:00', NULL, '1456374022'),
(38, 138, 'travel,sports', '1:00-1:15', NULL, '1456377457'),
(39, 138, 'travel,sports', '1:00-1:15', NULL, '1456377465'),
(40, 50, 'sports,design', '1:00-1:05', NULL, '1456380341'),
(41, 50, 'sports,design', '1:00-1:10', NULL, '1456380376'),
(42, 138, 'design,arts', '3:05-3:35', NULL, '1456380982'),
(43, 138, 'design,arts', '3:05-3:35', NULL, '1456380986'),
(44, 138, 'design,arts', '3:05-3:35', NULL, '1456381379'),
(45, 138, 'design,arts', '3:05-3:35', NULL, '1456381414'),
(46, 50, 'design', '1:00-1:10', NULL, '1456381569'),
(47, 50, 'cook', '1:00-3:00', NULL, '1456381669'),
(48, 50, 'design', '1:00-1:05', NULL, '1456381813'),
(49, 50, 'tech,arts', '1:00-2:00', NULL, '1456381832'),
(50, 138, 'sports,design', '1:10-1:30', NULL, '1456381867'),
(51, 138, 'design', '1:05-1:35', NULL, '1456382235');

-- --------------------------------------------------------

--
-- 表的结构 `talknic_trading_record`
--

CREATE TABLE IF NOT EXISTS `talknic_trading_record` (
  `trading_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '交易ID',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `pay_type` varchar(30) NOT NULL COMMENT '交易方式',
  `pay_money` varchar(30) NOT NULL COMMENT '交易金额',
  `pay_time` varchar(30) NOT NULL COMMENT '交易时间',
  PRIMARY KEY (`trading_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='交易记录表' AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `talknic_trading_record`
--


-- --------------------------------------------------------

--
-- 表的结构 `talknic_user`
--

CREATE TABLE IF NOT EXISTS `talknic_user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `user_name` varchar(255) NOT NULL COMMENT '用户名',
  `user_pwd` varchar(55) NOT NULL COMMENT '用户密码',
  `user_pic` varchar(255) NOT NULL DEFAULT 'user.png' COMMENT '用户头像路径',
  `user_level` varchar(20) DEFAULT NULL COMMENT '用户水平',
  `user_alipay` varchar(55) DEFAULT NULL COMMENT '支付宝账号',
  `user_bank` int(20) DEFAULT NULL COMMENT '银行卡号',
  `user_allscore` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '金额',
  `user_fans` int(11) DEFAULT '0' COMMENT '粉丝数',
  `user_praise` int(11) DEFAULT '0' COMMENT '点赞数',
  `facebook` varchar(255) DEFAULT NULL COMMENT 'facebook',
  `wechat` varchar(255) DEFAULT NULL COMMENT '微信(openid)',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `sina` varchar(255) DEFAULT NULL COMMENT '新浪微博(uid)',
  `user_create_time` char(20) DEFAULT NULL COMMENT '创建时间',
  `user_email` char(40) DEFAULT NULL COMMENT '邮箱',
  `nationality` varchar(255) DEFAULT NULL COMMENT '国籍',
  `occupation` varchar(255) DEFAULT NULL COMMENT '城市',
  `biography` text COMMENT '话题',
  `user_real_name` char(20) DEFAULT NULL COMMENT '姓名',
  `user_first_login` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否第一次登录',
  `user_sex` tinyint(4) NOT NULL DEFAULT '0' COMMENT '性别',
  `user_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '用户类型,1外教，0学员',
  `user_status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '用户状态',
  `user_online` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否在线',
  `score` int(11) DEFAULT '0' COMMENT '积分',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_name` (`user_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='用户表' AUTO_INCREMENT=143 ;

--
-- 转存表中的数据 `talknic_user`
--

INSERT INTO `talknic_user` (`user_id`, `user_name`, `user_pwd`, `user_pic`, `user_level`, `user_alipay`, `user_bank`, `user_allscore`, `user_fans`, `user_praise`, `facebook`, `wechat`, `email`, `sina`, `user_create_time`, `user_email`, `nationality`, `occupation`, `biography`, `user_real_name`, `user_first_login`, `user_sex`, `user_type`, `user_status`, `user_online`, `score`) VALUES
(1, '13261301673', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'beginner', NULL, NULL, 10, 0, 0, NULL, NULL, NULL, NULL, '1455876940', NULL, NULL, NULL, NULL, '123', 1, 2, 0, 1, 0, NULL),
(2, '13333333333', '81dc9bdb52d04dc20036dbd8313ed055', 'http://115.47.28.121/Talknic1.0/data/uploads/56c6ec1c84382.jpg', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1455877104', NULL, NULL, NULL, '哈哈哈', '哈哈哈', 1, 0, 0, 1, 0, NULL),
(3, '13261301674', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'junior', NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1455877129', NULL, NULL, NULL, '', '123', 1, 2, 0, 1, 0, NULL),
(4, '13810170477', 'e10adc3949ba59abbe56e057f20f883e', 'http://115.47.28.121/Talknic1.0/data/uploads/56c6ecb422e5f.jpg', NULL, NULL, NULL, 20, 0, 1, NULL, NULL, NULL, NULL, '1455877140', NULL, '我们的', '连连看', '哦哦哦哦', '我们', 1, 2, 1, 1, 0, NULL),
(5, '13810170476', 'b59c67bf196a4758191e42f76670ceba', 'http://115.47.28.121/Talknic1.0/data/uploads/56cab2a4e18ee.jpg', 'beginner', NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456064763', NULL, NULL, NULL, '', '111', 1, 2, 0, 1, 0, NULL),
(6, '13355552222', '81dc9bdb52d04dc20036dbd8313ed055', 'http://115.47.28.121/Talknic1.0/data/uploads/56ca965f50ce2.jpg', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456105509', NULL, NULL, NULL, '哈哈', '呵呵', 1, 0, 0, 1, 0, NULL),
(7, '13261301690', 'e10adc3949ba59abbe56e057f20f883e', 'http://115.47.28.121/Talknic1.0/data/uploads/56ca6a0aa0caa.jpg', NULL, NULL, NULL, 15, 0, 1, NULL, NULL, NULL, NULL, '1456105529', NULL, 'Awe', 'Awe', 'Aaaa', 'Www', 1, 2, 1, 1, 0, NULL),
(8, '13300009999', 'e10adc3949ba59abbe56e057f20f883e', 'http://115.47.28.121/Talknic1.0/data/uploads/56ca6c67dafa9.jpg', NULL, NULL, NULL, 0, 0, 2, NULL, NULL, NULL, NULL, '1456106533', NULL, '111', '2324', '1231', 'Assad', 1, 2, 1, 1, 0, NULL),
(9, '13378900987', 'e10adc3949ba59abbe56e057f20f883e', 'http://115.47.28.121/Talknic1.0/data/uploads/56ca70c5c78c5.jpg', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456107658', NULL, NULL, NULL, '123123', 'Wudi', 1, 0, 1, 1, 0, NULL),
(10, '13377773333', '81dc9bdb52d04dc20036dbd8313ed055', 'http://115.47.28.121/Talknic1.0/data/uploads/56ca7faea46c2.jpg', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456111507', NULL, NULL, NULL, '', '', 1, 0, 0, 1, 0, NULL),
(11, '18833332222', '81dc9bdb52d04dc20036dbd8313ed055', 'http://115.47.28.121/Talknic1.0/data/uploads/56caa018cae43.jpg', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456119785', NULL, NULL, NULL, '盖茨基金会', '海边', 1, 0, 1, 1, 0, NULL),
(12, '18844445555', '81dc9bdb52d04dc20036dbd8313ed055', 'http://115.47.28.121/Talknic1.0/data/uploads/56caa1ccf0721.jpg', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456120240', NULL, NULL, NULL, '华丽集锦', '华丽集锦', 1, 0, 1, 1, 0, NULL),
(13, '18877778888', '81dc9bdb52d04dc20036dbd8313ed055', 'user.png', NULL, NULL, NULL, 30, 0, 0, NULL, NULL, NULL, NULL, '1456121610', NULL, '盖茨', '哈哈哈', '哈哈哈', '盖茨', 1, 2, 1, 1, 0, NULL),
(14, '18888889999', '81dc9bdb52d04dc20036dbd8313ed055', 'http://115.47.28.121/Talknic1.0/data/uploads/56cab0e0b5a51.jpg', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456121823', NULL, '盖茨', '还摸', '哈哈咳咳', '哈哈哈哈哈', 1, 2, 1, 1, 0, NULL),
(15, '17722223333', '81dc9bdb52d04dc20036dbd8313ed055', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456122325', NULL, '痛苦了', '同', '来咯', '盖茨', 1, 2, 1, 1, 0, NULL),
(16, '15556669999', 'b59c67bf196a4758191e42f76670ceba', 'http://115.47.28.121/Talknic1.0/data/uploads/56caab99bc335.jpg', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456122666', NULL, '你说', '不能自拔', '我想要是个', '我想要', 1, 2, 1, 1, 0, NULL),
(17, '13333330000', 'e10adc3949ba59abbe56e057f20f883e', 'http://115.47.28.121/Talknic1.0/data/uploads/56caad4eca680.jpg', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456123183', NULL, NULL, NULL, '一我们', '哦哦噢噢', 1, 0, 1, 1, 0, NULL),
(18, '18888880000', 'e10adc3949ba59abbe56e057f20f883e', 'http://115.47.28.121/Talknic1.0/data/uploads/56caadd804e3f.jpg', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456123272', NULL, '啊 dasd', '11111', '23123', '舞蹈家', 1, 2, 1, 1, 0, NULL),
(19, '13333344444', 'b59c67bf196a4758191e42f76670ceba', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456128400', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 1, 0, NULL),
(20, '15555566666', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'beginner', NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456128528', NULL, NULL, NULL, NULL, '111', 1, 2, 0, 1, 0, NULL),
(21, '13222222222', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456131441', NULL, '123', '123', '123', '123', 1, 2, 1, 1, 0, NULL),
(22, '18866669999', '81dc9bdb52d04dc20036dbd8313ed055', 'http://115.47.28.121/Talknic1.0/data/uploads/56caddfb8a84e.jpg', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456133973', NULL, '哈哈', '哈哈', '来吧', '哈哈哈', 1, 2, 1, 1, 0, NULL),
(23, '13233333333', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456135688', NULL, '123', '123', '123', '123', 1, 2, 1, 1, 0, NULL),
(24, '13244444444', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456135807', NULL, '123', '123', '123', '123', 1, 2, 1, 1, 0, NULL),
(25, '13255555555', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456135956', NULL, '123', '123', '123', '123', 1, 2, 1, 1, 0, NULL),
(26, '13266666666', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456136080', NULL, '12', '12', '2', '123123', 1, 2, 1, 1, 0, NULL),
(27, '13277777777', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456136180', NULL, 'Add', 'Asda', 'As', '123', 1, 2, 1, 1, 0, NULL),
(28, '13288888888', '4297f44b13955235245b2497399d7a93', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456136265', NULL, 'Add', 'Asdasd', 'As', 'Add', 1, 2, 1, 1, 0, NULL),
(29, '13788889999', 'b59c67bf196a4758191e42f76670ceba', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456136678', NULL, 'DaA', 'Dad', 'Dada', 'As', 1, 2, 1, 1, 0, NULL),
(30, '15666666666', '81dc9bdb52d04dc20036dbd8313ed055', 'user.png', NULL, NULL, NULL, 0, 0, 1, NULL, NULL, NULL, NULL, '1456136932', NULL, '哈哈', '哈哈', '哈哈', '哈哈', 1, 2, 1, 1, 0, NULL),
(31, '15222222222', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456137049', NULL, '哈哈', '哈哈哈', '哈哈哈哈', '哈哈', 1, 2, 1, 1, 0, NULL),
(32, '13666666666', '81dc9bdb52d04dc20036dbd8313ed055', 'user.png', 'junior', NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456137353', NULL, NULL, NULL, NULL, '他咯', 1, 2, 0, 1, 0, NULL),
(33, 'o3LYLuJqlWQBKwaUuLq7bBDUfegY', 'o3LYLuJqlWQBKwaUuLq7bBDUfegY', 'http://115.47.28.121/Talknic1.0/data/uploads/56cbe8a30bc05.jpg', NULL, NULL, NULL, 0, 0, 0, NULL, 'o3LYLuJqlWQBKwaUuLq7bBDUfegY', NULL, NULL, '1456203177', NULL, NULL, NULL, 'ok', '我会很少', 0, 0, 1, 1, 0, NULL),
(34, '15010713630', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'beginner', NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456203520', NULL, NULL, NULL, '哭了魔', 'julye', 1, 1, 0, 1, 0, NULL),
(35, '15010713631', '', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456204952', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, 0, NULL),
(36, '15010713632', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456204972', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 1, 0, NULL),
(37, '13633334444', 'b59c67bf196a4758191e42f76670ceba', 'http://115.47.28.121/Talknic1.0/data/uploads/56cbf0b1f0f4d.jpg', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456205890', NULL, 'Dad', 'Did', 'Did', 'Aadddddd', 1, 2, 1, 1, 0, NULL),
(38, 'o3LYLuNhDQmCnvunDCd_X4VkB5Q4', 'o3LYLuNhDQmCnvunDCd_X4VkB5Q4', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, 'o3LYLuNhDQmCnvunDCd_X4VkB5Q4', NULL, NULL, '1456211261', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, 0, NULL),
(39, 'kB5Q4', 'kB5Q4', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, 'kB5Q4', NULL, NULL, '1456211906', NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 1, 0, NULL),
(40, 'o3LYLuK5G1GnP2QGvBNAJdcnZInM', 'o3LYLuK5G1GnP2QGvBNAJdcnZInM', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, 'o3LYLuK5G1GnP2QGvBNAJdcnZInM', NULL, NULL, '1456213345', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, 0, NULL),
(41, '13521626327', '96e79218965eb72c92a549dd5a330112', 'http://115.47.28.121/Talknic1.0/data/uploads/56cc204f1e52c.jpg', NULL, NULL, NULL, 0, 0, 1, NULL, NULL, NULL, NULL, '1456218045', NULL, '11', '11', 'Wrwewrw', 'We''re wee', 1, 1, 1, 1, 0, NULL),
(42, '13822222222', '202cb962ac59075b964b07152d234b70', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456225428', NULL, 'Wee', 'Did', 'Dfsd', 'Gang', 1, 2, 1, 1, 0, NULL),
(43, '13555555555', '202cb962ac59075b964b07152d234b70', 'user.png', 'beginner', NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456225807', NULL, NULL, NULL, NULL, 'Gg', 1, 2, 0, 1, 0, NULL),
(44, '15811151831', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'beginner', NULL, NULL, 315, 0, 0, NULL, NULL, NULL, NULL, '1456225850', NULL, NULL, NULL, NULL, 'Bihar', 1, 2, 0, 1, 0, NULL),
(45, '2951051727', '2951051727', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, '2951051727', '1456226353', NULL, NULL, NULL, '', '555', 0, 0, 1, 1, 0, NULL),
(46, '15538181022', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'beginner', NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456226614', NULL, NULL, NULL, NULL, 'wuhaiwei', 1, 2, 0, 1, 0, NULL),
(47, '15701690165', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456226696', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, NULL),
(48, '15701690166', '', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456226972', NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 1, 0, NULL),
(49, '2789974421', '2789974421', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, '2789974421', '1456227030', NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 1, 0, NULL),
(50, '13718694706', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456227322', NULL, 'Zhongguo', 'Chengxuyuan ', 'Faf', 'sabo', 1, 2, 1, 1, 0, NULL),
(51, '13261111111', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456228062', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 1, 0, NULL),
(52, '5866084044', '5866084044', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, '5866084044', '1456229007', NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 1, 0, NULL),
(53, '5790189457', '5790189457', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, '5790189457', '1456229321', NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 1, 0, NULL),
(54, '5865738174', '5865738174', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, '5865738174', '1456229482', NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 1, 0, NULL),
(55, '5866085947', '5866085947', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, '5866085947', '1456230224', NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 1, 0, NULL),
(56, '5865741434', '5865741434', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, '5865741434', '1456231345', NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 1, 0, NULL),
(57, '5703702626', '5703702626', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, '5703702626', '1456231890', NULL, '2345', '3245', '2345', '2452345', 0, 2, 1, 1, 0, NULL),
(58, '5866335971', '5866335971', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, '5866335971', '1456234849', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, 0, NULL),
(59, '5866337169', '5866337169', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, '5866337169', '1456235235', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, 0, NULL),
(60, '13822225555', '96e79218965eb72c92a549dd5a330112', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456235806', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 1, 0, NULL),
(61, '13655552222', '', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456235917', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, 0, NULL),
(62, '13655552223', '96e79218965eb72c92a549dd5a330112', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456235942', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 1, 0, NULL),
(63, '13288888887', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456277753', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 1, 0, NULL),
(64, '15701690163', '', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456277819', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, 0, NULL),
(65, '15701690169', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456277851', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 1, 0, NULL),
(66, '13260000000', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456278023', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, NULL),
(67, '13210000000', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456278100', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, NULL),
(68, '18206429501', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456278236', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, NULL),
(69, '18206429503', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456278413', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, NULL),
(70, '13220000000', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456278445', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, NULL),
(71, '18206429504', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456278651', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 1, 0, NULL),
(72, '13230000000', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456278819', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, NULL),
(73, '13240000000', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456279010', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, NULL),
(74, '13250000000', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456279437', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, NULL),
(75, '13270000000', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456279512', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, NULL),
(76, '13280000000', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456279634', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, NULL),
(77, '13211111111', '81dc9bdb52d04dc20036dbd8313ed055', 'user.png', 'junior', NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456279649', NULL, NULL, NULL, '', '哈哈', 1, 2, 0, 1, 0, NULL),
(78, '13290000000', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456280048', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, NULL),
(79, '13211111112', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456280152', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, NULL),
(80, '13211111113', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456280365', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, NULL),
(81, '13855556666', '96e79218965eb72c92a549dd5a330112', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456280504', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, NULL),
(82, '13866667777', '96e79218965eb72c92a549dd5a330112', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456280576', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, NULL),
(83, '13822223333', '96e79218965eb72c92a549dd5a330112', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456280883', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, NULL),
(84, '13856565656', '7fa8282ad93047a4d6fe6111c93b308a', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456281222', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, NULL),
(85, '13756565656', '96e79218965eb72c92a549dd5a330112', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456281298', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, NULL),
(86, '13710140476', '', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456281592', NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 1, 0, NULL),
(87, '15899998888', '', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456281696', NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 1, 0, NULL),
(88, '15866667777', '96e79218965eb72c92a549dd5a330112', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456281964', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, NULL),
(89, '13566667777', '96e79218965eb72c92a549dd5a330112', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456282078', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, NULL),
(90, '13241111111', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456282162', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, NULL),
(91, '13511111111', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456282212', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 1, 0, NULL),
(92, '5866377145', '5866377145', 'user.png', 'beginner', NULL, NULL, 0, 0, 0, NULL, NULL, NULL, '5866377145', '1456282405', NULL, NULL, NULL, '', '123', 0, 1, 0, 1, 0, NULL),
(93, '13122924103', '393c0103009e75427c4b41bc8d4ad1fc', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456293465', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 1, 0, NULL),
(94, 'o3LYLuKWmHBxVRMD77vm_sHeL7Xs', 'o3LYLuKWmHBxVRMD77vm_sHeL7Xs', 'user.png', NULL, NULL, NULL, 30, 0, 2, NULL, 'o3LYLuKWmHBxVRMD77vm_sHeL7Xs', NULL, NULL, '1456293575', NULL, 'usa', 'it', 'im', 'rex', 0, 2, 1, 1, 0, NULL),
(95, 'o3LYLuCcrYoSMHR8Ynu66x8Nnbeo', 'o3LYLuCcrYoSMHR8Ynu66x8Nnbeo', 'user.png', 'professor', NULL, NULL, 0, 0, 0, NULL, 'o3LYLuCcrYoSMHR8Ynu66x8Nnbeo', NULL, NULL, '1456293757', NULL, NULL, NULL, 'fuck', 'Heath', 0, 2, 0, 1, 0, NULL),
(96, '2678291412', '2678291412', 'user.png', 'junior', NULL, NULL, 10, 0, 0, NULL, NULL, NULL, '2678291412', '1456293893', NULL, NULL, NULL, '', 'abc', 0, 2, 0, 1, 0, NULL),
(97, '15538181021', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456296504', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, NULL),
(98, 'lingyi.kong@talknic.cn', 'daa281b29ea36699cba6e66060efc15c', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456297271', NULL, 'USA', 'S', 'As', 'Kly', 1, 2, 1, 1, 0, NULL),
(99, '13366669999', '81dc9bdb52d04dc20036dbd8313ed055', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456366957', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 1, 0, 0),
(100, '13344440000', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456367299', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 1, 0, 0),
(101, '13344445555', '7e8feb2276322ecddd4423b649dfd4d9', 'http://115.47.28.121/Talknic1.0/data/uploads/56ce6721e9e54.jpg', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456367363', NULL, NULL, NULL, '2313', 'Will. Cc', 1, 0, 0, 1, 0, 0),
(102, '18822223333', '96e79218965eb72c92a549dd5a330112', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456369513', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 1, 0, 0),
(103, '18833334444', '96e79218965eb72c92a549dd5a330112', 'http://115.47.28.121/Talknic1.0/data/uploads/56ce719fbbba2.jpg', 'beginner', NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456369698', NULL, NULL, NULL, '11112', '11', 1, 2, 0, 1, 0, 0),
(104, '13212345678', '', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456369830', NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 1, 0, 0),
(105, '13212221122', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456370384', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, 0),
(106, '13212312311', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456370866', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, 0),
(107, '13223121121', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456371113', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, 0),
(108, '13212231221', '4297f44b13955235245b2497399d7a93', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456371387', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, 0),
(109, '13212234122', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456371501', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, 0),
(110, '13261381231', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456371648', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, 0),
(111, '13212312312', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456371739', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, 0),
(112, '13212321211', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456371833', NULL, '123', 'Wee ', 'Werner', '1231', 1, 2, 1, 1, 0, 0),
(113, '13256421312', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'beginner', NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456371951', NULL, NULL, NULL, NULL, '123', 1, 2, 0, 1, 0, 0),
(114, '13256321224', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456372088', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, 0),
(115, '13256123121', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456372226', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, 0),
(116, '13251123232', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456372293', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, 0),
(117, '13251343454', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456372354', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, 0),
(118, '13267890987', '508df4cb2f4d8f80519256258cfb975f', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456372414', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, 0),
(119, '13261234543', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456372459', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, 0),
(120, '13267231211', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456372536', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, 0, 0),
(121, '13267896672', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456372616', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 1, 0, 0),
(122, '13267832123', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456372945', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 1, 0, 0),
(123, '13366668888', 'e10adc3949ba59abbe56e057f20f883e', 'http://115.47.28.121/Talknic1.0/data/uploads/56ce7f7eb0c12.jpg', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456373608', NULL, NULL, NULL, '哈哈哈', '我是熊本熊', 1, 0, 1, 1, 0, 0),
(124, '13256789087', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'junior', NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456373730', NULL, NULL, NULL, NULL, '123', 1, 2, 0, 1, 0, 0),
(125, '13355556666', 'e10adc3949ba59abbe56e057f20f883e', 'http://115.47.28.121/Talknic1.0/data/uploads/56ce806eafc1d.jpg', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456373838', NULL, NULL, NULL, '111', 'Shows a', 1, 0, 0, 1, 0, 0),
(126, '13256789752', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'junior', NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456373917', NULL, NULL, NULL, NULL, '123123', 1, 2, 0, 1, 0, 0),
(127, '13444444444', 'e10adc3949ba59abbe56e057f20f883e', 'http://115.47.28.121/Talknic1.0/data/uploads/56ce80c2866fa.jpg', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456373917', NULL, NULL, NULL, '', '熊本啊', 1, 0, 1, 1, 0, 0),
(128, '13245654345', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'junior', NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456374058', NULL, NULL, NULL, NULL, '123123', 1, 2, 0, 1, 0, 0),
(129, '13300000000', 'e10adc3949ba59abbe56e057f20f883e', 'http://115.47.28.121/Talknic1.0/data/uploads/56ce8f0153f26.jpg', NULL, NULL, NULL, 10, 0, 0, NULL, NULL, NULL, NULL, '1456374430', NULL, NULL, NULL, '', '富春江', 1, 0, 0, 1, 0, 0),
(130, '13455558888', 'e10adc3949ba59abbe56e057f20f883e', 'http://115.47.28.121/Talknic1.0/data/uploads/56ce84287f6b7.jpg', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456374582', NULL, NULL, NULL, '', '尼玛币', 1, 0, 1, 1, 0, 0),
(131, '13412345622', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456374664', NULL, '123', '123', '123', '123', 1, 2, 1, 1, 0, 0),
(132, '13212312323', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'junior', NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456375058', NULL, NULL, NULL, NULL, 'Qweq', 1, 2, 0, 1, 0, 0),
(133, '13655554444', 'e10adc3949ba59abbe56e057f20f883e', 'http://115.47.28.121/Talknic1.0/data/uploads/56ce86c4686f9.jpg', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456375451', NULL, NULL, NULL, '', '卧槽∑(⊙▽⊙"a', 1, 0, 1, 1, 0, 0),
(134, '13699998888', 'e10adc3949ba59abbe56e057f20f883e', 'http://115.47.28.121/Talknic1.0/data/uploads/56ce88a067f1e.jpg', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456375913', NULL, '41', '覅', '舅舅家', '恕我直言', 1, 2, 1, 1, 0, 0),
(135, '13261472581', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456376724', NULL, '来了', 'ba', '到', '陌陌', 1, 2, 1, 1, 0, 0),
(136, '13212323423', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456376995', NULL, '123', '123', '123', '12', 1, 2, 1, 1, 0, 0),
(137, '13212342351', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456377339', NULL, '23', '3', '12', '123', 1, 2, 1, 1, 0, 0),
(138, '15538181000', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456377384', NULL, NULL, NULL, '', '测试latest排序', 1, 0, 1, 1, 0, 0),
(139, '13287123213', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456377735', NULL, '123', '3214', 'Qewr', '123123', 1, 2, 1, 1, 0, 0),
(140, '15844445555', '96e79218965eb72c92a549dd5a330112', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456380885', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 1, 0, 0),
(141, '15833335555', '96e79218965eb72c92a549dd5a330112', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456380963', NULL, 'Sara', 'Ada', 'Dad', 'Fffffffffffffff', 1, 1, 1, 1, 0, 0),
(142, 'rex.zou@talknic.cn', '', 'user.png', NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, '1456381832', NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 1, 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `talknic_voucher`
--

CREATE TABLE IF NOT EXISTS `talknic_voucher` (
  `voucher_id` int(10) NOT NULL COMMENT '代金券ID',
  `user_id` int(10) NOT NULL COMMENT '用户ID',
  `voucher_price` char(20) NOT NULL COMMENT '代金券额度',
  `voucher_pic` char(255) DEFAULT NULL COMMENT '代金券图片',
  PRIMARY KEY (`voucher_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='代金券表';

--
-- 转存表中的数据 `talknic_voucher`
--

INSERT INTO `talknic_voucher` (`voucher_id`, `user_id`, `voucher_price`, `voucher_pic`) VALUES
(1, 1, '', NULL),
(4, 1, '', NULL);
