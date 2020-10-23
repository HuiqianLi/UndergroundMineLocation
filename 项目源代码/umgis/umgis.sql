/*
Navicat MySQL Data Transfer

Source Server         : test
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : test

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2020-10-21 22:02:02
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for area
-- ----------------------------
DROP TABLE IF EXISTS `area`;
CREATE TABLE `area` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `position1` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `position2` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `position3` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `area` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `note` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of area
-- ----------------------------
INSERT INTO `area` VALUES ('1', '(-23.71, -571.00, -248.28)', '(25.31, -574.32, -252.96)', '(-8.57, -574.96, -206.00)', '1077.18平方米', '2020-09-30 20:55:12', '面积11');
INSERT INTO `area` VALUES ('2', '(-24.20, -370.47, -233.04)', '(25.80, -365.77, -230.13)', '(-20.66, -360.30, -222.28)', '361.041平方米', '2020-10-03 16:26:42', 'test123');
INSERT INTO `area` VALUES ('3', '(25.28, -384.26, -239.52)', '(23.01, -384.18, -239.54)', '(25.18, -384.25, -246.11)', '7.49803平方米', '2020-10-21 18:18:08', '测试3');
INSERT INTO `area` VALUES ('4', '(24.90, -588.97, -232.88)', '(24.75, -615.57, -232.75)', '(21.82, -593.31, -253.55)', '278.224平方米', '2020-10-21 18:18:34', 'test4');
INSERT INTO `area` VALUES ('5', '(-22.33, -488.54, -232.57)', '(-22.29, -489.72, -229.50)', '(-22.21, -556.31, -232.35)', '103.911平方米', '2020-10-21 18:18:47', 'test5');
INSERT INTO `area` VALUES ('6', '(-20.76, -520.19, -222.49)', '(22.27, -519.77, -222.09)', '(-23.15, -525.13, -253.96)', '684.833平方米', '2020-10-21 18:19:02', '');

-- ----------------------------
-- Table structure for distance
-- ----------------------------
DROP TABLE IF EXISTS `distance`;
CREATE TABLE `distance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `position1` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `position2` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `distance` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `note` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of distance
-- ----------------------------
INSERT INTO `distance` VALUES ('1', '(-22.56, -434.84, -253.93)', '(-22.41, -434.15, -230.07)', '23.8664米', '2020-09-17 21:08:18', null);
INSERT INTO `distance` VALUES ('2', '(-23.10, -577.22, -221.92)', '(25.31, -565.95, -242.62)', '53.8417米', '2020-10-18 20:54:12', 'test5');
INSERT INTO `distance` VALUES ('3', '(-3.80, -370.96, -252.87)', '(-3.85, -552.17, -252.02)', '181.215米', '2020-10-21 18:08:31', 'test4');
INSERT INTO `distance` VALUES ('4', '(24.25, -433.98, -254.07)', '(-22.43, -434.87, -253.67)', '46.6971米', '2020-10-21 18:09:47', null);
INSERT INTO `distance` VALUES ('5', '(22.37, -445.80, -222.72)', '(-22.56, -437.31, -232.69)', '46.7913米', '2020-10-21 18:09:58', null);
INSERT INTO `distance` VALUES ('6', '(-22.26, -671.72, -253.74)', '(-24.20, -690.59, -232.49)', '28.4799米', '2020-10-21 18:10:10', '距离3');
INSERT INTO `distance` VALUES ('7', '(5.52, -568.40, -211.20)', '(5.97, -792.15, -207.18)', '223.792米', '2020-10-21 18:10:18', null);
INSERT INTO `distance` VALUES ('8', '(25.80, -571.42, -229.69)', '(-23.26, -847.84, -232.99)', '280.761米', '2020-10-21 18:10:32', '距离1');
INSERT INTO `distance` VALUES ('9', '(-22.48, -423.68, -232.68)', '(-22.38, -490.85, -232.62)', '67.1631米', '2020-10-21 19:24:07', null);

-- ----------------------------
-- Table structure for mark
-- ----------------------------
DROP TABLE IF EXISTS `mark`;
CREATE TABLE `mark` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `point` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `note` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of mark
-- ----------------------------
INSERT INTO `mark` VALUES ('42', 'M76', '(24.196, -489.028, -240.937)', 'test1', '2020-10-21 18:22:08');
INSERT INTO `mark` VALUES ('43', 'M2', '(-21.2334, -445.47, -224.996)', 'test2', '2020-10-21 18:22:16');
INSERT INTO `mark` VALUES ('44', 'M89', '(23.8955, -468.137, -229.812)', '需要维修管道', '2020-10-21 18:23:13');
INSERT INTO `mark` VALUES ('45', 'M41', '(-21.2345, -338.088, -242.359)', '小柜子3号', '2020-10-21 18:27:34');
INSERT INTO `mark` VALUES ('46', 'M93', '(-0.142446, -403.39, -207.263)', 'test3', '2020-10-21 18:27:50');
INSERT INTO `mark` VALUES ('47', 'M39', '(2.28845, -668.601, -206.913)', 'test8', '2020-10-21 18:28:04');
INSERT INTO `mark` VALUES ('48', 'M97', '(-22.551, -434.901, -237.042)', '管道122号', '2020-10-21 19:25:01');

-- ----------------------------
-- Table structure for t_doc
-- ----------------------------
DROP TABLE IF EXISTS `t_doc`;
CREATE TABLE `t_doc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `content` varchar(2000) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `pub_time` datetime DEFAULT NULL,
  `operator` varchar(255) DEFAULT NULL,
  `mod_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_doc
-- ----------------------------
INSERT INTO `t_doc` VALUES ('4', '萤石矿粉尘治理措施', '在萤石矿的坑探作业等各环节中，都会产生粉尘（萤石矿、岩石等细微固体颗粒的总称），也简称为矿尘，在坑探作业过程中生量大，面积极广。粉尘所导致的尘肺疾病约20 余万人，且年均死亡约为2500人。此外,粉尘有极强的爆炸性，发生时间迅速且危害力极强，对萤石矿井下工人的生命安全构成严重威胁，对粉尘进行有针对性地治理，减少和避免粉尘的爆炸事故，具有重要的现实意义。\r\n以下是萤石矿常用的粉尘治理措施：\r\n（1）通风除尘 在萤石矿坑探作业中需要保障矿并具备有良好的通风性能，对于井下的粉尘浓度也需要进行必要的稀释处理，这样才能够让粉尘及时的排出矿井。但是在通风除尘过程中，其除尘效果还会受到粉尘密度、形状、风流以及空气湿度等诸多因素的影响，如果风速过低，会导致一些粗粒矿尘难以及时排除，而在风速过大的情况下，则容易导致掘进空间的粉尘浓度增加。\r\n（2）作业面洒水  作业面洒水主要是通过将水洒到作业面表层，这样能够让表层的含水量提升，在爆破作业过程中也就能够有效避免粉尘的出现，因此在现阶段的萤石矿企业除尘工作中得到了广泛的应用。萤石矿企业需要在结合自身实际开采倩况的基础上，进行作业面洒水的合理选择，借此获得良好的粉尘防治效果。\r\n（3）净化风流技术 现有的净化风流技术主要包含有空气幕隔尘技术以及水幕净化技术两种模式，其中前者能够通过条行风中吹出的条缝形空气射流来让污染物跟空气两者得到有效的隔离，在此基础上保障工作区的卫生条件，对于工作面的粉尘扩散情况也能够起到良好的控制效果。而水幕净化技术则是在井巷顶部跟两边进行水管的敷设工作，然后在水管上面进行多个喷雾器的安装，通过喷洒水雾的模式来对巷道中的粉尘量进行全面有效的控制。\r\n（4）萤石矿地面坑探作业系统的粉尘治理工艺 坑探作业环节和产尘点繁多，在整个坑探作业过程中的每一环节都产生大量的粉尘，如果粉尘严重超标，不仅为粉尘燃烧与爆炸事故埋下了安全隐患，并且威胁环境问题。因此，萤石矿企业必须重视粉尘治理工艺，在治理工作中，首先要采用喷雾抑尘法。\r\n（6）泡沫除尘技术 泡沫除尘技术是以高压空气促使发泡剂产生无空隙湿润泡沫体覆盖尘源，使刚产生的粉尘得以浸润、附着、沉积，失去飞扬能力，整体除尘效果好，一般可达90%以上，尤其对5mm以下的呼吸性粉尘，除尘率可达80%以上。泡沫除尘能够无空隙地覆盖尘源，从根本上阻止粉尘向外扩散，液体形成泡沫后，总体积和表面积大幅度增大，增加了与粉尘的碰撞效率，泡沫的液膜中含有特制的发泡剂，能大幅度降低水的表面张力，迅速增加粉尘被湿润的速度。泡沫具有很好的粘性，粉尘和泡沫接触后会迅速被泡沫粘附，抑尘效果明显，比传统除尘方法有绝对优势。在现场利用原有的防尘系统和压风系统，安装工作量小，成本低，它将使萤石矿现场环境质量得到根本性改变，在萤石矿有良好的推广价值。\r\n', '规章制度', '2020-05-15 03:33:23', '28', '2020-05-15 03:33:23');
INSERT INTO `t_doc` VALUES ('5', '国家矿山安全监察局职能配置、内设机构和人员编制规定 ', '第一条　为了贯彻党中央对煤矿和非煤矿山（以下统称矿山）安全监管监察工作的有关要求，规范国家矿山安全监察局的职能配置、内设机构和人员编制，推进机构、职能、权限、程序、责任法定化，根据《中国共产党机构编制工作条例》，制定本规定。\r\n第二条　国家矿山安全监察局是应急管理部管理的国家局，为副部级。\r\n第三条　本规定确定的职能配置、内设机构和人员编制等，是国家矿山安全监察局履行职责、配备人员、规范权力以及经费核定的基本依据。\r\n第四条　国家矿山安全监察局负责贯彻落实党中央关于矿山安全监管监察工作的方针政策和决策部署，在履行职责过程中坚持和加强党对矿山安全监管监察工作的集中统一领导。主要职责是：\r\n（一）拟订矿山安全生产（含地质勘探，下同）方面的政策、规划、标准，起草相关法律法规草案、部门规章草案并监督实施。\r\n（二）负责国家矿山安全监察工作。监督检查地方政府矿山安全监管工作。组织实施矿山安全生产抽查检查，对发现的重大事故隐患采取现场处置措施，向地方政府提出改善和加强矿山安全监管工作的意见和建议，督促开展重大隐患整改和复查。\r\n（三）指导矿山安全监管工作。制定矿山安全准入、监管执法、风险分级管控和事故隐患排查治理等政策措施并监督实施，指导地方矿山安全监督管理部门编制和完善执法计划，提升地方矿山安全监管水平和执法能力。依法对煤矿企业贯彻执行安全生产法律法规情况进行监督检查，对煤矿企业安全生产条件、设备设施安全情况进行监管执法，对发现的违法违规问题实施行政处罚、监督整改落实并承担相应责任。\r\n（四）负责统筹矿山安全生产监管执法保障体系建设，制定监管监察能力建设规划，完善技术支撑体系，推进监管执法制度化、规范化、信息化。\r\n（五）参与编制矿山安全生产应急预案，指导和组织协调煤矿事故应急救援工作，参与非煤矿山事故应急救援工作。依法组织或参与煤矿生产安全事故和特别重大非煤矿山生产安全事故调查处理，监督事故查处落实情况。负责统计分析和发布矿山安全生产信息和事故情况。\r\n（六）负责矿山安全生产宣传教育，组织开展矿山安全科学技术研究及推广应用工作。指导矿山企业安全生产基础工作，会同有关部门指导和监督煤矿生产能力核定工作。对煤矿安全技术改造和瓦斯综合治理与利用项目提出审核意见。\r\n（七）完成党中央、国务院交办的其他任务。\r\n（八）职能转变。国家矿山安全监察局要进一步完善“国家监察、地方监管、企业负责”的矿山安全监管监察体制。以防范遏制重特大矿山生产安全事故为重点，坚持安全第一、预防为主、综合治理的方针，加强对地方政府落实矿山安全属地监管责任的监督检查，严密层级治理和行业治理、政府治理、社会治理相结合的安全生产治理体系，着力防范化解区域性、系统性矿山安全风险。推动地方矿山安全监督管理部门强化监管执法，依法严厉查处违法违规行为，督促企业落实安全生产主体责任，推动企业建立健全自我约束、持续改进的内生机制。强化矿山安全监管能力建设，建立健全监管执法人员资格管理制度，加强教育培训，推进安全科技创新，提升信息化建设和应用水平，进一步提高执法队伍能力和素质。将煤矿安全生产许可、建设工程安全设施设计审查和竣工验收核查、检验检测机构认证、相关人员培训等事项移交给地方政府。', '规章制度', '2020-05-20 03:33:27', '28', '2020-05-20 03:33:27');
INSERT INTO `t_doc` VALUES ('6', '关于做好近期煤矿瓦斯治理工作的通知 ', '各产煤省、自治区、直辖市及新疆生产建设兵团煤矿安全监管部门、煤炭行业管理部门，各省级煤矿安全监察局，司法部监狱管理局，有关中央企业：\r\n瓦斯是煤矿安全的“第一杀手”。瓦斯治理是煤矿安全生产工作的重中之重，是防范和遏制煤矿较大以上事故的重要举措。今年以来，全国煤矿共发生较大事故6起、死亡29人，其中瓦斯事故2起、死亡14人，分别占33.3%、48.3%。2起瓦斯事故各死亡7人，是今年死亡人数最多的事故。此外，今年还发生了1起瓦斯燃烧事故，造成3人重伤。\r\n四季度历来瓦斯事故多发。2016年先后发生了重庆永川区金山沟煤矿“10•31”和内蒙古赤峰市宝马矿业“12•3”特别重大瓦斯爆炸事故，共造成65人死亡。2019年9月至年底相继发生5起重大或较大瓦斯事故，事故起数和死亡人数分别占全年较大以上瓦斯事故的35.7%和46.5%。为进一步做好瓦斯防治工作，有效防范和坚决遏制重特大事故，现就做好近期煤矿瓦斯治理工作通知如下。\r\n一、切实抓好“一通三防”专项监察发现问题的整改工作\r\n各级煤矿安全监管监察部门要用好今年“一通三防”专项监察成果，紧盯专项监察发现的各类问题和隐患，建立整改清单，逐一对账销号；实施分类精准执法，立足查大系统、控大风险、治大隐患、防大事故，对瓦斯灾害严重、瓦斯治理薄弱、安全风险较高的煤矿开展重点监督检查，发现问题坚决查处。煤矿安全监管部门要对重大隐患治理情况进行挂牌督办，做到责任到人、措施到位、整改彻底。各驻地监察分局要对整改结果进行现场核查。\r\n二、坚决打击非法违规生产建设行为\r\n非法违规生产是导致煤矿瓦斯事故多发的重要原因。各级煤矿安全监管监察部门要紧密结合煤矿安全专项整治三年行动，持续开展“打非治违”，重点打击瓦斯等级鉴定弄虚作假、煤层突出危险性检验验证指标作假、违规通风、通风系统不完善和超通风能力组织生产等行为；坚决打击巷道式采煤等非正规开采、超层越界开采、违规开采保安煤柱、以假图纸和假密闭隐瞒采掘地点，不安装安全监控系统或监控数据作假等违法违规行为；坚决查处瓦斯超限不停止作业、不停电撒人，出现突出预兆不停电撒人等行为，以及以“过渡期”“回撤期”名义违规生产、停工停产矿井违规复工复产、技改矿井不按设计方案和批准工期施工、采掘工程违规承包、以包代管等严重违法违规行为。要高度关注列入淘汰关闭计划的煤矿，警惕待关闭矿井“最后的疯狂”。要综合运用处罚、通报、约谈、问责、联合惩戒、“黑名单”管理、行刑衔接等措施，依法严厉追责问责。\r\n三、严格落实区域瓦斯治理措施\r\n煤矿企业要坚持问题导向，选择合理的技术路线，加强瓦斯治理人才队伍建设，保证安全投入，确保灾害治理工程到位有效。要持续推进瓦斯“零超限”、煤层“零突出”目标管理，强化瓦斯源头治理，健全完善“通风可靠、抽采达标、监控有效、管理到位”的瓦斯综合治理体系，发现瓦斯超限的必须查明原因、整改到位。要加强煤矿瓦斯地质基础工作，严格落实“两个四位一体”综合防突措施，持续加大瓦斯抽采力度，严格执行《煤矿瓦斯抽采达标暂行规定》，做到预抽达标、抽采达标。有冲击地压风险的高瓦斯、煤与瓦斯突出矿井要强化煤层瓦斯抽采工作，有效防范冲击地压和采空区顶板垮落造成瓦斯大量涌出，发生爆炸事故。要强化通风管理，加强局部通风机和风门等通风构筑物管理，防止风流短路和局部停风导致瓦斯集聚。要加强采空区安全管理，防范采空区煤炭自燃和瓦斯事故。要强化现场管理，狠抓瓦斯治理综合措施落实的现场管理，加强重点部位、关键环节的检查巡视和视频监视，及时发现和消除安全隐患。各级煤矿安全监管监察部门要加大监管监察执法力度，强化对矿井通风、瓦斯管理和突出矿井防突措施落实等情况的监督检查，推动煤矿企业瓦斯治理措施落实到位。\r\n四、扎实做好安全监控系统升级改造工作\r\n煤矿企业要按照《煤矿安全监控系统升级改造技术方案》要求，于2020年底前完成监控系统升级改造任务。各级煤矿安全监管监察部门要督促煤矿企业完成监控系统升级改造工作，对不能按时完成升级改造任务的或者监控系统不能正常运行的矿井，要依法采取必要的措施。煤矿企业要切实用好安全监控系统，确保运行可靠、监控有效；提高瓦斯超限预警分析能力，健全完善瓦斯分析制度，认真分析瓦斯超限原因，对瓦斯超限等严肃追责问责，确保严格落实各项防范措施。\r\n请各省级煤矿安全监察局迅速将本通知精神传达至辖区内所有煤矿企业。\r\n国家煤矿安监局办公室\r\n2020年9月23日', '通知公告', '2020-04-20 12:23:33', '29', '2020-05-20 03:33:27');
INSERT INTO `t_doc` VALUES ('7', '国家煤矿安监局关于煤矿“一通三防”专项监察情况的通报 ', '各产煤省、自治区、直辖市及新疆生产建设兵团煤矿安全监管部门，各省级煤矿安全监察局：\r\n现将2020年度煤矿“一通三防”专项监察开展情况通报如下：\r\n一、专项监察开展情况\r\n煤矿“一通三防”专项监察开展以来，各级煤矿安全监管监察部门共开展煤矿安全检查3191矿次，实现正常生产建设矿井全覆盖，下达执法文书27851份，查处一般隐患44240条、重大隐患277条，责令停止使用设备29602台（套）、局部停止作业1958处、停产整顿煤矿170处，暂扣煤矿安全生产许可证191处，实施联合惩戒6矿次，公开曝光111矿次，行政罚款38656.8万元，推动“一通三防”事故继续下降，有力地促进了煤矿安全生产形势持续稳定好转。今年上半年，全国共发生瓦斯事故1起、死亡7人，与去年同期相比减少10起、20人；未发生煤尘事故，与去年同期相比减少1起、21人；未发生火灾事故（与去年同期持平）。\r\n（一）精心组织，落实责任，为“一通三防”专项监察提供组织保障。一是及时部署。25个省级煤矿安监局（以下简称省局）及时按照国家煤矿安监局要求对专项监察进行部署，其中山西、内蒙古、辽宁、河南、广西、贵州、云南、甘肃、新疆等省局与省级煤矿安全监管部门联合部署。二是加强组织领导。河北、山西、内蒙古、江西、湖南、广西、陕西、甘肃、新疆、兵团等省局成立了领导小组。三是细化方案。各地结合实际细化工作方案。陕西煤矿安监局按“一矿一组”原则，将276处煤矿分解到45个检查组。河北煤矿安监局、河北省应急厅等省级部门负责检查灾害严重的高瓦斯、突出矿井。黑龙江煤矿安监局负责对龙煤集团的高瓦斯、突出矿井进行检查。\r\n（二）多措并举，扎实推动专项监察深入开展。一是督促煤矿企业开展自查自改。贵州、陕西等省局制定了自查自改报告模板，指导煤矿企业开展自查自改。福建煤矿安监局要求各矿每月开展1次自查自改并报监管监察部门。二是加强风险研判，突出监察重点。河南煤矿安监局提前对正常生产建设矿井开展分析研判，提高专项监察的精准性。山东、江苏等省局组织开展预防性技术监察，为专项监察奠定基础。三是开展远程监察。新冠肺炎疫情发生后，各地努力克服疫情影响，充分利用信息化手段开展远程监察。河北、内蒙古、辽宁、吉林、黑龙江、江苏、安徽、山东、河南、重庆、四川、贵州、云南等省局出台办法，将远程监察制度化、规范化、常态化。四是发挥行业专家作用。内蒙古、黑龙江、安徽、福建、江西、陕西、甘肃、青海、宁夏、兵团等省局聘请专家参与专项监察。五是加强对煤矿企业的服务指导。宁夏煤矿安监局坚持每次监察执法都让煤矿企业做到“三个明白”，即明白是什么（问题描述）、为什么（法律法规）、怎么改（处理决定）。贵州煤矿安监局制定了防突专项设计、瓦斯抽采设计等11个编制指南。六是开展联合执法，形成合力。河北、内蒙古、辽宁、黑龙江、福建、江西、湖南、重庆、四川、贵州等省局与监管部门建立协调机制，开展联合执法，形成合力。七是统筹推进。山西、辽宁、江西、山东、湖南、贵州、新疆等省局利用专项监察推进煤矿“三大系统”联网升级改造。\r\n（三）坚持严格执法，严厉打击违法违规行为。专项监察开展以来，各级煤矿安全监管监察部门依法严厉打击了一批非法违法行为，起到了震慑作用。河北、山西、内蒙古、黑龙江、河南、四川、贵州、云南、陕西、新疆等专项监察行政处罚额均超过1000万元，其中山西省行政处罚达1.3亿元。云南煤矿安监局对存在重大事故隐患的2处煤矿进行公开裁定，以案说法、以会代训。贵州煤矿安监局针对设计单位审核把关不严、防突设计不合理等问题，约谈设计单位主要负责人及相关责任人员。河北煤矿安监局对邢台煤矿擅自甩掉闭锁保护冒险作业的违法违规行为罚款处215万元。内蒙古煤矿安监局对存在2条重大事故隐患的青春塔煤矿，责令停产整顿，暂扣安全生产许可证，处罚款327万元，并进行了通报曝光。陕西、湖南、内蒙古、甘肃、青海、宁夏、云南等省局共对有关责任人员实施问责900人次。辽宁煤矿安监局向企业下达《安全生产责任落实督办通知书》19份，督促企业实施追责301人次。', '行业新闻', '2020-05-20 03:33:27', '29', '2020-05-20 03:33:27');
INSERT INTO `t_doc` VALUES ('8', 'test2', '', '规章制度', '2020-05-20 03:33:27', '29', '2020-05-20 03:33:27');
INSERT INTO `t_doc` VALUES ('9', 'test3', '', '规章制度', '2020-04-20 12:23:33', '1', '2020-06-25 03:39:42');
INSERT INTO `t_doc` VALUES ('12', 'test4', ' ', '通知公告', '2020-04-20 12:23:33', '1', '2020-06-25 03:38:49');
INSERT INTO `t_doc` VALUES ('13', 'test5', ' ', '行业新闻', '2020-05-20 03:33:27', '1', '2020-06-25 03:38:32');
INSERT INTO `t_doc` VALUES ('29', 'test6', ' ', '行业新闻', '2020-06-24 08:22:50', '1', '2020-06-25 15:29:43');
INSERT INTO `t_doc` VALUES ('31', 'test11', ' ', '行业新闻', '2020-06-25 19:46:10', '1', '2020-06-25 19:46:10');

-- ----------------------------
-- Table structure for t_emp
-- ----------------------------
DROP TABLE IF EXISTS `t_emp`;
CREATE TABLE `t_emp` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  `password` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `sex` int(5) DEFAULT NULL,
  `mobile` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  `orgno` int(10) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `email` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  `attenceno` int(10) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `education` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `orgname` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '机构名',
  `techgrade` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `post` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `duty` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_emp
-- ----------------------------
INSERT INTO `t_emp` VALUES ('1', 'admin', 'admin', '0', '13480742222', '1', '2020-05-21', '11111232123@qq.com', null, '2020-06-22 00:00:00', '硕士', '管理部门', '高级工程师', 'post', 'xxxx', 'xxxx');
INSERT INTO `t_emp` VALUES ('2', 'admin1', '000', '1', '13480743758', '2', '2020-05-12', null, null, null, '硕士', '管理部门', '高级工程师', 'post', 'xxx', 'xxxx');
INSERT INTO `t_emp` VALUES ('28', 'admin2', '000', '0', '13480743751', '1', '2020-05-22', null, null, null, '硕士', '管理部门', '高级工程师', 'post', 'xxx', 'xxxx');
INSERT INTO `t_emp` VALUES ('29', 'admin3', '000', '1', '13480743758', '4', '2020-05-05', null, null, null, '本科', '管理部门', '高级工程师', 'post', 'xxx', 'xxxx');
INSERT INTO `t_emp` VALUES ('31', 'admin4', '000', '1', '13480743758', '5', '2020-05-06', null, null, null, '博士', '管理部门', null, 'post', 'xxx', 'xxxx');
INSERT INTO `t_emp` VALUES ('35', 'admin5', '000', '1', '13480743758', '6', '2020-05-13', null, null, null, '本科', '管理部门', null, null, null, null);
INSERT INTO `t_emp` VALUES ('41', 'admin6', '000', '0', '13480743758', '7', '2020-05-20', null, null, null, '博士', '管理部门', null, null, null, null);
INSERT INTO `t_emp` VALUES ('43', 'other1', '000', '0', '47888888888', '1', null, null, null, null, '本科', '测绘部门', null, null, null, null);
INSERT INTO `t_emp` VALUES ('46', 'other2', '000', '0', '13480743758', '1', '1998-10-05', 'lili@qf.com', null, null, '本科', '测绘部门', null, null, null, null);
INSERT INTO `t_emp` VALUES ('47', 'other3', '000', '1', '13480741234', '6', '1996-06-05', 'admin@qf.com', null, '2020-06-22 00:00:00', '硕士', '测绘部门', null, null, null, null);
INSERT INTO `t_emp` VALUES ('48', 'other4', '000', '0', '15489525478', '7', '1996-06-05', null, null, '2020-06-22 00:00:00', '博士', '测绘部门', null, null, null, null);

-- ----------------------------
-- Table structure for t_menu
-- ----------------------------
DROP TABLE IF EXISTS `t_menu`;
CREATE TABLE `t_menu` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  `url` varchar(40) COLLATE utf8_bin DEFAULT NULL,
  `type` int(10) DEFAULT NULL,
  `parent_menu_id` int(10) DEFAULT NULL,
  `p_code` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  `ddesc` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of t_menu
-- ----------------------------
INSERT INTO `t_menu` VALUES ('1', '总菜单', null, '2', '0', 'all:*', '总菜单');
INSERT INTO `t_menu` VALUES ('2', '员工管理', null, '2', '1', 'employee', '员工管理');
INSERT INTO `t_menu` VALUES ('3', '员工信息管理', null, '1', '2', 'emp:manage', '信息浏览');
INSERT INTO `t_menu` VALUES ('5', '个人信息维护', '', '1', '2', 'emp:my', '统计分析');
INSERT INTO `t_menu` VALUES ('9', '文档管理', null, '2', '1', 'document', '文档管理');
INSERT INTO `t_menu` VALUES ('10', '文档批量删除', null, '1', '9', 'doc:batchdel', '文档类型');
INSERT INTO `t_menu` VALUES ('11', '文档删除', null, '1', '9', 'doc:del', '管理文档');
INSERT INTO `t_menu` VALUES ('12', '文档编辑', null, '1', '9', 'doc:edit', '薪资管理');
INSERT INTO `t_menu` VALUES ('13', '测量管理', null, '2', '1', 'measure', '测量管理');
INSERT INTO `t_menu` VALUES ('14', '测量距离列表', null, '1', '13', 'mea:distance', '薪资项设置');
INSERT INTO `t_menu` VALUES ('15', '测量面积列表', null, '1', '13', 'mea:area', '参数设置');
INSERT INTO `t_menu` VALUES ('16', '标记列表', null, '1', '13', 'mea:mark', '标记管理');
INSERT INTO `t_menu` VALUES ('30', '系统管理', null, '2', '1', 'system', '系统管理');
INSERT INTO `t_menu` VALUES ('31', '角色管理', 'roleController/getRoleList', '1', '30', 'sys:role', '角色管理');
INSERT INTO `t_menu` VALUES ('32', '授权管理', 'authController/toAuthPage', '1', '30', 'sys:auth', '授权管理');

-- ----------------------------
-- Table structure for t_role
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  `role_desc` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  `role_state` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of t_role
-- ----------------------------
INSERT INTO `t_role` VALUES ('1', '管理员', '拥有系统所有权限', '1');
INSERT INTO `t_role` VALUES ('2', '二级管理员', '拥有文档管理，员工管理权限', '1');
INSERT INTO `t_role` VALUES ('3', '普通员工', '普通员工', '1');

-- ----------------------------
-- Table structure for t_role_emp
-- ----------------------------
DROP TABLE IF EXISTS `t_role_emp`;
CREATE TABLE `t_role_emp` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `uid` int(10) DEFAULT NULL,
  `rid` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of t_role_emp
-- ----------------------------
INSERT INTO `t_role_emp` VALUES ('1', '1', '1');
INSERT INTO `t_role_emp` VALUES ('3', '28', '3');
INSERT INTO `t_role_emp` VALUES ('19', '29', '4');
INSERT INTO `t_role_emp` VALUES ('20', '31', '5');
INSERT INTO `t_role_emp` VALUES ('21', '35', '6');
INSERT INTO `t_role_emp` VALUES ('22', '41', '7');
INSERT INTO `t_role_emp` VALUES ('23', '42', '8');
INSERT INTO `t_role_emp` VALUES ('25', '45', '9');
INSERT INTO `t_role_emp` VALUES ('32', '43', '9');
INSERT INTO `t_role_emp` VALUES ('35', '46', '7');
INSERT INTO `t_role_emp` VALUES ('36', '47', '7');
INSERT INTO `t_role_emp` VALUES ('37', '2', '2');
INSERT INTO `t_role_emp` VALUES ('38', '48', '2');
INSERT INTO `t_role_emp` VALUES ('39', '43', '2');

-- ----------------------------
-- Table structure for t_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `t_role_menu`;
CREATE TABLE `t_role_menu` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `rid` int(10) DEFAULT NULL,
  `mid` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=266 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of t_role_menu
-- ----------------------------
INSERT INTO `t_role_menu` VALUES ('150', '1', '1');
INSERT INTO `t_role_menu` VALUES ('151', '1', '2');
INSERT INTO `t_role_menu` VALUES ('152', '1', '3');
INSERT INTO `t_role_menu` VALUES ('153', '1', '4');
INSERT INTO `t_role_menu` VALUES ('154', '1', '5');
INSERT INTO `t_role_menu` VALUES ('155', '1', '6');
INSERT INTO `t_role_menu` VALUES ('156', '1', '7');
INSERT INTO `t_role_menu` VALUES ('157', '1', '8');
INSERT INTO `t_role_menu` VALUES ('158', '1', '9');
INSERT INTO `t_role_menu` VALUES ('159', '1', '10');
INSERT INTO `t_role_menu` VALUES ('160', '1', '11');
INSERT INTO `t_role_menu` VALUES ('161', '1', '12');
INSERT INTO `t_role_menu` VALUES ('162', '1', '13');
INSERT INTO `t_role_menu` VALUES ('163', '1', '14');
INSERT INTO `t_role_menu` VALUES ('164', '1', '15');
INSERT INTO `t_role_menu` VALUES ('165', '1', '16');
INSERT INTO `t_role_menu` VALUES ('166', '1', '17');
INSERT INTO `t_role_menu` VALUES ('167', '1', '18');
INSERT INTO `t_role_menu` VALUES ('168', '1', '19');
INSERT INTO `t_role_menu` VALUES ('169', '1', '20');
INSERT INTO `t_role_menu` VALUES ('170', '1', '22');
INSERT INTO `t_role_menu` VALUES ('171', '1', '23');
INSERT INTO `t_role_menu` VALUES ('172', '1', '24');
INSERT INTO `t_role_menu` VALUES ('173', '1', '25');
INSERT INTO `t_role_menu` VALUES ('174', '1', '26');
INSERT INTO `t_role_menu` VALUES ('175', '1', '27');
INSERT INTO `t_role_menu` VALUES ('176', '1', '28');
INSERT INTO `t_role_menu` VALUES ('177', '1', '30');
INSERT INTO `t_role_menu` VALUES ('178', '1', '31');
INSERT INTO `t_role_menu` VALUES ('179', '1', '32');
INSERT INTO `t_role_menu` VALUES ('180', '1', '33');
INSERT INTO `t_role_menu` VALUES ('197', '4', '1');
INSERT INTO `t_role_menu` VALUES ('198', '4', '2');
INSERT INTO `t_role_menu` VALUES ('199', '4', '3');
INSERT INTO `t_role_menu` VALUES ('200', '4', '4');
INSERT INTO `t_role_menu` VALUES ('201', '4', '5');
INSERT INTO `t_role_menu` VALUES ('202', '4', '6');
INSERT INTO `t_role_menu` VALUES ('203', '4', '7');
INSERT INTO `t_role_menu` VALUES ('204', '4', '8');
INSERT INTO `t_role_menu` VALUES ('205', '4', '9');
INSERT INTO `t_role_menu` VALUES ('206', '4', '10');
INSERT INTO `t_role_menu` VALUES ('207', '4', '11');
INSERT INTO `t_role_menu` VALUES ('208', '4', '12');
INSERT INTO `t_role_menu` VALUES ('209', '4', '13');
INSERT INTO `t_role_menu` VALUES ('210', '4', '17');
INSERT INTO `t_role_menu` VALUES ('211', '4', '25');
INSERT INTO `t_role_menu` VALUES ('212', '4', '26');
INSERT INTO `t_role_menu` VALUES ('213', '4', '27');
INSERT INTO `t_role_menu` VALUES ('214', '4', '28');
INSERT INTO `t_role_menu` VALUES ('225', '5', '1');
INSERT INTO `t_role_menu` VALUES ('226', '5', '2');
INSERT INTO `t_role_menu` VALUES ('227', '5', '5');
INSERT INTO `t_role_menu` VALUES ('228', '5', '13');
INSERT INTO `t_role_menu` VALUES ('229', '5', '14');
INSERT INTO `t_role_menu` VALUES ('230', '5', '15');
INSERT INTO `t_role_menu` VALUES ('231', '5', '16');
INSERT INTO `t_role_menu` VALUES ('232', '5', '17');
INSERT INTO `t_role_menu` VALUES ('233', '5', '25');
INSERT INTO `t_role_menu` VALUES ('234', '7', '1');
INSERT INTO `t_role_menu` VALUES ('235', '7', '2');
INSERT INTO `t_role_menu` VALUES ('236', '7', '5');
INSERT INTO `t_role_menu` VALUES ('237', '7', '23');
INSERT INTO `t_role_menu` VALUES ('238', '7', '24');
INSERT INTO `t_role_menu` VALUES ('239', '7', '25');
INSERT INTO `t_role_menu` VALUES ('240', '8', '1');
INSERT INTO `t_role_menu` VALUES ('241', '8', '2');
INSERT INTO `t_role_menu` VALUES ('242', '8', '5');
INSERT INTO `t_role_menu` VALUES ('243', '8', '13');
INSERT INTO `t_role_menu` VALUES ('244', '8', '17');
INSERT INTO `t_role_menu` VALUES ('245', '8', '23');
INSERT INTO `t_role_menu` VALUES ('246', '8', '25');
INSERT INTO `t_role_menu` VALUES ('247', '3', '1');
INSERT INTO `t_role_menu` VALUES ('248', '3', '2');
INSERT INTO `t_role_menu` VALUES ('249', '3', '5');
INSERT INTO `t_role_menu` VALUES ('250', '3', '13');
INSERT INTO `t_role_menu` VALUES ('251', '3', '14');
INSERT INTO `t_role_menu` VALUES ('252', '3', '15');
INSERT INTO `t_role_menu` VALUES ('253', '3', '16');
INSERT INTO `t_role_menu` VALUES ('254', '2', '1');
INSERT INTO `t_role_menu` VALUES ('255', '2', '2');
INSERT INTO `t_role_menu` VALUES ('256', '2', '3');
INSERT INTO `t_role_menu` VALUES ('257', '2', '5');
INSERT INTO `t_role_menu` VALUES ('258', '2', '9');
INSERT INTO `t_role_menu` VALUES ('259', '2', '10');
INSERT INTO `t_role_menu` VALUES ('260', '2', '11');
INSERT INTO `t_role_menu` VALUES ('261', '2', '12');
INSERT INTO `t_role_menu` VALUES ('262', '2', '13');
INSERT INTO `t_role_menu` VALUES ('263', '2', '14');
INSERT INTO `t_role_menu` VALUES ('264', '2', '15');
INSERT INTO `t_role_menu` VALUES ('265', '2', '16');
