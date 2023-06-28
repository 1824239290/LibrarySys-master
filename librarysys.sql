/*
SQLyog 企业版 - MySQL GUI v8.14 
MySQL - 5.5.28 : Database - librarysys
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`librarysys` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `librarysys`;

/*Table structure for table `banben` */

DROP TABLE IF EXISTS `banben`;

CREATE TABLE `banben` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pro_name` varchar(16) NOT NULL COMMENT '项目名称',
  `now` varchar(255) DEFAULT NULL COMMENT '当前版本',
  `tese` varchar(255) NOT NULL COMMENT '主要特色',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='版本信息';

/*Data for the table `banben` */

insert  into `banben`(`id`,`pro_name`,`now`,`tese`) values (1,'图书管理系统','v1.0.1','零门槛 / 响应式 / 清爽 / 极简');

/*Table structure for table `book` */

DROP TABLE IF EXISTS `book`;

CREATE TABLE `book` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '图书ID',
  `book_name` varchar(16) NOT NULL COMMENT '图书名称',
  `author` varchar(16) NOT NULL COMMENT '图书作者',
  `press` varchar(16) NOT NULL COMMENT '出版社',
  `book_number` varchar(6) NOT NULL COMMENT '书籍编号',
  `book_description` varchar(255) NOT NULL COMMENT '书籍简介',
  `book_language` varchar(10) NOT NULL COMMENT '书籍语言',
  `book_price` double NOT NULL COMMENT '书籍价格',
  `publication_time` date NOT NULL COMMENT '出版日期',
  `type_name` varchar(16) NOT NULL COMMENT '书籍类型',
  `book_status` int(3) NOT NULL DEFAULT '0' COMMENT '书籍状态:0-未借出1-已借出2-延迟还书3-丢失图书',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='图书表';

/*Data for the table `book` */

insert  into `book`(`id`,`book_name`,`author`,`press`,`book_number`,`book_description`,`book_language`,`book_price`,`publication_time`,`type_name`,`book_status`) values (4,'钢铁是怎样炼成的','尼古拉·奥斯特洛夫斯基','人民教育出版社','96b030','小说通过记叙保尔·柯察金的成长道路告诉人们，一个人只有在革命的艰难困苦中战胜敌人也战胜自己，只有在把自己的追求和祖国、人民的利益联系在一起的时候，才会创造出奇迹，才会成长为钢铁战士。','中文',62,'2020-02-03','马克思主义著作',0),(5,'中华上下五千年','墨人','中国戏剧出版社出版','00baad','我们伟大的祖国有非常悠久的历史。按照古代的传统说法，从传说中的黄帝到现在，大约有五千多年的历史，通常叫做“上下五千年”。期间流传有许多的神话，历史故事等。故有书《中华上下五千年》。','中文',10,'2020-02-01','社会科学',0),(6,'西游记','吴承恩','人民文学出版社','f7f864','《西游记》是中国神魔小说的经典之作，达到了古代长篇浪漫主义小说的巅峰，与《三国演义》《水浒传》《红楼梦》并称为中国古典四大名著。《西游记》自问世以来在民间广为流传，各式各样的版本层出不穷。明代刊本有六种，清代刊本、抄本也有七种，典籍所记已佚版本十三种。鸦片战争以后，大量中国古典文学作品被译为西文，《西游记》渐渐传入欧美，被译为英、法、德、意、西、手语、世（世界语）、斯（斯瓦西里语）、俄、捷、罗、波、日、朝、越等语言。','中文',32,'1999-03-13','社会科学',0);

/*Table structure for table `booktype` */

DROP TABLE IF EXISTS `booktype`;

CREATE TABLE `booktype` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '图书类型ID',
  `type_name` varchar(16) NOT NULL COMMENT '图书类型名称',
  `remark` varchar(255) DEFAULT NULL COMMENT '图书类型备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='图书类型表';

/*Data for the table `booktype` */

insert  into `booktype`(`id`,`type_name`,`remark`) values (9,'哲学','哲学'),(10,'马克思主义著作','马克思主义著作'),(11,'社会科学','社会科学'),(12,'自然科学','自然科学'),(13,'综合性图书','综合性图书');

/*Table structure for table `borrowbook` */

DROP TABLE IF EXISTS `borrowbook`;

CREATE TABLE `borrowbook` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '借阅ID',
  `book_id` int(11) NOT NULL COMMENT '图书id',
  `library_card` varchar(6) NOT NULL COMMENT '借书卡号',
  `reader_id` int(11) NOT NULL COMMENT '读者id',
  `borrow_time` datetime NOT NULL COMMENT '借阅时间',
  `return_book_time` datetime DEFAULT NULL COMMENT '还书时间',
  `return_book_type` int(3) DEFAULT NULL COMMENT '还书类型:0-正常还书1-延迟还书2-破损还书3-丢失图书4-在借中',
  `remark` varchar(255) DEFAULT NULL COMMENT '异常还书备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='借阅表';

/*Data for the table `borrowbook` */

insert  into `borrowbook`(`id`,`book_id`,`library_card`,`reader_id`,`borrow_time`,`return_book_time`,`return_book_type`,`remark`) values (4,5,'0b485c',16,'2022-02-18 23:43:04','2022-02-19 17:11:58',0,NULL),(7,6,'0b485c',16,'2022-02-19 17:28:21','2022-02-19 17:42:43',0,NULL),(12,5,'0b485c',16,'2022-02-21 16:32:20','2022-02-21 19:43:04',0,'轻微损坏'),(13,5,'0b485c',16,'2022-02-21 16:34:07','2022-02-21 19:44:31',0,'不小心丢失图书'),(14,4,'0b485c',16,'2022-02-21 21:18:48','2022-02-21 22:31:45',0,'123'),(15,6,'0b485c',16,'2022-02-21 21:52:44','2022-02-21 22:31:45',0,'123'),(16,4,'0b485c',16,'2022-02-21 22:35:42','2022-02-21 22:36:23',0,'不小心丢失图书'),(17,4,'2f8ef7',13,'2022-02-21 23:23:55','2022-02-21 23:33:45',2,'xiao '),(18,5,'2f8ef7',13,'2022-02-21 23:24:53','2022-02-21 23:36:20',0,'diushi'),(19,6,'2f8ef7',13,'2022-02-21 23:25:01','2022-02-21 23:36:11',0,'wu');

/*Table structure for table `count` */

DROP TABLE IF EXISTS `count`;

CREATE TABLE `count` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_count` varchar(16) NOT NULL COMMENT '用户总计',
  `book_count` varchar(16) NOT NULL COMMENT '图书总计',
  `type_count` varchar(16) NOT NULL COMMENT '图书分类总计',
  `record_count` varchar(16) NOT NULL COMMENT '借阅记录总计',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='报表总计';

/*Data for the table `count` */

insert  into `count`(`id`,`user_count`,`book_count`,`type_count`,`record_count`) values (1,'11','3','5','10');

/*Table structure for table `liuyan` */

DROP TABLE IF EXISTS `liuyan`;

CREATE TABLE `liuyan` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `main` varchar(16) NOT NULL COMMENT '作者心语',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='作者心语';

/*Data for the table `liuyan` */

insert  into `liuyan`(`id`,`main`) values (1,'本管理系统基于ssm+layui');

/*Table structure for table `notice` */

DROP TABLE IF EXISTS `notice`;

CREATE TABLE `notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `title` varchar(50) NOT NULL COMMENT '公告标题',
  `content` varchar(255) NOT NULL COMMENT '公告内容',
  `creator` varchar(6) NOT NULL COMMENT '公告创建人',
  `create_time` datetime NOT NULL COMMENT '公告创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='公告表';

/*Data for the table `notice` */

insert  into `notice`(`id`,`title`,`content`,`creator`,`create_time`) values (2,'测试','测试','小草','2022-02-15 02:18:10'),(3,'测试1','测试','小草','2022-02-15 02:18:35'),(4,'测试2','测试','小草','2022-02-15 02:18:47'),(5,'测试3','测试','小草','2022-02-15 02:19:01'),(6,'测试4','测试','小草','2022-02-15 02:19:18'),(7,'测试5','测试','小草','2022-02-15 02:19:24'),(8,'香港增4285例确诊1.2万人等候入院','据香港“大公文汇全媒体”报道，香港疫情严峻，确诊数字连日创新高，15日增1619例确诊病例，全属本地感染，另有初步确诊病例约5400例。消息指，16日新增4285宗确诊病例再创新高，另有超过7000例初步确诊病例。\n医管局总行政经理（病人安全及风险管理）何婉霞在疫情记者会上公布，香港本地新增9例染疫死亡个案，另有17名患者病危。\n港媒称，由于连续多日确诊破千，香港隔离设施和医疗系统全线告急。截至15日，在社区等候送院的初步确诊及确诊者人数高达12000人。','wqewq','2022-02-16 19:42:56');

/*Table structure for table `psd` */

DROP TABLE IF EXISTS `psd`;

CREATE TABLE `psd` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `old` varchar(16) NOT NULL COMMENT '旧密码',
  `new` varchar(16) NOT NULL COMMENT '新密码',
  `sure` varchar(16) NOT NULL COMMENT '再次输入新密码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='修改密码';

/*Data for the table `psd` */

insert  into `psd`(`id`,`old`,`new`,`sure`) values (1,'123456','654321','654321');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(6) NOT NULL COMMENT '用户名',
  `password` varchar(16) NOT NULL COMMENT '密码',
  `user_type` int(3) NOT NULL DEFAULT '2' COMMENT '用户类型：0-超级管理员1-普通管理员2-读者',
  `real_name` varchar(4) NOT NULL COMMENT '真实姓名',
  `sex` varchar(2) NOT NULL COMMENT '性别',
  `birthday` date NOT NULL COMMENT '出生日期',
  `address` varchar(50) DEFAULT NULL COMMENT '地址',
  `tel` varchar(11) DEFAULT NULL COMMENT '电话',
  `email` varchar(30) DEFAULT NULL COMMENT '邮箱',
  `create_date` datetime NOT NULL COMMENT '注册日期',
  `library_card` varchar(6) NOT NULL COMMENT '借书卡号',
  `user_status` int(3) NOT NULL DEFAULT '1' COMMENT '用户状态：0-冻结1-正常',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户表';

/*Data for the table `user` */

insert  into `user`(`id`,`username`,`password`,`user_type`,`real_name`,`sex`,`birthday`,`address`,`tel`,`email`,`create_date`,`library_card`,`user_status`) values (12,'test','test123456',1,'测试','男','2022-02-08','','','test@qq.com','2022-02-08 01:20:20','4b233c',1),(13,'test1','test123',2,'测试','男','2022-02-08','我也不几道啊','12312312312','123@qq.com','2022-02-08 16:04:25','2f8ef7',1),(14,'wqewq','123456',1,'测试','男','2022-02-19','','','','2022-02-08 17:19:49','48f787',1),(15,'asdsaa','asdsadsadsadsads',1,'测试','男','2022-02-18','','','','2022-02-09 18:13:06','59da59',1),(16,'小草','xiaocao123',0,'小草嘻哈','男','1992-02-05','','','','2022-02-09 18:18:53','0b485c',1),(17,'test2','123456',2,'测试','男','2022-02-10','','12312312312','123@qq.com','2022-02-10 21:18:53','8771a8',1),(18,'test3','test123',2,'测试','男','2022-02-10','dsadsadsa','12312312312','123@qq.com','2022-02-10 23:19:10','3989cd',1),(19,'test4','test123',2,'测试','男','2022-02-11','','','','2022-02-11 16:19:32','b75e32',1),(20,'test5','123456',2,'测试','男','2022-02-18','','','','2022-02-13 21:23:41','284042',0),(21,'test6','123456',2,'测试','男','2022-02-18','','','','2022-02-14 23:25:04','189ed3',1),(26,'test7','123456',2,'测试','男','1989-02-18','','','','2022-02-15 17:34:44','7b6eb6',1),(28,'wht','wht123',2,'小吴','女','2022-05-02','','','','2022-05-15 14:21:29','3cd310',1);

/*Table structure for table `userphoto` */

DROP TABLE IF EXISTS `userphoto`;

CREATE TABLE `userphoto` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户头像ID',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `picture` varchar(255) DEFAULT NULL COMMENT '用户头像',
  `upload_time` datetime DEFAULT NULL COMMENT '上传头像时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户头像表';

/*Data for the table `userphoto` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
