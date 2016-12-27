-- Table : ad
-- Type  : create
-- SQL   :
CREATE TABLE `ad` (
  `AD_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `TITLE` varchar(255) DEFAULT NULL COMMENT '标题',
  `DESCRIPTION` varchar(255) DEFAULT NULL COMMENT '描述',
  `FILE_PATH` varchar(255) NOT NULL COMMENT '文件路径',
  `FILE_NAME` varchar(255) NOT NULL COMMENT '文件名称',
  `ORIGINAL_NAME` varchar(255) NOT NULL COMMENT '原始文件名',
  `CREATEDBY` varchar(99) NOT NULL COMMENT '创建者',
  `CREATEDON` datetime NOT NULL COMMENT '创建时间',
  `MODIFIEDBY` varchar(99) NOT NULL COMMENT '更新者',
  `MODIFIEDON` datetime NOT NULL COMMENT '更新时间',
  `XML_NAME` varchar(99) NOT NULL,
  `HIDDEN` char(1) NOT NULL COMMENT '是否隐藏',
  PRIMARY KEY (`AD_ID`),
  KEY `INDEX_AD_CREATEDBY` (`CREATEDBY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='广告表';

-- Table : ad_setting
-- Type  : create
-- SQL   :
CREATE TABLE `ad_setting` (
  `AD_SETTING_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `PRE_POSITION` varchar(45) NOT NULL,
  `AFTER_POSITION` varchar(45) NOT NULL,
  `MID_POSITION` varchar(45) NOT NULL,
  `CREATEDBY` varchar(99) NOT NULL,
  `CREATEDON` datetime NOT NULL,
  `MODIFIEDBY` varchar(99) NOT NULL,
  `MODIFIEDON` datetime NOT NULL,
  PRIMARY KEY (`AD_SETTING_ID`),
  KEY `INDEX_CREATEDBY` (`CREATEDBY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='广告设置表';

-- Table : encode_para
-- Type  : create
-- SQL   :
CREATE TABLE `encode_para` (
  `USER_ID` varchar(99) NOT NULL COMMENT '对应用户表的，用户ID',
  `SCALE_WIDTH` int(5) NOT NULL COMMENT '转码以后视频宽度(单位像素)',
  `SCALE_HEIGHT` int(5) NOT NULL COMMENT '转码以后的视频高度(单位像素)',
  `FRAMERATE` int(5) NOT NULL DEFAULT '0' COMMENT '帧速率,有效范围>=1',
  `PNG_WIDTH` int(5) NOT NULL COMMENT '截取png图片的宽度(单位像素)',
  `PNG_HEIGHT` int(5) NOT NULL COMMENT '截取png图片的高度(单位像素)',
  `CUTIMAGE_SPLITTIMES` int(10) NOT NULL COMMENT '每隔多久截取一张图片（单位秒）',
  `CUTVIDEO_SPLITTIMES` int(10) NOT NULL COMMENT '每隔多久截取一次视频(单位秒)',
  `CUTVIDEOLENGTH` int(10) NOT NULL COMMENT '截取的视频长度(单位秒)',
  `BRIGHTNESS` int(3) NOT NULL DEFAULT '0' COMMENT '亮度(有效范围-255~255)',
  `CONTRAST` int(3) NOT NULL DEFAULT '0' COMMENT '对比度(有效范围-255~255)',
  `HUE` int(3) NOT NULL DEFAULT '0' COMMENT '色调(有效范围-255~255)',
  `SATURATION` int(3) NOT NULL DEFAULT '0' COMMENT '饱和度(有效范围-255~255)',
  `NOISE` int(3) NOT NULL DEFAULT '0' COMMENT '降噪音(0:自适应;如果噪音过大可设置大于零的值)',
  `OVERLAY` int(2) NOT NULL DEFAULT '0' COMMENT '水印位置',
  `OVERLAY_LOGO_PATH` varchar(255) DEFAULT NULL COMMENT '水印PNG图片的路径',
  `FORMAT_ID` varchar(50) NOT NULL DEFAULT '1' COMMENT '转码的视频格式(对应视频格式表)',
  `SOUND_FLAG` varchar(1) NOT NULL DEFAULT '1' COMMENT '1:主屏有声音；2:子屏有声音；3:主屏和子屏都有声音',
  PRIMARY KEY (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='视频转码参数';

-- Table : message
-- Type  : create
-- SQL   :
CREATE TABLE `message` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `RESOURCE_ID` varchar(255) NOT NULL,
  `FILE_TYPE` char(1) NOT NULL,
  `MSG` longblob NOT NULL,
  `STATUS` char(1) NOT NULL COMMENT '0:未被读取;1:已被读取;2:开始处理',
  `CREATETIME` datetime NOT NULL,
  `READTIME` datetime DEFAULT NULL COMMENT '被读取的时间',
  `PROCESSTIME` datetime DEFAULT NULL COMMENT '开始处理的时间',
  `REMOTEHOSTIP` varchar(99) DEFAULT NULL,
  `Mesage_CREATETIME` datetime DEFAULT NULL,
  `RSYNC_READTIME` datetime DEFAULT NULL,
  `DESCRIPTION` text,
  PRIMARY KEY (`id`),
  KEY `Index_Message_Resource_ID` (`RESOURCE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table : message_dlq
-- Type  : create
-- SQL   :
CREATE TABLE `message_dlq` (
  `ACTIVEMQ_ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '消息的唯一ID',
  `RESOURCE_ID` varchar(99) NOT NULL COMMENT '消息对应的资源ID',
  `TRANSCODE_TYPE` int(4) NOT NULL COMMENT '转码类型(0:快速转码部分;1:正常转码部分)',
  `RESOURCE_NAME` varchar(255) NOT NULL COMMENT '切片的的名字',
  `FILE_TYPE` char(1) NOT NULL COMMENT '文件类型--如果是单屏为1;双分屏为2;三分屏为3',
  `MAIN_FILE_ID` varchar(99) DEFAULT NULL,
  `FIRST_FILE_ID` varchar(99) DEFAULT NULL,
  `PART_ID` int(3) NOT NULL,
  `SLAVESERVER_IP` varchar(99) DEFAULT NULL,
  `CREATEDON` datetime NOT NULL COMMENT '进库时间',
  `MESSAGE_CREATEDON` datetime NOT NULL COMMENT '该消息创建的时间',
  `QUEUE_NAME` varchar(255) NOT NULL COMMENT '消息重发时，要发送给哪个队列',
  `MSG` longblob NOT NULL,
  PRIMARY KEY (`ACTIVEMQ_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table : overlay
-- Type  : create
-- SQL   :
CREATE TABLE `overlay` (
  `OVERLAY_ID` int(2) NOT NULL,
  `CODE` varchar(255) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`OVERLAY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='水印位置表';

-- Table : player
-- Type  : create
-- SQL   :
CREATE TABLE `player` (
  `PLAYER_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) NOT NULL COMMENT '名称',
  `XML_NAME` varchar(255) NOT NULL COMMENT '配置文件路径',
  `VIDEO_WIDTH` varchar(255) NOT NULL COMMENT '宽度',
  `VIDEO_HEIGHT` varchar(255) NOT NULL COMMENT '高度',
  `SKIN_NAME` varchar(255) NOT NULL COMMENT '皮肤名称',
  `STYLE` varchar(255) NOT NULL,
  `FUNCTIONS` varchar(255) NOT NULL,
  `CREATEDON` datetime NOT NULL,
  `CREATEDBY` varchar(99) NOT NULL,
  `MODIFIEDON` datetime NOT NULL,
  `MODIFIEDBY` varchar(99) NOT NULL,
  `XML` text,
  PRIMARY KEY (`PLAYER_ID`),
  KEY `INDEX_PLAYER_CREATEDBY` (`CREATEDBY`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='播放器表';

-- Table : resource
-- Type  : create
-- SQL   :
CREATE TABLE `resource` (
  `RESOURCE_ID` varchar(99) NOT NULL COMMENT '主键',
  `TITLE` varchar(255) DEFAULT NULL COMMENT '视频名称',
  `FILE_NAME` varchar(255) DEFAULT NULL COMMENT '文件名称',
  `FILE_SIZE` bigint(20) unsigned DEFAULT NULL COMMENT '文件大小',
  `DESCRIPTION` varchar(255) DEFAULT NULL COMMENT '描述',
  `SOURCE` varchar(255) DEFAULT NULL COMMENT '视频来源',
  `PUBLISH_SCOPE` varchar(255) DEFAULT NULL COMMENT '发布范围',
  `LINK_TEXT` varchar(255) DEFAULT NULL COMMENT '相关链接文字',
  `LINK_URL` varchar(255) DEFAULT NULL COMMENT '相关链接地址',
  `SUB_IMG` varchar(255) DEFAULT NULL COMMENT '缩略图路径及名称,相对地址',
  `SUB_IMG_SIZE` bigint(20) unsigned DEFAULT NULL COMMENT '缩略图大小',
  `TYPE_ID` bigint(20) unsigned DEFAULT NULL COMMENT '分类ID',
  `AD_STATUS` varchar(255) DEFAULT NULL COMMENT '广告策略',
  `PUBLICIZE_NAME` varchar(255) DEFAULT NULL COMMENT '前置宣传片真实名称',
  `PUBLICIZE_UPNAME` varchar(255) DEFAULT NULL COMMENT '前置宣传片上传名称',
  `USEFULL_LIFE` varchar(255) DEFAULT NULL COMMENT '有效期',
  `AREA_CONFINE` varchar(255) DEFAULT NULL COMMENT '受限区域',
  `LOGO_SETTING_IMG` varchar(255) DEFAULT NULL COMMENT 'LOGO设置图片',
  `LOGO_SETTING_URL` varchar(255) DEFAULT NULL COMMENT 'LOGO设置URL',
  `LOGO_SETTING_TEXT` varchar(255) DEFAULT NULL COMMENT 'LOGO设置文字',
  `SNAP_TYPE_ID` bigint(20) unsigned DEFAULT NULL COMMENT '对齐方式ID',
  `CREATEDBY` varchar(99) NOT NULL COMMENT '创建者',
  `CREATEDON` datetime NOT NULL COMMENT '上传日期',
  `MODIFIEDBY` varchar(99) NOT NULL COMMENT '修改者',
  `MODIFIEDON` datetime NOT NULL COMMENT '修改日期',
  `VIDEO_XML_NAME` varchar(255) DEFAULT NULL COMMENT '视频的XML名称',
  `OLD_FILE_NAME` varchar(255) DEFAULT NULL COMMENT '初始文件名',
  `NEW_FILE_NAME` varchar(255) DEFAULT NULL COMMENT '转码后的文件路径及文件名',
  `NEW_FILE_SIZE` bigint(20) unsigned DEFAULT NULL COMMENT '转码后的文件大小',
  `STATUS` char(5) DEFAULT NULL COMMENT '状态',
  `FILE_TYPE` char(1) NOT NULL COMMENT '文件类型--如果是单屏为1;双分屏为2;三分屏为3;大视频为4',
  `MAIN_FILE_ID` varchar(99) DEFAULT NULL COMMENT '主文件ID--单屏为空;如果是多屏的主文件为空;多屏子文件不能为空',
  `FIRST_FILE_ID` varchar(99) DEFAULT NULL COMMENT '如果视频时分割上传的话，这里显示视频的第一部分的ResourceID',
  `PART_ID` int(3) NOT NULL DEFAULT '0' COMMENT '如果视频时分割上传的话，这里显示该段视频时第几段',
  `TOTAL_PARTS` int(3) DEFAULT '1' COMMENT '如果是大文件分段上传的话，这里是上传时视频总共分多少段。默认是1',
  `VIRTUAL_PATH` varchar(255) DEFAULT NULL COMMENT '码转后文件所在的虚拟路径',
  `PLAY_STATUS` char(1) DEFAULT NULL COMMENT '播放状态-->2:可播放(全部转完,包括子屏和主屏);1:可播放(快转部分转完);0:不可播放',
  PRIMARY KEY (`RESOURCE_ID`),
  KEY `INDEX_CREATEDBY` (`CREATEDBY`) USING BTREE,
  KEY `INDEX_RESOURCE_TYPE` (`TYPE_ID`),
  KEY `INDEX_CREATEDON` (`CREATEDBY`,`MAIN_FILE_ID`,`PART_ID`,`CREATEDON`,`PLAY_STATUS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table : resource_play_para
-- Type  : create
-- SQL   :
CREATE TABLE `resource_play_para` (
  `RESOURCE_ID` varchar(99) NOT NULL,
  `CUTTIME` int(5) NOT NULL DEFAULT '0' COMMENT '多少时间的视频不用播放',
  PRIMARY KEY (`RESOURCE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table : resource_tag
-- Type  : create
-- SQL   :
CREATE TABLE `resource_tag` (
  `RESOURCE_ID` varchar(99) NOT NULL,
  `TAG_ID` bigint(20) NOT NULL,
  PRIMARY KEY (`RESOURCE_ID`,`TAG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资源与标签映射表';

-- Table : resource_temp
-- Type  : create
-- SQL   :
CREATE TABLE `resource_temp` (
  `id` varchar(99) NOT NULL,
  `PNAME` varchar(99) NOT NULL COMMENT '实际文件名称',
  `ONAME` varchar(1000) NOT NULL COMMENT '原文件名称',
  `OPATH` varchar(1000) NOT NULL COMMENT '客户端地址',
  `SIZE` bigint(20) unsigned NOT NULL COMMENT '文件大小',
  `USER_ID` varchar(99) NOT NULL COMMENT '用户ID',
  `UPLOADED_LENGTH` bigint(20) unsigned NOT NULL COMMENT '已上传大小',
  `TITLE` varchar(255) DEFAULT NULL COMMENT '标题',
  `DESCRIPTION` varchar(1000) DEFAULT NULL COMMENT '描述',
  `TYPE_ID` bigint(20) unsigned DEFAULT NULL COMMENT '类别ID',
  `RESOURCE_ID` varchar(99) DEFAULT NULL COMMENT '资源ID',
  PRIMARY KEY (`id`),
  KEY `Index_P_NAME` (`PNAME`) USING BTREE,
  KEY `INDEX_RT_USER_ID` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资源临时表';

-- Table : resource_thread_temp
-- Type  : create
-- SQL   :
CREATE TABLE `resource_thread_temp` (
  `RESOURCE_TEMP_ID` varchar(99) NOT NULL,
  `THREAD_ID` varchar(10) NOT NULL,
  `START_POS` bigint(20) unsigned NOT NULL COMMENT '开始点',
  `END_POS` bigint(20) unsigned NOT NULL COMMENT '结束点',
  PRIMARY KEY (`RESOURCE_TEMP_ID`,`THREAD_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资源上传线程表';

-- Table : role
-- Type  : create
-- SQL   :
CREATE TABLE `role` (
  `ROLE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `CODE` varchar(255) NOT NULL COMMENT '角色代码',
  `NAME` varchar(255) NOT NULL COMMENT '角色名称',
  PRIMARY KEY (`ROLE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- Table : tag
-- Type  : create
-- SQL   :
CREATE TABLE `tag` (
  `TAG_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `TAG_NAME` varchar(255) NOT NULL COMMENT '名字',
  PRIMARY KEY (`TAG_ID`),
  UNIQUE KEY `FK_TAG_NAME` (`TAG_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='标签表';

-- Table : transcode
-- Type  : create
-- SQL   :
CREATE TABLE `transcode` (
  `RID` varchar(99) NOT NULL COMMENT '资源ID',
  `SFILENAME` varchar(1000) NOT NULL COMMENT '源文件名(全路径)',
  `DESTPATH` varchar(1000) NOT NULL COMMENT '目标文件路径',
  `DESTFILENAME` varchar(1000) NOT NULL COMMENT '目标文件名',
  PRIMARY KEY (`RID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table : type
-- Type  : create
-- SQL   :
CREATE TABLE `type` (
  `TYPE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) DEFAULT NULL,
  `USER_ID` varchar(99) DEFAULT NULL,
  `UP_TYPE_ID` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`TYPE_ID`),
  KEY `INDEX_TYPE_USER_ID` (`USER_ID`),
  KEY `INDEX_TYPE_UPTYPEID` (`UP_TYPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资源类别表';

-- Table : user
-- Type  : create
-- SQL   :
CREATE TABLE `user` (
  `USER_ID` varchar(99) NOT NULL,
  `LOGINNAME` varchar(255) NOT NULL COMMENT '用户名',
  `PASSWORD` varchar(255) NOT NULL COMMENT '密码',
  `EMAIL` varchar(255) NOT NULL COMMENT '邮箱',
  `NAME` varchar(255) DEFAULT NULL COMMENT '姓名',
  `UNIT` varchar(255) DEFAULT NULL COMMENT '单位',
  `ADDRESS` varchar(255) DEFAULT NULL COMMENT '住址',
  `POSTCODE` varchar(255) DEFAULT NULL COMMENT '邮编',
  `TEL` varchar(255) DEFAULT NULL COMMENT '电话',
  `MOBILE` varchar(255) DEFAULT NULL COMMENT '移动电话',
  `ACTIVE` char(1) NOT NULL COMMENT '是否激活 0-未激活 1-已激活',
  `CREATEDBY` varchar(99) DEFAULT NULL COMMENT '创建者',
  `MODIFIEDBY` varchar(99) DEFAULT NULL COMMENT '修改者',
  `CREATEDON` datetime NOT NULL COMMENT '创建时间',
  `MODIFIEDON` datetime NOT NULL COMMENT '修改时间',
  `USERSPACE` bigint(20) unsigned NOT NULL COMMENT '用户空间',
  `BANDWIDTH` bigint(20) unsigned NOT NULL COMMENT '用户带宽',
  `LAST_LOGIN_TIME` datetime DEFAULT NULL COMMENT '最近登录时间',
  `LAST_LOGIN_IP` varchar(45) DEFAULT NULL COMMENT '最近登录ip',
  `SAVED_USERSPACE` bigint(20) unsigned DEFAULT NULL COMMENT '用户已储存文件大小',
  `FLIE_NUMBER` bigint(20) unsigned DEFAULT NULL COMMENT '用户已储存文件个数',
  `FILE_SIZE` bigint(20) unsigned NOT NULL DEFAULT '1048576' COMMENT '用户每次上传时，单个文件的最大值.默认情况下是1M',
  `USER_KEY` varchar(255) DEFAULT NULL COMMENT '高级用户远程访问时使用的密钥',
  PRIMARY KEY (`USER_ID`),
  UNIQUE KEY `UNIQUE_LOGINNAME` (`LOGINNAME`),
  KEY `INDEX_USER_CREATEDBY` (`CREATEDBY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table : user_domain
-- Type  : create
-- SQL   :
CREATE TABLE `user_domain` (
  `DOMIAN_ID` varchar(99) NOT NULL,
  `USER_ID` varchar(99) NOT NULL,
  `DOMAIN` varchar(255) DEFAULT NULL,
  `STATUS` int(1) DEFAULT '0' COMMENT '0:enable;1:disable',
  PRIMARY KEY (`DOMIAN_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table : user_role
-- Type  : create
-- SQL   :
CREATE TABLE `user_role` (
  `USER_ID` varchar(99) NOT NULL,
  `ROLE_ID` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`USER_ID`,`ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户与角色映射';

-- Table : video_format
-- Type  : create
-- SQL   :
CREATE TABLE `video_format` (
  `FORMAT_ID` int(5) NOT NULL DEFAULT '0' COMMENT '唯一ID',
  `CODE` varchar(255) DEFAULT NULL COMMENT '视频转码的格式(eg:flv mov mp4 3gp)',
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `STATUS` char(1) DEFAULT NULL COMMENT '视频格式状态 0:可用;1:不可用',
  PRIMARY KEY (`FORMAT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='视频转码的格式表';

-- Table : visit
-- Type  : create
-- SQL   :
CREATE TABLE `visit` (
  `VISIT_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `USER_ID` varchar(99) DEFAULT NULL,
  `RESOURCE_ID` varchar(99) NOT NULL COMMENT '资源ID',
  `IP` varchar(45) DEFAULT NULL COMMENT 'IP',
  `CLIENT_AGENT` varchar(1000) DEFAULT NULL,
  `FROM_URL` varchar(1000) DEFAULT NULL,
  `CUR_URL` varchar(1000) DEFAULT NULL,
  `OS` varchar(45) DEFAULT NULL,
  `BROWSER_NAME` varchar(255) DEFAULT NULL,
  `BROWSER_VERSION` varchar(255) DEFAULT NULL,
  `BROWSER_LANG` varchar(255) DEFAULT NULL,
  `CREATEDON` datetime NOT NULL,
  PRIMARY KEY (`VISIT_ID`),
  KEY `INDEX_VISIT_RESOURCEID` (`RESOURCE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='访问情况表';

