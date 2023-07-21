/*
 Navicat Premium Data Transfer

 Source Server         : 192.168.65.174
 Source Server Type    : MySQL
 Source Server Version : 80024
 Source Host           : 192.168.65.174:3306
 Source Schema         : hspersona

 Target Server Type    : MySQL
 Target Server Version : 80024
 File Encoding         : 65001

 Date: 13/01/2022 13:43:12
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for etl_database_source
-- ----------------------------
DROP TABLE IF EXISTS `etl_database_source`;
CREATE TABLE `etl_database_source`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '主键ID',
  `userId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属用户',
  `alias` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据源别名',
  `dbType` int(0) NULL DEFAULT NULL COMMENT '数据库类型，见系统字典type=dbType',
  `ip` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'IPv4地址',
  `port` int(0) NULL DEFAULT NULL COMMENT '端口',
  `dbName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据库名',
  `userName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'ETL数据源配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of etl_database_source
-- ----------------------------
INSERT INTO `etl_database_source` VALUES ('ID1709211426328502353165656', '1', 'localXDJ', 1, '192.168.0.43', 3306, 'xdj', 'root', '123');
INSERT INTO `etl_database_source` VALUES ('ID1709291024228903252134510', '1', 'OracleTest', 2, '172.16.49.129', 1521, 'warehouse', 'cdbadm', 'cdac#505');
INSERT INTO `etl_database_source` VALUES ('ID1907261501120733802113786', '1', 'GY_SWORD_SIT', 2, '172.16.49.65', 1521, 'motion', 'swordrisk', 'risk#230');
INSERT INTO `etl_database_source` VALUES ('ID2112091532208712932716844', '1', 'hadoop01', 1, '192.168.65.174', 3306, 'didi', 'root', 'root');

-- ----------------------------
-- Table structure for etl_json_config
-- ----------------------------
DROP TABLE IF EXISTS `etl_json_config`;
CREATE TABLE `etl_json_config`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '主键ID',
  `userId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '所属用户',
  `userName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户账号',
  `etlName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ETL主题',
  `typeName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主表数据类型名，如Person',
  `primaryTableFileName` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主表文件名',
  `primaryTableKeyIndex` int(0) NULL DEFAULT NULL COMMENT '主表主键下标',
  `primaryTableProperties` varchar(3000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主表需要解析列属性规则如（0,name），多个用split隔开',
  `logs` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ETL日志',
  `industryType` int(0) NULL DEFAULT NULL COMMENT '所属的行业ID，值见字典表type=industryType',
  `ENABLE` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'ETL主表配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of etl_json_config
-- ----------------------------
INSERT INTO `etl_json_config` VALUES ('ID1709051725555586221020404', '1', 'admin', 'admin', 'Person', '/data/admin/person.txt', 0, '1,managementAgency3,gender2,givenName2,name', '计算发生错误：Output directory hdfs://master:8020/ID1709051725555586221020404 already exists', 1, '1');
INSERT INTO `etl_json_config` VALUES ('ID1709251603480604761693533', '1', 'admin', 'GY_Usr_Info', 'GY_Usr_Info', '/GY_USR_DEMO_DATA', 0, '0,MBL_NO1,USR_MIN_DT2,CUR_AMT3,USR_COUNT', '计算发生错误：Output directory hdfs://master:8020/ID1709251603480604761693533 already exists', 2, '1');
INSERT INTO `etl_json_config` VALUES ('ID2112091711475243549542338', '1', 'admin', 'tttt2', 'GY_Fund_Info', '/GY_USR_DEMO_DATA', 0, NULL, NULL, 2, '0');
INSERT INTO `etl_json_config` VALUES ('ID2112131310569166728092638', '1', 'admin', 'DS_USER', 'DS_CLIENT', '/data/admin/hspersona/DS', 0, '0,DS_USER_ID1,DS_USER_NAME2,DS_USER_PHONE3,DS_USER_GENDER4,DS_USER_REGTIME5,DS_USER_AVAILABLE6,DS_USER_IDENTIFICATION7,DS_USER_HOMEADDR8,DS_USER_AGE9,DS_USER_ORDER_COUNT10,DS_USER_ORDER_AMOUNT', '计算发生错误：Output directory hdfs://hadoop01/data/admin/ID2112131310569166728092638 already exists', 3, '1');

-- ----------------------------
-- Table structure for etl_json_table_config
-- ----------------------------
DROP TABLE IF EXISTS `etl_json_table_config`;
CREATE TABLE `etl_json_table_config`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '主键ID',
  `configId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属配置ID',
  `keyName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '该表对应数据Key',
  `fileName` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '该表所在的文件名',
  `typeName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表数据类型名，如Family',
  `properties` varchar(3000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '需要解析列属性规则如（0,name），多个用split隔开',
  `foreignKeyIndex` int(0) NULL DEFAULT NULL COMMENT '外键所在数据下标',
  `mappingType` int(0) NULL DEFAULT NULL COMMENT '映射类型：0是一对一，1是一对多',
  `memo` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK54E980A86B1261C8`(`configId`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'ETL从表数据配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of etl_json_table_config
-- ----------------------------
INSERT INTO `etl_json_table_config` VALUES ('ID1709051744092439581958749', 'ID1709051725555586221020404', 'deposit', '/data/admin/deposit.txt', 'Integer', '1,deposit', 0, 1, NULL);
INSERT INTO `etl_json_table_config` VALUES ('ID1709051744494893241967814', 'ID1709051725555586221020404', 'creditCardQuota', '/data/admin/creditcardquota.txt', 'Number', '1,creditCardQuota', 0, 1, NULL);
INSERT INTO `etl_json_table_config` VALUES ('ID1709051745138775041407888', 'ID1709051725555586221020404', 'family', '/data/admin/family.txt', 'Family', '1,familyMemberLabel2,familyRelationsCode', 0, 1, NULL);
INSERT INTO `etl_json_table_config` VALUES ('ID1709201621045420235241096', 'ID1709051725555586221020404', 'financing', '/data/admin/finance.txt', 'IndividualFinancing', '1,balance', 0, 1, NULL);

-- ----------------------------
-- Table structure for etl_sqoop_load_data
-- ----------------------------
DROP TABLE IF EXISTS `etl_sqoop_load_data`;
CREATE TABLE `etl_sqoop_load_data`  (
  `ID` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `USERID` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DATASOURCEID` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `LOADSQL` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `TARGETPATH` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SPLITBY` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ETLPROCESSCORENUM` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CREATEDATE` datetime(0) NULL DEFAULT NULL,
  `STARTDATE` datetime(0) NULL DEFAULT NULL,
  `ENDDATE` datetime(0) NULL DEFAULT NULL,
  `LOGS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ENABLE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of etl_sqoop_load_data
-- ----------------------------
INSERT INTO `etl_sqoop_load_data` VALUES ('ID1709211427536526664303271', '1', 'sqoopT1', 'ID1709211426328502353165656', 'select * from t_client where 1=1', '/localXDJ2', 'client_id', '1', '2017-09-21 14:27:53', NULL, NULL, NULL, '1');
INSERT INTO `etl_sqoop_load_data` VALUES ('ID1709291026003537706935143', '1', 'sqoopTOracle', 'ID1709291024228903252134510', 'select UI.IP_ID,UI.Usr_City_Nm,UI.MBL_NO,UI.Real_Nm_Flg,UI.CRED_LVL,UI.Cus_Nm from USR_INFO UI where 1=1', '/SQOra2', 'IP_ID', '3', '2017-09-29 10:26:00', NULL, NULL, NULL, '1');
INSERT INTO `etl_sqoop_load_data` VALUES ('ID1907261457265057679480442', '1', 'GY_USR_DEMO', 'ID1907261501120733802113786', 'select mblno,mindt,amt,cou from (select s.mblno,min(s.dt) mindt,nvl(sum(s.tx_amt),0) amt,count(1) cou from swordriskinfo s group by s.mblno) where 1=1', '/GY_USR_DEMO_DATA', 'mblno', '3', '2019-07-26 14:57:26', NULL, NULL, NULL, '1');
INSERT INTO `etl_sqoop_load_data` VALUES ('ID2112091458050600066384350', '1', 'ttt', 'ID1709291024228903252134510', 'asdfasdf where 1=1 ', 'asdfasdf', 'asdf', '2', '2021-12-09 14:58:05', NULL, NULL, NULL, '0');
INSERT INTO `etl_sqoop_load_data` VALUES ('ID2112091502055426617006143', '1', 'hadoop_user', 'ID2112091532208712932716844', 'select * from user where 1=1 ', '/hspersona', 'name', '2', '2021-12-09 15:02:06', NULL, NULL, NULL, '0');
INSERT INTO `etl_sqoop_load_data` VALUES ('ID2112121803192619643040155', '1', '电商用户信息抽取', 'ID2112091532208712932716844', 'SELECT\r\n	u.id,\r\n	u.NAME,\r\n	u.phone,\r\n	u.gender,\r\n	u.regtime,\r\n	u.availableAmount,\r\n	u.identification,\r\n	u.homeAddr,\r\n	u.age,\r\n	t.count,\r\n	t.amount \r\nFROM\r\n	ums_user u,\r\n	( SELECT user_id, count( 1 ) count, sum( price ) amount FROM oms_order o where o.order_date>\'\'${runDate}\'\' GROUP BY o.user_id ) t \r\nWHERE\r\n	u.id = t.user_id', '/data/admin/hspersona/DS', 'id', '3', '2021-12-12 18:03:19', NULL, NULL, NULL, '1');

-- ----------------------------
-- Table structure for etl_upload_file_data
-- ----------------------------
DROP TABLE IF EXISTS `etl_upload_file_data`;
CREATE TABLE `etl_upload_file_data`  (
  `ID` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `USERID` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SOURCEPATH` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `TARGETPATH` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CREATEDATE` datetime(0) NULL DEFAULT NULL,
  `STARTDATE` datetime(0) NULL DEFAULT NULL,
  `ENDDATE` datetime(0) NULL DEFAULT NULL,
  `LOGS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ENABLE` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sys_dictionary
-- ----------------------------
DROP TABLE IF EXISTS `sys_dictionary`;
CREATE TABLE `sys_dictionary`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '主键ID',
  `orders` int(0) NULL DEFAULT NULL COMMENT '内部排序号',
  `type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典类型',
  `itemName` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典项名称',
  `itemValue` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典项值',
  `memo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dictionary
-- ----------------------------
INSERT INTO `sys_dictionary` VALUES ('ID1605182136234831320816912', 1, 'orgType', '公司', '1', '公司');
INSERT INTO `sys_dictionary` VALUES ('ID1605182138158918059174680', 2, 'orgType', '部门', '2', '公司部门，包括分公司、项目部的部门等');
INSERT INTO `sys_dictionary` VALUES ('ID1605182138430910040557930', 3, 'orgType', '项目部', '3', '总公司或分公司的项目部');
INSERT INTO `sys_dictionary` VALUES ('ID1605182139154237506332091', 4, 'orgType', '分公司', '4', '分公司类型机构');
INSERT INTO `sys_dictionary` VALUES ('ID1605182157067633460614027', 1, 'edgeType', '父子关系', '1', '父子关系边，A是父，B是子');
INSERT INTO `sys_dictionary` VALUES ('ID1605182157404540422347121', 2, 'edgeType', '朋友关系', '2', '朋友关系边');
INSERT INTO `sys_dictionary` VALUES ('ID1605182205345716081625706', 1, 'vertexType', '分类节点', '1', '分类节点');
INSERT INTO `sys_dictionary` VALUES ('ID1605182205465412697281651', 2, 'vertexType', '概念节点', '2', '概念节点');
INSERT INTO `sys_dictionary` VALUES ('ID1605182205568737676580254', 3, 'vertexType', '规则节点', '3', '规则节点');
INSERT INTO `sys_dictionary` VALUES ('ID1605182206077970512289855', 4, 'vertexType', '标签节点', '4', '标签节点');
INSERT INTO `sys_dictionary` VALUES ('ID1605282218112579998954473', 1, 'dataType', '基本类型', '1', '');
INSERT INTO `sys_dictionary` VALUES ('ID1605282218279924401137325', 3, 'dataType', '复合类型', '3', '');
INSERT INTO `sys_dictionary` VALUES ('ID1605291648096467338742777', 2, 'dataType', '扩展类型', '2', '基于基础类型的扩展');
INSERT INTO `sys_dictionary` VALUES ('ID1606072313109488195911041', 1, 'ruleType', '区段规则', '1', '按区段分段的规则计算');
INSERT INTO `sys_dictionary` VALUES ('ID1606072314047130610555086', 2, 'ruleType', '函数规则', '2', '使用已定义函数进行规则运算');
INSERT INTO `sys_dictionary` VALUES ('ID1606252234074452949112199', 1, 'expressType', '官方表述', '1', '');
INSERT INTO `sys_dictionary` VALUES ('ID1606252234247115283600886', 2, 'expressType', '专业表述', '2', '');
INSERT INTO `sys_dictionary` VALUES ('ID1606252234413210350765130', 3, 'expressType', '口语表述', '3', '');
INSERT INTO `sys_dictionary` VALUES ('ID1608141442470287574604011', 1, 'dbType', 'mysql', '1', '支持的数据库类型');
INSERT INTO `sys_dictionary` VALUES ('ID1612301123053979375979250', 1, 'industryType', '金融行业', '1', '');
INSERT INTO `sys_dictionary` VALUES ('ID1612301123229440334867005', 2, 'industryType', '社保行业', '2', '');
INSERT INTO `sys_dictionary` VALUES ('ID1612301123342576117463928', 3, 'industryType', '电商行业', '3', '');
INSERT INTO `sys_dictionary` VALUES ('ID1709291008253575865672451', 2, 'dbType', 'oracle', '2', '支持的数据库类型');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '主键ID',
  `name` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单名称',
  `url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单URL',
  `treeCode` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '树结构编码',
  `parentId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父节点ID',
  `enable` int(0) NULL DEFAULT NULL COMMENT '是否可用，0不可用，1可用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('ID1401280946338647341224519', '系统管理', '', '00002', '-1', 1);
INSERT INTO `sys_menu` VALUES ('ID1401280946338647341224520', '系统权限', '', '0000200001', 'ID1401280946338647341224519', 1);
INSERT INTO `sys_menu` VALUES ('ID1401280946338647341224521', '菜单管理', '/system/menu/to', '000020000100001', 'ID1401280946338647341224520', 1);
INSERT INTO `sys_menu` VALUES ('ID1401280946338647341224522', '角色管理', '/system/role/to', '000020000100003', 'ID1401280946338647341224520', 1);
INSERT INTO `sys_menu` VALUES ('ID1401280946338647341224523', '用户管理', '/system/user/to', '000020000100004', 'ID1401280946338647341224520', 1);
INSERT INTO `sys_menu` VALUES ('ID1401280946338647341224524', '系统权限点', '/system/permission/to', '000020000100002', 'ID1401280946338647341224520', 1);
INSERT INTO `sys_menu` VALUES ('ID1401280946338647341224525', '基础数据', '', '0000200002', 'ID1401280946338647341224519', 1);
INSERT INTO `sys_menu` VALUES ('ID1402181417029005469350906', '首页', '', '00001', '-1', 1);
INSERT INTO `sys_menu` VALUES ('ID1402181419189699555606245', '工具箱', '', '0000100001', 'ID1402181417029005469350906', 1);
INSERT INTO `sys_menu` VALUES ('ID1402181419369585855903829', '修改个人信息', '/system/user/toedit', '000010000100001', 'ID1402181419189699555606245', 1);
INSERT INTO `sys_menu` VALUES ('ID1401280946338647341224526', '机构管理', '/system/org/to', '000020000200001', 'ID1401280946338647341224525', 1);
INSERT INTO `sys_menu` VALUES ('ID1403121445531699840146179', '数据库监控', '/druid/index.html', '000010000100002', 'ID1402181419189699555606245', 1);
INSERT INTO `sys_menu` VALUES ('ID1604182143281458597068986', '标签工厂', '', '00005', '-1', 1);
INSERT INTO `sys_menu` VALUES ('ID1604182146119253689233729', '标签基础', '', '0000500001', 'ID1604182143281458597068986', 1);
INSERT INTO `sys_menu` VALUES ('ID1605102213576573906054037', '标签树定义', '/tag/tagNet/toTagTree', '000050000100001', 'ID1604182146119253689233729', 1);
INSERT INTO `sys_menu` VALUES ('ID1605102214402952404623898', '标签图展现', '/tag/tagNet/toNetTree', '000050000100003', 'ID1604182146119253689233729', 1);
INSERT INTO `sys_menu` VALUES ('ID1402191513154943593609285', '系统字典', '/system/dictionary/to', '000020000200002', 'ID1401280946338647341224525', 1);
INSERT INTO `sys_menu` VALUES ('ID1605162332025948978862486', '接口管理', '', '0000500002', 'ID1604182143281458597068986', 1);
INSERT INTO `sys_menu` VALUES ('ID1605162333232383403663172', '标签分析入参维护', '/tag/tagParam/to', '000050000200004', 'ID1605162332025948978862486', 1);
INSERT INTO `sys_menu` VALUES ('ID1612301109418408340052743', '扩展模型管理', '/tag/tagExtModel/toEdit', '000030000200001', 'ID1612290936516502790274662', 1);
INSERT INTO `sys_menu` VALUES ('ID1605162243250420068515373', '参数管理', '/system/param/to', '000020000200003', 'ID1401280946338647341224525', 1);
INSERT INTO `sys_menu` VALUES ('ID1605282116225687186361928', '基础模型浏览', '/tag/tagBaseModel/modelWeb', '000030000100001', 'ID1612290930027773726581985', 1);
INSERT INTO `sys_menu` VALUES ('ID1605282116020407753219474', '基础模型类型集合', '/tag/tagBaseModel/to', '000030000100002', 'ID1612290930027773726581985', 1);
INSERT INTO `sys_menu` VALUES ('ID1606041705513511573036650', '计算管理', '/tag/tagCalculate/to', '000050000200007', 'ID1605162332025948978862486', 1);
INSERT INTO `sys_menu` VALUES ('ID1606041101038652411227709', '基础模型属性集合', '/tag/tagElement/to', '000030000100003', 'ID1612290930027773726581985', 1);
INSERT INTO `sys_menu` VALUES ('ID1608091634443695972140830', '数据转换', '', '0000400002', 'ID1608091629136412483034244', 1);
INSERT INTO `sys_menu` VALUES ('ID1606050954114043933453026', '计算规则维护', '/tag/tagRule/to', '000050000200005', 'ID1605162332025948978862486', 1);
INSERT INTO `sys_menu` VALUES ('ID1608091629136412483034244', '数据预处理', '', '00004', '-1', 1);
INSERT INTO `sys_menu` VALUES ('ID1606042227072809298873623', '属性字典', '/tag/tagDictionary/to', '000030000100004', 'ID1612290930027773726581985', 1);
INSERT INTO `sys_menu` VALUES ('ID1608141136262912481782612', '数据抽取', '', '0000400001', 'ID1608091629136412483034244', 1);
INSERT INTO `sys_menu` VALUES ('ID1608141138443267147550134', '关系数据库表导入', '/etl/etlExtractRdb/toIFRDB', '000040000100002', 'ID1608141136262912481782612', 1);
INSERT INTO `sys_menu` VALUES ('ID1608091635266328815724140', '二维表转JSON', '/etl/etlTransformJson/to', '000040000200001', 'ID1608091634443695972140830', 1);
INSERT INTO `sys_menu` VALUES ('ID1609032308158170720179957', '数据加工配置', '', '0000400003', 'ID1608091629136412483034244', 1);
INSERT INTO `sys_menu` VALUES ('ID1608161043276231002591331', 'HDFS文件系统管理', '/etl/etlExtractRdb/to', '000040000100001', 'ID1608141136262912481782612', 1);
INSERT INTO `sys_menu` VALUES ('ID1612290928591047239731649', '数据模型', '', '00003', '-1', 1);
INSERT INTO `sys_menu` VALUES ('ID1612290930027773726581985', '基础模型', '', '0000300001', 'ID1612290928591047239731649', 1);
INSERT INTO `sys_menu` VALUES ('ID1612290936516502790274662', '行业扩展模型', '', '0000300002', 'ID1612290928591047239731649', 1);
INSERT INTO `sys_menu` VALUES ('ID1612301110113568319902059', '扩展模型浏览', '/tag/tagExtModel/toView', '000030000200002', 'ID1612290936516502790274662', 1);
INSERT INTO `sys_menu` VALUES ('ID1609032308539125789008385', '数据库源配置', '/etl/databaseSource/to', '000040000300001', 'ID1609032308158170720179957', 1);
INSERT INTO `sys_menu` VALUES ('ID2112091801537902648750314', '标签节点列表', '/tag/tagNet/to', '000050000100004', 'ID1604182146119253689233729', 1);

-- ----------------------------
-- Table structure for sys_org
-- ----------------------------
DROP TABLE IF EXISTS `sys_org`;
CREATE TABLE `sys_org`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '主键ID',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '机构名称',
  `treeCode` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '树结构编码',
  `parentId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父节点ID',
  `type` int(0) NULL DEFAULT NULL COMMENT '机构类型，参见字典表中type=orgType的数据',
  `status` int(0) NULL DEFAULT NULL COMMENT '状态：1：正常，0：废弃',
  `leaf` int(0) NULL DEFAULT NULL COMMENT '状态：1：正常，0：废弃',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKC342863266FE05BF`(`type`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '机构表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_org
-- ----------------------------
INSERT INTO `sys_org` VALUES ('ID1402241152495635866349713', '湖南分公司', '0000100004', 'ID1403071146031201296423100', 2, 1, 0);
INSERT INTO `sys_org` VALUES ('ID1402241153514684476991034', '研发部', '000010000400002', 'ID1402241152495635866349713', 4, 1, 0);
INSERT INTO `sys_org` VALUES ('ID1403071146031201296423100', '科技有限公司', '00001', '-1', 1, 1, 0);

-- ----------------------------
-- Table structure for sys_param
-- ----------------------------
DROP TABLE IF EXISTS `sys_param`;
CREATE TABLE `sys_param`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '主键ID',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数编码',
  `memo` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注说明',
  `value` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数值',
  `enable` int(0) NULL DEFAULT NULL COMMENT '是否可用 0不可用，1可用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '参数表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_param
-- ----------------------------
INSERT INTO `sys_param` VALUES ('ID1605162252192064558974034', 'defaultPassword', '默认密码', '123456', 1);
INSERT INTO `sys_param` VALUES ('ID1605162255436556754025222', 'tagGraphDepth', '标签图显示深度', '4', 1);
INSERT INTO `sys_param` VALUES ('ID1606041309201214794348781', 'modelTopClass', '模型顶级类名', 'Object', 1);
INSERT INTO `sys_param` VALUES ('ID1606231346261218444931363', 'jsonldContext', 'JSONLD的context地址', 'http://schema.org/', 1);
INSERT INTO `sys_param` VALUES ('ID1607011519234363237623736', 'esClusterName', 'ElasticSearch集群名称', 'my-application', 1);
INSERT INTO `sys_param` VALUES ('ID1607011520450919841156276', 'esClusterIpv4s', 'ElasticSearch集群入口地址，型如：IP1:PORT1,IP2:PORT2；127.0.0.1:9300,127.0.0.1:9300,127.0.0.1:9300', 'hadoop01:9200,hadoop02:9200,hadoop03:9200', 1);
INSERT INTO `sys_param` VALUES ('ID1607231018087279969694524', 'esIndexName', 'ElasticSearch数据库索引名', 'hspersona_esdb', 1);
INSERT INTO `sys_param` VALUES ('ID1608141410445978990782782', 'dataRootPath', '系统hdfs数据存储根目录', '/data', 1);
INSERT INTO `sys_param` VALUES ('ID1608141411347998205479976', 'etlProcessCoreNum', 'ETL时数据抽取使用的集群核心数', '2', 1);
INSERT INTO `sys_param` VALUES ('ID1608172003187773448658970', 'sshHostName', 'SSH连接的地址，外网地址', 'hadoop01', 1);
INSERT INTO `sys_param` VALUES ('ID1608172005147594836409228', 'sshUserName', 'SSH连接的用户名', 'root', 1);
INSERT INTO `sys_param` VALUES ('ID1608172005332112430131554', 'sshPassword', 'SSH连接的密码', 'root', 1);
INSERT INTO `sys_param` VALUES ('ID1608172049141170030350467', 'sparkHome', '服务器上spark安装目录', '/app/spark/spark-3.1.1-bin-hadoop3.2', 1);
INSERT INTO `sys_param` VALUES ('ID1608172052005450737636788', 'sqoopHome', '服务器上sqoop安装目录', '/app/sqoop/sqoop-1.4.7.bin__hadoop-2.6.0', 1);
INSERT INTO `sys_param` VALUES ('ID1608172052387023568399504', 'hadoopHome', '服务器上hadoop安装目录', '/app/hadoop/hadoop-3.2.2/', 1);
INSERT INTO `sys_param` VALUES ('ID1608172059100534145494710', 'userTagEngineJar', '计算引擎jar目录', '/app/hspersona/engine/HspersonaEng.jar', 1);
INSERT INTO `sys_param` VALUES ('ID1612262358248593727092146', 'webHdfsUsername', 'hdfs文件系统用户名', 'root', 1);
INSERT INTO `sys_param` VALUES ('ID1612262211533734151394954', 'webHdfsAddress', 'webhdfs路径地址前缀', 'http://hadoop01:9870/webhdfs/v1', 1);
INSERT INTO `sys_param` VALUES ('ID1703131225170803831352427', 'sparkSystemType', '操作系统名称', 'centos', 1);
INSERT INTO `sys_param` VALUES ('ID1703231132534112419535476', 'sparkRestAddress', 'Spark的RestAPI接口路径前缀', 'http://172.16.48.10:6066/v1', 1);
INSERT INTO `sys_param` VALUES ('ID1709051629450088227683335', 'webHdfsAddressStandBy', 'webhdfs路径地址前缀', '', 1);
INSERT INTO `sys_param` VALUES ('ID2112091310211767628163307', 'localTmpPath', '文件上传HDFS时的本地缓存目录', 'D://tmp', 1);

-- ----------------------------
-- Table structure for sys_param_value_info
-- ----------------------------
DROP TABLE IF EXISTS `sys_param_value_info`;
CREATE TABLE `sys_param_value_info`  (
  `ID` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JSONDATA` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CREATEDATE` datetime(0) NULL DEFAULT NULL,
  `STATUS` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ISDELETE` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '主键ID',
  `menuId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属菜单ID',
  `treeCode` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '树结构代码',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限点代码',
  `memo` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '说明描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '权限点表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_permission
-- ----------------------------
INSERT INTO `sys_permission` VALUES ('ID1402120855096955922862851', 'ID1401280946338647341224521', '00002000010000100001', 'viewMenu', '查看菜单');
INSERT INTO `sys_permission` VALUES ('ID1402120855096955922862852', 'ID1401280946338647341224522', '00002000010000300001', 'viewRole', '查看角色');
INSERT INTO `sys_permission` VALUES ('ID1402120855096955922862853', 'ID1401280946338647341224523', '00002000010000400001', 'viewUser', '查看用户');
INSERT INTO `sys_permission` VALUES ('ID1402120855096955922862854', 'ID1401280946338647341224524', '00002000010000200001', 'viewPermission', '查看系统权限点');
INSERT INTO `sys_permission` VALUES ('ID1402120855096955922862855', 'ID1401280946338647341224526', '00002000020000100001', 'viewOrg', '查看机构');
INSERT INTO `sys_permission` VALUES ('ID1402120855096955922862856', 'ID1401280946338647341224521', '00002000010000100002', 'editMenu', '编辑菜单');
INSERT INTO `sys_permission` VALUES ('ID1402181604282460368527290', 'ID1402181419369585855903829', '00001000010000100001', 'viewPersonalInfo', '查看个人用户信息');
INSERT INTO `sys_permission` VALUES ('ID1402191535132519189242462', 'ID1401280946338647341224524', '00002000010000200002', 'editPermission', '编辑系统权限点');
INSERT INTO `sys_permission` VALUES ('ID1402191535325137023566734', 'ID1401280946338647341224522', '00002000010000300002', 'editRole', '编辑角色');
INSERT INTO `sys_permission` VALUES ('ID1402191535493704707663571', 'ID1401280946338647341224523', '00002000010000400002', 'editUser', '编辑用户');
INSERT INTO `sys_permission` VALUES ('ID1402191536040809819498428', 'ID1401280946338647341224526', '00002000020000100002', 'editOrg', '编辑机构');
INSERT INTO `sys_permission` VALUES ('ID1402191536251835863681350', 'ID1402191513154943593609285', '00002000020000200001', 'viewDictionary', '查看字典数据');
INSERT INTO `sys_permission` VALUES ('ID1402191536440362028608194', 'ID1402191513154943593609285', '00002000020000200002', 'editDictionary', '编辑字典数据');
INSERT INTO `sys_permission` VALUES ('ID1403121446115067590839490', 'ID1403121445531699840146179', '00001000010000200001', 'viewMonitorDatabase', '查看数据库监控');
INSERT INTO `sys_permission` VALUES ('ID1404111644575893819825520', 'ID1404111644410962121822809', '00001000010000300001', 'viewReportDemo', '查看超级报表DEMO');
INSERT INTO `sys_permission` VALUES ('ID1605102214594325896050839', 'ID1605102213576573906054037', '00005000010000100001', 'viewTagTree', '查看标签树');
INSERT INTO `sys_permission` VALUES ('ID1605102215104114936438112', 'ID1605102214185790795505676', '00005000010000200001', 'viewTagNet', '查看标签网');
INSERT INTO `sys_permission` VALUES ('ID1605102215242433774458644', 'ID1605102214402952404623898', '00005000010000300001', 'viewTagGraph', '查看标签图');
INSERT INTO `sys_permission` VALUES ('ID1605162243478907520413515', 'ID1605162243250420068515373', '00002000020000300001', 'viewParam', '查看参数');
INSERT INTO `sys_permission` VALUES ('ID1605162244021075685857022', 'ID1605162243250420068515373', '00002000020000300002', 'editParam', '编辑参数');
INSERT INTO `sys_permission` VALUES ('ID1605162334081599450374107', 'ID1605162333232383403663172', '00005000020000400001', 'viewTagInParam', '查看标签入参管理');
INSERT INTO `sys_permission` VALUES ('ID1605162334081599450398642', 'ID1605162333232383403663172', '00005000020000400002', 'editTagInParam', '编辑标签入参管理');
INSERT INTO `sys_permission` VALUES ('ID1605282116528486698012607', 'ID1605282116020407753219474', '00003000010000200001', 'viewBaseModelMng', '查看基础模型类型集合');
INSERT INTO `sys_permission` VALUES ('ID1605282117101456454735475', 'ID1605282116020407753219474', '00003000010000200002', 'editBaseModelMng', '编辑基础模型类型集合');
INSERT INTO `sys_permission` VALUES ('ID1605282117197702512849116', 'ID1605282116225687186361928', '00003000010000100001', 'viewBaseModel', '查看基础模型');
INSERT INTO `sys_permission` VALUES ('ID1606041101416344449908556', 'ID1606041101038652411227709', '00003000010000300001', 'viewBaseModelProperty', '查看基础模型属性集合');
INSERT INTO `sys_permission` VALUES ('ID1606041102007838514971470', 'ID1606041101038652411227709', '00003000010000300002', 'editBaseModelProperty', '编辑基础模型属性集合');
INSERT INTO `sys_permission` VALUES ('ID1606041709219786744162407', 'ID1606041705513511573036650', '00005000020000700001', 'viewTagCalculate', '查看标签计算管理');
INSERT INTO `sys_permission` VALUES ('ID1606042231486330819969125', 'ID1606042227072809298873623', '00003000010000400001', 'viewTagDictionary', '查看标签字典');
INSERT INTO `sys_permission` VALUES ('ID1606042232050788648479742', 'ID1606042227072809298873623', '00003000010000400002', 'editTagDictionary', '编辑标签字典');
INSERT INTO `sys_permission` VALUES ('ID1606050954443750879921337', 'ID1606050954114043933453026', '00005000020000500001', 'viewCalculateRule', '查看计算规则');
INSERT INTO `sys_permission` VALUES ('ID1606050955036709441288380', 'ID1606050952003073803238933', '00005000030000200001', 'viewCustDetailPanelConfig', '查看客户详细页面配置');
INSERT INTO `sys_permission` VALUES ('ID1607262156492282854879836', 'ID1607262154104912171251511', '00005000030000100001', 'viewCustDetailPanel', '查看客户详细页面板');
INSERT INTO `sys_permission` VALUES ('ID1607262157036032114947798', 'ID1607262154104912171251511', '00005000030000100002', 'editCustDetailPanel', '编辑客户详细页面板');
INSERT INTO `sys_permission` VALUES ('ID1606111058585501519968512', 'ID1606041705513511573036650', '00005000020000700002', 'viewAllTagCalculate', '查看所有标签计算管理');
INSERT INTO `sys_permission` VALUES ('ID1606192139576353227921113', 'ID1606041705513511573036650', '00005000020000700003', 'editTagCalculate', '编辑标签计算管理');
INSERT INTO `sys_permission` VALUES ('ID1606192140178546281442858', 'ID1606041705513511573036650', '00005000020000700004', 'startTagCalculate', '启动计算');
INSERT INTO `sys_permission` VALUES ('ID1607272117059388980952105', 'ID1606050952003073803238933', '00005000030000200002', 'editCustDetailPanelConfig', '编辑客户详细页面配置');
INSERT INTO `sys_permission` VALUES ('ID1608101025542698196043372', 'ID1608091635266328815724140', '00004000020000100002', 'editTabelToJson', '编辑二维表转JSON');
INSERT INTO `sys_permission` VALUES ('ID1608091635531840051655586', 'ID1608091635266328815724140', '00004000020000100001', 'viewTableToJson', '查看二维表转JSON');
INSERT INTO `sys_permission` VALUES ('ID1607281016195139395920196', 'ID1607281013154494612048706', '00005000030000300001', 'viewReportTemplate', '查看报告模板');
INSERT INTO `sys_permission` VALUES ('ID1607281016350159482498837', 'ID1607281013154494612048706', '00005000030000300002', 'editReportTemplate', '编辑报告模板');
INSERT INTO `sys_permission` VALUES ('ID1607281016496713491136014', 'ID1607281015096066425726624', '00005000030000400001', 'viewReportTemplateConfig', '查看报告模板配置');
INSERT INTO `sys_permission` VALUES ('ID1607281017082963505292925', 'ID1607281015096066425726624', '00005000030000400002', 'editReportTemplateConfig', '编辑报告模板配置');
INSERT INTO `sys_permission` VALUES ('ID1608141140030787075520148', 'ID1608141138443267147550134', '00004000010000200001', 'viewImportFromRDB', '查看从关系数据库导入');
INSERT INTO `sys_permission` VALUES ('ID1608161044107287979655431', 'ID1608161043276231002591331', '00004000010000100001', 'viewHdfs', '查看HDFS文件系统');
INSERT INTO `sys_permission` VALUES ('ID1608161044257833277878068', 'ID1608161043276231002591331', '00004000010000100002', 'addHdfs', '添加HDFS文件');
INSERT INTO `sys_permission` VALUES ('ID1608161044442166449763425', 'ID1608161043276231002591331', '00004000010000100003', 'deleteHdfs', '删除HDFS文件');
INSERT INTO `sys_permission` VALUES ('ID1608161047244641863608555', 'ID1608161043276231002591331', '00004000010000100004', 'editHdfsName', '修改HDFS文件名');
INSERT INTO `sys_permission` VALUES ('ID1609032309422568178211920', 'ID1609032308539125789008385', '00004000030000100001', 'viewDatabaseSource', '查看数据库源');
INSERT INTO `sys_permission` VALUES ('ID1609032310017726540539531', 'ID1609032308539125789008385', '00004000030000100002', 'editDatabaseSource', '编辑数据库源');
INSERT INTO `sys_permission` VALUES ('ID1611102223126606592074738', 'ID1611102222236032469905583', '00005000030000500001', 'viewTagAccount', '查看客户信息');
INSERT INTO `sys_permission` VALUES ('ID1611102223219522093140861', 'ID1611102222236032469905583', '00005000030000500002', 'editTagAccount', '编辑客户信息');
INSERT INTO `sys_permission` VALUES ('ID1611232056354328263023126', 'ID1605102213576573906054037', '00005000010000100002', 'editTagTree', '编辑标签树');
INSERT INTO `sys_permission` VALUES ('ID1611232056456982841597534', 'ID1605102214185790795505676', '00005000010000200002', 'editTagNet', '编辑标签网');
INSERT INTO `sys_permission` VALUES ('ID1611232210209449571652840', 'ID1611232207423775411970557', '00005000020000100001', 'viewCalculateRuleLib', '查看计算规则样本库');
INSERT INTO `sys_permission` VALUES ('ID1611232210357881396592497', 'ID1611232208043167616594842', '00005000020000200001', 'viewCalculateRuleAssign', '查看计算规则授权');
INSERT INTO `sys_permission` VALUES ('ID1611232211147154003065824', 'ID1611232208151602781653117', '00005000020000300001', 'viewCalculateRuleImport', '查看计算规则引入');
INSERT INTO `sys_permission` VALUES ('ID1701101913473007835509546', 'ID2112091801537902648750314', '00005000010000400001', 'viewTagTable', '查看标签节点列表');
INSERT INTO `sys_permission` VALUES ('ID1612301114018125525571783', 'ID1612301109418408340052743', '00003000020000100001', 'viewExtModelMng', '查看扩展模型管理');
INSERT INTO `sys_permission` VALUES ('ID1612042158107163812927003', 'ID1611102222236032469905583', '00005000030000500003', 'viewAllTagAccount', '查看所有客户信息');
INSERT INTO `sys_permission` VALUES ('ID1612301113149212146622341', 'ID1612301110113568319902059', '00003000020000200001', 'viewExtModel', '查看扩展模型');
INSERT INTO `sys_permission` VALUES ('ID1612271659372822809330629', 'ID1608161043276231002591331', '00004000010000100005', 'uploadHdfs', '上传hdfs文件');
INSERT INTO `sys_permission` VALUES ('ID1612301114159372256957702', 'ID1612301109418408340052743', '00003000020000100002', 'editExtModelMng', '维护扩展模型管理');
INSERT INTO `sys_permission` VALUES ('ID1701101914008781441764829', 'ID2112091801537902648750314', '00005000010000400002', 'editTagTable', '编辑标签节点列表');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '主键ID',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名称',
  `enable` int(0) NULL DEFAULT NULL COMMENT '是否可用：0不可用，1可用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('ID1402120855096955922862851', '超级管理员', 1);

-- ----------------------------
-- Table structure for sys_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_permission`;
CREATE TABLE `sys_role_permission`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '主键ID',
  `roleId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色ID',
  `permissionId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限点ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色权限关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_permission
-- ----------------------------
INSERT INTO `sys_role_permission` VALUES ('ID2201091553314152353867186', 'ID1402120855096955922862851', 'ID1606192140178546281442858');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553314078687025369', 'ID1402120855096955922862851', 'ID1606192139576353227921113');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553313982675042283', 'ID1402120855096955922862851', 'ID1606111058585501519968512');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553313917275861854', 'ID1402120855096955922862851', 'ID1606041709219786744162407');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553313825296135170', 'ID1402120855096955922862851', 'ID1606050954443750879921337');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553313735560142752', 'ID1402120855096955922862851', 'ID1605162334081599450398642');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553313637432374996', 'ID1402120855096955922862851', 'ID1605162334081599450374107');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553313547825641787', 'ID1402120855096955922862851', 'ID1701101914008781441764829');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553313464007466876', 'ID1402120855096955922862851', 'ID1701101913473007835509546');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553313399596377387', 'ID1402120855096955922862851', 'ID1605102215242433774458644');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553313318473185179', 'ID1402120855096955922862851', 'ID1611232056354328263023126');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553313196931831502', 'ID1402120855096955922862851', 'ID1605102214594325896050839');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553313078441062891', 'ID1402120855096955922862851', 'ID1609032310017726540539531');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553313009003058915', 'ID1402120855096955922862851', 'ID1609032309422568178211920');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553312939756865801', 'ID1402120855096955922862851', 'ID1608101025542698196043372');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553312861723301325', 'ID1402120855096955922862851', 'ID1608091635531840051655586');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553312798823739335', 'ID1402120855096955922862851', 'ID1608141140030787075520148');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553312716463461256', 'ID1402120855096955922862851', 'ID1612271659372822809330629');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553312586667524027', 'ID1402120855096955922862851', 'ID1608161047244641863608555');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553312455136069793', 'ID1402120855096955922862851', 'ID1608161044442166449763425');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553312360544288896', 'ID1402120855096955922862851', 'ID1608161044257833277878068');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553312165993828109', 'ID1402120855096955922862851', 'ID1608161044107287979655431');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553311985106897230', 'ID1402120855096955922862851', 'ID1612301113149212146622341');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553311910540813023', 'ID1402120855096955922862851', 'ID1612301114159372256957702');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553311851188440055', 'ID1402120855096955922862851', 'ID1612301114018125525571783');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553311791619962317', 'ID1402120855096955922862851', 'ID1606042232050788648479742');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553311712280654160', 'ID1402120855096955922862851', 'ID1606042231486330819969125');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553311638684857902', 'ID1402120855096955922862851', 'ID1606041102007838514971470');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553311579035005878', 'ID1402120855096955922862851', 'ID1606041101416344449908556');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553311509897653206', 'ID1402120855096955922862851', 'ID1605282117101456454735475');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553311444938488435', 'ID1402120855096955922862851', 'ID1605282116528486698012607');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553311383448191223', 'ID1402120855096955922862851', 'ID1605282117197702512849116');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553311311408467715', 'ID1402120855096955922862851', 'ID1605162244021075685857022');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553311254337894218', 'ID1402120855096955922862851', 'ID1605162243478907520413515');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553311199710228034', 'ID1402120855096955922862851', 'ID1402191536440362028608194');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553311107283921052', 'ID1402120855096955922862851', 'ID1402191536251835863681350');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553310991742606240', 'ID1402120855096955922862851', 'ID1402191536040809819498428');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553310863460891619', 'ID1402120855096955922862851', 'ID1402120855096955922862855');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553310807003936037', 'ID1402120855096955922862851', 'ID1402191535493704707663571');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553310741424951470', 'ID1402120855096955922862851', 'ID1402120855096955922862853');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553310643349635459', 'ID1402120855096955922862851', 'ID1402191535325137023566734');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553310558412691226', 'ID1402120855096955922862851', 'ID1402120855096955922862852');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553310495540200357', 'ID1402120855096955922862851', 'ID1402191535132519189242462');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553310427693394692', 'ID1402120855096955922862851', 'ID1402120855096955922862854');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553310319581554649', 'ID1402120855096955922862851', 'ID1402120855096955922862856');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553310207888761298', 'ID1402120855096955922862851', 'ID1402120855096955922862851');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553310121159269242', 'ID1402120855096955922862851', 'ID1403121446115067590839490');
INSERT INTO `sys_role_permission` VALUES ('ID2201091553310044852727702', 'ID1402120855096955922862851', 'ID1402181604282460368527290');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '主键ID',
  `name` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登陆用户名',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `realName` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名称',
  `createDate` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建日期',
  `enable` int(0) NULL DEFAULT NULL COMMENT '是否可用：0不可用，1可用',
  `orgId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属机构',
  `industryTypes` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属的行业ID，用逗号隔开，值见字典表type=industryType',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', '57BA172A6BE125CCA2F449826F9980CA', '管理员', '2021-12-06 10:45:53', 1, 'ID1402241153514684476991034', '1,2,3');
INSERT INTO `sys_user` VALUES ('ID1709121606447652965219471', 'test', '21232F297A57A5A743894A0E4A801FC3', '测试人员', '2017-09-12 16:07:22', 1, 'ID1402241153514684476991034', '1,2,3');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '主键ID',
  `userId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户ID',
  `roleId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户角色关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('ID1402251436513072617616194', '1', 'ID1402120855096955922862851');
INSERT INTO `sys_user_role` VALUES ('ID1709121608176593011809361', 'ID1709121606447652965219471', 'ID1402120855096955922862851');

-- ----------------------------
-- Table structure for tag_account
-- ----------------------------
DROP TABLE IF EXISTS `tag_account`;
CREATE TABLE `tag_account`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '主键ID',
  `userId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属后端用户',
  `account` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '账号',
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `realName` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户真实姓名',
  `createDate` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `status` int(0) NULL DEFAULT 1 COMMENT '用户状态 0 不可用 1 可用',
  `phone` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `memo` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属单位',
  `type` int(0) NULL DEFAULT NULL COMMENT '用户类型，0 为普通用户，1 为系统用户',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `account_UNIQUE`(`account`) USING BTREE,
  INDEX `FK71D9E648C63F0320`(`userId`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '账户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tag_account
-- ----------------------------
INSERT INTO `tag_account` VALUES ('ID1701101349302871312555201', '1', 'admin', '57BA172A6BE125CCA2F449826F9980CA', 'admin', '2021-12-15 16:17:31', 1, NULL, '系统用户', 1);
INSERT INTO `tag_account` VALUES ('ID1709121606448361252976369', 'ID1709121606447652965219471', 'test', '21232F297A57A5A743894A0E4A801FC3', '测试人员', '2017-09-12 16:06:44', 1, NULL, '系统用户', 1);

-- ----------------------------
-- Table structure for tag_base_type
-- ----------------------------
DROP TABLE IF EXISTS `tag_base_type`;
CREATE TABLE `tag_base_type`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '主键ID',
  `parentTypeId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父数据类型',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据类型编码',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类名称',
  `treeCode` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '树结构编码',
  `type` int(0) NULL DEFAULT NULL COMMENT '类类型，具体参见字典表type=dataType',
  `isFirstShow` int(0) NULL DEFAULT NULL COMMENT '是否首先显示：0是，1不是',
  `memo` varchar(3000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '基础模型数据类型' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tag_base_type
-- ----------------------------
INSERT INTO `tag_base_type` VALUES ('-1', NULL, 'Object', '顶级类型', '', 1, 0, '顶级类型');
INSERT INTO `tag_base_type` VALUES ('ID1606041442402757730621039', 'ID1606202304011389502180611', 'Integer', '整型', '000010000100002', 1, 0, '');
INSERT INTO `tag_base_type` VALUES ('ID1606041455258139966562852', 'ID1606202304011389502180611', 'Float', '浮点型', '000010000100001', 1, 0, '');
INSERT INTO `tag_base_type` VALUES ('ID1606041455442065173847803', 'ID1606201301834928932308203', 'Text', '字符串型', '0000100002', 1, 0, '');
INSERT INTO `tag_base_type` VALUES ('ID1606041548221626379288007', 'ID1606041948737864364386236', 'Person', '人', '0000200001', 3, 1, '');
INSERT INTO `tag_base_type` VALUES ('ID1606041946579183194460162', 'ID1607072155411398743731160', 'PostalAddress', '地址', '0000200029000330000300001', 3, 0, '');
INSERT INTO `tag_base_type` VALUES ('ID1606041954092518736647987', 'ID1606041455442065173847803', 'Date', '日期型', '0000100004', 2, 0, 'yyyy-MM-dd');
INSERT INTO `tag_base_type` VALUES ('ID1606041954484897026617976', 'ID1606041455442065173847803', 'DateTime', '日期时间型', '0000100005', 2, 0, 'yyyy-MM-dd hh:mm:ss');
INSERT INTO `tag_base_type` VALUES ('ID1606041955182025798492067', 'ID1606041455442065173847803', 'Time', '时间型', '0000100006', 2, 0, 'hh:mm:ss');
INSERT INTO `tag_base_type` VALUES ('ID1606041956071866919035499', 'ID1606041455442065173847803', 'Url', 'WEB地址', '000010000200001', 2, 0, 'http://,https://,ftp://');
INSERT INTO `tag_base_type` VALUES ('ID1606041956405195042138877', 'ID1606041455442065173847803', 'Email', '邮箱', '000010000200002', 2, 0, 'xxx@email.com');
INSERT INTO `tag_base_type` VALUES ('ID1606051134420268427414740', 'ID1606041948737864364386236', 'Certificate', '认证证书', '0000200002', 3, 0, '');
INSERT INTO `tag_base_type` VALUES ('ID1606042059261072737209331', 'ID1606201301834928932308203', 'Enumeration', '枚举型', '0000100003', 1, 0, '');
INSERT INTO `tag_base_type` VALUES ('ID1606051031275129305238240', 'ID1606041948737864364386236', 'Identification', '证件', '0000200003', 3, 0, '');
INSERT INTO `tag_base_type` VALUES ('ID1606051104061710731316527', 'ID1606041948737864364386236', 'Contact', '联系方式', '0000200004', 3, 0, '');
INSERT INTO `tag_base_type` VALUES ('ID1606181541470878270376768', 'ID1606041948737864364386236', 'Family', '家庭关系', '0000200005', 3, 0, '');
INSERT INTO `tag_base_type` VALUES ('ID1606181602079146917200087', 'ID1606041948737864364386236', 'Alumnus', '教育经历信息', '0000200006', 3, 0, '');
INSERT INTO `tag_base_type` VALUES ('ID1606182039439287874991318', 'ID1606041948737864364386236', 'IndividualDeposit', '个人存款产品', '0000200007', 3, 0, '');
INSERT INTO `tag_base_type` VALUES ('ID1606191059443152359530333', 'ID1606041948737864364386236', 'Organization', '机构组织', '0000200008', 3, 0, '');
INSERT INTO `tag_base_type` VALUES ('ID1606191141228422698024569', 'ID1606041948737864364386236', 'IndividualLoans', '个人贷款产品', '0000200009', 3, 0, '');
INSERT INTO `tag_base_type` VALUES ('ID1606041948737864364386236', '-1', 'Thing', '事物通用类型', '00002', 3, 0, '描述事物复合类型的顶级类型');
INSERT INTO `tag_base_type` VALUES ('ID1606201301834928932308203', '-1', 'DataType', '基本数据类型', '00001', 1, 0, '基础类型的顶级类型');
INSERT INTO `tag_base_type` VALUES ('ID1606201956553617041953668', 'ID1606041948737864364386236', 'IndividualOnlineBank', '个人客户网上银行产品', '0000200011', 3, 0, '');
INSERT INTO `tag_base_type` VALUES ('ID1606202004471166250245553', 'ID1606041948737864364386236', 'IndividualMobileBank', '个人手机银行产品', '0000200012', 3, 0, '');
INSERT INTO `tag_base_type` VALUES ('ID1606202016475940462127132', 'ID1606041948737864364386236', 'IndividualWeChatBank', '个人微信银行产品', '0000200013', 3, 0, '');
INSERT INTO `tag_base_type` VALUES ('ID1606202022174884784008287', 'ID1606041948737864364386236', 'IndividualPhoneBank', '个人电话银行产品', '0000200014', 3, 0, '');
INSERT INTO `tag_base_type` VALUES ('ID1606202040497684955661032', 'ID1606041948737864364386236', 'IndividualFinancing', '个人理财产品', '0000200015', 3, 0, '');
INSERT INTO `tag_base_type` VALUES ('ID1606202056579829957769648', 'ID1606041948737864364386236', 'IndividualFund', '个人基金产品', '0000200016', 3, 0, '');
INSERT INTO `tag_base_type` VALUES ('ID1606202126070676332333704', 'ID1606041948737864364386236', 'IndividualFundTargetInvestment', '个人基金定投', '0000200017', 3, 0, '');
INSERT INTO `tag_base_type` VALUES ('ID1606202140081398359294650', 'ID1606041948737864364386236', 'IndividualThirdDepository', '个人三方存管', '0000200018', 3, 0, '');
INSERT INTO `tag_base_type` VALUES ('ID1606202224431876420829957', 'ID1606041948737864364386236', 'IndividualDebitCard', '个人借记卡产品', '0000200019', 3, 0, '');
INSERT INTO `tag_base_type` VALUES ('ID1606202229281134126016397', 'ID1606041948737864364386236', 'IndividualCreditCard', '个人信用卡产品', '0000200020', 3, 0, '');
INSERT INTO `tag_base_type` VALUES ('ID1606202233501791543691591', 'ID1606041948737864364386236', 'IndividualCreditCardQuota', '个人信用卡额度', '0000200021', 3, 0, '');
INSERT INTO `tag_base_type` VALUES ('ID1606202251063780501817401', 'ID1606041948737864364386236', 'IndividualInsuranceAgents', '个人代理保险产品', '0000200022', 3, 0, '');
INSERT INTO `tag_base_type` VALUES ('ID1606202257362892545632833', 'ID1606041948737864364386236', 'IndividualDemandDepositsTrading', '个人活期存款交易', '0000200023', 3, 0, '');
INSERT INTO `tag_base_type` VALUES ('ID1606202304011389502180610', 'ID1606041948737864364386236', 'IndividualDepositsTrading', '个人定期存款交易', '0000200024', 3, 0, '');
INSERT INTO `tag_base_type` VALUES ('ID1606202304011389502180611', 'ID1606201301834928932308203', 'Number', '数字型', '0000100001', 1, 0, NULL);
INSERT INTO `tag_base_type` VALUES ('ID1606072147401110292952758', 'ID1606201301834928932308203', 'Boolean', '布尔型', '0000100004', 1, 0, '');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731272', 'ID1606041548221626379288007', 'Patient', 'Patient', '000020000100001', 3, 0, 'A patient is any person recipient of health care services.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731090', 'ID1606041948737864364386236', 'Action', 'Action', '0000200025', 3, 0, 'An action performed by a direct agent and indirect participants upon a direct object. Optionally happens at a location with the help of an inanimate instrument. The execution of the action may produce a result. Specific action sub-type documentation specifies the exact expectation of each argument/role.       <br/><br/>See also <a href=\"http://blog.schema.org/2014/04/announcing-schemaorg-actions.html\">blog post</a>       and <a href=\"http://schema.org/docs/actions.html\">Actions overview document</a>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731031', 'ID1607072155411398743731090', 'TradeAction', 'TradeAction', '000020002500001', 3, 0, 'The act of participating in an exchange of goods and services for monetary compensation. An agent trades an object, product or service with a participant in exchange for a one time or periodic payment.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731111', 'ID1607072155411398743731031', 'BuyAction', 'BuyAction', '00002000250000100001', 3, 0, 'The act of giving money to a seller in exchange for goods or services rendered. An agent buys an object, product, or service from a seller for a price. Reciprocal of SellAction.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731214', 'ID1607072155411398743731031', 'PreOrderAction', 'PreOrderAction', '00002000250000100002', 3, 0, 'An agent orders a (not yet released) object/product/service to be delivered/sent.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731219', 'ID1607072155411398743731031', 'SellAction', 'SellAction', '00002000250000100003', 3, 0, 'The act of taking money from a buyer in exchange for goods or services rendered. An agent sells an object, product, or service to a buyer for a price. Reciprocal of BuyAction.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731495', 'ID1607072155411398743731031', 'QuoteAction', 'QuoteAction', '00002000250000100004', 3, 0, 'An agent quotes/estimates/appraises an object/product/service with a price at a location/store.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731502', 'ID1607072155411398743731031', 'PayAction', 'PayAction', '00002000250000100005', 3, 0, 'An agent pays a price to a participant.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731510', 'ID1607072155411398743731031', 'TipAction', 'TipAction', '00002000250000100006', 3, 0, 'The act of giving money voluntarily to a beneficiary in recognition of services rendered.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731520', 'ID1607072155411398743731031', 'DonateAction', 'DonateAction', '00002000250000100007', 3, 0, 'The act of providing goods, services, or money without compensation, often for philanthropic reasons.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731549', 'ID1607072155411398743731031', 'OrderAction', 'OrderAction', '00002000250000100008', 3, 0, 'An agent orders an object/product/service to be delivered/sent.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731563', 'ID1607072155411398743731031', 'RentAction', 'RentAction', '00002000250000100009', 3, 0, 'The act of giving money in return for temporary use, but not ownership, of an object such as a vehicle or property. For example, an agent rents a property from a landlord in exchange for a periodic payment.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731066', 'ID1607072155411398743731090', 'ConsumeAction', 'ConsumeAction', '000020002500002', 3, 0, 'The act of ingesting information/resources/food.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731047', 'ID1607072155411398743731066', 'UseAction', 'UseAction', '00002000250000200001', 3, 0, 'The act of applying an object to its intended purpose.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731457', 'ID1607072155411398743731047', 'WearAction', 'WearAction', '0000200025000020000100001', 3, 0, 'The act of dressing oneself in clothing.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731239', 'ID1607072155411398743731066', 'ReadAction', 'ReadAction', '00002000250000200002', 3, 0, 'The act of consuming written content.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731248', 'ID1607072155411398743731066', 'ListenAction', 'ListenAction', '00002000250000200003', 3, 0, 'The act of consuming audio content.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731433', 'ID1607072155411398743731066', 'ViewAction', 'ViewAction', '00002000250000200004', 3, 0, 'The act of consuming static visual content.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731440', 'ID1607072155411398743731066', 'EatAction', 'EatAction', '00002000250000200005', 3, 0, 'The act of swallowing solid objects.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731443', 'ID1607072155411398743731066', 'InstallAction', 'InstallAction', '00002000250000200006', 3, 0, 'The act of installing an application.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731464', 'ID1607072155411398743731066', 'WatchAction', 'WatchAction', '00002000250000200007', 3, 0, 'The act of consuming dynamic/moving visual content.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731558', 'ID1607072155411398743731066', 'DrinkAction', 'DrinkAction', '00002000250000200008', 3, 0, 'The act of swallowing liquids.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731134', 'ID1607072155411398743731090', 'AchieveAction', 'AchieveAction', '000020002500003', 3, 0, 'The act of accomplishing something via previous efforts. It is an instantaneous action rather than an ongoing process.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731157', 'ID1607072155411398743731134', 'WinAction', 'WinAction', '00002000250000300001', 3, 0, 'The act of achieving victory in a competitive activity.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731164', 'ID1607072155411398743731134', 'LoseAction', 'LoseAction', '00002000250000300002', 3, 0, 'The act of being defeated in a competitive activity.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731385', 'ID1607072155411398743731134', 'TieAction', 'TieAction', '00002000250000300003', 3, 0, 'The act of reaching a draw in a competitive activity.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731205', 'ID1607072155411398743731090', 'OrganizeAction', 'OrganizeAction', '000020002500004', 3, 0, 'The act of manipulating/administering/supervising/controlling one or more objects.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731005', 'ID1607072155411398743731205', 'BookmarkAction', 'BookmarkAction', '00002000250000400001', 3, 0, 'An agent bookmarks/flags/labels/tags/marks an object.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731059', 'ID1607072155411398743731205', 'ApplyAction', 'ApplyAction', '00002000250000400002', 3, 0, 'The act of registering to an organization/service without the guarantee to receive it. <p>Related actions:</p><ul><li><a href=\"http://schema.org/RegisterAction\">RegisterAction</a>: Unlike RegisterAction, ApplyAction has no guarantees that the application will be accepted</li></ul>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731089', 'ID1607072155411398743731205', 'AllocateAction', 'AllocateAction', '00002000250000400003', 3, 0, 'The act of organizing tasks/objects/events by associating resources to it.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731092', 'ID1607072155411398743731089', 'AcceptAction', 'AcceptAction', '0000200025000040000300001', 3, 0, 'The act of committing to/adopting an object.<p>Related actions:</p><ul><li><a href=\"http://schema.org/RejectAction\">RejectAction</a>: The antonym of AcceptAction</li></ul>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731198', 'ID1607072155411398743731089', 'RejectAction', 'RejectAction', '0000200025000040000300002', 3, 0, 'The act of rejecting to/adopting an object.<p>Related actions:</p><ul><li><a href=\"http://schema.org/AcceptAction\">AcceptAction</a>: The antonym of RejectAction</li></ul>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731199', 'ID1607072155411398743731089', 'AssignAction', 'AssignAction', '0000200025000040000300003', 3, 0, 'The act of allocating an action/event/task to some destination (someone or something).');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731218', 'ID1607072155411398743731089', 'AuthorizeAction', 'AuthorizeAction', '0000200025000040000300004', 3, 0, 'The act of granting permission to an object.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731356', 'ID1607072155411398743731205', 'PlanAction', 'PlanAction', '00002000250000400004', 3, 0, 'The act of planning the execution of an event/task/action/reservation/plan to a future date.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731104', 'ID1607072155411398743731356', 'ScheduleAction', 'ScheduleAction', '0000200025000040000400001', 3, 0, 'Scheduling future actions, events, or tasks.<p>Related actions:</p><ul><li><a href=\"http://schema.org/ReserveAction\">ReserveAction</a>: Unlike ReserveAction, ScheduleAction allocates future actions (e.g. an event, a task, etc) towards a time slot / spatial allocation</li></ul>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731188', 'ID1607072155411398743731356', 'CancelAction', 'CancelAction', '0000200025000040000400002', 3, 0, 'The act of asserting that a future event/action is no longer going to happen.<p>Related actions:</p><ul><li><a href=\"http://schema.org/ConfirmAction\">ConfirmAction</a>: The antonym of CancelAction</li></ul>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731372', 'ID1607072155411398743731356', 'ReserveAction', 'ReserveAction', '0000200025000040000400003', 3, 0, 'Reserving a concrete object.<p>Related actions:</p><ul><li><a href=\"http://schema.org/ScheduleAction\">ScheduleAction</a>: Unlike ScheduleAction, ReserveAction reserves concrete objects (e.g. a table, a hotel) towards a time slot / spatial allocation</li></ul>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731229', 'ID1607072155411398743731090', 'TransferAction', 'TransferAction', '000020002500005', 3, 0, 'The act of transferring/moving (abstract or concrete) animate or inanimate objects from one place to another.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731086', 'ID1607072155411398743731229', 'LendAction', 'LendAction', '00002000250000500001', 3, 0, 'The act of providing an object under an agreement that it will be returned at a later date. Reciprocal of BorrowAction.<p>Related actions:</p><ul><li><a href=\"http://schema.org/BorrowAction\">BorrowAction</a>: Reciprocal of LendAction</li></ul>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731290', 'ID1607072155411398743731229', 'SendAction', 'SendAction', '00002000250000500002', 3, 0, 'The act of physically/electronically dispatching an object for transfer from an origin to a destination.<p>Related actions:</p><ul><li><a href=\"http://schema.org/ReceiveAction\">ReceiveAction</a>: The reciprocal of SendAction.</li><li><a href=\"http://schema.org/GiveAction\">GiveAction</a>: Unlike GiveAction, SendAction does not imply the transfer of ownership (e.g. I can send you my laptop, but I\"m not necessarily giving it to you)</li></ul>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731387', 'ID1607072155411398743731229', 'DownloadAction', 'DownloadAction', '00002000250000500003', 3, 0, 'The act of downloading an object.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731512', 'ID1607072155411398743731229', 'GiveAction', 'GiveAction', '00002000250000500004', 3, 0, 'The act of transferring ownership of an object to a destination. Reciprocal of TakeAction.<p>Related actions:</p><ul><li><a href=\"http://schema.org/TakeAction\">TakeAction</a>: Reciprocal of GiveAction.</li><li><a href=\"http://schema.org/SendAction\">SendAction</a>: Unlike SendAction, GiveAction implies that ownership is being transferred (e.g. I may send my laptop to you, but that doesn\"t mean I\"m giving it to you)</li></ul>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731532', 'ID1607072155411398743731229', 'TakeAction', 'TakeAction', '00002000250000500005', 3, 0, 'The act of gaining ownership of an object from an origin. Reciprocal of GiveAction.<p>Related actions:</p><ul><li><a href=\"http://schema.org/GiveAction\">GiveAction</a>: The reciprocal of TakeAction.</li><li><a href=\"http://schema.org/ReceiveAction\">ReceiveAction</a>: Unlike ReceiveAction, TakeAction implies that ownership has been transfered</li></ul>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731547', 'ID1607072155411398743731229', 'ReturnAction', 'ReturnAction', '00002000250000500006', 3, 0, 'The act of returning to the origin that which was previously received (concrete objects) or taken (ownership).');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731628', 'ID1607072155411398743731229', 'ReceiveAction', 'ReceiveAction', '00002000250000500007', 3, 0, 'The act of physically/electronically taking delivery of an object thathas been transferred from an origin to a destination. Reciprocal of SendAction.<p>Related actions:</p><ul><li><a href=\"http://schema.org/SendAction\">SendAction</a>: The reciprocal of ReceiveAction.</li><li><a href=\"http://schema.org/TakeAction\">TakeAction</a>: Unlike TakeAction, ReceiveAction does not imply that the ownership has been transfered (e.g. I can receive a package, but it does not mean the package is now mine)</li></ul>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731642', 'ID1607072155411398743731229', 'BorrowAction', 'BorrowAction', '00002000250000500008', 3, 0, 'The act of obtaining an object under an agreement to return it at a later date. Reciprocal of LendAction.<p>Related actions:</p><ul><li><a href=\"http://schema.org/LendAction\">LendAction</a>: Reciprocal of BorrowAction</li></ul>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731277', 'ID1607072155411398743731090', 'PlayAction', 'PlayAction', '000020002500006', 3, 0, 'The act of playing/exercising/training/performing for enjoyment, leisure, recreation, Competition or exercise.<p>Related actions:</p><ul><li><a href=\"http://schema.org/ListenAction\">ListenAction</a>: Unlike ListenAction (which is under ConsumeAction), PlayAction refers to performing for an audience or at an event, rather than consuming music.</li><li><a href=\"http://schema.org/WatchAction\">WatchAction</a>: Unlike WatchAction (which is under ConsumeAction), PlayAction refers to showing/displaying for an audience or at an event, rather than consuming visual content</li></ul>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731530', 'ID1607072155411398743731277', 'ExerciseAction', 'ExerciseAction', '00002000250000600001', 3, 0, 'The act of participating in exertive activity for the purposes of improving health and fitness.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731580', 'ID1607072155411398743731277', 'PerformAction', 'PerformAction', '00002000250000600002', 3, 0, 'The act of participating in performance arts.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731336', 'ID1607072155411398743731090', 'CreateAction', 'CreateAction', '000020002500007', 3, 0, 'The act of deliberately creating/producing/generating/building a result out of the agent.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731050', 'ID1607072155411398743731336', 'WriteAction', 'WriteAction', '00002000250000700001', 3, 0, 'The act of authoring written creative content.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731147', 'ID1607072155411398743731336', 'FilmAction', 'FilmAction', '00002000250000700002', 3, 0, 'The act of capturing sound and moving images on film, video, or digitally.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731388', 'ID1607072155411398743731336', 'CookAction', 'CookAction', '00002000250000700003', 3, 0, 'The act of producing/preparing food.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731406', 'ID1607072155411398743731336', 'PaintAction', 'PaintAction', '00002000250000700004', 3, 0, 'The act of producing a painting, typically with paint and canvas as instruments.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731451', 'ID1607072155411398743731336', 'DrawAction', 'DrawAction', '00002000250000700005', 3, 0, 'The act of producing a visual/graphical representation of an object, typically with a pen/pencil and paper as instruments.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731497', 'ID1607072155411398743731336', 'PhotographAction', 'PhotographAction', '00002000250000700006', 3, 0, 'The act of capturing still images of objects using a camera.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731379', 'ID1607072155411398743731090', 'UpdateAction', 'UpdateAction', '000020002500008', 3, 0, 'The act of managing by changing/editing the state of the object.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731364', 'ID1607072155411398743731379', 'ReplaceAction', 'ReplaceAction', '00002000250000800001', 3, 0, 'The act of editing a recipient by replacing an old object with a new object.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731378', 'ID1607072155411398743731379', 'AddAction', 'AddAction', '00002000250000800002', 3, 0, 'The act of editing by adding an object to a collection.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731554', 'ID1607072155411398743731378', 'InsertAction', 'InsertAction', '0000200025000080000200001', 3, 0, 'The act of adding at a specific location in an ordered collection.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731088', 'ID1607072155411398743731554', 'AppendAction', 'AppendAction', '000020002500008000020000100001', 3, 0, 'The act of inserting at the end if an ordered collection.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731118', 'ID1607072155411398743731554', 'PrependAction', 'PrependAction', '000020002500008000020000100002', 3, 0, 'The act of inserting at the beginning if an ordered collection.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731569', 'ID1607072155411398743731379', 'DeleteAction', 'DeleteAction', '00002000250000800003', 3, 0, 'The act of editing a recipient by removing one of its objects.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731386', 'ID1607072155411398743731090', 'SearchAction', 'SearchAction', '000020002500009', 3, 0, 'The act of searching for an object.<p>Related actions:</p><ul><li><a href=\"http://schema.org/FindAction\">FindAction</a>: SearchAction generally leads to a FindAction, but not necessarily</li></ul>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731460', 'ID1607072155411398743731090', 'InteractAction', 'InteractAction', '000020002500010', 3, 0, 'The act of interacting with another person or organization.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731054', 'ID1607072155411398743731460', 'MarryAction', 'MarryAction', '00002000250001000001', 3, 0, 'The act of marrying a person.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731209', 'ID1607072155411398743731460', 'UnRegisterAction', 'UnRegisterAction', '00002000250001000002', 3, 0, 'The act of un-registering from a service.<p>Related actions:</p><ul><li><a href=\"http://schema.org/RegisterAction\">RegisterAction</a>: antonym of UnRegisterAction.</li><li><a href=\"http://schema.org/Leave\">Leave</a>: Unlike LeaveAction, UnRegisterAction implies that you are unregistering from a service you werer previously registered, rather than leaving a team/group of people</li></ul>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731249', 'ID1607072155411398743731460', 'SubscribeAction', 'SubscribeAction', '00002000250001000003', 3, 0, 'The act of forming a personal connection with someone/something (object) unidirectionally/asymmetrically to get updates pushed to.<p>Related actions:</p><ul><li><a href=\"http://schema.org/FollowAction\">FollowAction</a>: Unlike FollowAction, SubscribeAction implies that the subscriber acts as a passive agent being constantly/actively pushed for updates.</li><li><a href=\"http://schema.org/RegisterAction\">RegisterAction</a>: Unlike RegisterAction, SubscribeAction implies that the agent is interested in continuing receiving updates from the object.</li><li><a href=\"http://schema.org/JoinAction\">JoinAction</a>: Unlike JoinAction, SubscribeAction implies that the agent is interested in continuing receiving updates from the object</li></ul>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731274', 'ID1607072155411398743731460', 'CommunicateAction', 'CommunicateAction', '00002000250001000004', 3, 0, 'The act of conveying information to another person via a communication medium (instrument) such as speech, email, or telephone conversation.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731035', 'ID1607072155411398743731274', 'ShareAction', 'ShareAction', '0000200025000100000400001', 3, 0, 'The act of distributing content to people for their amusement or edification.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731211', 'ID1607072155411398743731274', 'InformAction', 'InformAction', '0000200025000100000400002', 3, 0, 'The act of notifying someone of information pertinent to them, with no expectation of a response.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731083', 'ID1607072155411398743731211', 'RsvpAction', 'RsvpAction', '000020002500010000040000200001', 3, 0, 'The act of notifying an event organizer as to whether you expect to attend the event.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731159', 'ID1607072155411398743731211', 'ConfirmAction', 'ConfirmAction', '000020002500010000040000200002', 3, 0, 'The act of notifying someone that a future event/action is going to happen as expected.<p>Related actions:</p><ul><li><a href=\"http://schema.org/CancelAction\">CancelAction</a>: The antonym of ConfirmAction</li></ul>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731252', 'ID1607072155411398743731274', 'AskAction', 'AskAction', '0000200025000100000400003', 3, 0, 'The act of posing a question / favor to someone.<p>Related actions:</p><ul><li><a href=\"http://schema.org/ReplyAction\">ReplyAction</a>: Appears generally as a response to AskAction</li></ul>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731435', 'ID1607072155411398743731274', 'CheckOutAction', 'CheckOutAction', '0000200025000100000400004', 3, 0, 'The act of an agent communicating (service provider, social media, etc) their departure of a previously reserved service (e.g. flight check in) or place (e.g. hotel).<p>Related actions:</p><ul><li><a href=\"http://schema.org/CheckInAction\">CheckInAction</a>: The antonym of CheckOutAction.</li><li><a href=\"http://schema.org/DepartAction\">DepartAction</a>: Unlike DepartAction, CheckOutAction implies that the agent is informing/confirming the end of a previously reserved service.</li><li><a href=\"http://schema.org/CancelAction\">CancelAction</a>: Unlike CancelAction, CheckOutAction implies that the agent is informing/confirming the end of a previously reserved service</li></ul>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731537', 'ID1607072155411398743731274', 'CheckInAction', 'CheckInAction', '0000200025000100000400005', 3, 0, '<p>The act of an agent communicating (service provider, social media, etc) their arrival by registering/confirming for a previously reserved service (e.g. flight check in) or at a place (e.g. hotel), possibly resulting in a result (boarding pass, etc).</p> <p>Related actions:</p> <ul> <li><a class=\"localLink\" href=\"/CheckOutAction\">CheckOutAction</a>: The antonym of CheckInAction.</li> <li><a class=\"localLink\" href=\"/ArriveAction\">ArriveAction</a>: Unlike ArriveAction, CheckInAction implies that the agent is informing/confirming the start of a previously reserved service.</li> <li><a class=\"localLink\" href=\"/ConfirmAction\">ConfirmAction</a>: Unlike ConfirmAction, CheckInAction implies that the agent is informing/confirming the <em>start</em> of a previously reserved service rather than its validity/existence.</li> </ul>');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731583', 'ID1607072155411398743731274', 'CommentAction', 'CommentAction', '0000200025000100000400006', 3, 0, 'The act of generating a comment about a subject.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731602', 'ID1607072155411398743731274', 'InviteAction', 'InviteAction', '0000200025000100000400007', 3, 0, 'The act of asking someone to attend an event. Reciprocal of RsvpAction.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731640', 'ID1607072155411398743731274', 'ReplyAction', 'ReplyAction', '0000200025000100000400008', 3, 0, 'The act of responding to a question/message asked/sent by the object. Related to <a href=\"AskAction\">AskAction</a>.<p>Related actions:</p><ul><li><a href=\"http://schema.org/AskAction\">AskAction</a>: Appears generally as an origin of a ReplyAction</li></ul>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731399', 'ID1607072155411398743731460', 'BefriendAction', 'BefriendAction', '00002000250001000005', 3, 0, 'The act of forming a personal connection with someone (object) mutually/bidirectionally/symmetrically.<p>Related actions:</p><ul><li><a href=\"http://schema.org/FollowAction\">FollowAction</a>: Unlike FollowAction, BefriendAction implies that the connection is reciprocal</li></ul>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731404', 'ID1607072155411398743731460', 'LeaveAction', 'LeaveAction', '00002000250001000006', 3, 0, 'An agent leaves an event / group with participants/friends at a location.<p>Related actions:</p><ul><li><a href=\"http://schema.org/JoinAction\">JoinAction</a>: The antonym of LeaveAction.</li><li><a href=\"http://schema.org/UnRegisterAction\">UnRegisterAction</a>: Unlike UnRegisterAction, LeaveAction implies leaving a group/team of people rather than a service</li></ul>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731458', 'ID1607072155411398743731460', 'JoinAction', 'JoinAction', '00002000250001000007', 3, 0, 'An agent joins an event/group with participants/friends at a location.<p>Related actions:</p><ul><li><a href=\"http://schema.org/RegisterAction\">RegisterAction</a>: Unlike RegisterAction, JoinAction refers to joining a group/team of people.</li><li><a href=\"http://schema.org/SubscribeAction\">SubscribeAction</a>: Unlike SubscribeAction, JoinAction does not imply that you\"ll be receiving updates.</li><li><a href=\"http://schema.org/FollowAction\">FollowAction</a>: Unlike FollowAction, JoinAction does not imply that you\"ll be polling for updates</li></ul>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731514', 'ID1607072155411398743731460', 'FollowAction', 'FollowAction', '00002000250001000008', 3, 0, 'The act of forming a personal connection with someone/something (object) unidirectionally/asymmetrically to get updates polled from.<p>Related actions:</p><ul><li><a href=\"http://schema.org/BefriendAction\">BefriendAction</a>: Unlike BefriendAction, FollowAction implies that the connection is <em>not</em> necessarily reciprocal.</li><li><a href=\"http://schema.org/SubscribeAction\">SubscribeAction</a>: Unlike SubscribeAction, FollowAction implies that the follower acts as an active agent constantly/actively polling for updates.</li><li><a href=\"http://schema.org/RegisterAction\">RegisterAction</a>: Unlike RegisterAction, FollowAction implies that the agent is interested in continuing receiving updates from the object.</li><li><a href=\"http://schema.org/JoinAction\">JoinAction</a>: Unlike JoinAction, FollowAction implies that the agent is interested in getting updates from the object.</li><li><a href=\"http://schema.org/TrackAction\">TrackAction</a>: Unlike TrackAction, FollowAction refers to the polling of updates of all aspects of animate objects rather than the location of inanimate objects (e.g. you track a package, but you don\"t follow it)</li></ul>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731621', 'ID1607072155411398743731460', 'RegisterAction', 'RegisterAction', '00002000250001000009', 3, 0, 'The act of registering to be a user of a service, product or web page.<p>Related actions:</p><ul><li><a href=\"http://schema.org/JoinAction\">JoinAction</a>: Unlike JoinAction, RegisterAction implies you are registering to be a user of a service, <em>not</em> a group/team of people.</li><li><a href=\"http://schema.org/FollowAction\">FollowAction</a>: Unlike FollowAction, RegisterAction doesn\"t imply that the agent is expecting to poll for updates from the object.</li><li><a href=\"http://schema.org/SubscribeAction\">SubscribeAction</a>: Unlike SubscribeAction, RegisterAction doesn\"t imply that the agent is expecting updates from the object</li></ul>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731557', 'ID1607072155411398743731090', 'FindAction', 'FindAction', '000020002500011', 3, 0, 'The act of finding an object.<p>Related actions:</p><ul><li><a href=\"http://schema.org/SearchAction\">SearchAction</a>: FindAction is generally lead by a SearchAction, but not necessarily</li></ul>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731278', 'ID1607072155411398743731557', 'TrackAction', 'TrackAction', '00002000250001100001', 3, 0, 'An agent tracks an object for updates.<p>Related actions:</p><ul><li><a href=\"http://schema.org/FollowAction\">FollowAction</a>: Unlike FollowAction, TrackAction refers to the interest on the location of innanimates objects.</li><li><a href=\"http://schema.org/SubscribeAction\">SubscribeAction</a>: Unlike SubscribeAction, TrackAction refers to  the interest on the location of innanimate objects</li></ul>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731411', 'ID1607072155411398743731557', 'DiscoverAction', 'DiscoverAction', '00002000250001100002', 3, 0, 'The act of discovering/finding an object.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731551', 'ID1607072155411398743731557', 'CheckAction', 'CheckAction', '00002000250001100003', 3, 0, 'An agent inspects/determines/investigates/inquire or examine an object\"s accuracy/quality/condition or state.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731606', 'ID1607072155411398743731090', 'MoveAction', 'MoveAction', '000020002500012', 3, 0, 'The act of an agent relocating to a place.<p>Related actions:</p><ul><li><a href=\"http://schema.org/TransferAction\">TransferAction</a>: Unlike TransferAction, the subject of the move is a living Person or Organization rather than an inanimate object</li></ul>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731292', 'ID1607072155411398743731606', 'DepartAction', 'DepartAction', '00002000250001200001', 3, 0, 'The act of  departing from a place. An agent departs from an fromLocation for a destination, optionally with participants.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731474', 'ID1607072155411398743731606', 'TravelAction', 'TravelAction', '00002000250001200002', 3, 0, 'The act of traveling from an fromLocation to a destination by a specified mode of transport, optionally with participants.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731619', 'ID1607072155411398743731606', 'ArriveAction', 'ArriveAction', '00002000250001200003', 3, 0, 'The act of arriving at a place. An agent arrives at a destination from an fromLocation, optionally with participants.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731609', 'ID1607072155411398743731090', 'AssessAction', 'AssessAction', '000020002500013', 3, 0, 'The act of forming one\"s opinion, reaction or sentiment.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731117', 'ID1607072155411398743731609', 'IgnoreAction', 'IgnoreAction', '00002000250001300001', 3, 0, 'The act of intentionally disregarding the object. An agent ignores an object.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731124', 'ID1607072155411398743731609', 'ChooseAction', 'ChooseAction', '00002000250001300002', 3, 0, 'The act of expressing a preference from a set of options or a large or unbounded set of choices/options.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731140', 'ID1607072155411398743731124', 'VoteAction', 'VoteAction', '0000200025000130000200001', 3, 0, 'The act of expressing a preference from a fixed/finite/structured set of choices/options.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731402', 'ID1607072155411398743731609', 'ReactAction', 'ReactAction', '00002000250001300003', 3, 0, 'The act of responding instinctively and emotionally to an object, expressing a sentiment.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731182', 'ID1607072155411398743731402', 'EndorseAction', 'EndorseAction', '0000200025000130000300001', 3, 0, 'An agent approves/certifies/likes/supports/sanction an object.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731346', 'ID1607072155411398743731402', 'WantAction', 'WantAction', '0000200025000130000300002', 3, 0, 'The act of expressing a desire about the object. An agent wants an object.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731421', 'ID1607072155411398743731402', 'DislikeAction', 'DislikeAction', '0000200025000130000300003', 3, 0, 'The act of expressing a negative sentiment about the object. An agent dislikes an object (a proposition, topic or theme) with participants.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731425', 'ID1607072155411398743731402', 'DisagreeAction', 'DisagreeAction', '0000200025000130000300004', 3, 0, 'The act of expressing a difference of opinion with the object. An agent disagrees to/about an object (a proposition, topic or theme) with participants.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731539', 'ID1607072155411398743731402', 'LikeAction', 'LikeAction', '0000200025000130000300005', 3, 0, 'The act of expressing a positive sentiment about the object. An agent likes an object (a proposition, topic or theme) with participants.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731581', 'ID1607072155411398743731402', 'AgreeAction', 'AgreeAction', '0000200025000130000300006', 3, 0, 'The act of expressing a consistency of opinion with the object. An agent agrees to/about an object (a proposition, topic or theme) with participants.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731545', 'ID1607072155411398743731609', 'ReviewAction', 'ReviewAction', '00002000250001300004', 3, 0, 'The act of producing a balanced opinion about the object for an audience. An agent reviews an object with participants resulting in a review.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731643', 'ID1607072155411398743731090', 'ControlAction', 'ControlAction', '000020002500014', 3, 0, 'An agent controls a device or application.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731115', 'ID1607072155411398743731643', 'ResumeAction', 'ResumeAction', '00002000250001400001', 3, 0, 'The act of resuming a device or application which was formerly paused (e.g. resume music playback or resume a timer).');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731119', 'ID1607072155411398743731643', 'SuspendAction', 'SuspendAction', '00002000250001400002', 3, 0, 'The act of momentarily pausing a device or application (e.g. pause music playback or pause a timer).');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731131', 'ID1607072155411398743731643', 'DeactivateAction', 'DeactivateAction', '00002000250001400003', 3, 0, 'The act of stopping or deactivating a device or application (e.g. stopping a timer or turning off a flashlight).');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731634', 'ID1607072155411398743731643', 'ActivateAction', 'ActivateAction', '00002000250001400004', 3, 0, 'The act of starting or activating a device or application (e.g. starting a timer or turning on a flashlight).');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731350', 'ID1606041948737864364386236', 'Place', 'Place', '0000200026', 3, 0, 'Entities that have a somewhat fixed, physical extension.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731037', 'ID1607072155411398743731350', 'AdministrativeArea', 'AdministrativeArea', '000020002600001', 3, 0, 'A geographical region, typically under the jurisdiction of a particular government.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731150', 'ID1607072155411398743731037', 'State', 'State', '00002000260000100001', 3, 0, 'A state or province of a country.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731525', 'ID1607072155411398743731037', 'Country', 'Country', '00002000260000100002', 3, 0, 'A country.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731617', 'ID1607072155411398743731037', 'City', 'City', '00002000260000100003', 3, 0, 'A city or town.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731114', 'ID1607072155411398743731350', 'CivicStructure', 'CivicStructure', '000020002600002', 3, 0, 'A public structure, such as a town hall or concert hall.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731003', 'ID1607072155411398743731114', 'PoliceStation', 'PoliceStation', '00002000260000200001', 3, 0, 'A police station.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731032', 'ID1607072155411398743731114', 'Beach', 'Beach', '00002000260000200002', 3, 0, 'Beach.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731040', 'ID1607072155411398743731114', 'GovernmentBuilding', 'GovernmentBuilding', '00002000260000200003', 3, 0, 'A government building.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731087', 'ID1607072155411398743731040', 'CityHall', 'CityHall', '0000200026000020000300001', 3, 0, 'A city hall.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731263', 'ID1607072155411398743731040', 'Courthouse', 'Courthouse', '0000200026000020000300002', 3, 0, 'A courthouse.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731349', 'ID1607072155411398743731040', 'LegislativeBuilding', 'LegislativeBuilding', '0000200026000020000300003', 3, 0, 'A legislative building&#x2014;for example, the state capitol.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731487', 'ID1607072155411398743731040', 'Embassy', 'Embassy', '0000200026000020000300004', 3, 0, 'An embassy.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731511', 'ID1607072155411398743731040', 'DefenceEstablishment', 'DefenceEstablishment', '0000200026000020000300005', 3, 0, 'A defence establishment, such as an army or navy base.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731042', 'ID1607072155411398743731114', 'Hospital', 'Hospital', '00002000260000200004', 3, 0, 'A hospital.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731051', 'ID1607072155411398743731114', 'Park', 'Park', '00002000260000200005', 3, 0, 'A park.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731105', 'ID1607072155411398743731114', 'MovieTheater', 'MovieTheater', '00002000260000200006', 3, 0, 'A movie theater.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731144', 'ID1607072155411398743731114', 'MusicVenue', 'MusicVenue', '00002000260000200007', 3, 0, 'A music venue.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731151', 'ID1607072155411398743731114', 'SubwayStation', 'SubwayStation', '00002000260000200008', 3, 0, 'A subway station.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731176', 'ID1607072155411398743731114', 'ParkingFacility', 'ParkingFacility', '00002000260000200009', 3, 0, 'A parking lot or other parking facility.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731178', 'ID1607072155411398743731114', 'FireStation', 'FireStation', '00002000260000200010', 3, 0, 'A fire station. With firemen.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731179', 'ID1607072155411398743731114', 'RVPark', 'RVPark', '00002000260000200011', 3, 0, 'A place offering space for \"Recreational Vehicles\", Caravans, mobile homes and the like.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731222', 'ID1607072155411398743731114', 'Airport', 'Airport', '00002000260000200012', 3, 0, 'An airport.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731235', 'ID1607072155411398743731114', 'Zoo', 'Zoo', '00002000260000200013', 3, 0, 'A zoo.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731253', 'ID1607072155411398743731114', 'EventVenue', 'EventVenue', '00002000260000200014', 3, 0, 'An event venue.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731296', 'ID1607072155411398743731114', 'Playground', 'Playground', '00002000260000200015', 3, 0, 'A playground.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731302', 'ID1607072155411398743731114', 'TaxiStand', 'TaxiStand', '00002000260000200016', 3, 0, 'A taxi stand.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731320', 'ID1607072155411398743731114', 'Bridge', 'Bridge', '00002000260000200017', 3, 0, 'A bridge.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731321', 'ID1607072155411398743731114', 'Museum', 'Museum', '00002000260000200018', 3, 0, 'A museum.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731365', 'ID1607072155411398743731114', 'BusStop', 'BusStop', '00002000260000200019', 3, 0, 'A bus stop.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731376', 'ID1607072155411398743731114', 'Aquarium', 'Aquarium', '00002000260000200020', 3, 0, 'Aquarium.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731409', 'ID1607072155411398743731114', 'Crematorium', 'Crematorium', '00002000260000200021', 3, 0, 'A crematorium.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731414', 'ID1607072155411398743731114', 'Campground', 'Campground', '00002000260000200022', 3, 0, 'A campground.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731446', 'ID1607072155411398743731114', 'TrainStation', 'TrainStation', '00002000260000200023', 3, 0, 'A train station.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731500', 'ID1607072155411398743731114', 'Cemetery', 'Cemetery', '00002000260000200024', 3, 0, 'A graveyard.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731509', 'ID1607072155411398743731114', 'PerformingArtsTheater', 'PerformingArtsTheater', '00002000260000200025', 3, 0, 'A theater or other performing art center.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731513', 'ID1607072155411398743731114', 'BusStation', 'BusStation', '00002000260000200026', 3, 0, 'A bus station.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731524', 'ID1607072155411398743731114', 'PlaceOfWorship', 'PlaceOfWorship', '00002000260000200027', 3, 0, 'Place of worship, such as a church, synagogue, or mosque.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731142', 'ID1607072155411398743731524', 'Synagogue', 'Synagogue', '0000200026000020002700001', 3, 0, 'A synagogue.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731304', 'ID1607072155411398743731524', 'HinduTemple', 'HinduTemple', '0000200026000020002700002', 3, 0, 'A Hindu temple.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731348', 'ID1607072155411398743731524', 'Church', 'Church', '0000200026000020002700003', 3, 0, 'A church.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731400', 'ID1607072155411398743731524', 'BuddhistTemple', 'BuddhistTemple', '0000200026000020002700004', 3, 0, 'A Buddhist temple.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731420', 'ID1607072155411398743731524', 'CatholicChurch', 'CatholicChurch', '0000200026000020002700005', 3, 0, 'A Catholic church.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731478', 'ID1607072155411398743731524', 'Mosque', 'Mosque', '0000200026000020002700006', 3, 0, 'A mosque.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731224', 'ID1607072155411398743731350', 'LandmarksOrHistoricalBuildings', 'LandmarksOrHistoricalBuildings', '000020002600003', 3, 0, 'An historical landmark or building.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731270', 'ID1607072155411398743731350', 'Landform', 'Landform', '000020002600004', 3, 0, 'A landform or physical feature.  Landform elements include mountains, plains, lakes, rivers, seascape and oceanic waterbody interface features such as bays, peninsulas, seas and so forth, including sub-aqueous terrain features such as submersed mountain ranges, volcanoes, and the great ocean basins.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731166', 'ID1607072155411398743731270', 'BodyOfWater', 'BodyOfWater', '00002000260000400001', 3, 0, 'A body of water, such as a sea, ocean, or lake.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731100', 'ID1607072155411398743731166', 'Waterfall', 'Waterfall', '0000200026000040000100001', 3, 0, 'A waterfall, like Niagara.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731269', 'ID1607072155411398743731166', 'Reservoir', 'Reservoir', '0000200026000040000100002', 3, 0, 'A reservoir of water, typically an artificially created lake, like the Lake Kariba reservoir.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731279', 'ID1607072155411398743731166', 'RiverBodyOfWater', 'RiverBodyOfWater', '0000200026000040000100003', 3, 0, 'A river (for example, the broad majestic Shannon).');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731319', 'ID1607072155411398743731166', 'OceanBodyOfWater', 'OceanBodyOfWater', '0000200026000040000100004', 3, 0, 'An ocean (for example, the Pacific).');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731329', 'ID1607072155411398743731166', 'LakeBodyOfWater', 'LakeBodyOfWater', '0000200026000040000100005', 3, 0, 'A lake (for example, Lake Pontrachain).');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731389', 'ID1607072155411398743731166', 'Pond', 'Pond', '0000200026000040000100006', 3, 0, 'A pond.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731419', 'ID1607072155411398743731166', 'Canal', 'Canal', '0000200026000040000100007', 3, 0, 'A canal, like the Panama Canal.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731578', 'ID1607072155411398743731166', 'SeaBodyOfWater', 'SeaBodyOfWater', '0000200026000040000100008', 3, 0, 'A sea (for example, the Caspian sea).');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731360', 'ID1607072155411398743731270', 'Volcano', 'Volcano', '00002000260000400002', 3, 0, 'A volcano, like Fuji san.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731604', 'ID1607072155411398743731270', 'Mountain', 'Mountain', '00002000260000400003', 3, 0, 'A mountain, like Mount Whitney or Mount Everest.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731632', 'ID1607072155411398743731270', 'Continent', 'Continent', '00002000260000400004', 3, 0, 'One of the continents (for example, Europe or Africa).');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731281', 'ID1607072155411398743731350', 'LocalBusiness', 'LocalBusiness', '000020002600005', 3, 0, 'A particular physical business or branch of an organization. Examples of LocalBusiness include a restaurant, a particular branch of a restaurant chain, a branch of a bank, a medical practice, a club, a bowling alley, etc.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731001', 'ID1607072155411398743731281', 'GovernmentOffice', 'GovernmentOffice', '00002000260000500001', 3, 0, 'A government office&#x2014;for example, an IRS or DMV office.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731377', 'ID1607072155411398743731001', 'PostOffice', 'PostOffice', '0000200026000050000100001', 3, 0, 'A post office.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731069', 'ID1607072155411398743731281', 'DryCleaningOrLaundry', 'DryCleaningOrLaundry', '00002000260000500002', 3, 0, 'A dry-cleaning business.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731158', 'ID1607072155411398743731281', 'ChildCare', 'ChildCare', '00002000260000500003', 3, 0, 'A Childcare center.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731162', 'ID1607072155411398743731281', 'Library', 'Library', '00002000260000500004', 3, 0, 'A library.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731181', 'ID1607072155411398743731281', 'RadioStation', 'RadioStation', '00002000260000500005', 3, 0, 'A radio station.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731187', 'ID1607072155411398743731281', 'FoodEstablishment', 'FoodEstablishment', '00002000260000500006', 3, 0, 'A food-related business.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731048', 'ID1607072155411398743731187', 'Brewery', 'Brewery', '0000200026000050000600001', 3, 0, 'Brewery.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731075', 'ID1607072155411398743731187', 'Restaurant', 'Restaurant', '0000200026000050000600002', 3, 0, 'A restaurant.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731120', 'ID1607072155411398743731187', 'BarOrPub', 'BarOrPub', '0000200026000050000600003', 3, 0, 'A bar or pub.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731127', 'ID1607072155411398743731187', 'Bakery', 'Bakery', '0000200026000050000600004', 3, 0, 'A bakery.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731227', 'ID1607072155411398743731187', 'CafeOrCoffeeShop', 'CafeOrCoffeeShop', '0000200026000050000600005', 3, 0, 'A cafe or coffee shop.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731447', 'ID1607072155411398743731187', 'IceCreamShop', 'IceCreamShop', '0000200026000050000600006', 3, 0, 'An ice cream shop.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731587', 'ID1607072155411398743731187', 'Distillery', 'Distillery', '0000200026000050000600007', 3, 0, 'A distillery.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731627', 'ID1607072155411398743731187', 'Winery', 'Winery', '0000200026000050000600008', 3, 0, 'A winery.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731635', 'ID1607072155411398743731187', 'FastFoodRestaurant', 'FastFoodRestaurant', '0000200026000050000600009', 3, 0, 'A fast-food restaurant.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731204', 'ID1607072155411398743731281', 'TravelAgency', 'TravelAgency', '00002000260000500007', 3, 0, 'A travel agency.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731288', 'ID1607072155411398743731281', 'Store', 'Store', '00002000260000500008', 3, 0, 'A retail good store.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731026', 'ID1607072155411398743731288', 'HobbyShop', 'HobbyShop', '0000200026000050000800001', 3, 0, 'A store that sells materials useful or necessary for various hobbies.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731041', 'ID1607072155411398743731288', 'GroceryStore', 'GroceryStore', '0000200026000050000800002', 3, 0, 'A grocery store.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731079', 'ID1607072155411398743731288', 'BikeStore', 'BikeStore', '0000200026000050000800003', 3, 0, 'A bike store.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731080', 'ID1607072155411398743731288', 'ToyStore', 'ToyStore', '0000200026000050000800004', 3, 0, 'A toy store.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731085', 'ID1607072155411398743731288', 'ConvenienceStore', 'ConvenienceStore', '0000200026000050000800005', 3, 0, 'A convenience store.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731102', 'ID1607072155411398743731288', 'HomeGoodsStore', 'HomeGoodsStore', '0000200026000050000800006', 3, 0, 'A home goods store.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731138', 'ID1607072155411398743731288', 'ComputerStore', 'ComputerStore', '0000200026000050000800007', 3, 0, 'A computer store.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731189', 'ID1607072155411398743731288', 'PawnShop', 'PawnShop', '0000200026000050000800008', 3, 0, 'A shop that will buy, or lend money against the security of, personal possessions.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731220', 'ID1607072155411398743731288', 'BookStore', 'BookStore', '0000200026000050000800009', 3, 0, 'A bookstore.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731257', 'ID1607072155411398743731288', 'OutletStore', 'OutletStore', '0000200026000050000800010', 3, 0, 'An outlet store.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731264', 'ID1607072155411398743731288', 'MensClothingStore', 'MensClothingStore', '0000200026000050000800011', 3, 0, 'A men\"s clothing store.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731285', 'ID1607072155411398743731288', 'LiquorStore', 'LiquorStore', '0000200026000050000800012', 3, 0, 'A shop that sells alcoholic drinks such as wine, beer, whisky and other spirits.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731324', 'ID1607072155411398743731288', 'MobilePhoneStore', 'MobilePhoneStore', '0000200026000050000800013', 3, 0, 'A store that sells mobile phones and related accessories.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731330', 'ID1607072155411398743731288', 'MusicStore', 'MusicStore', '0000200026000050000800014', 3, 0, 'A music store.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731359', 'ID1607072155411398743731288', 'TireShop', 'TireShop', '0000200026000050000800015', 3, 0, 'A tire shop.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731398', 'ID1607072155411398743731288', 'OfficeEquipmentStore', 'OfficeEquipmentStore', '0000200026000050000800016', 3, 0, 'An office equipment store.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731405', 'ID1607072155411398743731288', 'FurnitureStore', 'FurnitureStore', '0000200026000050000800017', 3, 0, 'A furniture store.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731416', 'ID1607072155411398743731288', 'MovieRentalStore', 'MovieRentalStore', '0000200026000050000800018', 3, 0, 'A movie rental store.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731431', 'ID1607072155411398743731288', 'PetStore', 'PetStore', '0000200026000050000800019', 3, 0, 'A pet store.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731438', 'ID1607072155411398743731288', 'HardwareStore', 'HardwareStore', '0000200026000050000800020', 3, 0, 'A hardware store.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731448', 'ID1607072155411398743731288', 'DepartmentStore', 'DepartmentStore', '0000200026000050000800021', 3, 0, 'A department store.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731490', 'ID1607072155411398743731288', 'SportingGoodsStore', 'SportingGoodsStore', '0000200026000050000800022', 3, 0, 'A sporting goods store.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731527', 'ID1607072155411398743731288', 'JewelryStore', 'JewelryStore', '0000200026000050000800023', 3, 0, 'A jewelry store.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731534', 'ID1607072155411398743731288', 'WholesaleStore', 'WholesaleStore', '0000200026000050000800024', 3, 0, 'A wholesale store.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731555', 'ID1607072155411398743731288', 'GardenStore', 'GardenStore', '0000200026000050000800025', 3, 0, 'A garden store.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731561', 'ID1607072155411398743731288', 'AutoPartsStore', 'AutoPartsStore', '0000200026000050000800026', 3, 0, 'An auto parts store.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731574', 'ID1607072155411398743731288', 'ElectronicsStore', 'ElectronicsStore', '0000200026000050000800027', 3, 0, 'An electronics store.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731582', 'ID1607072155411398743731288', 'ClothingStore', 'ClothingStore', '0000200026000050000800028', 3, 0, 'A clothing store.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731611', 'ID1607072155411398743731288', 'ShoeStore', 'ShoeStore', '0000200026000050000800029', 3, 0, 'A shoe store.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731637', 'ID1607072155411398743731288', 'Florist', 'Florist', '0000200026000050000800030', 3, 0, 'A florist.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731297', 'ID1607072155411398743731281', 'FinancialService', 'FinancialService', '00002000260000500009', 3, 0, 'Financial services business.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731384', 'ID1607072155411398743731297', 'InsuranceAgency', 'InsuranceAgency', '0000200026000050000900001', 3, 0, 'An Insurance agency.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731526', 'ID1607072155411398743731297', 'BankOrCreditUnion', 'BankOrCreditUnion', '0000200026000050000900002', 3, 0, 'Bank or credit union.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731548', 'ID1607072155411398743731297', 'AutomatedTeller', 'AutomatedTeller', '0000200026000050000900003', 3, 0, 'ATM/cash machine.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731567', 'ID1607072155411398743731297', 'AccountingService', 'AccountingService', '0000200026000050000900004', 3, 0, 'Accountancy business.         <br><br>         As a <a href=\"/LocalBusiness\">LocalBusiness</a> it can be         described as a <a href=\"/provider\">provider</a> of one or more         <a href=\"/Service\">Service(s)</a>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731299', 'ID1607072155411398743731281', 'EmploymentAgency', 'EmploymentAgency', '00002000260000500010', 3, 0, 'An employment agency.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731315', 'ID1607072155411398743731281', 'ShoppingCenter', 'ShoppingCenter', '00002000260000500011', 3, 0, 'A shopping center or mall.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731342', 'ID1607072155411398743731281', 'EmergencyService', 'EmergencyService', '00002000260000500012', 3, 0, 'An emergency service, such as a fire station or ER.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731410', 'ID1607072155411398743731281', 'LegalService', 'LegalService', '00002000260000500013', 3, 0, 'A LegalService is a business that provides legally-oriented services, advice and representation, e.g. law firms.         <br><br>         As a <a href=\"/LocalBusiness\">LocalBusiness</a> it can be         described as a <a href=\"/provider\">provider</a> of one or more         <a href=\"/Service\">Service(s)</a>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731084', 'ID1607072155411398743731410', 'Attorney', 'Attorney', '0000200026000050001300001', 3, 0, 'Professional service: Attorney. <br><br>         This type is deprecated - <a href=\"/LegalService\">LegalService</a> is more inclusive and less ambiguous.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731422', 'ID1607072155411398743731410', 'Notary', 'Notary', '0000200026000050001300002', 3, 0, 'A notary.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731428', 'ID1607072155411398743731281', 'RecyclingCenter', 'RecyclingCenter', '00002000260000500014', 3, 0, 'A recycling center.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731441', 'ID1607072155411398743731281', 'ProfessionalService', 'ProfessionalService', '00002000260000500015', 3, 0, 'Original definition: \"provider of professional services.\"         <br><br>         The general <a href=\"/ProfessionalService\">ProfessionalService</a> type         for local businesses was deprecated due to confusion with <a href=\"/Service\">Service</a>.         For reference, the types that it included were: <a href=\"/Dentist\">Dentist</a>,         <a href=\"/AccountingService\">AccountingService</a>,         <a href=\"/Attorney\">Attorney</a>,         <a href=\"/Notary\">Notary</a>, as well as types for several kinds of         <a href=\"/HomeAndConstructionBusiness\">HomeAndConstructionBusiness</a>:         <a href=\"/Electrician\">Electrician</a>,         <a href=\"/GeneralContractor\">GeneralContractor</a>,         <a href=\"/HousePainter\">HousePainter</a>,         <a href=\"/Locksmith\">Locksmith</a>,         <a href=\"/Plumber\">Plumber</a>,         <a href=\"/Plumber\">RoofingContractor</a>.         <a href=\"/LegalService\">LegalService</a> was introduced as a more         inclusive supertype of <a href=\"/Attorney\">Attorney</a>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731445', 'ID1607072155411398743731281', 'TelevisionStation', 'TelevisionStation', '00002000260000500016', 3, 0, 'A television station.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731454', 'ID1607072155411398743731281', 'SportsActivityLocation', 'SportsActivityLocation', '00002000260000500017', 3, 0, 'A sports location, such as a playing field.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731097', 'ID1607072155411398743731454', 'GolfCourse', 'GolfCourse', '0000200026000050001700001', 3, 0, 'A golf course.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731306', 'ID1607072155411398743731454', 'StadiumOrArena', 'StadiumOrArena', '0000200026000050001700002', 3, 0, 'A stadium.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731309', 'ID1607072155411398743731454', 'TennisComplex', 'TennisComplex', '0000200026000050001700003', 3, 0, 'A tennis complex.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731430', 'ID1607072155411398743731454', 'SkiResort', 'SkiResort', '0000200026000050001700004', 3, 0, 'A ski resort.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731432', 'ID1607072155411398743731454', 'ExerciseGym', 'ExerciseGym', '0000200026000050001700005', 3, 0, 'A gym.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731566', 'ID1607072155411398743731454', 'SportsClub', 'SportsClub', '0000200026000050001700006', 3, 0, 'A sports club.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731571', 'ID1607072155411398743731454', 'PublicSwimmingPool', 'PublicSwimmingPool', '0000200026000050001700007', 3, 0, 'A public swimming pool.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731616', 'ID1607072155411398743731454', 'BowlingAlley', 'BowlingAlley', '0000200026000050001700008', 3, 0, 'A bowling alley.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731492', 'ID1607072155411398743731281', 'RealEstateAgent', 'RealEstateAgent', '00002000260000500018', 3, 0, 'A real-estate agent.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731518', 'ID1607072155411398743731281', 'MedicalBusiness', 'MedicalBusiness', '00002000260000500019', 3, 0, 'A particular physical or virtual business of an organization for medical purposes. Examples of MedicalBusiness include differents business run by health professionals.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731273', 'ID1607072155411398743731518', 'Optician', 'Optician', '0000200026000050001900001', 3, 0, 'A store that sells reading glasses and similar devices for improving vision.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731564', 'ID1607072155411398743731518', 'Dentist', 'Dentist', '0000200026000050001900002', 3, 0, 'A dentist.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731528', 'ID1607072155411398743731281', 'TouristInformationCenter', 'TouristInformationCenter', '00002000260000500020', 3, 0, 'A tourist information center.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731535', 'ID1607072155411398743731281', 'AutomotiveBusiness', 'AutomotiveBusiness', '00002000260000500021', 3, 0, 'Car repair, sales, or parts.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731122', 'ID1607072155411398743731535', 'AutoRepair', 'AutoRepair', '0000200026000050002100001', 3, 0, 'Car repair business.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731197', 'ID1607072155411398743731535', 'GasStation', 'GasStation', '0000200026000050002100002', 3, 0, 'A gas station.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731225', 'ID1607072155411398743731535', 'AutoWash', 'AutoWash', '0000200026000050002100003', 3, 0, 'A car wash business.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731301', 'ID1607072155411398743731535', 'AutoDealer', 'AutoDealer', '0000200026000050002100004', 3, 0, 'An car dealership.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731334', 'ID1607072155411398743731535', 'AutoRental', 'AutoRental', '0000200026000050002100005', 3, 0, 'A car rental business.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731423', 'ID1607072155411398743731535', 'MotorcycleDealer', 'MotorcycleDealer', '0000200026000050002100006', 3, 0, 'A motorcycle dealer.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731436', 'ID1607072155411398743731535', 'MotorcycleRepair', 'MotorcycleRepair', '0000200026000050002100007', 3, 0, 'A motorcycle repair shop.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731572', 'ID1607072155411398743731535', 'AutoBodyShop', 'AutoBodyShop', '0000200026000050002100008', 3, 0, 'Auto body shop.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731538', 'ID1607072155411398743731281', 'HealthAndBeautyBusiness', 'HealthAndBeautyBusiness', '00002000260000500022', 3, 0, 'Health and beauty.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731133', 'ID1607072155411398743731538', 'HealthClub', 'HealthClub', '0000200026000050002200001', 3, 0, 'A health club.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731143', 'ID1607072155411398743731538', 'BeautySalon', 'BeautySalon', '0000200026000050002200002', 3, 0, 'Beauty salon.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731260', 'ID1607072155411398743731538', 'TattooParlor', 'TattooParlor', '0000200026000050002200003', 3, 0, 'A tattoo parlor.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731344', 'ID1607072155411398743731538', 'HairSalon', 'HairSalon', '0000200026000050002200004', 3, 0, 'A hair salon.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731396', 'ID1607072155411398743731538', 'DaySpa', 'DaySpa', '0000200026000050002200005', 3, 0, 'A day spa.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731620', 'ID1607072155411398743731538', 'NailSalon', 'NailSalon', '0000200026000050002200006', 3, 0, 'A nail salon.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731542', 'ID1607072155411398743731281', 'EntertainmentBusiness', 'EntertainmentBusiness', '00002000260000500023', 3, 0, 'A business providing entertainment.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731011', 'ID1607072155411398743731542', 'ArtGallery', 'ArtGallery', '0000200026000050002300001', 3, 0, 'An art gallery.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731280', 'ID1607072155411398743731542', 'ComedyClub', 'ComedyClub', '0000200026000050002300002', 3, 0, 'A comedy club.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731322', 'ID1607072155411398743731542', 'AdultEntertainment', 'AdultEntertainment', '0000200026000050002300003', 3, 0, 'An adult entertainment establishment.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731374', 'ID1607072155411398743731542', 'AmusementPark', 'AmusementPark', '0000200026000050002300004', 3, 0, 'An amusement park.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731383', 'ID1607072155411398743731542', 'NightClub', 'NightClub', '0000200026000050002300005', 3, 0, 'A nightclub or discotheque.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731636', 'ID1607072155411398743731542', 'Casino', 'Casino', '0000200026000050002300006', 3, 0, 'A casino.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731560', 'ID1607072155411398743731281', 'InternetCafe', 'InternetCafe', '00002000260000500024', 3, 0, 'An internet cafe.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731573', 'ID1607072155411398743731281', 'HomeAndConstructionBusiness', 'HomeAndConstructionBusiness', '00002000260000500025', 3, 0, 'A construction business.         <br><br>         A HomeAndConstructionBusiness is a LocalBusiness that provides services around homes and buildings.           <br><br>           As a <a href=\"/LocalBusiness\">LocalBusiness</a> it can be           described as a <a href=\"/provider\">provider</a> of one or more           <a href=\"/Service\">Service(s)</a>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731129', 'ID1607072155411398743731573', 'HousePainter', 'HousePainter', '0000200026000050002500001', 3, 0, 'A house painting service.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731154', 'ID1607072155411398743731573', 'Plumber', 'Plumber', '0000200026000050002500002', 3, 0, 'A plumbing service.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731155', 'ID1607072155411398743731573', 'RoofingContractor', 'RoofingContractor', '0000200026000050002500003', 3, 0, 'A roofing contractor.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731294', 'ID1607072155411398743731573', 'MovingCompany', 'MovingCompany', '0000200026000050002500004', 3, 0, 'A moving company.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731313', 'ID1607072155411398743731573', 'Locksmith', 'Locksmith', '0000200026000050002500005', 3, 0, 'A locksmith.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731351', 'ID1607072155411398743731573', 'Electrician', 'Electrician', '0000200026000050002500006', 3, 0, 'An electrician.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731363', 'ID1607072155411398743731573', 'HVACBusiness', 'HVACBusiness', '0000200026000050002500007', 3, 0, 'A business that provide Heating, Ventilation and Air Conditioning services.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731375', 'ID1607072155411398743731573', 'GeneralContractor', 'GeneralContractor', '0000200026000050002500008', 3, 0, 'A general contractor.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731596', 'ID1607072155411398743731281', 'AnimalShelter', 'AnimalShelter', '00002000260000500026', 3, 0, 'Animal shelter.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731622', 'ID1607072155411398743731281', 'SelfStorage', 'SelfStorage', '00002000260000500027', 3, 0, 'A self-storage facility.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731638', 'ID1607072155411398743731281', 'LodgingBusiness', 'LodgingBusiness', '00002000260000500028', 3, 0, 'A lodging business, such as a motel, hotel, or inn.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731024', 'ID1607072155411398743731638', 'Hostel', 'Hostel', '0000200026000050002800001', 3, 0, 'A hostel - cheap accommodation, often in shared dormitories.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731101', 'ID1607072155411398743731638', 'BedAndBreakfast', 'BedAndBreakfast', '0000200026000050002800002', 3, 0, 'Bed and breakfast.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731172', 'ID1607072155411398743731638', 'Motel', 'Motel', '0000200026000050002800003', 3, 0, 'A motel.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731486', 'ID1607072155411398743731638', 'Hotel', 'Hotel', '0000200026000050002800004', 3, 0, 'A hotel.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731392', 'ID1607072155411398743731350', 'TouristAttraction', 'TouristAttraction', '000020002600006', 3, 0, 'A tourist attraction.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731576', 'ID1607072155411398743731350', 'Residence', 'Residence', '000020002600007', 3, 0, 'The place where a person lives.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731020', 'ID1607072155411398743731576', 'GatedResidenceCommunity', 'GatedResidenceCommunity', '00002000260000700001', 3, 0, 'Residence type: Gated community.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731186', 'ID1607072155411398743731576', 'ApartmentComplex', 'ApartmentComplex', '00002000260000700002', 3, 0, 'Residence type: Apartment complex.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731508', 'ID1607072155411398743731576', 'SingleFamilyResidence', 'SingleFamilyResidence', '00002000260000700003', 3, 0, 'Residence type: Single-family home.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731354', 'ID1606041948737864364386236', 'Product', 'Product', '0000200027', 3, 0, 'Any offered product or service. For example: a pair of shoes; a concert ticket; the rental of a car; a haircut; or an episode of a TV show streamed online.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731132', 'ID1607072155411398743731354', 'IndividualProduct', 'IndividualProduct', '000020002700001', 3, 0, 'A single, identifiable product instance (e.g. a laptop with a particular serial number).');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731234', 'ID1607072155411398743731354', 'SomeProducts', 'SomeProducts', '000020002700002', 3, 0, 'A placeholder for multiple similar products of the same kind.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731295', 'ID1607072155411398743731354', 'ProductModel', 'ProductModel', '000020002700003', 3, 0, 'A datasheet or vendor specification of a product (in the sense of a prototypical description).');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731449', 'ID1607072155411398743731354', 'Vehicle', 'Vehicle', '000020002700004', 3, 0, 'A vehicle is a device that is designed or used to transport people or cargo over land, water, air, or through space.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731169', 'ID1607072155411398743731449', 'Motorcycle', 'Motorcycle', '00002000270000400001', 3, 0, 'A motorcycle or motorbike is a single-track, two-wheeled motor vehicle.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731180', 'ID1607072155411398743731449', 'Car', 'Car', '00002000270000400002', 3, 0, 'A car is a wheeled, self-powered motor vehicle used for transportation.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731183', 'ID1607072155411398743731449', 'BusOrCoach', 'BusOrCoach', '00002000270000400003', 3, 0, 'A bus (also omnibus or autobus) is a road vehicle designed to carry passengers. Coaches are luxury busses, usually in service for long distance travel.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731361', 'ID1607072155411398743731449', 'MotorizedBicycle', 'MotorizedBicycle', '00002000270000400004', 3, 0, 'A motorized bicycle is a bicycle with an attached motor used to power the vehicle, or to assist with pedaling.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731362', 'ID1606041948737864364386236', 'CreativeWork', 'CreativeWork', '0000200028', 3, 0, 'The most generic kind of creative work, including books, movies, photographs, software programs, etc.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731002', 'ID1607072155411398743731362', 'Book', 'Book', '000020002800001', 3, 0, 'A book.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731014', 'ID1607072155411398743731362', 'Dataset', 'Dataset', '000020002800002', 3, 0, 'A body of structured information describing some topic(s) of interest.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731110', 'ID1607072155411398743731014', 'DataFeed', 'DataFeed', '00002000280000200001', 3, 0, 'A single feed providing structured information about one or more entities or topics.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731029', 'ID1607072155411398743731362', 'Movie', 'Movie', '000020002800003', 3, 0, 'A movie.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731057', 'ID1607072155411398743731362', 'MediaObject', 'MediaObject', '000020002800004', 3, 0, 'An image, video, or audio object embedded in a web page. Note that a creative work may have many media objects associated with it on the same web page. For example, a page about a single song (MusicRecording) may have a music video (VideoObject), and a high and low bandwidth audio stream (2 AudioObject\"s).');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731015', 'ID1607072155411398743731057', 'AudioObject', 'AudioObject', '00002000280000400001', 3, 0, 'An audio file.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731175', 'ID1607072155411398743731015', 'Audiobook', 'Audiobook', '0000200028000040000100001', 3, 0, 'An audiobook.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731082', 'ID1607072155411398743731057', 'ImageObject', 'ImageObject', '00002000280000400002', 3, 0, 'An image file.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731496', 'ID1607072155411398743731082', 'Barcode', 'Barcode', '0000200028000040000200001', 3, 0, 'An image of a visual machine-readable code such as a barcode or QR code.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731094', 'ID1607072155411398743731057', 'DataDownload', 'DataDownload', '00002000280000400003', 3, 0, 'A dataset in downloadable form.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731228', 'ID1607072155411398743731057', 'VideoObject', 'VideoObject', '00002000280000400004', 3, 0, 'A video file.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731415', 'ID1607072155411398743731057', 'MusicVideoObject', 'MusicVideoObject', '00002000280000400005', 3, 0, 'A music video file.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731091', 'ID1607072155411398743731362', 'Collection', 'Collection', '000020002800005', 3, 0, 'A created collection of Creative Works or other artefacts.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731103', 'ID1607072155411398743731362', 'Season', 'Season', '000020002800006', 3, 0, 'A media season e.g. tv, radio, video game etc.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731113', 'ID1607072155411398743731362', 'ComicStory', 'ComicStory', '000020002800007', 3, 0, 'The term \"story\" is any indivisible, re-printable     unit of a comic, including the interior stories, covers, and backmatter. Most     comics have at least two stories: a cover (ComicCoverArt) and an interior story.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731116', 'ID1607072155411398743731362', 'Game', 'Game', '000020002800008', 3, 0, 'The Game type represents things which are games. These are typically rule-governed recreational activities, e.g. role-playing games in which players assume the role of characters in a fictional setting.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731318', 'ID1607072155411398743731116', 'VideoGame', 'VideoGame', '00002000280000800001', 3, 0, 'A video game is an electronic game that involves human interaction with a user interface to generate visual feedback on a video device.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731153', 'ID1607072155411398743731362', 'Conversation', 'Conversation', '000020002800009', 3, 0, 'One or more messages between organizations or people on a particular topic. Individual messages can be linked to the conversation with isPartOf or hasPart properties.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731156', 'ID1607072155411398743731362', 'WebSite', 'WebSite', '000020002800010', 3, 0, 'A WebSite is a set of related web pages and other items typically served from a single web domain and accessible via URLs.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731173', 'ID1607072155411398743731362', 'WebPage', 'WebPage', '000020002800011', 3, 0, 'A web page. Every web page is implicitly assumed to be declared to be of type WebPage, so the various properties about that webpage, such as <code>breadcrumb</code> may be used. We recommend explicit declaration if these properties are specified, but if they are found outside of an itemscope, they will be assumed to be about the page.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731012', 'ID1607072155411398743731173', 'QAPage', 'QAPage', '00002000280001100001', 3, 0, 'A QAPage is a WebPage focussed on a specific Question and its Answer(s), e.g. in a question answering site or documenting Frequently Asked Questions (FAQs).');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731055', 'ID1607072155411398743731173', 'SearchResultsPage', 'SearchResultsPage', '00002000280001100002', 3, 0, 'Web page type: Search results page.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731076', 'ID1607072155411398743731173', 'CollectionPage', 'CollectionPage', '00002000280001100003', 3, 0, 'Web page type: Collection page.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731337', 'ID1607072155411398743731076', 'ImageGallery', 'ImageGallery', '0000200028000110000300001', 3, 0, 'Web page type: Image gallery page.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731493', 'ID1607072155411398743731076', 'VideoGallery', 'VideoGallery', '0000200028000110000300002', 3, 0, 'Web page type: Video gallery page.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731184', 'ID1607072155411398743731173', 'ContactPage', 'ContactPage', '00002000280001100004', 3, 0, 'Web page type: Contact page.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731465', 'ID1607072155411398743731173', 'MedicalWebPage', 'MedicalWebPage', '00002000280001100005', 3, 0, 'A web page that provides medical information.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731466', 'ID1607072155411398743731173', 'ProfilePage', 'ProfilePage', '00002000280001100006', 3, 0, 'Web page type: Profile page.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731585', 'ID1607072155411398743731173', 'CheckoutPage', 'CheckoutPage', '00002000280001100007', 3, 0, 'Web page type: Checkout page.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731588', 'ID1607072155411398743731173', 'AboutPage', 'AboutPage', '00002000280001100008', 3, 0, 'Web page type: About page.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731623', 'ID1607072155411398743731173', 'ItemPage', 'ItemPage', '00002000280001100009', 3, 0, 'A page devoted to a single item, such as a particular product or hotel.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731177', 'ID1607072155411398743731362', 'CreativeWorkSeason', 'CreativeWorkSeason', '000020002800012', 3, 0, 'A media season e.g. tv, radio, video game etc.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731244', 'ID1607072155411398743731177', 'RadioSeason', 'RadioSeason', '00002000280001200001', 3, 0, 'Season dedicated to radio broadcast and associated online delivery.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731529', 'ID1607072155411398743731177', 'TVSeason', 'TVSeason', '00002000280001200002', 3, 0, 'Season dedicated to TV broadcast and associated online delivery.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731191', 'ID1607072155411398743731362', 'Recipe', 'Recipe', '000020002800013', 3, 0, 'A recipe. For dietary restrictions covered by the recipe,     a few common restrictions are enumerated via <a href=\"/suitableForDiet\">suitableForDiet</a>.     The <a href=\"/keywords\">keywords</a> property can also be used to add more detail.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731203', 'ID1607072155411398743731362', 'VisualArtwork', 'VisualArtwork', '000020002800014', 3, 0, 'A work of art that is primarily visual in character.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731107', 'ID1607072155411398743731203', 'CoverArt', 'CoverArt', '00002000280001400001', 3, 0, 'The artwork on the outer surface of a CreativeWork.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731305', 'ID1607072155411398743731107', 'ComicCoverArt', 'ComicCoverArt', '0000200028000140000100001', 3, 0, 'The artwork on the cover of a comic.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731207', 'ID1607072155411398743731362', 'Thesis', 'Thesis', '000020002800015', 3, 0, 'A thesis or dissertation document submitted in support of candidature for an academic degree or professional qualification.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731215', 'ID1607072155411398743731362', 'SoftwareSourceCode', 'SoftwareSourceCode', '000020002800016', 3, 0, 'Computer programming source code. Example: Full (compile ready) solutions, code snippet samples, scripts, templates.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731236', 'ID1607072155411398743731362', 'Code', 'Code', '000020002800017', 3, 0, 'Computer programming source code. Example: Full (compile ready) solutions, code snippet samples, scripts, templates.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731237', 'ID1607072155411398743731362', 'DigitalDocument', 'DigitalDocument', '000020002800018', 3, 0, 'An electronic file or document.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731481', 'ID1607072155411398743731237', 'PresentationDigitalDocument', 'PresentationDigitalDocument', '00002000280001800001', 3, 0, 'A file containing slides or used for a presentation.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731517', 'ID1607072155411398743731237', 'SpreadsheetDigitalDocument', 'SpreadsheetDigitalDocument', '00002000280001800002', 3, 0, 'A spreadsheet file.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731600', 'ID1607072155411398743731237', 'NoteDigitalDocument', 'NoteDigitalDocument', '00002000280001800003', 3, 0, 'A file containing a note, primarily for the author.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731608', 'ID1607072155411398743731237', 'TextDigitalDocument', 'TextDigitalDocument', '00002000280001800004', 3, 0, 'A file composed primarily of text.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731256', 'ID1607072155411398743731362', 'Course', 'Course', '000020002800019', 3, 0, 'A description of an educational course which may be offered as distinct instances at different times and places, or through different media or modes of study. An educational course is a sequence of one or more educational events and/or creative works which aims to build knowledge, competence or ability of learners.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731262', 'ID1607072155411398743731362', 'Article', 'Article', '000020002800020', 3, 0, '<p>An article, such as a news article or piece of investigative report. Newspapers and magazines have articles of many different types and this is intended to cover them all.</p> <pre><code>  &lt;br/&gt;&lt;br/&gt;See also &lt;a href=\"http://blog.schema.org/2014/09/schemaorg-support-for-bibliographic_2.html\"&gt;blog post&lt;/a&gt;. </code></pre>');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731045', 'ID1607072155411398743731262', 'NewsArticle', 'NewsArticle', '00002000280002000001', 3, 0, 'A news article.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731077', 'ID1607072155411398743731262', 'ScholarlyArticle', 'ScholarlyArticle', '00002000280002000002', 3, 0, 'A scholarly article.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731202', 'ID1607072155411398743731077', 'MedicalScholarlyArticle', 'MedicalScholarlyArticle', '0000200028000200000200001', 3, 0, 'A scholarly article in the medical domain.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731216', 'ID1607072155411398743731262', 'SocialMediaPosting', 'SocialMediaPosting', '00002000280002000003', 3, 0, 'A post to a social media platform, including blog posts, tweets, Facebook posts, etc.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731046', 'ID1607072155411398743731216', 'DiscussionForumPosting', 'DiscussionForumPosting', '0000200028000200000300001', 3, 0, 'A posting to a discussion forum.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731395', 'ID1607072155411398743731262', 'BlogPosting', 'BlogPosting', '00002000280002000004', 3, 0, 'A blog post.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731323', 'ID1607072155411398743731395', 'LiveBlog', 'LiveBlog', '0000200028000200000400001', 3, 0, 'A blog post intended to provide a rolling textual coverage of an ongoing event through continuous updates.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731553', 'ID1607072155411398743731262', 'TechArticle', 'TechArticle', '00002000280002000005', 3, 0, 'A technical article - Example: How-to (task) topics, step-by-step, procedural troubleshooting, specifications, etc.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731505', 'ID1607072155411398743731553', 'APIReference', 'APIReference', '0000200028000200000500001', 3, 0, 'Reference documentation for application programming interfaces (APIs).');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731641', 'ID1607072155411398743731262', 'Report', 'Report', '00002000280002000006', 3, 0, 'A Report generated by governmental or non-governmental organization.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731286', 'ID1607072155411398743731362', 'PublicationVolume', 'PublicationVolume', '000020002800021', 3, 0, '<p>A part of a successively published publication such as a periodical or multi-volume work, often numbered. It may represent a time span, such as a year.</p> <pre><code>  &lt;br/&gt;&lt;br/&gt;See also &lt;a href=\"http://blog.schema.org/2014/09/schemaorg-support-for-bibliographic_2.html\"&gt;blog post&lt;/a&gt;. </code></pre>');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731300', 'ID1607072155411398743731362', 'Painting', 'Painting', '000020002800022', 3, 0, 'A painting.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731307', 'ID1607072155411398743731362', 'Comment', 'Comment', '000020002800023', 3, 0, 'A comment on an item - for example, a comment on a blog post. The comment\"s content is expressed via the \"text\" property, and its topic via \"about\", properties shared with all CreativeWorks.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731194', 'ID1607072155411398743731307', 'Answer', 'Answer', '00002000280002300001', 3, 0, 'An answer offered to a question; perhaps correct, perhaps opinionated or wrong.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731316', 'ID1607072155411398743731362', 'Sculpture', 'Sculpture', '000020002800024', 3, 0, 'A piece of sculpture.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731333', 'ID1607072155411398743731362', 'Chapter', 'Chapter', '000020002800025', 3, 0, 'One of the sections into which a book is divided. A chapter usually has a section number or a name.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731335', 'ID1607072155411398743731362', 'Atlas', 'Atlas', '000020002800026', 3, 0, 'A collection or bound volume of maps, charts, plates or tables, physical or in media form illustrating any subject.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731345', 'ID1607072155411398743731362', 'Review', 'Review', '000020002800027', 3, 0, 'A review of an item - for example, of a restaurant, movie, or store.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731355', 'ID1607072155411398743731345', 'ClaimReview', 'ClaimReview', '00002000280002700001', 3, 0, 'A fact-checking review of claims made (or reported) in some creative work (referenced via itemReviewed).');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731358', 'ID1607072155411398743731362', 'PublicationIssue', 'PublicationIssue', '000020002800028', 3, 0, '<p>A part of a successively published publication such as a periodical or publication volume, often numbered, usually containing a grouping of works such as articles.</p> <pre><code>  &lt;br/&gt;&lt;br/&gt;See also &lt;a href=\"http://blog.schema.org/2014/09/schemaorg-support-for-bibliographic_2.html\"&gt;blog post&lt;/a&gt;. </code></pre>');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731501', 'ID1607072155411398743731358', 'ComicIssue', 'ComicIssue', '00002000280002800001', 3, 0, 'Individual comic issues are serially published as     part of a larger series. For the sake of consistency, even one-shot issues     belong to a series comprised of a single issue. All comic issues can be     uniquely identified by: the combination of the name and volume number of the     series to which the issue belongs; the issue number; and the variant     description of the issue (if any).');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731408', 'ID1607072155411398743731362', 'MusicRecording', 'MusicRecording', '000020002800029', 3, 0, 'A music recording (track), usually a single song.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731417', 'ID1607072155411398743731362', 'MusicComposition', 'MusicComposition', '000020002800030', 3, 0, 'A musical composition.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731450', 'ID1607072155411398743731362', 'Question', 'Question', '000020002800031', 3, 0, 'A specific question - e.g. from a user seeking answers online, or collected in a Frequently Asked Questions (FAQ) document.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731453', 'ID1607072155411398743731362', 'CreativeWorkSeries', 'CreativeWorkSeries', '000020002800032', 3, 0, '<p>A CreativeWorkSeries in schema.org is a group of related items, typically but not necessarily of the same kind.           CreativeWorkSeries are usually organized into some order, often chronological. Unlike <a href=\"/ItemList\">ItemList</a> which           is a general purpose data structure for lists of things, the emphasis with           CreativeWorkSeries is on published materials (written e.g. books and periodicals,           or media such as tv, radio and games).</p> <pre><code>      &lt;br/&gt;&lt;br/&gt;       Specific subtypes are available for describing &lt;a href=\"/TVSeries\"&gt;TVSeries&lt;/a&gt;, &lt;a href=\"/RadioSeries\"&gt;RadioSeries&lt;/a&gt;,       &lt;a href=\"/MovieSeries\"&gt;MovieSeries&lt;/a&gt;,       &lt;a href=\"/BookSeries\"&gt;BookSeries&lt;/a&gt;,       &lt;a href=\"/Periodical\"&gt;Periodical&lt;/a&gt;       and &lt;a href=\"/VideoGameSeries\"&gt;VideoGameSeries&lt;/a&gt;. In each case,       the &lt;a href=\"/hasPart\"&gt;hasPart&lt;/a&gt; / &lt;a href=\"/isPartOf\"&gt;isPartOf&lt;/a&gt; properties       can be used to relate the CreativeWorkSeries to its parts. The general CreativeWorkSeries type serves largely       just to organize these more specific and practical subtypes.       &lt;br/&gt;&lt;br/&gt;       It is common for properties applicable to an item from the series to be usefully applied to the containing group.       Schema.org attempts to anticipate some of these cases, but publishers should be free to apply       properties of the series parts to the series as a whole wherever they seem appropriate. </code></pre>');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731053', 'ID1607072155411398743731453', 'TVSeries', 'TVSeries', '00002000280003200001', 3, 0, 'CreativeWorkSeries dedicated to TV broadcast and associated online delivery.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731063', 'ID1607072155411398743731453', 'BookSeries', 'BookSeries', '00002000280003200002', 3, 0, 'A series of books. Included books can be indicated with the hasPart property.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731065', 'ID1607072155411398743731453', 'RadioSeries', 'RadioSeries', '00002000280003200003', 3, 0, 'CreativeWorkSeries dedicated to radio broadcast and associated online delivery.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731095', 'ID1607072155411398743731453', 'Periodical', 'Periodical', '00002000280003200004', 3, 0, 'A publication in any medium issued in successive parts bearing numerical or chronological designations and intended, such as a magazine, scholarly journal, or newspaper to continue indefinitely.</p> <p>See also <a href=\"http://blog.schema.org/2014/09/schemaorg-support-for-bibliographic_2.html\">blog post</a>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731010', 'ID1607072155411398743731095', 'Newspaper', 'Newspaper', '0000200028000320000400001', 3, 0, 'A publication containing information about varied topics that are pertinent to general information, a geographic area, or a specific subject matter (i.e. business, culture, education). Often published daily.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731397', 'ID1607072155411398743731095', 'ComicSeries', 'ComicSeries', '0000200028000320000400002', 3, 0, 'A sequential publication of comic stories under a     unifying title, for example \"The Amazing Spider-Man\" or \"Groo the     Wanderer\".');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731126', 'ID1607072155411398743731453', 'MovieSeries', 'MovieSeries', '00002000280003200005', 3, 0, 'A series of movies. Included movies can be indicated with the hasPart property.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731145', 'ID1607072155411398743731453', 'VideoGameSeries', 'VideoGameSeries', '00002000280003200006', 3, 0, 'A <a href=\"/VideoGame\">video game</a> series.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731473', 'ID1607072155411398743731362', 'Quotation', 'Quotation', '000020002800033', 3, 0, 'A quotation from some work, attributable to real world author and - if associated with a fictional character - to any fictional Person. Use isBasedOnUrl to link to source/origin.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731476', 'ID1607072155411398743731362', 'MusicPlaylist', 'MusicPlaylist', '000020002800034', 3, 0, 'A collection of music tracks in playlist form.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731067', 'ID1607072155411398743731476', 'MusicAlbum', 'MusicAlbum', '00002000280003400001', 3, 0, 'A collection of music tracks.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731341', 'ID1607072155411398743731476', 'MusicRelease', 'MusicRelease', '00002000280003400002', 3, 0, 'A MusicRelease is a specific release of a music album.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731484', 'ID1607072155411398743731362', 'Message', 'Message', '000020002800035', 3, 0, 'A single message from a sender to one or more organizations or people.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731470', 'ID1607072155411398743731484', 'EmailMessage', 'EmailMessage', '00002000280003500001', 3, 0, 'An email message.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731521', 'ID1607072155411398743731362', 'SoftwareApplication', 'SoftwareApplication', '000020002800036', 3, 0, 'A software application.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731058', 'ID1607072155411398743731521', 'MobileApplication', 'MobileApplication', '00002000280003600001', 3, 0, 'A software application designed specifically to work well on a mobile device such as a telephone.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731238', 'ID1607072155411398743731521', 'WebApplication', 'WebApplication', '00002000280003600002', 3, 0, 'Web applications.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731531', 'ID1607072155411398743731362', 'Episode', 'Episode', '000020002800037', 3, 0, 'A media episode (e.g. TV, radio, video game) which can be part of a series or season.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731108', 'ID1607072155411398743731531', 'RadioEpisode', 'RadioEpisode', '00002000280003700001', 3, 0, 'A radio episode which can be part of a series or season.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731314', 'ID1607072155411398743731531', 'TVEpisode', 'TVEpisode', '00002000280003700002', 3, 0, 'A TV episode which can be part of a series or season.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731550', 'ID1607072155411398743731362', 'Blog', 'Blog', '000020002800038', 3, 0, 'A blog.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731562', 'ID1607072155411398743731362', 'Photograph', 'Photograph', '000020002800039', 3, 0, 'A photograph.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731565', 'ID1607072155411398743731362', 'DataCatalog', 'DataCatalog', '000020002800040', 3, 0, 'A collection of datasets.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731579', 'ID1607072155411398743731362', 'Series', 'Series', '000020002800041', 3, 0, 'A Series in schema.org is a group of related items, typically but not necessarily of the same kind.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731592', 'ID1607072155411398743731362', 'WebPageElement', 'WebPageElement', '000020002800042', 3, 0, 'A web page element, like a table or an image.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731064', 'ID1607072155411398743731592', 'SiteNavigationElement', 'SiteNavigationElement', '00002000280004200001', 3, 0, 'A navigation element of the page.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731163', 'ID1607072155411398743731592', 'WPHeader', 'WPHeader', '00002000280004200002', 3, 0, 'The header section of the page.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731434', 'ID1607072155411398743731592', 'WPSideBar', 'WPSideBar', '00002000280004200003', 3, 0, 'A sidebar section of the page.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731467', 'ID1607072155411398743731592', 'WPAdBlock', 'WPAdBlock', '00002000280004200004', 3, 0, 'An advertising section of the page.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731607', 'ID1607072155411398743731592', 'Table', 'Table', '00002000280004200005', 3, 0, 'A table on a Web page.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731629', 'ID1607072155411398743731592', 'WPFooter', 'WPFooter', '00002000280004200006', 3, 0, 'The footer section of the page.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731612', 'ID1607072155411398743731362', 'Clip', 'Clip', '000020002800043', 3, 0, 'A short TV or radio program or a segment/part of a program.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731195', 'ID1607072155411398743731612', 'VideoGameClip', 'VideoGameClip', '00002000280004300001', 3, 0, 'A short segment/part of a video game.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731412', 'ID1607072155411398743731612', 'TVClip', 'TVClip', '00002000280004300002', 3, 0, 'A short TV program or a segment/part of a TV program.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731503', 'ID1607072155411398743731612', 'MovieClip', 'MovieClip', '00002000280004300003', 3, 0, 'A short segment/part of a movie.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731615', 'ID1607072155411398743731612', 'RadioClip', 'RadioClip', '00002000280004300004', 3, 0, 'A short radio program or a segment/part of a radio program.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731624', 'ID1607072155411398743731362', 'Map', 'Map', '000020002800044', 3, 0, 'A map.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731498', 'ID1606041948737864364386236', 'Intangible', 'Intangible', '0000200029', 3, 0, 'A utility class that serves as the umbrella for a number of \"intangible\" things such as quantities, structured values, etc.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731062', 'ID1607072155411398743731498', 'Invoice', 'Invoice', '000020002900001', 3, 0, 'A statement of the money due for goods or services; a bill.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731070', 'ID1607072155411398743731498', 'Service', 'Service', '000020002900002', 3, 0, 'A service provided by an organization, e.g. delivery service, print services, etc.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731121', 'ID1607072155411398743731070', 'Taxi', 'Taxi', '00002000290000200001', 3, 0, 'A taxi.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731327', 'ID1607072155411398743731070', 'FinancialProduct', 'FinancialProduct', '00002000290000200002', 3, 0, 'A product provided to consumers and businesses by financial institutions such as banks, insurance companies, brokerage firms, consumer finance companies, and investment companies which comprise the financial services industry.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731021', 'ID1607072155411398743731327', 'InvestmentOrDeposit', 'InvestmentOrDeposit', '0000200029000020000200001', 3, 0, 'A type of financial product that typically requires the client to transfer funds to a financial service in return for potential beneficial financial return.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731125', 'ID1607072155411398743731327', 'CurrencyConversionService', 'CurrencyConversionService', '0000200029000020000200002', 3, 0, 'A service to convert funds from one currency to another currency.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731148', 'ID1607072155411398743731327', 'BankAccount', 'BankAccount', '0000200029000020000200003', 3, 0, 'A product or service offered by a bank whereby one may deposit, withdraw or transfer money and in some cases be paid interest.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731000', 'ID1607072155411398743731148', 'DepositAccount', 'DepositAccount', '000020002900002000020000300001', 3, 0, 'A type of Bank Account with a main purpose of depositing funds to gain interest or other benefits.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731171', 'ID1607072155411398743731327', 'PaymentCard', 'PaymentCard', '0000200029000020000200004', 3, 0, 'A payment method using a credit, debit, store or other card to associate the payment with an account.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731149', 'ID1607072155411398743731171', 'CreditCard', 'CreditCard', '000020002900002000020000400001', 3, 0, 'A card payment method of a particular brand or name.  Used to mark up a particular payment method and/or the financial product/service that supplies the card account.<br />     Commonly used values:<br /> <br />     http://purl.org/goodrelations/v1#AmericanExpress <br />     http://purl.org/goodrelations/v1#DinersClub <br />     http://purl.org/goodrelations/v1#Discover <br />     http://purl.org/goodrelations/v1#JCB <br />     http://purl.org/goodrelations/v1#MasterCard <br />     http://purl.org/goodrelations/v1#VISA <br />');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731489', 'ID1607072155411398743731327', 'PaymentService', 'PaymentService', '0000200029000020000200005', 3, 0, 'A Service to transfer funds from a person or organization to a beneficiary person or organization.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731519', 'ID1607072155411398743731327', 'LoanOrCredit', 'LoanOrCredit', '0000200029000020000200006', 3, 0, 'A financial product for the loaning of an amount of money under agreed terms and charges.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731370', 'ID1607072155411398743731070', 'TaxiService', 'TaxiService', '00002000290000200003', 3, 0, 'A service for a vehicle for hire with a driver for local travel. Fares are usually calculated based on distance traveled.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731475', 'ID1607072155411398743731070', 'CableOrSatelliteService', 'CableOrSatelliteService', '00002000290000200004', 3, 0, 'A service which provides access to media programming like TV or radio. Access may be via cable or satellite.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731523', 'ID1607072155411398743731070', 'BroadcastService', 'BroadcastService', '00002000290000200005', 3, 0, 'A delivery service through which content is provided via broadcast over the air or online.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731589', 'ID1607072155411398743731070', 'GovernmentService', 'GovernmentService', '00002000290000200006', 3, 0, 'A service provided by a government organization, e.g. food stamps, veterans benefits, etc.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731081', 'ID1607072155411398743731498', 'BusTrip', 'BusTrip', '000020002900003', 3, 0, 'A trip on a commercial bus line.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731093', 'ID1607072155411398743731498', 'Language', 'Language', '000020002900004', 3, 0, 'Natural languages such as Spanish, Tamil, Hindi, English, etc. Formal language code tags expressed in <a href=\"https://en.wikipedia.org/wiki/IETF_language_tag\">BCP 47</a> can be used via the <a class=\"localLink\" href=\"/alternateName\">alternateName</a> property. The Language type previously also covered programming languages such as Scheme and Lisp, which are now best represented using <a class=\"localLink\" href=\"/ComputerLanguage\">ComputerLanguage</a>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731109', 'ID1607072155411398743731498', 'ProgramMembership', 'ProgramMembership', '000020002900005', 3, 0, 'Used to describe membership in a loyalty programs (e.g. \"StarAliance\"), traveler clubs (e.g. \"AAA\"), purchase clubs (\"Safeway Club\"), etc.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731141', 'ID1607072155411398743731498', 'Reservation', 'Reservation', '000020002900006', 3, 0, 'Describes a reservation for travel, dining or an event. Some reservations require tickets.Note: This type is for information about actual reservations, e.g. in confirmation emails or HTML pages with individual confirmations of reservations. For offers of tickets, restaurant reservations, flights, or rental cars, use http://schema.org/Offer.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731098', 'ID1607072155411398743731141', 'TrainReservation', 'TrainReservation', '00002000290000600001', 3, 0, 'A reservation for train travel.Note: This type is for information about actual reservations, e.g. in confirmation emails or HTML pages with individual confirmations of reservations. For offers of tickets, use http://schema.org/Offer.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731130', 'ID1607072155411398743731141', 'TaxiReservation', 'TaxiReservation', '00002000290000600002', 3, 0, 'A reservation for a taxi.Note: This type is for information about actual reservations, e.g. in confirmation emails or HTML pages with individual confirmations of reservations. For offers of tickets, use http://schema.org/Offer.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731221', 'ID1607072155411398743731141', 'FlightReservation', 'FlightReservation', '00002000290000600003', 3, 0, 'A reservation for air travel.Note: This type is for information about actual reservations, e.g. in confirmation emails or HTML pages with individual confirmations of reservations. For offers of tickets, use http://schema.org/Offer.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731233', 'ID1607072155411398743731141', 'RentalCarReservation', 'RentalCarReservation', '00002000290000600004', 3, 0, 'A reservation for a rental car.Note: This type is for information about actual reservations, e.g. in confirmation emails or HTML pages with individual confirmations of reservations.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731251', 'ID1607072155411398743731141', 'LodgingReservation', 'LodgingReservation', '00002000290000600005', 3, 0, 'A reservation for lodging at a hotel, motel, inn, etc.Note: This type is for information about actual reservations, e.g. in confirmation emails or HTML pages with individual confirmations of reservations.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731368', 'ID1607072155411398743731141', 'EventReservation', 'EventReservation', '00002000290000600006', 3, 0, 'A reservation for an event like a concert, sporting event, or lecture.Note: This type is for information about actual reservations, e.g. in confirmation emails or HTML pages with individual confirmations of reservations. For offers of tickets, use http://schema.org/Offer.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731452', 'ID1607072155411398743731141', 'BusReservation', 'BusReservation', '00002000290000600007', 3, 0, 'A reservation for bus travel.Note: This type is for information about actual reservations, e.g. in confirmation emails or HTML pages with individual confirmations of reservations. For offers of tickets, use http://schema.org/Offer.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731515', 'ID1607072155411398743731141', 'FoodEstablishmentReservation', 'FoodEstablishmentReservation', '00002000290000600008', 3, 0, 'A reservation to dine at a food-related business.Note: This type is for information about actual reservations, e.g. in confirmation emails or HTML pages with individual confirmations of reservations.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731543', 'ID1607072155411398743731141', 'ReservationPackage', 'ReservationPackage', '00002000290000600009', 3, 0, 'A group of multiple reservations with common values for all sub-reservations.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731146', 'ID1607072155411398743731498', 'HealthPlanFormulary', 'HealthPlanFormulary', '000020002900007', 3, 0, 'For a given health insurance plan, the specification for costs and coverage of prescription drugs.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731185', 'ID1607072155411398743731498', 'HealthPlanNetwork', 'HealthPlanNetwork', '000020002900008', 3, 0, 'A US-style health insurance plan network.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731190', 'ID1607072155411398743731498', 'EntryPoint', 'EntryPoint', '000020002900009', 3, 0, 'An entry point, within some Web-based protocol.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731193', 'ID1607072155411398743731498', 'Flight', 'Flight', '000020002900010', 3, 0, 'An airline flight.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731206', 'ID1607072155411398743731498', 'Quantity', 'Quantity', '000020002900011', 3, 0, 'Quantities such as distance, time, mass, weight, etc. Particular instances of say Mass are entities like \"3 Kg\" or \"4 milligrams\".');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731009', 'ID1607072155411398743731206', 'Energy', 'Energy', '00002000290001100001', 3, 0, 'Properties that take Energy as values are of the form \"&lt;Number&gt; &lt;Energy unit of measure&gt;\".');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731036', 'ID1607072155411398743731206', 'Duration', 'Duration', '00002000290001100002', 3, 0, 'Quantity: Duration (use  <a href=\"http://en.wikipedia.org/wiki/ISO_8601\">ISO 8601 duration format</a>).');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731261', 'ID1607072155411398743731206', 'Mass', 'Mass', '00002000290001100003', 3, 0, 'Properties that take Mass as values are of the form \"&lt;Number&gt; &lt;Mass unit of measure&gt;\". E.g., \"7 kg\".');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731479', 'ID1607072155411398743731206', 'Distance', 'Distance', '00002000290001100004', 3, 0, 'Properties that take Distances as values are of the form \"&lt;Number&gt; &lt;Length unit of measure&gt;\". E.g., \"7 ft\".');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731231', 'ID1607072155411398743731498', 'DataFeedItem', 'DataFeedItem', '000020002900012', 3, 0, 'A single item within a larger data feed.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731242', 'ID1607072155411398743731498', 'Offer', 'Offer', '000020002900013', 3, 0, 'An offer to transfer some rights to an item or to provide a service&#x2014;for example, an offer to sell tickets to an event, to rent the DVD of a movie, to stream a TV show over the internet, to repair a motorcycle, or to loan a book.       <br/><br/>       For <a href=\"http://www.gs1.org/barcodes/technical/idkeys/gtin\">GTIN</a>-related fields, see       <a href=\"http://www.gs1.org/barcodes/support/check_digit_calculator\">Check Digit calculator</a>       and <a href=\"http://www.gs1us.org/resources/standards/gtin-validation-guide\">validation guide</a>       from <a href=\"http://www.gs1.org/\">GS1</a>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731371', 'ID1607072155411398743731242', 'AggregateOffer', 'AggregateOffer', '00002000290001300001', 3, 0, 'When a single product is associated with multiple offers (for example, the same pair of shoes is offered by different merchants), then AggregateOffer can be used.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731243', 'ID1607072155411398743731498', 'Demand', 'Demand', '000020002900014', 3, 0, 'A demand entity represents the public, not necessarily binding, not necessarily exclusive, announcement by an organization or person to seek a certain type of goods or services. For describing demand using this type, the very same properties used for Offer apply.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731247', 'ID1607072155411398743731498', 'ItemList', 'ItemList', '000020002900015', 3, 0, 'A list of items of any sort&#x2014;for example, Top 10 Movies About Weathermen, or Top 100 Party Songs. Not to be confused with HTML lists, which are often used only for formatting.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731413', 'ID1607072155411398743731247', 'OfferCatalog', 'OfferCatalog', '00002000290001500001', 3, 0, 'An OfferCatalog is an ItemList that contains related Offers and/or further OfferCatalogs that are offeredBy the same provider.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731552', 'ID1607072155411398743731247', 'BreadcrumbList', 'BreadcrumbList', '00002000290001500002', 3, 0, 'A BreadcrumbList is an ItemList consisting of a chain of linked Web pages, typically described using at least their URL and their name, and typically ending with the current page.       <br />       <br />       The \"position\" property is used to reconstruct the order of the items in a BreadcrumbList.       The convention is that a breadcrumb list has an itemListOrder of ItemListOrderAscending (lower values listed first), and that the       first items in this list correspond to the \"top\" or beginning of the breadcrumb trail, e.g. with a site or section homepage.       The specific values of \"position\" are not assigned meaning for a BreadcrumbList, but they should be integers, e.g. beginning       with \"1\" for the first item in the list.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731258', 'ID1607072155411398743731498', 'JobPosting', 'JobPosting', '000020002900016', 3, 0, 'A listing that describes a job opening in a certain organization.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731265', 'ID1607072155411398743731498', 'Property', 'Property', '000020002900017', 3, 0, 'A property, used to indicate attributes and relationships of some Thing; equivalent to Property.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731267', 'ID1607072155411398743731498', 'Class', 'Class', '000020002900018', 3, 0, 'A class, also often called a \"Type\"; equivalent to Class.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731112', 'ID1607072155411398743731267', 'DataType', 'DataType', '00002000290001800001', 3, 0, 'The basic data types such as Integers, Strings, etc.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731271', 'ID1607072155411398743731498', 'HealthPlanCostSharingSpecification', 'HealthPlanCostSharingSpecification', '000020002900019', 3, 0, 'A description of costs to the patient under a given network or formulary.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731287', 'ID1607072155411398743731498', 'DigitalDocumentPermission', 'DigitalDocumentPermission', '000020002900020', 3, 0, 'A permission for a particular person or group to access a particular file.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731310', 'ID1607072155411398743731498', 'Rating', 'Rating', '000020002900021', 3, 0, 'A rating is an evaluation on a numeric scale, such as 1 to 5 stars.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731357', 'ID1607072155411398743731310', 'AggregateRating', 'AggregateRating', '00002000290002100001', 3, 0, 'The average rating based on multiple ratings or reviews.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731339', 'ID1607072155411398743731498', 'GameServer', 'GameServer', '000020002900022', 3, 0, 'Server that provides game interaction in a multiplayer game.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731340', 'ID1607072155411398743731498', 'HealthInsurancePlan', 'HealthInsurancePlan', '000020002900023', 3, 0, 'A US-style health insurance plan, including PPOs, EPOs, and HMOs.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731353', 'ID1607072155411398743731498', 'ListItem', 'ListItem', '000020002900024', 3, 0, 'An list item, e.g. a step in a checklist or how-to description.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731369', 'ID1607072155411398743731498', 'BroadcastFrequencySpecification', 'BroadcastFrequencySpecification', '000020002900025', 3, 0, 'The frequency in MHz and the modulation used for a particular BroadcastService.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731390', 'ID1607072155411398743731498', 'Role', 'Role', '000020002900026', 3, 0, '<p>Represents additional information about a relationship or property. For example a Role can be used to say that a \"member\" role linking some SportsTeam to a player occurred during a particular time period. Or that a Person\"s \"actor\" role in a Movie was for some particular characterName. Such properties can be attached to a Role entity, which is then associated with the main entities using ordinary properties like \"member\" or \"actor\".</p> <pre><code>  &lt;br/&gt;&lt;br/&gt;See also &lt;a href=\"http://blog.schema.org/2014/06/introducing-role.html\"&gt;blog post&lt;/a&gt;. </code></pre>');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731230', 'ID1607072155411398743731390', 'PerformanceRole', 'PerformanceRole', '00002000290002600001', 3, 0, 'A PerformanceRole is a Role that some entity places with regard to a theatrical performance, e.g. in a Movie, TVSeries etc.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731381', 'ID1607072155411398743731390', 'OrganizationRole', 'OrganizationRole', '00002000290002600002', 3, 0, 'A subclass of Role used to describe roles within organizations.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731044', 'ID1607072155411398743731381', 'EmployeeRole', 'EmployeeRole', '0000200029000260000200001', 3, 0, 'A subclass of OrganizationRole used to describe employee relationships.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731544', 'ID1607072155411398743731390', 'LinkRole', 'LinkRole', '00002000290002600003', 3, 0, 'A Role that represents a Web link e.g. as expressed via the \"url\" property. Its linkRelationship property can indicate URL-based and plain textual link types e.g. those in IANA link registry or others such as \"amphtml\". This structure provides a placeholder where details from HTML\"s link element can be represented outside of HTML, e.g. in JSON-LD feeds.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731407', 'ID1607072155411398743731498', 'Permit', 'Permit', '000020002900027', 3, 0, 'A permit issued by an organization, e.g. a parking pass.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731061', 'ID1607072155411398743731407', 'GovernmentPermit', 'GovernmentPermit', '00002000290002700001', 3, 0, 'A permit issued by a government agency.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731418', 'ID1607072155411398743731498', 'TrainTrip', 'TrainTrip', '000020002900028', 3, 0, 'A trip on a commercial train line.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731437', 'ID1607072155411398743731498', 'ParcelDelivery', 'ParcelDelivery', '000020002900029', 3, 0, 'The delivery of a parcel either via the postal service or a commercial service.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731442', 'ID1607072155411398743731498', 'AlignmentObject', 'AlignmentObject', '000020002900030', 3, 0, 'An intangible item that describes an alignment between a learning resource and a node in an educational framework.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731461', 'ID1607072155411398743731498', 'ServiceChannel', 'ServiceChannel', '000020002900031', 3, 0, 'A means for accessing a service, e.g. a government office location, web site, or phone number.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731463', 'ID1607072155411398743731498', 'Order', 'Order', '000020002900032', 3, 0, 'An order is a confirmation of a transaction (a receipt), which can contain multiple line items, each represented by an Offer that has been accepted by the customer.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731480', 'ID1607072155411398743731498', 'StructuredValue', 'StructuredValue', '000020002900033', 3, 0, 'Structured values are used when the value of a property has a more complex structure than simply being a textual value or a reference to another thing.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731008', 'ID1607072155411398743731480', 'EngineSpecification', 'EngineSpecification', '00002000290003300001', 3, 0, 'Information about the engine of the vehicle. A vehicle can have multiple engines represented by multiple engine specification entities.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731025', 'ID1607072155411398743731480', 'PropertyValue', 'PropertyValue', '00002000290003300002', 3, 0, 'A property-value pair, e.g. representing a feature of a product or place. Use the \"name\" property for the name of the property. If there is an additional human-readable version of the value, put that into the \"description\" property.         <br/><br/>         Always use specific schema.org properties when a) they exist and b) you can populate them. Using PropertyValue as a substitute will typically not trigger the same effect as using the original, specific property.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731160', 'ID1607072155411398743731480', 'ContactPoint', 'ContactPoint', '00002000290003300003', 3, 0, 'A contact point&#x2014;for example, a Customer Complaints department.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731192', 'ID1607072155411398743731480', 'TypeAndQuantityNode', 'TypeAndQuantityNode', '00002000290003300004', 3, 0, 'A structured value indicating the quantity, unit of measurement, and business function of goods included in a bundle offer.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731217', 'ID1607072155411398743731480', 'OpeningHoursSpecification', 'OpeningHoursSpecification', '00002000290003300005', 3, 0, 'A structured value providing information about the opening hours of a place or a certain service inside a place. <br /> The place is <b>open</b> if the <a href=\"/opens\">opens</a> property is specified, and <b>closed</b> otherwise. <br /> If the value for the <a href=\"/closes\">closes</a> property is less than the value for the <a href=\"/opens\">opens</a> property then the hour range is assumed to span over the next day.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731246', 'ID1607072155411398743731480', 'PriceSpecification', 'PriceSpecification', '00002000290003300006', 3, 0, 'A structured value representing a price or price range. Typically, only the subclasses of this type are used for markup. It is recommended to use <a class=\"localLink\" href=\"/MonetaryAmount\">MonetaryAmount</a> to describe independent amounts of money such as a salary, credit card limits, etc.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731022', 'ID1607072155411398743731246', 'DeliveryChargeSpecification', 'DeliveryChargeSpecification', '0000200029000330000600001', 3, 0, 'The price for the delivery of an offer using a particular delivery method.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731213', 'ID1607072155411398743731246', 'PaymentChargeSpecification', 'PaymentChargeSpecification', '0000200029000330000600002', 3, 0, 'The costs of settling the payment using a particular payment method.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731308', 'ID1607072155411398743731246', 'CompoundPriceSpecification', 'CompoundPriceSpecification', '0000200029000330000600003', 3, 0, 'A compound price specification is one that bundles multiple prices that all apply in combination for different dimensions of consumption. Use the name property of the attached unit price specification for indicating the dimension of a price component (e.g. \"electricity\" or \"final cleaning\").');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731494', 'ID1607072155411398743731246', 'UnitPriceSpecification', 'UnitPriceSpecification', '0000200029000330000600004', 3, 0, 'The price asked for a given offer by the respective organization or person.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731250', 'ID1607072155411398743731480', 'WarrantyPromise', 'WarrantyPromise', '00002000290003300007', 3, 0, 'A structured value representing the duration and scope of services that will be provided to a customer free of charge in case of a defect or malfunction of a product.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731254', 'ID1607072155411398743731480', 'DatedMoneySpecification', 'DatedMoneySpecification', '00002000290003300008', 3, 0, 'A DatedMoneySpecification represents monetary values with optional start and end dates. For example, this could represent an employee\"s salary over a specific period of time. <strong>Note:</strong> This type has been superseded by <a class=\"localLink\" href=\"/MonetaryAmount\">MonetaryAmount</a> use of that type is recommended');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731325', 'ID1607072155411398743731480', 'InteractionCounter', 'InteractionCounter', '00002000290003300009', 3, 0, 'A summary of how users have interacted with this CreativeWork. In most cases, authors will use a subtype to specify the specific type of interaction.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731332', 'ID1607072155411398743731480', 'QuantitativeValue', 'QuantitativeValue', '00002000290003300010', 3, 0, 'A point value or interval for product characteristics and other purposes.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731391', 'ID1607072155411398743731480', 'GeoShape', 'GeoShape', '00002000290003300011', 3, 0, 'The geographic shape of a place. A GeoShape can be described using several properties whose values are based on latitude/longitude pairs. Either whitespace or commas can be used to separate latitude and longitude; whitespace should be used when writing a list of several such points.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731477', 'ID1607072155411398743731391', 'GeoCircle', 'GeoCircle', '0000200029000330001100001', 3, 0, 'A GeoCircle is a GeoShape representing a circular geographic area. As it is a GeoShape           it provides the simple textual property \"circle\", but also allows the combination of postalCode alongside geoRadius.           The center of the circle can be indicated via the \"geoMidpoint\" property, or more approximately using \"address\", \"postalCode\".');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731455', 'ID1607072155411398743731480', 'GeoCoordinates', 'GeoCoordinates', '00002000290003300012', 3, 0, 'The geographic coordinates of a place or event.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731536', 'ID1607072155411398743731480', 'OwnershipInfo', 'OwnershipInfo', '00002000290003300013', 3, 0, 'A structured value providing information about when a certain organization or person owned a certain product.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731556', 'ID1607072155411398743731480', 'MonetaryAmount', 'MonetaryAmount', '00002000290003300014', 3, 0, 'A monetary value or range. This type can be used to describe an amount of money such as $50 USD, or a range as in describing a bank account being suitable for a balance between ￡1,000 and ￡1,000,000 GBP, or the value of a salary, etc. It is recommended to use <a class=\"localLink\" href=\"/PriceSpecification\">PriceSpecification</a> Types to describe the price of an Offer, Invoice, etc.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731610', 'ID1607072155411398743731480', 'NutritionInformation', 'NutritionInformation', '00002000290003300015', 3, 0, 'Nutritional information about the recipe.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731485', 'ID1607072155411398743731498', 'Brand', 'Brand', '000020002900034', 3, 0, 'A brand is a name used by an organization or business person for labeling a product, product group, or similar.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731504', 'ID1607072155411398743731498', 'BroadcastChannel', 'BroadcastChannel', '000020002900035', 3, 0, 'A unique instance of a BroadcastService on a CableOrSatelliteService lineup.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731019', 'ID1607072155411398743731504', 'TelevisionChannel', 'TelevisionChannel', '00002000290003500001', 3, 0, 'A unique instance of a television BroadcastService on a CableOrSatelliteService lineup.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731276', 'ID1607072155411398743731504', 'RadioChannel', 'RadioChannel', '00002000290003500002', 3, 0, 'A unique instance of a radio BroadcastService on a CableOrSatelliteService lineup.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731506', 'ID1607072155411398743731498', 'Ticket', 'Ticket', '000020002900036', 3, 0, 'Used to describe a ticket to an event, a flight, a bus ride, etc.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731559', 'ID1607072155411398743731498', 'PropertyValueSpecification', 'PropertyValueSpecification', '000020002900037', 3, 0, 'A Property value specification.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731586', 'ID1607072155411398743731498', 'OrderItem', 'OrderItem', '000020002900038', 3, 0, 'An order item is a line of an order. It includes the quantity and shipping details of a bought offer.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731618', 'ID1607072155411398743731498', 'ComputerLanguageLanguage', 'ComputerLanguageLanguage', '000020002900039', 3, 0, 'This type covers computer programming languages such as Scheme and Lisp, as well as other language-like computer representations. Natural languages are best represented with the <a class=\"localLink\" href=\"/Language\">Language</a> type.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731625', 'ID1607072155411398743731498', 'Seat', 'Seat', '000020002900040', 3, 0, 'Used to describe a seat, such as a reserved seat in an event reservation.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731630', 'ID1607072155411398743731498', 'Audience', 'Audience', '000020002900041', 3, 0, 'Intended audience for an item, i.e. the group for whom the item was created.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731268', 'ID1607072155411398743731630', 'PeopleAudience', 'PeopleAudience', '00002000290004100001', 3, 0, 'A set of characteristics belonging to people, e.g. who compose an item\"s target audience.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731570', 'ID1607072155411398743731268', 'ParentAudience', 'ParentAudience', '0000200029000410000100001', 3, 0, 'A set of characteristics describing parents, who can be interested in viewing some content.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731282', 'ID1607072155411398743731630', 'EducationalAudience', 'EducationalAudience', '00002000290004100002', 3, 0, 'An EducationalAudience.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731312', 'ID1607072155411398743731630', 'MedicalAudience', 'MedicalAudience', '00002000290004100003', 3, 0, 'Target audiences for medical web pages. Enumerated type.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731601', 'ID1607072155411398743731630', 'BusinessAudience', 'BusinessAudience', '00002000290004100004', 3, 0, 'A set of characteristics belonging to businesses, e.g. who compose an item\"s target audience.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731597', 'ID1606041948737864364386236', 'Event', 'Event', '0000200030', 3, 0, 'An event happening at a certain time and location, such as a concert, lecture, or festival. Ticketing information may be added via the \"offers\" property. Repeated events may be structured as separate Event objects.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731023', 'ID1607072155411398743731597', 'LiteraryEvent', 'LiteraryEvent', '000020003000001', 3, 0, 'Event type: Literary event.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731049', 'ID1607072155411398743731597', 'ChildrensEvent', 'ChildrensEvent', '000020003000002', 3, 0, 'Event type: Children\"s event.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731056', 'ID1607072155411398743731597', 'EducationEvent', 'EducationEvent', '000020003000003', 3, 0, 'Event type: Education event.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731068', 'ID1607072155411398743731597', 'ComedyEvent', 'ComedyEvent', '000020003000004', 3, 0, 'Event type: Comedy event.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731071', 'ID1607072155411398743731597', 'SocialEvent', 'SocialEvent', '000020003000005', 3, 0, 'Event type: Social event.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731074', 'ID1607072155411398743731597', 'TheaterEvent', 'TheaterEvent', '000020003000006', 3, 0, 'Event type: Theater performance.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731106', 'ID1607072155411398743731597', 'ScreeningEvent', 'ScreeningEvent', '000020003000007', 3, 0, 'A screening of a movie or other video.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731136', 'ID1607072155411398743731597', 'SportsEvent', 'SportsEvent', '000020003000008', 3, 0, 'Event type: Sports event.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731167', 'ID1607072155411398743731597', 'EventSeries', 'EventSeries', '000020003000009', 3, 0, 'A series of <a class=\"localLink\" href=\"/Event\">Event</a>s. Included events can relate with the series using the <a class=\"localLink\" href=\"/superEvent\">superEvent</a> property.</p> <p>An EventSeries is a collection of events that share some unifying characteristic. For example, \"The Olympic Games\" is a series, which is repeated regularly. The \"2012 London Olympics\" can be presented both as an <a class=\"localLink\" href=\"/Event\">Event</a> in the series \"Olympic Games\", and as an <a class=\"localLink\" href=\"/EventSeries\">EventSeries</a> that included a number of sporting competitions as Events.</p> <p>The nature of the association between the events in an <a class=\"localLink\" href=\"/EventSeries\">EventSeries</a> can vary, but typical examples could include a thematic event series (e.g. topical meetups or classes), or a series of regular events that share a location, attendee group and/or organizers.</p> <p>EventSeries has been defined as a kind of Event to make it easy for publishers to use it in an Event context without worrying about which kinds of series are really event-like enough to call an Event. In general an EventSeries may seem more Event-like when the period of time is compact and when aspects such as location are fixed, but it may also sometimes prove useful to describe a longer-term series as an Event.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731174', 'ID1607072155411398743731597', 'VisualArtsEvent', 'VisualArtsEvent', '000020003000010', 3, 0, 'Event type: Visual arts event.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731232', 'ID1607072155411398743731597', 'DanceEvent', 'DanceEvent', '000020003000011', 3, 0, 'Event type: A social dance.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731241', 'ID1607072155411398743731597', 'SaleEvent', 'SaleEvent', '000020003000012', 3, 0, 'Event type: Sales event.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731275', 'ID1607072155411398743731597', 'PublicationEvent', 'PublicationEvent', '000020003000013', 3, 0, 'A PublicationEvent corresponds indifferently to the event of publication for a CreativeWork of any type e.g. a broadcast event, an on-demand event, a book/journal publication via a variety of delivery media.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731034', 'ID1607072155411398743731275', 'OnDemandEvent', 'OnDemandEvent', '00002000300001300001', 3, 0, 'A publication event e.g. catch-up TV or radio podcast, during which a program is available on-demand.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731223', 'ID1607072155411398743731275', 'BroadcastEvent', 'BroadcastEvent', '00002000300001300002', 3, 0, 'An over the air or online broadcast event.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731284', 'ID1607072155411398743731597', 'DeliveryEvent', 'DeliveryEvent', '000020003000014', 3, 0, 'An event involving the delivery of an item.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731291', 'ID1607072155411398743731597', 'Festival', 'Festival', '000020003000015', 3, 0, 'Event type: Festival.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731331', 'ID1607072155411398743731597', 'ExhibitionEvent', 'ExhibitionEvent', '000020003000016', 3, 0, 'Event type: Exhibition event, e.g. at a museum, library, archive, tradeshow, ...');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731393', 'ID1607072155411398743731597', 'FoodEvent', 'FoodEvent', '000020003000017', 3, 0, 'Event type: Food event.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731401', 'ID1607072155411398743731597', 'UserInteraction', 'UserInteraction', '000020003000018', 3, 0, 'UserInteraction and its subtypes is an old way of talking about users interacting with pages. It is generally better to use           <a href=\"/Action\">Action</a>-based vocabulary, alongside types such as <a href=\"/Comment\">Comment</a>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731052', 'ID1607072155411398743731401', 'UserLikes', 'UserLikes', '00002000300001800001', 3, 0, 'UserInteraction and its subtypes is an old way of talking about users interacting with pages. It is generally better to use           <a href=\"/Action\">Action</a>-based vocabulary, alongside types such as <a href=\"/Comment\">Comment</a>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731073', 'ID1607072155411398743731401', 'UserPlays', 'UserPlays', '00002000300001800002', 3, 0, 'UserInteraction and its subtypes is an old way of talking about users interacting with pages. It is generally better to use           <a href=\"/Action\">Action</a>-based vocabulary, alongside types such as <a href=\"/Comment\">Comment</a>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731245', 'ID1607072155411398743731401', 'UserPlusOnes', 'UserPlusOnes', '00002000300001800003', 3, 0, 'UserInteraction and its subtypes is an old way of talking about users interacting with pages. It is generally better to use           <a href=\"/Action\">Action</a>-based vocabulary, alongside types such as <a href=\"/Comment\">Comment</a>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731311', 'ID1607072155411398743731401', 'UserBlocks', 'UserBlocks', '00002000300001800004', 3, 0, 'UserInteraction and its subtypes is an old way of talking about users interacting with pages. It is generally better to use           <a href=\"/Action\">Action</a>-based vocabulary, alongside types such as <a href=\"/Comment\">Comment</a>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731326', 'ID1607072155411398743731401', 'UserCheckins', 'UserCheckins', '00002000300001800005', 3, 0, 'UserInteraction and its subtypes is an old way of talking about users interacting with pages. It is generally better to use           <a href=\"/Action\">Action</a>-based vocabulary, alongside types such as <a href=\"/Comment\">Comment</a>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731347', 'ID1607072155411398743731401', 'UserComments', 'UserComments', '00002000300001800006', 3, 0, 'UserInteraction and its subtypes is an old way of talking about users interacting with pages. It is generally better to use           <a href=\"/Action\">Action</a>-based vocabulary, alongside types such as <a href=\"/Comment\">Comment</a>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731540', 'ID1607072155411398743731401', 'UserPageVisits', 'UserPageVisits', '00002000300001800007', 3, 0, 'UserInteraction and its subtypes is an old way of talking about users interacting with pages. It is generally better to use           <a href=\"/Action\">Action</a>-based vocabulary, alongside types such as <a href=\"/Comment\">Comment</a>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731546', 'ID1607072155411398743731401', 'UserDownloads', 'UserDownloads', '00002000300001800008', 3, 0, 'UserInteraction and its subtypes is an old way of talking about users interacting with pages. It is generally better to use           <a href=\"/Action\">Action</a>-based vocabulary, alongside types such as <a href=\"/Comment\">Comment</a>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731598', 'ID1607072155411398743731401', 'UserTweets', 'UserTweets', '00002000300001800009', 3, 0, 'UserInteraction and its subtypes is an old way of talking about users interacting with pages. It is generally better to use           <a href=\"/Action\">Action</a>-based vocabulary, alongside types such as <a href=\"/Comment\">Comment</a>.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731456', 'ID1607072155411398743731597', 'BusinessEvent', 'BusinessEvent', '000020003000019', 3, 0, 'Event type: Business event.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731599', 'ID1607072155411398743731597', 'CourseInstance', 'CourseInstance', '000020003000020', 3, 0, 'An instance of a Course offered at a specific time and place or through specific media or mode of study or to a specific section of students.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731614', 'ID1607072155411398743731597', 'MusicEvent', 'MusicEvent', '000020003000021', 3, 0, 'Event type: Music event.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731028', 'ID1606041948737864364386236', 'MedicalEntity', 'MedicalEntity', '0000200031', 3, 0, 'The most generic type of entity related to health and the practice of medicine.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731007', 'ID1607072155411398743731028', 'MedicalRiskFactor', 'MedicalRiskFactor', '000020003100001', 3, 0, 'A risk factor is anything that increases a person\"s likelihood of developing or contracting a disease, medical condition, or complication.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731038', 'ID1607072155411398743731028', 'MedicalStudy', 'MedicalStudy', '000020003100002', 3, 0, 'A medical study is an umbrella type covering all kinds of research studies relating to human medicine or health, including observational studies and interventional trials and registries, randomized, controlled or not. When the specific type of study is known, use one of the extensions of this type, such as MedicalTrial or MedicalObservationalStudy. Also, note that this type should be used to mark up data that describes the study itself; to tag an article that publishes the results of a study, use MedicalScholarlyArticle. Note: use the code property of MedicalEntity to store study IDs, e.g. clinicaltrials.gov ID.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731472', 'ID1607072155411398743731038', 'MedicalObservationalStudy', 'MedicalObservationalStudy', '00002000310000200001', 3, 0, 'An observational study is a type of medical study that attempts to infer the possible effect of a treatment through observation of a cohort of subjects over a period of time. In an observational study, the assignment of subjects into treatment groups versus control groups is outside the control of the investigator. This is in contrast with controlled studies, such as the randomized controlled trials represented by MedicalTrial, where each subject is randomly assigned to a treatment group or a control group before the start of the treatment.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731522', 'ID1607072155411398743731038', 'MedicalTrial', 'MedicalTrial', '00002000310000200002', 3, 0, 'A medical trial is a type of medical study that uses scientific process used to compare the safety and efficacy of medical therapies or medical procedures. In general, medical trials are controlled and subjects are allocated at random to the different treatment and/or control groups.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731123', 'ID1607072155411398743731028', 'MedicalProcedure', 'MedicalProcedure', '000020003100003', 3, 0, 'A process of care used in either a diagnostic, therapeutic, preventive or palliative capacity that relies on invasive (surgical), non-invasive, or other techniques.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731027', 'ID1607072155411398743731123', 'PalliativeProcedure', 'PalliativeProcedure', '00002000310000300001', 3, 0, 'A medical procedure intended primarily for palliative purposes, aimed at relieving the symptoms of an underlying health condition.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731483', 'ID1607072155411398743731123', 'DiagnosticProcedure', 'DiagnosticProcedure', '00002000310000300002', 3, 0, 'A medical procedure intended primarily for diagnostic, as opposed to therapeutic, purposes.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731584', 'ID1607072155411398743731123', 'TherapeuticProcedure', 'TherapeuticProcedure', '00002000310000300003', 3, 0, 'A medical procedure intended primarily for therapeutic purposes, aimed at improving a health condition.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731168', 'ID1607072155411398743731584', 'PsychologicalTreatment', 'PsychologicalTreatment', '0000200031000030000300001', 3, 0, 'A process of care relying upon counseling, dialogue and communication  aimed at improving a mental health condition without use of drugs.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731471', 'ID1607072155411398743731584', 'MedicalTherapy', 'MedicalTherapy', '0000200031000030000300002', 3, 0, 'Any medical intervention designed to prevent, treat, and cure human diseases and medical conditions, including both curative and palliative therapies. Medical therapies are typically processes of care relying upon pharmacotherapy, behavioral therapy, supportive therapy (with fluid or nutrition for example), or detoxification (e.g. hemodialysis) aimed at improving or preventing a health condition.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731240', 'ID1607072155411398743731471', 'RadiationTherapy', 'RadiationTherapy', '000020003100003000030000200001', 3, 0, 'A process of care using radiation aimed at improving a health condition.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731289', 'ID1607072155411398743731471', 'PhysicalTherapy', 'PhysicalTherapy', '000020003100003000030000200002', 3, 0, 'A process of progressive physical care and rehabilitation aimed at improving a health condition.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731590', 'ID1607072155411398743731123', 'PhysicalExam', 'PhysicalExam', '00002000310000300004', 3, 0, 'A type of physical examination of a patient performed by a physician.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731137', 'ID1607072155411398743731028', 'MedicalGuideline', 'MedicalGuideline', '000020003100004', 3, 0, 'Any recommendation made by a standard society (e.g. ACC/AHA) or consensus statement that denotes how to diagnose and treat a particular condition. Note: this type should be used to tag the actual guideline recommendation; if the guideline recommendation occurs in a larger scholarly article, use MedicalScholarlyArticle to tag the overall article, not this type. Note also: the organization making the recommendation should be captured in the recognizingAuthority base property of MedicalEntity.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731605', 'ID1607072155411398743731137', 'MedicalGuidelineContraindication', 'MedicalGuidelineContraindication', '00002000310000400001', 3, 0, 'A guideline contraindication that designates a process as harmful and where quality of the data supporting the contraindication is sound.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731631', 'ID1607072155411398743731137', 'MedicalGuidelineRecommendation', 'MedicalGuidelineRecommendation', '00002000310000400002', 3, 0, 'A guideline recommendation that is regarded as efficacious and where quality of the data supporting the recommendation is sound.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731208', 'ID1607072155411398743731028', 'MedicalCondition', 'MedicalCondition', '000020003100005', 3, 0, 'Any condition of the human body that affects the normal functioning of a person, whether physically or mentally. Includes diseases, injuries, disabilities, disorders, syndromes, etc.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731006', 'ID1607072155411398743731208', 'InfectiousDisease', 'InfectiousDisease', '00002000310000500001', 3, 0, 'An infectious disease is a clinically evident human disease resulting from the presence of pathogenic microbial agents, like pathogenic viruses, pathogenic bacteria, fungi, protozoa, multicellular parasites, and prions. To be considered an infectious disease, such pathogens are known to be able to cause this disease.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731533', 'ID1607072155411398743731208', 'MedicalSignOrSymptom', 'MedicalSignOrSymptom', '00002000310000500002', 3, 0, 'Any feature associated or not with a medical condition. In medicine a symptom is generally subjective while a sign is objective.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731328', 'ID1607072155411398743731533', 'MedicalSign', 'MedicalSign', '0000200031000050000200001', 3, 0, 'Any physical manifestation of a person\"s medical condition discoverable by objective diagnostic tests or physical examination.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731170', 'ID1607072155411398743731328', 'VitalSign', 'VitalSign', '000020003100005000020000100001', 3, 0, 'Vital signs are measures of various physiological functions in order to assess the most basic body functions.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731439', 'ID1607072155411398743731533', 'MedicalSymptom', 'MedicalSymptom', '0000200031000050000200002', 3, 0, 'Any complaint sensed and expressed by the patient (therefore defined as subjective)  like stomachache, lower-back pain, or fatigue.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731293', 'ID1607072155411398743731028', 'MedicalRiskEstimator', 'MedicalRiskEstimator', '000020003100006', 3, 0, 'Any rule set or interactive tool for estimating the risk of developing a complication or condition.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731099', 'ID1607072155411398743731293', 'MedicalRiskScore', 'MedicalRiskScore', '00002000310000600001', 3, 0, 'A simple system that adds up the number of risk factors to yield a score that is associated with prognosis, e.g. CHAD score, TIMI risk score.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731507', 'ID1607072155411398743731293', 'MedicalRiskCalculator', 'MedicalRiskCalculator', '00002000310000600002', 3, 0, 'A complex mathematical calculation requiring an online calculator, used to assess prognosis. Note: use the url property of Thing to record any URLs for online calculators.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731352', 'ID1607072155411398743731028', 'MedicalCause', 'MedicalCause', '000020003100007', 3, 0, 'The causative agent(s) that are responsible for the pathophysiologic process that eventually results in a medical condition, symptom or sign. In this schema, unless otherwise specified this is meant to be the proximate cause of the medical condition, symptom or sign. The proximate cause is defined as the causative agent that most directly results in the medical condition, symptom or sign. For example, the HIV virus could be considered a cause of AIDS. Or in a diagnostic context, if a patient fell and sustained a hip fracture and two days later sustained a pulmonary embolism which eventuated in a cardiac arrest, the cause of the cardiac arrest (the proximate cause) would be the pulmonary embolism and not the fall. Medical causes can include cardiovascular, chemical, dermatologic, endocrine, environmental, gastroenterologic, genetic, hematologic, gynecologic, iatrogenic, infectious, musculoskeletal, neurologic, nutritional, obstetric, oncologic, otolaryngologic, pharmacologic, psychiatric, pulmonary, renal, rheumatologic, toxic, traumatic, or urologic causes; medical conditions can be causes as well.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731367', 'ID1607072155411398743731028', 'MedicalDevice', 'MedicalDevice', '000020003100008', 3, 0, 'Any object used in a medical capacity, such as to diagnose or treat a patient.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731380', 'ID1607072155411398743731028', 'Substance', 'Substance', '000020003100009', 3, 0, 'Any matter of defined composition that has discrete existence, whose origin may be biological, mineral or chemical.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731043', 'ID1607072155411398743731380', 'DietarySupplement', 'DietarySupplement', '00002000310000900001', 3, 0, 'A product taken by mouth that contains a dietary ingredient intended to supplement the diet. Dietary ingredients may include vitamins, minerals, herbs or other botanicals, amino acids, and substances such as enzymes, organ tissues, glandulars and metabolites.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731444', 'ID1607072155411398743731380', 'Drug', 'Drug', '00002000310000900002', 3, 0, 'A chemical or biologic substance, used as a medical therapy, that has a physiological effect on an organism. Here the term drug is used interchangeably with the term medicine although clinical knowledge make a clear difference between them.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731382', 'ID1607072155411398743731028', 'SuperficialAnatomy', 'SuperficialAnatomy', '000020003100010', 3, 0, 'Anatomical features that can be observed by sight (without dissection), including the form and proportions of the human body as well as surface landmarks that correspond to deeper subcutaneous structures. Superficial anatomy plays an important role in sports medicine, phlebotomy, and other medical specialties as underlying anatomical structures can be identified through surface palpation. For example, during back surgery, superficial anatomy can be used to palpate and count vertebrae to find the site of incision. Or in phlebotomy, superficial anatomy can be used to locate an underlying vein; for example, the median cubital vein can be located by palpating the borders of the cubital fossa (such as the epicondyles of the humerus) and then looking for the superficial signs of the vein, such as size, prominence, ability to refill after depression, and feel of surrounding tissue support. As another example, in a subluxation (dislocation) of the glenohumeral joint, the bony structure becomes pronounced with the deltoid muscle failing to cover the glenohumeral joint allowing the edges of the scapula to be superficially visible. Here, the superficial anatomy is the visible edges of the scapula, implying the underlying dislocation of the joint (the related anatomical structure).');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731403', 'ID1607072155411398743731028', 'AnatomicalSystem', 'AnatomicalSystem', '000020003100011', 3, 0, 'An anatomical system is a group of anatomical structures that work together to perform a certain task. Anatomical systems, such as organ systems, are one organizing principle of anatomy, and can includes circulatory, digestive, endocrine, integumentary, immune, lymphatic, muscular, nervous, reproductive, respiratory, skeletal, urinary, vestibular, and other systems.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731459', 'ID1607072155411398743731028', 'MedicalIntangible', 'MedicalIntangible', '000020003100012', 3, 0, 'A utility class that serves as the umbrella for a number of \"intangible\" things in the medical space.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731004', 'ID1607072155411398743731459', 'DoseSchedule', 'DoseSchedule', '00002000310001200001', 3, 0, 'A specific dosing schedule for a drug or supplement.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731017', 'ID1607072155411398743731004', 'MaximumDoseSchedule', 'MaximumDoseSchedule', '0000200031000120000100001', 3, 0, 'The maximum dosing schedule considered safe for a drug or supplement as recommended by an authority or by the drug/supplement\"s manufacturer. Capture the recommending authority in the recognizingAuthority property of MedicalEntity.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731317', 'ID1607072155411398743731004', 'RecommendedDoseSchedule', 'RecommendedDoseSchedule', '0000200031000120000100002', 3, 0, 'A recommended dosing schedule for a drug or supplement as prescribed or recommended by an authority or by the drug/supplement\"s manufacturer. Capture the recommending authority in the recognizingAuthority property of MedicalEntity.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731424', 'ID1607072155411398743731004', 'ReportedDoseSchedule', 'ReportedDoseSchedule', '0000200031000120000100003', 3, 0, 'A patient-reported or observed dosing schedule for a drug or supplement.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731165', 'ID1607072155411398743731459', 'DDxElement', 'DDxElement', '00002000310001200002', 3, 0, 'An alternative, closely-related condition typically considered later in the differential diagnosis process along with the signs that are used to distinguish it.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731201', 'ID1607072155411398743731459', 'MedicalConditionStage', 'MedicalConditionStage', '00002000310001200003', 3, 0, 'A stage of a medical condition, such as \"Stage IIIa\".');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731259', 'ID1607072155411398743731459', 'DrugLegalStatus', 'DrugLegalStatus', '00002000310001200004', 3, 0, 'The legal availability status of a medical drug.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731469', 'ID1607072155411398743731459', 'MedicalCode', 'MedicalCode', '00002000310001200005', 3, 0, 'A code for a medical entity.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731488', 'ID1607072155411398743731459', 'DrugStrength', 'DrugStrength', '00002000310001200006', 3, 0, 'A specific strength in which a medical drug is available in a specific country.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731462', 'ID1607072155411398743731028', 'LifestyleModification', 'LifestyleModification', '000020003100013', 3, 0, 'A process of care involving exercise, changes to diet, fitness routines, and other lifestyle changes aimed at improving a health condition.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731298', 'ID1607072155411398743731462', 'Diet', 'Diet', '00002000310001300001', 3, 0, 'A strategy of regulating the intake of food to achieve or maintain a specific health-related goal.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731482', 'ID1607072155411398743731462', 'PhysicalActivity', 'PhysicalActivity', '00002000310001300002', 3, 0, 'Any bodily activity that enhances or maintains physical fitness and overall health and wellness. Includes activity that is part of daily living and routine, structured exercise, and exercise prescribed as part of a medical treatment or recovery plan.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731210', 'ID1607072155411398743731482', 'ExercisePlan', 'ExercisePlan', '0000200031000130000200001', 3, 0, 'Fitness-related activity designed for a specific health-related purpose, including defined exercise routines as well as activity prescribed by a clinician.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731468', 'ID1607072155411398743731028', 'MedicalIndication', 'MedicalIndication', '000020003100014', 3, 0, 'A condition or factor that indicates use of a medical therapy, including signs, symptoms, risk factors, anatomical states, etc.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731016', 'ID1607072155411398743731468', 'PreventionIndication', 'PreventionIndication', '00002000310001400001', 3, 0, 'An indication for preventing an underlying condition, symptom, etc.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731338', 'ID1607072155411398743731468', 'ApprovedIndication', 'ApprovedIndication', '00002000310001400002', 3, 0, 'An indication for a medical therapy that has been formally specified or approved by a regulatory body that regulates use of the therapy; for example, the US FDA approves indications for most drugs in the US.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731373', 'ID1607072155411398743731468', 'TreatmentIndication', 'TreatmentIndication', '00002000310001400003', 3, 0, 'An indication for treating an underlying condition, symptom, etc.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731491', 'ID1607072155411398743731028', 'MedicalTest', 'MedicalTest', '000020003100015', 3, 0, 'Any medical test, typically performed for diagnostic purposes.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731039', 'ID1607072155411398743731491', 'MedicalTestPanel', 'MedicalTestPanel', '00002000310001500001', 3, 0, 'Any collection of tests commonly ordered together.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731255', 'ID1607072155411398743731491', 'BloodTest', 'BloodTest', '00002000310001500002', 3, 0, 'A medical test performed on a sample of a patient\"s blood.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731426', 'ID1607072155411398743731491', 'PathologyTest', 'PathologyTest', '00002000310001500003', 3, 0, 'A medical test performed by a laboratory that typically involves examination of a tissue sample by a pathologist.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731575', 'ID1607072155411398743731491', 'ImagingTest', 'ImagingTest', '00002000310001500004', 3, 0, 'Any medical imaging modality typically used for diagnostic purposes.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731541', 'ID1607072155411398743731028', 'MedicalContraindication', 'MedicalContraindication', '000020003100016', 3, 0, 'A condition or factor that serves as a reason to withhold a certain medical therapy. Contraindications can be absolute (there are no reasonable circumstances for undertaking a course of action) or relative (the patient is at higher risk of complications, but that these risks may be outweighed by other considerations or mitigated by other measures).');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731577', 'ID1607072155411398743731028', 'AnatomicalStructure', 'AnatomicalStructure', '000020003100017', 3, 0, 'Any part of the human body, typically a component of an anatomical system. Organs, tissues, and cells are all anatomical structures.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731033', 'ID1607072155411398743731577', 'Joint', 'Joint', '00002000310001700001', 3, 0, 'The anatomical location at which two or more bones make contact.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731072', 'ID1607072155411398743731577', 'BrainStructure', 'BrainStructure', '00002000310001700002', 3, 0, 'Any anatomical structure which pertains to the soft nervous tissue functioning as the coordinating center of sensation and intellectual and nervous activity.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731196', 'ID1607072155411398743731577', 'Ligament', 'Ligament', '00002000310001700003', 3, 0, 'A short band of tough, flexible, fibrous connective tissue that functions to connect multiple bones, cartilages, and structurally support joints.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731226', 'ID1607072155411398743731577', 'Muscle', 'Muscle', '00002000310001700004', 3, 0, 'A muscle is an anatomical structure consisting of a contractile form of tissue that animals use to effect movement.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731516', 'ID1607072155411398743731577', 'Nerve', 'Nerve', '00002000310001700005', 3, 0, 'A common pathway for the electrochemical nerve impulses that are transmitted along each of the axons.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731591', 'ID1607072155411398743731577', 'Bone', 'Bone', '00002000310001700006', 3, 0, 'Rigid connective tissue that comprises up the skeletal structure of the human body.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731593', 'ID1607072155411398743731577', 'Vessel', 'Vessel', '00002000310001700007', 3, 0, 'A component of the human body circulatory system comprised of an intricate network of hollow tubes that transport blood throughout the entire body.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731152', 'ID1607072155411398743731593', 'Artery', 'Artery', '0000200031000170000700001', 3, 0, 'A type of blood vessel that specifically carries blood away from the heart.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731283', 'ID1607072155411398743731593', 'LymphaticVessel', 'LymphaticVessel', '0000200031000170000700002', 3, 0, 'A type of blood vessel that specifically carries lymph fluid unidirectionally toward the heart.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731499', 'ID1607072155411398743731593', 'Vein', 'Vein', '0000200031000170000700003', 3, 0, 'A type of blood vessel that specifically carries blood to the heart.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731060', 'ID1606041948737864364386236', 'Organization', 'Organization', '0000200032', 3, 0, 'An organization such as a school, NGO, corporation, club, etc.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731013', 'ID1607072155411398743731060', 'Airline', 'Airline', '000020003200001', 3, 0, 'An organization that provides flights for passengers.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731030', 'ID1607072155411398743731060', 'NGO', 'NGO', '000020003200002', 3, 0, 'Organization: Non-governmental Organization.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731078', 'ID1607072155411398743731060', 'EducationalOrganization', 'EducationalOrganization', '000020003200003', 3, 0, 'An educational organization.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731096', 'ID1607072155411398743731078', 'ElementarySchool', 'ElementarySchool', '00002000320000300001', 3, 0, 'An elementary school.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731135', 'ID1607072155411398743731078', 'HighSchool', 'HighSchool', '00002000320000300002', 3, 0, 'A high school.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731200', 'ID1607072155411398743731078', 'School', 'School', '00002000320000300003', 3, 0, 'A school.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731212', 'ID1607072155411398743731078', 'MiddleSchool', 'MiddleSchool', '00002000320000300004', 3, 0, 'A middle school (typically for children aged around 11-14, although this varies somewhat).');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731303', 'ID1607072155411398743731078', 'CollegeOrUniversity', 'CollegeOrUniversity', '00002000320000300005', 3, 0, 'A college, university, or other third-level educational institution.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731594', 'ID1607072155411398743731078', 'Preschool', 'Preschool', '00002000320000300006', 3, 0, 'A preschool.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731128', 'ID1607072155411398743731060', 'MedicalOrganization', 'MedicalOrganization', '000020003200004', 3, 0, 'A medical organization (physical or not), such as hospital, institution or clinic.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731139', 'ID1607072155411398743731128', 'DiagnosticLab', 'DiagnosticLab', '00002000320000400001', 3, 0, 'A medical laboratory that offers on-site or off-site diagnostic services.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731266', 'ID1607072155411398743731128', 'Pharmacy', 'Pharmacy', '00002000320000400002', 3, 0, 'A pharmacy or drugstore.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731394', 'ID1607072155411398743731128', 'Physician', 'Physician', '00002000320000400003', 3, 0, 'A doctor\"s office.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731613', 'ID1607072155411398743731128', 'MedicalClinic', 'MedicalClinic', '00002000320000400004', 3, 0, 'A facility, often associated with a hospital or medical school, that is devoted to the specific diagnosis and/or healthcare. Previously limited to outpatients but with evolution it may be open to inpatients as well.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731633', 'ID1607072155411398743731128', 'VeterinaryCare', 'VeterinaryCare', '00002000320000400005', 3, 0, 'A vet\"s office.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731343', 'ID1607072155411398743731060', 'WorkersUnion', 'WorkersUnion', '000020003200005', 3, 0, 'A Workers Union (also known as a Labor Union, Labour Union, or Trade Union) is an organization that promotes the interests of its worker members by collectively bargaining with management, organizing, and political lobbying.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731427', 'ID1607072155411398743731060', 'SportsOrganization', 'SportsOrganization', '000020003200006', 3, 0, 'Represents the collection of all sports organizations, including sports teams, governing bodies, and sports associations.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731018', 'ID1607072155411398743731427', 'SportsTeam', 'SportsTeam', '00002000320000600001', 3, 0, 'Organization: Sports team.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731568', 'ID1607072155411398743731060', 'PerformingGroup', 'PerformingGroup', '000020003200007', 3, 0, 'A performance group, such as a band, an orchestra, or a circus.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731161', 'ID1607072155411398743731568', 'MusicGroup', 'MusicGroup', '00002000320000700001', 3, 0, 'A musical group, such as a band, an orchestra, or a choir. Can also be a solo musician.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731429', 'ID1607072155411398743731568', 'TheaterGroup', 'TheaterGroup', '00002000320000700002', 3, 0, 'A theater group or company, for example, the Royal Shakespeare Company or Druid Theatre.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731595', 'ID1607072155411398743731568', 'DanceGroup', 'DanceGroup', '00002000320000700003', 3, 0, 'A dance group&#x2014;for example, the Alvin Ailey Dance Theater or Riverdance.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731603', 'ID1607072155411398743731060', 'GovernmentOrganization', 'GovernmentOrganization', '000020003200008', 3, 0, 'A governmental organization or agency.');
INSERT INTO `tag_base_type` VALUES ('ID1607072155411398743731639', 'ID1607072155411398743731060', 'Corporation', 'Corporation', '000020003200009', 3, 0, 'Organization: A business corporation.');
INSERT INTO `tag_base_type` VALUES ('ID1709251503588982155402409', '-1', 'GY_Fund_Info', '测试增值用户信息', '00004', 3, 1, '');
INSERT INTO `tag_base_type` VALUES ('ID1709251511316996686509516', '-1', 'GY_Usr_Info', '用户信息测试', '00005', 3, 0, '');
INSERT INTO `tag_base_type` VALUES ('ID2112061703425286168665094', '-1', 'Address1', '地址2', '00006', 3, 0, '22222');

-- ----------------------------
-- Table structure for tag_base_type_field
-- ----------------------------
DROP TABLE IF EXISTS `tag_base_type_field`;
CREATE TABLE `tag_base_type_field`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '主键ID',
  `belongTypeId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `typeElementId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `selfTypeId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '自己的数据类型',
  `typeLength` int(0) NULL DEFAULT 0 COMMENT '属性数据类型长度',
  `typePrecision` int(0) NULL DEFAULT 0 COMMENT '属性数据类型精度',
  `isArray` int(0) NULL DEFAULT 0 COMMENT '是否是列表：0不是，1是',
  `isQuery` int(0) NULL DEFAULT NULL COMMENT '搜索时是否可查询：0不是，1是',
  `memo` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '说明',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK3B2904854A9D2FC2`(`belongTypeId`) USING BTREE,
  INDEX `FK3B290485BB62DC58`(`selfTypeId`) USING BTREE,
  INDEX `FK3B2904852A1FD210`(`typeElementId`) USING BTREE,
  INDEX `FK3B290485DADE459E`(`belongTypeId`) USING BTREE,
  INDEX `FK5D850D5B23A3F0C`(`selfTypeId`) USING BTREE,
  INDEX `FK5D850D5B2A1FD210`(`typeElementId`) USING BTREE,
  INDEX `FK5D850D5BEB418352`(`belongTypeId`) USING BTREE,
  INDEX `FKB7B5BEFE4603371A`(`belongTypeId`) USING BTREE,
  INDEX `FKB7B5BEFE74748F67`(`selfTypeId`) USING BTREE,
  INDEX `FKB7B5BEFEE30A7D7A`(`typeElementId`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '基础模型数据类型属性' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tag_base_type_field
-- ----------------------------
INSERT INTO `tag_base_type_field` VALUES ('ID1606041949399836771723189', 'ID1606041946579183194460162', 'ID1606041932435458734374230', 'ID1606041455442065173847803', 50, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606041950207442612316478', 'ID1606041946579183194460162', 'ID1606041932435458734374231', 'ID1606041455442065173847803', 50, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606041950417096316473949', 'ID1606041946579183194460162', 'ID1606041932435458734374232', 'ID1606041455442065173847803', 50, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606041950536537368480750', 'ID1606041946579183194460162', 'ID1606041932435458734374233', 'ID1606041455442065173847803', 50, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606041951454071384044756', 'ID1606041946579183194460162', 'ID1606041932435458734374234', 'ID1606041455442065173847803', 50, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606042100185394564269990', 'ID1606041548221626379288007', 'ID1606041932435458734374210', 'ID1606042059261072737209331', 1, 0, 0, 1, '1:男,2:女,3:未知');
INSERT INTO `tag_base_type_field` VALUES ('ID1606042354452656359583109', 'ID1606041548221626379288007', 'ID1606051119474914114550441', 'ID1606041946579183194460162', 0, 0, 1, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051121095537918753360', 'ID1606041946579183194460162', 'ID1606041932435458734374227', 'ID1606042059261072737209331', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606050028529194259926882', 'ID1606041548221626379288007', 'ID1606041932435458734374211', 'ID1606041442402757730621039', 11, 0, 0, 1, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051024210383754840909', 'ID1606041548221626379288007', 'ID1606041932435458734374201', 'ID1606041455442065173847803', 20, 0, 0, 1, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051028245183498166947', 'ID1606041548221626379288007', 'ID1606041932435458734374203', 'ID1606041455442065173847803', 10, 0, 0, 1, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051032255391871895924', 'ID1606051031275129305238240', 'ID1606041932435458734374205', 'ID1606042059261072737209331', 2, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051033546482212377108', 'ID1606051031275129305238240', 'ID1606041932435458734374206', 'ID1606041455442065173847803', 20, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051034558757682754095', 'ID1606051031275129305238240', 'ID1606041932435458734374207', 'ID1606041954092518736647987', 10, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051035070558372417120', 'ID1606051031275129305238240', 'ID1606041932435458734374208', 'ID1606041954092518736647987', 10, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051035201401750130393', 'ID1606051031275129305238240', 'ID1606041932435458734374209', 'ID1606041455442065173847803', 20, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051043591050174194615', 'ID1606041548221626379288007', 'ID1606051043348949309132887', 'ID1606051031275129305238240', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051044467217263220658', 'ID1606041548221626379288007', 'ID1606041932435458734374212', 'ID1606041954092518736647987', 10, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051045013708057533721', 'ID1606041548221626379288007', 'ID1606041932435458734374213', 'ID1606041954092518736647987', 10, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919387139', 'ID1606041548221626379288007', 'ID1606041932435458734374214', 'ID1606042059261072737209331', 10, 0, 0, 1, '00:未登记或拒绝登记,01:汉族,02:蒙古族,03:回族,04:维吾尔族,05:藏族,06:苗族,07:彝族,08:壮族,09:布依族,10:朝鲜族');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051370713178234790', 'ID1606041548221626379288007', 'ID1606041932435458734374215', 'ID1606042059261072737209331', 20, 0, 0, 1, 'CHN:中国');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051596183094998530', 'ID1606041548221626379288007', 'ID1606041932435458734374216', 'ID1606041946579183194460162', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051052279079129191258', 'ID1606041548221626379288007', 'ID1606041932435458734374217', 'ID1606041946579183194460162', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051055266529263681062', 'ID1606041548221626379288007', 'ID1606041932435458734374207', 'ID1606041954092518736647987', 10, 0, 0, 0, '客户生效日期');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051055473251460746058', 'ID1606041548221626379288007', 'ID1606041932435458734374208', 'ID1606041954092518736647987', 10, 0, 0, 0, '客户失效日期');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051056301239905923428', 'ID1606041548221626379288007', 'ID1606041932435458734374218', 'ID1606041455442065173847803', 20, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051059423857269858028', 'ID1606041548221626379288007', 'ID1606041932435458734374219', 'ID1606041455442065173847803', 20, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051059595255166190218', 'ID1606041548221626379288007', 'ID1606041932435458734374220', 'ID1606041455442065173847803', 20, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051100157591614416755', 'ID1606041548221626379288007', 'ID1606041932435458734374221', 'ID1606041455442065173847803', 20, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051100269830695682230', 'ID1606041548221626379288007', 'ID1606041932435458734374222', 'ID1606041455442065173847803', 20, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051100387957514786371', 'ID1606041548221626379288007', 'ID1606041932435458734374223', 'ID1606041455442065173847803', 20, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051108591498335772628', 'ID1606051104061710731316527', 'ID1606041932435458734374225', 'ID1606041455442065173847803', 20, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051109184516149336147', 'ID1606051104061710731316527', 'ID1606041932435458734374226', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051109505896903167023', 'ID1606051104061710731316527', 'ID1606041932435458734374207', 'ID1606041954092518736647987', 10, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051109589424444512940', 'ID1606051104061710731316527', 'ID1606041932435458734374208', 'ID1606041954092518736647987', 10, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051110377715191014644', 'ID1606051104061710731316527', 'ID1606041932435458734374224', 'ID1606042059261072737209331', 2, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051117270950373359052', 'ID1606041548221626379288007', 'ID1606051117025316411776731', 'ID1606051104061710731316527', 0, 0, 1, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051122228598021592898', 'ID1606041946579183194460162', 'ID1606041932435458734374228', 'ID1606041455442065173847803', 50, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051122519661496069656', 'ID1606041946579183194460162', 'ID1606041932435458734374229', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051134581217874269760', 'ID1606051134420268427414740', 'ID1606041932435458734374235', 'ID1606041455442065173847803', 10, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051135119877038888000', 'ID1606051134420268427414740', 'ID1606041932435458734374236', 'ID1606041954092518736647987', 10, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051135266696912532881', 'ID1606051134420268427414740', 'ID1606041932435458734374237', 'ID1606041455442065173847803', 20, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051135399461009661885', 'ID1606051134420268427414740', 'ID1606041932435458734374238', 'ID1606041455442065173847803', 10, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051135499908762680784', 'ID1606051134420268427414740', 'ID1606041932435458734374239', 'ID1606041455442065173847803', 20, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051136025025192785725', 'ID1606051134420268427414740', 'ID1606041932435458734374240', 'ID1606041455442065173847803', 20, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051136192315774044769', 'ID1606051134420268427414740', 'ID1606041932435458734374241', 'ID1606041455442065173847803', 20, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051142190789482876805', 'ID1606051134420268427414740', 'ID1606051141331033988092425', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606222241020847843183917', 'ID1606041948737864364386236', 'ID1606181217245345613434796', 'ID1606041455442065173847803', 64, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606181545352795326647520', 'ID1606181541470878270376768', 'ID1606041932435458734374242', 'ID1606042059261072737209331', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606181546078596577254596', 'ID1606181541470878270376768', 'ID1606041932435458734374243', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606181547145086524597869', 'ID1606181541470878270376768', 'ID1606041932435458734374244', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606181547420336378227683', 'ID1606181541470878270376768', 'ID1606041932435458734374246', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606181548113307118828841', 'ID1606181541470878270376768', 'ID1606041932435458734374247', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606181550056729052026285', 'ID1606181541470878270376768', 'ID1606041932435458734374248', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606181551305528515147032', 'ID1606181541470878270376768', 'ID1606041932435458734374245', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606181607212453040649677', 'ID1606181602079146917200087', 'ID1606041932435458734374250', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606181607525983980238789', 'ID1606181602079146917200087', 'ID1606041932435458734374257', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606181610491678154694426', 'ID1606181602079146917200087', 'ID1606051119474914114550441', 'ID1606041946579183194460162', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606181611368461426832602', 'ID1606181602079146917200087', 'ID1606041932435458734374251', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606181611480030849238775', 'ID1606181602079146917200087', 'ID1606041932435458734374252', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606181612110350131795317', 'ID1606181602079146917200087', 'ID1606041932435458734374258', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606181612283013396434682', 'ID1606181602079146917200087', 'ID1606041932435458734374259', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606181613067920490131669', 'ID1606181602079146917200087', 'ID1606041932435458734374255', 'ID1606042059261072737209331', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606181614580970869936874', 'ID1606181602079146917200087', 'ID1606041932435458734374256', 'ID1606042059261072737209331', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606181622524335166756876', 'ID1606181602079146917200087', 'ID1606041932435458734374253', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606181623067625875228319', 'ID1606181602079146917200087', 'ID1606041932435458734374254', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606181653109327472535537', 'ID1606041548221626379288007', 'ID1606181650134187851250251', 'ID1606181541470878270376768', 0, 0, 1, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606181653348551087886789', 'ID1606041548221626379288007', 'ID1606181652269278909303403', 'ID1606181602079146917200087', 0, 0, 1, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606182040414932095249479', 'ID1606182039439287874991318', 'ID1606041932435458734374264', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606182041226827580173649', 'ID1606182039439287874991318', 'ID1606041932435458734374265', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606191052251444877919292', 'ID1606182039439287874991318', 'ID1606041932435458734374266', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606191052487078851372230', 'ID1606182039439287874991318', 'ID1606041932435458734374267', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606191053096916332320448', 'ID1606182039439287874991318', 'ID1606041932435458734374268', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606191053351640329647796', 'ID1606182039439287874991318', 'ID1606041932435458734374269', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606191053537113220959688', 'ID1606182039439287874991318', 'ID1606041932435458734374270', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606191100364402273212088', 'ID1606191059443152359530333', 'ID1606051119474914114550441', 'ID1606041946579183194460162', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606191110410659576164077', 'ID1606182039439287874991318', 'ID1606041932435458734374273', 'ID1606041455442065173847803', 0, 0, 0, 0, '后续需要改成Organization这种复合属性');
INSERT INTO `tag_base_type_field` VALUES ('ID1606191127168813842925212', 'ID1606182039439287874991318', 'ID1606041932435458734374274', 'ID1606041455442065173847803', 0, 0, 0, 0, '后续需要修改成Organization这种复合属性');
INSERT INTO `tag_base_type_field` VALUES ('ID1606191128370714876795456', 'ID1606182039439287874991318', 'ID1606041932435458734374271', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606191129372913227526985', 'ID1606182039439287874991318', 'ID1606041932435458734374272', 'ID1606041954092518736647987', 0, 0, 0, 0, '最迟销户日期');
INSERT INTO `tag_base_type_field` VALUES ('ID1606191130201998291480202', 'ID1606182039439287874991318', 'ID1606041932435458734374275', 'ID1606041455442065173847803', 0, 0, 0, 0, '后续需要修改成Organization这种复合属性');
INSERT INTO `tag_base_type_field` VALUES ('ID1606191130335436177151546', 'ID1606182039439287874991318', 'ID1606041932435458734374276', 'ID1606041455442065173847803', 0, 0, 0, 0, '后续需要修改成Organization这种复合属性');
INSERT INTO `tag_base_type_field` VALUES ('ID1606191131234358260667911', 'ID1606182039439287874991318', 'ID1606041932435458734374278', 'ID1606041455258139966562852', 0, 0, 0, 0, '存款余额');
INSERT INTO `tag_base_type_field` VALUES ('ID1606191141552645451214370', 'ID1606191141228422698024569', 'ID1606041932435458734374264', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606191142297199244224166', 'ID1606191141228422698024569', 'ID1606041932435458734374265', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606191142488914258873782', 'ID1606191141228422698024569', 'ID1606041932435458734374266', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606191143098142104772307', 'ID1606191141228422698024569', 'ID1606191138354935015088932', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606191159007376664337932', 'ID1606191141228422698024569', 'ID1606041932435458734374278', 'ID1606041455258139966562852', 0, 0, 0, 0, '贷款余额');
INSERT INTO `tag_base_type_field` VALUES ('ID1606201957581433107670285', 'ID1606201956553617041953668', 'ID1606192314843784783743910', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为枚举类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606201958528464769344256', 'ID1606201956553617041953668', 'ID1606192314843784783743912', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606201959427844996851952', 'ID1606201956553617041953668', 'ID1606192314843784783743913', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为Organization类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606201959562226876970030', 'ID1606201956553617041953668', 'ID1606192314843784783743914', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202000170045330864410', 'ID1606201956553617041953668', 'ID1606192314843784783743915', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为Organization类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202001312708803119799', 'ID1606201956553617041953668', 'ID1606192314843784783743911', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为枚举类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202003282097924001142', 'ID1606201956553617041953668', 'ID1606192314843784783743916', 'ID1606041455258139966562852', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202003383032719433207', 'ID1606201956553617041953668', 'ID1606192314843784783743917', 'ID1606041455258139966562852', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202008585885866640719', 'ID1606202004471166250245553', 'ID1606192314843784783743910', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为枚举类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202010053082176665038', 'ID1606202004471166250245553', 'ID1606192314843784783743912', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202010271214401348675', 'ID1606202004471166250245553', 'ID1606192314843784783743913', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为Organization类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202010511216911304823', 'ID1606202004471166250245553', 'ID1606192314843784783743914', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202011253409564023306', 'ID1606202004471166250245553', 'ID1606192314843784783743915', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为Organization类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202012405602396815152', 'ID1606202004471166250245553', 'ID1606192314843784783743911', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为枚举类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202013075767896593747', 'ID1606202004471166250245553', 'ID1606192314843784783743916', 'ID1606041455258139966562852', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202013164203399973209', 'ID1606202004471166250245553', 'ID1606192314843784783743917', 'ID1606041455258139966562852', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202017334077545185846', 'ID1606202016475940462127132', 'ID1606192314843784783743910', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为枚举类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202017464239305618034', 'ID1606202016475940462127132', 'ID1606192314843784783743912', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202018036110470500912', 'ID1606202016475940462127132', 'ID1606192314843784783743913', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为Organization类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202018592370725771947', 'ID1606202016475940462127132', 'ID1606192314843784783743914', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202019162848098413187', 'ID1606202016475940462127132', 'ID1606192314843784783743915', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为Organization类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202019465971201764461', 'ID1606202016475940462127132', 'ID1606192314843784783743911', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为枚举类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202020032848227685442', 'ID1606202016475940462127132', 'ID1606192314843784783743916', 'ID1606041455258139966562852', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202020116916710192631', 'ID1606202016475940462127132', 'ID1606192314843784783743917', 'ID1606041455258139966562852', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202022517232007229377', 'ID1606202022174884784008287', 'ID1606192314843784783743910', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为枚举类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202023059115813085534', 'ID1606202022174884784008287', 'ID1606192314843784783743912', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202023354732446335057', 'ID1606202022174884784008287', 'ID1606192314843784783743913', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为Organization类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202023517393509451778', 'ID1606202022174884784008287', 'ID1606192314843784783743914', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202024044114956053611', 'ID1606202022174884784008287', 'ID1606192314843784783743915', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为Organization类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202024376461989864280', 'ID1606202022174884784008287', 'ID1606192314843784783743911', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为枚举类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202025366002220818351', 'ID1606202022174884784008287', 'ID1606192314843784783743916', 'ID1606041455258139966562852', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202025441942811957524', 'ID1606202022174884784008287', 'ID1606192314843784783743917', 'ID1606041455258139966562852', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202048173523350468169', 'ID1606202040497684955661032', 'ID1606192314843784783743919', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后改成枚举类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202049252128910679297', 'ID1606202040497684955661032', 'ID1606041932435458734374264', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202049568690089117715', 'ID1606202040497684955661032', 'ID1606041932435458734374266', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后改为枚举类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202051079166318209942', 'ID1606202040497684955661032', 'ID1606192314843784783743918', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为枚举类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202054056682541967583', 'ID1606202040497684955661032', 'ID1606192314843784783743913', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为Organization类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202054530599942963384', 'ID1606202040497684955661032', 'ID1606192314843784783743925', 'ID1606041455258139966562852', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202055160752779372614', 'ID1606202040497684955661032', 'ID1606041932435458734374278', 'ID1606041455258139966562852', 0, 0, 0, 0, '产品余额');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202057531080798670552', 'ID1606202056579829957769648', 'ID1606192314843784783743921', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202058019057058163060', 'ID1606202056579829957769648', 'ID1606192314843784783743922', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202058099689936558737', 'ID1606202056579829957769648', 'ID1606192314843784783743923', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202058176554074725654', 'ID1606202056579829957769648', 'ID1606192314843784783743924', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为枚举类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202059054681199896739', 'ID1606202056579829957769648', 'ID1606041932435458734374266', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为枚举类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202059423918736591952', 'ID1606202056579829957769648', 'ID1606192314843784783743913', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202100151885691242929', 'ID1606202056579829957769648', 'ID1606192314843784783743925', 'ID1606041455258139966562852', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202111405567790521096', 'ID1606202056579829957769648', 'ID1606041932435458734374278', 'ID1606041455258139966562852', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202126321923827580818', 'ID1606202126070676332333704', 'ID1606192314843784783743921', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202126430673892147481', 'ID1606202126070676332333704', 'ID1606192314843784783743922', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202126577082884462134', 'ID1606202126070676332333704', 'ID1606192314843784783743923', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202127223332031235328', 'ID1606202126070676332333704', 'ID1606041932435458734374266', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为枚举类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202132452122149398817', 'ID1606202126070676332333704', 'ID1606192314843784783743913', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为Organization类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202133071340259872511', 'ID1606202126070676332333704', 'ID1606041932435458734374268', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为枚举类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202134049003497410762', 'ID1606202126070676332333704', 'ID1606192314843784783743924', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为枚举类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202135233700803823775', 'ID1606202126070676332333704', 'ID1606192314843784783743926', 'ID1606041455258139966562852', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202142079079123113365', 'ID1606202140081398359294650', 'ID1606192314843784783743927', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202142226414235411887', 'ID1606202140081398359294650', 'ID1606192314843784783743928', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202142452201620764227', 'ID1606202140081398359294650', 'ID1606041932435458734374266', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为枚举类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202147482709666836597', 'ID1606202140081398359294650', 'ID1606192314843784783743929', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为Organization类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202206465032272701389', 'ID1606202140081398359294650', 'ID1606202206027830264746435', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为Organization类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202220411543221704700', 'ID1606202140081398359294650', 'ID1606202219418721354591235', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202221191547549211075', 'ID1606202140081398359294650', 'ID1606041932435458734374272', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202222365761606633042', 'ID1606202140081398359294650', 'ID1606041932435458734374278', 'ID1606041455258139966562852', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202225149388562082654', 'ID1606202224431876420829957', 'ID1606192314843784783743930', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202225291259904028616', 'ID1606202224431876420829957', 'ID1606192314843784783743931', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为Organization类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202225582193170630373', 'ID1606202224431876420829957', 'ID1606192314843784783743932', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为枚举类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202226075018493167848', 'ID1606202224431876420829957', 'ID1606192314843784783743934', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202226166268069358017', 'ID1606202224431876420829957', 'ID1606192314843784783743935', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202226560791644727645', 'ID1606202224431876420829957', 'ID1606192314843784783743933', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202227077832544626375', 'ID1606202224431876420829957', 'ID1606041932435458734374278', 'ID1606041455258139966562852', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202229473160218230317', 'ID1606202229281134126016397', 'ID1606192314843784783743930', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202230267859921412547', 'ID1606202229281134126016397', 'ID1606192314843784783743931', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为Organization类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202230426610142135450', 'ID1606202229281134126016397', 'ID1606192314843784783743932', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为枚举类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202230539890701216897', 'ID1606202229281134126016397', 'ID1606192314843784783743934', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202231041615341696428', 'ID1606202229281134126016397', 'ID1606192314843784783743935', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202231244421399162948', 'ID1606202229281134126016397', 'ID1606041932435458734374266', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为枚举类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202234203821020933206', 'ID1606202233501791543691591', 'ID1606041932435458734374266', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为枚举类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202234417578691195893', 'ID1606202233501791543691591', 'ID1606202206027830264746435', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为Organization类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202235175083371765125', 'ID1606202233501791543691591', 'ID1606192314843784783743936', 'ID1606041455258139966562852', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202237307595355971088', 'ID1606202233501791543691591', 'ID1606202237150874038562908', 'ID1606041455258139966562852', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202238431043730771653', 'ID1606202233501791543691591', 'ID1606202238307453082909695', 'ID1606041455258139966562852', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202240049026650270550', 'ID1606202233501791543691591', 'ID1606202239471525469499393', 'ID1606041455258139966562852', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202241410602016346217', 'ID1606202233501791543691591', 'ID1606202241272474728224869', 'ID1606041455258139966562852', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202243516084726958403', 'ID1606202233501791543691591', 'ID1606202243290772724802508', 'ID1606041455258139966562852', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202245176251407367750', 'ID1606202233501791543691591', 'ID1606202245031879802485398', 'ID1606041455258139966562852', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202247140166612997095', 'ID1606202233501791543691591', 'ID1606202246588132257793975', 'ID1606041455258139966562852', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202247217988935743662', 'ID1606202233501791543691591', 'ID1606041932435458734374278', 'ID1606041455258139966562852', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202248493458750690939', 'ID1606202233501791543691591', 'ID1606202248355338910183855', 'ID1606041455258139966562852', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202249352210939024694', 'ID1606202233501791543691591', 'ID1606202249219553478696522', 'ID1606041455258139966562852', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202251274105272715203', 'ID1606202251063780501817401', 'ID1606192314843784783743938', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202251486768318145648', 'ID1606202251063780501817401', 'ID1606192314843784783743939', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为Organization类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202252115355115671183', 'ID1606202251063780501817401', 'ID1606192314843784783743940', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为枚举类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202252403015255255946', 'ID1606202251063780501817401', 'ID1606192314843784783743941', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为枚举类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202255075388577740248', 'ID1606202251063780501817401', 'ID1606202254523972208718678', 'ID1606041455258139966562852', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202258024625644264090', 'ID1606202257362892545632833', 'ID1606192314843784783743942', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202258281498141163037', 'ID1606202257362892545632833', 'ID1606041932435458734374267', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为枚举类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202259059782809131380', 'ID1606202257362892545632833', 'ID1606041932435458734374266', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为枚举类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202259227135926563476', 'ID1606202257362892545632833', 'ID1606192314843784783743943', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202300102454512576448', 'ID1606202257362892545632833', 'ID1606041932435458734374268', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为枚举类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202300306678714545378', 'ID1606202257362892545632833', 'ID1606192314843784783743944', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为Organization类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202301409803458982964', 'ID1606202257362892545632833', 'ID1606192314843784783743945', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为枚举类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202302111520282744714', 'ID1606202257362892545632833', 'ID1606192314843784783743946', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202302181992062856764', 'ID1606202257362892545632833', 'ID1606192314843784783743947', 'ID1606041455258139966562852', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202304198885401233857', 'ID1606202304011389502180610', 'ID1606192314843784783743942', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202304384208762908556', 'ID1606202304011389502180610', 'ID1606041932435458734374267', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为枚举类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202304593586658796218', 'ID1606202304011389502180610', 'ID1606041932435458734374266', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为枚举类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202306052809132439024', 'ID1606202304011389502180610', 'ID1606192314843784783743943', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202306389212448575721', 'ID1606202304011389502180610', 'ID1606041932435458734374268', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为枚举类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202307163284076798219', 'ID1606202304011389502180610', 'ID1606192314843784783743944', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为Organization类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202307278918214523115', 'ID1606202304011389502180610', 'ID1606192314843784783743945', 'ID1606041455442065173847803', 0, 0, 0, 0, '以后修改为枚举类型');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202307359221805260856', 'ID1606202304011389502180610', 'ID1606192314843784783743946', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606202307445941190283155', 'ID1606202304011389502180610', 'ID1606192314843784783743947', 'ID1606041455258139966562852', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606222048115185823818535', 'ID1606041548221626379288007', 'ID1606222039393396027239495', 'ID1606182039439287874991318', 0, 0, 1, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606222048485187096932537', 'ID1606041548221626379288007', 'ID1606222040104185204830178', 'ID1606191141228422698024569', 0, 0, 1, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606222049478476735803603', 'ID1606041548221626379288007', 'ID1606222040380127910346753', 'ID1606201956553617041953668', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606222051536920629144093', 'ID1606041548221626379288007', 'ID1606222041114038447455289', 'ID1606202004471166250245553', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606222052151151096684095', 'ID1606041548221626379288007', 'ID1606222041426061756661260', 'ID1606202016475940462127132', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606222054028502435289130', 'ID1606041548221626379288007', 'ID1606222042164046802738821', 'ID1606202022174884784008287', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606222054249765739091694', 'ID1606041548221626379288007', 'ID1606222042409515635051548', 'ID1606202040497684955661032', 0, 0, 1, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606222054454766887596520', 'ID1606041548221626379288007', 'ID1606222043051081426537090', 'ID1606202056579829957769648', 0, 0, 1, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606222055054766239979923', 'ID1606041548221626379288007', 'ID1606222043336240164066664', 'ID1606202126070676332333704', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606222055291337663292343', 'ID1606041548221626379288007', 'ID1606222043579053460986728', 'ID1606202140081398359294650', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606222056030080409481142', 'ID1606041548221626379288007', 'ID1606222044164053222208225', 'ID1606202224431876420829957', 0, 0, 1, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606222056288529579259814', 'ID1606041548221626379288007', 'ID1606222044322186558932779', 'ID1606202229281134126016397', 0, 0, 1, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606222058272290199300172', 'ID1606041548221626379288007', 'ID1606222057547918677056571', 'ID1606202233501791543691591', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606222058471041194320915', 'ID1606041548221626379288007', 'ID1606222045129690746631461', 'ID1606202251063780501817401', 0, 0, 1, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606222059069646496553009', 'ID1606041548221626379288007', 'ID1606222045352194371235183', 'ID1606202257362892545632833', 0, 0, 1, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606222059235582008122077', 'ID1606041548221626379288007', 'ID1606222046266889631640601', 'ID1606202304011389502180610', 0, 0, 1, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381001', 'ID1607072155411398743731082', 'ID1607072311435458734371001', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381002', 'ID1607072155411398743731210', 'ID1607072311435458734371002', 'ID1607072155411398743731036', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381003', 'ID1607072155411398743731231', 'ID1607072311435458734371003', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381004', 'ID1607072155411398743731106', 'ID1607072311435458734371004', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381005', 'ID1607072155411398743731445', 'ID1607072311435458734371004', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381006', 'ID1607072155411398743731004', 'ID1607072311435458734371005', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381007', 'ID1607072155411398743731625', 'ID1607072311435458734371006', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381008', 'ID1607072155411398743731403', 'ID1607072311435458734371007', 'ID1607072155411398743731577', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381009', 'ID1607072155411398743731057', 'ID1607072311435458734371008', 'ID1606072147401110292952758', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381010', 'ID1607072155411398743731531', 'ID1607072311435458734371009', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381011', 'ID1607072155411398743731318', 'ID1607072311435458734371009', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381012', 'ID1607072155411398743731029', 'ID1607072311435458734371009', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381013', 'ID1607072155411398743731145', 'ID1607072311435458734371009', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381014', 'ID1607072155411398743731612', 'ID1607072311435458734371009', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381015', 'ID1607072155411398743731053', 'ID1607072311435458734371009', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381016', 'ID1607072155411398743731126', 'ID1607072311435458734371009', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381017', 'ID1607072155411398743731228', 'ID1607072311435458734371009', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381018', 'ID1607072155411398743731065', 'ID1607072311435458734371009', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381019', 'ID1607072155411398743731130', 'ID1607072311435458734371010', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381020', 'ID1607072155411398743731515', 'ID1607072311435458734371010', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381021', 'ID1607072155411398743731515', 'ID1607072311435458734371011', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381022', 'ID1607072155411398743731090', 'ID1607072311435458734371011', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381023', 'ID1607072155411398743731145', 'ID1607072311435458734371012', 'ID1606041948737864364386236', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381024', 'ID1607072155411398743731116', 'ID1607072311435458734371012', 'ID1606041948737864364386236', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381025', 'ID1607072155411398743731408', 'ID1607072311435458734371013', 'ID1607072155411398743731161', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381026', 'ID1607072155411398743731067', 'ID1607072311435458734371013', 'ID1607072155411398743731161', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381027', 'ID1607072155411398743731612', 'ID1607072311435458734371014', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381028', 'ID1607072155411398743731152', 'ID1607072311435458734371015', 'ID1607072155411398743731577', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381029', 'ID1607072155411398743731355', 'ID1607072311435458734371016', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381030', 'ID1607072155411398743731281', 'ID1607072311435458734371017', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381031', 'ID1607072155411398743731060', 'ID1607072311435458734371018', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381032', 'ID1607072155411398743731160', 'ID1607072311435458734371018', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381033', 'ID1607072155411398743731350', 'ID1607072311435458734371018', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381034', 'ID1606041548221626379288007', 'ID1607072311435458734371018', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381035', 'ID1607072155411398743731175', 'ID1607072311435458734371019', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381036', 'ID1607072155411398743731444', 'ID1607072311435458734371020', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381037', 'ID1606041548221626379288007', 'ID1607072311435458734371021', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381038', 'ID1607072155411398743731060', 'ID1607072311435458734371021', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381039', 'ID1607072155411398743731530', 'ID1607072311435458734371022', 'ID1607072155411398743731136', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381040', 'ID1607072155411398743731362', 'ID1607072311435458734371023', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381041', 'ID1607072155411398743731228', 'ID1607072311435458734371024', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381042', 'ID1607072155411398743731610', 'ID1607072311435458734371025', 'ID1607072155411398743731009', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381043', 'ID1607072155411398743731444', 'ID1607072311435458734371026', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381044', 'ID1607072155411398743731028', 'ID1607072311435458734371026', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381045', 'ID1607072155411398743731043', 'ID1607072311435458734371026', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381046', 'ID1607072155411398743731388', 'ID1607072311435458734371027', 'ID1607072155411398743731393', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381047', 'ID1607072155411398743731449', 'ID1607072311435458734371028', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381048', 'ID1607072155411398743731256', 'ID1607072311435458734371029', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381049', 'ID1607072155411398743731256', 'ID1607072311435458734371030', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381050', 'ID1606041548221626379288007', 'ID1607072311435458734371031', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381051', 'ID1607072155411398743731350', 'ID1607072311435458734371031', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381052', 'ID1607072155411398743731060', 'ID1607072311435458734371031', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381053', 'ID1607072155411398743731268', 'ID1607072311435458734371032', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381054', 'ID1607072155411398743731559', 'ID1607072311435458734371033', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381055', 'ID1607072155411398743731519', 'ID1607072311435458734371034', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381056', 'ID1606041948737864364386236', 'ID1607072311435458734371035', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381057', 'ID1607072155411398743731556', 'ID1607072311435458734371036', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381058', 'ID1607072155411398743731025', 'ID1607072311435458734371036', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381059', 'ID1607072155411398743731332', 'ID1607072311435458734371036', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381060', 'ID1607072155411398743731242', 'ID1607072311435458734371037', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381061', 'ID1607072155411398743731243', 'ID1607072311435458734371037', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381062', 'ID1607072155411398743731208', 'ID1607072311435458734371038', 'ID1607072155411398743731444', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381063', 'ID1607072155411398743731584', 'ID1607072311435458734371038', 'ID1607072155411398743731444', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381064', 'ID1607072155411398743731272', 'ID1607072311435458734371038', 'ID1607072155411398743731444', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381065', 'ID1607072155411398743731347', 'ID1607072311435458734371039', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381066', 'ID1607072155411398743731362', 'ID1607072311435458734371039', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381067', 'ID1607072155411398743731283', 'ID1607072311435458734371040', 'ID1607072155411398743731403', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381068', 'ID1607072155411398743731499', 'ID1607072311435458734371040', 'ID1607072155411398743731403', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381069', 'ID1607072155411398743731354', 'ID1607072311435458734371041', 'ID1607072155411398743731479', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381070', 'ID1607072155411398743731203', 'ID1607072311435458734371041', 'ID1607072155411398743731479', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381071', 'ID1607072155411398743731043', 'ID1607072311435458734371042', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381072', 'ID1607072155411398743731004', 'ID1607072311435458734371042', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381073', 'ID1607072155411398743731521', 'ID1607072311435458734371043', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381074', 'ID1607072155411398743731203', 'ID1607072311435458734371044', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381075', 'ID1607072155411398743731449', 'ID1607072311435458734371045', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381076', 'ID1607072155411398743731014', 'ID1607072311435458734371046', 'ID1607072155411398743731565', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381077', 'ID1607072155411398743731444', 'ID1607072311435458734371047', 'ID1607072155411398743731444', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381078', 'ID1607072155411398743731215', 'ID1607072311435458734371048', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381079', 'ID1607072155411398743731185', 'ID1607072311435458734371049', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381080', 'ID1607072155411398743731516', 'ID1607072311435458734371050', 'ID1607072155411398743731072', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381081', 'ID1606041948737864364386236', 'ID1606041932435458734374202', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381082', 'ID1607072155411398743731530', 'ID1607072311435458734371052', 'ID1607072155411398743731018', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381083', 'ID1607072155411398743731332', 'ID1607072311435458734371053', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381084', 'ID1607072155411398743731025', 'ID1607072311435458734371053', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381085', 'ID1607072155411398743731559', 'ID1607072311435458734371053', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381086', 'ID1607072155411398743731556', 'ID1607072311435458734371053', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381087', 'ID1607072155411398743731271', 'ID1607072311435458734371054', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381088', 'ID1607072155411398743731362', 'ID1607072311435458734371055', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381089', 'ID1607072155411398743731442', 'ID1607072311435458734371056', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381090', 'ID1607072155411398743731543', 'ID1607072311435458734371057', 'ID1607072155411398743731141', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381091', 'ID1607072155411398743731437', 'ID1607072311435458734371058', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381092', 'ID1607072155411398743731418', 'ID1607072311435458734371059', 'ID1607072155411398743731446', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381093', 'ID1607072155411398743731339', 'ID1607072311435458734371060', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381094', 'ID1607072155411398743731318', 'ID1607072311435458734371061', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381095', 'ID1607072155411398743731029', 'ID1607072311435458734371061', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381096', 'ID1607072155411398743731531', 'ID1607072311435458734371061', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381097', 'ID1607072155411398743731228', 'ID1607072311435458734371061', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381098', 'ID1607072155411398743731065', 'ID1607072311435458734371061', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381099', 'ID1607072155411398743731612', 'ID1607072311435458734371061', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381100', 'ID1607072155411398743731126', 'ID1607072311435458734371061', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381101', 'ID1607072155411398743731053', 'ID1607072311435458734371061', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381102', 'ID1607072155411398743731145', 'ID1607072311435458734371061', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381103', 'ID1607072155411398743731126', 'ID1607072311435458734371062', 'ID1607072155411398743731228', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381104', 'ID1607072155411398743731145', 'ID1607072311435458734371062', 'ID1607072155411398743731228', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381105', 'ID1607072155411398743731318', 'ID1607072311435458734371062', 'ID1607072155411398743731228', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381106', 'ID1607072155411398743731065', 'ID1607072311435458734371062', 'ID1607072155411398743731228', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381107', 'ID1607072155411398743731177', 'ID1607072311435458734371062', 'ID1607072155411398743731228', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381108', 'ID1607072155411398743731531', 'ID1607072311435458734371062', 'ID1607072155411398743731228', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381109', 'ID1607072155411398743731053', 'ID1607072311435458734371062', 'ID1607072155411398743731228', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381110', 'ID1607072155411398743731029', 'ID1607072311435458734371062', 'ID1607072155411398743731228', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381111', 'ID1607072155411398743731381', 'ID1607072311435458734371063', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381112', 'ID1607072155411398743731157', 'ID1607072311435458734371064', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381113', 'ID1607072155411398743731559', 'ID1607072311435458734371065', 'ID1606072147401110292952758', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381114', 'ID1607072155411398743731193', 'ID1607072311435458734371066', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381115', 'ID1607072155411398743731318', 'ID1607072311435458734371067', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381116', 'ID1607072155411398743731065', 'ID1607072311435458734371067', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381117', 'ID1607072155411398743731531', 'ID1607072311435458734371067', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381118', 'ID1607072155411398743731029', 'ID1607072311435458734371067', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381119', 'ID1607072155411398743731228', 'ID1607072311435458734371067', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381120', 'ID1607072155411398743731145', 'ID1607072311435458734371067', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381121', 'ID1607072155411398743731177', 'ID1607072311435458734371067', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381122', 'ID1607072155411398743731612', 'ID1607072311435458734371067', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381123', 'ID1607072155411398743731597', 'ID1607072311435458734371067', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381124', 'ID1607072155411398743731053', 'ID1607072311435458734371067', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381125', 'ID1607072155411398743731126', 'ID1607072311435458734371067', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381126', 'ID1607072155411398743731521', 'ID1607072311435458734371068', 'ID1607072155411398743731521', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381127', 'ID1607072155411398743731190', 'ID1607072311435458734371069', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381128', 'ID1607072155411398743731371', 'ID1607072311435458734371070', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381129', 'ID1607072155411398743731070', 'ID1607072311435458734371071', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381130', 'ID1607072155411398743731482', 'ID1607072311435458734371071', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381131', 'ID1607072155411398743731242', 'ID1607072311435458734371071', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381132', 'ID1607072155411398743731062', 'ID1607072311435458734371071', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381133', 'ID1607072155411398743731265', 'ID1607072311435458734371071', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381134', 'ID1607072155411398743731354', 'ID1607072311435458734371071', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381135', 'ID1607072155411398743731267', 'ID1607072311435458734371071', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381136', 'ID1607072155411398743731045', 'ID1607072311435458734371072', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381137', 'ID1607072155411398743731362', 'ID1607072311435458734371073', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381138', 'ID1607072155411398743731390', 'ID1606041932435458734374251', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381139', 'ID1607072155411398743731453', 'ID1606041932435458734374251', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381140', 'ID1607072155411398743731177', 'ID1606041932435458734374251', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381141', 'ID1607072155411398743731597', 'ID1606041932435458734374251', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381142', 'ID1607072155411398743731254', 'ID1606041932435458734374251', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381143', 'ID1607072155411398743731521', 'ID1607072311435458734371075', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381144', 'ID1607072155411398743731354', 'ID1607072311435458734371076', 'ID1607072155411398743731354', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381145', 'ID1607072155411398743731070', 'ID1607072311435458734371076', 'ID1607072155411398743731354', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381146', 'ID1607072155411398743731028', 'ID1607072311435458734371077', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381147', 'ID1607072155411398743731242', 'ID1607072311435458734371078', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381148', 'ID1607072155411398743731243', 'ID1607072311435458734371078', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381149', 'ID1607072155411398743731022', 'ID1607072311435458734371078', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381150', 'ID1607072155411398743731444', 'ID1607072311435458734371079', 'ID1606072147401110292952758', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381151', 'ID1607072155411398743731043', 'ID1607072311435458734371079', 'ID1606072147401110292952758', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381152', 'ID1607072155411398743731114', 'ID1607072311435458734371080', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381153', 'ID1607072155411398743731281', 'ID1607072311435458734371080', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381154', 'ID1607072155411398743731408', 'ID1607072311435458734371081', 'ID1607072155411398743731067', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381155', 'ID1607072155411398743731029', 'ID1607072311435458734371082', 'ID1607072155411398743731093', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381156', 'ID1607072155411398743731106', 'ID1607072311435458734371082', 'ID1607072155411398743731093', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381157', 'ID1607072155411398743731314', 'ID1607072311435458734371082', 'ID1607072155411398743731093', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381158', 'ID1607072155411398743731530', 'ID1607072311435458734371083', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381159', 'ID1607072155411398743731187', 'ID1607072311435458734371084', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381160', 'ID1607072155411398743731642', 'ID1607072311435458734371085', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381161', 'ID1607072155411398743731449', 'ID1607072311435458734371086', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381162', 'ID1607072155411398743731136', 'ID1607072311435458734371087', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381163', 'ID1607072155411398743731062', 'ID1607072311435458734371088', 'ID1607072155411398743731036', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381164', 'ID1607072155411398743731242', 'ID1607072311435458734371089', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381165', 'ID1607072155411398743731243', 'ID1607072311435458734371089', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381166', 'ID1607072155411398743731514', 'ID1607072311435458734371090', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381167', 'ID1607072155411398743731362', 'ID1607072311435458734371091', 'ID1607072155411398743731362', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381168', 'ID1607072155411398743731559', 'ID1607072311435458734371092', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381169', 'ID1607072155411398743731362', 'ID1607072311435458734371093', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381170', 'ID1606041548221626379288007', 'ID1607072311435458734371094', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381171', 'ID1607072155411398743731449', 'ID1607072311435458734371095', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381172', 'ID1607072155411398743731354', 'ID1607072311435458734371096', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381173', 'ID1607072155411398743731242', 'ID1607072311435458734371096', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381174', 'ID1607072155411398743731243', 'ID1607072311435458734371096', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381175', 'ID1606041548221626379288007', 'ID1607072311435458734371097', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381176', 'ID1607072155411398743731295', 'ID1607072311435458734371098', 'ID1607072155411398743731295', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381177', 'ID1607072155411398743731530', 'ID1607072311435458734371099', 'ID1607072155411398743731210', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381178', 'ID1607072155411398743731362', 'ID1607072311435458734371100', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381179', 'ID1607072155411398743731161', 'ID1607072311435458734371100', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381180', 'ID1607072155411398743731379', 'ID1607072311435458734371101', 'ID1606041948737864364386236', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381181', 'ID1607072155411398743731463', 'ID1607072311435458734371102', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381182', 'ID1607072155411398743731062', 'ID1607072311435458734371102', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381183', 'ID1607072155411398743731070', 'ID1607072311435458734371103', 'ID1607072155411398743731461', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381184', 'ID1607072155411398743731219', 'ID1607072311435458734371104', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381185', 'ID1607072155411398743731522', 'ID1607072311435458734371105', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381186', 'ID1607072155411398743731449', 'ID1607072311435458734371106', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381187', 'ID1607072155411398743731449', 'ID1607072311435458734371107', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381188', 'ID1607072155411398743731242', 'ID1607072311435458734371108', 'ID1607072155411398743731242', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381189', 'ID1607072155411398743731242', 'ID1607072311435458734371109', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381190', 'ID1607072155411398743731354', 'ID1607072311435458734371109', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381191', 'ID1607072155411398743731243', 'ID1607072311435458734371109', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381192', 'ID1607072155411398743731455', 'ID1607072311435458734371110', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381193', 'ID1607072155411398743731391', 'ID1607072311435458734371110', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381194', 'ID1606041946579183194460162', 'ID1607072311435458734371110', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381195', 'ID1606041548221626379288007', 'ID1607072311435458734371111', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381196', 'ID1607072155411398743731060', 'ID1607072311435458734371111', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381197', 'ID1607072155411398743731328', 'ID1607072311435458734371112', 'ID1607072155411398743731590', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381198', 'ID1607072155411398743731530', 'ID1607072311435458734371113', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381199', 'ID1607072155411398743731554', 'ID1607072311435458734371113', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381200', 'ID1607072155411398743731606', 'ID1607072311435458734371113', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381201', 'ID1607072155411398743731229', 'ID1607072311435458734371113', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381202', 'ID1607072155411398743731358', 'ID1607072311435458734371114', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381203', 'ID1607072155411398743731262', 'ID1607072311435458734371114', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381204', 'ID1607072155411398743731286', 'ID1607072311435458734371114', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381205', 'ID1607072155411398743731333', 'ID1607072311435458734371114', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381207', 'ID1607072155411398743731371', 'ID1607072311435458734371116', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381208', 'ID1607072155411398743731362', 'ID1607072311435458734371117', 'ID1607072155411398743731345', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381209', 'ID1607072155411398743731485', 'ID1607072311435458734371117', 'ID1607072155411398743731345', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381210', 'ID1607072155411398743731354', 'ID1607072311435458734371117', 'ID1607072155411398743731345', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381211', 'ID1607072155411398743731060', 'ID1607072311435458734371117', 'ID1607072155411398743731345', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381212', 'ID1607072155411398743731350', 'ID1607072311435458734371117', 'ID1607072155411398743731345', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381213', 'ID1607072155411398743731070', 'ID1607072311435458734371117', 'ID1607072155411398743731345', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381214', 'ID1607072155411398743731242', 'ID1607072311435458734371117', 'ID1607072155411398743731345', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381215', 'ID1607072155411398743731597', 'ID1607072311435458734371117', 'ID1607072155411398743731345', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381216', 'ID1607072155411398743731625', 'ID1607072311435458734371118', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381217', 'ID1607072155411398743731444', 'ID1607072311435458734371119', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381218', 'ID1607072155411398743731340', 'ID1607072311435458734371120', 'ID1607072155411398743731160', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381219', 'ID1606041548221626379288007', 'ID1607072311435458734371120', 'ID1607072155411398743731160', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381220', 'ID1607072155411398743731060', 'ID1607072311435458734371120', 'ID1607072155411398743731160', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381221', 'ID1607072155411398743731362', 'ID1607072311435458734371121', 'ID1607072155411398743731362', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381222', 'ID1607072155411398743731536', 'ID1607072311435458734371122', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381223', 'ID1607072155411398743731284', 'ID1607072311435458734371123', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381224', 'ID1607072155411398743731062', 'ID1607072311435458734371124', 'ID1607072155411398743731463', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381225', 'ID1607072155411398743731417', 'ID1607072311435458734371125', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381226', 'ID1607072155411398743731208', 'ID1607072311435458734371126', 'ID1607072155411398743731533', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381227', 'ID1607072155411398743731070', 'ID1607072311435458734371127', 'ID1607072155411398743731354', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381228', 'ID1607072155411398743731354', 'ID1607072311435458734371127', 'ID1607072155411398743731354', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381229', 'ID1607072155411398743731597', 'ID1607072311435458734371128', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381230', 'ID1607072155411398743731362', 'ID1607072311435458734371129', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381231', 'ID1607072155411398743731043', 'ID1607072311435458734371130', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381232', 'ID1607072155411398743731354', 'ID1607072311435458734371130', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381233', 'ID1607072155411398743731444', 'ID1607072311435458734371130', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381234', 'ID1607072155411398743731281', 'ID1607072311435458734371131', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381235', 'ID1607072155411398743731008', 'ID1607072311435458734371132', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381236', 'ID1607072155411398743731090', 'ID1607072311435458734371133', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381237', 'ID1607072155411398743731601', 'ID1607072311435458734371134', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381238', 'ID1607072155411398743731090', 'ID1607072311435458734371135', 'ID1606041948737864364386236', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381239', 'ID1607072155411398743731597', 'ID1607072311435458734371136', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381240', 'ID1607072155411398743731362', 'ID1607072311435458734371136', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381241', 'ID1607072155411398743731126', 'ID1607072311435458734371137', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381242', 'ID1607072155411398743731053', 'ID1607072311435458734371137', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381243', 'ID1607072155411398743731531', 'ID1607072311435458734371137', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381244', 'ID1607072155411398743731612', 'ID1607072311435458734371137', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381245', 'ID1607072155411398743731145', 'ID1607072311435458734371137', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381246', 'ID1607072155411398743731177', 'ID1607072311435458734371137', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381247', 'ID1607072155411398743731065', 'ID1607072311435458734371137', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381248', 'ID1607072155411398743731228', 'ID1607072311435458734371137', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381249', 'ID1607072155411398743731029', 'ID1607072311435458734371137', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381250', 'ID1607072155411398743731597', 'ID1607072311435458734371137', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381251', 'ID1607072155411398743731318', 'ID1607072311435458734371137', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381252', 'ID1606041548221626379288007', 'ID1607072311435458734371138', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381253', 'ID1607072155411398743731109', 'ID1607072311435458734371139', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381254', 'ID1607072155411398743731060', 'ID1607072311435458734371139', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381255', 'ID1607072155411398743731544', 'ID1607072311435458734371140', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381256', 'ID1607072155411398743731109', 'ID1607072311435458734371141', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381257', 'ID1606041548221626379288007', 'ID1607072311435458734371142', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381258', 'ID1607072155411398743731318', 'ID1607072311435458734371143', 'ID1607072155411398743731339', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381259', 'ID1607072155411398743731004', 'ID1607072311435458734371144', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381260', 'ID1607072155411398743731060', 'ID1607072311435458734371145', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381261', 'ID1607072155411398743731362', 'ID1607072311435458734371145', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381262', 'ID1606041548221626379288007', 'ID1607072311435458734371145', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381263', 'ID1607072155411398743731354', 'ID1607072311435458734371145', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381264', 'ID1607072155411398743731450', 'ID1607072311435458734371146', 'ID1607072155411398743731194', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381265', 'ID1607072155411398743731341', 'ID1607072311435458734371147', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381266', 'ID1607072155411398743731185', 'ID1607072311435458734371148', 'ID1606072147401110292952758', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381267', 'ID1607072155411398743731146', 'ID1607072311435458734371148', 'ID1606072147401110292952758', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381268', 'ID1607072155411398743731580', 'ID1607072311435458734371149', 'ID1607072155411398743731542', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381269', 'ID1607072155411398743731258', 'ID1607072311435458734371150', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381270', 'ID1607072155411398743731362', 'ID1607072311435458734371151', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381271', 'ID1607072155411398743731062', 'ID1607072311435458734371152', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381272', 'ID1607072155411398743731463', 'ID1607072311435458734371152', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381273', 'ID1607072155411398743731191', 'ID1607072311435458734371153', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381274', 'ID1607072155411398743731271', 'ID1607072311435458734371154', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381275', 'ID1607072155411398743731556', 'ID1607072311435458734371155', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381276', 'ID1607072155411398743731243', 'ID1607072311435458734371155', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381277', 'ID1607072155411398743731407', 'ID1607072311435458734371155', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381278', 'ID1607072155411398743731246', 'ID1607072311435458734371155', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381279', 'ID1607072155411398743731217', 'ID1607072311435458734371155', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381280', 'ID1607072155411398743731242', 'ID1607072311435458734371155', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381281', 'ID1607072155411398743731177', 'ID1607072311435458734371156', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381282', 'ID1607072155411398743731358', 'ID1607072311435458734371157', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381283', 'ID1607072155411398743731262', 'ID1607072311435458734371157', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381284', 'ID1607072155411398743731286', 'ID1607072311435458734371157', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381285', 'ID1607072155411398743731333', 'ID1607072311435458734371157', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381286', 'ID1607072155411398743731625', 'ID1607072311435458734371158', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381287', 'ID1606041548221626379288007', 'ID1607072311435458734371159', 'ID1607072155411398743731243', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381288', 'ID1607072155411398743731060', 'ID1607072311435458734371159', 'ID1607072155411398743731243', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381289', 'ID1607072155411398743731362', 'ID1607072311435458734371160', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381290', 'ID1607072155411398743731362', 'ID1607072311435458734371161', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381291', 'ID1607072155411398743731437', 'ID1607072311435458734371162', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381292', 'ID1607072155411398743731463', 'ID1607072311435458734371163', 'ID1607072155411398743731062', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381293', 'ID1607072155411398743731449', 'ID1607072311435458734371164', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381294', 'ID1607072155411398743731033', 'ID1607072311435458734371165', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381295', 'ID1607072155411398743731506', 'ID1607072311435458734371166', 'ID1607072155411398743731625', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381296', 'ID1607072155411398743731449', 'ID1607072311435458734371167', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381297', 'ID1607072155411398743731141', 'ID1607072311435458734371168', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381298', 'ID1607072155411398743731242', 'ID1607072311435458734371168', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381299', 'ID1607072155411398743731506', 'ID1607072311435458734371168', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381300', 'ID1607072155411398743731246', 'ID1607072311435458734371168', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381301', 'ID1607072155411398743731597', 'ID1607072311435458734371169', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381302', 'ID1607072155411398743731013', 'ID1607072311435458734371170', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381303', 'ID1607072155411398743731222', 'ID1607072311435458734371170', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381304', 'ID1607072155411398743731203', 'ID1607072311435458734371171', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381305', 'ID1607072155411398743731501', 'ID1607072311435458734371171', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381306', 'ID1607072155411398743731113', 'ID1607072311435458734371171', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381307', 'ID1607072155411398743731145', 'ID1607072311435458734371172', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381308', 'ID1607072155411398743731318', 'ID1607072311435458734371172', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381309', 'ID1607072155411398743731577', 'ID1607072311435458734371173', 'ID1607072155411398743731208', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381310', 'ID1607072155411398743731382', 'ID1607072311435458734371173', 'ID1607072155411398743731208', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381311', 'ID1607072155411398743731403', 'ID1607072311435458734371173', 'ID1607072155411398743731208', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381312', 'ID1606041548221626379288007', 'ID1607072311435458734371174', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381313', 'ID1607072155411398743731521', 'ID1607072311435458734371175', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381314', 'ID1607072155411398743731444', 'ID1607072311435458734371176', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381315', 'ID1607072155411398743731043', 'ID1607072311435458734371176', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381316', 'ID1607072155411398743731274', 'ID1607072311435458734371177', 'ID1607072155411398743731093', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381317', 'ID1607072155411398743731362', 'ID1607072311435458734371177', 'ID1607072155411398743731093', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381318', 'ID1607072155411398743731597', 'ID1607072311435458734371177', 'ID1607072155411398743731093', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381319', 'ID1607072155411398743731050', 'ID1607072311435458734371177', 'ID1607072155411398743731093', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381320', 'ID1607072155411398743731544', 'ID1607072311435458734371177', 'ID1607072155411398743731093', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381321', 'ID1607072155411398743731449', 'ID1607072311435458734371178', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381322', 'ID1607072155411398743731203', 'ID1607072311435458734371179', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381323', 'ID1607072155411398743731208', 'ID1607072311435458734371180', 'ID1607072155411398743731403', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381324', 'ID1607072155411398743731482', 'ID1607072311435458734371180', 'ID1607072155411398743731403', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381325', 'ID1607072155411398743731362', 'ID1607072311435458734371181', 'ID1607072155411398743731362', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381326', 'ID1607072155411398743731362', 'ID1607072311435458734371183', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381327', 'ID1607072155411398743731070', 'ID1607072311435458734371184', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381328', 'ID1607072155411398743731161', 'ID1607072311435458734371185', 'ID1607072155411398743731067', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381329', 'ID1607072155411398743731002', 'ID1607072311435458734371186', 'ID1606072147401110292952758', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381330', 'ID1607072155411398743731444', 'ID1607072311435458734371187', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381331', 'ID1607072155411398743731228', 'ID1607072311435458734371188', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381332', 'ID1607072155411398743731082', 'ID1607072311435458734371188', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381333', 'ID1607072155411398743731362', 'ID1607072311435458734371189', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381334', 'ID1607072155411398743731407', 'ID1607072311435458734371190', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381335', 'ID1607072155411398743731506', 'ID1607072311435458734371190', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381336', 'ID1607072155411398743731057', 'ID1607072311435458734371191', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381337', 'ID1607072155411398743731231', 'ID1607072311435458734371192', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381338', 'ID1607072155411398743731362', 'ID1607072311435458734371192', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381339', 'ID1606041948737864364386236', 'ID1607072311435458734371193', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381340', 'ID1607072155411398743731362', 'ID1607072311435458734371055', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381341', 'ID1607072155411398743731229', 'ID1607072311435458734371195', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381342', 'ID1607072155411398743731530', 'ID1607072311435458734371195', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381343', 'ID1607072155411398743731606', 'ID1607072311435458734371195', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381344', 'ID1607072155411398743731060', 'ID1607072311435458734371196', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381345', 'ID1607072155411398743731529', 'ID1607072311435458734371197', 'ID1607072155411398743731053', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381346', 'ID1607072155411398743731412', 'ID1607072311435458734371197', 'ID1607072155411398743731053', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381347', 'ID1607072155411398743731314', 'ID1607072311435458734371197', 'ID1607072155411398743731053', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381348', 'ID1607072155411398743731476', 'ID1607072311435458734371198', 'ID1607072155411398743731408', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381349', 'ID1607072155411398743731161', 'ID1607072311435458734371198', 'ID1607072155411398743731408', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381350', 'ID1607072155411398743731193', 'ID1607072311435458734371199', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381351', 'ID1607072155411398743731081', 'ID1607072311435458734371199', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381352', 'ID1607072155411398743731362', 'ID1607072311435458734371199', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381353', 'ID1607072155411398743731437', 'ID1607072311435458734371199', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381354', 'ID1607072155411398743731062', 'ID1607072311435458734371199', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381355', 'ID1607072155411398743731141', 'ID1607072311435458734371199', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381356', 'ID1607072155411398743731418', 'ID1607072311435458734371199', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381357', 'ID1607072155411398743731070', 'ID1607072311435458734371199', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381358', 'ID1607072155411398743731521', 'ID1607072311435458734371200', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381359', 'ID1607072155411398743731612', 'ID1607072311435458734371201', 'ID1607072155411398743731453', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381360', 'ID1607072155411398743731531', 'ID1607072311435458734371201', 'ID1607072155411398743731453', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381361', 'ID1607072155411398743731177', 'ID1607072311435458734371201', 'ID1607072155411398743731453', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381362', 'ID1607072155411398743731145', 'ID1607072311435458734371202', 'ID1607072155411398743731177', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381363', 'ID1607072155411398743731065', 'ID1607072311435458734371202', 'ID1607072155411398743731177', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381364', 'ID1607072155411398743731053', 'ID1607072311435458734371202', 'ID1607072155411398743731177', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381365', 'ID1607072155411398743731362', 'ID1607072311435458734371203', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381366', 'ID1607072155411398743731298', 'ID1607072311435458734371204', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381367', 'ID1607072155411398743731223', 'ID1607072311435458734371205', 'ID1606072147401110292952758', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381368', 'ID1607072155411398743731394', 'ID1607072311435458734371206', 'ID1607072155411398743731042', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381369', 'ID1607072155411398743731004', 'ID1607072311435458734371207', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381370', 'ID1607072155411398743731203', 'ID1607072311435458734371208', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381371', 'ID1607072155411398743731501', 'ID1607072311435458734371208', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381372', 'ID1607072155411398743731113', 'ID1607072311435458734371208', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381373', 'ID1607072155411398743731450', 'ID1607072311435458734371209', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381374', 'ID1607072155411398743731417', 'ID1607072311435458734371210', 'ID1607072155411398743731417', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381375', 'ID1607072155411398743731221', 'ID1607072311435458734371211', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381376', 'ID1607072155411398743731563', 'ID1607072311435458734371212', 'ID1607072155411398743731492', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381377', 'ID1607072155411398743731391', 'ID1607072311435458734371213', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381378', 'ID1607072155411398743731362', 'ID1607072311435458734371214', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381379', 'ID1607072155411398743731501', 'ID1607072311435458734371215', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381380', 'ID1607072155411398743731362', 'ID1607072311435458734371216', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381381', 'ID1607072155411398743731521', 'ID1607072311435458734371217', 'ID1607072155411398743731110', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381382', 'ID1607072155411398743731258', 'ID1607072311435458734371218', 'ID1607072155411398743731556', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381383', 'ID1607072155411398743731044', 'ID1607072311435458734371218', 'ID1607072155411398743731556', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381384', 'ID1607072155411398743731463', 'ID1607072311435458734371219', 'ID1606041946579183194460162', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381385', 'ID1607072155411398743731215', 'ID1607072311435458734371220', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381386', 'ID1607072155411398743731242', 'ID1607072311435458734371221', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381387', 'ID1607072155411398743731243', 'ID1607072311435458734371221', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381388', 'ID1607072155411398743731354', 'ID1607072311435458734371221', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381389', 'ID1607072155411398743731062', 'ID1607072311435458734371222', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381390', 'ID1607072155411398743731256', 'ID1607072311435458734371223', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381391', 'ID1607072155411398743731028', 'ID1607072311435458734371224', 'ID1607072155411398743731469', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381392', 'ID1607072155411398743731007', 'ID1607072311435458734371225', 'ID1607072155411398743731028', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381393', 'ID1607072155411398743731584', 'ID1607072311435458734371226', 'ID1607072155411398743731028', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381394', 'ID1607072155411398743731367', 'ID1607072311435458734371226', 'ID1607072155411398743731028', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381395', 'ID1607072155411398743731610', 'ID1607072311435458734371227', 'ID1607072155411398743731261', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381396', 'ID1607072155411398743731610', 'ID1607072311435458734371228', 'ID1607072155411398743731261', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381397', 'ID1607072155411398743731141', 'ID1607072311435458734371229', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381398', 'ID1607072155411398743731461', 'ID1607072311435458734371230', 'ID1606041946579183194460162', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381399', 'ID1607072155411398743731130', 'ID1607072311435458734371232', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381400', 'ID1607072155411398743731233', 'ID1607072311435458734371232', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381401', 'ID1607072155411398743731226', 'ID1607072311435458734371233', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381402', 'ID1607072155411398743731113', 'ID1607072311435458734371234', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381403', 'ID1607072155411398743731501', 'ID1607072311435458734371234', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381404', 'ID1607072155411398743731203', 'ID1607072311435458734371234', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381405', 'ID1607072155411398743731463', 'ID1607072311435458734371235', 'ID1607072155411398743731242', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381406', 'ID1607072155411398743731461', 'ID1607072311435458734371236', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381407', 'ID1607072155411398743731570', 'ID1607072311435458734371237', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381408', 'ID1607072155411398743731444', 'ID1607072311435458734371238', 'ID1607072155411398743731340', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381409', 'ID1607072155411398743731450', 'ID1607072311435458734371239', 'ID1607072155411398743731194', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381410', 'ID1607072155411398743731362', 'ID1607072311435458734371240', 'ID1606072147401110292952758', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381411', 'ID1607072155411398743731187', 'ID1607072311435458734371241', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381412', 'ID1607072155411398743731038', 'ID1607072311435458734371242', 'ID1607072155411398743731028', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381413', 'ID1607072155411398743731165', 'ID1607072311435458734371243', 'ID1607072155411398743731533', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381414', 'ID1607072155411398743731275', 'ID1607072311435458734371244', 'ID1606072147401110292952758', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381415', 'ID1607072155411398743731362', 'ID1607072311435458734371245', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381416', 'ID1607072155411398743731193', 'ID1607072311435458734371246', 'ID1607072155411398743731036', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381417', 'ID1607072155411398743731449', 'ID1607072311435458734371247', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381418', 'ID1607072155411398743731002', 'ID1607072311435458734371248', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381419', 'ID1607072155411398743731449', 'ID1607072311435458734371249', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381420', 'ID1607072155411398743731210', 'ID1607072311435458734371250', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381421', 'ID1607072155411398743731223', 'ID1607072311435458734371251', 'ID1607072155411398743731597', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381422', 'ID1607072155411398743731201', 'ID1607072311435458734371252', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381423', 'ID1607072155411398743731109', 'ID1607072311435458734371253', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381424', 'ID1607072155411398743731491', 'ID1607072311435458734371254', 'ID1607072155411398743731444', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381425', 'ID1607072155411398743731465', 'ID1607072311435458734371255', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381426', 'ID1607072155411398743731123', 'ID1607072311435458734371256', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381427', 'ID1607072155411398743731038', 'ID1607072311435458734371256', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381428', 'ID1607072155411398743731427', 'ID1607072311435458734371257', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381429', 'ID1607072155411398743731057', 'ID1607072311435458734371258', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381430', 'ID1607072155411398743731208', 'ID1607072311435458734371259', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381431', 'ID1607072155411398743731243', 'ID1607072311435458734371260', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381432', 'ID1607072155411398743731246', 'ID1607072311435458734371260', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381433', 'ID1607072155411398743731242', 'ID1607072311435458734371260', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381434', 'ID1607072155411398743731530', 'ID1607072311435458734371261', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381435', 'ID1606041548221626379288007', 'ID1607072311435458734371262', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381436', 'ID1607072155411398743731369', 'ID1607072311435458734371263', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381437', 'ID1607072155411398743731256', 'ID1607072311435458734371264', 'ID1607072155411398743731599', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381438', 'ID1607072155411398743731086', 'ID1607072311435458734371265', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381439', 'ID1607072155411398743731111', 'ID1607072311435458734371266', 'ID1607072155411398743731250', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381440', 'ID1607072155411398743731219', 'ID1607072311435458734371266', 'ID1607072155411398743731250', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381441', 'ID1607072155411398743731060', 'ID1607072311435458734371267', 'ID1607072155411398743731082', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381442', 'ID1607072155411398743731485', 'ID1607072311435458734371267', 'ID1607072155411398743731082', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381443', 'ID1607072155411398743731354', 'ID1607072311435458734371267', 'ID1607072155411398743731082', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381444', 'ID1607072155411398743731070', 'ID1607072311435458734371267', 'ID1607072155411398743731082', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381445', 'ID1607072155411398743731350', 'ID1607072311435458734371267', 'ID1607072155411398743731082', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381446', 'ID1607072155411398743731345', 'ID1607072311435458734371268', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381447', 'ID1607072155411398743731070', 'ID1607072311435458734371269', 'ID1607072155411398743731485', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381448', 'ID1607072155411398743731060', 'ID1607072311435458734371269', 'ID1607072155411398743731485', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381449', 'ID1606041548221626379288007', 'ID1607072311435458734371269', 'ID1607072155411398743731485', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381450', 'ID1607072155411398743731354', 'ID1607072311435458734371269', 'ID1607072155411398743731485', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381451', 'ID1607072155411398743731353', 'ID1607072311435458734371270', 'ID1607072155411398743731353', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381452', 'ID1607072155411398743731136', 'ID1607072311435458734371271', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381453', 'ID1607072155411398743731006', 'ID1607072311435458734371272', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381454', 'ID1607072155411398743731403', 'ID1607072311435458734371273', 'ID1607072155411398743731471', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381455', 'ID1607072155411398743731577', 'ID1607072311435458734371273', 'ID1607072155411398743731471', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381456', 'ID1607072155411398743731382', 'ID1607072311435458734371273', 'ID1607072155411398743731471', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381457', 'ID1607072155411398743731577', 'ID1607072311435458734371274', 'ID1607072155411398743731577', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381458', 'ID1607072155411398743731271', 'ID1607072311435458734371275', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381459', 'ID1606041948737864364386236', 'ID1607072311435458734371276', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381460', 'ID1607072155411398743731559', 'ID1607072311435458734371277', 'ID1606072147401110292952758', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381461', 'ID1607072155411398743731014', 'ID1607072311435458734371278', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381462', 'ID1607072155411398743731455', 'ID1607072311435458734371279', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381463', 'ID1607072155411398743731160', 'ID1606041932435458734374224', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381464', 'ID1607072155411398743731444', 'ID1607072311435458734371281', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381465', 'ID1607072155411398743731388', 'ID1607072311435458734371282', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381466', 'ID1606041948737864364386236', 'ID1607072311435458734371283', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381467', 'ID1607072155411398743731252', 'ID1607072311435458734371284', 'ID1607072155411398743731450', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381468', 'ID1607072155411398743731350', 'ID1607072311435458734371285', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381469', 'ID1607072155411398743731597', 'ID1606041932435458734374252', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381470', 'ID1607072155411398743731453', 'ID1606041932435458734374252', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381471', 'ID1607072155411398743731390', 'ID1606041932435458734374252', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381472', 'ID1607072155411398743731177', 'ID1606041932435458734374252', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381473', 'ID1607072155411398743731254', 'ID1606041932435458734374252', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381474', 'ID1607072155411398743731536', 'ID1607072311435458734371287', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381475', 'ID1607072155411398743731341', 'ID1607072311435458734371288', 'ID1607072155411398743731067', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381476', 'ID1607072155411398743731251', 'ID1607072311435458734371289', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381477', 'ID1607072155411398743731060', 'ID1607072311435458734371290', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381478', 'ID1607072155411398743731275', 'ID1607072311435458734371291', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381479', 'ID1607072155411398743731631', 'ID1607072311435458734371292', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381480', 'ID1607072155411398743731251', 'ID1607072311435458734371293', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381481', 'ID1607072155411398743731640', 'ID1607072311435458734371294', 'ID1607072155411398743731307', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381482', 'ID1607072155411398743731583', 'ID1607072311435458734371294', 'ID1607072155411398743731307', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381483', 'ID1607072155411398743731226', 'ID1607072311435458734371295', 'ID1607072155411398743731593', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381484', 'ID1607072155411398743731340', 'ID1607072311435458734371296', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381485', 'ID1607072155411398743731146', 'ID1607072311435458734371296', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381486', 'ID1607072155411398743731530', 'ID1607072311435458734371297', 'ID1607072155411398743731298', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381487', 'ID1607072155411398743731510', 'ID1607072311435458734371298', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381488', 'ID1607072155411398743731512', 'ID1607072311435458734371298', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381489', 'ID1607072155411398743731274', 'ID1607072311435458734371298', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381490', 'ID1607072155411398743731484', 'ID1607072311435458734371298', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381491', 'ID1607072155411398743731502', 'ID1607072311435458734371298', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381492', 'ID1607072155411398743731520', 'ID1607072311435458734371298', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381493', 'ID1607072155411398743731218', 'ID1607072311435458734371298', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381494', 'ID1607072155411398743731290', 'ID1607072311435458734371298', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381495', 'ID1607072155411398743731547', 'ID1607072311435458734371298', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381496', 'ID1607072155411398743731340', 'ID1607072311435458734371299', 'ID1607072155411398743731185', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381497', 'ID1607072155411398743731243', 'ID1607072311435458734371300', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381498', 'ID1607072155411398743731242', 'ID1607072311435458734371300', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381499', 'ID1607072155411398743731234', 'ID1607072311435458734371300', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381500', 'ID1607072155411398743731417', 'ID1607072311435458734371301', 'ID1607072155411398743731417', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381501', 'ID1607072155411398743731043', 'ID1607072311435458734371302', 'ID1607072155411398743731317', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381502', 'ID1607072155411398743731516', 'ID1607072311435458734371303', 'ID1607072155411398743731577', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381503', 'ID1607072155411398743731281', 'ID1607072311435458734371304', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381504', 'ID1607072155411398743731449', 'ID1607072311435458734371305', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381505', 'ID1607072155411398743731476', 'ID1607072311435458734371306', 'ID1607072155411398743731247', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381506', 'ID1607072155411398743731161', 'ID1607072311435458734371306', 'ID1607072155411398743731247', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381507', 'ID1607072155411398743731610', 'ID1607072311435458734371307', 'ID1607072155411398743731261', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381508', 'ID1607072155411398743731307', 'ID1607072311435458734371308', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381509', 'ID1607072155411398743731450', 'ID1607072311435458734371308', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381510', 'ID1607072155411398743731521', 'ID1607072311435458734371309', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381511', 'ID1607072155411398743731362', 'ID1607072311435458734371310', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381512', 'ID1607072155411398743731417', 'ID1607072311435458734371311', 'ID1607072155411398743731362', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381513', 'ID1607072155411398743731141', 'ID1607072311435458734371312', 'ID1607072155411398743731506', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381514', 'ID1607072155411398743731242', 'ID1607072311435458734371313', 'ID1607072155411398743731246', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381515', 'ID1607072155411398743731246', 'ID1607072311435458734371313', 'ID1607072155411398743731246', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381516', 'ID1607072155411398743731243', 'ID1607072311435458734371313', 'ID1607072155411398743731246', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381517', 'ID1607072155411398743731521', 'ID1607072311435458734371314', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381518', 'ID1607072155411398743731597', 'ID1607072311435458734371315', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381519', 'ID1607072155411398743731531', 'ID1607072311435458734371316', 'ID1607072155411398743731177', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381520', 'ID1607072155411398743731612', 'ID1607072311435458734371316', 'ID1607072155411398743731177', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381521', 'ID1607072155411398743731058', 'ID1607072311435458734371317', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381522', 'ID1606041948737864364386236', 'ID1607072311435458734371318', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381523', 'ID1607072155411398743731210', 'ID1607072311435458734371319', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381524', 'ID1607072155411398743731180', 'ID1607072311435458734371320', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381525', 'ID1607072155411398743731183', 'ID1607072311435458734371320', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381526', 'ID1607072155411398743731327', 'ID1607072311435458734371321', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381527', 'ID1607072155411398743731297', 'ID1607072311435458734371321', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381528', 'ID1607072155411398743731124', 'ID1607072311435458734371322', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381529', 'ID1607072155411398743731444', 'ID1607072311435458734371323', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381530', 'ID1607072155411398743731207', 'ID1607072311435458734371324', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381531', 'ID1607072155411398743731418', 'ID1607072311435458734371325', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381532', 'ID1607072155411398743731060', 'ID1606041932435458734374257', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381533', 'ID1607072155411398743731123', 'ID1607072311435458734371327', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381534', 'ID1607072155411398743731325', 'ID1607072311435458734371328', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381535', 'ID1607072155411398743731173', 'ID1607072311435458734371329', 'ID1607072155411398743731592', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381536', 'ID1607072155411398743731083', 'ID1607072311435458734371330', 'ID1607072155411398743731307', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381537', 'ID1607072155411398743731362', 'ID1607072311435458734371330', 'ID1607072155411398743731307', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381538', 'ID1607072155411398743731187', 'ID1607072311435458734371331', 'ID1606072147401110292952758', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381539', 'ID1607072155411398743731577', 'ID1607072311435458734371332', 'ID1607072155411398743731403', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381540', 'ID1607072155411398743731201', 'ID1607072311435458734371333', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381541', 'ID1607072155411398743731628', 'ID1607072311435458734371334', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381542', 'ID1607072155411398743731484', 'ID1607072311435458734371334', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381543', 'ID1607072155411398743731217', 'ID1607072311435458734371335', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381544', 'ID1607072155411398743731242', 'ID1607072311435458734371335', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381545', 'ID1607072155411398743731258', 'ID1607072311435458734371335', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381546', 'ID1607072155411398743731243', 'ID1607072311435458734371335', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381547', 'ID1607072155411398743731556', 'ID1607072311435458734371335', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381548', 'ID1607072155411398743731246', 'ID1607072311435458734371335', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381549', 'ID1607072155411398743731390', 'ID1607072311435458734371336', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381550', 'ID1607072155411398743731391', 'ID1607072311435458734371337', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381551', 'ID1607072155411398743731521', 'ID1607072311435458734371338', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381552', 'ID1607072155411398743731559', 'ID1607072311435458734371339', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381553', 'ID1607072155411398743731126', 'ID1607072311435458734371340', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381554', 'ID1607072155411398743731053', 'ID1607072311435458734371340', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381555', 'ID1607072155411398743731531', 'ID1607072311435458734371340', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381556', 'ID1607072155411398743731065', 'ID1607072311435458734371340', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381557', 'ID1607072155411398743731029', 'ID1607072311435458734371340', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381558', 'ID1607072155411398743731318', 'ID1607072311435458734371340', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381559', 'ID1607072155411398743731612', 'ID1607072311435458734371340', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381560', 'ID1607072155411398743731228', 'ID1607072311435458734371340', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381561', 'ID1607072155411398743731145', 'ID1607072311435458734371340', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381562', 'ID1607072155411398743731521', 'ID1607072311435458734371341', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381563', 'ID1607072155411398743731461', 'ID1607072311435458734371342', 'ID1607072155411398743731160', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381564', 'ID1607072155411398743731521', 'ID1607072311435458734371343', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381565', 'ID1607072155411398743731271', 'ID1607072311435458734371344', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381566', 'ID1607072155411398743731057', 'ID1607072311435458734371345', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381567', 'ID1607072155411398743731258', 'ID1607072311435458734371346', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381568', 'ID1607072155411398743731060', 'ID1607072311435458734371347', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381569', 'ID1607072155411398743731354', 'ID1607072311435458734371347', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381570', 'ID1607072155411398743731070', 'ID1607072311435458734371347', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381571', 'ID1606041548221626379288007', 'ID1607072311435458734371347', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381572', 'ID1607072155411398743731362', 'ID1607072311435458734371347', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381573', 'ID1607072155411398743731641', 'ID1607072311435458734371348', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381574', 'ID1607072155411398743731242', 'ID1607072311435458734371349', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381575', 'ID1607072155411398743731222', 'ID1607072311435458734371350', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381576', 'ID1607072155411398743731256', 'ID1607072311435458734371351', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381577', 'ID1607072155411398743731246', 'ID1607072311435458734371352', 'ID1606072147401110292952758', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381578', 'ID1607072155411398743731251', 'ID1607072311435458734371353', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381579', 'ID1607072155411398743731523', 'ID1607072311435458734371354', 'ID1607072155411398743731369', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381580', 'ID1607072155411398743731417', 'ID1607072311435458734371355', 'ID1607072155411398743731597', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381581', 'ID1607072155411398743731216', 'ID1607072311435458734371356', 'ID1607072155411398743731362', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381582', 'ID1607072155411398743731081', 'ID1607072311435458734371357', 'ID1607072155411398743731365', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381583', 'ID1607072155411398743731356', 'ID1607072311435458734371358', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381584', 'ID1607072155411398743731444', 'ID1607072311435458734371359', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381585', 'ID1607072155411398743731332', 'ID1607072311435458734371360', 'ID1606042059261072737209331', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381586', 'ID1607072155411398743731025', 'ID1607072311435458734371360', 'ID1606042059261072737209331', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381587', 'ID1607072155411398743731045', 'ID1607072311435458734371361', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381588', 'ID1607072155411398743731610', 'ID1607072311435458734371362', 'ID1607072155411398743731261', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381589', 'ID1606041548221626379288007', 'ID1607072311435458734371363', 'ID1607072155411398743731242', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381590', 'ID1607072155411398743731060', 'ID1607072311435458734371363', 'ID1607072155411398743731242', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381591', 'ID1607072155411398743731141', 'ID1607072311435458734371364', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381592', 'ID1607072155411398743731247', 'ID1607072311435458734371365', 'ID1607072155411398743731353', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381593', 'ID1606041548221626379288007', 'ID1607072311435458734371366', 'ID1607072155411398743731160', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381594', 'ID1607072155411398743731060', 'ID1607072311435458734371366', 'ID1607072155411398743731160', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381595', 'ID1607072155411398743731060', 'ID1607072311435458734371367', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381596', 'ID1607072155411398743731523', 'ID1607072311435458734371368', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381597', 'ID1607072155411398743731403', 'ID1607072311435458734371369', 'ID1607072155411398743731577', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381598', 'ID1607072155411398743731449', 'ID1607072311435458734371370', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381599', 'ID1607072155411398743731408', 'ID1607072311435458734371371', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381600', 'ID1607072155411398743731357', 'ID1607072311435458734371372', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381601', 'ID1607072155411398743731242', 'ID1607072311435458734371373', 'ID1607072155411398743731250', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381602', 'ID1607072155411398743731243', 'ID1607072311435458734371373', 'ID1607072155411398743731250', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381603', 'ID1607072155411398743731536', 'ID1607072311435458734371374', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381604', 'ID1607072155411398743731358', 'ID1607072311435458734371375', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381605', 'ID1607072155411398743731262', 'ID1607072311435458734371375', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381606', 'ID1607072155411398743731286', 'ID1607072311435458734371375', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381607', 'ID1607072155411398743731333', 'ID1607072311435458734371375', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381608', 'ID1607072155411398743731193', 'ID1607072311435458734371376', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381609', 'ID1607072155411398743731437', 'ID1607072311435458734371376', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381610', 'ID1607072155411398743731081', 'ID1607072311435458734371377', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381611', 'ID1607072155411398743731193', 'ID1607072311435458734371377', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381612', 'ID1607072155411398743731418', 'ID1607072311435458734371377', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381613', 'ID1607072155411398743731449', 'ID1607072311435458734371378', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381614', 'ID1607072155411398743731350', 'ID1607072311435458734371379', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381615', 'ID1607072155411398743731173', 'ID1607072311435458734371380', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381616', 'ID1607072155411398743731287', 'ID1607072311435458734371381', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381617', 'ID1607072155411398743731242', 'ID1607072311435458734371382', 'ID1607072155411398743731354', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381618', 'ID1607072155411398743731243', 'ID1607072311435458734371382', 'ID1607072155411398743731354', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381619', 'ID1607072155411398743731444', 'ID1607072311435458734371383', 'ID1606072147401110292952758', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381620', 'ID1607072155411398743731191', 'ID1607072311435458734371384', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381621', 'ID1607072155411398743731008', 'ID1607072311435458734371385', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381622', 'ID1607072155411398743731449', 'ID1607072311435458734371385', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381623', 'ID1607072155411398743731364', 'ID1607072311435458734371386', 'ID1606041948737864364386236', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381624', 'ID1607072155411398743731444', 'ID1607072311435458734371387', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381625', 'ID1607072155411398743731193', 'ID1607072311435458734371388', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381626', 'ID1607072155411398743731132', 'ID1607072311435458734371389', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381627', 'ID1607072155411398743731243', 'ID1607072311435458734371389', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381628', 'ID1607072155411398743731242', 'ID1607072311435458734371389', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381629', 'ID1607072155411398743731308', 'ID1607072311435458734371390', 'ID1607072155411398743731494', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381630', 'ID1607072155411398743731506', 'ID1607072311435458734371391', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381631', 'ID1607072155411398743731463', 'ID1607072311435458734371392', 'ID1607072155411398743731437', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381632', 'ID1607072155411398743731586', 'ID1607072311435458734371392', 'ID1607072155411398743731437', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381633', 'ID1607072155411398743731484', 'ID1607072311435458734371393', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381634', 'ID1607072155411398743731099', 'ID1607072311435458734371394', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381635', 'ID1607072155411398743731152', 'ID1607072311435458734371395', 'ID1607072155411398743731577', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381636', 'ID1607072155411398743731530', 'ID1607072311435458734371396', 'ID1607072155411398743731298', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381637', 'ID1607072155411398743731521', 'ID1607072311435458734371397', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381638', 'ID1607072155411398743731070', 'ID1607072311435458734371398', 'ID1606041948737864364386236', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381639', 'ID1607072155411398743731057', 'ID1607072311435458734371399', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381640', 'ID1606041548221626379288007', 'ID1607072311435458734371400', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381641', 'ID1607072155411398743731362', 'ID1607072311435458734371401', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381642', 'ID1607072155411398743731597', 'ID1607072311435458734371401', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381643', 'ID1607072155411398743731521', 'ID1607072311435458734371402', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381644', 'ID1607072155411398743731417', 'ID1607072311435458734371403', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381645', 'ID1607072155411398743731597', 'ID1607072311435458734371404', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381646', 'ID1607072155411398743731045', 'ID1607072311435458734371405', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381647', 'ID1607072155411398743731362', 'ID1607072311435458734371406', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381648', 'ID1607072155411398743731258', 'ID1607072311435458734371407', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381649', 'ID1607072155411398743731550', 'ID1607072311435458734371408', 'ID1607072155411398743731395', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381650', 'ID1607072155411398743731362', 'ID1607072311435458734371409', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381651', 'ID1607072155411398743731123', 'ID1607072311435458734371410', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381652', 'ID1607072155411398743731340', 'ID1607072311435458734371411', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381653', 'ID1607072155411398743731060', 'ID1607072311435458734371412', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381654', 'ID1607072155411398743731022', 'ID1607072311435458734371412', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381655', 'ID1607072155411398743731160', 'ID1607072311435458734371412', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381656', 'ID1607072155411398743731070', 'ID1607072311435458734371412', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381657', 'ID1607072155411398743731243', 'ID1607072311435458734371412', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381658', 'ID1607072155411398743731242', 'ID1607072311435458734371412', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381659', 'ID1607072155411398743731597', 'ID1607072311435458734371413', 'ID1607072155411398743731242', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381660', 'ID1607072155411398743731362', 'ID1607072311435458734371413', 'ID1607072155411398743731242', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381661', 'ID1607072155411398743731371', 'ID1607072311435458734371413', 'ID1607072155411398743731242', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381662', 'ID1607072155411398743731070', 'ID1607072311435458734371413', 'ID1607072155411398743731242', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381663', 'ID1607072155411398743731354', 'ID1607072311435458734371413', 'ID1607072155411398743731242', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381664', 'ID1607072155411398743731367', 'ID1607072311435458734371414', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381665', 'ID1607072155411398743731060', 'ID1607072311435458734371415', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381666', 'ID1606041548221626379288007', 'ID1607072311435458734371415', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381667', 'ID1607072155411398743731193', 'ID1607072311435458734371416', 'ID1607072155411398743731222', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381668', 'ID1607072155411398743731060', 'ID1607072311435458734371417', 'ID1607072155411398743731536', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381669', 'ID1606041548221626379288007', 'ID1607072311435458734371417', 'ID1607072155411398743731536', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381670', 'ID1607072155411398743731018', 'ID1607072311435458734371418', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381671', 'ID1607072155411398743731192', 'ID1607072311435458734371419', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381672', 'ID1607072155411398743731025', 'ID1607072311435458734371419', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381673', 'ID1607072155411398743731494', 'ID1607072311435458734371419', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381674', 'ID1607072155411398743731332', 'ID1607072311435458734371419', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381675', 'ID1606041548221626379288007', 'ID1607072311435458734371420', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381676', 'ID1607072155411398743731341', 'ID1607072311435458734371421', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381677', 'ID1607072155411398743731449', 'ID1607072311435458734371422', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381678', 'ID1607072155411398743731382', 'ID1607072311435458734371423', 'ID1607072155411398743731403', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381679', 'ID1607072155411398743731217', 'ID1607072311435458734371424', 'ID1606041955182025798492067', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381680', 'ID1607072155411398743731090', 'ID1607072311435458734371425', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381681', 'ID1607072155411398743731060', 'ID1607072311435458734371425', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381682', 'ID1607072155411398743731597', 'ID1607072311435458734371425', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381683', 'ID1607072155411398743731332', 'ID1607072311435458734371426', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381684', 'ID1607072155411398743731025', 'ID1607072311435458734371426', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381685', 'ID1607072155411398743731556', 'ID1607072311435458734371426', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381686', 'ID1607072155411398743731559', 'ID1607072311435458734371426', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381687', 'ID1607072155411398743731226', 'ID1607072311435458734371428', 'ID1607072155411398743731226', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381688', 'ID1607072155411398743731418', 'ID1607072311435458734371429', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381689', 'ID1607072155411398743731404', 'ID1607072311435458734371430', 'ID1607072155411398743731597', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381690', 'ID1607072155411398743731458', 'ID1607072311435458734371430', 'ID1607072155411398743731597', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381691', 'ID1607072155411398743731060', 'ID1607072311435458734371430', 'ID1607072155411398743731597', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381692', 'ID1607072155411398743731602', 'ID1607072311435458734371430', 'ID1607072155411398743731597', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381693', 'ID1607072155411398743731350', 'ID1607072311435458734371430', 'ID1607072155411398743731597', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381694', 'ID1607072155411398743731277', 'ID1607072311435458734371430', 'ID1607072155411398743731597', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381695', 'ID1607072155411398743731211', 'ID1607072311435458734371430', 'ID1607072155411398743731597', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381696', 'ID1607072155411398743731505', 'ID1607072311435458734371431', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381697', 'ID1607072155411398743731210', 'ID1607072311435458734371432', 'ID1607072155411398743731009', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381698', 'ID1607072155411398743731597', 'ID1607072311435458734371433', 'ID1607072155411398743731362', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381699', 'ID1607072155411398743731403', 'ID1607072311435458734371434', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381700', 'ID1607072155411398743731382', 'ID1607072311435458734371434', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381701', 'ID1607072155411398743731577', 'ID1607072311435458734371434', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381702', 'ID1607072155411398743731437', 'ID1607072311435458734371435', 'ID1607072155411398743731463', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381703', 'ID1607072155411398743731463', 'ID1607072311435458734371436', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381704', 'ID1607072155411398743731444', 'ID1607072311435458734371437', 'ID1607072155411398743731004', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381705', 'ID1607072155411398743731584', 'ID1607072311435458734371437', 'ID1607072155411398743731004', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381706', 'ID1606041548221626379288007', 'ID1607072311435458734371438', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381707', 'ID1607072155411398743731275', 'ID1607072311435458734371439', 'ID1607072155411398743731523', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381708', 'ID1607072155411398743731599', 'ID1607072311435458734371440', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381709', 'ID1607072155411398743731354', 'ID1607072311435458734371441', 'ID1607072155411398743731025', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381710', 'ID1607072155411398743731332', 'ID1607072311435458734371441', 'ID1607072155411398743731025', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381711', 'ID1607072155411398743731350', 'ID1607072311435458734371441', 'ID1607072155411398743731025', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381712', 'ID1607072155411398743731283', 'ID1607072311435458734371442', 'ID1607072155411398743731593', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381713', 'ID1607072155411398743731008', 'ID1607072311435458734371443', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381714', 'ID1607072155411398743731350', 'ID1607072311435458734371444', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381715', 'ID1607072155411398743731449', 'ID1607072311435458734371445', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381716', 'ID1607072155411398743731521', 'ID1607072311435458734371446', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381717', 'ID1607072155411398743731105', 'ID1607072311435458734371447', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381718', 'ID1607072155411398743731242', 'ID1607072311435458734371448', 'ID1607072155411398743731345', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381719', 'ID1607072155411398743731354', 'ID1607072311435458734371448', 'ID1607072155411398743731345', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381720', 'ID1607072155411398743731060', 'ID1607072311435458734371448', 'ID1607072155411398743731345', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381721', 'ID1607072155411398743731362', 'ID1607072311435458734371448', 'ID1607072155411398743731345', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381722', 'ID1607072155411398743731350', 'ID1607072311435458734371448', 'ID1607072155411398743731345', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381723', 'ID1607072155411398743731444', 'ID1607072311435458734371449', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381724', 'ID1607072155411398743731116', 'ID1607072311435458734371450', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381725', 'ID1607072155411398743731145', 'ID1607072311435458734371450', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381726', 'ID1607072155411398743731367', 'ID1607072311435458734371451', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381727', 'ID1607072155411398743731354', 'ID1607072311435458734371452', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381728', 'ID1607072155411398743731449', 'ID1607072311435458734371452', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381729', 'ID1607072155411398743731008', 'ID1607072311435458734371453', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381730', 'ID1607072155411398743731185', 'ID1607072311435458734371454', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381731', 'ID1607072155411398743731128', 'ID1607072311435458734371454', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381732', 'ID1607072155411398743731228', 'ID1607072311435458734371455', 'ID1607072155411398743731082', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381733', 'ID1607072155411398743731082', 'ID1607072311435458734371455', 'ID1607072155411398743731082', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381734', 'ID1607072155411398743731521', 'ID1607072311435458734371456', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381735', 'ID1607072155411398743731215', 'ID1607072311435458734371457', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381736', 'ID1607072155411398743731008', 'ID1607072311435458734371458', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381737', 'ID1607072155411398743731254', 'ID1607072311435458734371459', 'ID1607072155411398743731556', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381738', 'ID1607072155411398743731519', 'ID1607072311435458734371459', 'ID1607072155411398743731556', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381739', 'ID1607072155411398743731021', 'ID1607072311435458734371459', 'ID1607072155411398743731556', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381740', 'ID1606041548221626379288007', 'ID1607072311435458734371460', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381741', 'ID1607072155411398743731033', 'ID1607072311435458734371461', 'ID1607072155411398743731028', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381742', 'ID1607072155411398743731271', 'ID1607072311435458734371462', 'ID1607072155411398743731246', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381743', 'ID1606041948737864364386236', 'ID1607072311435458734371463', 'ID1607072155411398743731090', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381744', 'ID1607072155411398743731350', 'ID1607072311435458734371464', 'ID1607072155411398743731217', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381745', 'ID1607072155411398743731437', 'ID1607072311435458734371465', 'ID1606041946579183194460162', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381746', 'ID1607072155411398743731062', 'ID1607072311435458734371466', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381747', 'ID1607072155411398743731463', 'ID1607072311435458734371466', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381748', 'ID1607072155411398743731141', 'ID1607072311435458734371466', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381749', 'ID1606041946579183194460162', 'ID1607072311435458734371467', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381750', 'ID1607072155411398743731137', 'ID1607072311435458734371468', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381751', 'ID1607072155411398743731208', 'ID1607072311435458734371469', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381752', 'ID1607072155411398743731362', 'ID1607072311435458734371470', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381753', 'ID1607072155411398743731362', 'ID1607072311435458734371471', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381754', 'ID1607072155411398743731006', 'ID1607072311435458734371472', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381755', 'ID1607072155411398743731417', 'ID1607072311435458734371473', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381756', 'ID1607072155411398743731258', 'ID1607072311435458734371474', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381757', 'ID1607072155411398743731354', 'ID1607072311435458734371475', 'ID1607072155411398743731295', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381758', 'ID1607072155411398743731449', 'ID1607072311435458734371476', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381759', 'ID1607072155411398743731449', 'ID1607072311435458734371477', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381760', 'ID1607072155411398743731057', 'ID1607072311435458734371478', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381761', 'ID1607072155411398743731298', 'ID1607072311435458734371479', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381762', 'ID1607072155411398743731191', 'ID1607072311435458734371480', 'ID1607072155411398743731610', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381763', 'ID1607072155411398743731630', 'ID1607072311435458734371481', 'ID1607072155411398743731037', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381764', 'ID1607072155411398743731362', 'ID1607072311435458734371482', 'ID1606041948737864364386236', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381765', 'ID1607072155411398743731449', 'ID1607072311435458734371483', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381766', 'ID1607072155411398743731191', 'ID1607072311435458734371484', 'ID1607072155411398743731036', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381767', 'ID1607072155411398743731136', 'ID1607072311435458734371485', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381768', 'ID1607072155411398743731203', 'ID1607072311435458734371486', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381769', 'ID1607072155411398743731060', 'ID1607072311435458734371487', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381770', 'ID1607072155411398743731228', 'ID1607072311435458734371488', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381771', 'ID1607072155411398743731057', 'ID1607072311435458734371489', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381772', 'ID1607072155411398743731298', 'ID1607072311435458734371490', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381773', 'ID1607072155411398743731070', 'ID1607072311435458734371491', 'ID1606041948737864364386236', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381774', 'ID1607072155411398743731258', 'ID1607072311435458734371492', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381775', 'ID1607072155411398743731190', 'ID1607072311435458734371493', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381776', 'ID1607072155411398743731208', 'ID1607072311435458734371494', 'ID1607072155411398743731491', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381777', 'ID1607072155411398743731173', 'ID1607072311435458734371495', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381778', 'ID1607072155411398743731597', 'ID1607072311435458734371496', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381779', 'ID1607072155411398743731060', 'ID1607072311435458734371497', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381780', 'ID1607072155411398743731597', 'ID1607072311435458734371498', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381781', 'ID1607072155411398743731231', 'ID1607072311435458734371499', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381782', 'ID1607072155411398743731362', 'ID1607072311435458734371499', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381783', 'ID1607072155411398743731597', 'ID1607072311435458734371500', 'ID1607072155411398743731362', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381784', 'ID1606041548221626379288007', 'ID1607072311435458734371501', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381785', 'ID1607072155411398743731461', 'ID1607072311435458734371502', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381786', 'ID1607072155411398743731418', 'ID1607072311435458734371503', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381788', 'ID1607072155411398743731347', 'ID1607072311435458734371505', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381789', 'ID1607072155411398743731521', 'ID1607072311435458734371506', 'ID1607072155411398743731362', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381790', 'ID1607072155411398743731350', 'ID1607072311435458734371507', 'ID1607072155411398743731562', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381791', 'ID1607072155411398743731488', 'ID1607072311435458734371508', 'ID1607072155411398743731037', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381792', 'ID1607072155411398743731057', 'ID1607072311435458734371509', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381793', 'ID1607072155411398743731380', 'ID1607072311435458734371510', 'ID1607072155411398743731017', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381794', 'ID1607072155411398743731444', 'ID1607072311435458734371510', 'ID1607072155411398743731017', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381795', 'ID1607072155411398743731043', 'ID1607072311435458734371510', 'ID1607072155411398743731017', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381796', 'ID1607072155411398743731488', 'ID1607072311435458734371510', 'ID1607072155411398743731017', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381797', 'ID1607072155411398743731521', 'ID1607072311435458734371511', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381798', 'ID1607072155411398743731190', 'ID1607072311435458734371512', 'ID1607072155411398743731521', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381799', 'ID1607072155411398743731226', 'ID1607072311435458734371513', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381800', 'ID1607072155411398743731070', 'ID1607072311435458734371514', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381801', 'ID1607072155411398743731160', 'ID1607072311435458734371514', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381802', 'ID1607072155411398743731060', 'ID1607072311435458734371514', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381803', 'ID1607072155411398743731203', 'ID1607072311435458734371515', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381804', 'ID1607072155411398743731307', 'ID1607072311435458734371516', 'ID1607072155411398743731450', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381805', 'ID1607072155411398743731081', 'ID1607072311435458734371517', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381806', 'ID1607072155411398743731233', 'ID1607072311435458734371518', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381807', 'ID1607072155411398743731065', 'ID1607072311435458734371519', 'ID1607072155411398743731531', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381808', 'ID1607072155411398743731145', 'ID1607072311435458734371519', 'ID1607072155411398743731531', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381809', 'ID1607072155411398743731177', 'ID1607072311435458734371519', 'ID1607072155411398743731531', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381810', 'ID1607072155411398743731053', 'ID1607072311435458734371519', 'ID1607072155411398743731531', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381811', 'ID1607072155411398743731242', 'ID1607072311435458734371520', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381812', 'ID1607072155411398743731243', 'ID1607072311435458734371520', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381813', 'ID1607072155411398743731371', 'ID1607072311435458734371521', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381814', 'ID1607072155411398743731586', 'ID1607072311435458734371522', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381815', 'ID1607072155411398743731318', 'ID1607072311435458734371523', 'ID1607072155411398743731362', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381816', 'ID1607072155411398743731145', 'ID1607072311435458734371523', 'ID1607072155411398743731362', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381817', 'ID1607072155411398743731014', 'ID1607072311435458734371524', 'ID1607072155411398743731565', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381818', 'ID1607072155411398743731295', 'ID1607072311435458734371525', 'ID1607072155411398743731295', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381819', 'ID1606041548221626379288007', 'ID1607072311435458734371526', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381820', 'ID1607072155411398743731160', 'ID1607072311435458734371527', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381821', 'ID1607072155411398743731123', 'ID1607072311435458734371528', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381822', 'ID1607072155411398743731577', 'ID1607072311435458734371528', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381823', 'ID1607072155411398743731449', 'ID1607072311435458734371529', 'ID1607072155411398743731008', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381824', 'ID1607072155411398743731258', 'ID1607072311435458734371530', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381825', 'ID1607072155411398743731057', 'ID1607072311435458734371531', 'ID1607072155411398743731479', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381826', 'ID1607072155411398743731354', 'ID1607072311435458734371531', 'ID1607072155411398743731479', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381827', 'ID1607072155411398743731203', 'ID1607072311435458734371531', 'ID1607072155411398743731479', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381828', 'ID1607072155411398743731193', 'ID1607072311435458734371532', 'ID1607072155411398743731222', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381829', 'ID1607072155411398743731215', 'ID1607072311435458734371533', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381830', 'ID1607072155411398743731340', 'ID1607072311435458734371534', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381831', 'ID1607072155411398743731095', 'ID1607072311435458734371535', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381832', 'ID1607072155411398743731043', 'ID1607072311435458734371536', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381833', 'ID1607072155411398743731444', 'ID1607072311435458734371536', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381834', 'ID1607072155411398743731341', 'ID1607072311435458734371537', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381835', 'ID1607072155411398743731347', 'ID1607072311435458734371538', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381836', 'ID1607072155411398743731221', 'ID1607072311435458734371539', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381837', 'ID1607072155411398743731484', 'ID1607072311435458734371540', 'ID1607072155411398743731362', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381838', 'ID1607072155411398743731066', 'ID1607072311435458734371541', 'ID1607072155411398743731242', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381839', 'ID1607072155411398743731612', 'ID1607072311435458734371542', 'ID1607072155411398743731531', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381840', 'ID1607072155411398743731246', 'ID1607072311435458734371543', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381841', 'ID1607072155411398743731123', 'ID1607072311435458734371544', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381842', 'ID1607072155411398743731463', 'ID1607072311435458734371545', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381843', 'ID1607072155411398743731262', 'ID1607072311435458734371546', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381844', 'ID1607072155411398743731504', 'ID1607072311435458734371547', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381845', 'ID1607072155411398743731258', 'ID1607072311435458734371548', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381846', 'ID1607072155411398743731262', 'ID1607072311435458734371549', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381847', 'ID1607072155411398743731310', 'ID1607072311435458734371550', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381848', 'ID1607072155411398743731109', 'ID1607072311435458734371551', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381849', 'ID1607072155411398743731165', 'ID1607072311435458734371552', 'ID1607072155411398743731208', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381850', 'ID1607072155411398743731272', 'ID1607072311435458734371552', 'ID1607072155411398743731208', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381851', 'ID1607072155411398743731531', 'ID1607072311435458734371553', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381852', 'ID1607072155411398743731057', 'ID1607072311435458734371553', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381853', 'ID1607072155411398743731065', 'ID1607072311435458734371553', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381854', 'ID1607072155411398743731126', 'ID1607072311435458734371553', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381855', 'ID1607072155411398743731053', 'ID1607072311435458734371553', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381856', 'ID1607072155411398743731177', 'ID1607072311435458734371553', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381857', 'ID1607072155411398743731145', 'ID1607072311435458734371553', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381858', 'ID1607072155411398743731029', 'ID1607072311435458734371553', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381859', 'ID1607072155411398743731090', 'ID1607072311435458734371554', 'ID1606041948737864364386236', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381860', 'ID1607072155411398743731116', 'ID1607072311435458734371555', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381861', 'ID1607072155411398743731145', 'ID1607072311435458734371555', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381862', 'ID1607072155411398743731141', 'ID1607072311435458734371556', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381863', 'ID1607072155411398743731506', 'ID1607072311435458734371556', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381864', 'ID1607072155411398743731226', 'ID1607072311435458734371557', 'ID1607072155411398743731577', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381865', 'ID1607072155411398743731298', 'ID1607072311435458734371558', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381866', 'ID1607072155411398743731028', 'ID1607072311435458734371559', 'ID1607072155411398743731137', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381867', 'ID1607072155411398743731505', 'ID1607072311435458734371560', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381868', 'ID1607072155411398743731193', 'ID1607072311435458734371561', 'ID1607072155411398743731479', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381869', 'ID1606041948737864364386236', 'ID1607072311435458734371562', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381870', 'ID1607072155411398743731002', 'ID1607072311435458734371563', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381871', 'ID1607072155411398743731362', 'ID1607072311435458734371564', 'ID1607072155411398743731325', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381872', 'ID1607072155411398743731268', 'ID1607072311435458734371565', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381873', 'ID1607072155411398743731353', 'ID1607072311435458734371566', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381874', 'ID1607072155411398743731362', 'ID1607072311435458734371566', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381875', 'ID1607072155411398743731362', 'ID1607072311435458734371567', 'ID1607072155411398743731057', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381876', 'ID1607072155411398743731471', 'ID1607072311435458734371568', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381877', 'ID1607072155411398743731367', 'ID1607072311435458734371568', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381878', 'ID1607072155411398743731328', 'ID1607072311435458734371569', 'ID1607072155411398743731491', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381879', 'ID1607072155411398743731045', 'ID1607072311435458734371570', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381881', 'ID1607072155411398743731268', 'ID1607072311435458734371572', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381882', 'ID1607072155411398743731070', 'ID1607072311435458734371573', 'ID1607072155411398743731357', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381883', 'ID1607072155411398743731597', 'ID1607072311435458734371573', 'ID1607072155411398743731357', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381884', 'ID1607072155411398743731242', 'ID1607072311435458734371573', 'ID1607072155411398743731357', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381885', 'ID1607072155411398743731060', 'ID1607072311435458734371573', 'ID1607072155411398743731357', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381886', 'ID1607072155411398743731485', 'ID1607072311435458734371573', 'ID1607072155411398743731357', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381887', 'ID1607072155411398743731362', 'ID1607072311435458734371573', 'ID1607072155411398743731357', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381888', 'ID1607072155411398743731354', 'ID1607072311435458734371573', 'ID1607072155411398743731357', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381889', 'ID1607072155411398743731350', 'ID1607072311435458734371573', 'ID1607072155411398743731357', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381891', 'ID1607072155411398743731215', 'ID1607072311435458734371575', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381892', 'ID1607072155411398743731062', 'ID1607072311435458734371576', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381893', 'ID1607072155411398743731455', 'ID1607072311435458734371577', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381894', 'ID1607072155411398743731258', 'ID1607072311435458734371578', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381895', 'ID1607072155411398743731044', 'ID1607072311435458734371578', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381896', 'ID1607072155411398743731477', 'ID1607072311435458734371579', 'ID1607072155411398743731455', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381897', 'ID1607072155411398743731362', 'ID1607072311435458734371580', 'ID1607072155411398743731362', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381898', 'ID1607072155411398743731039', 'ID1607072311435458734371581', 'ID1607072155411398743731491', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381899', 'ID1607072155411398743731362', 'ID1607072311435458734371582', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381900', 'ID1607072155411398743731053', 'ID1607072311435458734371583', 'ID1607072155411398743731177', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381901', 'ID1607072155411398743731145', 'ID1607072311435458734371583', 'ID1607072155411398743731177', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381902', 'ID1607072155411398743731065', 'ID1607072311435458734371583', 'ID1607072155411398743731177', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381903', 'ID1607072155411398743731442', 'ID1607072311435458734371584', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381904', 'ID1607072155411398743731391', 'ID1606051119474914114550441', 'ID1606041946579183194460162', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381905', 'ID1607072155411398743731350', 'ID1606051119474914114550441', 'ID1606041946579183194460162', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381906', 'ID1607072155411398743731455', 'ID1606051119474914114550441', 'ID1606041946579183194460162', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381908', 'ID1607072155411398743731060', 'ID1606051119474914114550441', 'ID1606041946579183194460162', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381909', 'ID1607072155411398743731002', 'ID1607072311435458734371586', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381910', 'ID1607072155411398743731362', 'ID1607072311435458734371587', 'ID1607072155411398743731362', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381911', 'ID1607072155411398743731345', 'ID1607072311435458734371588', 'ID1607072155411398743731310', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381912', 'ID1607072155411398743731521', 'ID1607072311435458734371589', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381913', 'ID1607072155411398743731258', 'ID1607072311435458734371590', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381914', 'ID1607072155411398743731060', 'ID1607072311435458734371591', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381915', 'ID1606041548221626379288007', 'ID1607072311435458734371591', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381916', 'ID1607072155411398743731350', 'ID1607072311435458734371591', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381917', 'ID1607072155411398743731353', 'ID1607072311435458734371592', 'ID1607072155411398743731353', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381918', 'ID1607072155411398743731362', 'ID1607072311435458734371593', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381919', 'ID1607072155411398743731358', 'ID1607072311435458734371594', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381920', 'ID1607072155411398743731258', 'ID1607072311435458734371595', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381921', 'ID1607072155411398743731550', 'ID1607072311435458734371596', 'ID1607072155411398743731395', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381922', 'ID1607072155411398743731610', 'ID1607072311435458734371597', 'ID1607072155411398743731261', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381923', 'ID1607072155411398743731141', 'ID1607072311435458734371598', 'ID1607072155411398743731109', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381924', 'ID1607072155411398743731258', 'ID1607072311435458734371599', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381925', 'ID1607072155411398743731362', 'ID1607072311435458734371600', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381926', 'ID1607072155411398743731065', 'ID1607072311435458734371601', 'ID1607072155411398743731531', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381927', 'ID1607072155411398743731145', 'ID1607072311435458734371601', 'ID1607072155411398743731531', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381928', 'ID1607072155411398743731177', 'ID1607072311435458734371601', 'ID1607072155411398743731531', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381929', 'ID1607072155411398743731053', 'ID1607072311435458734371601', 'ID1607072155411398743731531', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381930', 'ID1607072155411398743731258', 'ID1607072311435458734371602', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381931', 'ID1607072155411398743731242', 'ID1607072311435458734371603', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381932', 'ID1607072155411398743731243', 'ID1607072311435458734371603', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381933', 'ID1607072155411398743731444', 'ID1607072311435458734371604', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381934', 'ID1607072155411398743731043', 'ID1607072311435458734371604', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381935', 'ID1607072155411398743731090', 'ID1607072311435458734371605', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381936', 'ID1607072155411398743731515', 'ID1607072311435458734371605', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381937', 'ID1607072155411398743731057', 'ID1607072311435458734371606', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381938', 'ID1607072155411398743731250', 'ID1607072311435458734371607', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381939', 'ID1607072155411398743731494', 'ID1607072311435458734371608', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381940', 'ID1607072155411398743731062', 'ID1607072311435458734371609', 'ID1607072155411398743731246', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381941', 'ID1607072155411398743731256', 'ID1607072311435458734371610', 'ID1607072155411398743731256', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381942', 'ID1607072155411398743731160', 'ID1607072311435458734371611', 'ID1607072155411398743731217', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381943', 'ID1607072155411398743731070', 'ID1607072311435458734371611', 'ID1607072155411398743731217', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381944', 'ID1606041548221626379288007', 'ID1607072311435458734371612', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381945', 'ID1607072155411398743731208', 'ID1607072311435458734371613', 'ID1607072155411398743731007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381946', 'ID1607072155411398743731455', 'ID1607072311435458734371614', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381947', 'ID1607072155411398743731391', 'ID1607072311435458734371614', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381948', 'ID1607072155411398743731203', 'ID1607072311435458734371615', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381949', 'ID1607072155411398743731062', 'ID1607072311435458734371616', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381950', 'ID1607072155411398743731286', 'ID1607072311435458734371617', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381951', 'ID1607072155411398743731408', 'ID1607072311435458734371618', 'ID1607072155411398743731417', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381952', 'ID1607072155411398743731062', 'ID1607072311435458734371619', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381953', 'ID1607072155411398743731463', 'ID1607072311435458734371619', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381954', 'ID1607072155411398743731450', 'ID1607072311435458734371620', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381955', 'ID1607072155411398743731307', 'ID1607072311435458734371620', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381956', 'ID1607072155411398743731418', 'ID1607072311435458734371621', 'ID1607072155411398743731446', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381957', 'ID1607072155411398743731463', 'ID1607072311435458734371622', 'ID1606072147401110292952758', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381958', 'ID1606041948737864364386236', 'ID1607072311435458734371623', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381959', 'ID1607072155411398743731449', 'ID1607072311435458734371624', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381960', 'ID1607072155411398743731444', 'ID1607072311435458734371625', 'ID1607072155411398743731444', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381961', 'ID1607072155411398743731523', 'ID1607072311435458734371626', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381962', 'ID1607072155411398743731161', 'ID1607072311435458734371627', 'ID1607072155411398743731067', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381963', 'ID1607072155411398743731191', 'ID1607072311435458734371628', 'ID1607072155411398743731036', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381964', 'ID1607072155411398743731038', 'ID1607072311435458734371629', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381965', 'ID1607072155411398743731391', 'ID1607072311435458734371630', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381966', 'ID1607072155411398743731339', 'ID1607072311435458734371631', 'ID1607072155411398743731318', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381967', 'ID1607072155411398743731362', 'ID1607072311435458734371632', 'ID1607072155411398743731057', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381968', 'ID1607072155411398743731530', 'ID1607072311435458734371633', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381969', 'ID1607072155411398743731362', 'ID1607072311435458734371634', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381970', 'ID1607072155411398743731193', 'ID1607072311435458734371635', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381971', 'ID1607072155411398743731327', 'ID1607072311435458734371636', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381972', 'ID1607072155411398743731499', 'ID1607072311435458734371637', 'ID1607072155411398743731577', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381973', 'ID1607072155411398743731043', 'ID1607072311435458734371638', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381974', 'ID1607072155411398743731449', 'ID1607072311435458734371639', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381975', 'ID1607072155411398743731067', 'ID1607072311435458734371640', 'ID1607072155411398743731341', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381976', 'ID1607072155411398743731060', 'ID1607072311435458734371641', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381977', 'ID1607072155411398743731078', 'ID1607072311435458734371641', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381978', 'ID1607072155411398743731070', 'ID1607072311435458734371642', 'ID1607072155411398743731630', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381979', 'ID1607072155411398743731437', 'ID1607072311435458734371643', 'ID1607072155411398743731284', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381980', 'ID1607072155411398743731521', 'ID1607072311435458734371644', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381981', 'ID1607072155411398743731559', 'ID1607072311435458734371645', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381982', 'ID1607072155411398743731449', 'ID1607072311435458734371646', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381983', 'ID1607072155411398743731523', 'ID1607072311435458734371647', 'ID1607072155411398743731523', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381984', 'ID1607072155411398743731123', 'ID1607072311435458734371648', 'ID1607072155411398743731468', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381985', 'ID1607072155411398743731367', 'ID1607072311435458734371648', 'ID1607072155411398743731468', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381986', 'ID1607072155411398743731584', 'ID1607072311435458734371648', 'ID1607072155411398743731468', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381987', 'ID1607072155411398743731062', 'ID1607072311435458734371649', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381988', 'ID1607072155411398743731463', 'ID1607072311435458734371649', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381989', 'ID1607072155411398743731002', 'ID1607072311435458734371650', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381990', 'ID1607072155411398743731639', 'ID1607072311435458734371651', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381991', 'ID1607072155411398743731610', 'ID1607072311435458734371652', 'ID1607072155411398743731261', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381992', 'ID1607072155411398743731473', 'ID1607072311435458734371653', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381993', 'ID1607072155411398743731530', 'ID1607072311435458734371654', 'ID1607072155411398743731479', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381994', 'ID1607072155411398743731474', 'ID1607072311435458734371654', 'ID1607072155411398743731479', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381995', 'ID1607072155411398743731461', 'ID1607072311435458734371655', 'ID1607072155411398743731070', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381996', 'ID1607072155411398743731362', 'ID1607072311435458734371656', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381997', 'ID1607072155411398743731160', 'ID1607072311435458734371657', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381998', 'ID1607072155411398743731060', 'ID1607072311435458734371657', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919381999', 'ID1607072155411398743731350', 'ID1607072311435458734371657', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382000', 'ID1606041548221626379288007', 'ID1607072311435458734371657', 'ID1606041455442065173847803', 0, 0, 0, 1, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382001', 'ID1607072155411398743731128', 'ID1607072311435458734371658', 'ID1606072147401110292952758', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382002', 'ID1606041548221626379288007', 'ID1607072311435458734371659', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382003', 'ID1607072155411398743731471', 'ID1607072311435458734371660', 'ID1607072155411398743731471', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382004', 'ID1607072155411398743731208', 'ID1607072311435458734371661', 'ID1607072155411398743731471', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382005', 'ID1607072155411398743731494', 'ID1607072311435458734371662', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382006', 'ID1607072155411398743731298', 'ID1607072311435458734371663', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382007', 'ID1607072155411398743731362', 'ID1607072311435458734371664', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382008', 'ID1607072155411398743731369', 'ID1607072311435458734371665', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382009', 'ID1607072155411398743731362', 'ID1607072311435458734371666', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382010', 'ID1607072155411398743731463', 'ID1607072311435458734371667', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382011', 'ID1607072155411398743731362', 'ID1607072311435458734371668', 'ID1607072155411398743731630', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382012', 'ID1607072155411398743731354', 'ID1607072311435458734371668', 'ID1607072155411398743731630', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382013', 'ID1607072155411398743731070', 'ID1607072311435458734371668', 'ID1607072155411398743731630', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382014', 'ID1607072155411398743731277', 'ID1607072311435458734371668', 'ID1607072155411398743731630', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382015', 'ID1607072155411398743731259', 'ID1607072311435458734371669', 'ID1607072155411398743731037', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382016', 'ID1607072155411398743731556', 'ID1606041932435458734374266', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382017', 'ID1607072155411398743731254', 'ID1606041932435458734374266', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382018', 'ID1607072155411398743731081', 'ID1607072311435458734371671', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382019', 'ID1607072155411398743731407', 'ID1607072311435458734371672', 'ID1607072155411398743731037', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382020', 'ID1607072155411398743731202', 'ID1607072311435458734371673', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382021', 'ID1607072155411398743731060', 'ID1607072311435458734371674', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382022', 'ID1607072155411398743731491', 'ID1607072311435458734371675', 'ID1607072155411398743731367', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382023', 'ID1607072155411398743731610', 'ID1607072311435458734371676', 'ID1607072155411398743731261', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382024', 'ID1607072155411398743731610', 'ID1607072311435458734371677', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382025', 'ID1607072155411398743731242', 'ID1607072311435458734371678', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382026', 'ID1607072155411398743731243', 'ID1607072311435458734371678', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382027', 'ID1607072155411398743731354', 'ID1607072311435458734371678', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382028', 'ID1607072155411398743731243', 'ID1607072311435458734371679', 'ID1607072155411398743731246', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382029', 'ID1607072155411398743731031', 'ID1607072311435458734371679', 'ID1607072155411398743731246', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382030', 'ID1607072155411398743731242', 'ID1607072311435458734371679', 'ID1607072155411398743731246', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382031', 'ID1607072155411398743731504', 'ID1607072311435458734371680', 'ID1607072155411398743731475', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382032', 'ID1607072155411398743731233', 'ID1607072311435458734371681', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382033', 'ID1607072155411398743731130', 'ID1607072311435458734371681', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382034', 'ID1607072155411398743731345', 'ID1607072311435458734371682', 'ID1606041948737864364386236', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382035', 'ID1607072155411398743731357', 'ID1607072311435458734371682', 'ID1606041948737864364386236', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382036', 'ID1607072155411398743731506', 'ID1607072311435458734371683', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382037', 'ID1607072155411398743731210', 'ID1607072311435458734371684', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382038', 'ID1607072155411398743731340', 'ID1607072311435458734371685', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382039', 'ID1607072155411398743731038', 'ID1607072311435458734371686', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382040', 'ID1607072155411398743731597', 'ID1607072311435458734371686', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382041', 'ID1607072155411398743731060', 'ID1607072311435458734371686', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382042', 'ID1606041548221626379288007', 'ID1607072311435458734371686', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382043', 'ID1607072155411398743731284', 'ID1607072311435458734371687', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382044', 'ID1607072155411398743731379', 'ID1607072311435458734371688', 'ID1606041948737864364386236', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382045', 'ID1607072155411398743731362', 'ID1607072311435458734371689', 'ID1607072155411398743731057', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382046', 'ID1607072155411398743731191', 'ID1607072311435458734371690', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382047', 'ID1607072155411398743731193', 'ID1607072311435458734371692', 'ID1607072155411398743731449', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382048', 'ID1607072155411398743731444', 'ID1607072311435458734371693', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382049', 'ID1607072155411398743731116', 'ID1607072311435458734371694', 'ID1606041948737864364386236', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382050', 'ID1607072155411398743731145', 'ID1607072311435458734371694', 'ID1606041948737864364386236', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382051', 'ID1607072155411398743731390', 'ID1607072311435458734371695', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382052', 'ID1607072155411398743731417', 'ID1607072311435458734371696', 'ID1607072155411398743731408', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382053', 'ID1607072155411398743731610', 'ID1607072311435458734371697', 'ID1607072155411398743731261', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382054', 'ID1607072155411398743731318', 'ID1607072311435458734371698', 'ID1607072155411398743731362', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382055', 'ID1607072155411398743731352', 'ID1607072311435458734371699', 'ID1607072155411398743731028', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382056', 'ID1607072155411398743731499', 'ID1607072311435458734371700', 'ID1607072155411398743731593', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382057', 'ID1607072155411398743731601', 'ID1607072311435458734371701', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382058', 'ID1607072155411398743731060', 'ID1607072311435458734371701', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382059', 'ID1607072155411398743731382', 'ID1607072311435458734371702', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382060', 'ID1607072155411398743731362', 'ID1607072311435458734371703', 'ID1607072155411398743731275', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382061', 'ID1607072155411398743731090', 'ID1607072311435458734371704', 'ID1607072155411398743731190', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382062', 'ID1607072155411398743731161', 'ID1607072311435458734371705', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382063', 'ID1607072155411398743731340', 'ID1607072311435458734371706', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382064', 'ID1607072155411398743731065', 'ID1607072311435458734371707', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382065', 'ID1607072155411398743731145', 'ID1607072311435458734371707', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382066', 'ID1607072155411398743731053', 'ID1607072311435458734371707', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382067', 'ID1607072155411398743731354', 'ID1607072311435458734371708', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382068', 'ID1607072155411398743731243', 'ID1607072311435458734371708', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382069', 'ID1607072155411398743731242', 'ID1607072311435458734371708', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382070', 'ID1606041548221626379288007', 'ID1607072311435458734371709', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382071', 'ID1607072155411398743731477', 'ID1607072311435458734371710', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382072', 'ID1607072155411398743731173', 'ID1607072311435458734371711', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382073', 'ID1607072155411398743731353', 'ID1607072311435458734371712', 'ID1606041948737864364386236', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382074', 'ID1607072155411398743731231', 'ID1607072311435458734371712', 'ID1606041948737864364386236', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382075', 'ID1607072155411398743731488', 'ID1607072311435458734371713', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382076', 'ID1607072155411398743731060', 'ID1607072311435458734371714', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382077', 'ID1606041548221626379288007', 'ID1607072311435458734371714', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382078', 'ID1607072155411398743731505', 'ID1607072311435458734371715', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382079', 'ID1607072155411398743731357', 'ID1607072311435458734371716', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382080', 'ID1607072155411398743731193', 'ID1607072311435458734371717', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382081', 'ID1607072155411398743731523', 'ID1607072311435458734371718', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382082', 'ID1607072155411398743731141', 'ID1607072311435458734371719', 'ID1607072155411398743731246', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382083', 'ID1607072155411398743731506', 'ID1607072311435458734371719', 'ID1607072155411398743731246', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382084', 'ID1607072155411398743731251', 'ID1607072311435458734371720', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382085', 'ID1607072155411398743731258', 'ID1607072311435458734371721', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382086', 'ID1607072155411398743731531', 'ID1607072311435458734371722', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382087', 'ID1607072155411398743731025', 'ID1607072311435458734371723', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382088', 'ID1607072155411398743731251', 'ID1607072311435458734371724', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382089', 'ID1607072155411398743731298', 'ID1607072311435458734371725', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382090', 'ID1607072155411398743731461', 'ID1607072311435458734371726', 'ID1607072155411398743731093', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382091', 'ID1607072155411398743731160', 'ID1607072311435458734371726', 'ID1607072155411398743731093', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382092', 'ID1607072155411398743731350', 'ID1607072311435458734371727', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382093', 'ID1607072155411398743731325', 'ID1607072311435458734371728', 'ID1607072155411398743731521', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382094', 'ID1607072155411398743731444', 'ID1607072311435458734371729', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382095', 'ID1607072155411398743731362', 'ID1607072311435458734371730', 'ID1607072155411398743731597', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382096', 'ID1606041548221626379288007', 'ID1607072311435458734371731', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382097', 'ID1607072155411398743731610', 'ID1607072311435458734371732', 'ID1607072155411398743731261', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382098', 'ID1607072155411398743731444', 'ID1607072311435458734371733', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382099', 'ID1607072155411398743731380', 'ID1607072311435458734371733', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382100', 'ID1607072155411398743731488', 'ID1607072311435458734371733', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382101', 'ID1607072155411398743731043', 'ID1607072311435458734371733', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382102', 'ID1607072155411398743731362', 'ID1607072311435458734371734', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382103', 'ID1607072155411398743731449', 'ID1607072311435458734371735', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382104', 'ID1607072155411398743731057', 'ID1607072311435458734371736', 'ID1607072155411398743731045', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382105', 'ID1607072155411398743731057', 'ID1607072311435458734371737', 'ID1607072155411398743731362', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382106', 'ID1607072155411398743731258', 'ID1607072311435458734371738', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382107', 'ID1606041548221626379288007', 'ID1607072311435458734371739', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382108', 'ID1607072155411398743731193', 'ID1607072311435458734371740', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382109', 'ID1607072155411398743731463', 'ID1607072311435458734371740', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382110', 'ID1607072155411398743731111', 'ID1607072311435458734371740', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382111', 'ID1607072155411398743731242', 'ID1607072311435458734371740', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382112', 'ID1607072155411398743731243', 'ID1607072311435458734371740', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382113', 'ID1607072155411398743731350', 'ID1607072311435458734371741', 'ID1607072155411398743731562', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382114', 'ID1607072155411398743731208', 'ID1607072311435458734371742', 'ID1607072155411398743731201', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382115', 'ID1607072155411398743731442', 'ID1607072311435458734371743', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382116', 'ID1607072155411398743731362', 'ID1607072311435458734371744', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382117', 'ID1607072155411398743731208', 'ID1607072311435458734371745', 'ID1607072155411398743731471', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382118', 'ID1607072155411398743731533', 'ID1607072311435458734371745', 'ID1607072155411398743731471', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382119', 'ID1607072155411398743731029', 'ID1607072311435458734371746', 'ID1607072155411398743731036', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382120', 'ID1607072155411398743731597', 'ID1607072311435458734371746', 'ID1607072155411398743731036', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382121', 'ID1607072155411398743731057', 'ID1607072311435458734371746', 'ID1607072155411398743731036', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382122', 'ID1607072155411398743731408', 'ID1607072311435458734371746', 'ID1607072155411398743731036', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382123', 'ID1607072155411398743731175', 'ID1607072311435458734371746', 'ID1607072155411398743731036', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382124', 'ID1607072155411398743731341', 'ID1607072311435458734371746', 'ID1607072155411398743731036', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382125', 'ID1607072155411398743731519', 'ID1607072311435458734371747', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382127', 'ID1607072155411398743731597', 'ID1607072311435458734371749', 'ID1607072155411398743731597', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382128', 'ID1607072155411398743731233', 'ID1607072311435458734371750', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382129', 'ID1607072155411398743731463', 'ID1607072311435458734371751', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382130', 'ID1606041946579183194460162', 'ID1607072311435458734371752', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382131', 'ID1607072155411398743731310', 'ID1607072311435458734371753', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382132', 'ID1607072155411398743731347', 'ID1607072311435458734371754', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382133', 'ID1607072155411398743731354', 'ID1607072311435458734371755', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382134', 'ID1607072155411398743731523', 'ID1607072311435458734371756', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382135', 'ID1607072155411398743731461', 'ID1607072311435458734371757', 'ID1607072155411398743731160', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382136', 'ID1606041548221626379288007', 'ID1607072311435458734371758', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382137', 'ID1607072155411398743731275', 'ID1607072311435458734371759', 'ID1606072147401110292952758', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382138', 'ID1607072155411398743731191', 'ID1607072311435458734371760', 'ID1607072155411398743731247', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382139', 'ID1607072155411398743731081', 'ID1607072311435458734371761', 'ID1607072155411398743731513', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382140', 'ID1607072155411398743731057', 'ID1607072311435458734371762', 'ID1607072155411398743731479', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382141', 'ID1607072155411398743731203', 'ID1607072311435458734371762', 'ID1607072155411398743731479', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382142', 'ID1607072155411398743731354', 'ID1607072311435458734371762', 'ID1607072155411398743731479', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382143', 'ID1606041548221626379288007', 'ID1607072311435458734371762', 'ID1607072155411398743731479', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382144', 'ID1607072155411398743731449', 'ID1607072311435458734371763', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382145', 'ID1607072155411398743731258', 'ID1607072311435458734371764', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382146', 'ID1607072155411398743731262', 'ID1607072311435458734371765', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382147', 'ID1607072155411398743731177', 'ID1607072311435458734371766', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382148', 'ID1607072155411398743731145', 'ID1607072311435458734371766', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382149', 'ID1607072155411398743731053', 'ID1607072311435458734371766', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382150', 'ID1607072155411398743731065', 'ID1607072311435458734371766', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382151', 'ID1606041548221626379288007', 'ID1607072311435458734371767', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382152', 'ID1607072155411398743731354', 'ID1607072311435458734371767', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382153', 'ID1607072155411398743731045', 'ID1607072311435458734371768', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382154', 'ID1607072155411398743731597', 'ID1607072311435458734371769', 'ID1607072155411398743731597', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382155', 'ID1607072155411398743731110', 'ID1607072311435458734371770', 'ID1607072155411398743731231', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382156', 'ID1607072155411398743731265', 'ID1607072311435458734371771', 'ID1607072155411398743731265', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382157', 'ID1607072155411398743731630', 'ID1607072311435458734371772', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382158', 'ID1607072155411398743731463', 'ID1607072311435458734371773', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382159', 'ID1607072155411398743731190', 'ID1607072311435458734371774', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382160', 'ID1607072155411398743731193', 'ID1607072311435458734371775', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382161', 'ID1607072155411398743731060', 'ID1607072311435458734371776', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382162', 'ID1607072155411398743731243', 'ID1607072311435458734371777', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382163', 'ID1607072155411398743731242', 'ID1607072311435458734371777', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382164', 'ID1607072155411398743731482', 'ID1607072311435458734371778', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382165', 'ID1607072155411398743731208', 'ID1607072311435458734371778', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382166', 'ID1607072155411398743731193', 'ID1607072311435458734371779', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382167', 'ID1607072155411398743731082', 'ID1607072311435458734371780', 'ID1606072147401110292952758', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382168', 'ID1607072155411398743731597', 'ID1607072311435458734371781', 'ID1607072155411398743731597', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382169', 'ID1607072155411398743731217', 'ID1607072311435458734371782', 'ID1606041955182025798492067', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382170', 'ID1607072155411398743731173', 'ID1607072311435458734371783', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382171', 'ID1607072155411398743731449', 'ID1607072311435458734371784', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382172', 'ID1607072155411398743731146', 'ID1607072311435458734371148', 'ID1606072147401110292952758', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382173', 'ID1607072155411398743731362', 'ID1607072311435458734371786', 'ID1607072155411398743731442', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382174', 'ID1607072155411398743731455', 'ID1606041932435458734374230', 'ID1607072155411398743731525', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382175', 'ID1607072155411398743731391', 'ID1606041932435458734374230', 'ID1607072155411398743731525', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382177', 'ID1607072155411398743731463', 'ID1607072311435458734371788', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382178', 'ID1607072155411398743731625', 'ID1607072311435458734371789', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382179', 'ID1607072155411398743731347', 'ID1607072311435458734371790', 'ID1607072155411398743731362', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382180', 'ID1607072155411398743731208', 'ID1607072311435458734371791', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382181', 'ID1607072155411398743731081', 'ID1607072311435458734371792', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382182', 'ID1607072155411398743731193', 'ID1607072311435458734371792', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382183', 'ID1607072155411398743731418', 'ID1607072311435458734371792', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382184', 'ID1607072155411398743731553', 'ID1607072311435458734371793', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382185', 'ID1607072155411398743731243', 'ID1607072311435458734371794', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382186', 'ID1607072155411398743731022', 'ID1607072311435458734371794', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382187', 'ID1607072155411398743731242', 'ID1607072311435458734371794', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382188', 'ID1607072155411398743731018', 'ID1607072311435458734371795', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382189', 'ID1607072155411398743731215', 'ID1607072311435458734371796', 'ID1607072155411398743731521', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382190', 'ID1607072155411398743731238', 'ID1607072311435458734371797', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382191', 'ID1607072155411398743731610', 'ID1607072311435458734371798', 'ID1607072155411398743731261', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382192', 'ID1607072155411398743731258', 'ID1607072311435458734371799', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382193', 'ID1607072155411398743731545', 'ID1607072311435458734371800', 'ID1607072155411398743731345', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382194', 'ID1607072155411398743731350', 'ID1607072311435458734371801', 'ID1607072155411398743731391', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382195', 'ID1607072155411398743731192', 'ID1607072311435458734371802', 'ID1607072155411398743731354', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382196', 'ID1607072155411398743731536', 'ID1607072311435458734371802', 'ID1607072155411398743731354', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382197', 'ID1607072155411398743731589', 'ID1607072311435458734371803', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382198', 'ID1607072155411398743731553', 'ID1607072311435458734371804', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382199', 'ID1607072155411398743731246', 'ID1607072311435458734371805', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382200', 'ID1607072155411398743731137', 'ID1607072311435458734371806', 'ID1607072155411398743731028', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382201', 'ID1607072155411398743731463', 'ID1607072311435458734371807', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382202', 'ID1607072155411398743731599', 'ID1607072311435458734371808', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382203', 'ID1607072155411398743731521', 'ID1607072311435458734371809', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382204', 'ID1607072155411398743731060', 'ID1607072311435458734371810', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382205', 'ID1606041548221626379288007', 'ID1607072311435458734371810', 'ID1606041455442065173847803', 0, 0, 0, 1, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382206', 'ID1607072155411398743731160', 'ID1607072311435458734371810', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382207', 'ID1607072155411398743731221', 'ID1607072311435458734371811', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382208', 'ID1607072155411398743731350', 'ID1607072311435458734371812', 'ID1607072155411398743731597', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382209', 'ID1607072155411398743731060', 'ID1607072311435458734371812', 'ID1607072155411398743731597', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382210', 'ID1607072155411398743731242', 'ID1607072311435458734371813', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382211', 'ID1607072155411398743731354', 'ID1607072311435458734371813', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382212', 'ID1607072155411398743731243', 'ID1607072311435458734371813', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382213', 'ID1607072155411398743731060', 'ID1607072311435458734371814', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382214', 'ID1606041548221626379288007', 'ID1607072311435458734371814', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382215', 'ID1607072155411398743731191', 'ID1607072311435458734371815', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382216', 'ID1607072155411398743731494', 'ID1607072311435458734371816', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382217', 'ID1607072155411398743731192', 'ID1607072311435458734371816', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382218', 'ID1607072155411398743731332', 'ID1607072311435458734371816', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382219', 'ID1607072155411398743731025', 'ID1607072311435458734371816', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382220', 'ID1607072155411398743731350', 'ID1607072311435458734371817', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382221', 'ID1607072155411398743731053', 'ID1607072311435458734371818', 'ID1607072155411398743731525', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382222', 'ID1607072155411398743731314', 'ID1607072311435458734371818', 'ID1607072155411398743731525', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382223', 'ID1607072155411398743731529', 'ID1607072311435458734371818', 'ID1607072155411398743731525', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382224', 'ID1607072155411398743731029', 'ID1607072311435458734371818', 'ID1607072155411398743731525', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382225', 'ID1607072155411398743731449', 'ID1607072311435458734371819', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382226', 'ID1607072155411398743731354', 'ID1607072311435458734371820', 'ID1607072155411398743731354', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382227', 'ID1607072155411398743731350', 'ID1607072311435458734371821', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382228', 'ID1607072155411398743731090', 'ID1607072311435458734371822', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382229', 'ID1607072155411398743731362', 'ID1607072311435458734371823', 'ID1607072155411398743731228', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382230', 'ID1607072155411398743731050', 'ID1607072311435458734371824', 'ID1607072155411398743731093', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382231', 'ID1607072155411398743731274', 'ID1607072311435458734371824', 'ID1607072155411398743731093', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382232', 'ID1607072155411398743731469', 'ID1607072311435458734371825', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382233', 'ID1606041548221626379288007', 'ID1607072311435458734371826', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382234', 'ID1607072155411398743731505', 'ID1607072311435458734371827', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382235', 'ID1607072155411398743731476', 'ID1607072311435458734371828', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382236', 'ID1607072155411398743731407', 'ID1607072311435458734371829', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382237', 'ID1607072155411398743731437', 'ID1607072311435458734371830', 'ID1607072155411398743731354', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382238', 'ID1607072155411398743731362', 'ID1607072311435458734371831', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382239', 'ID1607072155411398743731444', 'ID1607072311435458734371832', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382240', 'ID1607072155411398743731190', 'ID1607072311435458734371833', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382241', 'ID1607072155411398743731449', 'ID1607072311435458734371834', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382242', 'ID1607072155411398743731613', 'ID1607072311435458734371835', 'ID1607072155411398743731471', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382243', 'ID1607072155411398743731042', 'ID1607072311435458734371835', 'ID1607072155411398743731471', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382244', 'ID1607072155411398743731394', 'ID1607072311435458734371835', 'ID1607072155411398743731471', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382245', 'ID1607072155411398743731190', 'ID1607072311435458734371836', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382246', 'ID1607072155411398743731362', 'ID1607072311435458734371837', 'ID1606041948737864364386236', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382247', 'ID1607072155411398743731274', 'ID1607072311435458734371837', 'ID1606041948737864364386236', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382248', 'ID1607072155411398743731586', 'ID1607072311435458734371838', 'ID1607072155411398743731586', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382249', 'ID1607072155411398743731463', 'ID1607072311435458734371838', 'ID1607072155411398743731586', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382250', 'ID1607072155411398743731362', 'ID1607072311435458734371839', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382251', 'ID1607072155411398743731437', 'ID1607072311435458734371840', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382252', 'ID1607072155411398743731504', 'ID1607072311435458734371841', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382253', 'ID1606041548221626379288007', 'ID1607072311435458734371842', 'ID1607072155411398743731556', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382254', 'ID1607072155411398743731284', 'ID1607072311435458734371843', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382255', 'ID1607072155411398743731570', 'ID1607072311435458734371844', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382256', 'ID1607072155411398743731350', 'ID1607072311435458734371845', 'ID1607072155411398743731624', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382257', 'ID1607072155411398743731258', 'ID1607072311435458734371846', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382258', 'ID1607072155411398743731494', 'ID1607072311435458734371847', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382259', 'ID1607072155411398743731109', 'ID1607072311435458734371848', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382260', 'ID1607072155411398743731060', 'ID1607072311435458734371848', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382261', 'ID1607072155411398743731530', 'ID1607072311435458734371849', 'ID1607072155411398743731454', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382262', 'ID1607072155411398743731516', 'ID1607072311435458734371850', 'ID1607072155411398743731577', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382263', 'ID1607072155411398743731354', 'ID1607072311435458734371851', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382264', 'ID1607072155411398743731258', 'ID1607072311435458734371852', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382265', 'ID1607072155411398743731407', 'ID1607072311435458734371853', 'ID1607072155411398743731070', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382266', 'ID1607072155411398743731203', 'ID1607072311435458734371854', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382267', 'ID1607072155411398743731113', 'ID1607072311435458734371854', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382268', 'ID1607072155411398743731501', 'ID1607072311435458734371854', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382269', 'ID1607072155411398743731482', 'ID1607072311435458734371855', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382270', 'ID1607072155411398743731208', 'ID1607072311435458734371855', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382271', 'ID1607072155411398743731141', 'ID1607072311435458734371856', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382272', 'ID1607072155411398743731391', 'ID1607072311435458734371857', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382273', 'ID1607072155411398743731521', 'ID1607072311435458734371858', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382274', 'ID1607072155411398743731228', 'ID1607072311435458734371859', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382275', 'ID1607072155411398743731015', 'ID1607072311435458734371859', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382276', 'ID1607072155411398743731449', 'ID1607072311435458734371860', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382277', 'ID1607072155411398743731577', 'ID1607072311435458734371861', 'ID1607072155411398743731577', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382278', 'ID1607072155411398743731362', 'ID1607072311435458734371862', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382279', 'ID1606041948737864364386236', 'ID1607072311435458734371863', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382280', 'ID1607072155411398743731141', 'ID1607072311435458734371864', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382281', 'ID1607072155411398743731141', 'ID1607072311435458734371865', 'ID1606041948737864364386236', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382282', 'ID1607072155411398743731226', 'ID1607072311435458734371866', 'ID1607072155411398743731516', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382283', 'ID1607072155411398743731442', 'ID1607072311435458734371867', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382284', 'ID1607072155411398743731444', 'ID1607072311435458734371868', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382285', 'ID1607072155411398743731221', 'ID1607072311435458734371869', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382286', 'ID1607072155411398743731362', 'ID1607072311435458734371870', 'ID1606041948737864364386236', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382287', 'ID1607072155411398743731362', 'ID1607072311435458734371871', 'ID1607072155411398743731362', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382288', 'ID1607072155411398743731268', 'ID1607072311435458734371872', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382289', 'ID1607072155411398743731293', 'ID1607072311435458734371873', 'ID1607072155411398743731028', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382290', 'ID1607072155411398743731386', 'ID1607072311435458734371874', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382291', 'ID1607072155411398743731190', 'ID1607072311435458734371875', 'ID1607072155411398743731521', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382292', 'ID1607072155411398743731267', 'ID1607072311435458734371876', 'ID1607072155411398743731267', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382293', 'ID1607072155411398743731265', 'ID1607072311435458734371876', 'ID1607072155411398743731267', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382294', 'ID1607072155411398743731113', 'ID1607072311435458734371877', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382295', 'ID1607072155411398743731501', 'ID1607072311435458734371877', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382296', 'ID1607072155411398743731203', 'ID1607072311435458734371877', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382297', 'ID1606041548221626379288007', 'ID1607072311435458734371878', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382298', 'ID1607072155411398743731060', 'ID1607072311435458734371878', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382299', 'ID1607072155411398743731362', 'ID1607072311435458734371879', 'ID1607072155411398743731015', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382300', 'ID1607072155411398743731506', 'ID1607072311435458734371880', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382301', 'ID1607072155411398743731246', 'ID1607072311435458734371881', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382302', 'ID1607072155411398743731242', 'ID1607072311435458734371881', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382303', 'ID1607072155411398743731031', 'ID1607072311435458734371881', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382304', 'ID1607072155411398743731442', 'ID1607072311435458734371882', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382305', 'ID1607072155411398743731282', 'ID1607072311435458734371883', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382306', 'ID1607072155411398743731183', 'ID1607072311435458734371884', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382307', 'ID1607072155411398743731180', 'ID1607072311435458734371884', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382308', 'ID1607072155411398743731060', 'ID1607072311435458734371885', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382309', 'ID1607072155411398743731014', 'ID1607072311435458734371886', 'ID1607072155411398743731565', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382310', 'ID1607072155411398743731521', 'ID1607072311435458734371888', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382311', 'ID1607072155411398743731191', 'ID1607072311435458734371889', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382312', 'ID1607072155411398743731028', 'ID1607072311435458734371890', 'ID1607072155411398743731038', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382313', 'ID1607072155411398743731362', 'ID1607072311435458734371891', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382314', 'ID1607072155411398743731164', 'ID1607072311435458734371892', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382315', 'ID1607072155411398743731444', 'ID1607072311435458734371893', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382316', 'ID1607072155411398743731362', 'ID1607072311435458734371894', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382317', 'ID1607072155411398743731362', 'ID1607072311435458734371895', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382318', 'ID1607072155411398743731521', 'ID1607072311435458734371896', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382319', 'ID1606041548221626379288007', 'ID1607072311435458734371897', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382320', 'ID1607072155411398743731362', 'ID1607072311435458734371898', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382321', 'ID1607072155411398743731191', 'ID1607072311435458734371899', 'ID1607072155411398743731036', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382322', 'ID1607072155411398743731530', 'ID1607072311435458734371900', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382323', 'ID1607072155411398743731210', 'ID1607072311435458734371900', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382324', 'ID1607072155411398743731310', 'ID1607072311435458734371901', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382325', 'ID1607072155411398743731449', 'ID1607072311435458734371902', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382326', 'ID1607072155411398743731362', 'ID1607072311435458734371903', 'ID1607072155411398743731362', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382327', 'ID1607072155411398743731408', 'ID1607072311435458734371904', 'ID1607072155411398743731476', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382328', 'ID1607072155411398743731242', 'ID1607072311435458734371905', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382329', 'ID1607072155411398743731243', 'ID1607072311435458734371905', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382331', 'ID1607072155411398743731484', 'ID1607072311435458734371907', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382332', 'ID1607072155411398743731137', 'ID1607072311435458734371908', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382333', 'ID1607072155411398743731362', 'ID1607072311435458734371909', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382334', 'ID1607072155411398743731449', 'ID1607072311435458734371910', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382335', 'ID1607072155411398743731362', 'ID1607072311435458734371911', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382336', 'ID1607072155411398743731597', 'ID1607072311435458734371911', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382337', 'ID1607072155411398743731247', 'ID1607072311435458734371912', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382338', 'ID1607072155411398743731362', 'ID1607072311435458734371913', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382339', 'ID1607072155411398743731152', 'ID1607072311435458734371914', 'ID1607072155411398743731577', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382340', 'ID1607072155411398743731038', 'ID1607072311435458734371915', 'ID1607072155411398743731037', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382341', 'ID1607072155411398743731226', 'ID1607072311435458734371916', 'ID1607072155411398743731577', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382342', 'ID1607072155411398743731060', 'ID1607072311435458734371917', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382343', 'ID1607072155411398743731251', 'ID1607072311435458734371918', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382344', 'ID1607072155411398743731210', 'ID1607072311435458734371919', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382345', 'ID1607072155411398743731242', 'ID1607072311435458734371920', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382346', 'ID1607072155411398743731521', 'ID1607072311435458734371921', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382347', 'ID1607072155411398743731268', 'ID1607072311435458734371922', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382348', 'ID1607072155411398743731491', 'ID1607072311435458734371923', 'ID1607072155411398743731328', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382349', 'ID1607072155411398743731173', 'ID1607072311435458734371924', 'ID1607072155411398743731082', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382350', 'ID1607072155411398743731106', 'ID1607072311435458734371925', 'ID1607072155411398743731029', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382351', 'ID1607072155411398743731367', 'ID1607072311435458734371926', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382353', 'ID1607072155411398743731208', 'ID1607072311435458734371928', 'ID1607072155411398743731165', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382354', 'ID1607072155411398743731437', 'ID1607072311435458734371929', 'ID1606041946579183194460162', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382355', 'ID1607072155411398743731014', 'ID1607072311435458734371930', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382356', 'ID1607072155411398743731354', 'ID1607072311435458734371931', 'ID1607072155411398743731354', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382357', 'ID1607072155411398743731258', 'ID1607072311435458734371932', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382358', 'ID1607072155411398743731563', 'ID1607072311435458734371933', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382359', 'ID1607072155411398743731362', 'ID1607072311435458734371934', 'ID1607072155411398743731036', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382360', 'ID1607072155411398743731293', 'ID1607072311435458734371935', 'ID1607072155411398743731007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382361', 'ID1607072155411398743731060', 'ID1607072311435458734371936', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382362', 'ID1607072155411398743731418', 'ID1607072311435458734371937', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382363', 'ID1607072155411398743731586', 'ID1607072311435458734371939', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382364', 'ID1607072155411398743731388', 'ID1607072311435458734371940', 'ID1607072155411398743731191', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382365', 'ID1607072155411398743731014', 'ID1607072311435458734371941', 'ID1607072155411398743731094', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382366', 'ID1607072155411398743731139', 'ID1607072311435458734371942', 'ID1607072155411398743731491', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382367', 'ID1607072155411398743731437', 'ID1607072311435458734371943', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382368', 'ID1607072155411398743731062', 'ID1607072311435458734371944', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382369', 'ID1607072155411398743731463', 'ID1607072311435458734371944', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382370', 'ID1607072155411398743731173', 'ID1607072311435458734371945', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382371', 'ID1607072155411398743731364', 'ID1607072311435458734371946', 'ID1606041948737864364386236', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382372', 'ID1607072155411398743731281', 'ID1607072311435458734371947', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382373', 'ID1607072155411398743731053', 'ID1607072311435458734371948', 'ID1607072155411398743731177', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382374', 'ID1607072155411398743731065', 'ID1607072311435458734371948', 'ID1607072155411398743731177', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382375', 'ID1607072155411398743731145', 'ID1607072311435458734371948', 'ID1607072155411398743731177', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382376', 'ID1607072155411398743731444', 'ID1607072311435458734371949', 'ID1607072155411398743731488', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382377', 'ID1607072155411398743731116', 'ID1607072311435458734371950', 'ID1606041948737864364386236', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382378', 'ID1607072155411398743731145', 'ID1607072311435458734371950', 'ID1606041948737864364386236', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382379', 'ID1607072155411398743731488', 'ID1607072311435458734371951', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382380', 'ID1607072155411398743731362', 'ID1607072311435458734371952', 'ID1607072155411398743731060', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382381', 'ID1607072155411398743731350', 'ID1607072311435458734371953', 'ID1607072155411398743731217', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382382', 'ID1607072155411398743731237', 'ID1607072311435458734371954', 'ID1607072155411398743731287', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382383', 'ID1607072155411398743731354', 'ID1607072311435458734371955', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382384', 'ID1607072155411398743731449', 'ID1607072311435458734371955', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382385', 'ID1607072155411398743731070', 'ID1607072311435458734371956', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382386', 'ID1607072155411398743731193', 'ID1607072311435458734371957', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382387', 'ID1607072155411398743731325', 'ID1607072311435458734371958', 'ID1607072155411398743731090', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382388', 'ID1607072155411398743731417', 'ID1607072311435458734371959', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382389', 'ID1607072155411398743731597', 'ID1607072311435458734371959', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382390', 'ID1607072155411398743731407', 'ID1607072311435458734371960', 'ID1607072155411398743731036', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382391', 'ID1607072155411398743731354', 'ID1607072311435458734371961', 'ID1606041954092518736647987', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382392', 'ID1606041548221626379288007', 'ID1607072311435458734371962', 'ID1607072155411398743731413', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382393', 'ID1607072155411398743731070', 'ID1607072311435458734371962', 'ID1607072155411398743731413', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382394', 'ID1607072155411398743731060', 'ID1607072311435458734371962', 'ID1607072155411398743731413', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382395', 'ID1606041548221626379288007', 'ID1607072311435458734371963', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382396', 'ID1607072155411398743731504', 'ID1607072311435458734371964', 'ID1607072155411398743731523', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382397', 'ID1606041548221626379288007', 'ID1607072311435458734371965', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382398', 'ID1607072155411398743731533', 'ID1607072311435458734371966', 'ID1607072155411398743731352', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382399', 'ID1607072155411398743731208', 'ID1607072311435458734371966', 'ID1607072155411398743731352', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382400', 'ID1607072155411398743731283', 'ID1607072311435458734371967', 'ID1607072155411398743731593', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382401', 'ID1607072155411398743731060', 'ID1607072311435458734371968', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382402', 'ID1607072155411398743731559', 'ID1607072311435458734371969', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382403', 'ID1607072155411398743731210', 'ID1607072311435458734371970', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382404', 'ID1607072155411398743731083', 'ID1607072311435458734371971', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382405', 'ID1607072155411398743731111', 'ID1607072311435458734371972', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382406', 'ID1607072155411398743731362', 'ID1607072311435458734371973', 'ID1607072155411398743731275', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382407', 'ID1607072155411398743731516', 'ID1607072311435458734371974', 'ID1607072155411398743731226', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382408', 'ID1607072155411398743731203', 'ID1607072311435458734371975', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382409', 'ID1607072155411398743731367', 'ID1607072311435458734371976', 'ID1607072155411398743731028', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382410', 'ID1607072155411398743731471', 'ID1607072311435458734371976', 'ID1607072155411398743731028', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382411', 'ID1607072155411398743731033', 'ID1607072311435458734371977', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382412', 'ID1607072155411398743731062', 'ID1607072311435458734371978', 'ID1607072155411398743731246', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382413', 'ID1607072155411398743731565', 'ID1607072311435458734371979', 'ID1607072155411398743731014', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382414', 'ID1607072155411398743731523', 'ID1607072311435458734371980', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382415', 'ID1607072155411398743731484', 'ID1607072311435458734371981', 'ID1606041954484897026617976', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382416', 'ID1607072155411398743731340', 'ID1607072311435458734371982', 'ID1606041956071866919035499', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382417', 'ID1607072155411398743731417', 'ID1607072311435458734371983', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382418', 'ID1607072155411398743731124', 'ID1607072311435458734371984', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382419', 'ID1607072155411398743731265', 'ID1607072311435458734371985', 'ID1607072155411398743731267', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382420', 'ID1607072155411398743731340', 'ID1607072311435458734371986', 'ID1607072155411398743731146', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382421', 'ID1607072155411398743731295', 'ID1607072311435458734371987', 'ID1607072155411398743731295', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382422', 'ID1607072155411398743731173', 'ID1607072311435458734371988', 'ID1607072155411398743731552', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382423', 'ID1607072155411398743731597', 'ID1607072311435458734371989', 'ID1607072155411398743731362', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382424', 'ID1607072155411398743731140', 'ID1607072311435458734371990', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382425', 'ID1606041548221626379288007', 'ID1607072311435458734371991', 'ID1607072155411398743731597', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382426', 'ID1607072155411398743731601', 'ID1607072311435458734371992', 'ID1607072155411398743731332', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382427', 'ID1607072155411398743731043', 'ID1607072311435458734371993', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382428', 'ID1607072155411398743731559', 'ID1607072311435458734371994', 'ID1606072147401110292952758', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382429', 'ID1607072155411398743731090', 'ID1607072311435458734371995', 'ID1606041948737864364386236', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382430', 'ID1607072155411398743731192', 'ID1607072311435458734371996', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382431', 'ID1607072155411398743731577', 'ID1607072311435458734371997', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382432', 'ID1607072155411398743731268', 'ID1607072311435458734371998', 'ID1606041442402757730621039', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382433', 'ID1607072155411398743731461', 'ID1607072311435458734371999', 'ID1607072155411398743731036', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382434', 'ID1607072155411398743731014', 'ID1607072311435458734372000', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382435', 'ID1607072155411398743731449', 'ID1607072311435458734372001', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382436', 'ID1607072155411398743731491', 'ID1607072311435458734372002', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382437', 'ID1607072155411398743731469', 'ID1607072311435458734372003', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382438', 'ID1607072155411398743731559', 'ID1607072311435458734372004', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382439', 'ID1607072155411398743731426', 'ID1607072311435458734372005', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382440', 'ID1607072155411398743731242', 'ID1607072311435458734372006', 'ID1607072155411398743731192', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382441', 'ID1607072155411398743731243', 'ID1607072311435458734372006', 'ID1607072155411398743731192', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382442', 'ID1607072155411398743731230', 'ID1607072311435458734372007', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382443', 'ID1607072155411398743731327', 'ID1607072311435458734372008', 'ID1606202304011389502180611', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382444', 'ID1607072155411398743731182', 'ID1607072311435458734372009', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382445', 'ID1607072155411398743731505', 'ID1607072311435458734372010', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382446', 'ID1607072155411398743731057', 'ID1607072311435458734372011', 'ID1607072155411398743731350', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382447', 'ID1607072155411398743731597', 'ID1607072311435458734372013', 'ID1606041548221626379288007', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382448', 'ID1607072155411398743731491', 'ID1607072311435458734372014', 'ID1607072155411398743731208', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382449', 'ID1607072155411398743731407', 'ID1607072311435458734372015', 'ID1607072155411398743731630', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382450', 'ID1607072155411398743731090', 'ID1607072311435458734372016', 'ID1606041948737864364386236', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382451', 'ID1607072155411398743731265', 'ID1607072311435458734372017', 'ID1607072155411398743731267', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1606051051204028919382452', 'ID1607072155411398743731208', 'ID1607072311435458734372018', 'ID1606041455442065173847803', 0, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1709060927024687575175207', 'ID1606041548221626379288007', 'ID1606041932435458734374278', 'ID1606041442402757730621039', 8, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1709251513503794901022399', 'ID1709251511316996686509516', 'ID1709251451063005579838506', 'ID1606041455442065173847803', 20, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1709251513286820087518257', 'ID1709251511316996686509516', 'ID1709251450362202983470802', 'ID1606041455442065173847803', 2, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1709251513178861816544539', 'ID1709251511316996686509516', 'ID1709251450199129629699036', 'ID1606041455442065173847803', 2, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1709251513063998114916221', 'ID1709251511316996686509516', 'ID1709251449490325484855804', 'ID1606041455442065173847803', 12, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1709251512531154517002201', 'ID1709251511316996686509516', 'ID1709251449290719438182141', 'ID1606041455442065173847803', 60, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1709251512318385517161181', 'ID1709251511316996686509516', 'ID1709251448406654892411984', 'ID1606041455442065173847803', 12, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1709251504240806719329808', 'ID1709251503588982155402409', 'ID1709251452071034415624840', 'ID1606041455442065173847803', 12, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1709251504498406726033949', 'ID1709251503588982155402409', 'ID1709251452390655948308095', 'ID1606041455258139966562852', 8, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1709251505061434811877653', 'ID1709251503588982155402409', 'ID1709251453076624266428834', 'ID1606041455258139966562852', 8, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1709251514478403159685403', 'ID1709251511316996686509516', 'ID1709251510552855215377793', 'ID1709251503588982155402409', 10, 0, 1, 1, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1709251647091885181940443', 'ID1709251511316996686509516', 'ID1709251452071034415624840', 'ID1606041455442065173847803', 12, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1709251647193106907074473', 'ID1709251511316996686509516', 'ID1709251452390655948308095', 'ID1606041455258139966562852', 10, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID1709251647284451733203110', 'ID1709251511316996686509516', 'ID1709251453076624266428834', 'ID1606041455258139966562852', 10, 0, 0, 0, '');
INSERT INTO `tag_base_type_field` VALUES ('ID2112061704052122933448336', 'ID2112061703425286168665094', 'ID1606041932435458734374227', 'ID1606041956071866919035499', 5, 0, 0, 0, '5555');

-- ----------------------------
-- Table structure for tag_base_type_field_express
-- ----------------------------
DROP TABLE IF EXISTS `tag_base_type_field_express`;
CREATE TABLE `tag_base_type_field_express`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '主键ID',
  `baseTypeFieldId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` int(0) NULL DEFAULT NULL COMMENT '表达类型，具体见字典表type=expressType',
  `express` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表达模板',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK9FD1446C4D22467A`(`baseTypeFieldId`) USING BTREE,
  INDEX `FK8253A30F5B4D68FE`(`baseTypeFieldId`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '基础模型属性表述模板' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tag_calculate
-- ----------------------------
DROP TABLE IF EXISTS `tag_calculate`;
CREATE TABLE `tag_calculate`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '主键ID',
  `userId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属用户ID',
  `userName` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '计算主题',
  `dataPath` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据源路径',
  `createDate` datetime(0) NULL DEFAULT NULL COMMENT '生成时间',
  `startDate` datetime(0) NULL DEFAULT NULL COMMENT '执行开始时间',
  `endDate` datetime(0) NULL DEFAULT NULL COMMENT '执行结束时间',
  `logs` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '计算日志',
  `ENABLE` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户计算配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tag_calculate
-- ----------------------------
INSERT INTO `tag_calculate` VALUES ('ID1709191438370566296032365', '1', 'admin', 't1', '/ID1709051725555586221020404', '2017-09-19 14:38:37', NULL, '2017-09-21 09:45:45', '计算成功结束', '1');
INSERT INTO `tag_calculate` VALUES ('ID1709271129395091611259394', '1', 'admin', 'GY_T2', '/ID1709251603480604761693533', '2021-12-12 14:02:30', NULL, '2019-12-03 10:36:16', '计算成功结束', '1');
INSERT INTO `tag_calculate` VALUES ('ID2112141646122280258579581', '1', 'admin', 'DS_CLIENT', '/data/admin/ID2112131310569166728092638/', '2021-12-14 16:46:12', NULL, '2022-01-10 16:17:41', '计算成功结束', '1');

-- ----------------------------
-- Table structure for tag_calculate_select
-- ----------------------------
DROP TABLE IF EXISTS `tag_calculate_select`;
CREATE TABLE `tag_calculate_select`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '主键ID',
  `calculateId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属计算ID',
  `tagId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '选择的标签ID',
  `rule` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '标签计算规则',
  `tagContent` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签内容',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKA2903A3A14D8C2C`(`calculateId`) USING BTREE,
  INDEX `FKA2903A3A80B12434`(`tagId`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户计算标签选择表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tag_calculate_select
-- ----------------------------
INSERT INTO `tag_calculate_select` VALUES ('ID1709191443257274483717616', 'ID1709191438370566296032365', 'ID1709191426432943372946123', '[{\"sql\":\"gender\\t = \\t1\",\"result\":\"1\"},{\"sql\":\"gender\\t = \\t2\",\"result\":\"2\"}]', '1:男,2:女');
INSERT INTO `tag_calculate_select` VALUES ('ID1709191443257387406105655', 'ID1709191438370566296032365', 'ID1606292029338045132967557', '[{\"sql\":\"sum(financing.balance)\\t >= \\t10000\",\"result\":\"1\"},{\"sql\":\"(\\t(tsum(financing.balance)\\t < \\t10000\\t)\\t and \\t(\\tsum(financing.balance)\\t >= \\t5000\\t)\\t)\",\"result\":\"2\"},{\"sql\":\"sum(financing.balance)\\t < \\t5000\",\"result\":\"3\"}]', '1:高端客户,2:中端客户,3:低端客户');
INSERT INTO `tag_calculate_select` VALUES ('ID1907291700534085644103857', 'ID1709271129395091611259394', 'ID1907291649275525161434603', '[{\"sql\":\"USR_COUNT\\t >= \\t10\",\"result\":\"1\"},{\"sql\":\"(\\t(\\tUSR_COUNT\\t >= \\t4\\t)\\t and \\t(\\tUSR_COUNT\\t < \\t10\\t)\\t)\",\"result\":\"2\"},{\"sql\":\"USR_COUNT\\t < \\t4\",\"result\":\"3\"}]', '1:风控活跃客户,2:风控一般客户,3:风控沉默客户');
INSERT INTO `tag_calculate_select` VALUES ('ID1907291700534264781447840', 'ID1709271129395091611259394', 'ID1907291652217870869935226', '[{\"result\":\"0\",\"sql\":\"USR_MIN_DT\\u0002 >= \\u0002111\"},{\"result\":\"1\",\"sql\":\"USR_MIN_DT\\u0002 <= \\u000220180101\"},{\"result\":\"2\",\"sql\":\"USR_MIN_DT\\u0002 >= \\u000220180101\"}]', '1:风控老客户,2:风控新客户');
INSERT INTO `tag_calculate_select` VALUES ('ID2112141808193950110845116', 'ID2112141646122280258579581', 'ID2112121744344949468976184', '[{\"result\":\"1\",\"sql\":\"(\\t(\\tDS_USER_AGE\\t < \\t40\\t)\\t and \\t(\\tDS_USER_AGE\\t >= \\t30\\t)\\t)\"},{\"result\":\"2\",\"sql\":\"(\\t(\\tDS_USER_AGE\\t < \\t30\\t)\\t and \\t(\\tDS_USER_AGE\\t >= \\t20\\t)\\t)\"},{\"result\":\"3\",\"sql\":\"DS_USER_AGE\\t < \\t20\"},{\"result\":\"4\",\"sql\":\"DS_USER_AGE\\t >= \\t40\"}]', '1:80后,2:90后,3:00后,4:70后');
INSERT INTO `tag_calculate_select` VALUES ('ID2201101614494916665019257', 'ID2112141646122280258579581', 'ID2112121746288599756274827', '[{\"result\":\"1\",\"sql\":\"DS_USER_AGE\\t <= \\t20\"},{\"result\":\"2\",\"sql\":\"(\\t(\\tDS_USER_AGE\\t > \\t20\\t)\\t and \\t(\\tDS_USER_AGE\\t <= \\t40\\t)\\t)\"},{\"result\":\"3\",\"sql\":\"DS_USER_AGE\\t >= \\t40\"}]', '1:青少年,2:中年,3:老年');

-- ----------------------------
-- Table structure for tag_data_type_element
-- ----------------------------
DROP TABLE IF EXISTS `tag_data_type_element`;
CREATE TABLE `tag_data_type_element`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '主键ID',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '要素编码',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '要素名称',
  `enable` int(0) NULL DEFAULT NULL COMMENT '是否可用：1可用，0不可用',
  `memo` varchar(3000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '数据类型要素表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tag_data_type_element
-- ----------------------------
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374223', 'closeStaffLabel', '销户员工标识', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374203', 'honorificPrefix', '客户称谓', 1, '如先生、女士等。');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374204', 'englishName', '英文名称', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374205', 'identificationType', '证件类型', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374206', 'identificationNumber', '证件号码', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374207', 'effectiveDate', '生效日期', 1, '所有的生效日期用该名称');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374208', 'expirationDate', '失效日期', 1, '所有失效日期都用该名称');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374209', 'issuingAuthority', '发证机关', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374210', 'gender', '性别', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374211', 'age', '年龄', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374212', 'birthDate', '出生日期（公历）', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374213', 'lunarBirthDate', '出生日期（农历）', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374214', 'nation', '民族', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374215', 'nationality', '国籍', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374216', 'birthPlace', '出生地', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374217', 'originPlace', '籍贯', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374218', 'effectiveAgency', '客户生效机构', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374219', 'managementAgency', '客户管理机构', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374220', 'closeAgency', '客户销户机构', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374221', 'createStaffLabel', '创建员工标识', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374222', 'managementStaffLabel', '管理员工标识', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374224', 'contactType', '联系类别', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374225', 'contactContent', '联系方式内容', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374226', 'contactOrder', '联系方式序号', 1, '同类联系方式按重要性或生成日期排序。');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374227', 'addressType', '地址类别', 1, '如户籍地址、现居住地址、单位地址、家庭地址等。');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374228', 'addressDetail', '详细地址', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374229', 'addressOrder', '地址序号', 1, '按重要性或生成日期排序。');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374230', 'addressCountry', '地址所属国别', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374231', 'addressLocality', '地址所属省份', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374232', 'addressCity', '地址所属城市', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374233', 'addressRegion', '地址所属区县', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374234', 'addressStreet', '地址所属街道', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374235', 'certificationType', '认证类型', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374236', 'certificationDate', '认证时间', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374237', 'certificationAgencyLabel', '认证机构标识', 1, '如无法获取认证机构标识，存放认证机构组织机构代码或机构信用代码证等证件号码信息。');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374238', 'certificationLevels', '认证等级', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374239', 'certificationAgencyName', '认证机构名称', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374240', 'certificationAgencyType', '认证机构所属类别', 1, '如按行业划分类别。');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374241', 'agencyQualification', '认证机构资质', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374242', 'familyRelationsCode', '家庭关系代码', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374243', 'familyMemberLabel', '家庭成员标识', 1, '如是公司客户，存放公司客户唯一标识，否则存放证件号码。');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374244', 'familyMemberCall', '家庭成员称呼', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374245', 'cohabiting', '是否共同居住', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374246', 'familyMembername', '家庭成员姓名', 1, '目前做冗余设计，后续模型扩展后完成修改。');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374247', 'familyMemberNumber', '家庭人口数', 1, '目前做冗余设计，后续模型扩展后完成修改。');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374248', 'familyMemberHealth', '成员健康状况', 1, '目前做冗余设计，后续模型扩展后完成修改。');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374249', 'childNumber', '子女人口数', 1, '目前做冗余设计，后续模型扩展后完成修改。');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374250', 'schoolLabel', '就读学校标识', 1, '就读学校唯一标识。');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374251', 'startDate', '起始时间', 1, 'The start date and time of the item (in <a href=\"http://en.wikipedia.org/wiki/ISO_8601\">ISO 8601 date format</a>)');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374252', 'endDate', '截止时间', 1, 'The end date and time of the item (in <a href=\"http://en.wikipedia.org/wiki/ISO_8601\">ISO 8601 date format</a>).\r\n');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374253', 'educationCategory', '教育分类', 1, '如孝悌教育,道德教育,胎教,学龄前教育,少儿教育,经典教育,初等教育,中等教育,高等教育,研究生教育,本科教育、大学教育,计算机教育,高职教育,专科教育,义务教育,终身教育,职业教育,成人教育,开放教育,继续教育,干部教育,远程教育,函授教育,工读教育,数学教育,语言教育,阅读教育,科学教育,资讯教育,社会科学教育,艺术教育,家庭教育,特殊教育,资优教育,补习教育,性教育,一对一教育等。');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374254', 'educationAgency', '教育机构', 1, '如托儿所,幼儿园,小学,中专职业学校,初中,高中,高级职业学校,技术学院,专科学校,大学,书院,研究院,进修班,培训班,补习班等。');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374255', 'educated', '学历', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374256', 'degree', '学位', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374257', 'department', '某个机构的一部分', 1, 'A relationship between an organization and a department of that organization, also described as an organization (allowing different urls, logos, opening hours). For example: a store with a pharmacy, or a bakery with a cafe.');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374258', 'professional', '就读专业', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374259', 'class', '就读班级', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374260', 'schoolName', '就读学校名称', 1, '目前做冗余设计，后续模型扩展后完成修改。');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374261', 'schoolLocation', '就读学校所属省份', 1, '目前做冗余设计，后续模型扩展后完成修改。');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374262', 'schoolCity', '就读学校所属城市', 1, '目前做冗余设计，后续模型扩展后完成修改。');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374263', 'schoolRegion', '就读学校所属区县', 1, '目前做冗余设计，后续模型扩展后完成修改。');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374264', 'productLabel', '产品标识', 1, '如无统一产品标识，存放存款产品标准代码。');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374265', 'subjectCode', '科目代码', 1, '参考公司内标准科目代码。');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374266', 'currency', '币种代码', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374267', 'banknoteRemitCode', '钞汇鉴别代码', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374268', 'channelCode', '渠道代码', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374269', 'firstOpenAccountDate', '最早开户日期', 1, '客户最早的账户开户日期。');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374270', 'lastOpenAccountDate', '最迟开户日期', 1, '客户最迟的账户开户日期。');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374271', 'firstCloseAccountDate', '最早销户日期', 1, '客户最早的账户销户日期。');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374272', 'lastCloseAccountDate', '最迟销户日期', 1, '客户的销户日期。');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374273', 'firstOpenAccountAgency', '最早开户机构', 1, '客户最早的账户开户机构。');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374274', 'lastOpenAccountAgency', '最迟开户机构', 1, '客户最迟的账户开户机构。');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374275', 'firstCloseAccountAgency', '最早销户机构', 1, '客户最迟的账户销户机构。');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374276', 'lastCloseAccountAgency', '最迟销户机构', 1, '客户的销户机构。');
INSERT INTO `tag_data_type_element` VALUES ('ID1606051117025316411776731', 'contact', '联系方式', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374278', 'balance', '余额', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374201', 'customerLabel', '客户标识', 1, '依据客户定义规则，唯一标识一个个人客户。');
INSERT INTO `tag_data_type_element` VALUES ('ID1606041932435458734374202', 'name', '名称', 1, 'The name of the item.');
INSERT INTO `tag_data_type_element` VALUES ('ID1606051141331033988092425', 'certificationOrder', '认证重要性排序', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606051119474914114550441', 'address', '地址', 1, 'Physical address of the item.');
INSERT INTO `tag_data_type_element` VALUES ('ID1606042029079167301989212', 'nationAddress', '户籍地址', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606042030166475745204807', 'liveAddress', '居住地址', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606051043348949309132887', 'identification', '身份证件', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606051158432071743202454', 'certification', '认证证书', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606181217245345613434796', 'unid', '记录的唯一标示', 1, '用于做记录的唯一标示，可以进行数据关联计算');
INSERT INTO `tag_data_type_element` VALUES ('ID1606181650134187851250251', 'family', '家庭关系', 1, '与人物有关的家庭关系成员');
INSERT INTO `tag_data_type_element` VALUES ('ID1606181652269278909303403', 'alumniOf', '校友关系', 1, '标示人物与那些学校有校友关系，经历了那些教育');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743910', 'signedStatus', '签约状态', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606191138354935015088932', 'loanStatus', '贷款状态', 1, '五级分类/十二级分类/一逾两呆等。');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743911', 'verificationType', '验证类型', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743912', 'signedDate', '签约日期', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743913', 'signedAgency', '签约机构', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743914', 'cancelSignedDate', '取消签约日期', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743915', 'cancelSignedAgency', '取消签约机构', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743916', 'maxDayQuota', '最大日转账额', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743917', 'maxMonthQuota', '最大月转账额', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743918', 'riskLevel', '风险等级', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743919', 'productStatus', '理财产品状态', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743920', 'productQuota', '产品份额', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743921', 'fundMarketCode', '基金市场代码', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743922', 'fundCompanyCode', '基金公司代码', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743923', 'fundCode', '基金代码', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743924', 'fundAccountStatus', '基金账号状态', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743925', 'quota', '份额', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743926', 'totalRecurringDebit', '定期扣款总额', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743927', 'securitiesAgencyLabel', '券商标识', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743928', 'securitiesAgencyClientNumber', '券商端客户号', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743929', 'openingParty', '开户方', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743930', 'cardBIN', '卡BIN', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743931', 'cardIssuer', '发卡机构', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743932', 'cardStatus', '卡状态', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743933', 'masterLabel', '主附卡标志', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743934', 'cardICLabel', 'IC卡标志', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743935', 'cardQuantity', '卡数量', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743936', 'credit', '额度', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743938', 'insuranceAgencyCode', '保险公司代码', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743939', 'handleAgency', '办理机构', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743940', 'insuranceCode', '险种代码', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743941', 'insurancePolicyStatus', '保单状态', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743942', 'statisticsTime', '统计时间', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743943', 'lendDirection', '借贷别', 1, '借贷方向');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743944', 'tradeAgency', '交易机构', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743945', 'tradeCode', '交易代码', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743946', 'tradeQuantity', '交易笔数', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606192314843784783743947', 'transactionAmounts', '交易金额', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606202206027830264746435', 'openAccountAgency', '开户机构', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606202219418721354591235', 'openAccountDate', '开户日期', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606202237150874038562908', 'temporaryCredit', '临时额度', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606202238307453082909695', 'availableCredit', '可用额度', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606202239471525469499393', 'cashLimit', '取现限额', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606202241272474728224869', 'transferLimit', '转账限额', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606202243290772724802508', 'overdueAmounts', '逾期金额', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606202245031879802485398', 'installmentCredit', '分期额度', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606202246588132257793975', 'installmentBalance', '分期余额', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606202248355338910183855', 'availableCashCredit', '可用取现额度', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606202249219553478696522', 'availableTransferCredit', '可用转账额度', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606202254523972208718678', 'insurancePolicyAmounts', '保单金额', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606222039393396027239495', 'deposit', '存款产品', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606222040104185204830178', 'loans', '贷款产品', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606222040380127910346753', 'onlineBank', '网上银行产品', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606222041114038447455289', 'mobileBank', '手机银行产品', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606222041426061756661260', 'weChatBank', '微信银行产品', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606222042164046802738821', 'phoneBank', '电话银行产品', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606222042409515635051548', 'financing', '理财产品', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606222043051081426537090', 'fund', '基金产品', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606222043336240164066664', 'fundTargetInvestment', '基金定投产品', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606222043579053460986728', 'thirdDepository', '三方存管', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606222044164053222208225', 'debitCard', '借记卡', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606222044322186558932779', 'creditCard', '信用卡', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606222045129690746631461', 'insuranceAgents', '代理保险产品', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606222045352194371235183', 'demandDepositsTrading', '个人活期存款交易', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606222046266889631640601', 'depositsTrading', '个人定期存款交易', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1606222057547918677056571', 'creditCardQuota', '信用卡额度', 1, '');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371001', 'exifData', 'exifData', 1, 'exif data for this object.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371002', 'activityDuration', 'activityDuration', 1, 'Length of time to engage in the activity.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371003', 'dateDeleted', 'dateDeleted', 1, 'The datetime the item was removed from the DataFeed.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371004', 'videoFormat', 'videoFormat', 1, 'The type of screening or video broadcast used (e.g. IMAX, 3D, SD, HD, etc.).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371005', 'frequency', 'frequency', 1, 'How often the dose is taken, e.g. \"daily\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371006', 'seatNumber', 'seatNumber', 1, 'The location of the reserved seat (e.g., 27).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371007', 'comprisedOf', 'comprisedOf', 1, 'Specifying something physically contained by something else. Typically used here for the underlying anatomical structures, such as organs, that comprise the anatomical system.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371008', 'requiresSubscription', 'requiresSubscription', 1, 'Indicates if use of the media require a subscription  (either paid or free). Allowed values are <code>true</code> or <code>false</code> (note that an earlier version had \"yes\", \"no\").');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371009', 'musicBy', 'musicBy', 1, 'The composer of the soundtrack.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371010', 'partySize', 'partySize', 1, 'Number of people the reservation should accommodate.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371011', 'startTime', 'startTime', 1, 'The startTime of something. For a reserved event or service (e.g. FoodEstablishmentReservation), the time that it is expected to start. For actions that span a period of time, when the action was performed. e.g. John wrote a book from <em>January</em> to December.</p><p>Note that Event uses startDate/endDate instead of startTime/endTime, even when describing dates with times. This situation may be clarified in future revisions.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371012', 'characterAttribute', 'characterAttribute', 1, 'A piece of data that represents a particular aspect of a fictional character (skill, power, character points, advantage, disadvantage).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371013', 'byArtist', 'byArtist', 1, 'The artist that performed this album or recording.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371014', 'clipNumber', 'clipNumber', 1, 'Position of the clip within an ordered group of clips.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371015', 'source', 'source', 1, 'The anatomical or organ system that the artery originates from.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371016', 'claimReviewed', 'claimReviewed', 1, 'A short summary of the specific claims reviewed in a ClaimReview.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371017', 'priceRange', 'priceRange', 1, 'The price range of the business, for example <code>$$$</code>.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371018', 'faxNumber', 'faxNumber', 1, 'The fax number.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371019', 'readBy', 'readBy', 1, 'A person who reads (performs) the audiobook.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371020', 'drugUnit', 'drugUnit', 1, 'The unit in which the drug is measured, e.g. \"5 mg tablet\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371021', 'naics', 'naics', 1, 'The North American Industry Classification System (NAICS) code for a particular organization or business person.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371022', 'sportsEvent', 'sportsEvent', 1, 'A sub property of location. The sports event where this action occurred.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371023', 'citation', 'citation', 1, 'A citation or reference to another creative work, such as another publication, web page, scholarly article, etc.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371024', 'videoFrameSize', 'videoFrameSize', 1, 'The frame size of the video.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371025', 'calories', 'calories', 1, 'The number of calories.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371026', 'legalStatus', 'legalStatus', 1, 'The drug or supplement\"s legal status, including any controlled substance schedules that apply.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371027', 'foodEvent', 'foodEvent', 1, 'A sub property of location. The specific food event where the action occurred.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371028', 'numberOfDoors', 'numberOfDoors', 1, 'The number of doors.<br /> Typical unit code(s): C62');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371029', 'courseCreditsUnit', 'courseCreditsUnit', 1, 'The type of credit associated with the credits earned for the Course. (e.g. TODO NoCredit, Quarter, Semester, CarnegieUnits, ContinuingEducationUnits, ClockHours, Other)');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371030', 'courseCredits', 'courseCredits', 1, 'The number of credits offered for the Course toward an academic goal.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371031', 'globalLocationNumber', 'globalLocationNumber', 1, 'The <a href=\"http://www.gs1.org/gln\">Global Location Number</a> (GLN, sometimes also referred to as International Location Number or ILN) of the respective organization, person, or place. The GLN is a 13-digit number used to identify parties and physical locations.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371032', 'requiredMinAge', 'requiredMinAge', 1, 'Audiences defined by a person\"s minimum age.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371033', 'valueMaxLength', 'valueMaxLength', 1, 'Specifies the allowed range for number of characters in a literal value.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371034', 'requiredCollateral', 'requiredCollateral', 1, 'Assets required to secure loan or credit repayments. It may take form of third party pledge, goods, financial instruments (cash, securities, etc.)');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371035', 'image', 'image', 1, 'An image of the item. This can be a <a href=\"http://schema.org/URL\">URL</a> or a fully described <a href=\"http://schema.org/ImageObject\">ImageObject</a>.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371036', 'value', 'value', 1, 'The value of the quantitative value or property value node.<br/>     For QuantitativeValue and MonetaryValue, the recommended type for values is \"Number\". <br/>     For PropertyValue, it can be \"Text;\", \"Number\", \"Boolean\", or \"StructuredValue\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371037', 'availableAtOrFrom', 'availableAtOrFrom', 1, 'The place(s) from which the offer can be obtained (e.g. store locations).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371038', 'drug', 'drug', 1, 'Specifying a drug or medicine used in a medication procedure');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371039', 'creator', 'creator', 1, 'The creator/author of this CreativeWork. This is the same as the Author property for CreativeWork.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371040', 'regionDrained', 'regionDrained', 1, 'The anatomical or organ system drained by this vessel; generally refers to a specific part of an organ.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371041', 'depth', 'depth', 1, 'The depth of the item.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371042', 'targetPopulation', 'targetPopulation', 1, 'Characteristics of the population for which this is intended, or which typically uses it, e.g. \"adults\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371043', 'countriesNotSupported', 'countriesNotSupported', 1, 'Countries for which the application is not supported. You can also provide the two-letter ISO 3166-1 alpha-2 country code.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371044', 'artform', 'artform', 1, 'e.g. Painting, Drawing, Sculpture, Print, Photograph, Assemblage, Collage, etc.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371045', 'knownVehicleDamages', 'knownVehicleDamages', 1, 'A textual description of known damages, both repaired and unrepaired.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371046', 'includedDataCatalog', 'includedDataCatalog', 1, 'A data catalog which contains this dataset (this property was previously \"catalog\", preferred name is now \"includedInDataCatalog\").');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371047', 'interactingDrug', 'interactingDrug', 1, 'Another drug that is known to interact with this drug in a way that impacts the effect of this drug or causes a risk to the patient. Note: disease interactions are typically captured as contraindications.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371048', 'sampleType', 'sampleType', 1, 'Full (compile ready) solution, code snippet, inline code, scripts, template.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371049', 'healthPlanNetworkTier', 'healthPlanNetworkTier', 1, 'The tier(s) for this network.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371050', 'sourcedFrom', 'sourcedFrom', 1, 'The neurological pathway that originates the neurons.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371052', 'sportsTeam', 'sportsTeam', 1, 'A sub property of participant. The sports team that participated on this action.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371053', 'maxValue', 'maxValue', 1, 'The upper value of some characteristic or property.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371054', 'healthPlanCoinsuranceOption', 'healthPlanCoinsuranceOption', 1, 'Whether the coinsurance applies before or after deductible, etc. TODO: Is this a closed set?');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371055', 'isBasedOnUrl', 'isBasedOnUrl', 1, 'A resource that was used in the creation of this resource. This term can be repeated for multiple sources. For example, http://example.com/great-multiplication-intro.html.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371056', 'targetName', 'targetName', 1, 'The name of a node in an established educational framework.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371057', 'subReservation', 'subReservation', 1, 'The individual reservations included in the package. Typically a repeated property.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371058', 'trackingNumber', 'trackingNumber', 1, 'Shipper tracking number.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371059', 'arrivalStation', 'arrivalStation', 1, 'The station where the train trip ends.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371060', 'playersOnline', 'playersOnline', 1, 'Number of players on the server.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371061', 'directors', 'directors', 1, 'A director of e.g. tv, radio, movie, video games etc. content. Directors can be associated with individual items or with a series, episode, clip.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371062', 'trailer', 'trailer', 1, 'The trailer of a movie or tv/radio series, season, episode, etc.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371063', 'numberedPosition', 'numberedPosition', 1, 'A number associated with a role in an organization, for example, the number on an athlete\"s jersey.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371064', 'loser', 'loser', 1, 'A sub property of participant. The loser of the action.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371065', 'valueRequired', 'valueRequired', 1, 'Whether the property must be filled in to complete the action.  Default is false.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371066', 'mealService', 'mealService', 1, 'Description of the meals that will be provided or available for purchase.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371067', 'director', 'director', 1, 'A director of e.g. tv, radio, movie, video gaming etc. content, or of an event. Directors can be associated with individual items or with a series, episode, clip.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371068', 'softwareAddOn', 'softwareAddOn', 1, 'Additional content for a software application.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371069', 'urlTemplate', 'urlTemplate', 1, 'An url template (RFC6570) that will be used to construct the target of the execution of the action.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371070', 'offerCount', 'offerCount', 1, 'The number of offers for the product.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371071', 'category', 'category', 1, 'A category for the item. Greater signs or slashes can be used to informally indicate a category hierarchy.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371072', 'printColumn', 'printColumn', 1, 'The number of the column in which the NewsArticle appears in the print edition.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371073', 'accessModeSufficient', 'accessModeSufficient', 1, 'A list of single or combined accessModes that are sufficient to understand all the intellectual content of a resource. Expected values include:  auditory, tactile, textual, visual.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371075', 'softwareVersion', 'softwareVersion', 1, 'Version of the software instance.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371076', 'isRelatedTo', 'isRelatedTo', 1, 'A pointer to another, somehow related product (or multiple products).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371077', 'recognizingAuthority', 'recognizingAuthority', 1, 'If applicable, the organization that officially recognizes this entity as part of its endorsed system of medicine.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371078', 'ineligibleRegion', 'ineligibleRegion', 1, 'The ISO 3166-1 (ISO 3166-1 alpha-2) or ISO 3166-2 code, the place, or the GeoShape for the geo-political region(s) for which the offer or delivery charge specification is not valid, e.g. a region where the transaction is not allowed.       <br><br> See also <a href=\"/eligibleRegion\">eligibleRegion</a>.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371079', 'isProprietary', 'isProprietary', 1, 'True if this item\"s name is a proprietary/brand name (vs. generic name).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371080', 'openingHours', 'openingHours', 1, 'The general opening hours for a business. Opening hours can be specified as a weekly time range, starting with days, then times per day. Multiple days can be listed with commas \",\" separating each day. Day or time ranges are specified using a hyphen \"-\".<br />- Days are specified using the following two-letter combinations: <code>Mo</code>, <code>Tu</code>, <code>We</code>, <code>Th</code>, <code>Fr</code>, <code>Sa</code>, <code>Su</code>.<br />- Times are specified using 24:00 time. For example, 3pm is specified as <code>15:00</code>. <br />- Here is an example: <code>&lt;span itemprop=&quot;openingHours&quot; content=&quot;Tu,Th 16:00-20:00&quot;&gt;Tuesdays and Thursdays 4-8pm&lt;/span&gt;</code>. <br />- If a business is open 7 days a week, then it can be specified as <code>&lt;span itemprop=&quot;openingHours&quot; content=&quot;Mo-Su&quot;&gt;Monday through Sunday, all day&lt;/span&gt;</code>.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371081', 'inAlbum', 'inAlbum', 1, 'The album to which this recording belongs.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371082', 'subtitleLanguage', 'subtitleLanguage', 1, 'Languages in which subtitles/captions are available, in <a href=\"http://tools.ietf.org/html/bcp47\">IETF BCP 47 standard format.</a>');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371083', 'opponent', 'opponent', 1, 'A sub property of participant. The opponent on this action.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371084', 'menu', 'menu', 1, 'Either the actual menu or a URL of the menu.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371085', 'lender', 'lender', 1, 'A sub property of participant. The person that lends the object being borrowed.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371086', 'meetsEmissionStandard', 'meetsEmissionStandard', 1, 'Indicates that the vehicle meets the respective emission standard.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371087', 'competitor', 'competitor', 1, 'A competitor in a sports event.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371088', 'billingPeriod', 'billingPeriod', 1, 'The time interval used to compute the invoice.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371089', 'advanceBookingRequirement', 'advanceBookingRequirement', 1, 'The amount of time that is required between accepting the offer and the actual usage of the resource or service.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371090', 'followee', 'followee', 1, 'A sub property of object. The person or organization being followed.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371091', 'hasPart', 'hasPart', 1, 'Indicates a CreativeWork that is (in some sense) a part of this CreativeWork.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371092', 'valueMinLength', 'valueMinLength', 1, 'Specifies the minimum allowed range for number of characters in a literal value.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371093', 'discussionUrl', 'discussionUrl', 1, 'A link to the page containing the comments of the CreativeWork.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371094', 'children', 'children', 1, 'A child of the person.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371095', 'vehicleInteriorType', 'vehicleInteriorType', 1, 'The type or material of the interior of the vehicle (e.g. synthetic fabric, leather, wood, etc.). While most interior types are characterized by the material used, an interior type can also be based on vehicle usage or target audience.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371096', 'gtin14', 'gtin14', 1, 'The <a href=\"http://ocp.gs1.org/sites/glossary/en-gb/Pages/GTIN-14.aspx\">GTIN-14</a> code of the product, or the product to which the offer refers. See <a href=\"http://www.gs1.org/barcodes/technical/idkeys/gtin\">GS1 GTIN Summary</a> for more details.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371097', 'colleagues', 'colleagues', 1, 'A colleague of the person.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371098', 'successorOf', 'successorOf', 1, 'A pointer from a newer variant of a product  to its previous, often discontinued predecessor.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371099', 'exercisePlan', 'exercisePlan', 1, 'A sub property of instrument. The exercise plan used on this action.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371100', 'genre', 'genre', 1, 'Genre of the creative work or group.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371101', 'targetCollection', 'targetCollection', 1, 'A sub property of object. The collection target of the action.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371102', 'confirmationNumber', 'confirmationNumber', 1, 'A number that confirms the given order or payment has been received.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371103', 'availableChannel', 'availableChannel', 1, 'A means of accessing the service (e.g. a phone bank, a web site, a location, etc.).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371104', 'buyer', 'buyer', 1, 'A sub property of participant. The participant/person/organization that bought the object.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371105', 'phase', 'phase', 1, 'The phase of the clinical trial.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371106', 'vehicleTransmission', 'vehicleTransmission', 1, 'The type of component used for transmitting the power from a rotating power source to the wheels or other relevant component(s) (\"gearbox\" for cars).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371107', 'tongueWeight', 'tongueWeight', 1, '<p>The permitted vertical load (TWR) of a trailer attached to the vehicle. Also referred to as Tongue Load Rating (TLR) or Vertical Load Rating (VLR).<br />         Typical unit code(s): KGM for kilogram, LBR for pound<br /></p> <pre><code>Note 1: You can indicate additional information in the &lt;a href=\"name\"&gt;name&lt;/a&gt; of the &lt;a href=\"QuantitativeValue\"&gt;QuantitativeValue&lt;/a&gt; node.&lt;br /&gt; Note 2: You may also link to a &lt;a href=\"QualitativeValue\"&gt;QualitativeValue&lt;/a&gt; node that provides additional information using &lt;a href=\"valueReference\"&gt;valueReference&lt;/a&gt;.&lt;br /&gt; Note 3: Note that you can use &lt;a href=\"minValue\"&gt;minValue&lt;/a&gt; and &lt;a href=\"maxValue\"&gt;maxValue&lt;/a&gt; to indicate ranges. </code></pre>');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371108', 'addOn', 'addOn', 1, 'An additional offer that can only be obtained in combination with the first base offer (e.g. supplements and extensions that are available for a surcharge).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371109', 'gtin12', 'gtin12', 1, 'The <a href=\"http://ocp.gs1.org/sites/glossary/en-gb/Pages/GTIN-12.aspx\">GTIN-12</a> code of the product, or the product to which the offer refers. The GTIN-12 is the 12-digit GS1 Identification Key composed of a U.P.C. Company Prefix, Item Reference, and Check Digit used to identify trade items. See <a href=\"http://www.gs1.org/barcodes/technical/idkeys/gtin\">GS1 GTIN Summary</a> for more details.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371110', 'postalCode', 'postalCode', 1, 'The postal code. For example, 94043.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371111', 'duns', 'duns', 1, 'The Dun &amp; Bradstreet DUNS number for identifying an organization or business person.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371112', 'identifyingExam', 'identifyingExam', 1, 'A physical examination that can identify this sign.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371113', 'toLocation', 'toLocation', 1, 'A sub property of location. The final location of the object or the agent after the action.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371114', 'pagination', 'pagination', 1, 'Any description of pages that is not separated into pageStart and pageEnd; for example, \"1-6, 9, 55\" or \"10-12, 46-49\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371116', 'highPrice', 'highPrice', 1, 'The highest price of all offers available.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371117', 'review', 'review', 1, 'A review of the item.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371118', 'seatingType', 'seatingType', 1, 'The type/class of the seat.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371119', 'alcoholWarning', 'alcoholWarning', 1, 'Any precaution, guidance, contraindication, etc. related to consumption of alcohol while taking this drug.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371120', 'contactPoint', 'contactPoint', 1, 'A contact point for a person or organization.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371121', 'translationOfWork', 'translationOfWork', 1, 'The work that this work has been translated from. e.g. 物种起源 is a translationOf “On the Origin of Species”');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371122', 'ownedFrom', 'ownedFrom', 1, 'The date and time of obtaining the product.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371123', 'availableThrough', 'availableThrough', 1, 'After this date, the item will no longer be available for pickup.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371124', 'referencesOrder', 'referencesOrder', 1, 'The Order(s) related to this Invoice. One or more Orders may be combined into a single Invoice.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371125', 'lyricist', 'lyricist', 1, 'The person who wrote the words.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371126', 'signOrSymptom', 'signOrSymptom', 1, 'A sign or symptom of this condition. Signs are objective or physically observable manifestations of the medical condition while symptoms are the subjective experience of the medical condition.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371127', 'isSimilarTo', 'isSimilarTo', 1, 'A pointer to another, functionally similar product (or multiple products).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371128', 'attendee', 'attendee', 1, 'A person or organization attending the event.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371129', 'text', 'text', 1, 'The textual content of this CreativeWork.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371130', 'manufacturer', 'manufacturer', 1, 'The manufacturer of the product.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371131', 'paymentAccepted', 'paymentAccepted', 1, 'Cash, credit card, etc.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371132', 'enginePower', 'enginePower', 1, '<p>The power of the vehicle\"s engine.     Typical unit code(s): KWT for kilowatt, BHP for brake horsepower, N12 for metric horsepower (PS, with 1 PS = 735,49875 W) <br /></p> <pre><code>Note 1: There are many different ways of measuring an engine\"s power. For an overview, see  http://en.wikipedia.org/wiki/Horsepower#Engine_power_test_codes. &lt;br /&gt; Note 2: You can link to information about how the given value has been determined using the &lt;a href=\"valueReference\"&gt;valueReference&lt;/a&gt; property.&lt;br /&gt; Note 3: You can use &lt;a href=\"minValue\"&gt;minValue&lt;/a&gt; and &lt;a href=\"maxValue\"&gt;maxValue&lt;/a&gt; to indicate ranges. </code></pre>');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371133', 'participant', 'participant', 1, 'Other co-agents that participated in the action indirectly. e.g. John wrote a book with <em>Steve</em>.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371134', 'yearsInOperation', 'yearsInOperation', 1, 'The age of the business.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371135', 'error', 'error', 1, 'For failed actions, more information on the cause of the failure.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371136', 'contributor', 'contributor', 1, 'A secondary contributor to the CreativeWork or Event.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371137', 'actor', 'actor', 1, 'An actor, e.g. in tv, radio, movie, video games etc., or in an event. Actors can be associated with individual items or with a series, episode, clip.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371138', 'workLocation', 'workLocation', 1, 'A contact location for a person\"s place of work.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371139', 'members', 'members', 1, 'A member of this organization.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371140', 'linkRelationship', 'linkRelationship', 1, 'Indicates the relationship type of a Web link.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371141', 'membershipNumber', 'membershipNumber', 1, 'A unique identifier for the membership.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371142', 'knows', 'knows', 1, 'The most generic bi-directional social/work relation.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371143', 'gameServer', 'gameServer', 1, 'The server on which  it is possible to play the game.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371144', 'doseValue', 'doseValue', 1, 'The value of the dose, e.g. 500.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371145', 'awards', 'awards', 1, 'Awards won by or for this item.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371146', 'suggestedAnswer', 'suggestedAnswer', 1, 'An answer (possibly one of several, possibly incorrect) to a Question, e.g. on a Question/Answer site.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371147', 'creditedTo', 'creditedTo', 1, 'The group the release is credited to if different than the byArtist. For example, Red and Blue is credited to \"Stefani Germanotta Band\", but by Lady Gaga.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371148', 'offersPrescriptionByMail', 'offersPrescriptionByMail', 1, 'Whether The costs to the patient for services under this network or formulary.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371149', 'entertainmentBusiness', 'entertainmentBusiness', 1, 'A sub property of location. The entertainment business where the action occurred.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371150', 'industry', 'industry', 1, 'The industry associated with the job position.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371151', 'copyrightHolder', 'copyrightHolder', 1, 'The party holding the legal copyright to the CreativeWork.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371152', 'customer', 'customer', 1, 'Party placing the order or paying the invoice.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371153', 'recipeCuisine', 'recipeCuisine', 1, 'The cuisine of the recipe (for example, French or Ethiopian).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371154', 'healthPlanPharmacyCategory', 'healthPlanPharmacyCategory', 1, 'The category or type of pharmacy associated with this cost sharing.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371155', 'validFrom', 'validFrom', 1, 'The date when the item becomes valid.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371156', 'seasonNumber', 'seasonNumber', 1, 'Position of the season within an ordered group of seasons.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371157', 'pageStart', 'pageStart', 1, 'The page on which the work starts; for example \"135\" or \"xiii\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371158', 'seatSection', 'seatSection', 1, 'The section location of the reserved seat (e.g. Orchestra).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371159', 'seeks', 'seeks', 1, 'A pointer to products or services sought by the organization or person (demand).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371160', 'producer', 'producer', 1, 'The person or organization who produced the work (e.g. music album, movie, tv/radio series etc.).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371161', 'publisherImprint', 'publisherImprint', 1, 'The publishing division which published the comic.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371162', 'expectedArrivalFrom', 'expectedArrivalFrom', 1, 'The earliest date the package may arrive.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371163', 'partOfInvoice', 'partOfInvoice', 1, 'The order is being paid as part of the referenced Invoice.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371164', 'seatingCapacity', 'seatingCapacity', 1, 'The number of persons that can be seated (e.g. in a vehicle), both in terms of the physical space available, and in terms of limitations set by law.<br />     Typical unit code(s): C62 for persons');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371165', 'structuralClass', 'structuralClass', 1, 'The name given to how bone physically connects to each other.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371166', 'ticketedSeat', 'ticketedSeat', 1, 'The seat associated with the ticket.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371167', 'numberOfAxles', 'numberOfAxles', 1, 'The number of axles.<br /> Typical unit code(s): C62');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371168', 'priceCurrency', 'priceCurrency', 1, 'The currency (in 3-letter ISO 4217 format) of the price or a price component, when attached to PriceSpecification and its subtypes.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371169', 'organizer', 'organizer', 1, 'An organizer of an Event.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371170', 'iataCode', 'iataCode', 1, 'IATA identifier for an airline or airport.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371171', 'artist', 'artist', 1, 'The primary artist for a work     in a medium other than pencils or digital line art--for example, if the     primary artwork is done in watercolors or digital paints.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371172', 'gamePlatform', 'gamePlatform', 1, 'The electronic systems used to play <a href=\"http://en.wikipedia.org/wiki/Category:Video_game_platforms\">video games</a>.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371173', 'relatedCondition', 'relatedCondition', 1, 'A medical condition associated with this anatomy.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371174', 'affiliation', 'affiliation', 1, 'An organization that this person is affiliated with. For example, a school/university, a club, or a team.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371175', 'operatingSystem', 'operatingSystem', 1, 'Operating systems supported (Windows 7, OSX 10.6, Android 1.6).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371176', 'mechanismOfAction', 'mechanismOfAction', 1, 'The specific biochemical interaction through which this drug or supplement produces its pharmacological effect.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371177', 'inLanguage', 'inLanguage', 1, 'The language of the content or performance or used in an action. Please use one of the language codes from the <a href=\"http://tools.ietf.org/html/bcp47\">IETF BCP 47 standard</a>. See also <a class=\"localLink\" href=\"/availableLanguage\">availableLanguage</a>.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371178', 'fuelConsumption', 'fuelConsumption', 1, 'The amount of fuel consumed for traveling a particular distance or temporal duration with the given vehicle (e.g. liters per 100 km).<br /> Note 1: There are unfortunately no standard unit codes for liters per 100 km.<br /> Use <a href=\"unitText\">unitText</a> to indicate the unit of measurement, e.g. L/100 km. Note 2: There are two ways of indicating the fuel consumption, <a href=\"fuelConsumption\">fuelConsumption</a> (e.g. 8 liters per 100 km) and <a href=\"fuelEfficiency\">fuelEfficiency</a> (e.g. 30 miles per gallon). They are reciprocal.<br /> Note 3: Often, the absolute value is useful only when related to driving speed (\"at 80 km/h\") or usage pattern (\"city traffic\"). You can use <a href=\"valueReference\">valueReference</a> to link the value for the fuel consumption to another value.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371179', 'artEdition', 'artEdition', 1, 'The number of copies when multiple copies of a piece of artwork are produced - e.g. for a limited edition of 20 prints, \"artEdition\" refers to the total number of copies (in this example \"20\").');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371180', 'associatedAnatomy', 'associatedAnatomy', 1, 'The anatomy of the underlying organ system or structures associated with this entity.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371181', 'license', 'license', 1, 'A license document that applies to this content, typically indicated by URL.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371182', 'liveBlogUpdate', 'liveBlogUpdate', 1, 'An update to the LiveBlog.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371183', 'contentRating', 'contentRating', 1, 'Official rating of a piece of content&#x2014;for example,\"MPAA PG-13\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371184', 'serviceType', 'serviceType', 1, 'The type of service being offered, e.g. veterans\" benefits, emergency relief, etc.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371185', 'albums', 'albums', 1, 'A collection of music albums.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371186', 'abridged', 'abridged', 1, 'Indicates whether the book is an abridged edition.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371187', 'clincalPharmacology', 'clincalPharmacology', 1, 'Description of the absorption and elimination of drugs, including their concentration (pharmacokinetics, pK) and biological effects (pharmacodynamics, pD).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371188', 'caption', 'caption', 1, 'The caption for this object.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371189', 'educationalUse', 'educationalUse', 1, 'The purpose of a work in the context of education; for example, \"assignment\", \"group work\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371190', 'issuedBy', 'issuedBy', 1, 'The organization issuing the ticket or permit.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371191', 'embedUrl', 'embedUrl', 1, 'A URL pointing to a player for a specific video. In general, this is the information in the <code>src</code> element of an <code>embed</code> tag and should not be the same as the content of the <code>loc</code> tag.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371192', 'dateCreated', 'dateCreated', 1, 'The date on which the CreativeWork was created or the item was added to a DataFeed.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371193', 'sameAs', 'sameAs', 1, 'URL of a reference Web page that unambiguously indicates the item\"s identity. E.g. the URL of the item\"s Wikipedia page, Freebase page, or official website.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371195', 'fromLocation', 'fromLocation', 1, 'A sub property of location. The original location of the object or the agent before the action.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371196', 'founder', 'founder', 1, 'A person who founded this organization.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371197', 'partOfTVSeries', 'partOfTVSeries', 1, 'The TV series to which this episode or season belongs.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371198', 'tracks', 'tracks', 1, 'A music recording (track)&#x2014;usually a single song.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371199', 'provider', 'provider', 1, 'The service provider, service operator, or service performer; the goods producer. Another party (a seller) may offer those services or goods on behalf of the provider. A provider may also serve as the seller.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371200', 'applicationSuite', 'applicationSuite', 1, 'The name of the application suite to which the application belongs (e.g. Excel belongs to Office).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371201', 'partOfSeries', 'partOfSeries', 1, 'The series to which this episode or season belongs.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371202', 'containsSeason', 'containsSeason', 1, 'A season that is part of the media series.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371203', 'accessibilityAPI', 'accessibilityAPI', 1, 'Indicates that the resource is compatible with the referenced accessibility API (<a href=\"http://www.w3.org/wiki/WebSchemas/Accessibility\">WebSchemas wiki lists possible values</a>).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371204', 'dietFeatures', 'dietFeatures', 1, 'Nutritional information specific to the dietary plan. May include dietary recommendations on what foods to avoid, what foods to consume, and specific alterations/deviations from the USDA or other regulatory body\"s approved dietary guidelines.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371205', 'isLiveBroadcast', 'isLiveBroadcast', 1, 'True is the broadcast is of a live event.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371206', 'hospitalAffiliation', 'hospitalAffiliation', 1, 'A hospital with which the physician or office is affiliated.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371207', 'doseUnit', 'doseUnit', 1, 'The unit of the dose, e.g. \"mg\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371208', 'penciler', 'penciler', 1, 'The individual who draws the primary narrative artwork.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371209', 'answerCount', 'answerCount', 1, 'The number of answers this question has received.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371210', 'includedComposition', 'includedComposition', 1, 'Smaller compositions included in this work (e.g. a movement in a symphony).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371211', 'securityScreening', 'securityScreening', 1, 'The type of security screening the passenger is subject to.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371212', 'realEstateAgent', 'realEstateAgent', 1, 'A sub property of participant. The real estate agent involved in the action.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371213', 'polygon', 'polygon', 1, 'A polygon is the area enclosed by a point-to-point path for which the starting and ending points are the same. A polygon is expressed as a series of four or more space delimited points where the first and final points are identical.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371214', 'alternativeHeadline', 'alternativeHeadline', 1, 'A secondary title of the CreativeWork.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371215', 'variantCover', 'variantCover', 1, 'A description of the variant cover     for the issue, if the issue is a variant printing. For example, \"Bryan Hitch     Variant Cover\" or \"2nd Printing Variant\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371216', 'accountablePerson', 'accountablePerson', 1, 'Specifies the Person that is legally accountable for the CreativeWork.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371217', 'supportingData', 'supportingData', 1, 'Supporting data for a SoftwareApplication.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371218', 'baseSalary', 'baseSalary', 1, 'The base salary of the job or of an employee in an EmployeeRole.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371219', 'billingAddress', 'billingAddress', 1, 'The billing address for the order.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371220', 'runtime', 'runtime', 1, 'Runtime platform or script interpreter dependencies (Example - Java v1, Python2.3, .Net Framework 3.0).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371221', 'sku', 'sku', 1, 'The Stock Keeping Unit (SKU), i.e. a merchant-specific identifier for a product or service, or the product to which the offer refers.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371222', 'paymentStatus', 'paymentStatus', 1, 'The status of payment; whether the invoice has been paid or not.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371223', 'previewUrl', 'previewUrl', 1, 'A link to a site where a preview of the course is offered.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371224', 'code', 'code', 1, 'A medical code for the entity, taken from a controlled vocabulary or ontology such as ICD-9, DiseasesDB, MeSH, SNOMED-CT, RxNorm, etc.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371225', 'increasesRiskOf', 'increasesRiskOf', 1, 'The condition, complication, etc. influenced by this factor.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371226', 'adverseOutcome', 'adverseOutcome', 1, 'A possible complication and/or side effect of this therapy. If it is known that an adverse outcome is serious (resulting in death, disability, or permanent damage; requiring hospitalization; or is otherwise life-threatening or requires immediate medical attention), tag it as a seriouseAdverseOutcome instead.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371227', 'fatContent', 'fatContent', 1, 'The number of grams of fat.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371228', 'sugarContent', 'sugarContent', 1, 'The number of grams of sugar.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371229', 'modifiedTime', 'modifiedTime', 1, 'The date and time the reservation was modified.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371230', 'servicePostalAddress', 'servicePostalAddress', 1, 'The address for accessing the service by mail.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371231', 'costCurrency', 'costCurrency', 1, 'The currency (in 3-letter of the drug cost. See: http://en.wikipedia.org/wiki/ISO_4217');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371232', 'pickupTime', 'pickupTime', 1, 'When a taxi will pickup a passenger or a rental car can be picked up.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371233', 'action', 'action', 1, 'Obsolete term for <a class=\"localLink\" href=\"/muscleAction\">muscleAction</a>. Not to be confused with <a class=\"localLink\" href=\"/potentialAction\">potentialAction</a>.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371234', 'inker', 'inker', 1, 'The individual who traces over the pencil drawings in ink after pencils are complete.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371235', 'acceptedOffer', 'acceptedOffer', 1, 'The offer(s) -- e.g., product, quantity and price combinations -- included in the order.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371236', 'serviceUrl', 'serviceUrl', 1, 'The website to access the service.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371237', 'childMinAge', 'childMinAge', 1, 'Minimal age of the child.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371238', 'includedInHealthInsurancePlan', 'includedInHealthInsurancePlan', 1, 'The insurance plans that cover this drug.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371239', 'acceptedAnswer', 'acceptedAnswer', 1, 'The answer that has been accepted as best, typically on a Question/Answer site. Sites vary in their selection mechanisms, e.g. drawing on community opinion and/or the view of the Question author.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371240', 'isFamilyFriendly', 'isFamilyFriendly', 1, 'Indicates whether this content is family friendly.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371241', 'servesCuisine', 'servesCuisine', 1, 'The cuisine of the restaurant.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371242', 'studySubject', 'studySubject', 1, 'A subject of the study, i.e. one of the medical conditions, therapies, devices, drugs, etc. investigated by the study.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371243', 'distinguishingSign', 'distinguishingSign', 1, 'One of a set of signs and symptoms that can be used to distinguish this diagnosis from others in the differential diagnosis.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371244', 'free', 'free', 1, 'A flag to signal that the publication is accessible for free.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371245', 'copyrightYear', 'copyrightYear', 1, 'The year during which the claimed copyright for the CreativeWork was first asserted.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371246', 'estimatedFlightDuration', 'estimatedFlightDuration', 1, 'The estimated time the flight will take.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371247', 'dateVehicleFirstRegistered', 'dateVehicleFirstRegistered', 1, 'The date of the first registration of the vehicle with the respective public authorities.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371248', 'illustrator', 'illustrator', 1, 'The illustrator of the book.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371249', 'fuelCapacity', 'fuelCapacity', 1, 'The capacity of the fuel tank or in the case of electric cars, the battery. If there are multiple components for storage, this should indicate the total of all storage of the same type.<br />     Typical unit code(s): LTR for liters, GLL of US gallons, GLI for UK / imperial gallons, AMH for ampere-hours (for electrical vehicles)');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371250', 'additionalVariable', 'additionalVariable', 1, 'Any additional component of the exercise prescription that may need to be articulated to the patient. This may include the order of exercises, the number of repetitions of movement, quantitative distance, progressions over time, etc.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371251', 'broadcastOfEvent', 'broadcastOfEvent', 1, 'The event being broadcast such as a sporting event or awards ceremony.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371252', 'stageAsNumber', 'stageAsNumber', 1, 'The stage represented as a number, e.g. 3.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371253', 'hostingOrganization', 'hostingOrganization', 1, 'The organization (airline, travelers\" club, etc.) the membership is made with.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371254', 'affectedBy', 'affectedBy', 1, 'Drugs that affect the test\"s results.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371255', 'aspect', 'aspect', 1, 'An aspect of medical practice that is considered on the page, such as \"diagnosis\", \"treatment\", \"causes\", \"prognosis\", \"etiology\", \"epidemiology\", etc.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371256', 'outcome', 'outcome', 1, 'Expected or actual outcomes of the study.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371257', 'sport', 'sport', 1, 'A type of sport (e.g. Baseball).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371258', 'bitrate', 'bitrate', 1, 'The bitrate of the media object.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371259', 'possibleComplication', 'possibleComplication', 1, 'A possible unexpected and unfavorable evolution of a medical condition. Complications may include worsening of the signs or symptoms of the disease, extension of the condition to other organ systems, etc.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371260', 'eligibleQuantity', 'eligibleQuantity', 1, 'The interval and unit of measurement of ordering quantities for which the offer or price specification is valid. This allows e.g. specifying that a certain freight charge is valid only for a certain quantity.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371261', 'exerciseCourse', 'exerciseCourse', 1, 'A sub property of location. The course where this action was taken.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371262', 'honorificSuffix', 'honorificSuffix', 1, 'An honorific suffix preceding a Person\"s name such as M.D. /PhD/MSCSW.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371263', 'broadcastSignalModulation', 'broadcastSignalModulation', 1, 'The modulation (e.g. FM, AM, etc) used by a particular broadcast service');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371264', 'hasCourseInstance', 'hasCourseInstance', 1, 'An offering of the course at a specific time and place or through specific media or mode of study or to a specific section of students.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371265', 'borrower', 'borrower', 1, 'A sub property of participant. The person that borrows the object being lent.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371266', 'warrantyPromise', 'warrantyPromise', 1, 'The warranty promise(s) included in the offer.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371267', 'logo', 'logo', 1, 'An associated logo.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371268', 'reviewBody', 'reviewBody', 1, 'The actual body of the review.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371269', 'brand', 'brand', 1, 'The brand(s) associated with a product or service, or the brand(s) maintained by an organization or business person.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371270', 'previousItem', 'previousItem', 1, 'A link to the ListItem that preceeds the current one.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371271', 'awayTeam', 'awayTeam', 1, 'The away team in a sports event.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371272', 'infectiousAgent', 'infectiousAgent', 1, 'The actual infectious agent, such as a specific bacterium.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371273', 'relatedTherapy', 'relatedTherapy', 1, 'A medical therapy related to this anatomy.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371274', 'subStructure', 'subStructure', 1, 'Component (sub-)structure(s) that comprise this anatomical structure.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371275', 'healthPlanCoinsuranceRate', 'healthPlanCoinsuranceRate', 1, 'Whether The rate of coinsurance expressed as a number between 0.0 and 1.0.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371276', 'disambiguatingDescription', 'disambiguatingDescription', 1, 'A sub property of description. A short description of the item used to disambiguate from other, similar items. Information from other properties (in particular, name) may be necessary for the description to be useful for disambiguation.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371277', 'readonlyValue', 'readonlyValue', 1, 'Whether or not a property is mutable.  Default is false. Specifying this for a property that also has a value makes it act similar to a \"hidden\" input in an HTML form.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371278', 'temporal', 'temporal', 1, 'The range of temporal applicability of a dataset, e.g. for a 2011 census dataset, the year 2011 (in ISO 8601 time interval format).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371279', 'latitude', 'latitude', 1, 'The latitude of a location. For example <code>37.42242</code> (<a href=\"https://en.wikipedia.org/wiki/World_Geodetic_System\">WGS 84</a>).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371281', 'clinicalPharmacology', 'clinicalPharmacology', 1, 'Description of the absorption and elimination of drugs, including their concentration (pharmacokinetics, pK) and biological effects (pharmacodynamics, pD).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371282', 'foodEstablishment', 'foodEstablishment', 1, 'A sub property of location. The specific food establishment where the action occurred.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371283', 'description', 'description', 1, 'A description of the item.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371284', 'question', 'question', 1, 'A sub property of object. A question.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371285', 'map', 'map', 1, 'A URL to a map of the place.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371287', 'acquiredFrom', 'acquiredFrom', 1, 'The organization or person from which the product was acquired.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371288', 'releaseOf', 'releaseOf', 1, 'The album this is a release of.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371289', 'lodgingUnitDescription', 'lodgingUnitDescription', 1, 'A full description of the lodging unit.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371290', 'subOrganization', 'subOrganization', 1, 'A relationship between two organizations where the first includes the second, e.g., as a subsidiary. See also: the more specific \"department\" property.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371291', 'publishedBy', 'publishedBy', 1, 'An agent associated with the publication event.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371292', 'recommendationStrength', 'recommendationStrength', 1, 'Strength of the guideline\"s recommendation (e.g. \"class I\").');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371293', 'checkinTime', 'checkinTime', 1, 'The earliest someone may check into a lodging establishment.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371294', 'resultComment', 'resultComment', 1, 'A sub property of result. The Comment created or sent as a result of this action.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371295', 'bloodSupply', 'bloodSupply', 1, 'The blood vessel that carries blood from the heart to the muscle.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371296', 'healthPlanDrugTier', 'healthPlanDrugTier', 1, 'The tier(s) of drugs offered by this formulary or insurance plan.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371297', 'diet', 'diet', 1, 'A sub property of instrument. The diet used in this action.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371298', 'recipient', 'recipient', 1, 'A sub property of participant. The participant who is at the receiving end of the action.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371299', 'includesHealthPlanNetwork', 'includesHealthPlanNetwork', 1, 'Networks covered by this plan.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371300', 'inventoryLevel', 'inventoryLevel', 1, 'The current approximate inventory level for the item or items.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371301', 'musicArrangement', 'musicArrangement', 1, 'An arrangement derived from the composition.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371302', 'recommendedIntake', 'recommendedIntake', 1, 'Recommended intake of this supplement for a given population as defined by a specific recommending authority.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371303', 'sensoryUnit', 'sensoryUnit', 1, 'The neurological pathway extension that inputs and sends information to the brain or spinal cord.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371304', 'currenciesAccepted', 'currenciesAccepted', 1, 'The currency accepted (in <a href=\"http://en.wikipedia.org/wiki/ISO_4217\">ISO 4217 currency format</a>).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371305', 'vehicleInteriorColor', 'vehicleInteriorColor', 1, 'The color or color combination of the interior of the vehicle.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371306', 'track', 'track', 1, 'A music recording (track)&#x2014;usually a single song. If an ItemList is given, the list should contain items of type MusicRecording.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371307', 'fiberContent', 'fiberContent', 1, 'The number of grams of fiber.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371308', 'downvoteCount', 'downvoteCount', 1, 'The number of downvotes this question, answer or comment has received from the community.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371309', 'releaseNotes', 'releaseNotes', 1, 'Description of what changed in this version.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371310', 'headline', 'headline', 1, 'Headline of the article.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371311', 'lyrics', 'lyrics', 1, 'The words in the song.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371312', 'reservedTicket', 'reservedTicket', 1, 'A ticket associated with the reservation.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371313', 'eligibleTransactionVolume', 'eligibleTransactionVolume', 1, 'The transaction volume, in a monetary unit, for which the offer or price specification is valid, e.g. for indicating a minimal purchasing volume, to express free shipping above a certain order volume, or to limit the acceptance of credit cards to purchases to a certain minimal amount.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371314', 'processorRequirements', 'processorRequirements', 1, 'Processor architecture required to run the application (e.g. IA64).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371315', 'performers', 'performers', 1, 'The main performer or performers of the event&#x2014;for example, a presenter, musician, or actor.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371316', 'partOfSeason', 'partOfSeason', 1, 'The season to which this episode belongs.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371317', 'carrierRequirements', 'carrierRequirements', 1, 'Specifies specific carrier(s) requirements for the application (e.g. an application may only work on a specific carrier network).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371318', 'mainEntityOfPage', 'mainEntityOfPage', 1, 'Indicates a page (or other CreativeWork) for which this thing is the main entity being described. See <a href=\"/docs/datamodel.html#mainEntityBackground\">background notes</a> for details.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371319', 'restPeriods', 'restPeriods', 1, 'How often one should break from the activity.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371320', 'roofLoad', 'roofLoad', 1, '<p>The permitted total weight of cargo and installations (e.g. a roof rack) on top of the vehicle.<br />     Typical unit code(s): KGM for kilogram, LBR for pound<br /></p> <pre><code>Note 1: You can indicate additional information in the &lt;a href=\"name\"&gt;name&lt;/a&gt; of the &lt;a href=\"QuantitativeValue\"&gt;QuantitativeValue&lt;/a&gt; node.&lt;br /&gt; Note 2: You may also link to a &lt;a href=\"QualitativeValue\"&gt;QualitativeValue&lt;/a&gt; node that provides additional information using &lt;a href=\"valueReference\"&gt;valueReference&lt;/a&gt;.&lt;br /&gt; Note 3: Note that you can use &lt;a href=\"minValue\"&gt;minValue&lt;/a&gt; and &lt;a href=\"maxValue\"&gt;maxValue&lt;/a&gt; to indicate ranges. </code></pre>');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371321', 'feesAndCommissionsSpecification', 'feesAndCommissionsSpecification', 1, 'Description of fees, commissions, and other terms applied either to a class of financial product, or by a financial service organization.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371322', 'actionOption', 'actionOption', 1, 'A sub property of object. The options subject to this action.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371323', 'overdosage', 'overdosage', 1, 'Any information related to overdose on a drug, including signs or symptoms, treatments, contact information for emergency response.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371324', 'inSupportOf', 'inSupportOf', 1, 'Qualification, candidature, degree, application that Thesis supports.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371325', 'trainNumber', 'trainNumber', 1, 'The unique identifier for the train.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371327', 'preparation', 'preparation', 1, 'Typical preparation that a patient must undergo before having the procedure performed.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371328', 'userInteractionCount', 'userInteractionCount', 1, 'The number of interactions for the CreativeWork using the WebSite or SoftwareApplication.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371329', 'mainContentOfPage', 'mainContentOfPage', 1, 'Indicates if this web page element is the main subject of the page.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371330', 'comment', 'comment', 1, 'Comments, typically from users.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371331', 'acceptsReservations', 'acceptsReservations', 1, 'Indicates whether a FoodEstablishment accepts reservations. Values can be Boolean, an URL at which reservations can be made or (for backwards compatibility) the strings <code>Yes</code> or <code>No</code>.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371332', 'partOfSystem', 'partOfSystem', 1, 'The anatomical or organ system that this structure is part of.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371333', 'subStageSuffix', 'subStageSuffix', 1, 'The substage, e.g. \"a\" for Stage IIIa.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371334', 'sender', 'sender', 1, 'A sub property of participant. The participant who is at the sending end of the action.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371335', 'validThrough', 'validThrough', 1, 'The date after when the item is not valid. For example the end of an offer, salary period, or a period of opening hours.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371336', 'roleName', 'roleName', 1, 'A role played, performed or filled by a person or organization. For example, the team of creators for a comic book might fill the roles named \"inker\", \"penciller\", and \"letterer\"; or an athlete in a SportsTeam might play in the position named \"Quarterback\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371337', 'line', 'line', 1, 'A line is a point-to-point path consisting of two or more points. A line is expressed as a series of two or more point objects separated by space.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371338', 'fileSize', 'fileSize', 1, 'Size of the application / package (e.g. 18MB). In the absence of a unit (MB, KB etc.), KB will be assumed.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371339', 'valueName', 'valueName', 1, 'Indicates the name of the PropertyValueSpecification to be used in URL templates and form encoding in a manner analogous to HTML\"s input@name.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371340', 'actors', 'actors', 1, 'An actor, e.g. in tv, radio, movie, video games etc. Actors can be associated with individual items or with a series, episode, clip.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371341', 'downloadUrl', 'downloadUrl', 1, 'If the file can be downloaded, URL to download the binary.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371342', 'serviceSmsNumber', 'serviceSmsNumber', 1, 'The number to access the service by text message.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371343', 'device', 'device', 1, 'Device required to run the application. Used in cases where a specific make/model is required to run the application.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371344', 'healthPlanCopayOption', 'healthPlanCopayOption', 1, 'Whether the copay is before or after deductible, etc. TODO: Is this a closed set?');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371345', 'playerType', 'playerType', 1, 'Player type required&#x2014;for example, Flash or Silverlight.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371346', 'title', 'title', 1, 'The title of the job.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371347', 'award', 'award', 1, 'An award won by or for this item.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371348', 'reportNumber', 'reportNumber', 1, 'The number or other unique designator assigned to a Report by the publishing organization.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371349', 'offeredBy', 'offeredBy', 1, 'A pointer to the organization or person making the offer.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371350', 'icaoCode', 'icaoCode', 1, 'ICAO identifier for an airport.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371351', 'courseCode', 'courseCode', 1, 'The identifier used for the Course (e.g. CS101 or 6.001)');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371352', 'valueAddedTaxIncluded', 'valueAddedTaxIncluded', 1, 'Specifies whether the applicable value-added tax (VAT) is included in the price specification or not.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371353', 'checkoutTime', 'checkoutTime', 1, 'The latest someone may check out of a lodging establishment.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371354', 'broadcastFrequency', 'broadcastFrequency', 1, 'The frequency used for over-the-air broadcasts.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371355', 'firstPerformance', 'firstPerformance', 1, 'The date and place the work was first performed.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371356', 'sharedContent', 'sharedContent', 1, 'A CreativeWork such as an image, video, or audio clip shared as part of this posting.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371357', 'departureBusStop', 'departureBusStop', 1, 'The stop or station from which the bus departs.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371358', 'scheduledTime', 'scheduledTime', 1, 'The time the object is scheduled to.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371359', 'foodWarning', 'foodWarning', 1, 'Any precaution, guidance, contraindication, etc. related to consumption of specific foods while taking this drug.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371360', 'valueReference', 'valueReference', 1, 'A pointer to a secondary value that provides additional information on the original value, e.g. a reference temperature.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371361', 'printEdition', 'printEdition', 1, 'The edition of the print product in which the NewsArticle appears.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371362', 'sodiumContent', 'sodiumContent', 1, 'The number of milligrams of sodium.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371363', 'makesOffer', 'makesOffer', 1, 'A pointer to products or services offered by the organization or person.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371364', 'reservationId', 'reservationId', 1, 'A unique identifier for the reservation.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371365', 'itemListElement', 'itemListElement', 1, 'For itemListElement values, you can use simple strings (e.g. \"Peter\", \"Paul\", \"Mary\"), existing entities, or use ListItem.     <br/><br/>     Text values are best if the elements in the list are plain strings. Existing entities are best for a simple, unordered list of existing things in your data. ListItem is used with ordered lists when you want to provide additional context about the element in that list or when the same item might be in different places in different lists.     <br/><br/>     Note: The order of elements in your mark-up is not sufficient for indicating the order or elements.  Use ListItem with a \"position\" property in such cases.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371366', 'contactPoints', 'contactPoints', 1, 'A contact point for a person or organization.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371367', 'employees', 'employees', 1, 'People working for this organization.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371368', 'broadcaster', 'broadcaster', 1, 'The organization owning or operating the broadcast service.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371369', 'relatedStructure', 'relatedStructure', 1, 'Related anatomical structure(s) that are not part of the system but relate or connect to it, such as vascular bundles associated with an organ system.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371370', 'emissionsCO2', 'emissionsCO2', 1, 'The CO2 emissions in g/km. When used in combination with a QuantitativeValue, put \"g/km\" into the unitText property of that value, since there is no UN/CEFACT Common Code for \"g/km\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371371', 'isrcCode', 'isrcCode', 1, 'The International Standard Recording Code for the recording.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371372', 'reviewCount', 'reviewCount', 1, 'The count of total number of reviews.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371373', 'warranty', 'warranty', 1, 'The warranty promise(s) included in the offer.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371374', 'ownedThrough', 'ownedThrough', 1, 'The date and time of giving up ownership on the product.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371375', 'pageEnd', 'pageEnd', 1, 'The page on which the work ends; for example \"138\" or \"xvi\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371376', 'carrier', 'carrier', 1, 'carrier is an out-dated term indicating the \"provider\" for parcel delivery and flights.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371377', 'arrivalTime', 'arrivalTime', 1, 'The expected arrival time.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371378', 'weightTotal', 'weightTotal', 1, '<p>The permitted total weight of the loaded vehicle, including passengers and cargo and the weight of the empty vehicle.<br />     Typical unit code(s): KGM for kilogram, LBR for pound<br /></p> <pre><code>Note 1: You can indicate additional information in the &lt;a href=\"name\"&gt;name&lt;/a&gt; of the &lt;a href=\"QuantitativeValue\"&gt;QuantitativeValue&lt;/a&gt; node.&lt;br /&gt; Note 2: You may also link to a &lt;a href=\"QualitativeValue\"&gt;QualitativeValue&lt;/a&gt; node that provides additional information using &lt;a href=\"valueReference\"&gt;valueReference&lt;/a&gt;.&lt;br /&gt; Note 3: Note that you can use &lt;a href=\"minValue\"&gt;minValue&lt;/a&gt; and &lt;a href=\"maxValue\"&gt;maxValue&lt;/a&gt; to indicate ranges. </code></pre>');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371379', 'containedIn', 'containedIn', 1, 'The basic containment relation between a place and one that contains it.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371380', 'reviewedBy', 'reviewedBy', 1, 'People or organizations that have reviewed the content on this web page for accuracy and/or completeness.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371381', 'grantee', 'grantee', 1, 'The person, organization, contact point, or audience that has been granted this permission.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371382', 'itemOffered', 'itemOffered', 1, 'The item being offered.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371383', 'isAvailableGenerically', 'isAvailableGenerically', 1, 'True if the drug is available in a generic form (regardless of name).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371384', 'recipeYield', 'recipeYield', 1, 'The quantity produced by the recipe (for example, number of people served, number of servings, etc).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371385', 'fuelType', 'fuelType', 1, 'The type of fuel suitable for the engine or engines of the vehicle. If the vehicle has only one engine, this property can be attached directly to the vehicle.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371386', 'replacer', 'replacer', 1, 'A sub property of object. The object that replaces.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371387', 'prescribingInfo', 'prescribingInfo', 1, 'Link to prescribing information for the drug.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371388', 'departureGate', 'departureGate', 1, 'Identifier of the flight\"s departure gate.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371389', 'serialNumber', 'serialNumber', 1, 'The serial number or any alphanumeric identifier of a particular product. When attached to an offer, it is a shortcut for the serial number of the product included in the offer.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371390', 'priceComponent', 'priceComponent', 1, 'This property links to all UnitPriceSpecification nodes that apply in parallel for the CompoundPriceSpecification node.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371391', 'ticketToken', 'ticketToken', 1, 'Reference to an asset (e.g., Barcode, QR code image or PDF) usable for entrance.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371392', 'orderDelivery', 'orderDelivery', 1, 'The delivery of the parcel related to this order or order item.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371393', 'dateReceived', 'dateReceived', 1, 'The date/time the message was received if a single recipient exists.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371394', 'algorithm', 'algorithm', 1, 'The algorithm or rules to follow to compute the score.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371395', 'arterialBranch', 'arterialBranch', 1, 'The branches that comprise the arterial structure.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371396', 'exerciseRelatedDiet', 'exerciseRelatedDiet', 1, 'A sub property of instrument. The diet used in this action.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371397', 'countriesSupported', 'countriesSupported', 1, 'Countries for which the application is supported. You can also provide the two-letter ISO 3166-1 alpha-2 country code.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371398', 'produces', 'produces', 1, 'The tangible thing generated by the service, e.g. a passport, permit, etc.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371399', 'contentUrl', 'contentUrl', 1, 'Actual bytes of the media object, for example the image file or video file.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371400', 'givenName', 'givenName', 1, 'Given name. In the U.S., the first name of a Person. This can be used along with familyName instead of the name property.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371401', 'translator', 'translator', 1, 'An agent responsible for rendering a translated work from a source work ,Organization or person who adapts a creative work to different languages, regional differences and technical requirements of a target market, or that translates during some event.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371402', 'permissions', 'permissions', 1, 'Permission(s) required to run the app (for example, a mobile app may require full internet access or may run only on wifi).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371403', 'musicCompositionForm', 'musicCompositionForm', 1, 'The type of composition (e.g. overture, sonata, symphony, etc.).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371404', 'previousStartDate', 'previousStartDate', 1, 'Used in conjunction with eventStatus for rescheduled or cancelled events. This property contains the previously scheduled start date. For rescheduled events, the startDate property should be used for the newly scheduled start date. In the (rare) case of an event that has been postponed and rescheduled multiple times, this field may be repeated.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371405', 'dateline', 'dateline', 1, 'The location where the NewsArticle was produced.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371406', 'learningResourceType', 'learningResourceType', 1, 'The predominant type or kind characterizing the learning resource. For example, \"presentation\", \"handout\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371407', 'skills', 'skills', 1, 'Skills required to fulfill this role.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371408', 'blogPost', 'blogPost', 1, 'A posting that is part of this blog.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371409', 'thumbnailUrl', 'thumbnailUrl', 1, 'A thumbnail image relevant to the Thing.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371410', 'followup', 'followup', 1, 'Typical or recommended followup care after the procedure is performed.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371411', 'healthPlanDrugOption', 'healthPlanDrugOption', 1, 'TODO.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371412', 'areaServed', 'areaServed', 1, 'The geographic area where a service or offered item is provided.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371413', 'offers', 'offers', 1, 'An offer to provide this item&#x2014;for example, an offer to sell a product, rent the DVD of a movie, perform a service, or give away tickets to an event.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371414', 'postOp', 'postOp', 1, 'A description of the postoperative procedures, care, and/or followups for this device.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371415', 'memberOf', 'memberOf', 1, 'An Organization (or ProgramMembership) to which this Person or Organization belongs.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371416', 'arrivalAirport', 'arrivalAirport', 1, 'The airport where the flight terminates.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371417', 'owns', 'owns', 1, 'Products owned by the organization or person.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371418', 'athlete', 'athlete', 1, 'A person that acts as performing member of a sports team; a player as opposed to a coach.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371419', 'unitCode', 'unitCode', 1, 'The unit of measurement given using the UN/CEFACT Common Code (3 characters) or a URL. Other codes than the UN/CEFACT Common Code may be used with a prefix followed by a colon.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371420', 'colleague', 'colleague', 1, 'A colleague of the person.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371421', 'recordLabel', 'recordLabel', 1, 'The label that issued the release.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371422', 'wheelbase', 'wheelbase', 1, 'The distance between the centers of the front and rear wheels. <br />     Typical unit code(s): CMT for centimeters, MTR for meters, INH for inches, FOT for foot/feet');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371423', 'relatedAnatomy', 'relatedAnatomy', 1, 'Anatomical systems or structures that relate to the superficial anatomy.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371424', 'closes', 'closes', 1, 'The closing hour of the place or service on the given day(s) of the week.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371425', 'location', 'location', 1, 'The location of for example where the event is happening, an organization is located, or where an action takes place.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371426', 'minValue', 'minValue', 1, 'The lower value of some characteristic or property.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371427', 'costPerUnit', 'costPerUnit', 1, 'The cost per unit of the drug.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371428', 'antagonist', 'antagonist', 1, 'The muscle whose action counteracts the specified muscle.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371429', 'departurePlatform', 'departurePlatform', 1, 'The platform from which the train departs.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371430', 'event', 'event', 1, 'Upcoming or past event associated with this place, organization, or action.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371431', 'programmingModel', 'programmingModel', 1, 'Indicates whether API is managed or unmanaged.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371432', 'workload', 'workload', 1, 'Quantitative measure of the physiologic output of the exercise; also referred to as energy expenditure.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371433', 'recordedIn', 'recordedIn', 1, 'The CreativeWork that captured all or part of this Event.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371434', 'associatedPathophysiology', 'associatedPathophysiology', 1, 'If applicable, a description of the pathophysiology associated with the anatomical system, including potential abnormal changes in the mechanical, physical, and biochemical functions of the system.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371435', 'partOfOrder', 'partOfOrder', 1, 'The overall order the items in this delivery were included in.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371436', 'paymentUrl', 'paymentUrl', 1, 'The URL for sending a payment.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371437', 'doseSchedule', 'doseSchedule', 1, 'A dosing schedule for the drug for a given population, either observed, recommended, or maximum dose based on the type used.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371438', 'worksFor', 'worksFor', 1, 'Organizations that the person works for.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371439', 'publishedOn', 'publishedOn', 1, 'A broadcast service associated with the publication event.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371440', 'courseMode', 'courseMode', 1, 'The medium or means of delivery of the course, or the mode of study.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371441', 'additionalProperty', 'additionalProperty', 1, 'A property-value pair representing an additional characteristics of the entitity, e.g. a product feature or another characteristic for which there is no matching property in schema.org. <br /><br /></p> <p>Note: Publishers should be aware that applications designed to use specific schema.org properties (e.g. http://schema.org/width, http://schema.org/color, http://schema.org/gtin13, ...) will typically expect such data to be provided using those properties, rather than using the generic property/value mechanism.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371442', 'runsTo', 'runsTo', 1, 'The vasculature the lymphatic structure runs, or efferents, to.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371443', 'engineDisplacement', 'engineDisplacement', 1, '<p>The volume swept by all of the pistons inside the cylinders of an internal combustion engine in a single movement. <br />     Typical unit code(s): CMQ for cubic centimeter, LTR for liters, INQ for cubic inches<br /></p> <pre><code>Note 1: You can link to information about how the given value has been determined using the &lt;a href=\"valueReference\"&gt;valueReference&lt;/a&gt; property.&lt;br /&gt; Note 2: You can use &lt;a href=\"minValue\"&gt;minValue&lt;/a&gt; and &lt;a href=\"maxValue\"&gt;maxValue&lt;/a&gt; to indicate ranges. </code></pre>');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371444', 'containedInPlace', 'containedInPlace', 1, 'The basic containment relation between a place and one that contains it.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371445', 'accelerationTime', 'accelerationTime', 1, '<p>The time needed to accelerate the vehicle from a given start velocity to a given target velocity.<br />     Typical unit code(s): SEC for seconds<br /></p> <pre><code>Note: There are unfortunately no standard unit codes for seconds/0..100 km/h or seconds/0..60 mph. Simply use \"SEC\" for seconds and indicate the velocities in the &lt;a href=\"name\"&gt;name&lt;/a&gt; of the &lt;a href=\"QuantitativeValue\"&gt;QuantitativeValue&lt;/a&gt;, or use &lt;a href=\"valueReference\"&gt;valueReference&lt;/a&gt; with a &lt;a href=\"QuantitativeValue\"&gt;QuantitativeValue&lt;/a&gt; of 0..60 mph or 0..100 km/h to specify the reference speeds. </code></pre>');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371446', 'applicationSubCategory', 'applicationSubCategory', 1, 'Subcategory of the application, e.g. \"Arcade Game\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371447', 'screenCount', 'screenCount', 1, 'The number of screens in the movie theater.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371448', 'reviews', 'reviews', 1, 'Review of the item.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371449', 'pregnancyWarning', 'pregnancyWarning', 1, 'Any precaution, guidance, contraindication, etc. related to this drug\"s use during pregnancy.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371450', 'numberOfPlayers', 'numberOfPlayers', 1, 'Indicate how many people can play this game (minimum, maximum, or range).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371451', 'procedure', 'procedure', 1, 'A description of the procedure involved in setting up, using, and/or installing the device.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371452', 'purchaseDate', 'purchaseDate', 1, 'The date the item e.g. vehicle was purchased by the current owner.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371453', 'torque', 'torque', 1, '<p>The torque (turning force) of the vehicle\"s engine.<br />         Typical unit code(s): NU for newton metre (N m), F17 for pound-force per foot, or F48 for pound-force per inch<br /></p> <pre><code>Note 1: You can link to information about how the given value has been determined (e.g. reference RPM) using the &lt;a href=\"valueReference\"&gt;valueReference&lt;/a&gt; property.&lt;br /&gt; Note 2: You can use &lt;a href=\"minValue\"&gt;minValue&lt;/a&gt; and &lt;a href=\"maxValue\"&gt;maxValue&lt;/a&gt; to indicate ranges. </code></pre>');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371454', 'healthPlanNetworkId', 'healthPlanNetworkId', 1, 'Name or unique ID of network. (Networks are often reused across different insurance plans).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371455', 'thumbnail', 'thumbnail', 1, 'Thumbnail image for an image or video.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371456', 'featureList', 'featureList', 1, 'Features or modules provided by this application (and possibly required by other applications).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371457', 'codeRepository', 'codeRepository', 1, 'Link to the repository where the un-compiled, human readable code and related code is located (SVN, github, CodePlex).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371458', 'engineType', 'engineType', 1, 'The type of engine or engines powering the vehicle.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371459', 'amount', 'amount', 1, 'The amount of money.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371460', 'parents', 'parents', 1, 'A parents of the person.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371461', 'functionalClass', 'functionalClass', 1, 'The degree of mobility the joint allows.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371462', 'healthPlanCopay', 'healthPlanCopay', 1, 'Whether The copay amount.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371463', 'potentialAction', 'potentialAction', 1, 'Indicates a potential Action, which describes an idealized action in which this thing would play an \"object\" role.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371464', 'openingHoursSpecification', 'openingHoursSpecification', 1, 'The opening hours of a certain place.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371465', 'originAddress', 'originAddress', 1, 'Shipper\"s address.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371466', 'broker', 'broker', 1, 'An entity that arranges for an exchange between a buyer and a seller.  In most cases a broker never acquires or releases ownership of a product or service involved in an exchange.  If it is not clear whether an entity is a broker, seller, or buyer, the latter two terms are preferred.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371467', 'streetAddress', 'streetAddress', 1, 'The street address. For example, 1600 Amphitheatre Pkwy.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371468', 'guidelineDate', 'guidelineDate', 1, 'Date on which this guideline\"s recommendation was made.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371469', 'naturalProgression', 'naturalProgression', 1, 'The expected progression of the condition if it is not treated and allowed to progress naturally.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371470', 'character', 'character', 1, 'Fictional person connected with a creative work.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371471', 'keywords', 'keywords', 1, 'Keywords or tags used to describe this content. Multiple entries in a keywords list are typically delimited by commas.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371472', 'transmissionMethod', 'transmissionMethod', 1, 'How the disease spreads, either as a route or vector, for example \"direct contact\", \"Aedes aegypti\", etc.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371473', 'musicalKey', 'musicalKey', 1, 'The key, mode, or scale this composition uses.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371474', 'incentiveCompensation', 'incentiveCompensation', 1, 'Description of bonus and commission compensation aspects of the job.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371475', 'model', 'model', 1, 'The model of the product. Use with the URL of a ProductModel or a textual representation of the model identifier. The URL of the ProductModel can be from an external source. It is recommended to additionally provide strong product identifiers via the gtin8/gtin13/gtin14 and mpn properties.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371476', 'vehicleModelDate', 'vehicleModelDate', 1, 'The release date of a vehicle model (often used to differentiate versions of the same make and model).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371477', 'trailerWeight', 'trailerWeight', 1, '<p>The permitted weight of a trailer attached to the vehicle.<br />     Typical unit code(s): KGM for kilogram, LBR for pound<br /></p> <pre><code>Note 1: You can indicate additional information in the &lt;a href=\"name\"&gt;name&lt;/a&gt; of the &lt;a href=\"QuantitativeValue\"&gt;QuantitativeValue&lt;/a&gt; node.&lt;br /&gt; Note 2: You may also link to a &lt;a href=\"QualitativeValue\"&gt;QualitativeValue&lt;/a&gt; node that provides additional information using &lt;a href=\"valueReference\"&gt;valueReference&lt;/a&gt;.&lt;br /&gt; Note 3: Note that you can use &lt;a href=\"minValue\"&gt;minValue&lt;/a&gt; and &lt;a href=\"maxValue\"&gt;maxValue&lt;/a&gt; to indicate ranges. </code></pre>');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371478', 'uploadDate', 'uploadDate', 1, 'Date when this media object was uploaded to this site.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371479', 'risks', 'risks', 1, 'Specific physiologic risks associated to the diet plan.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371480', 'nutrition', 'nutrition', 1, 'Nutrition information about the recipe.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371481', 'geographicArea', 'geographicArea', 1, 'The geographic area associated with the audience.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371482', 'mainEntity', 'mainEntity', 1, 'Indicates the primary entity described in some page or other CreativeWork.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371483', 'mileageFromOdometer', 'mileageFromOdometer', 1, 'The total distance travelled by the particular vehicle since its initial production, as read from its odometer.<br /> Typical unit code(s): KMT for kilometers, SMI for statute miles');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371484', 'totalTime', 'totalTime', 1, 'The total time it takes to prepare and cook the recipe, in ISO 8601 duration format.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371485', 'homeTeam', 'homeTeam', 1, 'The home team in a sports event.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371486', 'artworkSurface', 'artworkSurface', 1, 'The supporting materials for the artwork, e.g. Canvas, Paper, Wood, Board, etc.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371487', 'legalName', 'legalName', 1, 'The official name of the organization, e.g. the registered company name.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371488', 'videoQuality', 'videoQuality', 1, 'The quality of the video.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371489', 'contentSize', 'contentSize', 1, 'File size in (mega/kilo) bytes.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371490', 'expertConsiderations', 'expertConsiderations', 1, 'Medical expert advice related to the plan.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371491', 'serviceOutput', 'serviceOutput', 1, 'The tangible thing generated by the service, e.g. a passport, permit, etc.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371492', 'jobLocation', 'jobLocation', 1, 'A (typically single) geographic location associated with the job position.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371493', 'httpMethod', 'httpMethod', 1, 'An HTTP method that specifies the appropriate HTTP method for a request to an HTTP EntryPoint. Values are capitalized strings as used in HTTP.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371494', 'typicalTest', 'typicalTest', 1, 'A medical test typically performed given this condition.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371495', 'significantLink', 'significantLink', 1, 'One of the more significant URLs on the page. Typically, these are the non-navigation links that are clicked on the most.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371496', 'performer', 'performer', 1, 'A performer at the event&#x2014;for example, a presenter, musician, musical group or actor.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371497', 'leiCode', 'leiCode', 1, 'An organization identifier that uniquely identifies a legal entity as defined in ISO 17442.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371498', 'doorTime', 'doorTime', 1, 'The time admission will commence.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371499', 'dateModified', 'dateModified', 1, 'The date on which the CreativeWork was most recently modified or when the item\"s entry was modified within a DataFeed.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371500', 'workPerformed', 'workPerformed', 1, 'A work performed in some event, for example a play performed in a TheaterEvent.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371501', 'follows', 'follows', 1, 'The most generic uni-directional social relation.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371502', 'serviceLocation', 'serviceLocation', 1, 'The location (e.g. civic structure, local business, etc.) where a person can go to access the service.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371503', 'arrivalPlatform', 'arrivalPlatform', 1, 'The platform where the train arrives.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371505', 'commentText', 'commentText', 1, 'The text of the UserComment.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371506', 'softwareHelp', 'softwareHelp', 1, 'Software application help.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371507', 'photo', 'photo', 1, 'A photograph of this place.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371508', 'availableIn', 'availableIn', 1, 'The location in which the strength is available.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371509', 'encodingFormat', 'encodingFormat', 1, 'mp3, mpeg4, etc.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371510', 'maximumIntake', 'maximumIntake', 1, 'Recommended intake of this supplement for a given population as defined by a specific recommending authority.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371511', 'storageRequirements', 'storageRequirements', 1, 'Storage requirements (free space required).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371512', 'application', 'application', 1, 'An application that can complete the request.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371513', 'muscleAction', 'muscleAction', 1, 'The movement the muscle generates.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371514', 'serviceArea', 'serviceArea', 1, 'The geographic area where the service is provided.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371515', 'artMedium', 'artMedium', 1, 'The material used. (e.g. Oil, Watercolour, Acrylic, Linoprint, Marble, Cyanotype, Digital, Lithograph, DryPoint, Intaglio, Pastel, Woodcut, Pencil, Mixed Media, etc.)');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371516', 'parentItem', 'parentItem', 1, 'The parent of a question, answer or item in general.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371517', 'busNumber', 'busNumber', 1, 'The unique identifier for the bus.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371518', 'dropoffTime', 'dropoffTime', 1, 'When a rental car can be dropped off.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371519', 'episode', 'episode', 1, 'An episode of a tv, radio or game media within a series or season.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371520', 'eligibleDuration', 'eligibleDuration', 1, 'The duration for which the given offer is valid.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371521', 'lowPrice', 'lowPrice', 1, 'The lowest price of all offers available.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371522', 'orderQuantity', 'orderQuantity', 1, 'The number of the item ordered. If the property is not set, assume the quantity is one.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371523', 'cheatCode', 'cheatCode', 1, 'Cheat codes to the game.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371524', 'catalog', 'catalog', 1, 'A data catalog which contains this dataset.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371525', 'isVariantOf', 'isVariantOf', 1, 'A pointer to a base product from which this product is a variant. It is safe to infer that the variant inherits all product features from the base model, unless defined locally. This is not transitive.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371526', 'spouse', 'spouse', 1, 'The person\"s spouse.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371527', 'productSupported', 'productSupported', 1, 'The product or service this support contact point is related to (such as product support for a particular product line). This can be a specific product or product line (e.g. \"iPhone\") or a general category of products or services (e.g. \"smartphones\").');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371528', 'bodyLocation', 'bodyLocation', 1, 'Location in the body of the anatomical structure.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371529', 'vehicleEngine', 'vehicleEngine', 1, 'Information about the engine or engines of the vehicle.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371530', 'specialCommitments', 'specialCommitments', 1, 'Any special commitments associated with this job posting. Valid entries include VeteranCommit, MilitarySpouseCommit, etc.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371531', 'width', 'width', 1, 'The width of the item.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371532', 'departureAirport', 'departureAirport', 1, 'The airport where the flight originates.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371533', 'runtimePlatform', 'runtimePlatform', 1, 'Runtime platform or script interpreter dependencies (Example - Java v1, Python2.3, .Net Framework 3.0).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371534', 'healthPlanMarketingUrl', 'healthPlanMarketingUrl', 1, 'The URL that goes directly to the plan brochure for the specific standard plan or plan variation.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371535', 'issn', 'issn', 1, 'The International Standard Serial Number (ISSN) that identifies this periodical. You can repeat this property to (for example) identify different formats of this periodical.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371536', 'proprietaryName', 'proprietaryName', 1, 'Proprietary name given to the diet plan, typically by its originator or creator.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371537', 'catalogNumber', 'catalogNumber', 1, 'The catalog number for the release.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371538', 'replyToUrl', 'replyToUrl', 1, 'The URL at which a reply may be posted to the specified UserComment.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371539', 'passengerSequenceNumber', 'passengerSequenceNumber', 1, 'The passenger\"s sequence number as assigned by the airline.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371540', 'messageAttachment', 'messageAttachment', 1, 'A CreativeWork attached to the message.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371541', 'expectsAcceptanceOf', 'expectsAcceptanceOf', 1, 'An Offer which must be accepted before the user can perform the Action. For example, the user may need to buy a movie before being able to watch it.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371542', 'partOfEpisode', 'partOfEpisode', 1, 'The episode to which this clip belongs.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371543', 'minPrice', 'minPrice', 1, 'The lowest price if the price is a range.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371544', 'howPerformed', 'howPerformed', 1, 'How the procedure is performed.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371545', 'orderDate', 'orderDate', 1, 'Date order was placed.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371546', 'wordCount', 'wordCount', 1, 'The number of words in the text of the Article.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371547', 'broadcastServiceTier', 'broadcastServiceTier', 1, 'The type of service required to have access to the channel (e.g. Standard or Premium).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371548', 'workHours', 'workHours', 1, 'The typical working hours for this job (e.g. 1st shift, night shift, 8am-5pm).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371549', 'articleSection', 'articleSection', 1, 'Articles may belong to one or more \"sections\" in a magazine or newspaper, such as Sports, Lifestyle, etc.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371550', 'worstRating', 'worstRating', 1, 'The lowest value allowed in this rating system. If worstRating is omitted, 1 is assumed.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371551', 'programName', 'programName', 1, 'The program providing the membership.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371552', 'diagnosis', 'diagnosis', 1, 'One or more alternative conditions considered in the differential diagnosis process as output of a diagnosis process.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371553', 'productionCompany', 'productionCompany', 1, 'The production company or studio responsible for the item e.g. series, video game, episode etc.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371554', 'instrument', 'instrument', 1, 'The object that helped the agent perform the action. e.g. John wrote a book with <em>a pen</em>.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371555', 'gameLocation', 'gameLocation', 1, 'Real or fictional location of the game (or part of game).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371556', 'underName', 'underName', 1, 'The person or organization the reservation or ticket is for.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371557', 'origin', 'origin', 1, 'The place or point where a muscle arises.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371558', 'overview', 'overview', 1, 'Descriptive information establishing the overarching theory/philosophy of the plan. May include the rationale for the name, the population where the plan first came to prominence, etc.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371559', 'guideline', 'guideline', 1, 'A medical guideline related to this entity.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371560', 'assemblyVersion', 'assemblyVersion', 1, 'Associated product/technology version. e.g., .NET Framework 4.5.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371561', 'flightDistance', 'flightDistance', 1, 'The distance of the flight.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371562', 'url', 'url', 1, 'URL of the item.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371563', 'numberOfPages', 'numberOfPages', 1, 'The number of pages in the book.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371564', 'interactionStatistic', 'interactionStatistic', 1, 'The number of interactions for the CreativeWork using the WebSite or SoftwareApplication. The most specific child type of InteractionCounter should be used.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371565', 'suggestedGender', 'suggestedGender', 1, 'The gender of the person or audience.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371566', 'position', 'position', 1, 'The position of an item in a series or sequence of items.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371567', 'encodings', 'encodings', 1, 'A media object that encodes this CreativeWork.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371568', 'contraindication', 'contraindication', 1, 'A contraindication for this therapy.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371569', 'identifyingTest', 'identifyingTest', 1, 'A diagnostic test that can identify this sign.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371570', 'printPage', 'printPage', 1, 'If this NewsArticle appears in print, this field indicates the name of the page on which the article is found. Please note that this field is intended for the exact page name (e.g. A5, B18).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371572', 'requiredGender', 'requiredGender', 1, 'Audiences defined by a person\"s gender.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371573', 'aggregateRating', 'aggregateRating', 1, 'The overall rating, based on a collection of reviews or ratings, of the item.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371575', 'codeSampleType', 'codeSampleType', 1, 'Full (compile ready) solution, code snippet, inline code, scripts, template.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371576', 'scheduledPaymentDate', 'scheduledPaymentDate', 1, 'The date the invoice is scheduled to be paid.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371577', 'longitude', 'longitude', 1, 'The longitude of a location. For example <code>-122.08585</code> (<a href=\"https://en.wikipedia.org/wiki/World_Geodetic_System\">WGS 84</a>).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371578', 'salaryCurrency', 'salaryCurrency', 1, 'The currency (coded using ISO 4217, http://en.wikipedia.org/wiki/ISO_4217 ) used for the main salary information in this job posting or for this employee.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371579', 'geoMidpoint', 'geoMidpoint', 1, 'Indicates the GeoCoordinates at the centre of a GeoShape e.g. GeoCircle.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371580', 'workExample', 'workExample', 1, 'Example/instance/realization/derivation of the concept of this creative work. eg. The paperback edition, first edition, or eBook.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371581', 'subTest', 'subTest', 1, 'A component test of the panel.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371582', 'contentReferenceTime', 'contentReferenceTime', 1, 'The specific time described by a creative work, for works (e.g. articles, video objects etc.) that emphasise a particular moment within an Event.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371583', 'seasons', 'seasons', 1, 'A season in a media series.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371584', 'alignmentType', 'alignmentType', 1, 'A category of alignment between the learning resource and the framework node. Recommended values include: \"assesses\", \"teaches\", \"requires\", \"textComplexity\", \"readingLevel\", \"educationalSubject\", and \"educationLevel\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371586', 'isbn', 'isbn', 1, 'The ISBN of the book.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371587', 'exampleOfWork', 'exampleOfWork', 1, 'A creative work that this work is an example/instance/realization/derivation of.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371588', 'reviewRating', 'reviewRating', 1, 'The rating given in this review. Note that reviews can themselves be rated. The <code>reviewRating</code> applies to rating given by the review. The <code>aggregateRating</code> property applies to the review itself, as a creative work.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371589', 'requirements', 'requirements', 1, 'Component dependency requirements for application. This includes runtime environments and shared libraries that are not included in the application distribution package, but required to run the application (Examples: DirectX, Java or .NET runtime).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371590', 'jobBenefits', 'jobBenefits', 1, 'Description of benefits associated with the job.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371591', 'isicV4', 'isicV4', 1, 'The International Standard of Industrial Classification of All Economic Activities (ISIC), Revision 4 code for a particular organization, business person, or place.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371592', 'nextItem', 'nextItem', 1, 'A link to the ListItem that follows the current one.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371593', 'editor', 'editor', 1, 'Specifies the Person who edited the CreativeWork.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371594', 'issueNumber', 'issueNumber', 1, 'Identifies the issue of publication; for example, \"iii\" or \"2\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371595', 'benefits', 'benefits', 1, 'Description of benefits associated with the job.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371596', 'blogPosts', 'blogPosts', 1, 'The postings that are part of this blog.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371597', 'cholesterolContent', 'cholesterolContent', 1, 'The number of milligrams of cholesterol.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371598', 'programMembershipUsed', 'programMembershipUsed', 1, 'Any membership in a frequent flyer, hotel loyalty program, etc. being applied to the reservation.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371599', 'qualifications', 'qualifications', 1, 'Specific qualifications required for this role.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371600', 'locationCreated', 'locationCreated', 1, 'The location where the CreativeWork was created, which may not be the same as the location depicted in the CreativeWork.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371601', 'episodes', 'episodes', 1, 'An episode of a TV/radio series or season.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371602', 'occupationalCategory', 'occupationalCategory', 1, 'Category or categories describing the job. Use BLS O*NET-SOC taxonomy: http://www.onetcenter.org/taxonomy.html. Ideally includes textual label and formal code, with the property repeated for each applicable value.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371603', 'availabilityStarts', 'availabilityStarts', 1, 'The beginning of the availability of the product or service included in the offer.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371604', 'nonProprietaryName', 'nonProprietaryName', 1, 'The generic name of this drug or supplement.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371605', 'endTime', 'endTime', 1, 'The endTime of something. For a reserved event or service (e.g. FoodEstablishmentReservation), the time that it is expected to end. For actions that span a period of time, when the action was performed. e.g. John wrote a book from January to <em>December</em>.</p> <p>Note that Event uses startDate/endDate instead of startTime/endTime, even when describing dates with times. This situation may be clarified in future revisions.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371606', 'expires', 'expires', 1, 'Date the content expires and is no longer useful or available. Useful for videos.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371607', 'durationOfWarranty', 'durationOfWarranty', 1, 'The duration of the warranty promise. Common unitCode values are ANN for year, MON for months, or DAY for days.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371608', 'referenceQuantity', 'referenceQuantity', 1, 'The reference quantity for which a certain price applies, e.g. 1 EUR per 4 kWh of electricity. This property is a replacement for unitOfMeasurement for the advanced cases where the price does not relate to a standard unit.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371609', 'minimumPaymentDue', 'minimumPaymentDue', 1, 'The minimum payment required at this time.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371610', 'coursePrerequisites', 'coursePrerequisites', 1, 'Requirements for taking the Course. May be completion of another Course or a textual description like \"permission of instructor\". Requirements may be a pre-requisite competency, referenced using AlignmentObject.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371611', 'hoursAvailable', 'hoursAvailable', 1, 'The hours during which this service or contact is available.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371612', 'parent', 'parent', 1, 'A parent of this person.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371613', 'riskFactor', 'riskFactor', 1, 'A modifiable or non-modifiable factor that increases the risk of a patient contracting this condition, e.g. age,  coexisting condition.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371614', 'elevation', 'elevation', 1, 'The elevation of a location (<a href=\"https://en.wikipedia.org/wiki/World_Geodetic_System\">WGS 84</a>).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371615', 'surface', 'surface', 1, 'e.g. Canvas, Paper, Wood, Board, etc.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371616', 'accountId', 'accountId', 1, 'The identifier for the account the payment will be applied to.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371617', 'volumeNumber', 'volumeNumber', 1, 'Identifies the volume of publication or multi-part work; for example, \"iii\" or \"2\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371618', 'recordingOf', 'recordingOf', 1, 'The composition this track is a recording of.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371619', 'paymentDue', 'paymentDue', 1, 'The date that payment is due.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371620', 'upvoteCount', 'upvoteCount', 1, 'The number of upvotes this question, answer or comment has received from the community.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371621', 'departureStation', 'departureStation', 1, 'The station from which the train departs.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371622', 'isGift', 'isGift', 1, 'Was the offer accepted as a gift for someone other than the buyer.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371623', 'alternateName', 'alternateName', 1, 'An alias for the item.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371624', 'numberOfPreviousOwners', 'numberOfPreviousOwners', 1, 'The number of owners of the vehicle, including the current one.<br /> Typical unit code(s): C62');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371625', 'relatedDrug', 'relatedDrug', 1, 'Any other drug related to this one, for example commonly-prescribed alternatives.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371626', 'area', 'area', 1, 'The area within which users can expect to reach the broadcast service.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371627', 'album', 'album', 1, 'A music album.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371628', 'cookTime', 'cookTime', 1, 'The time it takes to actually cook the dish, in ISO 8601 duration format.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371629', 'population', 'population', 1, 'Any characteristics of the population used in the study, e.g. \"males under 65\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371630', 'circle', 'circle', 1, 'A circle is the circular region of a specified radius centered at a specified latitude and longitude. A circle is expressed as a pair followed by a radius in meters.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371631', 'game', 'game', 1, 'Video game which is played on this server.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371632', 'associatedMedia', 'associatedMedia', 1, 'A media object that encodes this CreativeWork. This property is a synonym for encoding.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371633', 'course', 'course', 1, 'A sub property of location. The course where this action was taken.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371634', 'schemaVersion', 'schemaVersion', 1, 'Indicates (by URL or string) a particular version of a schema used in some CreativeWork. For example, a document could declare a schemaVersion using an URL such as http://schema.org/version/2.0/ if precise indication of schema version was required by some application.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371635', 'webCheckinTime', 'webCheckinTime', 1, 'The time when a passenger can check into the flight online.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371636', 'interestRate', 'interestRate', 1, 'The interest rate, charged or paid, applicable to the financial product. Note: This is different from the calculated annualPercentageRate.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371637', 'tributary', 'tributary', 1, 'The anatomical or organ system that the vein flows into; a larger structure that the vein connects to.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371638', 'safetyConsideration', 'safetyConsideration', 1, 'Any potential safety concern associated with the supplement. May include interactions with other drugs and foods, pregnancy, breastfeeding, known adverse reactions, and documented efficacy of the supplement.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371639', 'speed', 'speed', 1, '<p>The speed range of the vehicle. If the vehicle is powered by an engine, the upper limit of the speed range (indicated by <a href=\"maxValue\">maxValue</a>) should be the maximum speed achievable under regular conditions.<br />     Typical unit code(s): KMH for km/h, HM for mile per hour (0.447 04 m/s), KNT for knot<br /></p> <pre><code>Note 1: Use &lt;a href=\"minValue\"&gt;minValue&lt;/a&gt; and &lt;a href=\"maxValue\"&gt;maxValue&lt;/a&gt; to indicate the range. Typically, the minimal value is zero.&lt;br /&gt; Note 2: There are many different ways of measuring the speed range. You can link to information about how the given value has been determined using the &lt;a href=\"valueReference\"&gt;valueReference&lt;/a&gt; property. </code></pre>');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371640', 'albumRelease', 'albumRelease', 1, 'A release of this album.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371641', 'alumni', 'alumni', 1, 'Alumni of an organization.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371642', 'serviceAudience', 'serviceAudience', 1, 'The audience eligible for this service.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371643', 'deliveryStatus', 'deliveryStatus', 1, 'New entry added as the package passes through each leg of its journey (from shipment to final delivery).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371644', 'memoryRequirements', 'memoryRequirements', 1, 'Minimum memory requirements.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371645', 'stepValue', 'stepValue', 1, 'The stepValue attribute indicates the granularity that is expected (and required) of the value in a PropertyValueSpecification.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371646', 'fuelEfficiency', 'fuelEfficiency', 1, 'The distance traveled per unit of fuel used; most commonly miles per gallon (mpg) or kilometers per liter (km/L).<br /> Note 1: There are unfortunately no standard unit codes for miles per gallon or kilometers per liter.<br /> Use <a href=\"unitText\">unitText</a> to indicate the unit of measurement, e.g. mpg or km/L. Note 2: There are two ways of indicating the fuel consumption, <a href=\"fuelConsumption\">fuelConsumption</a> (e.g. 8 liters per 100 km) and <a href=\"fuelEfficiency\">fuelEfficiency</a> (e.g. 30 miles per gallon). They are reciprocal.<br /> Note 3: Often, the absolute value is useful only when related to driving speed (\"at 80 km/h\") or usage pattern (\"city traffic\"). You can use <a href=\"valueReference\">valueReference</a> to link the value for the fuel economy to another value.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371647', 'parentService', 'parentService', 1, 'A broadcast service to which the broadcast service may belong to such as regional variations of a national channel.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371648', 'indication', 'indication', 1, 'A factor that indicates use of this therapy for treatment and/or prevention of a condition, symptom, etc. For therapies such as drugs, indications can include both officially-approved indications as well as off-label uses. These can be distinguished by using the ApprovedIndication subtype of MedicalIndication.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371649', 'paymentMethodId', 'paymentMethodId', 1, 'An identifier for the method of payment used (e.g. the last 4 digits of the credit card).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371650', 'bookEdition', 'bookEdition', 1, 'The edition of the book.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371651', 'tickerSymbol', 'tickerSymbol', 1, 'The exchange traded instrument associated with a Corporation object. The tickerSymbol is expressed as an exchange and an instrument name separated by a space character. For the exchange component of the tickerSymbol attribute, we reccommend using the controlled vocaulary of Market Identifier Codes (MIC) specified in ISO15022.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371652', 'unsaturatedFatContent', 'unsaturatedFatContent', 1, 'The number of grams of unsaturated fat.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371653', 'spokenByCharacter', 'spokenByCharacter', 1, 'The (e.g. fictional) character, Person or Organization to whom the quotation is attributed within the containing CreativeWork.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371654', 'distance', 'distance', 1, 'The distance travelled, e.g. exercising or travelling.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371655', 'providesService', 'providesService', 1, 'The service provided by this channel.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371656', 'accessibilityHazard', 'accessibilityHazard', 1, 'A characteristic of the described resource that is physiologically dangerous to some users. Related to WCAG 2.0 guideline 2.3 (<a href=\"http://www.w3.org/wiki/WebSchemas/Accessibility\">WebSchemas wiki lists possible values</a>).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371657', 'telephone', '联系电话', 1, 'The telephone number.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371658', 'isAcceptingNewPatients', 'isAcceptingNewPatients', 1, 'Whether the provider is accepting new patients.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371659', 'deathDate', 'deathDate', 1, 'Date of death.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371660', 'duplicateTherapy', 'duplicateTherapy', 1, 'A therapy that duplicates or overlaps this one.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371661', 'primaryPrevention', 'primaryPrevention', 1, 'A preventative therapy used to prevent an initial occurrence of the medical condition, such as vaccination.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371662', 'priceType', 'priceType', 1, 'A short text or acronym indicating multiple price specifications for the same offer, e.g. SRP for the suggested retail price or INVOICE for the invoice price, mostly used in the car industry.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371663', 'endorsers', 'endorsers', 1, 'People or organizations that endorse the plan.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371664', 'accessMode', 'accessMode', 1, 'The human sensory perceptual system or cognitive faculty through which a person may process or perceive information. Expected values include: auditory, tactile, textual, visual, colorDependent, chartOnVisual, chemOnVisual, diagramOnVisual, mathOnVisual, musicOnVisual, textOnVisual.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371665', 'broadcastFrequencyValue', 'broadcastFrequencyValue', 1, 'The frequency in MHz for a particular broadcast.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371666', 'accessibilitySummary', 'accessibilitySummary', 1, 'A human-readable summary of specific accessibility features or deficiencies, consistent with the other accessibility metadata but expressing subtleties such as \"short descriptions are present but long descriptions will be needed for non-visual users\" or \"short descriptions are present and no long descriptions are needed.\"');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371667', 'merchant', 'merchant', 1, 'merchant is an out-dated term for \"seller\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371668', 'audience', 'audience', 1, 'An intended audience, i.e. a group for whom something was created.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371669', 'applicableLocation', 'applicableLocation', 1, 'The location in which the status applies.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371671', 'busName', 'busName', 1, 'The name of the bus (e.g. Bolt Express).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371672', 'validIn', 'validIn', 1, 'The geographic area where the permit is valid.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371673', 'publicationType', 'publicationType', 1, 'The type of the medical article, taken from the US NLM MeSH publication type catalog. See also <a href=\"http://www.nlm.nih.gov/mesh/pubtypes.html\">MeSH documentation</a>.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371674', 'employee', 'employee', 1, 'Someone working for this organization.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371675', 'usesDevice', 'usesDevice', 1, 'Device used to perform the test.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371676', 'carbohydrateContent', 'carbohydrateContent', 1, 'The number of grams of carbohydrates.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371677', 'servingSize', 'servingSize', 1, 'The serving size, in terms of the number of volume or mass.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371678', 'gtin13', 'gtin13', 1, 'The <a href=\"http://ocp.gs1.org/sites/glossary/en-gb/Pages/GTIN-13.aspx\">GTIN-13</a> code of the product, or the product to which the offer refers. This is equivalent to 13-digit ISBN codes and EAN UCC-13. Former 12-digit UPC codes can be converted into a GTIN-13 code by simply adding a preceeding zero. See <a href=\"http://www.gs1.org/barcodes/technical/idkeys/gtin\">GS1 GTIN Summary</a> for more details.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371679', 'priceSpecification', 'priceSpecification', 1, 'One or more detailed price specifications, indicating the unit price and delivery or payment charges.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371680', 'inBroadcastLineup', 'inBroadcastLineup', 1, 'The CableOrSatelliteService offering the channel.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371681', 'pickupLocation', 'pickupLocation', 1, 'Where a taxi will pick up a passenger or a rental car can be picked up.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371682', 'itemReviewed', 'itemReviewed', 1, 'The item that is being reviewed/rated.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371683', 'ticketNumber', 'ticketNumber', 1, 'The unique identifier for the ticket.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371684', 'intensity', 'intensity', 1, 'Quantitative measure gauging the degree of force involved in the exercise, for example, heartbeats per minute. May include the velocity of the movement.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371685', 'usesHealthPlanIdStandard', 'usesHealthPlanIdStandard', 1, 'The standard for interpreting thePlan ID. The preferred is \"HIOS\". See the Centers for Medicare &amp; Medicaid Services for more details.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371686', 'sponsor', 'sponsor', 1, 'A person or organization that supports a thing through a pledge, promise, or financial contribution. e.g. a sponsor of a Medical Study or a corporate sponsor of an event.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371687', 'availableFrom', 'availableFrom', 1, 'When the item is available for pickup from the store, locker, etc.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371688', 'collection', 'collection', 1, 'A sub property of object. The collection target of the action.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371689', 'encoding', 'encoding', 1, 'A media object that encodes this CreativeWork. This property is a synonym for associatedMedia.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371690', 'recipeIngredient', 'recipeIngredient', 1, 'A single ingredient used in the recipe, e.g. sugar, flour or garlic.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371691', 'costOrigin', 'costOrigin', 1, 'Additional details to capture the origin of the cost data. For example, \"Medicare Part B\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371692', 'aircraft', 'aircraft', 1, 'The kind of aircraft (e.g., \"Boeing 747\").');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371693', 'labelDetails', 'labelDetails', 1, 'Link to the drug\"s label details.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371694', 'quest', 'quest', 1, 'The task that a player-controlled character, or group of characters may complete in order to gain a reward.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371695', 'namedPosition', 'namedPosition', 1, 'A position played, performed or filled by a person or organization, as part of an organization. For example, an athlete in a SportsTeam might play in the position named \"Quarterback\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371696', 'recordedAs', 'recordedAs', 1, 'An audio recording of the work.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371697', 'saturatedFatContent', 'saturatedFatContent', 1, 'The number of grams of saturated fat.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371698', 'gameTip', 'gameTip', 1, 'Links to tips, tactics, etc.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371699', 'causeOf', 'causeOf', 1, 'The condition, complication, symptom, sign, etc. caused.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371700', 'drainsTo', 'drainsTo', 1, 'The vasculature that the vein drains into.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371701', 'numberOfEmployees', 'numberOfEmployees', 1, 'The number of employees in an organization e.g. business.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371702', 'significance', 'significance', 1, 'The significance associated with the superficial anatomy; as an example, how characteristics of the superficial anatomy can suggest underlying medical conditions or courses of treatment.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371703', 'releasedEvent', 'releasedEvent', 1, 'The place and time the release was issued, expressed as a PublicationEvent.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371704', 'target', 'target', 1, 'Indicates a target EntryPoint for an Action.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371705', 'musicGroupMember', 'musicGroupMember', 1, 'A member of a music group&#x2014;for example, John, Paul, George, or Ringo.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371706', 'healthPlanId', 'healthPlanId', 1, 'The 14-character, HIOS-generated Plan ID number. (Plan IDs must be unique, even across different markets.)');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371707', 'numberOfSeasons', 'numberOfSeasons', 1, 'The number of seasons in this series.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371708', 'mpn', 'mpn', 1, 'The Manufacturer Part Number (MPN) of the product, or the product to which the offer refers.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371709', 'deathPlace', 'deathPlace', 1, 'The place where the person died.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371710', 'geoRadius', 'geoRadius', 1, 'Indicates the approximate radius of a GeoCircle (metres unless indicated otherwise via Distance notation).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371711', 'lastReviewed', 'lastReviewed', 1, 'Date on which the content on this web page was last reviewed for accuracy and/or completeness.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371712', 'item', 'item', 1, 'An entity represented by an entry in a list or data feed (e.g. an \"artist\" in a list of \"artists\")’.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371713', 'strengthUnit', 'strengthUnit', 1, 'The units of an active ingredient\"s strength, e.g. mg.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371714', 'taxID', 'taxID', 1, 'The Tax / Fiscal ID of the organization or person, e.g. the TIN in the US or the CIF/NIF in Spain.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371715', 'executableLibraryName', 'executableLibraryName', 1, 'Library file name e.g., mscorlib.dll, system.web.dll.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371716', 'ratingCount', 'ratingCount', 1, 'The count of total number of ratings.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371717', 'arrivalGate', 'arrivalGate', 1, 'Identifier of the flight\"s arrival gate.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371718', 'broadcastDisplayName', 'broadcastDisplayName', 1, 'The name displayed in the channel guide. For many US affiliates, it is the network name.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371719', 'totalPrice', 'totalPrice', 1, 'The total price for the reservation or ticket, including applicable taxes, shipping, etc.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371720', 'numAdults', 'numAdults', 1, 'The number of adults staying in the unit.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371721', 'employmentType', 'employmentType', 1, 'Type of employment (e.g. full-time, part-time, contract, temporary, seasonal, internship).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371722', 'episodeNumber', 'episodeNumber', 1, 'Position of the episode within an ordered group of episodes.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371723', 'propertyID', 'propertyID', 1, 'A commonly used identifier for the characteristic represented by the property, e.g. a manufacturer or a standard code for a property. propertyID can be (1) a prefixed string, mainly meant to be used with standards for product properties; (2) a site-specific, non-prefixed string (e.g. the primary key of the property or the vendor-specific id of the property), or (3) a URL indicating the type of the property, either pointing to an external vocabulary, or a Web resource that describes the property (e.g. a glossary entry). Standards bodies should promote a standard prefix for the identifiers of properties from their standards.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371724', 'lodgingUnitType', 'lodgingUnitType', 1, 'Textual description of the unit type (including suite vs. room, size of bed, etc.).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371725', 'physiologicalBenefits', 'physiologicalBenefits', 1, 'Specific physiologic benefits associated to the plan.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371726', 'availableLanguage', 'availableLanguage', 1, 'A language someone may use with the item. Please use one of the language codes from the <a href=\"http://tools.ietf.org/html/bcp47\">IETF BCP 47 standard</a>. See also <a class=\"localLink\" href=\"/inLanguage\">inLanguage</a>.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371727', 'containsPlace', 'containsPlace', 1, 'The basic containment relation between a place and another that it contains.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371728', 'interactionService', 'interactionService', 1, 'The WebSite or SoftwareApplication where the interactions took place.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371729', 'rxcui', 'rxcui', 1, 'The RxCUI drug identifier from RXNORM.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371730', 'recordedAt', 'recordedAt', 1, 'The Event where the CreativeWork was recorded. The CreativeWork may capture all or part of the event.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371731', 'siblings', 'siblings', 1, 'A sibling of the person.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371732', 'transFatContent', 'transFatContent', 1, 'The number of grams of trans fat.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371733', 'activeIngredient', 'activeIngredient', 1, 'An active ingredient, typically chemical compounds and/or biologic substances.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371734', 'datePublished', 'datePublished', 1, 'Date of first broadcast/publication.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371735', 'modelDate', 'modelDate', 1, 'The release date of a vehicle model (often used to differentiate versions of the same make and model).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371736', 'associatedArticle', 'associatedArticle', 1, 'A NewsArticle associated with the Media Object.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371737', 'encodesCreativeWork', 'encodesCreativeWork', 1, 'The CreativeWork encoded by this media object.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371738', 'hiringOrganization', 'hiringOrganization', 1, 'Organization offering the job position.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371739', 'homeLocation', 'homeLocation', 1, 'A contact location for a person\"s residence.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371740', 'seller', 'seller', 1, 'An entity which offers (sells / leases / lends / loans) the services / goods.  A seller may also be a provider.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371741', 'photos', 'photos', 1, 'Photographs of this place.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371742', 'stage', 'stage', 1, 'The stage of the condition, if applicable.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371743', 'targetDescription', 'targetDescription', 1, 'The description of a node in an established educational framework.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371744', 'accessibilityControl', 'accessibilityControl', 1, 'Identifies input methods that are sufficient to fully control the described resource (<a href=\"http://www.w3.org/wiki/WebSchemas/Accessibility\">WebSchemas wiki lists possible values</a>).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371745', 'possibleTreatment', 'possibleTreatment', 1, 'A possible treatment to address this condition, sign or symptom.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371746', 'duration', 'duration', 1, 'The duration of the item (movie, audio recording, event, etc.) in <a href=\"http://en.wikipedia.org/wiki/ISO_8601\">ISO 8601 date format</a>.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371747', 'loanTerm', 'loanTerm', 1, 'The duration of the loan or credit agreement.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371749', 'subEvents', 'subEvents', 1, 'Events that are a part of this event. For example, a conference event includes many presentations, each subEvents of the conference.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371750', 'dropoffLocation', 'dropoffLocation', 1, 'Where a rental car can be dropped off.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371751', 'discount', 'discount', 1, 'Any discount applied (to an Order).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371752', 'postOfficeBoxNumber', 'postOfficeBoxNumber', 1, 'The post office box number for PO box addresses.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371753', 'bestRating', 'bestRating', 1, 'The highest value allowed in this rating system. If bestRating is omitted, 5 is assumed.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371754', 'commentTime', 'commentTime', 1, 'The time at which the UserComment was made.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371755', 'productID', 'productID', 1, 'The product identifier, such as ISBN. For example: <code>&lt;meta itemprop=\"productID\" content=\"isbn:123-456-789\"/&gt;</code>.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371756', 'broadcastAffiliateOf', 'broadcastAffiliateOf', 1, 'The media network(s) whose content is broadcast on this station.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371757', 'servicePhone', 'servicePhone', 1, 'The phone number to use to access the service.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371758', 'relatedTo', 'relatedTo', 1, 'The most generic familial relation.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371759', 'isAccessibleForFree', 'isAccessibleForFree', 1, 'A flag to signal that the publication is accessible for free.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371760', 'recipeInstructions', 'recipeInstructions', 1, 'A step or instruction involved in making the recipe.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371761', 'arrivalBusStop', 'arrivalBusStop', 1, 'The stop or station from which the bus arrives.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371762', 'height', 'height', 1, 'The height of the item.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371763', 'payload', 'payload', 1, '<p>The permitted weight of passengers and cargo, EXCLUDING the weight of the empty vehicle. <br />     Typical unit code(s): KGM for kilogram, LBR for pound<br /></p> <pre><code>Note 1: Many databases specify the permitted TOTAL weight instead, which is the sum of &lt;a href=\"weight\"&gt;weight&lt;/a&gt; and &lt;a href=\"payload\"&gt;payload&lt;/a&gt;.&lt;br /&gt; Note 2: You can indicate additional information in the &lt;a href=\"name\"&gt;name&lt;/a&gt; of the &lt;a href=\"QuantitativeValue\"&gt;QuantitativeValue&lt;/a&gt; node.&lt;br /&gt; Note 3: You may also link to a &lt;a href=\"QualitativeValue\"&gt;QualitativeValue&lt;/a&gt; node that provides additional information using &lt;a href=\"valueReference\"&gt;valueReference&lt;/a&gt;.&lt;br /&gt; Note 4: Note that you can use &lt;a href=\"minValue\"&gt;minValue&lt;/a&gt; and &lt;a href=\"maxValue\"&gt;maxValue&lt;/a&gt; to indicate ranges. </code></pre>');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371764', 'responsibilities', 'responsibilities', 1, 'Responsibilities associated with this role.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371765', 'articleBody', 'articleBody', 1, 'The actual body of the article.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371766', 'numberOfEpisodes', 'numberOfEpisodes', 1, 'The number of episodes in this season or series.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371767', 'weight', 'weight', 1, 'The weight of the product or person.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371768', 'printSection', 'printSection', 1, 'If this NewsArticle appears in print, this field indicates the print section in which the article appeared.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371769', 'subEvent', 'subEvent', 1, 'An Event that is part of this event. For example, a conference event includes many presentations, each of which is a subEvent of the conference.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371770', 'dataFeedElement', 'dataFeedElement', 1, 'An item within in a data feed. Data feeds may have many elements.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371771', 'inverseOf', 'inverseOf', 1, 'Relates a property to a property that is its inverse. Inverse properties relate the same pairs of items to each other, but in reversed direction. For example, the \"alumni\" and \"alumniOf\" properties are inverseOf each other. Some properties don\"t have explicit inverses; in these situations RDFa and JSON-LD syntax for reverse properties can be used.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371772', 'audienceType', 'audienceType', 1, 'The target group associated with a given audience (e.g. veterans, car owners, musicians, etc.).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371773', 'orderNumber', 'orderNumber', 1, 'The identifier of the transaction.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371774', 'actionPlatform', 'actionPlatform', 1, 'The high level platform(s) where the Action can be performed for the given URL. To specify a specific application or operating system instance, use actionApplication.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371775', 'departureTerminal', 'departureTerminal', 1, 'Identifier of the flight\"s departure terminal.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371776', 'parentOrganization', 'parentOrganization', 1, 'The larger organization that this local business is a branch of, if any.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371777', 'deliveryLeadTime', 'deliveryLeadTime', 1, 'The typical delay between the receipt of the order and the goods leaving the warehouse.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371778', 'epidemiology', 'epidemiology', 1, 'The characteristics of associated patients, such as age, gender, race etc.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371779', 'arrivalTerminal', 'arrivalTerminal', 1, 'Identifier of the flight\"s arrival terminal.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371780', 'representativeOfPage', 'representativeOfPage', 1, 'Indicates whether this image is representative of the content of the page.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371781', 'superEvent', 'superEvent', 1, 'An event that this event is a part of. For example, a collection of individual music performances might each have a music festival as their superEvent.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371782', 'opens', 'opens', 1, 'The opening hour of the place or service on the given day(s) of the week.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371783', 'significantLinks', 'significantLinks', 1, 'The most significant URLs on the page. Typically, these are the non-navigation links that are clicked on the most.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371784', 'cargoVolume', 'cargoVolume', 1, 'The available volume for cargo or luggage. For automobiles, this is usually the trunk volume.<br /> Typical unit code(s): LTR for liters, FTQ for cubic foot/feet<br /></p> <p>Note: You can use <a href=\"minValue\">minValue</a> and <a href=\"maxValue\">maxValue</a> to indicate ranges.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371786', 'educationalAlignment', 'educationalAlignment', 1, 'An alignment to an established educational framework.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371788', 'discountCode', 'discountCode', 1, 'Code used to redeem a discount.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371789', 'seatRow', 'seatRow', 1, 'The row location of the reserved seat (e.g., B).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371790', 'discusses', 'discusses', 1, 'Specifies the CreativeWork associated with the UserComment.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371791', 'expectedPrognosis', 'expectedPrognosis', 1, 'The likely outcome in either the short term or long term of the medical condition.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371792', 'departureTime', 'departureTime', 1, 'The expected departure time.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371793', 'proficiencyLevel', 'proficiencyLevel', 1, 'Proficiency needed for this content; expected values: \"Beginner\", \"Expert\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371794', 'eligibleRegion', 'eligibleRegion', 1, 'The ISO 3166-1 (ISO 3166-1 alpha-2) or ISO 3166-2 code, the place, or the GeoShape for the geo-political region(s) for which the offer or delivery charge specification is valid.       <br><br> See also <a href=\"/ineligibleRegion\">ineligibleRegion</a>.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371795', 'coach', 'coach', 1, 'A person that acts in a coaching role for a sports team.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371796', 'targetProduct', 'targetProduct', 1, 'Target Operating System / Product to which the code applies.  If applies to several versions, just the product name can be used.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371797', 'browserRequirements', 'browserRequirements', 1, 'Specifies browser requirements in human-readable text. For example,\"requires HTML5 support\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371798', 'proteinContent', 'proteinContent', 1, 'The number of grams of protein.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371799', 'incentives', 'incentives', 1, 'Description of bonus and commission compensation aspects of the job.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371800', 'resultReview', 'resultReview', 1, 'A sub property of result. The review that resulted in the performing of the action.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371801', 'geo', 'geo', 1, 'The geo coordinates of the place.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371802', 'typeOfGood', 'typeOfGood', 1, 'The product that this structured value is referring to.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371803', 'serviceOperator', 'serviceOperator', 1, 'The operating organization, if different from the provider.  This enables the representation of services that are provided by an organization, but operated by another organization like a subcontractor.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371804', 'dependencies', 'dependencies', 1, 'Prerequisites needed to fulfill steps in article.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371805', 'maxPrice', 'maxPrice', 1, 'The highest price if the price is a range.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371806', 'guidelineSubject', 'guidelineSubject', 1, 'The medical conditions, treatments, etc. that are the subject of the guideline.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371807', 'discountCurrency', 'discountCurrency', 1, 'The currency (in 3-letter ISO 4217 format) of the discount.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371808', 'instructor', 'instructor', 1, 'A person assigned to instruct or provide instructional assistance for the CourseInstance.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371809', 'softwareRequirements', 'softwareRequirements', 1, 'Component dependency requirements for application. This includes runtime environments and shared libraries that are not included in the application distribution package, but required to run the application (Examples: DirectX, Java or .NET runtime).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371810', 'email', '电子邮箱', 1, 'Email address.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371811', 'boardingGroup', 'boardingGroup', 1, 'The airline-specific indicator of boarding order / preference.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371812', 'events', 'events', 1, 'Upcoming or past events associated with this place or organization.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371813', 'gtin8', 'gtin8', 1, 'The <a href=\"http://ocp.gs1.org/sites/glossary/en-gb/Pages/GTIN-8.aspx\">GTIN-8</a> code of the product, or the product to which the offer refers. This code is also known as EAN/UCC-8 or 8-digit EAN. See <a href=\"http://www.gs1.org/barcodes/technical/idkeys/gtin\">GS1 GTIN Summary</a> for more details.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371814', 'vatID', 'vatID', 1, 'The Value-added Tax ID of the organization or person.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371815', 'recipeCategory', 'recipeCategory', 1, 'The category of the recipe—for example, appetizer, entree, etc.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371816', 'unitText', 'unitText', 1, 'A string or text indicating the unit of measurement. Useful if you cannot provide a standard unit code for <a href=\"unitCode\">unitCode</a>.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371817', 'maps', 'maps', 1, 'A URL to a map of the place.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371818', 'countryOfOrigin', 'countryOfOrigin', 1, 'The country of the principal offices of the production company or individual responsible for the movie or program.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371819', 'vin', 'vin', 1, 'The Vehicle Identification Number (VIN) is a unique serial number used by the automotive industry to identify individual motor vehicles.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371820', 'isConsumableFor', 'isConsumableFor', 1, 'A pointer to another product (or multiple products) for which this product is a consumable.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371821', 'branchCode', 'branchCode', 1, 'A short textual code (also called \"store code\") that uniquely identifies a place of business. The code is typically assigned by the parentOrganization and used in structured URLs. <br /><br /> For example, in the URL http://www.starbucks.co.uk/store-locator/etc/detail/3047 the code \"3047\" is a branchCode for a particular branch.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371822', 'agent', 'agent', 1, 'The direct performer or driver of the action (animate or inanimate). e.g. <em>John</em> wrote a book.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371823', 'video', 'video', 1, 'An embedded video object.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371824', 'language', 'language', 1, 'A sub property of instrument. The language used on this action.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371825', 'codeValue', 'codeValue', 1, 'The actual code.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371826', 'additionalName', 'additionalName', 1, 'An additional name for a Person, can be used for a middle name.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371827', 'targetPlatform', 'targetPlatform', 1, 'Type of app development: phone, Metro style, desktop, XBox, etc.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371828', 'numTracks', 'numTracks', 1, 'The number of tracks in this album or playlist.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371829', 'validUntil', 'validUntil', 1, 'The date when the item is no longer valid.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371830', 'itemShipped', 'itemShipped', 1, 'Item(s) being shipped.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371831', 'sourceOrganization', 'sourceOrganization', 1, 'The Organization on whose behalf the creator was working.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371832', 'dosageForm', 'dosageForm', 1, 'A dosage form in which this drug/supplement is available, e.g. \"tablet\", \"suspension\", \"injection\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371833', 'encodingType', 'encodingType', 1, 'The supported encoding type(s) for an EntryPoint request.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371834', 'numberOfAirbags', 'numberOfAirbags', 1, 'The number or type of airbags in the vehicle.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371835', 'availableService', 'availableService', 1, 'A medical service available from this provider.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371836', 'contentType', 'contentType', 1, 'The supported content type(s) for an EntryPoint response.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371837', 'about', 'about', 1, 'The subject matter of the content.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371838', 'orderedItem', 'orderedItem', 1, 'The item ordered.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371839', 'fileFormat', 'fileFormat', 1, 'Media type (aka MIME format, see <a href=\"http://www.iana.org/assignments/media-types/media-types.xhtml\">IANA site</a>) of the content e.g. application/zip of a SoftwareApplication binary. In cases where a CreativeWork has several media type representations, \"encoding\" can be used to indicate each MediaObject alongside particular fileFormat information.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371840', 'expectedArrivalUntil', 'expectedArrivalUntil', 1, 'The latest date the package may arrive.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371841', 'broadcastChannelId', 'broadcastChannelId', 1, 'The unique address by which the BroadcastService can be identified in a provider lineup. In US, this is typically a number.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371842', 'netWorth', 'netWorth', 1, 'The total financial value of the organization or person as calculated by subtracting assets from liabilities.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371843', 'accessCode', 'accessCode', 1, 'Password, PIN, or access code needed for delivery (e.g. from a locker).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371844', 'childMaxAge', 'childMaxAge', 1, 'Maximal age of the child.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371845', 'hasMap', 'hasMap', 1, 'A URL to a map of the place.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371846', 'datePosted', 'datePosted', 1, 'Publication date for the job posting.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371847', 'billingIncrement', 'billingIncrement', 1, 'This property specifies the minimal quantity and rounding increment that will be the basis for the billing. The unit of measurement is specified by the unitCode property.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371848', 'member', 'member', 1, 'A member of an Organization or a ProgramMembership. Organizations can be members of organizations; ProgramMembership is typically for individuals.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371849', 'sportsActivityLocation', 'sportsActivityLocation', 1, 'A sub property of location. The sports activity location where this action occurred.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371850', 'branch', 'branch', 1, 'The branches that delineate from the nerve bundle. Not to be confused with <a class=\"localLink\" href=\"/branchOf\">branchOf</a>.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371851', 'color', 'color', 1, 'The color of the product.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371852', 'experienceRequirements', 'experienceRequirements', 1, 'Description of skills and experience needed for the position.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371853', 'issuedThrough', 'issuedThrough', 1, 'The service through with the permit was granted.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371854', 'letterer', 'letterer', 1, 'The individual who adds lettering, including speech balloons and sound effects, to artwork.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371855', 'pathophysiology', 'pathophysiology', 1, 'Changes in the normal mechanical, physical, and biochemical functions that are associated with this activity or condition.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371856', 'bookingTime', 'bookingTime', 1, 'The date and time the reservation was booked.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371857', 'box', 'box', 1, 'A box is the area enclosed by the rectangle formed by two points. The first point is the lower corner, the second point is the upper corner. A box is expressed as two points separated by a space character.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371858', 'screenshot', 'screenshot', 1, 'A link to a screenshot image of the app.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371859', 'transcript', 'transcript', 1, 'If this MediaObject is an AudioObject or VideoObject, the transcript of that object.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371860', 'vehicleConfiguration', 'vehicleConfiguration', 1, 'A short text indicating the configuration of the vehicle, e.g. \"5dr hatchback ST 2.5 MT 225 hp\" or \"limited edition\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371861', 'connectedTo', 'connectedTo', 1, 'Other anatomical structures to which this structure is connected.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371862', 'version', 'version', 1, 'The version of the CreativeWork embodied by a specified resource.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371863', 'additionalType', 'additionalType', 1, 'An additional type for the item, typically used for adding more specific types from external vocabularies in microdata syntax. This is a relationship between something and a class that the thing is in. In RDFa syntax, it is better to use the native RDFa syntax - the \"typeof\" attribute - for multiple types. Schema.org tools may have only weaker understanding of extra types, in particular those defined externally.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371864', 'bookingAgent', 'bookingAgent', 1, 'bookingAgent is an out-dated term indicating a \"broker\" that serves as a booking agent.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371865', 'reservationFor', 'reservationFor', 1, 'The thing -- flight, event, restaurant,etc. being reserved.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371866', 'nerve', 'nerve', 1, 'The underlying innervation associated with the muscle.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371867', 'targetUrl', 'targetUrl', 1, 'The URL of a node in an established educational framework.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371868', 'warning', 'warning', 1, 'Any FDA or other warnings about the drug (text or URL).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371869', 'passengerPriorityStatus', 'passengerPriorityStatus', 1, 'The priority status assigned to a passenger for security or boarding (e.g. FastTrack or Priority).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371870', 'mentions', 'mentions', 1, 'Indicates that the CreativeWork contains a reference to, but is not necessarily about a concept.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371871', 'workTranslation', 'workTranslation', 1, 'A work that is a translation of the content of this work. e.g. 西遊記 has an English workTranslation “Journey to the West”,a German workTranslation “Monkeys Pilgerfahrt” and a Vietnamese  translation Tay du ky bình kh?o.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371872', 'suggestedMaxAge', 'suggestedMaxAge', 1, 'Maximal age recommended for viewing content.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371873', 'estimatesRiskOf', 'estimatesRiskOf', 1, 'The condition, complication, or symptom whose risk is being estimated.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371874', 'query', 'query', 1, 'A sub property of instrument. The query used on this action.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371875', 'actionApplication', 'actionApplication', 1, 'An application that can complete the request.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371876', 'supersededBy', 'supersededBy', 1, 'Relates a term (i.e. a property, class or enumeration) to one that supersedes it.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371877', 'colorist', 'colorist', 1, 'The individual who adds color to inked drawings.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371878', 'hasPOS', 'hasPOS', 1, 'Points-of-Sales operated by the organization or person.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371879', 'audio', 'audio', 1, 'An embedded audio object.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371880', 'dateIssued', 'dateIssued', 1, 'The date the ticket was issued.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371881', 'price', 'price', 1, 'The offer price of a product, or of a price component when attached to PriceSpecification and its subtypes. <br /> <br />       Usage guidelines: <br /> <ul> <li>Use the <a href=\"/priceCurrency\">priceCurrency</a> property (with <a href=\"http://en.wikipedia.org/wiki/ISO_4217#Active_codes\">ISO 4217 codes</a> e.g. \"USD\") instead of       including <a href=\"http://en.wikipedia.org/wiki/Dollar_sign#Currencies_that_use_the_dollar_or_peso_sign\">ambiguous symbols</a> such as \"$\" in the value. </li> <li>       Use \".\" (Unicode \"FULL STOP\" (U+002E)) rather than \",\" to indicate a decimal point. Avoid using these symbols as a readability separator. </li> <li>       Note that both <a href=\"http://www.w3.org/TR/xhtml-rdfa-primer/#using-the-content-attribute\">RDFa</a> and Microdata syntax allow the use of a \"content=\" attribute for publishing simple machine-readable values       alongside more human-friendly formatting. </li> <li>       Use values from 0123456789 (Unicode \"DIGIT ZERO\" (U+0030) to \"DIGIT NINE\" (U+0039)) rather than superficially similiar Unicode symbols. </li> </ul>');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371882', 'educationalFramework', 'educationalFramework', 1, 'The framework to which the resource being described is aligned.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371883', 'educationalRole', 'educationalRole', 1, 'An educationalRole of an EducationalAudience.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371884', 'acrissCode', 'acrissCode', 1, 'The ACRISS Car Classification Code is a code used by many car rental companies, for classifying vehicles. ACRISS stands for Association of Car Rental Industry Systems and Standards.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371885', 'dissolutionDate', 'dissolutionDate', 1, 'The date that this organization was dissolved.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371886', 'includedInDataCatalog', 'includedInDataCatalog', 1, 'A data catalog which contains this dataset.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371887', 'coverageEndTime', 'coverageEndTime', 1, 'The time when the live blog will stop covering the Event. Note that coverage may continue after the Event concludes.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371888', 'availableOnDevice', 'availableOnDevice', 1, 'Device required to run the application. Used in cases where a specific make/model is required to run the application.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371889', 'cookingMethod', 'cookingMethod', 1, 'The method of cooking, such as Frying, Steaming, ...');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371890', 'study', 'study', 1, 'A medical study or trial related to this entity.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371891', 'accessibilityFeature', 'accessibilityFeature', 1, 'Content features of the resource, such as accessible media, alternatives and supported enhancements for accessibility (<a href=\"http://www.w3.org/wiki/WebSchemas/Accessibility\">WebSchemas wiki lists possible values</a>).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371892', 'winner', 'winner', 1, 'A sub property of participant. The winner of the action.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371893', 'administrationRoute', 'administrationRoute', 1, 'A route by which this drug may be administered, e.g. \"oral\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371894', 'interactivityType', 'interactivityType', 1, 'The predominant mode of learning supported by the learning resource. Acceptable values are \"active\", \"expositive\", or \"mixed\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371895', 'commentCount', 'commentCount', 1, 'The number of comments this CreativeWork (e.g. Article, Question or Answer) has received. This is most applicable to works published in Web sites with commenting system; additional comments may exist elsewhere.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371896', 'installUrl', 'installUrl', 1, 'URL at which the app may be installed, if different from the URL of the item.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371897', 'familyName', 'familyName', 1, 'Family name. In the U.S., the last name of an Person. This can be used along with givenName instead of the name property.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371898', 'publishingPrinciples', 'publishingPrinciples', 1, 'Link to page describing the editorial principles of the organization primarily responsible for the creation of the CreativeWork.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371899', 'prepTime', 'prepTime', 1, 'The length of time it takes to prepare the recipe, in ISO 8601 duration format.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371900', 'exerciseType', 'exerciseType', 1, 'Type(s) of exercise or activity, such as strength training, flexibility training, aerobics, cardiac rehabilitation, etc.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371901', 'ratingValue', 'ratingValue', 1, 'The rating for the content.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371902', 'numberOfForwardGears', 'numberOfForwardGears', 1, 'The total number of forward gears available for the transmission system of the vehicle.<br /> Typical unit code(s): C62');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371903', 'isPartOf', 'isPartOf', 1, 'Indicates a CreativeWork that this CreativeWork is (in some sense) part of.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371904', 'inPlaylist', 'inPlaylist', 1, 'The playlist to which this recording belongs.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371905', 'availabilityEnds', 'availabilityEnds', 1, 'The end of the availability of the product or service included in the offer.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371907', 'dateSent', 'dateSent', 1, 'The date/time at which the message was sent.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371908', 'evidenceOrigin', 'evidenceOrigin', 1, 'Source of the data used to formulate the guidance, e.g. RCT, consensus opinion, etc.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371909', 'contentLocation', 'contentLocation', 1, 'The location depicted or described in the content. For example, the location in a photograph or painting.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371910', 'vehicleSeatingCapacity', 'vehicleSeatingCapacity', 1, 'The number of passengers that can be seated in the vehicle, both in terms of the physical space available, and in terms of limitations set by law.<br /> Typical unit code(s): C62 for persons.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371911', 'typicalAgeRange', 'typicalAgeRange', 1, 'The typical expected age range, e.g. \"7-9\", \"11-\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371912', 'numberOfItems', 'numberOfItems', 1, 'The number of items in an ItemList. Note that some descriptions might not fully describe all items in a list (e.g., multi-page pagination); in such cases, the numberOfItems would be for the entire list.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371913', 'author', 'author', 1, 'The author of this content. Please note that author is special in that HTML 5 provides a special mechanism for indicating authorship via the rel tag. That is equivalent to this and may be used interchangeably.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371914', 'supplyTo', 'supplyTo', 1, 'The area to which the artery supplies blood.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371915', 'studyLocation', 'studyLocation', 1, 'The location in which the study is taking/took place.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371916', 'insertion', 'insertion', 1, 'The place of attachment of a muscle, or what the muscle moves.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371917', 'foundingLocation', 'foundingLocation', 1, 'The place where the Organization was founded.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371918', 'numChildren', 'numChildren', 1, 'The number of children staying in the unit.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371919', 'activityFrequency', 'activityFrequency', 1, 'How often one should engage in the activity.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371920', 'priceValidUntil', 'priceValidUntil', 1, 'The date after which the price is no longer available.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371921', 'applicationCategory', 'applicationCategory', 1, 'Type of software application, e.g. \"Game, Multimedia\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371922', 'suggestedMinAge', 'suggestedMinAge', 1, 'Minimal age recommended for viewing content.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371923', 'signDetected', 'signDetected', 1, 'A sign detected by the test.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371924', 'primaryImageOfPage', 'primaryImageOfPage', 1, 'Indicates the main image on the page.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371925', 'workPresented', 'workPresented', 1, 'The movie presented during this event.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371926', 'preOp', 'preOp', 1, 'A description of the workup, testing, and other preparations required before implanting this device.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371928', 'differentialDiagnosis', 'differentialDiagnosis', 1, 'One of a set of differential diagnoses for the condition. Specifically, a closely-related or competing diagnosis typically considered later in the cognitive process whereby this medical condition is distinguished from others most likely responsible for a similar collection of signs and symptoms to reach the most parsimonious diagnosis or diagnoses in a patient.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371929', 'deliveryAddress', 'deliveryAddress', 1, 'Destination address.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371930', 'datasetTimeInterval', 'datasetTimeInterval', 1, 'The range of temporal applicability of a dataset, e.g. for a 2011 census dataset, the year 2011 (in ISO 8601 time interval format).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371931', 'isAccessoryOrSparePartFor', 'isAccessoryOrSparePartFor', 1, 'A pointer to another product (or multiple products) for which this product is an accessory or spare part.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371932', 'educationRequirements', 'educationRequirements', 1, 'Educational background needed for the position.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371933', 'landlord', 'landlord', 1, 'A sub property of participant. The owner of the real estate property.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371934', 'timeRequired', 'timeRequired', 1, 'Approximate or typical time it takes to work with or through this learning resource for the typical intended target audience, e.g. \"P30M\", \"P1H25M\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371935', 'includedRiskFactor', 'includedRiskFactor', 1, 'A modifiable or non-modifiable risk factor included in the calculation, e.g. age, coexisting condition.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371936', 'foundingDate', 'foundingDate', 1, 'The date that this organization was founded.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371937', 'trainName', 'trainName', 1, 'The name of the train (e.g. The Orient Express).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371938', 'diagram', 'diagram', 1, 'An image containing a diagram that illustrates the structure and/or its component substructures and/or connections with other structures.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371939', 'orderItemNumber', 'orderItemNumber', 1, 'The identifier of the order item.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371940', 'recipe', 'recipe', 1, 'A sub property of instrument. The recipe/instructions used to perform the action.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371941', 'distribution', 'distribution', 1, 'A downloadable form of this dataset, at a specific location, in a specific format.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371942', 'availableTest', 'availableTest', 1, 'A diagnostic test or procedure offered by this lab.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371943', 'trackingUrl', 'trackingUrl', 1, 'Tracking url for the parcel delivery.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371944', 'paymentDueDate', 'paymentDueDate', 1, 'The date that payment is due.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371945', 'relatedLink', 'relatedLink', 1, 'A link related to this web page, for example to other related web pages.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371946', 'replacee', 'replacee', 1, 'A sub property of object. The object that is being replaced.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371947', 'branchOf', 'branchOf', 1, 'The larger organization that this local business is a branch of, if any. Not to be confused with (anatomical)<a class=\"localLink\" href=\"/branch\">branch</a>.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371948', 'season', 'season', 1, 'A season in a media series.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371949', 'availableStrength', 'availableStrength', 1, 'An available dosage strength for the drug.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371950', 'gameItem', 'gameItem', 1, 'An item is an object within the game world that can be collected by a player or, occasionally, a non-player character.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371951', 'strengthValue', 'strengthValue', 1, 'The value of an active ingredient\"s strength, e.g. 325.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371952', 'publisher', 'publisher', 1, 'The publisher of the creative work.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371953', 'specialOpeningHoursSpecification', 'specialOpeningHoursSpecification', 1, 'The special opening hours of a certain place. <br /> Use this to explicitly override general opening hours brought in scope by <a href=\"/openingHoursSpecification\">openingHoursSpecification</a> or <a href=\"/openingHours\">openingHours</a>.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371954', 'hasDigitalDocumentPermission', 'hasDigitalDocumentPermission', 1, 'A permission related to the access to this document (e.g. permission to read or write an electronic document). For a public document, specify a grantee with an Audience with audienceType equal to \"public\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371955', 'productionDate', 'productionDate', 1, 'The date of production of the item, e.g. vehicle.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371956', 'providerMobility', 'providerMobility', 1, 'Indicates the mobility of a provided service (e.g. \"static\", \"dynamic\").');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371957', 'flightNumber', 'flightNumber', 1, 'The unique identifier for a flight including the airline IATA code. For example, if describing United flight 110, where the IATA code for United is \"UA\", the flightNumber is \"UA110\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371958', 'interactionType', 'interactionType', 1, 'The Action representing the type of interaction. For up votes, +1s, etc. use <a href=\"/LikeAction\";>LikeAction</a>. For down votes use <a href=\"/DislikeAction\">DislikeAction</a>. Otherwise, use the most specific Action.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371959', 'composer', 'composer', 1, 'The person or organization who wrote a composition, or who is the composer of a work performed at some event.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371960', 'validFor', 'validFor', 1, 'The time validity of the permit.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371961', 'releaseDate', 'releaseDate', 1, 'The release date of a product or product model. This can be used to distinguish the exact variant of a product.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371962', 'hasOfferCatalog', 'hasOfferCatalog', 1, 'Indicates an OfferCatalog listing for this Organization, Person, or Service.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371963', 'jobTitle', 'jobTitle', 1, 'The job title of the person (for example, Financial Manager).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371964', 'providesBroadcastService', 'providesBroadcastService', 1, 'The BroadcastService offered on this channel.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371965', 'sibling', 'sibling', 1, 'A sibling of the person.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371966', 'cause', 'cause', 1, 'Specifying a cause of something in general. e.g in medicine , one of the causative agent(s) that are most directly responsible for the pathophysiologic process that eventually results in the occurrence.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371967', 'originatesFrom', 'originatesFrom', 1, 'The vasculature the lymphatic structure originates, or afferents, from.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371968', 'founders', 'founders', 1, 'A person who founded this organization.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371969', 'defaultValue', 'defaultValue', 1, 'The default value of the input.  For properties that expect a literal, the default is a literal value, for properties that expect an object, it\"s an ID reference to one of the current values.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371970', 'repetitions', 'repetitions', 1, 'Number of times one should repeat the activity.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371971', 'additionalNumberOfGuests', 'additionalNumberOfGuests', 1, 'If responding yes, the number of guests who will attend in addition to the invitee.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371972', 'vendor', 'vendor', 1, 'vendor is an earlier term for \"seller\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371973', 'publication', 'publication', 1, 'A publication event associated with the item.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371974', 'nerveMotor', 'nerveMotor', 1, 'The neurological pathway extension that involves muscle control.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371975', 'material', 'material', 1, 'e.g. Oil, Watercolour, Acrylic, Linoprint, Marble, Cyanotype, Digital, Lithograph, DryPoint, Intaglio, Pastel, Woodcut, Pencil, Mixed Media, etc.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371976', 'seriousAdverseOutcome', 'seriousAdverseOutcome', 1, 'A possible serious complication and/or serious side effect of this therapy. Serious adverse outcomes include those that are life-threatening; result in death, disability, or permanent damage; require hospitalization or prolong existing hospitalization; cause congenital anomalies or birth defects; or jeopardize the patient and may require medical or surgical intervention to prevent one of the outcomes in this definition.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371977', 'biomechnicalClass', 'biomechnicalClass', 1, 'The biomechanical properties of the bone.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371978', 'totalPaymentDue', 'totalPaymentDue', 1, 'The total amount due.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371979', 'dataset', 'dataset', 1, 'A dataset contained in this catalog.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371980', 'timezone', 'timezone', 1, 'The timezone in <a href=\"http://en.wikipedia.org/wiki/ISO_8601\">ISO 8601 format</a> for which the service bases its broadcasts.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371981', 'dateRead', 'dateRead', 1, 'The date/time at which the message has been read by the recipient if a single recipient exists.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371982', 'benefitsSummaryUrl', 'benefitsSummaryUrl', 1, 'The URL that goes directly to the summary of benefits and coverage for the specific standard plan or plan variation.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371983', 'iswcCode', 'iswcCode', 1, 'The International Standard Musical Work Code for the composition.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371984', 'option', 'option', 1, 'A sub property of object. The options subject to this action.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371985', 'domainIncludes', 'domainIncludes', 1, 'Relates a property to a class that is (one of) the type(s) the property is expected to be used on.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371986', 'includesHealthPlanFormulary', 'includesHealthPlanFormulary', 1, 'Formularies covered by this plan.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371987', 'predecessorOf', 'predecessorOf', 1, 'A pointer from a previous, often discontinued variant of the product to its newer variant.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371988', 'breadcrumb', 'breadcrumb', 1, 'A set of links that can help a user understand and navigate a website hierarchy.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371989', 'workFeatured', 'workFeatured', 1, 'A work featured in some event, e.g. exhibited in an ExhibitionEvent.        Specific subproperties are available for workPerformed (e.g. a play), or a workPresented (a Movie at a ScreeningEvent).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371990', 'candidate', 'candidate', 1, 'A sub property of object. The candidate subject of this action.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371991', 'performerIn', 'performerIn', 1, 'Event that this person is a performer or participant in.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371992', 'yearlyRevenue', 'yearlyRevenue', 1, 'The size of the business in annual revenue.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371993', 'background', 'background', 1, 'Descriptive information establishing a historical perspective on the supplement. May include the rationale for the name, the population where the supplement first came to prominence, etc.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371994', 'multipleValues', 'multipleValues', 1, 'Whether multiple values are allowed for the property.  Default is false.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371995', 'result', 'result', 1, 'The result produced in the action. e.g. John wrote <em>a book</em>.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371996', 'amountOfThisGood', 'amountOfThisGood', 1, 'The quantity of the goods included in the offer.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371997', 'function', 'function', 1, 'Function of the anatomical structure.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371998', 'requiredMaxAge', 'requiredMaxAge', 1, 'Audiences defined by a person\"s maximum age.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734371999', 'processingTime', 'processingTime', 1, 'Estimated processing time for the service using this channel.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734372000', 'spatial', 'spatial', 1, 'The range of spatial applicability of a dataset, e.g. for a dataset of New York weather, the state of New York.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734372001', 'bodyType', 'bodyType', 1, 'Indicates the design and body style of the vehicle (e.g. station wagon, hatchback, etc.).');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734372002', 'normalRange', 'normalRange', 1, 'Range of acceptable values for a typical patient, when applicable.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734372003', 'codingSystem', 'codingSystem', 1, 'The coding system, e.g. \"ICD-10\".');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734372004', 'valuePattern', 'valuePattern', 1, 'Specifies a regular expression for testing literal values according to the HTML spec.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734372005', 'tissueSample', 'tissueSample', 1, 'The type of tissue sample required for the test.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734372006', 'includesObject', 'includesObject', 1, 'This links to a node or nodes indicating the exact quantity of the products included in the offer.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734372007', 'characterName', 'characterName', 1, 'The name of a character played in some acting or performing role, i.e. in a PerformanceRole.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734372008', 'annualPercentageRate', 'annualPercentageRate', 1, 'The annual rate that is charged for borrowing (or made by investing), expressed as a single percentage number that represents the actual yearly cost of funds over the term of a loan. This includes any fees or additional costs associated with the transaction.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734372009', 'endorsee', 'endorsee', 1, 'A sub property of participant. The person/organization being supported.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734372010', 'assembly', 'assembly', 1, 'Library file name e.g., mscorlib.dll, system.web.dll.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734372011', 'regionsAllowed', 'regionsAllowed', 1, 'The regions where the media is allowed. If not specified, then it\"s assumed to be allowed everywhere. Specify the countries in <a href=\"http://en.wikipedia.org/wiki/ISO_3166\">ISO 3166 format</a>.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734372012', 'coverageStartTime', 'coverageStartTime', 1, 'The time when the live blog will begin covering the Event. Note that coverage may begin before the Event\"s start time. The LiveBlogPosting may also be created before coverage begins.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734372013', 'attendees', 'attendees', 1, 'A person attending the event.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734372014', 'usedToDiagnose', 'usedToDiagnose', 1, 'A condition the test is used to diagnose.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734372015', 'permitAudience', 'permitAudience', 1, 'The target audience for this permit.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734372016', 'object', 'object', 1, 'The object upon the action is carried out, whose state is kept intact or changed. Also known as the semantic roles patient, affected or undergoer (which change their state) or theme (which doesn\"t). e.g. John read <em>a book</em>.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734372017', 'rangeIncludes', 'rangeIncludes', 1, 'Relates a property to a class that constitutes (one of) the expected type(s) for values of the property.');
INSERT INTO `tag_data_type_element` VALUES ('ID1607072311435458734372018', 'subtype', 'subtype', 1, 'A more specific type of the condition, where applicable, for example \"Type 1 Diabetes\", \"Type 2 Diabetes\", or \"Gestational Diabetes\" for Diabetes.');
INSERT INTO `tag_data_type_element` VALUES ('ID1709251448406654892411984', 'USR_NO', '测试内部客户号', 1, '测试内部客户号');
INSERT INTO `tag_data_type_element` VALUES ('ID1709251449290719438182141', 'USR_CITY_NM', '测试用户城市', 1, '测试用户城市');
INSERT INTO `tag_data_type_element` VALUES ('ID1709251449490325484855804', 'MBL_NO', '测试用户手机号', 1, '测试用户手机');
INSERT INTO `tag_data_type_element` VALUES ('ID1709251450199129629699036', 'REAL_NM_FLG', '测试用户实名认证标志', 1, '测试用户实名认证标志');
INSERT INTO `tag_data_type_element` VALUES ('ID1709251450362202983470802', 'CRED_LVL', '测试用户信用级别', 1, '测试用户信用级别');
INSERT INTO `tag_data_type_element` VALUES ('ID1709251451063005579838506', 'CUS_NM', '测试用户姓名', 1, '测试用户姓名');
INSERT INTO `tag_data_type_element` VALUES ('ID1709251452071034415624840', 'FUND_CORP_ID', '测试基金公司编号', 1, '测试基金公司编号');
INSERT INTO `tag_data_type_element` VALUES ('ID1709251452390655948308095', 'CUR_AMT', '测试客户总金额', 1, '测试客户总金额');
INSERT INTO `tag_data_type_element` VALUES ('ID1709251453076624266428834', 'CUR_EARN_AMT', '测试用户总收益', 1, '测试用户总收益');
INSERT INTO `tag_data_type_element` VALUES ('ID1709251510552855215377793', 'GY_FUND_INFO', '测试增值用户信息', 1, '测试增值用户信息');
INSERT INTO `tag_data_type_element` VALUES ('ID1907261453068498713591070', 'USR_MIN_DT', '测试用户最早参与时间', 1, '测试风控最早记录时间');
INSERT INTO `tag_data_type_element` VALUES ('ID1907261453563251602163676', 'USR_COUNT', '测试用户风控调用次数', 1, '测试用户风控调用次数');
INSERT INTO `tag_data_type_element` VALUES ('ID2112121732378642692198743', 'DS_USER_ID', '电商用户ID', 1, '电商用户ID');
INSERT INTO `tag_data_type_element` VALUES ('ID2112121732530075602233120', 'DS_USER_NAME', '电商用户姓名', 1, '电商用户姓名');
INSERT INTO `tag_data_type_element` VALUES ('ID2112121733161570756481905', 'DS_USER_PHONE', '电商用户手机号', 1, '电商用户手机号');
INSERT INTO `tag_data_type_element` VALUES ('ID2112121733327419855756435', 'DS_USER_GENDER', '电商用户性别', 1, '电商用户性别');
INSERT INTO `tag_data_type_element` VALUES ('ID2112121733488904724944343', 'DS_USER_REGTIME', '电商用户注册时间', 1, '电商用户注册时间');
INSERT INTO `tag_data_type_element` VALUES ('ID2112121734259344152304534', 'DS_USER_AVAILABLE', '电商用户余额', 1, '电商用户余额');
INSERT INTO `tag_data_type_element` VALUES ('ID2112121734543054899171157', 'DS_USER_IDENTIFICATION', '电商用户身份证', 1, '电商用户身份证');
INSERT INTO `tag_data_type_element` VALUES ('ID2112121735156905257572763', 'DS_USER_HOMEADDR', '电商用户家庭住址', 1, '电商用户家庭住址');
INSERT INTO `tag_data_type_element` VALUES ('ID2112121735347841068626759', 'DS_USER_AGE', '电商用户年龄', 1, '电商用户年龄');
INSERT INTO `tag_data_type_element` VALUES ('ID2112121736030557658540776', 'DS_USER_ORDER_COUNT', '电商用户交易次数', 1, '电商用户交易次数');
INSERT INTO `tag_data_type_element` VALUES ('ID2112121736296859374049689', 'DS_USER_ORDER_AMOUNT', '电商用户交易金额', 1, '电商用户交易金额');

-- ----------------------------
-- Table structure for tag_dictionary
-- ----------------------------
DROP TABLE IF EXISTS `tag_dictionary`;
CREATE TABLE `tag_dictionary`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '主键ID',
  `orders` int(0) NULL DEFAULT NULL COMMENT '内部排序号',
  `type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典类型',
  `itemName` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典项名称',
  `itemValue` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典项值',
  `memo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '标签字典表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tag_dictionary
-- ----------------------------
INSERT INTO `tag_dictionary` VALUES ('ID1606051001441119347934898', 1, 'gender', '男', '1', '');
INSERT INTO `tag_dictionary` VALUES ('ID1606051002003535606362429', 2, 'gender', '女', '2', '');
INSERT INTO `tag_dictionary` VALUES ('ID1606051002109268657059232', 3, 'gender', '未知', '3', '');
INSERT INTO `tag_dictionary` VALUES ('ID1606051032474217689495477', 1, 'identificationType', '身份证', '1', '');
INSERT INTO `tag_dictionary` VALUES ('ID1606051033074947261749449', 2, 'identificationType', '军官证', '2', '');
INSERT INTO `tag_dictionary` VALUES ('ID1606051033196755928627605', 3, 'identificationType', '护照', '3', '');
INSERT INTO `tag_dictionary` VALUES ('ID1606051033280702232403130', 4, 'identificationType', '户口本', '4', '');
INSERT INTO `tag_dictionary` VALUES ('ID1606051114125121855902649', 1, 'contactType', '手机', '1', '');
INSERT INTO `tag_dictionary` VALUES ('ID1606051114207861446238282', 2, 'contactType', 'QQ号', '2', '');
INSERT INTO `tag_dictionary` VALUES ('ID1606051114543232474326624', 3, 'contactType', '淘宝账号', '3', '');
INSERT INTO `tag_dictionary` VALUES ('ID1606051115074592234947178', 4, 'contactType', '微信号', '4', '');
INSERT INTO `tag_dictionary` VALUES ('ID1606051115216945705301293', 5, 'contactType', '邮箱', '5', '');
INSERT INTO `tag_dictionary` VALUES ('ID1606051115353690800183456', 6, 'contactType', '固定电话', '6', '');
INSERT INTO `tag_dictionary` VALUES ('ID1606051121239971464472602', 1, 'addressType', '户籍地址', '1', '');
INSERT INTO `tag_dictionary` VALUES ('ID1606051121369123090807386', 2, 'addressType', '现居住地址', '2', '');
INSERT INTO `tag_dictionary` VALUES ('ID1606051121461398327148633', 3, 'addressType', '单位地址', '3', '');
INSERT INTO `tag_dictionary` VALUES ('ID1606051121573686564207721', 4, 'addressType', '家庭地址', '4', '');
INSERT INTO `tag_dictionary` VALUES ('ID1606181617383755120023397', 1, 'degree', '学士', '1', '');
INSERT INTO `tag_dictionary` VALUES ('ID1606181618004716766501385', 2, 'degree', '硕士', '2', '');
INSERT INTO `tag_dictionary` VALUES ('ID1606181618213319187285088', 3, 'degree', '博士', '3', '');
INSERT INTO `tag_dictionary` VALUES ('ID1606181619231316032834478', 1, 'educated', '小学学历', '1', '学历');
INSERT INTO `tag_dictionary` VALUES ('ID1606181620080855810535875', 2, 'educated', '初中学历', '2', '');
INSERT INTO `tag_dictionary` VALUES ('ID1606181620372589462590718', 3, 'educated', '高中学历', '3', '学历');
INSERT INTO `tag_dictionary` VALUES ('ID1606181621136659190245425', 4, 'educated', '中专学历', '4', '');
INSERT INTO `tag_dictionary` VALUES ('ID1606181621322678019520698', 5, 'educated', '大专学历', '5', '');
INSERT INTO `tag_dictionary` VALUES ('ID1606181621510969946075259', 6, 'educated', '本科学历', '6', '');
INSERT INTO `tag_dictionary` VALUES ('ID1606181622068780612877671', 7, 'educated', '研究生学历', '7', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153153', 1, 'nationality', '中国', 'CHN', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153154', 1, 'familyRelationsCode', '父亲', '121', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153155', 2, 'familyRelationsCode', '母亲', '122', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153156', 3, 'familyRelationsCode', '养父', '123', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153157', 4, 'familyRelationsCode', '养母', '124', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153158', 5, 'familyRelationsCode', '儿子', '131', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153159', 6, 'familyRelationsCode', '女儿', '132', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153160', 7, 'familyRelationsCode', '养子', '133', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153161', 8, 'familyRelationsCode', '养女', '134', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153162', 9, 'familyRelationsCode', '其他直系成员', '1X0', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153163', 10, 'familyRelationsCode', '祖父', '211', '爷爷');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153164', 11, 'familyRelationsCode', '祖母', '212', '奶奶');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153165', 12, 'familyRelationsCode', '外祖父', '213', '外公');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153166', 13, 'familyRelationsCode', '外祖母', '214', '外婆');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153167', 14, 'familyRelationsCode', '伯父', '221', '伯伯');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153168', 15, 'familyRelationsCode', '叔父', '222', '叔叔');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153169', 16, 'familyRelationsCode', '姑妈', '223', '姑姑');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153170', 17, 'familyRelationsCode', '舅父', '224', '舅舅');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153171', 18, 'familyRelationsCode', '姨妈', '225', '阿姨、姨母');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153172', 19, 'familyRelationsCode', '兄弟', '231', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153173', 20, 'familyRelationsCode', '兄妹', '232', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153174', 21, 'familyRelationsCode', '姐妹', '233', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153175', 22, 'familyRelationsCode', '姐弟', '234', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153176', 23, 'familyRelationsCode', '堂兄弟', '235', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153177', 24, 'familyRelationsCode', '堂兄妹', '236', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153178', 25, 'familyRelationsCode', '堂姐妹', '237', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153179', 26, 'familyRelationsCode', '堂姐弟', '238', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153180', 27, 'familyRelationsCode', '表兄弟', '239', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153181', 28, 'familyRelationsCode', '表兄妹', '23A', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153182', 29, 'familyRelationsCode', '表姐妹', '23B', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153183', 30, 'familyRelationsCode', '表姐弟', '23C', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153184', 31, 'familyRelationsCode', '侄子', '241', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153185', 32, 'familyRelationsCode', '侄女', '242', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153186', 33, 'familyRelationsCode', '外甥', '243', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153187', 34, 'familyRelationsCode', '外甥女', '244', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153188', 35, 'familyRelationsCode', '孙子', '251', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153189', 36, 'familyRelationsCode', '孙女', '252', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153190', 37, 'familyRelationsCode', '外孙', '253', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153191', 38, 'familyRelationsCode', '外孙女', '254', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153192', 39, 'familyRelationsCode', '其他血亲关系', '2X0', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153193', 40, 'familyRelationsCode', '公公', '311', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153194', 41, 'familyRelationsCode', '婆婆', '312', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153195', 42, 'familyRelationsCode', '岳父', '313', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153196', 43, 'familyRelationsCode', '岳母', '314', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153197', 44, 'familyRelationsCode', '伯母', '315', '婶婶');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153198', 45, 'familyRelationsCode', '叔母', '316', '婶婶');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153199', 46, 'familyRelationsCode', '姑父', '317', '姑爷、姑丈');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153200', 47, 'familyRelationsCode', '舅母', '318', '舅妈');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153201', 48, 'familyRelationsCode', '姨父', '319', '姨丈');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153202', 49, 'familyRelationsCode', '嫂子', '321', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153203', 50, 'familyRelationsCode', '弟妹', '322', '弟媳妇');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153204', 51, 'familyRelationsCode', '姐夫', '323', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153205', 52, 'familyRelationsCode', '妹夫', '324', '妹婿、妹丈');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153206', 53, 'familyRelationsCode', '大伯哥', '325', '伯');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153207', 54, 'familyRelationsCode', '小叔子', '326', '叔');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153208', 55, 'familyRelationsCode', '大姑姐', '327', '姑');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153209', 56, 'familyRelationsCode', '小姑子', '328', '姑');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153210', 57, 'familyRelationsCode', '内兄', '329', '舅子');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153211', 58, 'familyRelationsCode', '内弟', '32A', '舅子');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153212', 59, 'familyRelationsCode', '姨子', '32B', '姨姐、姨妹');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153213', 60, 'familyRelationsCode', '妯娌', '32C', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153214', 61, 'familyRelationsCode', '连襟', '32D', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153215', 62, 'familyRelationsCode', '儿媳', '331', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153216', 63, 'familyRelationsCode', '女婿', '332', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153217', 64, 'familyRelationsCode', '养子配偶', '333', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153218', 65, 'familyRelationsCode', '养女配偶', '334', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153219', 66, 'familyRelationsCode', '其他姻亲关系', '3X0', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153220', 1, 'nation', '未登记或拒绝登记', '00', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153221', 2, 'nation', '汉族', '01', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153222', 3, 'nation', '蒙古族', '02', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153223', 4, 'nation', '回族', '03', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153224', 5, 'nation', '维吾尔族', '04', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153225', 6, 'nation', '藏族', '05', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153226', 7, 'nation', '苗族', '06', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153227', 8, 'nation', '彝族', '07', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153228', 9, 'nation', '壮族', '08', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153229', 10, 'nation', '布依族', '09', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153230', 11, 'nation', '朝鲜族', '10', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153231', 12, 'nation', '满族', '11', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153232', 13, 'nation', '侗族', '12', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153233', 14, 'nation', '瑶族', '13', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153234', 15, 'nation', '白族', '14', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153235', 16, 'nation', '土家族', '15', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153236', 17, 'nation', '哈尼族', '16', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153237', 18, 'nation', '哈萨克族', '17', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153238', 19, 'nation', '傣族', '18', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153239', 20, 'nation', '黎族', '19', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153240', 21, 'nation', '僳僳族', '20', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153241', 22, 'nation', '佤族', '21', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153242', 23, 'nation', '畲族', '22', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153243', 24, 'nation', '高山族', '23', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153244', 25, 'nation', '拉祜族', '24', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153245', 26, 'nation', '水族', '25', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153246', 27, 'nation', '东乡族', '26', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153247', 28, 'nation', '纳西族', '27', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153248', 29, 'nation', '景颇族', '28', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153249', 30, 'nation', '柯尔克孜族', '29', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153250', 31, 'nation', '土族', '30', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153251', 32, 'nation', '达斡尔族', '31', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153252', 33, 'nation', '仫佬族', '32', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153253', 34, 'nation', '羌族', '33', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153254', 35, 'nation', '布朗族', '34', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153255', 36, 'nation', '撒拉族', '35', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153256', 37, 'nation', '毛难族', '36', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153257', 38, 'nation', '仡佬族', '37', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153258', 39, 'nation', '锡伯族', '38', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153259', 40, 'nation', '阿昌族', '39', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153260', 41, 'nation', '普米族', '40', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153261', 42, 'nation', '塔吉克斯坦族', '41', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153262', 43, 'nation', '怒族', '42', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153263', 44, 'nation', '乌孜别克族', '43', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153264', 45, 'nation', '俄罗斯族', '44', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153265', 46, 'nation', '鄂温克族', '45', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153266', 47, 'nation', '崩龙族', '46', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153267', 48, 'nation', '保安族', '47', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153268', 49, 'nation', '裕固族', '48', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153269', 50, 'nation', '京族', '49', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153270', 51, 'nation', '塔塔尔族', '50', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153271', 52, 'nation', '独龙族', '51', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153272', 53, 'nation', '鄂伦春族', '52', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153273', 54, 'nation', '赫哲族', '53', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153274', 55, 'nation', '门巴族', '54', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153275', 56, 'nation', '珞巴族', '55', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153276', 57, 'nation', '基诺族', '56', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153277', 58, 'nation', '其他', '97', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153278', 59, 'nation', '外国血统', '98', '');
INSERT INTO `tag_dictionary` VALUES ('ID1607292150136869133153279', 67, 'familyRelationsCode', '配偶', '111', '');

-- ----------------------------
-- Table structure for tag_edge
-- ----------------------------
DROP TABLE IF EXISTS `tag_edge`;
CREATE TABLE `tag_edge`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '主键ID',
  `vertexAid` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '边的一个端点，如果是父子关系的边，A节点必须存放父节点',
  `vertexBid` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '边的另一个端点，如果是父子关系的边，B节点必须存放子节点',
  `type` int(0) NULL DEFAULT NULL COMMENT '边的类型，具体见字典表type=edgeType',
  `enable` int(0) NULL DEFAULT NULL COMMENT '是否可用0不可用，1可用',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK2DAF76243B4A5B1`(`vertexBid`) USING BTREE,
  INDEX `FK2DAF76243B4A1F0`(`vertexAid`) USING BTREE,
  INDEX `FK2DAF76227C28ED8`(`vertexBid`) USING BTREE,
  INDEX `FK2DAF76227C28B17`(`vertexAid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '标签网边实体类' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tag_edge
-- ----------------------------
INSERT INTO `tag_edge` VALUES ('ID1605102338215757370457412', 'ID1605101010105573103233721', 'ID1605102338215573103233721', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1605102347233768553020188', 'ID1605102338215573103233721', 'ID1605102347233570954042998', 1, 0);
INSERT INTO `tag_edge` VALUES ('ID1605112149304957504328135', 'ID1605102347233570954042998', 'ID1605112149304713474981318', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1605112149469437507595686', 'ID1605112149304713474981318', 'ID1605112149469391460442423', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1605112155529391879977688', 'ID1605112149469391460442423', 'ID1605112155529356196082057', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1605112156081520888338673', 'ID1605112155529356196082057', 'ID1605112156081493531215968', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1605112156176586773003606', 'ID1605112155529356196082057', 'ID1605112156176553763829761', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1605112156256946887033102', 'ID1605112155529356196082057', 'ID1605112156256903578342499', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1605112156449927139535193', 'ID1605112149304713474981318', 'ID1605112156449897817884870', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1605112156576316791848210', 'ID1605112156449897817884870', 'ID1605112156576288057095066', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1605112157074138804430384', 'ID1605112156576288057095066', 'ID1605112157074104244348488', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1605112157211075244138692', 'ID1605112156576288057095066', 'ID1605112157211041143011219', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1605112157311242361297967', 'ID1605112156576288057095066', 'ID1605112157311219628980894', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1605112157379233941359669', 'ID1605112156576288057095066', 'ID1605112157379201084891216', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1605112157442758301335138', 'ID1605112156576288057095066', 'ID1605112157442711231210978', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1605132227586132352458201', 'ID1605112149469391460442423', 'ID1605112156449897817884870', 2, 1);
INSERT INTO `tag_edge` VALUES ('ID1605182221390674499334087', 'ID1605112156449897817884870', 'ID1605182221390647463985640', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1605182222052968000910030', 'ID1605182221390647463985640', 'ID1605182222052934222658292', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1605182222151315196250707', 'ID1605182221390647463985640', 'ID1605182222151279444635185', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1605182222291734058313819', 'ID1605182221390647463985640', 'ID1605182222291694853029693', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1605182222345546050586940', 'ID1605182221390647463985640', 'ID1605182222345501500666968', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1605182222431501368270408', 'ID1605182221390647463985640', 'ID1605182222431479930087581', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1606292025100045643371906', 'ID1605101010105573103233721', 'ID1606292025100048084376983', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1606211558488958666008116', 'ID1605182221390647463985640', 'ID1606211558488953137075241', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1606211559035362204373248', 'ID1605182221390647463985640', 'ID1606211559035364494296291', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1606292026067232491090699', 'ID1606292025100048084376983', 'ID1606292026067235160461345', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1606292027129439358084193', 'ID1606292026067235160461345', 'ID1606292027129435684737845', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1606292027248819107084562', 'ID1606292027129435684737845', 'ID1606292027248816018389755', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1606292027457569335762842', 'ID1606292027248816018389755', 'ID1606292027457567743382237', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1606292028511163846977287', 'ID1606292027457567743382237', 'ID1606292028511161553616458', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1606292029338041442814132', 'ID1606292028511161553616458', 'ID1606292029338045132967557', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1606292030402278806782741', 'ID1606292029338045132967557', 'ID1606292030402273340795706', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1606292031005089602487916', 'ID1606292029338045132967557', 'ID1606292031005089929578564', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1606292031267432791469374', 'ID1606292029338045132967557', 'ID1606292031267433511138590', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607022350459646896334630', 'ID1607022348359150620930294', 'ID1607022350459646371773577', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607022345319311162741454', 'ID1607021821046560798520881', 'ID1607022345319311635755462', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607022351356199699889810', 'ID1607022350459646371773577', 'ID1607022351356191399020871', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607022348359158120643534', 'ID1607022311477084868358487', 'ID1607022348359150620930294', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607022357084906148869872', 'ID1607022351356191399020871', 'ID1607022357084903158140601', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607022357246469225915025', 'ID1607022351356191399020871', 'ID1607022357246463131183724', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607022310379269248006222', 'ID1605101010105573103233721', 'ID1607022310378791499376740', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607022311096298584706460', 'ID1607022310378791499376740', 'ID1607022311096296748440015', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607022311477086036395845', 'ID1607022311096296748440015', 'ID1607022311477084868358487', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607022314499972347684204', 'ID1607022311477084868358487', 'ID1607022314499978105431672', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607022315034669085574499', 'ID1607022314499978105431672', 'ID1607022315034660802831880', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607022323199302400425270', 'ID1607022315034660802831880', 'ID1607022323199302695830498', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607022324390104698818535', 'ID1607022323199302695830498', 'ID1607022324390102519371840', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607022325349499613516519', 'ID1607022323199302695830498', 'ID1607022325349496982992837', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607022327396889721658780', 'ID1607022323199302695830498', 'ID1607022327396888149994324', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607022327534234308783297', 'ID1607022323199302695830498', 'ID1607022327534236003742865', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607022328393151267203457', 'ID1607022323199302695830498', 'ID1607022328393157566780893', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607022339211272225991379', 'ID1607022314499978105431672', 'ID1607022339211272906980812', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607022340481594729854380', 'ID1607022339211272906980812', 'ID1607022340481596375626301', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607022341223946652802910', 'ID1607022340481596375626301', 'ID1607022341223943901825616', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607022341563476551595692', 'ID1607022340481596375626301', 'ID1607022341563475444476144', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607022342204736921351719', 'ID1607022340481596375626301', 'ID1607022342204730003037244', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607022342346607163939200', 'ID1607022340481596375626301', 'ID1607022342346605187627141', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607022357386047640851664', 'ID1607022351356191399020871', 'ID1607022357386044449843956', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607022357505730239943788', 'ID1607022351356191399020871', 'ID1607022357505737623795527', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607261549294165628267903', 'ID1605101010105573103233721', 'ID1607261549293530460986478', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607261607585657726991739', 'ID1607261549293530460986478', 'ID1607261607585652365156285', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607261608168154337111801', 'ID1607261607585652365156285', 'ID1607261608168157805966798', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607261608278627114704977', 'ID1607261608168157805966798', 'ID1607261608278623569209301', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607261608456754986567294', 'ID1607261608278623569209301', 'ID1607261608456756817125295', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607261609513807517057599', 'ID1607261608456756817125295', 'ID1607261609513800185132623', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607261610085991415138940', 'ID1607261609513800185132623', 'ID1607261610085993617513440', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607261610199744169407244', 'ID1607261609513800185132623', 'ID1607261610199741188761457', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607261610526789071282609', 'ID1607261608456756817125295', 'ID1607261610526781189818248', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607261611197418563800606', 'ID1607261610526781189818248', 'ID1607261611197413587510510', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1607261611320396430594122', 'ID1607261610526781189818248', 'ID1607261611320235435553113', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1605101010105757370457411', 'ID1701091920348588509079931', 'ID1605101010105573103233721', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1701091920348588509079931', '-1', 'ID1701091920348588509079931', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1702201846245840527414111', '-1', 'ID1702201846245848118673524', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1702201846418667406798184', 'ID1702201846245848118673524', 'ID1702201846418507420178674', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1702201846499919724072055', 'ID1702201846245848118673524', 'ID1702201846499918586993018', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1702201846570541121932835', 'ID1702201846245848118673524', 'ID1702201846570546627964020', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1702201847016799750386915', 'ID1702201846245848118673524', 'ID1702201847016799779333095', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1702201847074769826615087', 'ID1702201846245848118673524', 'ID1702201847074766361403410', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1702201847305232164821656', '-1', 'ID1702201847305233990034613', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1702201847426325805069652', 'ID1702201847305233990034613', 'ID1702201847426323006419363', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1702201848146485651901375', 'ID1702201846418507420178674', 'ID1702201848146486010402173', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1702201848187739508199845', 'ID1702201846418507420178674', 'ID1702201848187737885470397', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1702201848266333571368416', 'ID1702201846418507420178674', 'ID1702201848266331374872152', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1702201848385083138541272', 'ID1702201846418507420178674', 'ID1702201848385080338572492', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1702201848526335365005400', 'ID1702201846418507420178674', 'ID1702201848526335257083477', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1709191426203907754122328', 'ID1605112149304713474981318', 'ID1709191426203837233253002', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1709191426433013395731754', 'ID1709191426203837233253002', 'ID1709191426432943372946123', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1709191427177224009169407', 'ID1709191426432943372946123', 'ID1709191427177175290099728', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1709191427403332086222645', 'ID1709191426432943372946123', 'ID1709191427403312920302333', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1709271111001537840247301', 'ID1605101010105573103233721', 'ID1709271111001421239487528', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1709271111360817732651648', 'ID1709271111001421239487528', 'ID1709271111360750906219126', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1709271112006394204866815', 'ID1709271111360750906219126', 'ID1709271112006337765404995', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1709271112141207168992356', 'ID1709271111360750906219126', 'ID1709271112141160992287570', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1709271112333899456111191', 'ID1709271112141160992287570', 'ID1709271112333830713071988', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1709271112494762175948383', 'ID1709271112006337765404995', 'ID1709271112494741673409910', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1709271113079301563728193', 'ID1709271112333830713071988', 'ID1709271113079289872458322', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1709271113269381121356088', 'ID1709271112333830713071988', 'ID1709271113269365521638516', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1709271113359253984512360', 'ID1709271112333830713071988', 'ID1709271113359236382545765', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1709271113525031140711574', 'ID1709271112494741673409910', 'ID1709271113525006817769914', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1709271114035773849437982', 'ID1709271112494741673409910', 'ID1709271114035727258357737', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1709271114148272216150240', 'ID1709271112494741673409910', 'ID1709271114148258531014852', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1907291648226708299387404', 'ID1709271111001421239487528', 'ID1907291648226672647269717', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1907291648465124428294681', 'ID1907291648226672647269717', 'ID1907291648465089378590095', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1907291649275546216744885', 'ID1907291648465089378590095', 'ID1907291649275525161434603', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1907291649443900731217003', 'ID1907291649275525161434603', 'ID1907291649443871300469248', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1907291650029278177699407', 'ID1907291649275525161434603', 'ID1907291650029252966740120', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1907291650137892677278680', 'ID1907291649275525161434603', 'ID1907291650137875330139651', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1907291652054656095416239', 'ID1907291648226672647269717', 'ID1907291652054636645893406', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1907291652217890854244335', 'ID1907291652054636645893406', 'ID1907291652217870869935226', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1907291652522004233712172', 'ID1907291652217870869935226', 'ID1907291652521985730580916', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID1907291653050400630124049', 'ID1907291652217870869935226', 'ID1907291653050379677686450', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID2112121740227213605700367', 'ID1702201847305233990034613', 'ID2112121740227163623876719', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID2112121741335012995842691', 'ID2112121740227163623876719', 'ID2112121741334999421067048', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID2112121741439344311138337', 'ID2112121740227163623876719', 'ID2112121741439314706837778', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID2112121741511896057752268', 'ID2112121740227163623876719', 'ID2112121741511869130405962', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID2112121742009861972665075', 'ID2112121740227163623876719', 'ID2112121742009835774385873', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID2112121742463595294109406', 'ID2112121741334999421067048', 'ID2112121742463565519209604', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID2112121744344970823374076', 'ID2112121742463565519209604', 'ID2112121744344949468976184', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID2112121744490980683942276', 'ID2112121744344949468976184', 'ID2112121744490946929352851', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID2112121745025346612243762', 'ID2112121744344949468976184', 'ID2112121745025312780345238', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID2112121745146452685868844', 'ID2112121744344949468976184', 'ID2112121745146431263811403', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID2112121746012016064036465', 'ID2112121744344949468976184', 'ID2112121746011984254982254', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID2112121746288610862303634', 'ID2112121742463565519209604', 'ID2112121746288599756274827', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID2112121746415857242922167', 'ID2112121746288599756274827', 'ID2112121746415844908154282', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID2112121746519719841312641', 'ID2112121746288599756274827', 'ID2112121746519680221724459', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID2112121747017682172287065', 'ID2112121746288599756274827', 'ID2112121747017651309979022', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID2112121748128878153767426', 'ID2112121741439314706837778', 'ID2112121748128848908510578', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID2112121748374299956188794', 'ID2112121748128848908510578', 'ID2112121748374277515077746', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID2112121748474187750899809', 'ID2112121748128848908510578', 'ID2112121748474159258934750', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID2112121748592266175905057', 'ID2112121748128848908510578', 'ID2112121748592239061339722', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID2112121749152297015833634', 'ID2112121741439314706837778', 'ID2112121749152271279586959', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID2112121749418709699936769', 'ID2112121749152271279586959', 'ID2112121749418670971228229', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID2112121750155929030938985', 'ID2112121749152271279586959', 'ID2112121750155892582765745', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID2112121750300667487283837', 'ID2112121749152271279586959', 'ID2112121750300637717316769', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID2112121750550297387016970', 'ID2112121741511869130405962', 'ID2112121750550271163670941', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID2112121751239369489959866', 'ID2112121750550271163670941', 'ID2112121751239337514913136', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID2112121751436072522125205', 'ID2112121751239337514913136', 'ID2112121751436041982197289', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID2112121751550026962734944', 'ID2112121751239337514913136', 'ID2112121751549992797742167', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID2112121752082687796127043', 'ID2112121751239337514913136', 'ID2112121752082662556876967', 1, 1);
INSERT INTO `tag_edge` VALUES ('ID2112121752176390936385407', 'ID2112121751239337514913136', 'ID2112121752176360644865377', 1, 1);

-- ----------------------------
-- Table structure for tag_ext_type
-- ----------------------------
DROP TABLE IF EXISTS `tag_ext_type`;
CREATE TABLE `tag_ext_type`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '主键ID',
  `industryType` int(0) NOT NULL COMMENT '行业类型（见字典表type=industryType）',
  `parentTypeId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父数据类型',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据类型编码',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类名称',
  `treeCode` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '树结构编码',
  `type` int(0) NULL DEFAULT NULL COMMENT '类类型，具体参见字典表type=dataType',
  `isFirstShow` int(0) NULL DEFAULT NULL COMMENT '是否首先显示：0是，1不是',
  `memo` varchar(3000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '行业扩展模型数据类型' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tag_ext_type
-- ----------------------------
INSERT INTO `tag_ext_type` VALUES ('ID1709051734176057321566268', 1, '-1', 'Thing', '事物通用类型', '00001', 3, 0, '描述事物复合类型的顶级类型');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734176107955717880', 1, 'ID1709051734176057321566268', 'Person', '人', '0000100001', 2, 1, '1');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734176161041104329', 1, '-1', 'DataType', '基本数据类型', '00002', 1, 0, '基础类型的顶级类型');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734176200287100356', 1, 'ID1709051734176161041104329', 'Enumeration', '枚举型', '0000200001', 1, 0, '');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734176299742992483', 1, 'ID1709051734176161041104329', 'Number', '数字型', '0000200002', 1, 0, NULL);
INSERT INTO `tag_ext_type` VALUES ('ID1709051734176333445297452', 1, 'ID1709051734176299742992483', 'Integer', '整型', '000020000200001', 1, 0, '');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734176372151822324', 1, 'ID1709051734176161041104329', 'Text', '字符串型', '0000200003', 1, 0, '');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734176409899638337', 1, 'ID1709051734176057321566268', 'Identification', '证件', '0000100002', 3, 0, '');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734176448926723303', 1, 'ID1709051734176372151822324', 'Date', '日期型', '000020000300001', 2, 0, 'yyyy-MM-dd');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734176501988337388', 1, 'ID1709051734176057321566268', 'Contact', '联系方式', '0000100003', 3, 0, '');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734176539550664727', 1, 'ID1709051734176057321566268', 'Family', '家庭关系', '0000100004', 3, 0, '');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734176566373036178', 1, 'ID1709051734176057321566268', 'Alumnus', '教育经历信息', '0000100005', 3, 0, '');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734176592199195721', 1, 'ID1709051734176057321566268', 'IndividualDeposit', '个人存款产品', '0000100006', 3, 0, '');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734176634761524402', 1, 'ID1709051734176057321566268', 'IndividualLoans', '个人贷款产品', '0000100007', 3, 0, '');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734176679901708881', 1, 'ID1709051734176057321566268', 'IndividualOnlineBank', '个人客户网上银行产品', '0000100008', 3, 0, '');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734176700015913620', 1, 'ID1709051734176057321566268', 'IndividualMobileBank', '个人手机银行产品', '0000100009', 3, 0, '');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734176738858800303', 1, 'ID1709051734176057321566268', 'IndividualWeChatBank', '个人微信银行产品', '0000100010', 3, 0, '');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734176774040354286', 1, 'ID1709051734176057321566268', 'IndividualPhoneBank', '个人电话银行产品', '0000100011', 3, 0, '');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734176828172749023', 1, 'ID1709051734176057321566268', 'IndividualFinancing', '个人理财产品', '0000100012', 3, 0, '');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734176855719275837', 1, 'ID1709051734176057321566268', 'IndividualFund', '个人基金产品', '0000100013', 3, 0, '');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734176885037791719', 1, 'ID1709051734176057321566268', 'IndividualFundTargetInvestment', '个人基金定投', '0000100014', 3, 0, '');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734176912854783126', 1, 'ID1709051734176057321566268', 'IndividualThirdDepository', '个人三方存管', '0000100015', 3, 0, '');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734176959219845706', 1, 'ID1709051734176057321566268', 'IndividualDebitCard', '个人借记卡产品', '0000100016', 3, 0, '');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734176992921163170', 1, 'ID1709051734176057321566268', 'IndividualCreditCard', '个人信用卡产品', '0000100017', 3, 0, '');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734177022457496053', 1, 'ID1709051734176057321566268', 'IndividualCreditCardQuota', '个人信用卡额度', '0000100018', 3, 0, '');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734177053082904380', 1, 'ID1709051734176057321566268', 'IndividualInsuranceAgents', '个人代理保险产品', '0000100019', 3, 0, '');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734177076186787098', 1, 'ID1709051734176057321566268', 'IndividualDemandDepositsTrading', '个人活期存款交易', '0000100020', 3, 0, '');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734177119828064784', 1, 'ID1709051734176057321566268', 'IndividualDepositsTrading', '个人定期存款交易', '0000100021', 3, 0, '');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734177211333418901', 1, 'ID1709051734176057321566268', 'Place', 'Place', '0000100022', 3, 0, 'Entities that have a somewhat fixed, physical extension.');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734177244159812941', 1, 'ID1709051734176057321566268', 'Intangible', 'Intangible', '0000100023', 3, 0, 'A utility class that serves as the umbrella for a number of \"intangible\" things such as quantities, structured values, etc.');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734177260235641817', 1, 'ID1709051734177244159812941', 'Demand', 'Demand', '000010002300001', 3, 0, 'A demand entity represents the public, not necessarily binding, not necessarily exclusive, announcement by an organization or person to seek a certain type of goods or services. For describing demand using this type, the very same properties used for Offer apply.');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734177318728096300', 1, 'ID1709051734176057321566268', 'Organization', 'Organization', '0000100024', 3, 0, 'An organization such as a school, NGO, corporation, club, etc.');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734177358228857419', 1, 'ID1709051734177244159812941', 'Brand', 'Brand', '000010002300002', 3, 0, 'A brand is a name used by an organization or business person for labeling a product, product group, or similar.');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734177375736231763', 1, 'ID1709051734177244159812941', 'Offer', 'Offer', '000010002300003', 3, 0, 'An offer to transfer some rights to an item or to provide a service&#x2014;for example, an offer to sell tickets to an event, to rent the DVD of a movie, to stream a TV show over the internet, to repair a motorcycle, or to loan a book.       <br/><br/>       For <a href=\"http://www.gs1.org/barcodes/technical/idkeys/gtin\">GTIN</a>-related fields, see       <a href=\"http://www.gs1.org/barcodes/support/check_digit_calculator\">Check Digit calculator</a>       and <a href=\"http://www.gs1us.org/resources/standards/gtin-validation-guide\">validation guide</a>       from <a href=\"http://www.gs1.org/\">GS1</a>.');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734177437894707426', 1, 'ID1709051734177244159812941', 'Quantity', 'Quantity', '000010002300004', 3, 0, 'Quantities such as distance, time, mass, weight, etc. Particular instances of say Mass are entities like \"3 Kg\" or \"4 milligrams\".');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734177469710308205', 1, 'ID1709051734177437894707426', 'Distance', 'Distance', '00001000230000400001', 3, 0, 'Properties that take Distances as values are of the form \"&lt;Number&gt; &lt;Length unit of measure&gt;\". E.g., \"7 ft\".');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734177551780356364', 1, 'ID1709051734177244159812941', 'ItemList', 'ItemList', '000010002300005', 3, 0, 'A list of items of any sort&#x2014;for example, Top 10 Movies About Weathermen, or Top 100 Party Songs. Not to be confused with HTML lists, which are often used only for formatting.');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734177585662075468', 1, 'ID1709051734177551780356364', 'OfferCatalog', 'OfferCatalog', '00001000230000500001', 3, 0, 'An OfferCatalog is an ItemList that contains related Offers and/or further OfferCatalogs that are offeredBy the same provider.');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734177621581763149', 1, 'ID1709051734176057321566268', 'Event', 'Event', '0000100025', 3, 0, 'An event happening at a certain time and location, such as a concert, lecture, or festival. Ticketing information may be added via the \"offers\" property. Repeated events may be structured as separate Event objects.');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734177681535088447', 1, 'ID1709051734177244159812941', 'StructuredValue', 'StructuredValue', '000010002300006', 3, 0, 'Structured values are used when the value of a property has a more complex structure than simply being a textual value or a reference to another thing.');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734177714922436207', 1, 'ID1709051734177681535088447', 'ContactPoint', 'ContactPoint', '00001000230000600001', 3, 0, 'A contact point&#x2014;for example, a Customer Complaints department.');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734177747916824113', 1, 'ID1709051734177681535088447', 'OwnershipInfo', 'OwnershipInfo', '00001000230000600002', 3, 0, 'A structured value providing information about when a certain organization or person owned a certain product.');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734177773499612615', 1, 'ID1709051734177681535088447', 'QuantitativeValue', 'QuantitativeValue', '00001000230000600003', 3, 0, 'A point value or interval for product characteristics and other purposes.');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734177802758341488', 1, 'ID1709051734177681535088447', 'MonetaryAmount', 'MonetaryAmount', '00001000230000600004', 3, 0, 'A monetary value or range. This type can be used to describe an amount of money such as $50 USD, or a range as in describing a bank account being suitable for a balance between ￡1,000 and ￡1,000,000 GBP, or the value of a salary, etc. It is recommended to use <a class=\"localLink\" href=\"/PriceSpecification\">PriceSpecification</a> Types to describe the price of an Offer, Invoice, etc.');
INSERT INTO `tag_ext_type` VALUES ('ID1709051734177834061321701', 1, 'ID1709051734177714922436207', 'PostalAddress', '地址', '0000100023000060000100001', 3, 0, '');
INSERT INTO `tag_ext_type` VALUES ('-1', 2, NULL, 'Object', '顶级类型', '', 1, 0, '顶级类型');
INSERT INTO `tag_ext_type` VALUES ('ID1709251648374753279003403', 2, '-1', 'GY_Fund_Info', '测试增值用户信息', '00003', 3, 1, '');
INSERT INTO `tag_ext_type` VALUES ('ID1709251648374824505165174', 2, '-1', 'DataType', '基本数据类型', '00004', 1, 0, '基础类型的顶级类型');
INSERT INTO `tag_ext_type` VALUES ('ID1709251648374906392598396', 2, 'ID1709251648374824505165174', 'Text', '字符串型', '0000400001', 1, 0, '');
INSERT INTO `tag_ext_type` VALUES ('ID1709251648375016324930115', 2, 'ID1709251648374824505165174', 'Number', '数字型', '0000400002', 1, 0, NULL);
INSERT INTO `tag_ext_type` VALUES ('ID1709251648375094766574548', 2, 'ID1709251648375016324930115', 'Float', '浮点型', '000040000200001', 1, 0, '');
INSERT INTO `tag_ext_type` VALUES ('ID1709251648375193919373261', 2, '-1', 'GY_Usr_Info', '测试用户信息', '00005', 3, 1, '');
INSERT INTO `tag_ext_type` VALUES ('ID2112121717513952351050669', 3, '-1', 'DS_CLIENT', '电商用户', '00006', 3, 1, '电商用户');
INSERT INTO `tag_ext_type` VALUES ('ID2112121723123541862480718', 3, '-1', 'DataType', '基本数据类型', '00007', 1, 0, '基本数据类型的顶级父类');
INSERT INTO `tag_ext_type` VALUES ('ID2112121723505271480011966', 3, 'ID2112121723123541862480718', 'Text', '字符串型', '00000', 1, 0, '');
INSERT INTO `tag_ext_type` VALUES ('ID2112121724189439922803243', 3, 'ID2112121723123541862480718', 'Number', '整数类型', '00001', 1, 0, '');
INSERT INTO `tag_ext_type` VALUES ('ID2112121724362279459294951', 3, '-1', 'Float', '浮点型', '00008', 1, 0, '');

-- ----------------------------
-- Table structure for tag_ext_type_field
-- ----------------------------
DROP TABLE IF EXISTS `tag_ext_type_field`;
CREATE TABLE `tag_ext_type_field`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '主键ID',
  `industryType` int(0) NULL DEFAULT NULL COMMENT '行业类型（见字典表type=industryType）',
  `belongTypeId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `typeElementId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `selfTypeId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '自己的数据类型',
  `typeLength` int(0) NULL DEFAULT 0 COMMENT '属性数据类型长度',
  `typePrecision` int(0) NULL DEFAULT 0 COMMENT '属性数据类型精度',
  `isArray` int(0) NULL DEFAULT 0 COMMENT '是否是列表：0不是，1是',
  `isQuery` int(0) NULL DEFAULT NULL COMMENT '搜索时是否可查询：0不是，1是',
  `memo` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '说明',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK9A4373F828407FD4`(`belongTypeId`) USING BTREE,
  INDEX `FK9A4373F856B1D821`(`selfTypeId`) USING BTREE,
  INDEX `FK9A4373F8E30A7D7A`(`typeElementId`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '行业扩展模型数据类型属性' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tag_ext_type_field
-- ----------------------------
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179993914162685', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371758', 'ID1709051734176107955717880', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179966533290818', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371739', 'ID1709051734177211333418901', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179949100619395', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371731', 'ID1709051734176107955717880', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179915196887094', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371714', 'ID1709051734176372151822324', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179880223015207', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371709', 'ID1709051734177211333418901', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179850502909659', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371686', 'ID1709051734176107955717880', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179828812371105', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371659', 'ID1709051734176448926723303', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179795294069097', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371657', 'ID1709051734176372151822324', 0, 0, 0, 1, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179737935387241', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371591', 'ID1709051734176372151822324', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179764879816883', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371612', 'ID1709051734176107955717880', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179707051308604', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371526', 'ID1709051734176107955717880', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179683282364755', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371501', 'ID1709051734176107955717880', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179657210483501', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371460', 'ID1709051734176107955717880', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179639939637985', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371438', 'ID1709051734177318728096300', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179608723920452', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371420', 'ID1709051734176107955717880', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179572122636370', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371417', 'ID1709051734177747916824113', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179544708120349', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371415', 'ID1709051734177318728096300', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179518495790608', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371400', 'ID1709051734176372151822324', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179478365932622', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371366', 'ID1709051734177714922436207', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179443306352509', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371363', 'ID1709051734177375736231763', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179421978677203', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371347', 'ID1709051734176372151822324', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179399714523123', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371269', 'ID1709051734177358228857419', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179363648345682', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371262', 'ID1709051734176372151822324', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179331546158446', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371174', 'ID1709051734177318728096300', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179306218351830', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371159', 'ID1709051734177260235641817', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179276120419419', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371145', 'ID1709051734176372151822324', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179243120718753', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371142', 'ID1709051734176107955717880', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179210191060336', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371138', 'ID1709051734177211333418901', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179181771962478', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371120', 'ID1709051734177714922436207', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179163357428527', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371111', 'ID1709051734176372151822324', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179136301095772', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371097', 'ID1709051734176107955717880', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179104417917181', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371094', 'ID1709051734176107955717880', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179070364894423', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371031', 'ID1709051734176372151822324', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179051577448127', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371021', 'ID1709051734176372151822324', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179023476446614', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371018', 'ID1709051734176372151822324', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734179007610575638', 1, 'ID1709051734176107955717880', 'ID1606222046266889631640601', 'ID1709051734177119828064784', 0, 0, 1, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734178973530444690', 1, 'ID1709051734176107955717880', 'ID1606222045352194371235183', 'ID1709051734177076186787098', 0, 0, 1, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734178941395961472', 1, 'ID1709051734176107955717880', 'ID1606222045129690746631461', 'ID1709051734177053082904380', 0, 0, 1, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734178915423967903', 1, 'ID1709051734176107955717880', 'ID1606222057547918677056571', 'ID1709051734176299742992483', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734178895933485809', 1, 'ID1709051734176107955717880', 'ID1606222044322186558932779', 'ID1709051734176992921163170', 0, 0, 1, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734178866241837140', 1, 'ID1709051734176107955717880', 'ID1606222044164053222208225', 'ID1709051734176959219845706', 0, 0, 1, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734178841435170567', 1, 'ID1709051734176107955717880', 'ID1606222043579053460986728', 'ID1709051734176912854783126', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734178812810577008', 1, 'ID1709051734176107955717880', 'ID1606222043336240164066664', 'ID1709051734176885037791719', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734178783034147307', 1, 'ID1709051734176107955717880', 'ID1606222043051081426537090', 'ID1709051734176855719275837', 0, 0, 1, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734178753507882907', 1, 'ID1709051734176107955717880', 'ID1606222042409515635051548', 'ID1709051734176828172749023', 0, 0, 1, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734178729571141272', 1, 'ID1709051734176107955717880', 'ID1606222042164046802738821', 'ID1709051734176774040354286', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734178700806173408', 1, 'ID1709051734176107955717880', 'ID1606222041426061756661260', 'ID1709051734176738858800303', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734178675071395533', 1, 'ID1709051734176107955717880', 'ID1606222041114038447455289', 'ID1709051734176700015913620', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734178653332893845', 1, 'ID1709051734176107955717880', 'ID1606222040380127910346753', 'ID1709051734176679901708881', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734178628628925120', 1, 'ID1709051734176107955717880', 'ID1606222040104185204830178', 'ID1709051734176634761524402', 0, 0, 1, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734178582131666875', 1, 'ID1709051734176107955717880', 'ID1606222039393396027239495', 'ID1709051734176333445297452', 2, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734178566755223501', 1, 'ID1709051734176107955717880', 'ID1606181652269278909303403', 'ID1709051734176566373036178', 0, 0, 1, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734178539162878003', 1, 'ID1709051734176107955717880', 'ID1606181650134187851250251', 'ID1709051734176539550664727', 0, 0, 1, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734178498845542405', 1, 'ID1709051734176107955717880', 'ID1606051117025316411776731', 'ID1709051734176501988337388', 0, 0, 1, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734178462070811705', 1, 'ID1709051734176107955717880', 'ID1606041932435458734374223', 'ID1709051734176372151822324', 20, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734178435651145571', 1, 'ID1709051734176107955717880', 'ID1606041932435458734374222', 'ID1709051734176372151822324', 20, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734178404732001313', 1, 'ID1709051734176107955717880', 'ID1606041932435458734374221', 'ID1709051734176372151822324', 20, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734178375179477044', 1, 'ID1709051734176107955717880', 'ID1606041932435458734374220', 'ID1709051734176372151822324', 20, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734178348778388029', 1, 'ID1709051734176107955717880', 'ID1606041932435458734374219', 'ID1709051734176372151822324', 20, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734178312295699642', 1, 'ID1709051734176107955717880', 'ID1606041932435458734374218', 'ID1709051734176372151822324', 20, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734178285173829380', 1, 'ID1709051734176107955717880', 'ID1606041932435458734374208', 'ID1709051734176448926723303', 10, 0, 0, 0, '客户失效日期');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734178240001976536', 1, 'ID1709051734176107955717880', 'ID1606041932435458734374207', 'ID1709051734176448926723303', 10, 0, 0, 0, '客户生效日期');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734178211278643062', 1, 'ID1709051734176107955717880', 'ID1606041932435458734374217', 'ID1709051734177834061321701', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734178183343587364', 1, 'ID1709051734176107955717880', 'ID1606041932435458734374216', 'ID1709051734177834061321701', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734178154914468571', 1, 'ID1709051734176107955717880', 'ID1606041932435458734374215', 'ID1709051734176200287100356', 20, 0, 0, 1, 'CHN:中国');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734178125091591976', 1, 'ID1709051734176107955717880', 'ID1606041932435458734374214', 'ID1709051734176200287100356', 10, 0, 0, 1, '00:未登记或拒绝登记,01:汉族,02:蒙古族,03:回族,04:维吾尔族,05:藏族,06:苗族,07:彝族,08:壮族,09:布依族,10:朝鲜族');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734178086514764849', 1, 'ID1709051734176107955717880', 'ID1606041932435458734374213', 'ID1709051734176448926723303', 10, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734178058717716445', 1, 'ID1709051734176107955717880', 'ID1606041932435458734374212', 'ID1709051734176448926723303', 10, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734178028705573612', 1, 'ID1709051734176107955717880', 'ID1606051043348949309132887', 'ID1709051734176409899638337', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734177995287764198', 1, 'ID1709051734176107955717880', 'ID1606041932435458734374203', 'ID1709051734176372151822324', 10, 0, 0, 1, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734177953373678144', 1, 'ID1709051734176107955717880', 'ID1606041932435458734374201', 'ID1709051734176372151822324', 20, 0, 0, 1, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734177919624243169', 1, 'ID1709051734176107955717880', 'ID1606041932435458734374211', 'ID1709051734176333445297452', 11, 0, 0, 1, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734177895341981466', 1, 'ID1709051734176107955717880', 'ID1606051119474914114550441', 'ID1709051734177834061321701', 0, 0, 1, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734177866385612330', 1, 'ID1709051734176107955717880', 'ID1606041932435458734374210', 'ID1709051734176200287100356', 1, 0, 0, 1, '1:男,2:女,3:未知');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734180032567913033', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371762', 'ID1709051734177469710308205', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734180065263589412', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371767', 'ID1709051734177773499612615', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734180095919489364', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371810', 'ID1709051734176372151822324', 0, 0, 0, 1, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734180126219869491', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371814', 'ID1709051734176372151822324', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734180158137471254', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371826', 'ID1709051734176372151822324', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734180186549556088', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371842', 'ID1709051734177802758341488', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734180209608928394', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371878', 'ID1709051734177211333418901', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734180231179010975', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371897', 'ID1709051734176372151822324', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734180260569078894', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371962', 'ID1709051734177585662075468', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734180296665607029', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371963', 'ID1709051734176372151822324', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734180329081680622', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371965', 'ID1709051734176107955717880', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709051734180353990745230', 1, 'ID1709051734176107955717880', 'ID1607072311435458734371991', 'ID1709051734177621581763149', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709210927477670879915695', 1, 'ID1709051734176107955717880', 'ID1606041932435458734374278', 'ID1709051734176299742992483', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709061026033463966366789', 1, 'ID1709051734176107955717880', 'ID1606041932435458734374243', 'ID1709051734176333445297452', 4, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709061026292990554017941', 1, 'ID1709051734176107955717880', 'ID1606041932435458734374242', 'ID1709051734176333445297452', 4, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709201125411803977377576', 1, 'ID1709051734176107955717880', 'ID1606041932435458734374202', 'ID1709051734176372151822324', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709210924365612722467446', 1, 'ID1709051734176828172749023', 'ID1606041932435458734374278', 'ID1709051734176299742992483', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1907261455390343815066579', 2, 'ID1709251648375193919373261', 'ID1907261453563251602163676', 'ID1709251648375016324930115', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1907261455151829809901311', 2, 'ID1709251648375193919373261', 'ID1907261453068498713591070', 'ID1709251648374906392598396', 0, 0, 0, 0, '222');
INSERT INTO `tag_ext_type_field` VALUES ('ID1907261445565113581734363', 2, 'ID1709251648375193919373261', 'ID1709251449490325484855804', 'ID1709251648374906392598396', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1907261446360732287941701', 2, 'ID1709251648375193919373261', 'ID1709251452390655948308095', 'ID1709251648375094766574548', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709251648375309456916366', 2, 'ID1709251648374753279003403', 'ID1709251452390655948308095', 'ID1709251648375094766574548', 8, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709251648375358173106349', 2, 'ID1709251648374753279003403', 'ID1709251453076624266428834', 'ID1709251648375094766574548', 8, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID1709251648375247748064334', 2, 'ID1709251648374753279003403', 'ID1709251452071034415624840', 'ID1709251648374906392598396', 12, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID2112121737138742152405689', 3, 'ID2112121717513952351050669', 'ID2112121732378642692198743', 'ID2112121723505271480011966', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID2112121737239447542120826', 3, 'ID2112121717513952351050669', 'ID2112121732530075602233120', 'ID2112121723505271480011966', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID2112121737369731139568208', 3, 'ID2112121717513952351050669', 'ID2112121733161570756481905', 'ID2112121723505271480011966', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID2112121737464544723675187', 3, 'ID2112121717513952351050669', 'ID2112121733327419855756435', 'ID2112121723505271480011966', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID2112121738097793107234822', 3, 'ID2112121717513952351050669', 'ID2112121733488904724944343', 'ID2112121723505271480011966', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID2112121738184751491349844', 3, 'ID2112121717513952351050669', 'ID2112121734259344152304534', 'ID2112121724362279459294951', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID2112121738384986628798825', 3, 'ID2112121717513952351050669', 'ID2112121734543054899171157', 'ID2112121723505271480011966', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID2112121738545978048822358', 3, 'ID2112121717513952351050669', 'ID2112121735156905257572763', 'ID2112121723505271480011966', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID2112121739055007422437071', 3, 'ID2112121717513952351050669', 'ID2112121735347841068626759', 'ID2112121724189439922803243', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID2112121739184970329739995', 3, 'ID2112121717513952351050669', 'ID2112121736030557658540776', 'ID2112121724189439922803243', 0, 0, 0, 0, '');
INSERT INTO `tag_ext_type_field` VALUES ('ID2112121739360411878171212', 3, 'ID2112121717513952351050669', 'ID2112121736296859374049689', 'ID2112121724362279459294951', 0, 0, 0, 0, '');

-- ----------------------------
-- Table structure for tag_ext_type_field_express
-- ----------------------------
DROP TABLE IF EXISTS `tag_ext_type_field_express`;
CREATE TABLE `tag_ext_type_field_express`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '主键ID',
  `industryType` int(0) NULL DEFAULT NULL COMMENT '行业类型（见字典表type=industryType）',
  `extTypeFieldId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` int(0) NULL DEFAULT NULL COMMENT '表达类型，具体见字典表type=expressType',
  `express` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表达模板',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK70C1BE09AEF2CF34`(`extTypeFieldId`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '行业扩展模型属性表述模板' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tag_ext_type_field_express
-- ----------------------------
INSERT INTO `tag_ext_type_field_express` VALUES ('ID1904241516378690315988317', 2, 'ID1709251648375309456916366', 1, '${n}test');

-- ----------------------------
-- Table structure for tag_param_in
-- ----------------------------
DROP TABLE IF EXISTS `tag_param_in`;
CREATE TABLE `tag_param_in`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '主键ID',
  `userId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属用户',
  `tagId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所属标签节点ID，只能是规则节点',
  `fieldId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所属模型属性ID',
  `parentId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上级节点ID',
  `treeCode` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '树结构编码',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK8E98115C80B12434`(`tagId`) USING BTREE,
  INDEX `FK8E98115CAF96C30`(`fieldId`) USING BTREE,
  INDEX `FK8E98115CB7AA2112`(`fieldId`) USING BTREE,
  INDEX `FK8E98115CC63F0320`(`userId`) USING BTREE,
  INDEX `FK8E98115C80698C6F`(`fieldId`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '入参配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tag_param_in
-- ----------------------------
INSERT INTO `tag_param_in` VALUES ('ID2112191442152099650103418', '1', 'ID2112121751239337514913136', 'ID2112121739360411878171212', 'ID8624712487296939107000000', '00002');
INSERT INTO `tag_param_in` VALUES ('ID2201101608435910374894690', '1', 'ID2112121746288599756274827', 'ID2112121739055007422437071', 'ID4469229290412409667000000', '00001');

-- ----------------------------
-- Table structure for tag_param_in_lib
-- ----------------------------
DROP TABLE IF EXISTS `tag_param_in_lib`;
CREATE TABLE `tag_param_in_lib`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键ID',
  `ruleLibId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所属标签规则库ID',
  `fieldId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所属模型属性ID',
  `parentId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上级节点ID',
  `treeCode` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '树结构编码',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK77645902B7AA2112`(`fieldId`) USING BTREE,
  INDEX `FK77645902955351D2`(`ruleLibId`) USING BTREE,
  INDEX `FK7764590280698C6F`(`fieldId`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '标签规则库入参详细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tag_rule
-- ----------------------------
DROP TABLE IF EXISTS `tag_rule`;
CREATE TABLE `tag_rule`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '主键ID',
  `userId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属用户',
  `tagId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属标签节点ID',
  `type` int(0) NULL DEFAULT NULL COMMENT '规则类型，具体见type=ruleType字典',
  `rule` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '规则',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK2E120A180B12434`(`tagId`) USING BTREE,
  INDEX `FK2E120A1C63F0320`(`userId`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '标签规则表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tag_rule
-- ----------------------------
INSERT INTO `tag_rule` VALUES ('ID1709191431281345563984246', '1', 'ID1709191426432943372946123', 1, '[{\"sql\":\"gender\\t = \\t1\",\"result\":\"1\"},{\"sql\":\"gender\\t = \\t2\",\"result\":\"2\"}]');
INSERT INTO `tag_rule` VALUES ('ID1709191432179978083455161', '1', 'ID1606292029338045132967557', 1, '[{\"sql\":\"sum(financing.balance)\\t >= \\t10000\",\"result\":\"1\"},{\"sql\":\"(\\t(\\tsum(financing.balance)\\t < \\t10000\\t)\\t and \\t(\\tsum(financing.balance)\\t >= \\t5000\\t)\\t)\",\"result\":\"2\"},{\"sql\":\"sum(financing.balance)\\t < \\t5000\",\"result\":\"3\"}]');
INSERT INTO `tag_rule` VALUES ('ID1709271127162890384389916', '1', 'ID1709271112494741673409910', 1, '[{\"sql\":\"count(GY_FUND_INFO.FUND_CORP_ID)\\t >= \\t4\",\"result\":\"1\"},{\"sql\":\"(\\t(\\tcount(GY_FUND_INFO.FUND_CORP_ID)\\t >= \\t1\\t)\\t and \\t(\\tcount(GY_FUND_INFO.FUND_CORP_ID)\\t < \\t4\\t)\\t)\",\"result\":\"2\"},{\"sql\":\"count(GY_FUND_INFO.FUND_CORP_ID)\\t < \\t1\",\"result\":\"3\"}]');
INSERT INTO `tag_rule` VALUES ('ID1709271128309374475647666', '1', 'ID1709271112333830713071988', 1, '[{\"sql\":\"CUR_AMT\\t >= \\t1000\",\"result\":\"1\"},{\"sql\":\"(\\t(\\tCUR_AMT\\t >= \\t500\\t)\\t and \\t(\\tCUR_AMT\\t < \\t1000\\t)\\t)\",\"result\":\"2\"},{\"sql\":\"CUR_AMT\\t < \\t500\",\"result\":\"3\"}]');
INSERT INTO `tag_rule` VALUES ('ID1907291654578202441180424', '1', 'ID1907291649275525161434603', 1, '[{\"sql\":\"USR_COUNT\\t >= \\t10\",\"result\":\"1\"},{\"sql\":\"(\\t(\\tUSR_COUNT\\t >= \\t4\\t)\\t and \\t(\\tUSR_COUNT\\t < \\t10\\t)\\t)\",\"result\":\"2\"},{\"sql\":\"USR_COUNT\\t < \\t4\",\"result\":\"3\"}]');
INSERT INTO `tag_rule` VALUES ('ID1907291657546045056974912', '1', 'ID1907291652217870869935226', 1, '[{\"sql\":\"USR_MIN_DT\\u0002 <= \\u000220180101\",\"result\":\"1\"},{\"sql\":\"USR_MIN_DT\\u0002 >= \\u000220180101\",\"result\":\"2\"}]');
INSERT INTO `tag_rule` VALUES ('ID2112141730503772389927714', '1', 'ID2112121744490946929352851', 1, '[{\"sql\":\"DS_USER_AGE	 >= 	30\",\"result\":\"1\"}]');
INSERT INTO `tag_rule` VALUES ('ID2112141731278631032154639', '1', 'ID2112121744490946929352851', 1, '[{\"sql\":\"DS_USER_AGE	 >= 	30\",\"result\":\"1\"}]');
INSERT INTO `tag_rule` VALUES ('ID2112141735423987252979057', '1', 'ID2112121744344949468976184', 1, '[{\"result\":\"1\",\"sql\":\"(\\t(\\tDS_USER_AGE\\t < \\t40\\t)\\t and \\t(\\tDS_USER_AGE\\t >= \\t30\\t)\\t)\"},{\"result\":\"2\",\"sql\":\"(\\t(\\tDS_USER_AGE\\t < \\t30\\t)\\t and \\t(\\tDS_USER_AGE\\t >= \\t20\\t)\\t)\"},{\"result\":\"3\",\"sql\":\"DS_USER_AGE\\t < \\t20\"},{\"result\":\"4\",\"sql\":\"DS_USER_AGE\\t >= \\t40\"}]');
INSERT INTO `tag_rule` VALUES ('ID2201101611185083084789957', '1', 'ID2112121746288599756274827', 1, '[{\"result\":\"1\",\"sql\":\"DS_USER_AGE\\t <= \\t20\"},{\"result\":\"2\",\"sql\":\"(\\t(\\tDS_USER_AGE\\t > \\t20\\t)\\t and \\t(\\tDS_USER_AGE\\t <= \\t40\\t)\\t)\"},{\"result\":\"3\",\"sql\":\"DS_USER_AGE\\t >= \\t40\"}]');

-- ----------------------------
-- Table structure for tag_rule_lib
-- ----------------------------
DROP TABLE IF EXISTS `tag_rule_lib`;
CREATE TABLE `tag_rule_lib`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键ID',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规则库名称',
  `description` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规则库描述',
  `tagId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所属规则节点',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK765A3DC780B12434`(`tagId`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '标签规则库表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tag_rule_lib_assign
-- ----------------------------
DROP TABLE IF EXISTS `tag_rule_lib_assign`;
CREATE TABLE `tag_rule_lib_assign`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键ID',
  `ruleLibId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签规则库ID',
  `userId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属用户ID',
  `memo` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKD347667955351D2`(`ruleLibId`) USING BTREE,
  INDEX `FKD347667C63F0320`(`userId`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '标签规则库授权表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tag_rule_lib_detail
-- ----------------------------
DROP TABLE IF EXISTS `tag_rule_lib_detail`;
CREATE TABLE `tag_rule_lib_detail`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键ID',
  `ruleLibId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所属规则库',
  `type` int(0) NULL DEFAULT NULL COMMENT '规则类型，具体见type=ruleType字典',
  `rule` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '规则',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK118E0DC9955351D2`(`ruleLibId`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '标签规则库详细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tag_vertex
-- ----------------------------
DROP TABLE IF EXISTS `tag_vertex`;
CREATE TABLE `tag_vertex`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '主键ID',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '顶点名称',
  `type` int(0) NULL DEFAULT NULL COMMENT '顶点类型，具体见字典表type=vertexType',
  `enable` int(0) NULL DEFAULT NULL COMMENT '是否可用0不可用，1可用',
  `value` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '标签对应的值',
  `industryType` int(0) NULL DEFAULT NULL COMMENT '所属的行业ID，值见字典表type=industryType',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '标签网顶点实体类' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tag_vertex
-- ----------------------------
INSERT INTO `tag_vertex` VALUES ('-1', '标签体系树', 1, 1, '', -1);
INSERT INTO `tag_vertex` VALUES ('ID1605102338215573103233721', '基础属性', 1, 1, '1', 1);
INSERT INTO `tag_vertex` VALUES ('ID1605102347233570954042998', '自然属性', 1, 0, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1605112149304713474981318', '人口统计属性', 1, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1605112149469391460442423', '姓名', 2, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1605112155529356196082057', '按姓氏族分', 3, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1605112156081493531215968', '慕容姓氏家族', 4, 1, '1', 1);
INSERT INTO `tag_vertex` VALUES ('ID1605112156176553763829761', '张氏族群', 4, 1, '2', 1);
INSERT INTO `tag_vertex` VALUES ('ID1605112156256903578342499', '李氏族群', 4, 1, '3', 1);
INSERT INTO `tag_vertex` VALUES ('ID1605112156449897817884870', '年龄', 2, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1605112156576288057095066', '按年龄段分', 3, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1605112157074104244348488', '婴儿', 4, 1, '1', 1);
INSERT INTO `tag_vertex` VALUES ('ID1605112157211041143011219', '少儿', 4, 1, '2', 1);
INSERT INTO `tag_vertex` VALUES ('ID1605112157311219628980894', '少年', 4, 1, '3', 1);
INSERT INTO `tag_vertex` VALUES ('ID1605112157379201084891216', '青年', 4, 1, '4', 1);
INSERT INTO `tag_vertex` VALUES ('ID1605112157442711231210978', '中老年', 4, 1, '5', 1);
INSERT INTO `tag_vertex` VALUES ('ID1605182221390647463985640', '按年代分', 3, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1605182222052934222658292', '五零后之前', 4, 1, '1', 1);
INSERT INTO `tag_vertex` VALUES ('ID1605182222151279444635185', '五零后', 4, 1, '2', 1);
INSERT INTO `tag_vertex` VALUES ('ID1605182222291694853029693', '六零后', 4, 1, '3', 1);
INSERT INTO `tag_vertex` VALUES ('ID1605182222345501500666968', '七零后', 4, 1, '4', 1);
INSERT INTO `tag_vertex` VALUES ('ID1605182222431479930087581', '八零后', 4, 1, '5', 1);
INSERT INTO `tag_vertex` VALUES ('ID1606292025100048084376983', '关系属性', 1, 1, '2', 1);
INSERT INTO `tag_vertex` VALUES ('ID1606211558488953137075241', '九零后', 4, 1, '6', 1);
INSERT INTO `tag_vertex` VALUES ('ID1606211559035364494296291', '零零后', 4, 1, '7', 1);
INSERT INTO `tag_vertex` VALUES ('ID1606292026067235160461345', '与团体关系 ', 1, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1606292027129435684737845', '与次级团体关系', 1, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1606292027248816018389755', '金融性关系', 1, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1606292027457567743382237', '理财关系', 1, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1606292028511161553616458', '理财余额', 2, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1606292029338045132967557', '按余额确认客户层次', 3, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1606292030402273340795706', '高端客户', 4, 1, '1', 1);
INSERT INTO `tag_vertex` VALUES ('ID1606292031005089929578564', '中端客户', 4, 1, '2', 1);
INSERT INTO `tag_vertex` VALUES ('ID1606292031267433511138590', '低端客户', 4, 1, '3', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607022350459646371773577', '信用卡余额分析', 2, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607021821046560798520881', '按购买理财产品个数确认客户忠诚度', 3, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607022348359150620930294', '客户负债价值分析', 1, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607022351356191399020871', '余额与资产比', 3, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607022345319311635755462', '好', 4, 1, '8', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607022310378791499376740', '评估属性', 1, 1, '5', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607022311096296748440015', '价值评估', 1, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607022311477084868358487', '潜在价值', 1, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607022314499978105431672', '客户资产价值分析', 1, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607022315034660802831880', '存款理财分析', 2, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607022323199302695830498', '存款资产比', 3, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607022324390102519371840', '无资产', 4, 1, '1', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607022325349496982992837', '理财偏好型', 4, 1, '2', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607022327396888149994324', '理财存款均衡型', 4, 1, '3', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607022327534236003742865', '存款偏好型', 4, 1, '4', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607022328393157566780893', '全存款型', 4, 1, '5', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607022339211272906980812', '理财客户忠诚分析', 2, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607022340481596375626301', '理财产品数角度', 3, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607022341223943901825616', '高度忠诚客户', 4, 1, '4', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607022341563475444476144', '一般忠诚客户', 4, 1, '3', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607022342204730003037244', '犹豫型客户', 4, 1, '2', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607022342346605187627141', '背离型客户', 4, 1, '1', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607022357084903158140601', '未用信用卡', 4, 1, '1', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607022357246463131183724', '低消费型', 4, 1, '2', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607022357386044449843956', '高消费型', 4, 1, '3', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607022357505737623795527', '资产存放他行', 4, 1, '4', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607261549293530460986478', '活动属性', 1, 1, '4', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607261607585652365156285', '有意识行为', 1, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607261608168157805966798', '金融性活动', 1, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607261608278623569209301', '资产类活动', 1, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607261608456756817125295', '存款交易', 2, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607261609513800185132623', '活跃度分析', 3, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607261610085993617513440', '活跃客户', 4, 1, '1', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607261610199741188761457', '不活跃客户', 4, 1, '2', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607261610526781189818248', '流量分析', 3, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607261611197413587510510', '月净流入客户', 4, 1, '1', 1);
INSERT INTO `tag_vertex` VALUES ('ID1607261611320235435553113', '月净流出客户', 4, 1, '2', 1);
INSERT INTO `tag_vertex` VALUES ('ID1605101010105573103233721', '人', 1, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1701091920348588509079931', '金融体系', 1, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1702201846245848118673524', '交通体系', 1, 1, '', 2);
INSERT INTO `tag_vertex` VALUES ('ID1702201846418507420178674', '高速公路', 1, 1, '', 2);
INSERT INTO `tag_vertex` VALUES ('ID1702201846499918586993018', '普通公路', 1, 1, '', 2);
INSERT INTO `tag_vertex` VALUES ('ID1702201846570546627964020', '城市交通', 1, 1, '', 2);
INSERT INTO `tag_vertex` VALUES ('ID1702201847016799779333095', '轨道交通', 1, 1, '', 2);
INSERT INTO `tag_vertex` VALUES ('ID1702201847074766361403410', '水运', 1, 1, '', 2);
INSERT INTO `tag_vertex` VALUES ('ID1702201847305233990034613', '电商体系', 1, 1, '', 3);
INSERT INTO `tag_vertex` VALUES ('ID1702201847426323006419363', '商业保险', 1, 1, '', 3);
INSERT INTO `tag_vertex` VALUES ('ID1702201848146486010402173', 'ETC', 1, 1, '', 2);
INSERT INTO `tag_vertex` VALUES ('ID1702201848187737885470397', 'MTC', 1, 1, '', 2);
INSERT INTO `tag_vertex` VALUES ('ID1702201848266331374872152', '交通管理', 1, 1, '', 2);
INSERT INTO `tag_vertex` VALUES ('ID1702201848385080338572492', '基础建设', 1, 1, '', 2);
INSERT INTO `tag_vertex` VALUES ('ID1702201848526335257083477', '道路养护', 1, 1, '', 2);
INSERT INTO `tag_vertex` VALUES ('ID1709191426203837233253002', '性别', 2, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1709191426432943372946123', '按性别分', 3, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1709191427177175290099728', '男', 4, 1, '1', 1);
INSERT INTO `tag_vertex` VALUES ('ID1709191427403312920302333', '女', 4, 1, '2', 1);
INSERT INTO `tag_vertex` VALUES ('ID1709271111001421239487528', '测试', 1, 1, '6', 1);
INSERT INTO `tag_vertex` VALUES ('ID1709271111360750906219126', '理财关系', 1, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1709271112006337765404995', '签约产品个数', 2, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1709271112141160992287570', '理财余额', 2, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1709271112333830713071988', '按余额确认客户层次', 3, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1709271112494741673409910', '按签约个数确定客户层次', 3, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1709271113079289872458322', '投资高端客户', 4, 1, '1', 1);
INSERT INTO `tag_vertex` VALUES ('ID1709271113269365521638516', '投资中端客户', 4, 1, '2', 1);
INSERT INTO `tag_vertex` VALUES ('ID1709271113359236382545765', '投资低端客户', 4, 1, '3', 1);
INSERT INTO `tag_vertex` VALUES ('ID1709271113525006817769914', '签约活跃客户', 4, 1, '1', 1);
INSERT INTO `tag_vertex` VALUES ('ID1709271114035727258357737', '签约一般客户', 4, 1, '2', 1);
INSERT INTO `tag_vertex` VALUES ('ID1709271114148258531014852', '无签约客户', 4, 1, '3', 1);
INSERT INTO `tag_vertex` VALUES ('ID1907291648226672647269717', '活动关系', 1, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1907291648465089378590095', '业务参与度', 2, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1907291649275525161434603', '风控参与程度', 3, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1907291649443871300469248', '风控活跃客户', 4, 1, '1', 1);
INSERT INTO `tag_vertex` VALUES ('ID1907291650029252966740120', '风控一般客户', 4, 1, '2', 1);
INSERT INTO `tag_vertex` VALUES ('ID1907291650137875330139651', '风控沉默客户', 4, 1, '3', 1);
INSERT INTO `tag_vertex` VALUES ('ID1907291652054636645893406', '最早参与时间', 2, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1907291652217870869935226', '风控最早参与时间', 3, 1, '', 1);
INSERT INTO `tag_vertex` VALUES ('ID1907291652521985730580916', '风控老客户', 4, 1, '1', 1);
INSERT INTO `tag_vertex` VALUES ('ID1907291653050379677686450', '风控新客户', 4, 1, '2', 1);
INSERT INTO `tag_vertex` VALUES ('ID2112121740227163623876719', '电商用户', 1, 1, '', 3);
INSERT INTO `tag_vertex` VALUES ('ID2112121741334999421067048', '基础属性', 1, 1, '', 3);
INSERT INTO `tag_vertex` VALUES ('ID2112121741439314706837778', '评估属性', 2, 1, '', 3);
INSERT INTO `tag_vertex` VALUES ('ID2112121741511869130405962', '活动属性', 1, 1, '', 3);
INSERT INTO `tag_vertex` VALUES ('ID2112121742009835774385873', '关系属性', 1, 1, '', 3);
INSERT INTO `tag_vertex` VALUES ('ID2112121742463565519209604', '年龄', 2, 1, '', 3);
INSERT INTO `tag_vertex` VALUES ('ID2112121744344949468976184', '年代', 3, 1, '', 3);
INSERT INTO `tag_vertex` VALUES ('ID2112121744490946929352851', '80后', 4, 1, '1', 3);
INSERT INTO `tag_vertex` VALUES ('ID2112121745025312780345238', '90后', 4, 1, '2', 3);
INSERT INTO `tag_vertex` VALUES ('ID2112121745146431263811403', '00后', 4, 1, '3', 3);
INSERT INTO `tag_vertex` VALUES ('ID2112121746011984254982254', '70后', 4, 1, '4', 3);
INSERT INTO `tag_vertex` VALUES ('ID2112121746288599756274827', '年龄段', 3, 1, '', 3);
INSERT INTO `tag_vertex` VALUES ('ID2112121746415844908154282', '青少年', 4, 1, '1', 3);
INSERT INTO `tag_vertex` VALUES ('ID2112121746519680221724459', '中年', 4, 1, '2', 3);
INSERT INTO `tag_vertex` VALUES ('ID2112121747017651309979022', '老年', 4, 1, '3', 3);
INSERT INTO `tag_vertex` VALUES ('ID2112121748128848908510578', '交易次数', 3, 1, '', 3);
INSERT INTO `tag_vertex` VALUES ('ID2112121748374277515077746', '活跃用户', 4, 1, '1', 3);
INSERT INTO `tag_vertex` VALUES ('ID2112121748474159258934750', '一般用户', 4, 1, '2', 3);
INSERT INTO `tag_vertex` VALUES ('ID2112121748592239061339722', '沉默用户', 4, 1, '3', 3);
INSERT INTO `tag_vertex` VALUES ('ID2112121749152271279586959', '交易金额', 3, 1, '', 3);
INSERT INTO `tag_vertex` VALUES ('ID2112121749418670971228229', '电商高端投资用户', 4, 1, '1', 3);
INSERT INTO `tag_vertex` VALUES ('ID2112121750155892582765745', '电商中端投资用户', 4, 1, '2', 3);
INSERT INTO `tag_vertex` VALUES ('ID2112121750300637717316769', '电商低端投资用户', 4, 1, '3', 3);
INSERT INTO `tag_vertex` VALUES ('ID2112121750550271163670941', '综合评估', 2, 1, '', 3);
INSERT INTO `tag_vertex` VALUES ('ID2112121751239337514913136', '电商用户综合评估', 3, 1, '', 3);
INSERT INTO `tag_vertex` VALUES ('ID2112121751436041982197289', '优质客户', 4, 1, '1', 3);
INSERT INTO `tag_vertex` VALUES ('ID2112121751549992797742167', '重点客户', 4, 1, '2', 3);
INSERT INTO `tag_vertex` VALUES ('ID2112121752082662556876967', '羊毛党', 4, 1, '3', 3);
INSERT INTO `tag_vertex` VALUES ('ID2112121752176360644865377', '边缘用户', 4, 1, '4', 3);

-- ----------------------------
-- Table structure for tag_vertex_express
-- ----------------------------
DROP TABLE IF EXISTS `tag_vertex_express`;
CREATE TABLE `tag_vertex_express`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主键ID',
  `vertexId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属标签',
  `type` int(0) NULL DEFAULT NULL COMMENT '表达类型，具体见字典表type=expressType',
  `express` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表达模板',
  INDEX `FK974C0B1A3DBBBBE`(`vertexId`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '标签表述模板' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tag_vertex_express
-- ----------------------------
INSERT INTO `tag_vertex_express` VALUES ('ID2112141702522673403051050', 'ID2112121748128848908510578', 1, '123');

SET FOREIGN_KEY_CHECKS = 1;
