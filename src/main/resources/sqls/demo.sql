/*
Navicat MySQL Data Transfer

Source Server         : 192.168.0.108_ubuntu_1
Source Server Version : 50720
Source Host           : localhost:3306
Source Database       : demo

Target Server Type    : MYSQL
Target Server Version : 50720
File Encoding         : 65001

Date: 2018-03-11 21:01:13
*/

SET FOREIGN_KEY_CHECKS=0;


-- ----------------------------
-- Table structure for t_qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `t_qrtz_blob_triggers`;
CREATE TABLE `t_qrtz_blob_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(190) NOT NULL,
  `trigger_group` varchar(190) NOT NULL,
  `blob_data` blob,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  KEY `sched_name` (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `t_qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `t_qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Trigger 作为 Blob 类型存储(用于 Quartz 用户用JDBC创建他们自己定制的 Trigger 类型，JobStore并不知道如何存储实例的时候)   ';

-- ----------------------------
-- Records of t_qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for t_qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `t_qrtz_calendars`;
CREATE TABLE `t_qrtz_calendars` (
  `sched_name` varchar(120) NOT NULL,
  `calendar_name` varchar(190) NOT NULL,
  `calendar` blob NOT NULL,
  PRIMARY KEY (`sched_name`,`calendar_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='以 Blob 类型存储 Quartz 的 Calendar 信息   ';

-- ----------------------------
-- Records of t_qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for t_qrtz_console
-- ----------------------------
DROP TABLE IF EXISTS `t_qrtz_console`;
CREATE TABLE `t_qrtz_console` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT 'job（任务）名称，所有任务分组和触发器分组为默认值DEFAULT',
  `name_en` varchar(50) NOT NULL COMMENT '任务英文名称，唯一',
  `full_class_name` varchar(150) NOT NULL COMMENT '类名称，包含包名称',
  `cron` varchar(20) NOT NULL COMMENT 'cron表达式',
  `last_updatetime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最后一次更新时间',
  `admin_user_id` int(10) unsigned DEFAULT NULL COMMENT '最后一次更新操作人员id',
  `admin_user_ip` varchar(30) DEFAULT NULL COMMENT '最后一次更新操作人员ip',
  `memo` varchar(255) DEFAULT NULL COMMENT '备注',
  `status` int(10) NOT NULL DEFAULT '2' COMMENT '任务状态：1表示正常运行，2表示停止运行，3表示暂停（服务重启后会正常运行）',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_unique_name_en` (`name_en`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='系统定时任务控制器，其它t_qrtz开头的表为quartz框架表';

-- ----------------------------
-- Records of t_qrtz_console
-- ----------------------------
INSERT INTO `t_qrtz_console` VALUES ('8', '测试', 'TestJob', 'com.qjf.quartz.job.TestJob', '* * * * * ?', '2018-03-11 20:41:24', '1', '0:0:0:0:0:0:0:1', '', '2');

-- ----------------------------
-- Table structure for t_qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `t_qrtz_cron_triggers`;
CREATE TABLE `t_qrtz_cron_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(190) NOT NULL,
  `trigger_group` varchar(190) NOT NULL,
  `cron_expression` varchar(120) NOT NULL,
  `time_zone_id` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `t_qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `t_qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='存储 Cron Trigger，包括Cron表达式和时区信息,执行unscheduleJob将被移除';

-- ----------------------------
-- Records of t_qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for t_qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `t_qrtz_fired_triggers`;
CREATE TABLE `t_qrtz_fired_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `entry_id` varchar(95) NOT NULL,
  `trigger_name` varchar(190) NOT NULL,
  `trigger_group` varchar(190) NOT NULL,
  `instance_name` varchar(190) NOT NULL,
  `fired_time` bigint(13) NOT NULL,
  `sched_time` bigint(13) NOT NULL,
  `priority` int(11) NOT NULL,
  `state` varchar(16) NOT NULL,
  `job_name` varchar(190) DEFAULT NULL,
  `job_group` varchar(190) DEFAULT NULL,
  `is_nonconcurrent` varchar(1) DEFAULT NULL,
  `requests_recovery` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`entry_id`),
  KEY `idx_qrtz_ft_trig_inst_name` (`sched_name`,`instance_name`),
  KEY `idx_qrtz_ft_inst_job_req_rcvry` (`sched_name`,`instance_name`,`requests_recovery`),
  KEY `idx_qrtz_ft_j_g` (`sched_name`,`job_name`,`job_group`),
  KEY `idx_qrtz_ft_jg` (`sched_name`,`job_group`),
  KEY `idx_qrtz_ft_t_g` (`sched_name`,`trigger_name`,`trigger_group`),
  KEY `idx_qrtz_ft_tg` (`sched_name`,`trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='存储与已触发的 Trigger 相关的状态信息，以及相联 Job的执行信息';

-- ----------------------------
-- Records of t_qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for t_qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `t_qrtz_job_details`;
CREATE TABLE `t_qrtz_job_details` (
  `sched_name` varchar(120) NOT NULL,
  `job_name` varchar(190) NOT NULL COMMENT '集群中job的名字,该名字用户自己可以随意定制,无强行要求',
  `job_group` varchar(190) NOT NULL COMMENT '集群中job的所属组的名字,该名字用户自己随意定制,无强行要求',
  `description` varchar(250) DEFAULT NULL,
  `job_class_name` varchar(250) NOT NULL COMMENT '集群中个notejob实现类的完全包名,quartz就是根据这个路径到classpath找到该job类',
  `is_durable` varchar(1) NOT NULL COMMENT '是否持久化,把该属性设置为1，quartz会把job持久化到数据库中',
  `is_nonconcurrent` varchar(1) NOT NULL,
  `is_update_data` varchar(1) NOT NULL,
  `requests_recovery` varchar(1) NOT NULL,
  `job_data` blob COMMENT '一个blob字段，存放持久化job对象',
  PRIMARY KEY (`sched_name`,`job_name`,`job_group`),
  KEY `idx_qrtz_j_req_recovery` (`sched_name`,`requests_recovery`),
  KEY `idx_qrtz_j_grp` (`sched_name`,`job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='存储每一个已配置的 Job 的详细信息';

-- ----------------------------
-- Records of t_qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for t_qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `t_qrtz_locks`;
CREATE TABLE `t_qrtz_locks` (
  `sched_name` varchar(120) NOT NULL,
  `lock_name` varchar(40) NOT NULL,
  PRIMARY KEY (`sched_name`,`lock_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='存储程序的悲观锁的信息(假如使用了悲观锁)   ';



-- ----------------------------
-- Table structure for t_qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `t_qrtz_paused_trigger_grps`;
CREATE TABLE `t_qrtz_paused_trigger_grps` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_group` varchar(190) NOT NULL,
  PRIMARY KEY (`sched_name`,`trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT=' 存储已暂停的 Trigger组的信息   ';

-- ----------------------------
-- Records of t_qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for t_qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `t_qrtz_scheduler_state`;
CREATE TABLE `t_qrtz_scheduler_state` (
  `sched_name` varchar(120) NOT NULL,
  `instance_name` varchar(190) NOT NULL,
  `last_checkin_time` bigint(13) NOT NULL,
  `checkin_interval` bigint(13) NOT NULL,
  PRIMARY KEY (`sched_name`,`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='存储少量的有关 Scheduler 的状态信息，和别的Scheduler实例(假如是用于一个集群中)';


-- ----------------------------
-- Table structure for t_qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `t_qrtz_simple_triggers`;
CREATE TABLE `t_qrtz_simple_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(190) NOT NULL,
  `trigger_group` varchar(190) NOT NULL,
  `repeat_count` bigint(7) NOT NULL,
  `repeat_interval` bigint(12) NOT NULL,
  `times_triggered` bigint(10) NOT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `t_qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `t_qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='存储简单的Trigger，包括重复次数，间隔，以及已触的次数  ';

-- ----------------------------
-- Records of t_qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for t_qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `t_qrtz_simprop_triggers`;
CREATE TABLE `t_qrtz_simprop_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(190) NOT NULL,
  `trigger_group` varchar(190) NOT NULL,
  `str_prop_1` varchar(512) DEFAULT NULL,
  `str_prop_2` varchar(512) DEFAULT NULL,
  `str_prop_3` varchar(512) DEFAULT NULL,
  `int_prop_1` int(11) DEFAULT NULL,
  `int_prop_2` int(11) DEFAULT NULL,
  `long_prop_1` bigint(20) DEFAULT NULL,
  `long_prop_2` bigint(20) DEFAULT NULL,
  `dec_prop_1` decimal(13,4) DEFAULT NULL,
  `dec_prop_2` decimal(13,4) DEFAULT NULL,
  `bool_prop_1` varchar(1) DEFAULT NULL,
  `bool_prop_2` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `t_qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `t_qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for t_qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `t_qrtz_triggers`;
CREATE TABLE `t_qrtz_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(190) NOT NULL COMMENT 'trigger的名字,该名字用户自己可以随意定制,无强行要求',
  `trigger_group` varchar(190) NOT NULL COMMENT 'trigger所属组的名字,该名字用户自己随意定制,无强行要求   ',
  `job_name` varchar(190) NOT NULL,
  `job_group` varchar(190) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `next_fire_time` bigint(13) DEFAULT NULL,
  `prev_fire_time` bigint(13) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `trigger_state` varchar(16) NOT NULL COMMENT '当前trigger状态，设置为ACQUIRED,如果设置为WAITING,则job不会触发  ',
  `trigger_type` varchar(8) NOT NULL,
  `start_time` bigint(13) NOT NULL,
  `end_time` bigint(13) DEFAULT NULL,
  `calendar_name` varchar(190) DEFAULT NULL,
  `misfire_instr` smallint(2) DEFAULT NULL,
  `job_data` blob,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  KEY `idx_qrtz_t_j` (`sched_name`,`job_name`,`job_group`),
  KEY `idx_qrtz_t_jg` (`sched_name`,`job_group`),
  KEY `idx_qrtz_t_c` (`sched_name`,`calendar_name`),
  KEY `idx_qrtz_t_g` (`sched_name`,`trigger_group`),
  KEY `idx_qrtz_t_state` (`sched_name`,`trigger_state`),
  KEY `idx_qrtz_t_n_state` (`sched_name`,`trigger_name`,`trigger_group`,`trigger_state`),
  KEY `idx_qrtz_t_n_g_state` (`sched_name`,`trigger_group`,`trigger_state`),
  KEY `idx_qrtz_t_next_fire_time` (`sched_name`,`next_fire_time`),
  KEY `idx_qrtz_t_nft_st` (`sched_name`,`trigger_state`,`next_fire_time`),
  KEY `idx_qrtz_t_nft_misfire` (`sched_name`,`misfire_instr`,`next_fire_time`),
  KEY `idx_qrtz_t_nft_st_misfire` (`sched_name`,`misfire_instr`,`next_fire_time`,`trigger_state`),
  KEY `idx_qrtz_t_nft_st_misfire_grp` (`sched_name`,`misfire_instr`,`next_fire_time`,`trigger_group`,`trigger_state`),
  CONSTRAINT `t_qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `t_qrtz_job_details` (`sched_name`, `job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='存储已配置的 Trigger 的信息  ';
