-- phpMyAdmin SQL Dump
-- version 3.5.8.1deb1
-- http://www.phpmyadmin.net
--
-- 主機: localhost
-- 產生日期: 2014 年 06 月 01 日 00:39
-- 伺服器版本: 5.5.34-0ubuntu0.13.04.1
-- PHP 版本: 5.4.9-4ubuntu2.4

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 資料庫: `u2730`
--
DROP DATABASE `u2730`;
CREATE DATABASE `u2730` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `u2730`;

-- --------------------------------------------------------

--
-- 表的結構 `actions`
--

CREATE TABLE IF NOT EXISTS `actions` (
  `action_id` int(11) NOT NULL AUTO_INCREMENT,
  `action` varchar(75) NOT NULL,
  `qualifiers` text NOT NULL,
  `response` varchar(75) NOT NULL,
  `response_vars` text NOT NULL,
  `active` tinyint(4) NOT NULL,
  PRIMARY KEY (`action_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores user defined actions triggered by certain events' AUTO_INCREMENT=2 ;

--
-- 轉存資料表中的資料 `actions`
--

INSERT INTO `actions` (`action_id`, `action`, `qualifiers`, `response`, `response_vars`, `active`) VALUES
(1, 'report_add', 'a:7:{s:4:"user";s:1:"0";s:8:"location";s:8:"specific";s:8:"geometry";a:1:{i:0;s:249:"{"geometry":"POLYGON((121.03741929687952 25.87203298539387,118.55450914062702 23.29479492177476,120.88361070312496 20.892643130624467,122.68536851563051 24.199832641251724,122.53155992187598 25.77313988610665,121.03741929687952 25.87203298539387))"}";}s:7:"keyword";s:0:"";s:17:"on_specific_count";s:0:"";s:28:"on_specific_count_collective";s:1:"0";s:13:"between_times";i:0;}', 'approve_report', 'a:1:{s:6:"verify";s:1:"0";}', 1);

-- --------------------------------------------------------

--
-- 表的結構 `actions_log`
--

CREATE TABLE IF NOT EXISTS `actions_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `action_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `time` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `action_id` (`action_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores a log of triggered actions' AUTO_INCREMENT=1 ;

--
-- 轉存資料表中的資料 `actions_log`
--

INSERT INTO `actions_log` (`id`, `action_id`, `user_id`, `time`) VALUES
(1, 1, 0, 1400684947),
(2, 1, 0, 1400685116),
(3, 1, 0, 1400685465),
(4, 1, 0, 1400685737),
(5, 1, 2, 1400685801),
(6, 1, 0, 1401006301),
(7, 1, 0, 1401011778);

-- --------------------------------------------------------

--
-- 表的結構 `alert`
--

CREATE TABLE IF NOT EXISTS `alert` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned DEFAULT '0',
  `alert_type` tinyint(4) NOT NULL COMMENT '1 - MOBILE, 2 - EMAIL',
  `alert_recipient` varchar(200) DEFAULT NULL,
  `alert_code` varchar(30) DEFAULT NULL,
  `alert_confirmed` tinyint(4) NOT NULL DEFAULT '0',
  `alert_lat` varchar(150) DEFAULT NULL,
  `alert_lon` varchar(150) DEFAULT NULL,
  `alert_radius` tinyint(4) NOT NULL DEFAULT '20',
  `alert_ip` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_alert_code` (`alert_code`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores alerts subscribers information' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的結構 `alert_category`
--

CREATE TABLE IF NOT EXISTS `alert_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alert_id` bigint(20) unsigned DEFAULT NULL,
  `category_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `alert_id` (`alert_id`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores subscriber alert categories' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的結構 `alert_sent`
--

CREATE TABLE IF NOT EXISTS `alert_sent` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `incident_id` bigint(20) unsigned NOT NULL,
  `alert_id` bigint(20) unsigned NOT NULL,
  `alert_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `incident_id` (`incident_id`),
  KEY `alert_id` (`alert_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores a log of alerts sent out to subscribers' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的結構 `api_banned`
--

CREATE TABLE IF NOT EXISTS `api_banned` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `banned_ipaddress` varchar(50) NOT NULL,
  `banned_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='For logging banned API IP addresses' AUTO_INCREMENT=8 ;

-- --------------------------------------------------------

--
-- 表的結構 `api_log`
--

CREATE TABLE IF NOT EXISTS `api_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `api_task` varchar(10) NOT NULL,
  `api_parameters` varchar(100) NOT NULL,
  `api_records` tinyint(11) NOT NULL,
  `api_ipaddress` varchar(50) NOT NULL,
  `api_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='For logging API activities' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的結構 `api_settings`
--

CREATE TABLE IF NOT EXISTS `api_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `default_record_limit` int(11) NOT NULL DEFAULT '20',
  `max_record_limit` int(11) DEFAULT NULL,
  `max_requests_per_ip_address` int(11) DEFAULT NULL,
  `max_requests_quota_basis` int(11) DEFAULT NULL,
  `modification_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='For storing API logging settings' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的結構 `badge`
--

CREATE TABLE IF NOT EXISTS `badge` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores description of badges to be assigned' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的結構 `badge_users`
--

CREATE TABLE IF NOT EXISTS `badge_users` (
  `user_id` int(11) unsigned NOT NULL,
  `badge_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`badge_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores assigned badge information';

-- --------------------------------------------------------

--
-- 表的結構 `category`
--

CREATE TABLE IF NOT EXISTS `category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `locale` varchar(10) NOT NULL DEFAULT 'en_US',
  `category_position` tinyint(4) NOT NULL DEFAULT '0',
  `category_title` varchar(255) DEFAULT NULL,
  `category_description` text,
  `category_color` varchar(20) DEFAULT NULL,
  `category_image` varchar(255) DEFAULT NULL,
  `category_image_thumb` varchar(255) DEFAULT NULL,
  `category_visible` tinyint(4) NOT NULL DEFAULT '1',
  `category_trusted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `category_visible` (`category_visible`),
  KEY `parent_id` (`parent_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Holds information about categories defined for a deployment' AUTO_INCREMENT=23 ;

--
-- 轉存資料表中的資料 `category`
--

INSERT INTO `category` (`id`, `parent_id`, `locale`, `category_position`, `category_title`, `category_description`, `category_color`, `category_image`, `category_image_thumb`, `category_visible`, `category_trusted`) VALUES
(1, 0, 'en_US', 0, '高度分類', 'Category 1', '9900CC', NULL, NULL, 1, 0),
(2, 0, 'en_US', 3, '區域分類', 'Category 2', '3300FF', NULL, NULL, 1, 0),
(3, 0, 'en_US', 6, '儀器分類', 'Category 3', '663300', NULL, NULL, 1, 0),
(4, 0, 'en_US', 14, 'Trusted Reports', 'Reports from trusted reporters', '339900', NULL, NULL, 0, 1),
(6, 1, 'zh_TW', 1, '地板上', '地板上', '00e1ff', NULL, NULL, 1, 0),
(7, 1, 'zh_TW', 2, '一公尺', '一公尺', '00ff33', NULL, NULL, 1, 0),
(8, 2, 'zh_TW', 4, '於室內', '於室內', 'fff582', NULL, NULL, 1, 0),
(9, 2, 'zh_TW', 5, '於室外', '於室外', 'ff7247', NULL, NULL, 1, 0),
(10, 3, 'zh_TW', 7, 'Inspector Alert', 'Inspector Alert', '085aff', NULL, NULL, 1, 0),
(11, 3, 'zh_TW', 8, 'AIR COUNTER_S', 'AIR COUNTER_S', 'f53676', NULL, NULL, 1, 0),
(12, 3, 'zh_TW', 9, 'Ecotest MKS-05 TERRA-P', 'Ecotest MKS-05 TERRA-P', '632963', NULL, NULL, 1, 0),
(13, 3, 'zh_TW', 10, '儀器D', '儀器D', '008051', NULL, NULL, 1, 0),
(14, 0, 'zh_TW', 11, '人員分類', '人員分類', '79ff5e', NULL, NULL, 1, 0),
(15, 14, 'zh_TW', 12, '專業人士', '專業人士', '003e54', NULL, NULL, 1, 0),
(16, 14, 'zh_TW', 13, '一般人士', '一般人士', 'ffd500', NULL, NULL, 1, 0);

-- --------------------------------------------------------

--
-- 表的結構 `category_lang`
--

CREATE TABLE IF NOT EXISTS `category_lang` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(11) unsigned NOT NULL,
  `locale` varchar(10) DEFAULT NULL,
  `category_title` varchar(255) DEFAULT NULL,
  `category_description` text,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Holds translations for category titles and descriptions' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的結構 `city`
--

CREATE TABLE IF NOT EXISTS `city` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `country_id` int(11) DEFAULT NULL,
  `city` varchar(200) DEFAULT NULL,
  `city_lat` varchar(150) DEFAULT NULL,
  `city_lon` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `country_id` (`country_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores cities of countries retrieved by user.' AUTO_INCREMENT=18 ;

--
-- 轉存資料表中的資料 `city`
--

INSERT INTO `city` (`id`, `country_id`, `city`, `city_lat`, `city_lon`) VALUES
(1, 115, 'Nairobi', '-1.283253', '36.817245'),
(2, 115, 'Nakuru', '-0.283300', '36.066600'),
(3, 115, 'Mombasa', '-4.050520', '39.667169'),
(4, 115, 'Meru', '0.050003', '37.650006'),
(5, 115, 'Malindi', '-3.216599', '40.116593'),
(6, 115, 'Machakos', '-1.521522', '37.268234'),
(7, 115, 'Kitale', '1.018076', '35.000236'),
(8, 115, 'Kisii', '-0.669412', '34.767794'),
(9, 115, 'Kibwezi', '-2.410098', '37.965766'),
(10, 115, 'Kericho', '-0.366600', '35.283300'),
(11, 115, 'Kakamega', '0.283300', '34.750000'),
(12, 115, 'Garissa', '-0.466597', '39.633292'),
(13, 115, 'Nyeri', '-0.419296', '36.951701'),
(14, 115, 'Thika', '-1.045014', '37.088144'),
(15, 115, 'Dadaab', '0.055918', '40.305419'),
(16, 115, 'Kisumu', '-0.102911', '34.754176'),
(17, 115, 'Eldoret', '0.519833', '35.271548');

-- --------------------------------------------------------

--
-- 表的結構 `cluster`
--

CREATE TABLE IF NOT EXISTS `cluster` (
  `id` int(11) NOT NULL,
  `location_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `latitude_min` double NOT NULL,
  `longitude_min` double NOT NULL,
  `latitude_max` double NOT NULL,
  `longitude_max` double NOT NULL,
  `child_count` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `left_side` int(11) NOT NULL,
  `right_side` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  `incident_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `category_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `location_id` (`location_id`),
  KEY `incident_id` (`incident_id`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores information used for clustering of reports on the map.';

-- --------------------------------------------------------

--
-- 表的結構 `comment`
--

CREATE TABLE IF NOT EXISTS `comment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `incident_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` int(11) unsigned DEFAULT '0',
  `comment_author` varchar(100) DEFAULT NULL,
  `comment_email` varchar(120) DEFAULT NULL,
  `comment_description` text,
  `comment_ip` varchar(100) DEFAULT NULL,
  `comment_spam` tinyint(4) NOT NULL DEFAULT '0',
  `comment_active` tinyint(4) NOT NULL DEFAULT '0',
  `comment_date` datetime DEFAULT NULL,
  `comment_date_gmt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `incident_id` (`incident_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores comments made on reports' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的結構 `country`
--

CREATE TABLE IF NOT EXISTS `country` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `iso` varchar(10) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `capital` varchar(100) DEFAULT NULL,
  `cities` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores a list of all countries and their capital cities' AUTO_INCREMENT=250 ;

--
-- 轉存資料表中的資料 `country`
--

INSERT INTO `country` (`id`, `iso`, `country`, `capital`, `cities`) VALUES
(1, 'AD', 'Andorra', 'Andorra la Vella', 0),
(2, 'AE', 'United Arab Emirates', 'Abu Dhabi', 0),
(3, 'AF', 'Afghanistan', 'Kabul', 0),
(4, 'AG', 'Antigua and Barbuda', 'St. John''s', 0),
(5, 'AI', 'Anguilla', 'The Valley', 0),
(6, 'AL', 'Albania', 'Tirana', 0),
(7, 'AM', 'Armenia', 'Yerevan', 0),
(8, 'AN', 'Netherlands Antilles', 'Willemstad', 0),
(9, 'AO', 'Angola', 'Luanda', 0),
(10, 'AQ', 'Antarctica', '', 0),
(11, 'AR', 'Argentina', 'Buenos Aires', 0),
(12, 'AS', 'American Samoa', 'Pago Pago', 0),
(13, 'AT', 'Austria', 'Vienna', 0),
(14, 'AU', 'Australia', 'Canberra', 0),
(15, 'AW', 'Aruba', 'Oranjestad', 0),
(16, 'AX', 'Aland Islands', 'Mariehamn', 0),
(17, 'AZ', 'Azerbaijan', 'Baku', 0),
(18, 'BA', 'Bosnia and Herzegovina', 'Sarajevo', 0),
(19, 'BB', 'Barbados', 'Bridgetown', 0),
(20, 'BD', 'Bangladesh', 'Dhaka', 0),
(21, 'BE', 'Belgium', 'Brussels', 0),
(22, 'BF', 'Burkina Faso', 'Ouagadougou', 0),
(23, 'BG', 'Bulgaria', 'Sofia', 0),
(24, 'BH', 'Bahrain', 'Manama', 0),
(25, 'BI', 'Burundi', 'Bujumbura', 0),
(26, 'BJ', 'Benin', 'Porto-Novo', 0),
(27, 'BL', 'Saint BarthÃ©lemy', 'Gustavia', 0),
(28, 'BM', 'Bermuda', 'Hamilton', 0),
(29, 'BN', 'Brunei', 'Bandar Seri Begawan', 0),
(30, 'BO', 'Bolivia', 'La Paz', 0),
(31, 'BR', 'Brazil', 'BrasÃ­lia', 0),
(32, 'BS', 'Bahamas', 'Nassau', 0),
(33, 'BT', 'Bhutan', 'Thimphu', 0),
(34, 'BV', 'Bouvet Island', '', 0),
(35, 'BW', 'Botswana', 'Gaborone', 0),
(36, 'BY', 'Belarus', 'Minsk', 0),
(37, 'BZ', 'Belize', 'Belmopan', 0),
(38, 'CA', 'Canada', 'Ottawa', 0),
(39, 'CC', 'Cocos Islands', 'West Island', 0),
(40, 'CD', 'Democratic Republic of the Congo', 'Kinshasa', 0),
(41, 'CF', 'Central African Republic', 'Bangui', 0),
(42, 'CG', 'Congo Brazzavile', 'Brazzaville', 0),
(43, 'CH', 'Switzerland', 'Berne', 0),
(44, 'CI', 'Ivory Coast', 'Yamoussoukro', 0),
(45, 'CK', 'Cook Islands', 'Avarua', 0),
(46, 'CL', 'Chile', 'Santiago', 0),
(47, 'CM', 'Cameroon', 'YaoundÃ©', 0),
(48, 'CN', 'China', 'Beijing', 0),
(49, 'CO', 'Colombia', 'BogotÃ¡', 0),
(50, 'CR', 'Costa Rica', 'San JosÃ©', 0),
(51, 'CS', 'Serbia and Montenegro', 'Belgrade', 0),
(52, 'CU', 'Cuba', 'Havana', 0),
(53, 'CV', 'Cape Verde', 'Praia', 0),
(54, 'CX', 'Christmas Island', 'Flying Fish Cove', 0),
(55, 'CY', 'Cyprus', 'Nicosia', 0),
(56, 'CZ', 'Czech Republic', 'Prague', 0),
(57, 'DE', 'Germany', 'Berlin', 0),
(58, 'DJ', 'Djibouti', 'Djibouti', 0),
(59, 'DK', 'Denmark', 'Copenhagen', 0),
(60, 'DM', 'Dominica', 'Roseau', 0),
(61, 'DO', 'Dominican Republic', 'Santo Domingo', 0),
(62, 'DZ', 'Algeria', 'Algiers', 0),
(63, 'EC', 'Ecuador', 'Quito', 0),
(64, 'EE', 'Estonia', 'Tallinn', 0),
(65, 'EG', 'Egypt', 'Cairo', 0),
(66, 'EH', 'Western Sahara', 'El-Aaiun', 0),
(67, 'ER', 'Eritrea', 'Asmara', 0),
(68, 'ES', 'Spain', 'Madrid', 0),
(69, 'ET', 'Ethiopia', 'Addis Ababa', 0),
(70, 'FI', 'Finland', 'Helsinki', 0),
(71, 'FJ', 'Fiji', 'Suva', 0),
(72, 'FK', 'Falkland Islands', 'Stanley', 0),
(73, 'FM', 'Micronesia', 'Palikir', 0),
(74, 'FO', 'Faroe Islands', 'TÃ³rshavn', 0),
(75, 'FR', 'France', 'Paris', 0),
(76, 'GA', 'Gabon', 'Libreville', 0),
(77, 'GB', 'United Kingdom', 'London', 0),
(78, 'GD', 'Grenada', 'St. George''s', 0),
(79, 'GE', 'Georgia', 'Tbilisi', 0),
(80, 'GF', 'French Guiana', 'Cayenne', 0),
(81, 'GG', 'Guernsey', 'St Peter Port', 0),
(82, 'GH', 'Ghana', 'Accra', 0),
(83, 'GI', 'Gibraltar', 'Gibraltar', 0),
(84, 'GL', 'Greenland', 'Nuuk', 0),
(85, 'GM', 'Gambia', 'Banjul', 0),
(86, 'GN', 'Guinea', 'Conakry', 0),
(87, 'GP', 'Guadeloupe', 'Basse-Terre', 0),
(88, 'GQ', 'Equatorial Guinea', 'Malabo', 0),
(89, 'GR', 'Greece', 'Athens', 0),
(90, 'GS', 'South Georgia and the South Sandwich Islands', 'Grytviken', 0),
(91, 'GT', 'Guatemala', 'Guatemala City', 0),
(92, 'GU', 'Guam', 'HagÃ¥tÃ±a', 0),
(93, 'GW', 'Guinea-Bissau', 'Bissau', 0),
(94, 'GY', 'Guyana', 'Georgetown', 0),
(95, 'HK', 'Hong Kong', 'Hong Kong', 0),
(96, 'HM', 'Heard Island and McDonald Islands', '', 0),
(97, 'HN', 'Honduras', 'Tegucigalpa', 0),
(98, 'HR', 'Croatia', 'Zagreb', 0),
(99, 'HT', 'Haiti', 'Port-au-Prince', 0),
(100, 'HU', 'Hungary', 'Budapest', 0),
(101, 'ID', 'Indonesia', 'Jakarta', 0),
(102, 'IE', 'Ireland', 'Dublin', 0),
(103, 'IL', 'Israel', 'Jerusalem', 0),
(104, 'IM', 'Isle of Man', 'Douglas, Isle of Man', 0),
(105, 'IN', 'India', 'New Delhi', 0),
(106, 'IO', 'British Indian Ocean Territory', 'Diego Garcia', 0),
(107, 'IQ', 'Iraq', 'Baghdad', 0),
(108, 'IR', 'Iran', 'Tehran', 0),
(109, 'IS', 'Iceland', 'ReykjavÃ­k', 0),
(110, 'IT', 'Italy', 'Rome', 0),
(111, 'JE', 'Jersey', 'Saint Helier', 0),
(112, 'JM', 'Jamaica', 'Kingston', 0),
(113, 'JO', 'Jordan', 'Amman', 0),
(114, 'JP', 'Japan', 'Tokyo', 0),
(115, 'KE', 'Kenya', 'Nairobi', 17),
(116, 'KG', 'Kyrgyzstan', 'Bishkek', 0),
(117, 'KH', 'Cambodia', 'Phnom Penh', 0),
(118, 'KI', 'Kiribati', 'South Tarawa', 0),
(119, 'KM', 'Comoros', 'Moroni', 0),
(120, 'KN', 'Saint Kitts and Nevis', 'Basseterre', 0),
(121, 'KP', 'North Korea', 'Pyongyang', 0),
(122, 'KR', 'South Korea', 'Seoul', 0),
(123, 'KW', 'Kuwait', 'Kuwait City', 0),
(124, 'KY', 'Cayman Islands', 'George Town', 0),
(125, 'KZ', 'Kazakhstan', 'Astana', 0),
(126, 'LA', 'Laos', 'Vientiane', 0),
(127, 'LB', 'Lebanon', 'Beirut', 0),
(128, 'LC', 'Saint Lucia', 'Castries', 0),
(129, 'LI', 'Liechtenstein', 'Vaduz', 0),
(130, 'LK', 'Sri Lanka', 'Colombo', 0),
(131, 'LR', 'Liberia', 'Monrovia', 0),
(132, 'LS', 'Lesotho', 'Maseru', 0),
(133, 'LT', 'Lithuania', 'Vilnius', 0),
(134, 'LU', 'Luxembourg', 'Luxembourg', 0),
(135, 'LV', 'Latvia', 'Riga', 0),
(136, 'LY', 'Libya', 'Tripolis', 0),
(137, 'MA', 'Morocco', 'Rabat', 0),
(138, 'MC', 'Monaco', 'Monaco', 0),
(139, 'MD', 'Moldova', 'Chi_in_u', 0),
(140, 'ME', 'Montenegro', 'Podgorica', 0),
(141, 'MF', 'Saint Martin', 'Marigot', 0),
(142, 'MG', 'Madagascar', 'Antananarivo', 0),
(143, 'MH', 'Marshall Islands', 'Uliga', 0),
(144, 'MK', 'Macedonia', 'Skopje', 0),
(145, 'ML', 'Mali', 'Bamako', 0),
(146, 'MM', 'Myanmar', 'Yangon', 0),
(147, 'MN', 'Mongolia', 'Ulan Bator', 0),
(148, 'MO', 'Macao', 'Macao', 0),
(149, 'MP', 'Northern Mariana Islands', 'Saipan', 0),
(150, 'MQ', 'Martinique', 'Fort-de-France', 0),
(151, 'MR', 'Mauritania', 'Nouakchott', 0),
(152, 'MS', 'Montserrat', 'Plymouth', 0),
(153, 'MT', 'Malta', 'Valletta', 0),
(154, 'MU', 'Mauritius', 'Port Louis', 0),
(155, 'MV', 'Maldives', 'MalÃ©', 0),
(156, 'MW', 'Malawi', 'Lilongwe', 0),
(157, 'MX', 'Mexico', 'Mexico City', 0),
(158, 'MY', 'Malaysia', 'Kuala Lumpur', 0),
(159, 'MZ', 'Mozambique', 'Maputo', 0),
(160, 'NA', 'Namibia', 'Windhoek', 0),
(161, 'NC', 'New Caledonia', 'NoumÃ©a', 0),
(162, 'NE', 'Niger', 'Niamey', 0),
(163, 'NF', 'Norfolk Island', 'Kingston', 0),
(164, 'NG', 'Nigeria', 'Abuja', 0),
(165, 'NI', 'Nicaragua', 'Managua', 0),
(166, 'NL', 'Netherlands', 'Amsterdam', 0),
(167, 'NO', 'Norway', 'Oslo', 0),
(168, 'NP', 'Nepal', 'Kathmandu', 0),
(169, 'NR', 'Nauru', 'Yaren', 0),
(170, 'NU', 'Niue', 'Alofi', 0),
(171, 'NZ', 'New Zealand', 'Wellington', 0),
(172, 'OM', 'Oman', 'Muscat', 0),
(173, 'PA', 'Panama', 'Panama City', 0),
(174, 'PE', 'Peru', 'Lima', 0),
(175, 'PF', 'French Polynesia', 'Papeete', 0),
(176, 'PG', 'Papua New Guinea', 'Port Moresby', 0),
(177, 'PH', 'Philippines', 'Manila', 0),
(178, 'PK', 'Pakistan', 'Islamabad', 0),
(179, 'PL', 'Poland', 'Warsaw', 0),
(180, 'PM', 'Saint Pierre and Miquelon', 'Saint-Pierre', 0),
(181, 'PN', 'Pitcairn', 'Adamstown', 0),
(182, 'PR', 'Puerto Rico', 'San Juan', 0),
(183, 'PS', 'Palestinian Territory', 'East Jerusalem', 0),
(184, 'PT', 'Portugal', 'Lisbon', 0),
(185, 'PW', 'Palau', 'Koror', 0),
(186, 'PY', 'Paraguay', 'AsunciÃ³n', 0),
(187, 'QA', 'Qatar', 'Doha', 0),
(188, 'RE', 'Reunion', 'Saint-Denis', 0),
(189, 'RO', 'Romania', 'Bucharest', 0),
(190, 'RS', 'Serbia', 'Belgrade', 0),
(191, 'RU', 'Russia', 'Moscow', 0),
(192, 'RW', 'Rwanda', 'Kigali', 0),
(193, 'SA', 'Saudi Arabia', 'Riyadh', 0),
(194, 'SB', 'Solomon Islands', 'Honiara', 0),
(195, 'SC', 'Seychelles', 'Victoria', 0),
(196, 'SD', 'Sudan', 'Khartoum', 0),
(197, 'SE', 'Sweden', 'Stockholm', 0),
(198, 'SG', 'Singapore', 'Singapur', 0),
(199, 'SH', 'Saint Helena', 'Jamestown', 0),
(200, 'SI', 'Slovenia', 'Ljubljana', 0),
(201, 'SJ', 'Svalbard and Jan Mayen', 'Longyearbyen', 0),
(202, 'SK', 'Slovakia', 'Bratislava', 0),
(203, 'SL', 'Sierra Leone', 'Freetown', 0),
(204, 'SM', 'San Marino', 'San Marino', 0),
(205, 'SN', 'Senegal', 'Dakar', 0),
(206, 'SO', 'Somalia', 'Mogadishu', 0),
(207, 'SR', 'Suriname', 'Paramaribo', 0),
(208, 'ST', 'Sao Tome and Principe', 'SÃ£o TomÃ©', 0),
(209, 'SV', 'El Salvador', 'San Salvador', 0),
(210, 'SY', 'Syria', 'Damascus', 0),
(211, 'SZ', 'Swaziland', 'Mbabane', 0),
(212, 'TC', 'Turks and Caicos Islands', 'Cockburn Town', 0),
(213, 'TD', 'Chad', 'N''Djamena', 0),
(214, 'TF', 'French Southern Territories', 'Martin-de-ViviÃ¨s', 0),
(215, 'TG', 'Togo', 'LomÃ©', 0),
(216, 'TH', 'Thailand', 'Bangkok', 0),
(217, 'TJ', 'Tajikistan', 'Dushanbe', 0),
(218, 'TK', 'Tokelau', '', 0),
(219, 'TL', 'East Timor', 'Dili', 0),
(220, 'TM', 'Turkmenistan', 'Ashgabat', 0),
(221, 'TN', 'Tunisia', 'Tunis', 0),
(222, 'TO', 'Tonga', 'Nuku''alofa', 0),
(223, 'TR', 'Turkey', 'Ankara', 0),
(224, 'TT', 'Trinidad and Tobago', 'Port of Spain', 0),
(225, 'TV', 'Tuvalu', 'Vaiaku', 0),
(226, 'TW', 'Taiwan', 'Taipei', 0),
(227, 'TZ', 'Tanzania', 'Dar es Salaam', 0),
(228, 'UA', 'Ukraine', 'Kiev', 0),
(229, 'UG', 'Uganda', 'Kampala', 0),
(230, 'UM', 'United States Minor Outlying Islands', '', 0),
(231, 'US', 'United States', 'Washington', 0),
(232, 'UY', 'Uruguay', 'Montevideo', 0),
(233, 'UZ', 'Uzbekistan', 'Tashkent', 0),
(234, 'VA', 'Vatican', 'Vatican City', 0),
(235, 'VC', 'Saint Vincent and the Grenadines', 'Kingstown', 0),
(236, 'VE', 'Venezuela', 'Caracas', 0),
(237, 'VG', 'British Virgin Islands', 'Road Town', 0),
(238, 'VI', 'U.S. Virgin Islands', 'Charlotte Amalie', 0),
(239, 'VN', 'Vietnam', 'Hanoi', 0),
(240, 'VU', 'Vanuatu', 'Port Vila', 0),
(241, 'WF', 'Wallis and Futuna', 'MatÃ¢''Utu', 0),
(242, 'WS', 'Samoa', 'Apia', 0),
(243, 'YE', 'Yemen', 'Sanâ€˜aâ€™', 0),
(244, 'YT', 'Mayotte', 'Mamoudzou', 0),
(245, 'ZA', 'South Africa', 'Pretoria', 0),
(246, 'ZM', 'Zambia', 'Lusaka', 0),
(247, 'ZW', 'Zimbabwe', 'Harare', 0),
(248, 'XK', 'Kosovo', 'Pristina', 0),
(249, 'SS', 'South Sudan', 'Juba', 0);

-- --------------------------------------------------------

--
-- 表的結構 `externalapp`
--

CREATE TABLE IF NOT EXISTS `externalapp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Info on external apps(mobile) that work with your deployment' AUTO_INCREMENT=3 ;

--
-- 轉存資料表中的資料 `externalapp`
--

INSERT INTO `externalapp` (`id`, `name`, `url`) VALUES
(1, 'iPhone', 'http://download.ushahidi.com/track_download.php?download=ios'),
(2, 'Android', 'http://download.ushahidi.com/track_download.php?download=android');

-- --------------------------------------------------------

--
-- 表的結構 `feed`
--

CREATE TABLE IF NOT EXISTS `feed` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `feed_name` varchar(255) DEFAULT NULL,
  `feed_url` varchar(255) DEFAULT NULL,
  `feed_cache` text,
  `feed_active` tinyint(4) DEFAULT '1',
  `feed_update` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Information about RSS Feeds a deployment subscribes to' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的結構 `feed_item`
--

CREATE TABLE IF NOT EXISTS `feed_item` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `feed_id` int(11) unsigned NOT NULL,
  `location_id` bigint(20) unsigned DEFAULT '0',
  `incident_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `item_title` varchar(255) DEFAULT NULL,
  `item_description` text,
  `item_link` varchar(255) DEFAULT NULL,
  `item_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `feed_id` (`feed_id`),
  KEY `incident_id` (`incident_id`),
  KEY `location_id` (`location_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores feed items pulled from each RSS Feed' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的結構 `feed_item_category`
--

CREATE TABLE IF NOT EXISTS `feed_item_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `feed_item_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `category_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `feed_item_category_ids` (`feed_item_id`,`category_id`),
  KEY `feed_item_id` (`feed_item_id`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores fetched feed items categories' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的結構 `form`
--

CREATE TABLE IF NOT EXISTS `form` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `form_title` varchar(200) NOT NULL,
  `form_description` text,
  `form_active` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `form_title` (`form_title`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores all report submission forms created(default+custom)' AUTO_INCREMENT=2 ;

--
-- 轉存資料表中的資料 `form`
--

INSERT INTO `form` (`id`, `form_title`, `form_description`, `form_active`) VALUES
(1, 'Default Form', 'Default form, for report entry', 1);

-- --------------------------------------------------------

--
-- 表的結構 `form_field`
--

CREATE TABLE IF NOT EXISTS `form_field` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `form_id` int(11) NOT NULL DEFAULT '1',
  `field_name` varchar(200) DEFAULT NULL,
  `field_type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1 - TEXTFIELD, 2 - TEXTAREA (FREETEXT), 3 - DATE, 4 - PASSWORD, 5 - RADIO, 6 - CHECKBOX',
  `field_required` tinyint(4) DEFAULT '0',
  `field_position` tinyint(4) NOT NULL DEFAULT '0',
  `field_default` text,
  `field_maxlength` int(11) NOT NULL DEFAULT '0',
  `field_width` smallint(6) NOT NULL DEFAULT '0',
  `field_height` tinyint(4) DEFAULT '5',
  `field_isdate` tinyint(4) NOT NULL DEFAULT '0',
  `field_ispublic_visible` tinyint(4) NOT NULL DEFAULT '0',
  `field_ispublic_submit` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `field_name` (`field_name`,`form_id`),
  KEY `fk_form_id` (`form_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores all custom form fields created by users' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的結構 `form_field_option`
--

CREATE TABLE IF NOT EXISTS `form_field_option` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `form_field_id` int(11) NOT NULL DEFAULT '0',
  `option_name` varchar(200) DEFAULT NULL,
  `option_value` text,
  PRIMARY KEY (`id`),
  KEY `form_field_id` (`form_field_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Options related to custom form fields' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的結構 `form_response`
--

CREATE TABLE IF NOT EXISTS `form_response` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `form_field_id` int(11) NOT NULL,
  `incident_id` bigint(20) unsigned NOT NULL,
  `form_response` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_form_field_id` (`form_field_id`),
  KEY `incident_id` (`incident_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores responses to custom form fields' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的結構 `geometry`
--

CREATE TABLE IF NOT EXISTS `geometry` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `incident_id` bigint(20) unsigned NOT NULL,
  `geometry` geometry NOT NULL,
  `geometry_label` varchar(150) DEFAULT NULL,
  `geometry_comment` varchar(255) DEFAULT NULL,
  `geometry_color` varchar(20) DEFAULT NULL,
  `geometry_strokewidth` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  SPATIAL KEY `geometry` (`geometry`),
  KEY `incident_id` (`incident_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores map geometries i.e polygons, lines etc' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的結構 `incident`
--

CREATE TABLE IF NOT EXISTS `incident` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `location_id` bigint(20) unsigned NOT NULL,
  `form_id` int(11) NOT NULL DEFAULT '1',
  `locale` varchar(10) NOT NULL DEFAULT 'en_US',
  `user_id` int(11) unsigned DEFAULT NULL,
  `incident_title` varchar(255) DEFAULT NULL,
  `incident_description` longtext,
  `incident_date` datetime DEFAULT NULL,
  `incident_mode` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1 - WEB, 2 - SMS, 3 - EMAIL, 4 - TWITTER',
  `incident_active` tinyint(4) NOT NULL DEFAULT '0',
  `incident_verified` tinyint(4) NOT NULL DEFAULT '0',
  `incident_dateadd` datetime DEFAULT NULL,
  `incident_dateadd_gmt` datetime DEFAULT NULL,
  `incident_datemodify` datetime DEFAULT NULL,
  `incident_alert_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0 - Not Tagged for Sending, 1 - Tagged for Sending, 2 - Alerts Have Been Sent',
  `incident_zoom` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `location_id` (`location_id`),
  KEY `incident_active` (`incident_active`),
  KEY `incident_date` (`incident_date`),
  KEY `form_id` (`form_id`),
  KEY `user_id` (`user_id`),
  KEY `incident_mode` (`incident_mode`),
  KEY `incident_verified` (`incident_verified`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores reports submitted' AUTO_INCREMENT=208 ;

--
-- 轉存資料表中的資料 `incident`
--

INSERT INTO `incident` (`id`, `location_id`, `form_id`, `locale`, `user_id`, `incident_title`, `incident_description`, `incident_date`, `incident_mode`, `incident_active`, `incident_verified`, `incident_dateadd`, `incident_dateadd_gmt`, `incident_datemodify`, `incident_alert_status`, `incident_zoom`) VALUES
(1, 1, 1, 'en_US', 0, '0.095', 'Inspector Alert', '2014-03-12 12:27:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(2, 2, 1, 'en_US', 0, '0.08', 'AIR COUNTER_S', '2014-04-27 12:48:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(3, 3, 1, 'en_US', 0, '0.131', 'Inspector Alert', '2014-04-23 10:43:00', 1, 0, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(4, 4, 1, 'en_US', 0, '0.161', 'Inspector Alert', '2014-04-21 11:21:00', 1, 0, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(5, 5, 1, 'en_US', 0, '0.137', 'Inspector Alert', '2014-04-16 12:39:00', 1, 0, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(6, 6, 1, 'en_US', 0, '0.125', 'Inspector Alert', '2014-04-16 14:00:00', 1, 0, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(7, 7, 1, 'en_US', 0, '0.125', 'Inspector Alert', '2014-04-16 13:26:00', 1, 0, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(8, 8, 1, 'en_US', 0, '0.137', 'Inspector Alert', '2014-04-13 09:26:00', 1, 0, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(9, 9, 1, 'en_US', 0, '0.137', 'Inspector Alert', '2014-03-27 12:25:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(10, 10, 1, 'en_US', 0, '0.119', 'Inspector Alert', '2014-03-27 10:46:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(11, 11, 1, 'en_US', 0, '0.143', 'Inspector Alert', '2014-03-26 10:41:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(12, 12, 1, 'en_US', 0, '0.125', 'Inspector Alert', '2014-03-24 12:02:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(13, 13, 1, 'en_US', 0, '0.155', 'Inspector Alert', '2014-03-05 12:27:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(14, 14, 1, 'en_US', 0, '0.137', 'Inspector Alert', '2014-03-05 12:24:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(15, 15, 1, 'en_US', 0, '0.131', 'Inspector Alert', '2014-03-05 13:58:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(16, 16, 1, 'en_US', 0, '0.089', 'Inspector Alert', '2014-03-05 13:10:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(17, 17, 1, 'en_US', 0, '0.137', 'Inspector Alert', '2014-02-08 02:08:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(18, 18, 1, 'en_US', 0, '0.143', 'Inspector Alert', '2014-02-07 07:36:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(19, 19, 1, 'en_US', 0, '0.209', 'Inspector Alert', '2014-02-06 12:26:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(20, 20, 1, 'en_US', 0, '0.161', 'Inspector Alert', '2014-02-06 09:43:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(21, 21, 1, 'en_US', 0, '0.149', 'Inspector Alert', '2014-02-06 09:41:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(22, 22, 1, 'en_US', 0, '0.107', 'Inspector Alert', '2014-02-05 12:04:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(23, 23, 1, 'en_US', 0, '0.155', 'Inspector Alert', '2014-02-05 16:47:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(24, 24, 1, 'en_US', 0, '0.125', 'Inspector Alert', '2014-02-05 13:37:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(25, 25, 1, 'en_US', 0, '0.113', 'Inspector Alert', '2014-02-05 11:12:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(26, 26, 1, 'en_US', 0, '0.095', 'Inspector Alert', '2014-02-05 09:30:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(27, 27, 1, 'en_US', 0, '0.101', 'Inspector Alert', '2014-01-17 13:46:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(28, 28, 1, 'en_US', 0, '0.131', 'Inspector Alert', '2014-01-17 13:46:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(29, 29, 1, 'en_US', 0, '0.083', 'Inspector Alert', '2014-01-17 10:57:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(30, 30, 1, 'en_US', 0, '0.149', 'Inspector Alert', '2014-01-17 10:46:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(31, 31, 1, 'en_US', 0, '0.107', 'Inspector Alert', '2014-01-07 10:47:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(32, 32, 1, 'en_US', 0, '0.083', 'Inspector Alert', '2014-01-05 08:45:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(33, 33, 1, 'en_US', 0, '0.12', 'AIR COUNTER_S', '2014-01-17 17:07:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(34, 34, 1, 'en_US', 0, '0.203', 'Inspector Alert', '2013-12-26 08:45:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(35, 35, 1, 'en_US', 0, '0.149', 'Inspector Alert', '2013-12-26 13:30:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(36, 36, 1, 'en_US', 0, '0.149', 'Inspector Alert', '2013-12-26 13:30:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(37, 37, 1, 'en_US', 0, '0.125', 'Inspector Alert', '2013-12-26 13:29:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(38, 38, 1, 'en_US', 0, '0.089', 'Inspector Alert', '2013-12-14 08:00:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(39, 39, 1, 'en_US', 0, '0.113', 'Inspector Alert', '2013-12-14 08:00:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(40, 40, 1, 'en_US', 0, '0.137', 'Inspector Alert', '2013-12-11 13:23:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(41, 41, 1, 'en_US', 0, '0.089', 'Inspector Alert', '2013-12-11 13:02:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(42, 42, 1, 'en_US', 0, '0.13', 'AIR COUNTER_S', '2013-08-21 13:09:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(43, 43, 1, 'en_US', 0, '0.113', 'Inspector Alert', '2013-11-26 12:00:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(44, 44, 1, 'en_US', 0, '0.161', 'Inspector Alert', '2013-11-21 22:00:00', 1, 0, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(45, 45, 1, 'en_US', 0, '0.197', 'Inspector Alert', '2013-11-21 22:05:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(46, 46, 1, 'en_US', 0, '0.113', 'Inspector Alert', '2013-10-26 12:24:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(47, 47, 1, 'en_US', 0, '0.161', 'Inspector Alert', '2013-10-15 12:11:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(48, 48, 1, 'en_US', 0, '0.125', 'Inspector Alert', '2013-10-25 17:13:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(49, 49, 1, 'en_US', 0, '0.149', 'Inspector Alert', '2013-10-25 16:06:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(50, 50, 1, 'en_US', 0, '0.155', 'Inspector Alert', '2013-10-15 00:05:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(51, 51, 1, 'en_US', 0, '0.155', 'Inspector Alert', '2013-10-15 00:05:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(52, 52, 1, 'en_US', 0, '0.155', 'Inspector Alert', '2013-10-15 00:05:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(53, 53, 1, 'en_US', 0, '0.149', 'Inspector Alert', '2013-07-19 15:35:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(54, 54, 1, 'en_US', 0, '0.101', 'Inspector Alert', '2013-07-19 15:00:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(55, 55, 1, 'en_US', 0, '0.12', 'AIR COUNTER_S', '2013-07-19 15:00:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(56, 56, 1, 'en_US', 0, '0.05', 'AIR COUNTER_S', '2013-06-29 11:59:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(57, 57, 1, 'en_US', 0, '0.14', 'AIR COUNTER_S', '2013-06-29 09:34:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(58, 58, 1, 'en_US', 0, '010', 'AIR COUNTER_S', '2013-06-27 10:54:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(59, 59, 1, 'en_US', 0, '0.10', 'AIR COUNTER_S', '2013-06-26 17:18:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(60, 60, 1, 'en_US', 0, '0.08', 'AIR COUNTER_S', '2013-06-28 18:58:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(61, 61, 1, 'en_US', 0, '0.07', 'AIR COUNTER_S', '2013-06-26 12:25:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(62, 62, 1, 'en_US', 0, '0.09', 'AIR COUNTER_S', '2013-06-22 14:53:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(63, 63, 1, 'en_US', 0, '0.06', 'AIR COUNTER_S', '2013-06-22 22:34:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(64, 64, 1, 'en_US', 0, '0.06', 'AIR COUNTER_S', '2013-06-21 14:05:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(65, 65, 1, 'en_US', 0, '0.06', 'AIR COUNTER_S', '2013-06-21 14:05:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(66, 66, 1, 'en_US', 0, '0.15', 'AIR COUNTER_S', '2013-06-20 18:34:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(67, 67, 1, 'en_US', 0, '0.05', 'AIR COUNTER_S', '2013-06-21 13:10:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(68, 68, 1, 'en_US', 0, '0.11', 'AIR COUNTER_S', '2013-06-22 10:13:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(69, 69, 1, 'en_US', 0, '0.119', 'Inspector Alert', '2013-06-21 16:15:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(70, 70, 1, 'en_US', 0, '0.119', 'Inspector Alert', '2013-06-21 16:05:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(71, 71, 1, 'en_US', 0, '0.131', 'Inspector Alert', '2013-06-21 15:30:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(72, 72, 1, 'en_US', 0, '0.119', 'Inspector Alert', '2013-06-21 15:48:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(73, 73, 1, 'en_US', 0, '0.08', 'AIR COUNTER_S', '2013-06-21 12:49:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(74, 74, 1, 'en_US', 0, '0.08', 'AIR COUNTER_S', '2013-06-18 17:42:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(75, 75, 1, 'en_US', 0, '0.07', 'AIR COUNTER_S', '2013-06-18 17:14:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(76, 76, 1, 'en_US', 0, '0.07', 'AIR COUNTER_S', '2013-06-18 17:14:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(77, 77, 1, 'en_US', 0, '0.14', 'AIR COUNTER_S', '2013-06-18 16:55:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(78, 78, 1, 'en_US', 0, '0.131', 'Inspector Alert', '2013-06-19 11:49:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(79, 79, 1, 'en_US', 0, '0.125', 'Inspector Alert', '2013-06-19 11:42:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(80, 80, 1, 'en_US', 0, '0.06', 'AIR COUNTER_S', '2013-06-18 20:43:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(81, 81, 1, 'en_US', 0, '0.07', 'AIR COUNTER_S', '2013-06-18 07:37:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(82, 82, 1, 'en_US', 0, '0.13', 'AIR COUNTER_S', '2013-06-18 07:34:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(83, 83, 1, 'en_US', 0, '0.08', 'AIR COUNTER_S', '2013-06-18 07:32:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(84, 84, 1, 'en_US', 0, '0.11', 'AIR COUNTER_S', '2013-06-18 07:27:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(85, 85, 1, 'en_US', 0, '0.09', 'AIR COUNTER_S', '2013-06-18 07:11:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(86, 86, 1, 'en_US', 0, '0.08', 'AIR COUNTER_S', '2013-06-17 16:40:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(87, 87, 1, 'en_US', 0, '0.12', 'AIR COUNTER_S', '2013-06-17 11:35:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(88, 88, 1, 'en_US', 0, '0.06', 'AIR COUNTER_S', '2013-06-17 00:11:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(89, 89, 1, 'en_US', 0, '0.16', 'AIR COUNTER_S', '2013-06-15 10:07:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(90, 90, 1, 'en_US', 0, '0.05', 'AIR COUNTER_S', '2013-06-15 15:07:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(91, 91, 1, 'en_US', 0, '0.12', 'AIR COUNTER_S', '2013-06-15 17:03:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(92, 92, 1, 'en_US', 0, '0.07', 'AIR COUNTER_S', '2013-06-16 07:40:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(93, 93, 1, 'en_US', 0, '0.10', 'AIR COUNTER_S', '2013-06-16 13:57:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(94, 94, 1, 'en_US', 0, '0.09', 'AIR COUNTER_S', '2013-06-16 17:05:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(95, 95, 1, 'en_US', 0, '0.07', 'AIR COUNTER_S', '2013-06-16 17:27:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(96, 96, 1, 'en_US', 0, '0.08', 'AIR COUNTER_S', '2013-06-16 17:44:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(97, 97, 1, 'en_US', 0, '0.14', 'AIR COUNTER_S', '2013-06-16 17:47:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(98, 98, 1, 'en_US', 0, '0.06', 'AIR COUNTER_S', '2013-06-16 17:59:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(99, 99, 1, 'en_US', 0, '0.11', 'AIR COUNTER_S', '2013-06-16 18:06:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(100, 100, 1, 'en_US', 0, '0.06', 'AIR COUNTER_S', '2013-06-16 18:14:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(101, 101, 1, 'en_US', 0, '0.24', 'AIR COUNTER_S', '2013-06-16 18:17:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(102, 102, 1, 'en_US', 0, '0.09', 'AIR COUNTER_S', '2013-06-16 18:19:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(103, 103, 1, 'en_US', 0, '0.09', 'AIR COUNTER_S', '2013-06-16 17:05:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(104, 104, 1, 'en_US', 0, '0.19', 'AIR COUNTER_S', '2013-06-16 16:51:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(105, 105, 1, 'en_US', 0, '0.08', 'AIR COUNTER_S', '2013-06-16 18:26:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(106, 106, 1, 'en_US', 0, '0.19', 'AIR COUNTER_S', '2013-06-16 16:46:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(107, 107, 1, 'en_US', 0, '0.15', 'Ecotest MKS-05 TERRA-P', '2013-06-16 21:09:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(108, 108, 1, 'en_US', 0, '0.16', 'Ecotest MKS-05 TERRA-P', '2013-06-16 14:20:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(109, 109, 1, 'en_US', 0, '0.17', 'Ecotest MKS-05 TERRA-P', '2013-06-16 14:19:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(110, 110, 1, 'en_US', 0, '0.16', 'Ecotest MKS-05 TERRA-P', '2013-06-16 14:18:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(111, 111, 1, 'en_US', 0, '0.13', 'Ecotest MKS-05 TERRA-P', '2013-06-16 14:13:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(112, 112, 1, 'en_US', 0, '0.15', 'Ecotest MKS-05 TERRA-P', '2013-06-16 14:10:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(113, 113, 1, 'en_US', 0, '0.12', 'Ecotest MKS-05 TERRA-P', '2013-06-13 11:30:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(114, 114, 1, 'en_US', 0, '0.11', 'Ecotest MKS-05 TERRA-P', '2013-06-13 11:20:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(115, 115, 1, 'en_US', 0, '0.12', 'Ecotest MKS-05 TERRA-P', '2013-06-13 10:30:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(116, 116, 1, 'en_US', 0, '0.16', 'Ecotest MKS-05 TERRA-P', '2013-06-13 10:21:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(117, 117, 1, 'en_US', 0, '0.13', 'Ecotest MKS-05 TERRA-P', '2013-06-13 10:24:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(118, 118, 1, 'en_US', 0, '0.09', 'Ecotest MKS-05 TERRA-P', '2013-06-13 10:21:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(119, 119, 1, 'en_US', 0, '0.13', 'Ecotest MKS-05 TERRA-P', '2013-06-13 10:04:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(120, 120, 1, 'en_US', 0, '0.11', 'Ecotest MKS-05 TERRA-P', '2013-06-13 08:55:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(121, 121, 1, 'en_US', 0, '0.137', 'Inspector Alert', '2013-06-05 16:01:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(122, 122, 1, 'en_US', 0, '0.131', 'Inspector Alert', '2013-06-05 13:30:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(123, 123, 1, 'en_US', 0, '0.257', 'Inspector Alert', '2013-05-28 15:01:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(124, 124, 1, 'en_US', 0, '0.18', 'AIR COUNTER_S', '2013-05-28 14:56:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(125, 125, 1, 'en_US', 0, '0.143', 'Inspector Alert', '2013-05-24 11:24:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(126, 126, 1, 'en_US', 0, '0.101', 'Inspector Alert', '2013-05-22 09:35:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(127, 127, 1, 'en_US', 0, '0.209', 'Inspector Alert', '2013-04-10 19:34:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(128, 128, 1, 'en_US', 0, '0.215', 'Inspector Alert', '2013-05-15 15:37:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(129, 129, 1, 'en_US', 0, '0.215', 'Inspector Alert', '2013-05-15 15:28:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(130, 130, 1, 'en_US', 0, '0.185', 'Inspector Alert', '2013-05-15 14:22:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(131, 131, 1, 'en_US', 0, '0.113', 'Inspector Alert', '2013-05-15 08:30:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(132, 132, 1, 'en_US', 0, '0.251', 'Inspector Alert', '2013-05-15 11:47:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(133, 133, 1, 'en_US', 0, '0.09', 'AIR COUNTER_S', '2013-05-13 14:22:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(134, 134, 1, 'en_US', 0, '0.07', 'AIR COUNTER_S', '2013-05-11 23:12:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(135, 135, 1, 'en_US', 0, '0.107', 'Inspector Alert', '2013-05-11 12:16:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(136, 136, 1, 'en_US', 0, '0.12', 'Ecotest MKS-05 TERRA-P', '2013-05-11 12:14:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(137, 137, 1, 'en_US', 0, '0.107', 'Inspector Alert', '2013-05-11 12:07:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(138, 138, 1, 'en_US', 0, '0.05', 'AIR COUNTER_S', '2013-05-03 11:01:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(139, 139, 1, 'en_US', 0, '0.161', 'Inspector Alert', '2013-04-25 14:45:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(140, 140, 1, 'en_US', 0, '0.149', 'Inspector Alert', '2013-04-18 18:17:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(141, 141, 1, 'en_US', 0, '0.119', 'Inspector Alert', '2013-04-18 14:23:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(142, 142, 1, 'en_US', 0, '0.155', 'Inspector Alert', '2013-04-18 14:19:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(143, 143, 1, 'en_US', 0, '0.149', 'Inspector Alert', '2013-04-18 09:37:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(144, 144, 1, 'en_US', 0, '0.125', 'Inspector Alert', '2013-04-18 09:37:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(145, 145, 1, 'en_US', 0, '0.149', 'Inspector Alert', '2013-04-16 16:29:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(146, 146, 1, 'en_US', 0, '0.113', 'Inspector Alert', '2013-04-16 13:15:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(147, 147, 1, 'en_US', 0, '0.119', 'Inspector Alert', '2013-04-12 19:49:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(148, 148, 1, 'en_US', 0, '0.125', 'Inspector Alert', '2013-04-12 13:56:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(149, 149, 1, 'en_US', 0, '0.149', 'Inspector Alert', '2013-04-10 18:23:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(150, 150, 1, 'en_US', 0, '0.143', 'Inspector Alert', '2013-04-10 10:58:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(151, 151, 1, 'en_US', 0, '0.33', 'AIR COUNTER_S', '2013-04-07 11:24:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(152, 152, 1, 'en_US', 0, '0.25', 'AIR COUNTER_S', '2013-04-07 10:53:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(153, 153, 1, 'en_US', 0, '0.17', 'AIR COUNTER_S', '2013-04-06 09:53:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(154, 154, 1, 'en_US', 0, '0.14', 'AIR COUNTER_S', '2013-03-22 20:30:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(155, 155, 1, 'en_US', 0, '0.16', 'Inspector Alert', '2013-04-01 16:24:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(156, 156, 1, 'en_US', 0, '0.16', 'AIR COUNTER_S', '2013-03-31 17:57:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(157, 157, 1, 'en_US', 0, '0.12', 'AIR COUNTER_S', '2013-03-24 11:15:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(158, 158, 1, 'en_US', 0, '0.09', 'AIR COUNTER_S', '2013-03-23 14:27:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(159, 159, 1, 'en_US', 0, '0.10', 'AIR COUNTER_S', '2013-03-23 12:34:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(160, 160, 1, 'en_US', 0, '0.24', 'AIR COUNTER_S', '2013-03-17 16:38:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(161, 161, 1, 'en_US', 0, '0.11', 'AIR COUNTER_S', '2013-03-16 08:49:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(162, 162, 1, 'en_US', 0, '0.14', 'AIR COUNTER_S', '2013-03-09 13:24:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(163, 163, 1, 'en_US', 0, '0.14', 'AIR COUNTER_S', '2013-03-09 09:45:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(164, 164, 1, 'en_US', 0, '0.19', 'AIR COUNTER_S', '2013-03-09 08:42:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(165, 165, 1, 'en_US', 0, '0.10', 'AIR COUNTER_S', '2013-03-03 16:34:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(166, 166, 1, 'en_US', 0, '0.17', 'AIR COUNTER_S', '2013-03-03 15:40:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(167, 167, 1, 'en_US', 0, '0.11', 'AIR COUNTER_S', '2013-03-03 12:41:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(168, 168, 1, 'en_US', 0, '0.08', 'AIR COUNTER_S', '2013-03-03 12:09:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(169, 169, 1, 'en_US', 0, '0.05', 'AIR COUNTER_S', '2013-03-03 11:40:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(170, 170, 1, 'en_US', 0, '0.21', 'AIR COUNTER_S', '2013-03-01 12:48:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(171, 171, 1, 'en_US', 0, '0.14', 'AIR COUNTER_S', '2013-02-28 09:26:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(172, 172, 1, 'en_US', 0, '0.09', 'AIR COUNTER_S', '2013-02-24 16:37:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(173, 173, 1, 'en_US', 0, '0.09', 'AIR COUNTER_S', '2013-02-24 14:29:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(174, 174, 1, 'en_US', 0, '0.09', 'AIR COUNTER_S', '2013-02-24 14:29:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(175, 175, 1, 'en_US', 0, '0.16', 'AIR COUNTER_S', '2013-02-24 12:28:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(176, 176, 1, 'en_US', 0, '0.13', 'AIR COUNTER_S', '2013-02-24 08:52:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(177, 177, 1, 'en_US', 0, '0.10', 'AIR COUNTER_S', '2013-02-23 16:44:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(178, 178, 1, 'en_US', 0, '0.10', 'AIR COUNTER_S', '2013-02-16 17:47:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(179, 179, 1, 'en_US', 0, '0.06', 'AIR COUNTER_S', '2013-02-16 09:18:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(180, 180, 1, 'en_US', 0, '0.14', 'Ecotest MKS-05 TERRA-P', '2013-02-02 10:19:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(181, 181, 1, 'en_US', 0, '0.12', 'Ecotest MKS-05 TERRA-P', '2013-02-10 17:29:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(182, 182, 1, 'en_US', 0, '0.13', 'Ecotest MKS-05 TERRA-P', '2013-01-31 12:23:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(183, 183, 1, 'en_US', 0, '0.14', 'AIR COUNTER_S', '2013-02-12 08:19:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(184, 184, 1, 'en_US', 0, '0.12', 'AIR COUNTER_S', '2013-02-10 14:06:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(185, 185, 1, 'en_US', 0, '0.12', 'AIR COUNTER_S', '2013-02-10 14:06:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(186, 186, 1, 'en_US', 0, '0.21', 'AIR COUNTER_S', '2013-02-07 18:39:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(187, 187, 1, 'en_US', 0, '0.16', 'AIR COUNTER_S', '2013-02-01 01:14:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(188, 188, 1, 'en_US', 0, '0.18', 'AIR COUNTER_S', '2013-02-03 11:58:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(189, 189, 1, 'en_US', 0, '0.16', 'AIR COUNTER_S', '2013-02-02 18:54:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(190, 190, 1, 'en_US', 0, '0.16', 'Ecotest MKS-05 TERRA-P', '2013-01-30 17:14:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(191, 191, 1, 'en_US', 0, '0.13', 'Ecotest MKS-05 TERRA-P', '2013-01-30 16:49:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(192, 192, 1, 'en_US', 0, '0.11', 'Ecotest MKS-05 TERRA-P', '2013-01-30 11:49:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(193, 193, 1, 'en_US', 0, '0.14', 'Ecotest MKS-05 TERRA-P', '2013-01-30 19:49:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(194, 194, 1, 'en_US', 0, '0.10', 'Ecotest MKS-05 TERRA-P', '2013-01-29 20:25:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(195, 195, 1, 'en_US', 0, '0.10', 'Ecotest MKS-05 TERRA-P', '2013-01-27 16:35:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(196, 196, 1, 'en_US', 0, '0.10', 'Ecotest MKS-05 TERRA-P', '2013-01-28 16:44:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(197, 197, 1, 'en_US', 0, '0.09', 'Ecotest MKS-05 TERRA-P', '2013-01-23 17:32:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(198, 198, 1, 'en_US', 0, '0.12', 'Ecotest MKS-05 TERRA-P', '2013-01-24 16:33:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(199, 199, 1, 'en_US', 0, '0.39', 'AIR COUNTER_S', '2013-01-20 15:15:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(200, 200, 1, 'en_US', 0, '0.15', 'Ecotest MKS-05 TERRA-P', '2013-01-23 17:23:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(201, 201, 1, 'en_US', 0, '0.15', 'Ecotest MKS-05 TERRA-P', '2013-01-23 16:59:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(202, 202, 1, 'en_US', 0, '0.15', 'Ecotest MKS-05 TERRA-P', '2013-01-23 16:59:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(203, 203, 1, 'en_US', 0, '0.12', 'Ecotest MKS-05 TERRA-P', '2013-01-23 15:30:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(204, 204, 1, 'en_US', 0, '0.39', 'AIR COUNTER_S', '2013-01-20 15:15:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(205, 205, 1, 'en_US', 0, '0.12', 'AIR COUNTER_S', '2013-01-12 01:04:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(206, 206, 1, 'en_US', 0, '0.14', 'AIR COUNTER_S', '2013-01-12 00:04:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL),
(207, 207, 1, 'en_US', 0, '0.15', 'AIR COUNTER_S', '2013-01-11 23:50:00', 1, 1, 0, '2014-06-01 00:28:42', NULL, NULL, 0, NULL);

-- --------------------------------------------------------

--
-- 表的結構 `incident_category`
--

CREATE TABLE IF NOT EXISTS `incident_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `incident_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `category_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `incident_category_ids` (`incident_id`,`category_id`),
  KEY `incident_id` (`incident_id`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores submitted reports categories' AUTO_INCREMENT=829 ;

--
-- 轉存資料表中的資料 `incident_category`
--

INSERT INTO `incident_category` (`id`, `incident_id`, `category_id`) VALUES
(1, 1, 7),
(2, 1, 9),
(3, 1, 15),
(4, 1, 10),
(5, 2, 7),
(6, 2, 9),
(7, 2, 15),
(8, 2, 11),
(9, 3, 7),
(10, 3, 9),
(11, 3, 15),
(12, 3, 10),
(13, 4, 7),
(14, 4, 9),
(15, 4, 15),
(16, 4, 10),
(17, 5, 7),
(18, 5, 9),
(19, 5, 15),
(20, 5, 10),
(21, 6, 7),
(22, 6, 9),
(23, 6, 15),
(24, 6, 10),
(25, 7, 7),
(26, 7, 9),
(27, 7, 15),
(28, 7, 10),
(29, 8, 7),
(30, 8, 9),
(31, 8, 15),
(32, 8, 10),
(33, 9, 7),
(34, 9, 9),
(35, 9, 15),
(36, 9, 10),
(37, 10, 7),
(38, 10, 9),
(39, 10, 15),
(40, 10, 10),
(41, 11, 7),
(42, 11, 9),
(43, 11, 15),
(44, 11, 10),
(45, 12, 7),
(46, 12, 9),
(47, 12, 15),
(48, 12, 10),
(49, 13, 7),
(50, 13, 9),
(51, 13, 15),
(52, 13, 10),
(53, 14, 7),
(54, 14, 9),
(55, 14, 15),
(56, 14, 10),
(57, 15, 7),
(58, 15, 9),
(59, 15, 15),
(60, 15, 10),
(61, 16, 7),
(62, 16, 9),
(63, 16, 15),
(64, 16, 10),
(65, 17, 7),
(66, 17, 9),
(67, 17, 15),
(68, 17, 10),
(69, 18, 7),
(70, 18, 9),
(71, 18, 15),
(72, 18, 10),
(73, 19, 7),
(74, 19, 9),
(75, 19, 15),
(76, 19, 10),
(77, 20, 7),
(78, 20, 9),
(79, 20, 15),
(80, 20, 10),
(81, 21, 7),
(82, 21, 9),
(83, 21, 15),
(84, 21, 10),
(85, 22, 7),
(86, 22, 9),
(87, 22, 15),
(88, 22, 10),
(89, 23, 7),
(90, 23, 9),
(91, 23, 15),
(92, 23, 10),
(93, 24, 7),
(94, 24, 9),
(95, 24, 15),
(96, 24, 10),
(97, 25, 7),
(98, 25, 9),
(99, 25, 15),
(100, 25, 10),
(101, 26, 7),
(102, 26, 9),
(103, 26, 15),
(104, 26, 10),
(105, 27, 7),
(106, 27, 9),
(107, 27, 15),
(108, 27, 10),
(109, 28, 7),
(110, 28, 9),
(111, 28, 15),
(112, 28, 10),
(113, 29, 7),
(114, 29, 9),
(115, 29, 15),
(116, 29, 10),
(117, 30, 7),
(118, 30, 9),
(119, 30, 15),
(120, 30, 10),
(121, 31, 7),
(122, 31, 9),
(123, 31, 15),
(124, 31, 10),
(125, 32, 7),
(126, 32, 9),
(127, 32, 15),
(128, 32, 10),
(129, 33, 7),
(130, 33, 8),
(131, 33, 15),
(132, 33, 11),
(133, 34, 7),
(134, 34, 8),
(135, 34, 15),
(136, 34, 10),
(137, 35, 7),
(138, 35, 9),
(139, 35, 15),
(140, 35, 10),
(141, 36, 7),
(142, 36, 9),
(143, 36, 15),
(144, 36, 10),
(145, 37, 7),
(146, 37, 9),
(147, 37, 15),
(148, 37, 10),
(149, 38, 7),
(150, 38, 9),
(151, 38, 15),
(152, 38, 10),
(153, 39, 7),
(154, 39, 9),
(155, 39, 15),
(156, 39, 10),
(157, 40, 7),
(158, 40, 9),
(159, 40, 15),
(160, 40, 10),
(161, 41, 7),
(162, 41, 9),
(163, 41, 15),
(164, 41, 10),
(165, 42, 7),
(166, 42, 8),
(167, 42, 15),
(168, 42, 11),
(169, 43, 7),
(170, 43, 8),
(171, 43, 15),
(172, 43, 10),
(173, 44, 7),
(174, 44, 8),
(175, 44, 15),
(176, 44, 10),
(177, 45, 7),
(178, 45, 8),
(179, 45, 15),
(180, 45, 10),
(181, 46, 7),
(182, 46, 9),
(183, 46, 15),
(184, 46, 10),
(185, 47, 7),
(186, 47, 9),
(187, 47, 15),
(188, 47, 10),
(189, 48, 7),
(190, 48, 9),
(191, 48, 15),
(192, 48, 10),
(193, 49, 7),
(194, 49, 8),
(195, 49, 15),
(196, 49, 10),
(197, 50, 7),
(198, 50, 9),
(199, 50, 15),
(200, 50, 10),
(201, 51, 7),
(202, 51, 9),
(203, 51, 15),
(204, 51, 10),
(205, 52, 7),
(206, 52, 9),
(207, 52, 15),
(208, 52, 10),
(209, 53, 7),
(210, 53, 9),
(211, 53, 15),
(212, 53, 10),
(213, 54, 7),
(214, 54, 8),
(215, 54, 15),
(216, 54, 10),
(217, 55, 7),
(218, 55, 8),
(219, 55, 15),
(220, 55, 11),
(221, 56, 7),
(222, 56, 9),
(223, 56, 15),
(224, 56, 11),
(225, 57, 7),
(226, 57, 9),
(227, 57, 15),
(228, 57, 11),
(229, 58, 7),
(230, 58, 9),
(231, 58, 15),
(232, 58, 11),
(233, 59, 7),
(234, 59, 8),
(235, 59, 15),
(236, 59, 11),
(237, 60, 7),
(238, 60, 9),
(239, 60, 15),
(240, 60, 11),
(241, 61, 7),
(242, 61, 8),
(243, 61, 15),
(244, 61, 11),
(245, 62, 7),
(246, 62, 9),
(247, 62, 15),
(248, 62, 11),
(249, 63, 7),
(250, 63, 9),
(251, 63, 15),
(252, 63, 11),
(253, 64, 7),
(254, 64, 9),
(255, 64, 15),
(256, 64, 11),
(257, 65, 7),
(258, 65, 9),
(259, 65, 15),
(260, 65, 11),
(261, 66, 7),
(262, 66, 9),
(263, 66, 15),
(264, 66, 11),
(265, 67, 7),
(266, 67, 9),
(267, 67, 15),
(268, 67, 11),
(269, 68, 7),
(270, 68, 9),
(271, 68, 15),
(272, 68, 11),
(273, 69, 7),
(274, 69, 9),
(275, 69, 15),
(276, 69, 10),
(277, 70, 7),
(278, 70, 9),
(279, 70, 15),
(280, 70, 10),
(281, 71, 7),
(282, 71, 8),
(283, 71, 15),
(284, 71, 10),
(285, 72, 7),
(286, 72, 9),
(287, 72, 15),
(288, 72, 10),
(289, 73, 7),
(290, 73, 9),
(291, 73, 15),
(292, 73, 11),
(293, 74, 7),
(294, 74, 9),
(295, 74, 15),
(296, 74, 11),
(297, 75, 7),
(298, 75, 9),
(299, 75, 15),
(300, 75, 11),
(301, 76, 7),
(302, 76, 9),
(303, 76, 15),
(304, 76, 11),
(305, 77, 7),
(306, 77, 9),
(307, 77, 15),
(308, 77, 11),
(309, 78, 7),
(310, 78, 8),
(311, 78, 15),
(312, 78, 10),
(313, 79, 7),
(314, 79, 9),
(315, 79, 15),
(316, 79, 10),
(317, 80, 7),
(318, 80, 9),
(319, 80, 15),
(320, 80, 11),
(321, 81, 7),
(322, 81, 9),
(323, 81, 15),
(324, 81, 11),
(325, 82, 7),
(326, 82, 9),
(327, 82, 15),
(328, 82, 11),
(329, 83, 7),
(330, 83, 9),
(331, 83, 15),
(332, 83, 11),
(333, 84, 7),
(334, 84, 8),
(335, 84, 15),
(336, 84, 11),
(337, 85, 7),
(338, 85, 9),
(339, 85, 15),
(340, 85, 11),
(341, 86, 7),
(342, 86, 9),
(343, 86, 15),
(344, 86, 11),
(345, 87, 7),
(346, 87, 8),
(347, 87, 15),
(348, 87, 11),
(349, 88, 7),
(350, 88, 8),
(351, 88, 15),
(352, 88, 11),
(353, 89, 7),
(354, 89, 9),
(355, 89, 15),
(356, 89, 11),
(357, 90, 7),
(358, 90, 9),
(359, 90, 15),
(360, 90, 11),
(361, 91, 7),
(362, 91, 9),
(363, 91, 15),
(364, 91, 11),
(365, 92, 7),
(366, 92, 9),
(367, 92, 15),
(368, 92, 11),
(369, 93, 7),
(370, 93, 9),
(371, 93, 15),
(372, 93, 11),
(373, 94, 7),
(374, 94, 9),
(375, 94, 15),
(376, 94, 11),
(377, 95, 7),
(378, 95, 9),
(379, 95, 15),
(380, 95, 11),
(381, 96, 7),
(382, 96, 9),
(383, 96, 15),
(384, 96, 11),
(385, 97, 7),
(386, 97, 9),
(387, 97, 15),
(388, 97, 11),
(389, 98, 7),
(390, 98, 9),
(391, 98, 15),
(392, 98, 11),
(393, 99, 7),
(394, 99, 9),
(395, 99, 15),
(396, 99, 11),
(397, 100, 7),
(398, 100, 9),
(399, 100, 15),
(400, 100, 11),
(401, 101, 7),
(402, 101, 9),
(403, 101, 15),
(404, 101, 11),
(405, 102, 7),
(406, 102, 9),
(407, 102, 15),
(408, 102, 11),
(409, 103, 7),
(410, 103, 9),
(411, 103, 15),
(412, 103, 11),
(413, 104, 7),
(414, 104, 8),
(415, 104, 15),
(416, 104, 11),
(417, 105, 7),
(418, 105, 9),
(419, 105, 15),
(420, 105, 11),
(421, 106, 7),
(422, 106, 8),
(423, 106, 15),
(424, 106, 11),
(425, 107, 7),
(426, 107, 9),
(427, 107, 15),
(428, 107, 12),
(429, 108, 7),
(430, 108, 9),
(431, 108, 15),
(432, 108, 12),
(433, 109, 7),
(434, 109, 9),
(435, 109, 15),
(436, 109, 12),
(437, 110, 7),
(438, 110, 9),
(439, 110, 15),
(440, 110, 12),
(441, 111, 7),
(442, 111, 8),
(443, 111, 15),
(444, 111, 12),
(445, 112, 7),
(446, 112, 8),
(447, 112, 15),
(448, 112, 12),
(449, 113, 7),
(450, 113, 9),
(451, 113, 15),
(452, 113, 12),
(453, 114, 7),
(454, 114, 9),
(455, 114, 15),
(456, 114, 12),
(457, 115, 7),
(458, 115, 9),
(459, 115, 15),
(460, 115, 12),
(461, 116, 7),
(462, 116, 8),
(463, 116, 15),
(464, 116, 12),
(465, 117, 7),
(466, 117, 8),
(467, 117, 15),
(468, 117, 12),
(469, 118, 7),
(470, 118, 9),
(471, 118, 15),
(472, 118, 12),
(473, 119, 7),
(474, 119, 9),
(475, 119, 15),
(476, 119, 12),
(477, 120, 7),
(478, 120, 9),
(479, 120, 15),
(480, 120, 12),
(481, 121, 7),
(482, 121, 8),
(483, 121, 15),
(484, 121, 10),
(485, 122, 7),
(486, 122, 9),
(487, 122, 15),
(488, 122, 10),
(489, 123, 7),
(490, 123, 9),
(491, 123, 15),
(492, 123, 10),
(493, 124, 7),
(494, 124, 9),
(495, 124, 15),
(496, 124, 11),
(497, 125, 7),
(498, 125, 8),
(499, 125, 15),
(500, 125, 10),
(501, 126, 7),
(502, 126, 9),
(503, 126, 15),
(504, 126, 10),
(505, 127, 7),
(506, 127, 9),
(507, 127, 15),
(508, 127, 10),
(509, 128, 7),
(510, 128, 9),
(511, 128, 15),
(512, 128, 10),
(513, 129, 7),
(514, 129, 9),
(515, 129, 15),
(516, 129, 10),
(517, 130, 7),
(518, 130, 9),
(519, 130, 15),
(520, 130, 10),
(521, 131, 7),
(522, 131, 9),
(523, 131, 15),
(524, 131, 10),
(525, 132, 7),
(526, 132, 9),
(527, 132, 15),
(528, 132, 10),
(529, 133, 7),
(530, 133, 8),
(531, 133, 15),
(532, 133, 11),
(533, 134, 7),
(534, 134, 8),
(535, 134, 15),
(536, 134, 11),
(537, 135, 7),
(538, 135, 9),
(539, 135, 15),
(540, 135, 10),
(541, 136, 7),
(542, 136, 8),
(543, 136, 15),
(544, 136, 12),
(545, 137, 7),
(546, 137, 9),
(547, 137, 15),
(548, 137, 10),
(549, 138, 7),
(550, 138, 8),
(551, 138, 15),
(552, 138, 11),
(553, 139, 7),
(554, 139, 8),
(555, 139, 15),
(556, 139, 10),
(557, 140, 7),
(558, 140, 9),
(559, 140, 15),
(560, 140, 10),
(561, 141, 7),
(562, 141, 8),
(563, 141, 15),
(564, 141, 10),
(565, 142, 7),
(566, 142, 9),
(567, 142, 15),
(568, 142, 10),
(569, 143, 7),
(570, 143, 9),
(571, 143, 15),
(572, 143, 10),
(573, 144, 7),
(574, 144, 9),
(575, 144, 15),
(576, 144, 10),
(577, 145, 7),
(578, 145, 9),
(579, 145, 15),
(580, 145, 10),
(581, 146, 7),
(582, 146, 9),
(583, 146, 15),
(584, 146, 10),
(585, 147, 7),
(586, 147, 9),
(587, 147, 15),
(588, 147, 10),
(589, 148, 7),
(590, 148, 8),
(591, 148, 15),
(592, 148, 10),
(593, 149, 7),
(594, 149, 9),
(595, 149, 15),
(596, 149, 10),
(597, 150, 7),
(598, 150, 8),
(599, 150, 15),
(600, 150, 10),
(601, 151, 7),
(602, 151, 9),
(603, 151, 15),
(604, 151, 11),
(605, 152, 7),
(606, 152, 9),
(607, 152, 15),
(608, 152, 11),
(609, 153, 7),
(610, 153, 9),
(611, 153, 15),
(612, 153, 11),
(613, 154, 7),
(614, 154, 8),
(615, 154, 15),
(616, 154, 11),
(617, 155, 7),
(618, 155, 8),
(619, 155, 15),
(620, 155, 10),
(621, 156, 7),
(622, 156, 9),
(623, 156, 15),
(624, 156, 11),
(625, 157, 7),
(626, 157, 9),
(627, 157, 15),
(628, 157, 11),
(629, 158, 7),
(630, 158, 9),
(631, 158, 15),
(632, 158, 11),
(633, 159, 7),
(634, 159, 9),
(635, 159, 15),
(636, 159, 11),
(637, 160, 7),
(638, 160, 9),
(639, 160, 15),
(640, 160, 11),
(641, 161, 7),
(642, 161, 9),
(643, 161, 15),
(644, 161, 11),
(645, 162, 7),
(646, 162, 9),
(647, 162, 15),
(648, 162, 11),
(649, 163, 7),
(650, 163, 9),
(651, 163, 15),
(652, 163, 11),
(653, 164, 7),
(654, 164, 9),
(655, 164, 15),
(656, 164, 11),
(657, 165, 7),
(658, 165, 9),
(659, 165, 15),
(660, 165, 11),
(661, 166, 7),
(662, 166, 9),
(663, 166, 15),
(664, 166, 11),
(665, 167, 7),
(666, 167, 9),
(667, 167, 15),
(668, 167, 11),
(669, 168, 7),
(670, 168, 9),
(671, 168, 15),
(672, 168, 11),
(673, 169, 7),
(674, 169, 9),
(675, 169, 15),
(676, 169, 11),
(677, 170, 7),
(678, 170, 9),
(679, 170, 15),
(680, 170, 11),
(681, 171, 7),
(682, 171, 9),
(683, 171, 15),
(684, 171, 11),
(685, 172, 7),
(686, 172, 9),
(687, 172, 15),
(688, 172, 11),
(689, 173, 7),
(690, 173, 9),
(691, 173, 15),
(692, 173, 11),
(693, 174, 7),
(694, 174, 9),
(695, 174, 15),
(696, 174, 11),
(697, 175, 7),
(698, 175, 9),
(699, 175, 15),
(700, 175, 11),
(701, 176, 7),
(702, 176, 9),
(703, 176, 15),
(704, 176, 11),
(705, 177, 7),
(706, 177, 9),
(707, 177, 15),
(708, 177, 11),
(709, 178, 7),
(710, 178, 9),
(711, 178, 15),
(712, 178, 11),
(713, 179, 7),
(714, 179, 9),
(715, 179, 15),
(716, 179, 11),
(717, 180, 7),
(718, 180, 9),
(719, 180, 15),
(720, 180, 12),
(721, 181, 7),
(722, 181, 8),
(723, 181, 15),
(724, 181, 12),
(725, 182, 7),
(726, 182, 9),
(727, 182, 15),
(728, 182, 12),
(729, 183, 7),
(730, 183, 9),
(731, 183, 15),
(732, 183, 11),
(733, 184, 7),
(734, 184, 9),
(735, 184, 15),
(736, 184, 11),
(737, 185, 7),
(738, 185, 9),
(739, 185, 15),
(740, 185, 11),
(741, 186, 7),
(742, 186, 9),
(743, 186, 15),
(744, 186, 11),
(745, 187, 7),
(746, 187, 8),
(747, 187, 15),
(748, 187, 11),
(749, 188, 7),
(750, 188, 9),
(751, 188, 15),
(752, 188, 11),
(753, 189, 7),
(754, 189, 9),
(755, 189, 15),
(756, 189, 11),
(757, 190, 7),
(758, 190, 9),
(759, 190, 15),
(760, 190, 12),
(761, 191, 7),
(762, 191, 9),
(763, 191, 15),
(764, 191, 12),
(765, 192, 7),
(766, 192, 9),
(767, 192, 15),
(768, 192, 12),
(769, 193, 7),
(770, 193, 9),
(771, 193, 15),
(772, 193, 12),
(773, 194, 7),
(774, 194, 9),
(775, 194, 15),
(776, 194, 12),
(777, 195, 7),
(778, 195, 9),
(779, 195, 15),
(780, 195, 12),
(781, 196, 7),
(782, 196, 8),
(783, 196, 15),
(784, 196, 12),
(785, 197, 7),
(786, 197, 9),
(787, 197, 15),
(788, 197, 12),
(789, 198, 7),
(790, 198, 9),
(791, 198, 15),
(792, 198, 12),
(793, 199, 7),
(794, 199, 9),
(795, 199, 15),
(796, 199, 11),
(797, 200, 7),
(798, 200, 9),
(799, 200, 15),
(800, 200, 12),
(801, 201, 7),
(802, 201, 9),
(803, 201, 15),
(804, 201, 12),
(805, 202, 7),
(806, 202, 9),
(807, 202, 15),
(808, 202, 12),
(809, 203, 7),
(810, 203, 9),
(811, 203, 15),
(812, 203, 12),
(813, 204, 7),
(814, 204, 9),
(815, 204, 15),
(816, 204, 11),
(817, 205, 7),
(818, 205, 9),
(819, 205, 15),
(820, 205, 11),
(821, 206, 7),
(822, 206, 8),
(823, 206, 15),
(824, 206, 11),
(825, 207, 7),
(826, 207, 8),
(827, 207, 15),
(828, 207, 11);

-- --------------------------------------------------------

--
-- 表的結構 `incident_lang`
--

CREATE TABLE IF NOT EXISTS `incident_lang` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `incident_id` bigint(20) unsigned NOT NULL,
  `locale` varchar(10) DEFAULT NULL,
  `incident_title` varchar(255) DEFAULT NULL,
  `incident_description` longtext,
  PRIMARY KEY (`id`),
  KEY `incident_id` (`incident_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Holds translations for report titles and descriptions' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的結構 `incident_person`
--

CREATE TABLE IF NOT EXISTS `incident_person` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `incident_id` bigint(20) unsigned DEFAULT NULL,
  `person_first` varchar(200) DEFAULT NULL,
  `person_last` varchar(200) DEFAULT NULL,
  `person_email` varchar(120) DEFAULT NULL,
  `person_phone` varchar(60) DEFAULT NULL,
  `person_ip` varchar(50) DEFAULT NULL,
  `person_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `incident_id` (`incident_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Holds information provided by people who submit reports' AUTO_INCREMENT=30 ;

--
-- 轉存資料表中的資料 `incident_person`
--

INSERT INTO `incident_person` (`id`, `incident_id`, `person_first`, `person_last`, `person_email`, `person_phone`, `person_ip`, `person_date`) VALUES
(1, 2, '', '', 'afaye0927@gmail.com', NULL, NULL, '2014-06-01 00:28:46'),
(2, 42, '', 'Test upload', '', NULL, NULL, '2014-06-01 00:30:49'),
(3, 62, '', '', 'sauming_hu@hotmail.com', NULL, NULL, '2014-06-01 00:31:41'),
(4, 63, '', '', 'sauming_hu@hotmail.com', NULL, NULL, '2014-06-01 00:31:42'),
(5, 64, '', '', 'sauming_hu@hotmail.com', NULL, NULL, '2014-06-01 00:31:44'),
(6, 65, '', '', 'sauming_hu@hotmail.com', NULL, NULL, '2014-06-01 00:31:46'),
(7, 66, '', '', 'sauming_hu@hotmail.com', NULL, NULL, '2014-06-01 00:31:47'),
(8, 67, '', '', 'sauming_hu@hotmail.com', NULL, NULL, '2014-06-01 00:31:49'),
(9, 69, '', '美術館站真是好所在，測得輻射值0.119（可容許範圍0.114）', '', NULL, NULL, '2014-06-01 00:31:51'),
(10, 70, '', '主婦聯盟美術館站真是好所在，輻射值0.119（可容許範圍0.114）', '', NULL, NULL, '2014-06-01 00:31:52'),
(11, 72, '', '主婦聯盟美術館站真是好所在，輻射值0.119（可容忍範圍0.114）', '', NULL, NULL, '2014-06-01 00:31:56'),
(12, 126, '', '', 'jacklee@ms1.hinet.net', NULL, NULL, '2014-06-01 00:33:27'),
(13, 180, '', '', 'luomein@gmail.com', NULL, NULL, '2014-06-01 00:34:55'),
(14, 181, '', '', 'luomein@gmail.com', NULL, NULL, '2014-06-01 00:34:56'),
(15, 182, '', '', 'luomein@gmail.com', NULL, NULL, '2014-06-01 00:34:58'),
(16, 187, '', '', 'doreen@seed.net.tw', NULL, NULL, '2014-06-01 00:35:02'),
(17, 189, '', '在住家4樓前陽台，只有鐵窗無氣密窗', 'ybybkimo@yahoo.com.tw', NULL, NULL, '2014-06-01 00:35:04'),
(18, 190, '', '', 'luomein@gmail.com', NULL, NULL, '2014-06-01 00:35:05'),
(19, 191, '', '', 'luomein@gmail.com', NULL, NULL, '2014-06-01 00:35:06'),
(20, 192, '', '', 'luomein@gmail.com', NULL, NULL, '2014-06-01 00:35:07'),
(21, 193, '', '', 'luomein@gmail.com', NULL, NULL, '2014-06-01 00:35:10'),
(22, 194, '', '', 'luomein@gmail.com', NULL, NULL, '2014-06-01 00:35:10'),
(23, 195, '', '', 'luomein@gmail.com', NULL, NULL, '2014-06-01 00:35:12'),
(24, 196, '', '', 'luomein@gmail.com', NULL, NULL, '2014-06-01 00:35:14'),
(25, 197, '', '', 'luomein@gmail.com', NULL, NULL, '2014-06-01 00:35:15'),
(26, 199, '', '上一次量測記錄的地圖標示錯誤請刪除，今更正。', 'kuochaoeng@yahoo.com.tw', NULL, NULL, '2014-06-01 00:35:18'),
(27, 201, '', '', 'luomein@gmail.com', NULL, NULL, '2014-06-01 00:35:20'),
(28, 202, '', '', 'luomein@gmail.com', NULL, NULL, '2014-06-01 00:35:23'),
(29, 204, '', '', 'kuochaoeng@yahoo.com.tw', NULL, NULL, '2014-06-01 00:35:25');

-- --------------------------------------------------------

--
-- 表的結構 `layer`
--

CREATE TABLE IF NOT EXISTS `layer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layer_name` varchar(255) DEFAULT NULL,
  `layer_url` varchar(255) DEFAULT NULL,
  `layer_file` varchar(100) DEFAULT NULL,
  `layer_color` varchar(20) DEFAULT NULL,
  `layer_visible` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Holds static layer information' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的結構 `level`
--

CREATE TABLE IF NOT EXISTS `level` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `level_title` varchar(200) DEFAULT NULL,
  `level_description` varchar(200) DEFAULT NULL,
  `level_weight` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores level of trust assigned to reporters of the platform' AUTO_INCREMENT=6 ;

--
-- 轉存資料表中的資料 `level`
--

INSERT INTO `level` (`id`, `level_title`, `level_description`, `level_weight`) VALUES
(1, 'SPAM + Delete', 'SPAM + Delete', -2),
(2, 'SPAM', 'SPAM', -1),
(3, 'Untrusted', 'Untrusted', 0),
(4, 'Trusted', 'Trusted', 1),
(5, 'Trusted + Verify', 'Trusted + Verify', 2);

-- --------------------------------------------------------

--
-- 表的結構 `location`
--

CREATE TABLE IF NOT EXISTS `location` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `location_name` varchar(255) DEFAULT NULL,
  `country_id` int(11) NOT NULL DEFAULT '0',
  `latitude` double NOT NULL DEFAULT '0',
  `longitude` double NOT NULL DEFAULT '0',
  `location_visible` tinyint(4) NOT NULL DEFAULT '1',
  `location_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `country_id` (`country_id`),
  KEY `latitude` (`latitude`),
  KEY `longitude` (`longitude`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores location information' AUTO_INCREMENT=208 ;

--
-- 轉存資料表中的資料 `location`
--

INSERT INTO `location` (`id`, `location_name`, `country_id`, `latitude`, `longitude`, `location_visible`, `location_date`) VALUES
(1, '蘭嶼核廢料貯存場大門前', 0, 22.002897, 121.590582, 1, '2014-06-01 00:28:42'),
(2, '情人湖濱海大道', 0, 25.162757, 121.72879, 1, '2014-06-01 00:28:42'),
(3, '宜蘭大同鄉松羅國家步道', 0, 24.666291, 121.565371, 1, '2014-06-01 00:28:42'),
(4, '捷運大坪林站', 226, 24.982899, 121.541352, 1, '2014-06-01 00:28:42'),
(5, '新北市新店區慈濟醫院', 0, 24.985978, 121.535841, 1, '2014-06-01 00:28:42'),
(6, '新北市板橋區重慶國小', 0, 24.994454, 121.462426, 1, '2014-06-01 00:28:42'),
(7, '主婦聯盟合作社雙和取貨站', 0, 24.998331, 121.520392, 1, '2014-06-01 00:28:42'),
(8, '新北市板橋區信義國小', 0, 24.99182, 121.452605, 1, '2014-06-01 00:28:42'),
(9, '安溪國小', 226, 24.931107, 121.372415, 1, '2014-06-01 00:28:42'),
(10, '三峽老街長福橋 牌坊前', 0, 24.933278, 121.371083, 1, '2014-06-01 00:28:42'),
(11, '伯朗咖啡館外澳館', 0, 24.878043, 121.8415, 1, '2014-06-01 00:28:42'),
(12, '人文國中小', 0, 24.860175, 121.819689, 1, '2014-06-01 00:28:42'),
(13, '淡水渡船頭', 0, 25.169967, 121.438919, 1, '2014-06-01 00:28:42'),
(14, '淡水區中正觀光市場', 0, 25.170069, 121.439786, 1, '2014-06-01 00:28:42'),
(15, '捷運淡水站2號出口', 0, 25.167818, 121.445561, 1, '2014-06-01 00:28:42'),
(16, '真理大學', 226, 25.175587, 121.434602, 1, '2014-06-01 00:28:42'),
(17, '牛耳渡假村', 0, 23.965098, 120.943284, 1, '2014-06-01 00:28:42'),
(18, '光被八表碑', 226, 24.023996, 121.165522, 1, '2014-06-01 00:28:42'),
(19, '南華山', 226, 24.222933, 121.201415, 1, '2014-06-01 00:28:42'),
(20, '天池山莊台電天池保線所', 0, 24.034841, 121.185559, 1, '2014-06-01 00:28:42'),
(21, '天池山莊騎樓', 0, 24.034841, 121.185559, 1, '2014-06-01 00:28:42'),
(22, '春陽溫泉山莊', 0, 24.028334, 121.157493, 1, '2014-06-01 00:28:42'),
(23, '台電雲海保線所', 0, 24.026273, 121.144672, 1, '2014-06-01 00:28:42'),
(24, '能高越嶺道入口', 0, 24.023587, 121.132665, 1, '2014-06-01 00:28:42'),
(25, '榮光之星加油站', 0, 23.97877, 120.994362, 1, '2014-06-01 00:28:42'),
(26, '西湖服務區', 226, 24.565568, 120.759445, 1, '2014-06-01 00:28:42'),
(27, '信賢種籽親子實小', 0, 24.827958, 121.526329, 1, '2014-06-01 00:28:42'),
(28, '烏來區信賢步道入口黑橋旁', 0, 24.834098, 121.526148, 1, '2014-06-01 00:28:42'),
(29, '花園新城小公園', 0, 24.942328, 121.546542, 1, '2014-06-01 00:28:42'),
(30, '花園新城通泉草幼兒園', 0, 24.932827, 121.55145, 1, '2014-06-01 00:28:42'),
(31, '六福客棧', 226, 25.054733, 121.533531, 1, '2014-06-01 00:28:42'),
(32, '大直國小門口', 0, 25.080264, 121.546545, 1, '2014-06-01 00:28:42'),
(33, '立院中興樓103室', 0, 25.043032, 121.521261, 1, '2014-06-01 00:28:42'),
(34, '林邊文史工作室', 226, 22.435195, 120.518882, 1, '2014-06-01 00:28:42'),
(35, '忠治村', 48, 24.869666, 121.531291, 1, '2014-06-01 00:28:42'),
(36, '西雅圖的天空', 0, 24.869666, 121.531291, 1, '2014-06-01 00:28:42'),
(37, '西雅圖的天空', 0, 24.869666, 121.531291, 1, '2014-06-01 00:28:42'),
(38, '南投市觀音寺', 0, 23.923687, 120.716756, 1, '2014-06-01 00:28:42'),
(39, '南投縣中寮鄉標高900米山上', 0, 23.950991, 120.821249, 1, '2014-06-01 00:28:42'),
(40, '江醫師追流零污染舖子三民店', 0, 24.971015, 121.536938, 1, '2014-06-01 00:28:42'),
(41, '臺北市立木柵高工校門口', 0, 24.996905, 121.572444, 1, '2014-06-01 00:28:42'),
(42, '雪梨市', 114, -33.867487, 151.20699, 1, '2014-06-01 00:28:42'),
(43, '聯合醫院附近', 48, 25.106953, 121.531459, 1, '2014-06-01 00:28:42'),
(44, '17-1', 216, 25.118913, 121.532213, 1, '2014-06-01 00:28:42'),
(45, '17-1', 216, 25.118913, 121.532213, 1, '2014-06-01 00:28:42'),
(46, '桃��縣龜山鄉長壽路272號', 0, 23.484585, 120.894327, 1, '2014-06-01 00:28:42'),
(47, '奇岩好所在', 0, 25.124432, 121.505004, 1, '2014-06-01 00:28:42'),
(48, '環山路一段136巷12弄', 0, 25.087455, 121.567957, 1, '2014-06-01 00:28:42'),
(49, '碧湖好所在', 0, 25.08381, 121.580859, 1, '2014-06-01 00:28:42'),
(50, '台北市北投區奇岩社區發展協會(主婦聯盟合作社奇岩站)', 0, 25.124432, 121.505004, 1, '2014-06-01 00:28:42'),
(51, '台北市北投區公館路334巷16號', 0, 25.091075, 121.559834, 1, '2014-06-01 00:28:42'),
(52, '台北市北投區公館路334巷16號', 0, 23.484585, 120.894327, 1, '2014-06-01 00:28:42'),
(53, '南門好所在', 0, 22.982509, 120.204426, 1, '2014-06-01 00:28:42'),
(54, '南門好所在', 0, 22.982509, 120.204426, 1, '2014-06-01 00:28:42'),
(55, '南門好所在', 0, 22.982509, 120.204426, 1, '2014-06-01 00:28:42'),
(56, '捷運景安站', 226, 24.993905, 121.505113, 1, '2014-06-01 00:28:42'),
(57, '成功路四段167巷捷運內湖站2號出口', 0, 25.082723, 121.59541, 1, '2014-06-01 00:28:42'),
(58, '荷蘭村社區戶外', 0, 23.484585, 120.894327, 1, '2014-06-01 00:28:42'),
(59, '新竹聖教會室內', 0, 23.484585, 120.894327, 1, '2014-06-01 00:28:42'),
(60, '新竹聖教會廣場', 0, 23.484585, 120.894327, 1, '2014-06-01 00:28:42'),
(61, '荷蘭村社區B11-7樓', 0, 24.82196, 120.967585, 1, '2014-06-01 00:28:42'),
(62, '國立清華大學', 226, 24.794463, 120.990141, 1, '2014-06-01 00:28:42'),
(63, '馬偕醫院', 226, 24.79961, 120.991729, 1, '2014-06-01 00:28:42'),
(64, '國立科學工業園區實驗高中幼稚園部', 0, 24.777184, 121.016432, 1, '2014-06-01 00:28:42'),
(65, '國立科學工業園區實驗高中幼稚園部', 0, 24.777184, 121.016432, 1, '2014-06-01 00:28:42'),
(66, '建功一路70巷', 226, 24.799084, 120.997758, 1, '2014-06-01 00:28:42'),
(67, '金山十一街2巷', 0, 24.779352, 121.022174, 1, '2014-06-01 00:28:42'),
(68, '安樂區基金一路112巷110弄', 0, 25.147414, 121.702445, 1, '2014-06-01 00:28:42'),
(69, '主婦聯盟美術館站', 0, 23.484585, 120.894327, 1, '2014-06-01 00:28:42'),
(70, '主婦聯盟美術館站', 0, 23.010871, 120.666004, 1, '2014-06-01 00:28:42'),
(71, '主婦聯盟合作社美術館站', 0, 22.66248, 120.289111, 1, '2014-06-01 00:28:42'),
(72, '高雄巿鼓山區美術北三路227號', 0, 23.484585, 120.894327, 1, '2014-06-01 00:28:42'),
(73, '永和山水庫', 0, 24.661964, 120.923873, 1, '2014-06-01 00:28:42'),
(74, '港墘里', 226, 24.668073, 120.847023, 1, '2014-06-01 00:28:42'),
(75, '竹南科學園區', 226, 24.713777, 120.915092, 1, '2014-06-01 00:28:42'),
(76, '竹南科學園區', 226, 24.713777, 120.915092, 1, '2014-06-01 00:28:42'),
(77, '永和山水庫', 0, 24.661964, 120.923873, 1, '2014-06-01 00:28:42'),
(78, '三葉站', 48, 24.807201, 120.973241, 1, '2014-06-01 00:28:42'),
(79, '東門國小', 226, 24.805229, 120.972686, 1, '2014-06-01 00:28:42'),
(80, '聖約翰科技大學對面', 0, 25.226583, 121.452058, 1, '2014-06-01 00:28:42'),
(81, '南湖高中', 226, 25.066889, 121.610977, 1, '2014-06-01 00:28:42'),
(82, '市立南湖國小對街號誌控制器', 0, 25.067679, 121.612101, 1, '2014-06-01 00:28:42'),
(83, '市立南湖國小對街', 0, 25.067883, 121.611554, 1, '2014-06-01 00:28:42'),
(84, '捷運東湖站二樓', 0, 25.067147, 121.611445, 1, '2014-06-01 00:28:42'),
(85, '臺北市立圖書館東湖分館', 226, 25.067415, 121.61261, 1, '2014-06-01 00:28:42'),
(86, '舊莊國小', 226, 25.040155, 121.619606, 1, '2014-06-01 00:28:42'),
(87, '中研區民活動中心2樓', 0, 25.045368, 121.614511, 1, '2014-06-01 00:28:42'),
(88, '田園綠莊社區', 0, 25.03672, 121.623995, 1, '2014-06-01 00:28:42'),
(89, '研究院路四段麗山橋站', 0, 25.024929, 121.601299, 1, '2014-06-01 00:28:42'),
(90, '平等里福德祠站牌', 0, 25.128588, 121.57474, 1, '2014-06-01 00:28:42'),
(91, '平等國小門口', 0, 25.129106, 121.576511, 1, '2014-06-01 00:28:42'),
(92, '山豬窟游泳池', 0, 25.032498, 121.623963, 1, '2014-06-01 00:28:42'),
(93, '台北市立圖書館舊庄分館門口', 0, 25.041207, 121.619371, 1, '2014-06-01 00:28:42'),
(94, '胡適國小', 226, 25.042277, 121.617247, 1, '2014-06-01 00:28:42'),
(95, '南港區大坑街', 226, 25.04353, 121.618749, 1, '2014-06-01 00:28:42'),
(96, '中研院正門街口', 0, 25.043657, 121.616399, 1, '2014-06-01 00:28:42'),
(97, '中研院基因體研究中心', 226, 25.04287, 121.614436, 1, '2014-06-01 00:28:42'),
(98, '中研院生態池', 0, 25.042403, 121.612934, 1, '2014-06-01 00:28:42'),
(99, '中研院文學哲學研究所', 0, 25.041849, 121.612269, 1, '2014-06-01 00:28:42'),
(100, '中研院草皮活動廣場', 0, 25.040964, 121.613277, 1, '2014-06-01 00:28:42'),
(101, '中研院寬頻地震網衛星遙測系統', 0, 25.039856, 121.614329, 1, '2014-06-01 00:28:42'),
(102, '中研院歐美研究所', 0, 25.039633, 121.61523, 1, '2014-06-01 00:28:42'),
(103, '中研院胡適紀念館', 0, 25.040498, 121.616163, 1, '2014-06-01 00:28:42'),
(104, '臺北市立圖書館舊庄分館二樓', 0, 25.041895, 121.61784, 1, '2014-06-01 00:28:42'),
(105, '中央研究院物理研究所', 0, 25.042299, 121.616661, 1, '2014-06-01 00:28:42'),
(106, '臺北市南港區舊莊街1段91巷11號2樓', 0, 25.041869, 121.617633, 1, '2014-06-01 00:28:42'),
(107, '桃園市縣府路106號', 0, 23.484585, 120.894327, 1, '2014-06-01 00:28:42'),
(108, '桃園市縣府路98號', 0, 23.484585, 120.894327, 1, '2014-06-01 00:28:42'),
(109, '桃園市縣府路90號', 0, 23.484585, 120.894327, 1, '2014-06-01 00:28:42'),
(110, '桃園市縣府路88號', 0, 23.484585, 120.894327, 1, '2014-06-01 00:28:42'),
(111, '吉品咖啡', 0, 23.484585, 120.894327, 1, '2014-06-01 00:28:42'),
(112, '吉品咖啡', 0, 23.484585, 120.894327, 1, '2014-06-01 00:28:42'),
(113, '米羅幼兒園', 0, 23.484585, 120.894327, 1, '2014-06-01 00:28:42'),
(114, '金色大地', 31, 23.484585, 120.894327, 1, '2014-06-01 00:28:42'),
(115, '中路圖書館', 114, 23.484585, 120.894327, 1, '2014-06-01 00:28:42'),
(116, '桃園市益壽二街12巷16號', 0, 23.484585, 120.894327, 1, '2014-06-01 00:28:42'),
(117, '桃園市益壽二街12巷16號', 0, 23.484585, 120.894327, 1, '2014-06-01 00:28:42'),
(118, '桃園市益壽二街12巷16號', 0, 23.484585, 120.894327, 1, '2014-06-01 00:28:42'),
(119, '西門國小', 226, 23.484585, 120.894327, 1, '2014-06-01 00:28:42'),
(120, '桃園市中山國小', 226, 24.986239, 121.289687, 1, '2014-06-01 00:28:42'),
(121, '艾蜜奇', 0, 24.68241, 120.868951, 1, '2014-06-01 00:28:42'),
(122, '縣立竹南國中', 0, 24.684192, 120.875975, 1, '2014-06-01 00:28:42'),
(123, '浦城街', 226, 25.023424, 121.526804, 1, '2014-06-01 00:28:42'),
(124, '浦城街', 226, 25.023424, 121.526804, 1, '2014-06-01 00:28:42'),
(125, '某民宅', 0, 24.671459, 121.818535, 1, '2014-06-01 00:28:42'),
(126, '五結鄉利生醫院後門', 0, 23.484585, 120.894327, 1, '2014-06-01 00:28:42'),
(127, '313', 99, 25.094622, 121.523527, 1, '2014-06-01 00:28:42'),
(128, '旭海村', 48, 22.190459, 120.878603, 1, '2014-06-01 00:28:42'),
(129, '旭海村', 48, 22.190459, 120.878603, 1, '2014-06-01 00:28:42'),
(130, '港仔村', 48, 22.134175, 120.885114, 1, '2014-06-01 00:28:42'),
(131, '羅東火車站', 0, 24.677929, 121.774629, 1, '2014-06-01 00:28:42'),
(132, '宜蘭教養院', 0, 24.692886, 121.731379, 1, '2014-06-01 00:28:42'),
(133, '自立五街', 48, 24.967028, 121.251739, 1, '2014-06-01 00:28:42'),
(134, '金鋒五街', 226, 24.946511, 121.248794, 1, '2014-06-01 00:28:42'),
(135, '中壢好所在', 0, 24.952773, 121.233135, 1, '2014-06-01 00:28:42'),
(136, '220', 114, 24.952773, 121.233135, 1, '2014-06-01 00:28:42'),
(137, '中壢市廣州路220號', 0, 23.484585, 120.894327, 1, '2014-06-01 00:28:42'),
(138, '大觀路三段', 226, 24.992306, 121.430559, 1, '2014-06-01 00:28:42'),
(139, '新竹市南大路175號', 0, 23.484585, 120.894327, 1, '2014-06-01 00:28:42'),
(140, '捷運新北投站', 226, 25.136933, 121.50253, 1, '2014-06-01 00:28:42'),
(141, '太魯閣遊客中心', 226, 24.154246, 121.622175, 1, '2014-06-01 00:28:42'),
(142, '太魯閣遊客中心', 226, 24.154246, 121.622175, 1, '2014-06-01 00:28:42'),
(143, '新城火車站', 0, 24.127524, 121.640866, 1, '2014-06-01 00:28:42'),
(144, '頭城火車站', 0, 24.858976, 121.822556, 1, '2014-06-01 00:28:42'),
(145, '二集團', 226, 23.05614, 120.719187, 1, '2014-06-01 00:28:42'),
(146, '屏東火車站', 226, 22.669306, 120.486203, 1, '2014-06-01 00:28:42'),
(147, '中正紀念堂', 226, 25.034731, 121.521934, 1, '2014-06-01 00:28:42'),
(148, '汀州路三段160巷', 226, 23.484585, 120.894327, 1, '2014-06-01 00:28:42'),
(149, '捷運景安站', 226, 24.993905, 121.505113, 1, '2014-06-01 00:28:42'),
(150, '台北市中正區水源市場', 0, 23.484585, 120.894327, 1, '2014-06-01 00:28:42'),
(151, '金山區五湖南勢湖74-9號', 0, 25.236608, 121.6169, 1, '2014-06-01 00:28:42'),
(152, '金山區中正路145號', 0, 25.236608, 121.6169, 1, '2014-06-01 00:28:42'),
(153, '信義區光復南路133號', 0, 25.028702, 121.576957, 1, '2014-06-01 00:28:42'),
(154, '北市新生南路1段103巷8號', 0, 23.484585, 120.894327, 1, '2014-06-01 00:28:42'),
(155, '主婦聯盟環境保護基金會', 0, 25.013396, 121.534235, 1, '2014-06-01 00:28:42'),
(156, '大安森林公園', 226, 25.03, 121.535833, 1, '2014-06-01 00:28:42'),
(157, '安樂區基金一路112巷110弄', 0, 25.147414, 121.702445, 1, '2014-06-01 00:28:42'),
(158, '板橋區文化路二段388號', 0, 25.011111, 121.445833, 1, '2014-06-01 00:28:42'),
(159, '南港區南港路一段32號', 0, 25.053315, 121.607409, 1, '2014-06-01 00:28:42'),
(160, '安樂區基金一路112巷110弄', 0, 25.147414, 121.702445, 1, '2014-06-01 00:28:42'),
(161, '安樂區基金一路112巷110弄', 0, 25.147414, 121.702445, 1, '2014-06-01 00:28:42'),
(162, '中正紀念堂七號出口', 0, 25.034731, 121.521934, 1, '2014-06-01 00:28:42'),
(163, '北投區石牌路一段200號', 0, 25.1167, 121.5, 1, '2014-06-01 00:28:42'),
(164, '南港區南港路一段32號', 0, 25.053315, 121.607409, 1, '2014-06-01 00:28:42'),
(165, '仁愛區南榮路64巷', 226, 25.118716, 121.745193, 1, '2014-06-01 00:28:42'),
(166, '萬里區亞尼克門口', 0, 25.1675, 121.639444, 1, '2014-06-01 00:28:42'),
(167, '金山區中山路97號', 0, 25.236608, 121.6169, 1, '2014-06-01 00:28:42'),
(168, '金山區中山路97號', 0, 25.236608, 121.6169, 1, '2014-06-01 00:28:42'),
(169, '金山區中山路97號', 0, 25.236608, 121.6169, 1, '2014-06-01 00:28:42'),
(170, '基金一路112巷110弄', 0, 25.141163, 121.715843, 1, '2014-06-01 00:28:42'),
(171, '基金一路112巷110弄', 0, 25.141163, 121.715843, 1, '2014-06-01 00:28:42'),
(172, '基金一路112巷110弄', 0, 25.141163, 121.715843, 1, '2014-06-01 00:28:42'),
(173, '基金一路112巷110弄', 0, 25.141163, 121.715843, 1, '2014-06-01 00:28:42'),
(174, '基金一路112巷110弄', 0, 25.141163, 121.715843, 1, '2014-06-01 00:28:42'),
(175, '基金一路112巷110弄', 0, 25.141163, 121.715843, 1, '2014-06-01 00:28:42'),
(176, '基金一路112巷110弄', 0, 25.141163, 121.715843, 1, '2014-06-01 00:28:42'),
(177, '安樂區基金一路112巷110弄', 0, 25.147414, 121.702445, 1, '2014-06-01 00:28:42'),
(178, '基金一路112巷110弄', 0, 25.141163, 121.715843, 1, '2014-06-01 00:28:42'),
(179, '基金一路112巷110弄', 0, 25.141163, 121.715843, 1, '2014-06-01 00:28:42'),
(180, '文德捷運站', 0, 25.0785, 121.583833, 1, '2014-06-01 00:28:42'),
(181, '嘉義車站後站', 0, 23.48, 120.439833, 1, '2014-06-01 00:28:42'),
(182, '忠孝新生捷運站公園', 0, 25.042167, 121.532167, 1, '2014-06-01 00:28:42'),
(183, '基金一路112巷110弄', 0, 25.141163, 121.715843, 1, '2014-06-01 00:28:42'),
(184, '基金一路112巷110弄', 0, 25.141163, 121.715843, 1, '2014-06-01 00:28:42'),
(185, '基金一路112巷110弄', 0, 25.141163, 121.715843, 1, '2014-06-01 00:28:42'),
(186, '基金一路112巷110弄', 0, 25.141163, 121.715843, 1, '2014-06-01 00:28:42'),
(187, '捷運六張犁站', 226, 25.023777, 121.553115, 1, '2014-06-01 00:28:42'),
(188, '基金一路112巷110弄', 0, 25.141163, 121.715843, 1, '2014-06-01 00:28:42'),
(189, '基金一路112巷110弄', 0, 25.141163, 121.715843, 1, '2014-06-01 00:28:42'),
(190, '新店捷運站附近', 0, 24.957333, 121.538167, 1, '2014-06-01 00:28:42'),
(191, '小粗坑', 226, 24.941167, 121.546, 1, '2014-06-01 00:28:42'),
(192, '新店捷運站附近', 0, 24.956833, 121.538333, 1, '2014-06-01 00:28:42'),
(193, '新生南路上', 0, 25.0315, 121.533333, 1, '2014-06-01 00:28:42'),
(194, '大安分局', 226, 25.037167, 121.532833, 1, '2014-06-01 00:28:42'),
(195, '竹圍腳踏車道', 0, 25.137167, 121.459333, 1, '2014-06-01 00:28:42'),
(196, '員崠子商號', 0, 25.036667, 121.527833, 1, '2014-06-01 00:28:42'),
(197, '大安森林公園', 226, 25.025833, 121.534833, 1, '2014-06-01 00:28:42'),
(198, '小粗坑', 226, 24.9395, 121.5405, 1, '2014-06-01 00:28:42'),
(199, '核二廠展示館外', 0, 25.207167, 121.659529, 1, '2014-06-01 00:28:42'),
(200, '大安森林公園', 226, 25.025667, 121.534667, 1, '2014-06-01 00:28:42'),
(201, '台灣e店', 0, 25.019167, 121.533167, 1, '2014-06-01 00:28:42'),
(202, '台灣e店', 0, 25.019167, 121.533167, 1, '2014-06-01 00:28:42'),
(203, '台大校門口', 0, 25.016833, 121.533167, 1, '2014-06-01 00:28:42'),
(204, '核二廠展示館外空地', 0, 23.484585, 120.894327, 1, '2014-06-01 00:28:42'),
(205, '中壢市', 226, 23.484585, 120.894327, 1, '2014-06-01 00:28:42'),
(206, '高雄市小港區紹興街', 0, 22.562887, 120.356351, 1, '2014-06-01 00:28:42'),
(207, '小港區紹興街', 226, 22.562918, 120.35635, 1, '2014-06-01 00:28:42');

-- --------------------------------------------------------

--
-- 表的結構 `maintenance`
--

CREATE TABLE IF NOT EXISTS `maintenance` (
  `allowed_ip` varchar(15) NOT NULL,
  PRIMARY KEY (`allowed_ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Puts a site in maintenance mode if data exists in this table';

-- --------------------------------------------------------

--
-- 表的結構 `media`
--

CREATE TABLE IF NOT EXISTS `media` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `location_id` bigint(20) unsigned DEFAULT NULL,
  `incident_id` bigint(20) unsigned DEFAULT NULL,
  `message_id` bigint(20) unsigned DEFAULT NULL,
  `badge_id` int(11) DEFAULT NULL,
  `media_type` tinyint(4) DEFAULT NULL COMMENT '1 - IMAGES, 2 - VIDEO, 3 - AUDIO, 4 - NEWS, 5 - PODCAST',
  `media_title` varchar(255) DEFAULT NULL,
  `media_description` longtext,
  `media_link` varchar(255) DEFAULT NULL,
  `media_medium` varchar(255) DEFAULT NULL,
  `media_thumb` varchar(255) DEFAULT NULL,
  `media_date` datetime DEFAULT NULL,
  `media_active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `incident_id` (`incident_id`),
  KEY `location_id` (`location_id`),
  KEY `badge_id` (`badge_id`),
  KEY `message_id` (`message_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores any media submitted along with a report' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的結構 `message`
--

CREATE TABLE IF NOT EXISTS `message` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT '0',
  `incident_id` bigint(20) unsigned DEFAULT '0',
  `user_id` int(11) unsigned DEFAULT '0',
  `reporter_id` bigint(20) unsigned DEFAULT NULL,
  `service_messageid` varchar(100) DEFAULT NULL,
  `message_from` varchar(100) DEFAULT NULL,
  `message_to` varchar(100) DEFAULT NULL,
  `message` text,
  `message_detail` text,
  `message_type` tinyint(4) DEFAULT '1' COMMENT '1 - INBOX, 2 - OUTBOX (From Admin), 3 - DELETED',
  `message_date` datetime DEFAULT NULL,
  `message_level` tinyint(4) DEFAULT '0' COMMENT '0 - UNREAD, 1 - READ, 99 - SPAM',
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `incident_id` (`incident_id`),
  KEY `reporter_id` (`reporter_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores tweets, emails and SMS messages' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的結構 `openid`
--

CREATE TABLE IF NOT EXISTS `openid` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `openid` varchar(255) NOT NULL,
  `openid_email` varchar(127) NOT NULL,
  `openid_server` varchar(255) NOT NULL,
  `openid_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `openid` (`openid`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores usersâ€™ openid information' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的結構 `page`
--

CREATE TABLE IF NOT EXISTS `page` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page_title` varchar(255) NOT NULL,
  `page_description` longtext,
  `page_tab` varchar(100) NOT NULL,
  `page_active` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores user created pages' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的結構 `permissions`
--

CREATE TABLE IF NOT EXISTS `permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Stores permissions used for access control' AUTO_INCREMENT=21 ;

--
-- 轉存資料表中的資料 `permissions`
--

INSERT INTO `permissions` (`id`, `name`) VALUES
(1, 'reports_view'),
(2, 'reports_edit'),
(4, 'reports_comments'),
(5, 'reports_download'),
(6, 'reports_upload'),
(7, 'messages'),
(8, 'messages_reporters'),
(9, 'stats'),
(10, 'settings'),
(11, 'manage'),
(12, 'users'),
(13, 'manage_roles'),
(16, 'reports_verify'),
(17, 'reports_approve'),
(18, 'admin_ui'),
(19, 'member_ui'),
(20, 'delete_all_reports');

-- --------------------------------------------------------

--
-- 表的結構 `permissions_roles`
--

CREATE TABLE IF NOT EXISTS `permissions_roles` (
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`role_id`,`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Stores permissions assigned to roles';

--
-- 轉存資料表中的資料 `permissions_roles`
--

INSERT INTO `permissions_roles` (`role_id`, `permission_id`) VALUES
(1, 14),
(2, 1),
(2, 2),
(2, 4),
(2, 5),
(2, 6),
(2, 7),
(2, 8),
(2, 9),
(2, 10),
(2, 11),
(2, 12),
(2, 14),
(2, 15),
(2, 16),
(2, 17),
(2, 18),
(3, 1),
(3, 2),
(3, 4),
(3, 5),
(3, 6),
(3, 7),
(3, 8),
(3, 9),
(3, 10),
(3, 11),
(3, 12),
(3, 13),
(3, 14),
(3, 15),
(3, 16),
(3, 17),
(3, 18),
(3, 20),
(4, 19),
(5, 1),
(5, 5),
(5, 6);

-- --------------------------------------------------------

--
-- 表的結構 `plugin`
--

CREATE TABLE IF NOT EXISTS `plugin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_name` varchar(100) NOT NULL,
  `plugin_url` varchar(250) DEFAULT NULL,
  `plugin_description` text,
  `plugin_priority` tinyint(4) DEFAULT '0',
  `plugin_active` tinyint(4) DEFAULT '0',
  `plugin_installed` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugin_name` (`plugin_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Holds a list of all plugins installed on a deployment' AUTO_INCREMENT=5 ;

--
-- 轉存資料表中的資料 `plugin`
--

INSERT INTO `plugin` (`id`, `plugin_name`, `plugin_url`, `plugin_description`, `plugin_priority`, `plugin_active`, `plugin_installed`) VALUES
(1, 'clickatell', NULL, NULL, 0, 0, 0),
(2, 'frontlinesms', NULL, NULL, 0, 0, 0),
(3, 'sharing', NULL, NULL, 0, 0, 0),
(4, 'smssync', NULL, NULL, 0, 0, 0);

-- --------------------------------------------------------

--
-- 表的結構 `private_message`
--

CREATE TABLE IF NOT EXISTS `private_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) unsigned NOT NULL,
  `from_user_id` int(11) DEFAULT '0',
  `private_subject` varchar(255) NOT NULL,
  `private_message` text NOT NULL,
  `private_message_date` datetime NOT NULL,
  `private_message_new` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores private messages sent between Members' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的結構 `rating`
--

CREATE TABLE IF NOT EXISTS `rating` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned DEFAULT '0',
  `incident_id` bigint(20) unsigned DEFAULT NULL,
  `comment_id` bigint(20) unsigned DEFAULT NULL,
  `rating` tinyint(4) DEFAULT '0',
  `rating_ip` varchar(100) DEFAULT NULL,
  `rating_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `incident_id` (`incident_id`),
  KEY `comment_id` (`comment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores credibility ratings for reports and comments' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的結構 `reporter`
--

CREATE TABLE IF NOT EXISTS `reporter` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `location_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` int(11) unsigned DEFAULT NULL,
  `service_id` int(10) unsigned DEFAULT NULL,
  `level_id` int(11) unsigned DEFAULT NULL,
  `service_account` varchar(255) DEFAULT NULL,
  `reporter_first` varchar(200) DEFAULT NULL,
  `reporter_last` varchar(200) DEFAULT NULL,
  `reporter_email` varchar(120) DEFAULT NULL,
  `reporter_phone` varchar(60) DEFAULT NULL,
  `reporter_ip` varchar(50) DEFAULT NULL,
  `reporter_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `location_id` (`location_id`),
  KEY `service_id` (`service_id`),
  KEY `level_id` (`level_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Information on report submitters via email, twitter and sms' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的結構 `roles`
--

CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `description` varchar(255) NOT NULL,
  `access_level` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Defines user access levels and privileges on a deployment' AUTO_INCREMENT=6 ;

--
-- 轉存資料表中的資料 `roles`
--

INSERT INTO `roles` (`id`, `name`, `description`, `access_level`) VALUES
(1, 'login', 'Login privileges, granted after account confirmation', 0),
(2, 'admin', 'Administrative user, has access to almost everything.', 90),
(3, 'superadmin', 'Super administrative user, has access to everything.', 100),
(4, 'member', 'Regular user with access only to the member area', 10),
(5, 'TrustMember', 'TrustMember', 10);

-- --------------------------------------------------------

--
-- 表的結構 `roles_users`
--

CREATE TABLE IF NOT EXISTS `roles_users` (
  `user_id` int(11) unsigned NOT NULL,
  `role_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `fk_role_id` (`role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores roles assigned to users registered on a deployment';

--
-- 轉存資料表中的資料 `roles_users`
--

INSERT INTO `roles_users` (`user_id`, `role_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 5);

-- --------------------------------------------------------

--
-- 表的結構 `scheduler`
--

CREATE TABLE IF NOT EXISTS `scheduler` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `scheduler_name` varchar(100) NOT NULL,
  `scheduler_last` int(10) unsigned NOT NULL DEFAULT '0',
  `scheduler_weekday` smallint(6) NOT NULL DEFAULT '-1',
  `scheduler_day` smallint(6) NOT NULL DEFAULT '-1',
  `scheduler_hour` smallint(6) NOT NULL DEFAULT '-1',
  `scheduler_minute` smallint(6) NOT NULL,
  `scheduler_controller` varchar(100) NOT NULL,
  `scheduler_active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores schedules for cron jobs' AUTO_INCREMENT=6 ;

--
-- 轉存資料表中的資料 `scheduler`
--

INSERT INTO `scheduler` (`id`, `scheduler_name`, `scheduler_last`, `scheduler_weekday`, `scheduler_day`, `scheduler_hour`, `scheduler_minute`, `scheduler_controller`, `scheduler_active`) VALUES
(1, 'Feeds', 1401552793, -1, -1, -1, 0, 's_feeds', 1),
(2, 'Alerts', 1401554251, -1, -1, -1, -1, 's_alerts', 1),
(3, 'Email', 1401552793, -1, -1, -1, 0, 's_email', 1),
(4, 'Twitter', 1401552793, -1, -1, -1, 0, 's_twitter', 1),
(5, 'Cleanup', 1401552793, -1, -1, -1, 0, 's_cleanup', 1);

-- --------------------------------------------------------

--
-- 表的結構 `scheduler_log`
--

CREATE TABLE IF NOT EXISTS `scheduler_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `scheduler_id` int(10) unsigned NOT NULL,
  `scheduler_status` varchar(20) DEFAULT NULL,
  `scheduler_date` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `scheduler_id` (`scheduler_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores a log of scheduler actions' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的結構 `service`
--

CREATE TABLE IF NOT EXISTS `service` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `service_name` varchar(100) DEFAULT NULL,
  `service_description` varchar(255) DEFAULT NULL,
  `service_url` varchar(255) DEFAULT NULL,
  `service_api` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Info on input sources i.e SMS, Email, Twitter' AUTO_INCREMENT=4 ;

--
-- 轉存資料表中的資料 `service`
--

INSERT INTO `service` (`id`, `service_name`, `service_description`, `service_url`, `service_api`) VALUES
(1, 'SMS', 'Text messages from phones', NULL, NULL),
(2, 'Email', 'Email messages sent to your deployment', NULL, NULL),
(3, 'Twitter', 'Tweets tweets tweets', 'http://twitter.com', NULL);

-- --------------------------------------------------------

--
-- 表的結構 `sessions`
--

CREATE TABLE IF NOT EXISTS `sessions` (
  `session_id` varchar(127) NOT NULL,
  `last_activity` int(10) unsigned NOT NULL,
  `data` text NOT NULL,
  PRIMARY KEY (`session_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores session information';

--
-- 轉存資料表中的資料 `sessions`
--

INSERT INTO `sessions` (`session_id`, `last_activity`, `data`) VALUES
('j26hf6atdsn9u6adn4krpir4e7', 1401554251, 'R6mHXnLcgfMjY2Q3h58eH4cPCNbc+YlJtWmGLZtXLVh95p+lImENgsCaqhR4PeiL/QQM5OaUmAS/zP4I8tqAPmX3ldC/S1ybjBqa1h5IpDgZb/vbtP8Y/JWDZlex73TJBHwj6aOWBDXQNNeHK1AAlkrLdGGORCBZ17AVAclnPbwjuPwTB+EwGN77mKFnFYpTswFMD84asIoaueO1bI/twr7RybqVSEeR4F91cdqP2eO7vJ4E8MlqJs0auCBFLc+Z//24iuknLDY+AZ3Ss54Kq83Dv3Hirgj2GxNgxYdzTNWJlfulVwK1p/Fb9p57nwJ8cqFrPwQucPcLSrhzfx2oSnKW1j7sCMkmptzR+OOW5vpTiJnxztMBffSha7VQpMbI5dNrB+zzD9bgOu24MVHtmP4knEYll/jWKpcHr99HlE4ITM6Y9ZbCb36LPqNwV3JdsHYR4fYs6ApQ3HkpvxnG4mEQ45nBczLqd4qb6EE7tnCUqrBlVx5239ub3x6zxslOK3/IBhPUu9jdMM66HGyJsVpcaA=='),
('m3g34e2qncn88q8egk62bh7213', 1401554130, 'V2ScLlKuQjJxDZjXkDSxK8VtEbO2PmlwRn9bOuQSSrbNPzDT3T9p0INBbs+Tz+n1r7k2MFYxmy+X+YptmRCjHJDBVM7KxlwfXJ1DXz1OsEHBZgtG6IcmFlrKdb1ow17eZBhX03flaVXPGy+7p9jRWj8ETOmyfqBP9v65f8fUVPQ1aY6uLiXBPkJ3EVdqYV5Kt+iOlKRK40NQe0nHobEHk6zk0HEdpF6FvmJy9n7Oi+xGcZy2HKf8grk1E/5BKKKZEVDBNn5PAeotHMbqid5bzFmHvX/M9viB/tydVM4NqdBZZ6l7+OVFrnxeGODQPHw7hkQlBIqSyZGUwJepgZ4S0He/Ai7x0HGB0m0c7fAZmd4z21jERJOOGK3riXQ260j3pLBoB5c/I5dA/7uSvY5e7Eft7BgwwgJ5I3c0W/3A5RhSQD189er5PDXUZEdJpAkKnYhxb1z/1vxIkIMo5M2yCLJY6Argyr8E127UhikJrd1CEnyqqZa4scEqtAwQTiAvDTCzACdtjZu+zM8whe6JcP9+VZhBwZtwzbtHqdRteMz0VmqY5nsJv7mB3/MuUCI8jrL+0sgJvx6895kxHp491xbB6gAj4XeqmuFLZdnLugMKKKY1c0ArNZoyN+fHDCX+uMAgSj7iIEAs5WYRJGu62x+hB0dtDOdVZSZTpBfg2EeW6uwRwzoFrP3W6jEhTaw916BF1WbrdUgdNkz+0PQjT7r03wd25MRuQI9Z9/fixVCDNcakes71YG8caEJoHyaEfe5fmXQ2PWnXRss6tFJq0sl6N3YfY3ChVyic35p9uJ35CNqSNRpT2Yjil1Elq3wYwzVcsT+ncDXq3hB8uzRpXaFpcqO4/qZYDEDTHEWrV26O7QqpElvOdTwHHGIt+ICkZzN8I2NJyywf0q876hxtRPdXMQdfHGELrPhW1zsLxxsUKp5VEVEATCOrKwI0QiEYgA5fzSoo6haI+5owxWS/T2icP+QOxgnhgGrzeDaBG5R06Sxa9dI3N2g8Iea2lETj6DbHCahTyIrUpDEEXl3P3+UA5EpYd0GfyU4jUvn6Qt7wtpDY5f8+BoSzXSl7iAiHyE7BFa5PioJsU8gfm5/FE99Wd3eDjb+8CELkD2VGvERTULhJpYNR+ptlsPch2pCy4zrCz8lHNsnrVME76CXWRLmPXnxp93+vR14CsAD0RyBNLds55bXoxRYy5yCHAaamekKKed1rxbTUAdX6IIhBx09fAgtZJvBsrqKUGfSSg8eFdAUrYkVudhX+Cwxxn5wPeaEOe7RHK+7iYkr+kd+GofRGfEPSfWtN+SPfx7HWgQsDIEd8dUz794Gj+I2pCe2sp1t+0st3akzHjM4i7BbL+oiH81pPvpfnk7TwWhrK1n45uYB0CGux7JHdOfA3dP6P8bL/efQOqrF3vCc0VzZQeRtW28MowJcJDn+m+WhMW/d4/zZxdZGSmDTjU5mdmSxdYGQ=');

-- --------------------------------------------------------

--
-- 表的結構 `settings`
--

CREATE TABLE IF NOT EXISTS `settings` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(100) NOT NULL DEFAULT '' COMMENT 'Unique identifier for the configuration parameter',
  `value` text COMMENT 'Value for the settings parameter',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_settings_key` (`key`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=71 ;

--
-- 轉存資料表中的資料 `settings`
--

INSERT INTO `settings` (`id`, `key`, `value`) VALUES
(1, 'site_name', 'DemoNU273'),
(2, 'site_tagline', 'twnuclear'),
(3, 'site_banner_id', NULL),
(4, 'site_email', 'admin@gg.tw'),
(5, 'site_key', NULL),
(6, 'site_language', 'zh_TW'),
(7, 'site_style', 'nuclear'),
(8, 'site_timezone', 'Asia/Taipei'),
(9, 'site_contact_page', '1'),
(10, 'site_help_page', '1'),
(11, 'site_message', ''),
(12, 'site_copyright_statement', ''),
(13, 'site_submit_report_message', ''),
(14, 'allow_reports', '1'),
(15, 'allow_comments', '1'),
(16, 'allow_feed', '1'),
(17, 'allow_stat_sharing', '1'),
(18, 'allow_clustering', '1'),
(19, 'cache_pages', '0'),
(20, 'cache_pages_lifetime', '1800'),
(21, 'private_deployment', '0'),
(22, 'default_map', 'osm_TransportMap'),
(23, 'default_map_all', 'CC0000'),
(24, 'default_map_all_icon_id', NULL),
(25, 'api_google', ''),
(26, 'api_live', 'Apumcka0uPOF2lKLorq8aeo4nuqfVVeNRqJjqOcLMJ9iMCTsnMsNd9_OvpA8gR0i'),
(27, 'api_akismet', ''),
(28, 'default_country', '226'),
(29, 'multi_country', '0'),
(30, 'default_city', 'nairobi'),
(31, 'default_lat', '23.69781'),
(32, 'default_lon', '120.96051499999999'),
(33, 'default_zoom', '7'),
(34, 'items_per_page', '5'),
(35, 'items_per_page_admin', '20'),
(36, 'sms_provider', ''),
(37, 'sms_no1', NULL),
(38, 'sms_no2', NULL),
(39, 'sms_no3', NULL),
(40, 'google_analytics', ''),
(41, 'twitter_hashtags', NULL),
(42, 'blocks', 'news_block|reports_block'),
(43, 'blocks_per_row', '2'),
(44, 'date_modify', '2014-05-25 17:47:30'),
(45, 'stat_id', '64520'),
(46, 'stat_key', 'b32d1204b2c94499a786dbeb220ba3'),
(47, 'email_username', NULL),
(48, 'email_password', NULL),
(49, 'email_port', NULL),
(50, 'email_host', NULL),
(51, 'email_servertype', NULL),
(52, 'email_ssl', NULL),
(53, 'ftp_server', NULL),
(54, 'ftp_user_name', NULL),
(55, 'alerts_email', 'admin@gg.tw'),
(57, 'facebook_appid', NULL),
(58, 'facebook_appsecret', NULL),
(59, 'db_version', '117'),
(60, 'ushahidi_version', '2.7.3'),
(61, 'allow_alerts', '1'),
(62, 'require_email_confirmation', '0'),
(63, 'manually_approve_users', '0'),
(64, 'enable_timeline', '0'),
(65, 'feed_geolocation_user', ''),
(66, 'allow_feed_category', '0'),
(67, 'forgot_password_secret', '5X9D;c?1gn#qbm7q2M^1CRrTC.?MyVA4*OHW*Qh5XqqXsV8Ly5f)k*UPl2L~o$sc'),
(68, 'scheduler_lock', '0'),
(69, 'timeline_graph', 'line'),
(70, 'timeline_point_label', '0');

-- --------------------------------------------------------

--
-- 表的結構 `user_tokens`
--

CREATE TABLE IF NOT EXISTS `user_tokens` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `user_agent` varchar(40) NOT NULL,
  `token` varchar(64) NOT NULL,
  `created` int(10) unsigned NOT NULL,
  `expires` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_token` (`token`),
  KEY `fk_user_id` (`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores browser tokens assigned to users' AUTO_INCREMENT=6 ;

--
-- 轉存資料表中的資料 `user_tokens`
--

INSERT INTO `user_tokens` (`id`, `user_id`, `user_agent`, `token`, `created`, `expires`) VALUES
(1, 2, '850b723b0d6f223a19569cf18a0435fddb569589', 'fCa1xdaXbjJGaK4PY55xreFritBvuO9I', 1400485445, 1401695045),
(2, 1, '850b723b0d6f223a19569cf18a0435fddb569589', 'dfZnyceFbcTDJR3IXKnzzEgHjkwpWMWO', 1400627982, 1401837582),
(3, 2, '850b723b0d6f223a19569cf18a0435fddb569589', 'vgU6TDs8uhLbi0dR8TzJIpZjFUbhGRC2', 1400631623, 1401841223),
(5, 1, 'd4f09ab969f7263dd752040a91e66f34043b6e53', 'flIq1Hxs15HrYvSVDNG45DKeoD5KAGHH', 1401550934, 1402760534);

-- --------------------------------------------------------

--
-- 表的結構 `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `riverid` varchar(128) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `email` varchar(127) NOT NULL,
  `username` varchar(100) NOT NULL DEFAULT '',
  `password` char(50) NOT NULL,
  `logins` int(10) unsigned NOT NULL DEFAULT '0',
  `last_login` int(10) unsigned DEFAULT NULL,
  `notify` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Flag incase admin opts in for email notifications',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `color` varchar(6) NOT NULL DEFAULT 'FF0000',
  `code` varchar(30) DEFAULT NULL,
  `confirmed` tinyint(1) NOT NULL DEFAULT '0',
  `public_profile` tinyint(1) NOT NULL DEFAULT '1',
  `approved` tinyint(1) NOT NULL DEFAULT '1',
  `needinfo` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_username` (`username`),
  UNIQUE KEY `uniq_email` (`email`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores registered usersâ€™ information' AUTO_INCREMENT=3 ;

--
-- 轉存資料表中的資料 `users`
--

INSERT INTO `users` (`id`, `riverid`, `name`, `email`, `username`, `password`, `logins`, `last_login`, `notify`, `updated`, `color`, `code`, `confirmed`, `public_profile`, `approved`, `needinfo`) VALUES
(1, '', 'Administrator', 'admin@gg.tw', 'admin', '95bf499afd4867a272485ee3992339812ea23a87864a0f0af1', 19, 1401550934, 0, '2014-05-31 15:42:14', 'FF0000', NULL, 1, 0, 1, 0),
(2, '', 'member0', 'member0@gg.tw', '320830120', '1c40a27ee514bbd46c832ac630fa90a34244cc2cfeab5df312', 10, 1400685781, 0, '2014-05-21 15:23:01', 'FF0000', NULL, 0, 1, 1, 0);

-- --------------------------------------------------------

--
-- 表的結構 `verified`
--

CREATE TABLE IF NOT EXISTS `verified` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `incident_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `verified_date` datetime DEFAULT NULL,
  `verified_status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `incident_id` (`incident_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores all verified reports' AUTO_INCREMENT=7 ;

--
-- 轉存資料表中的資料 `verified`
--

INSERT INTO `verified` (`id`, `incident_id`, `user_id`, `verified_date`, `verified_status`) VALUES
(1, 4, 1, '2014-05-18 14:44:50', 1),
(2, 3, 1, '2014-05-18 14:44:50', 1),
(3, 2, 1, '2014-05-18 14:44:50', 1),
(4, 1, 1, '2014-05-18 14:44:50', 1),
(5, 6, 1, '2014-05-19 15:48:23', 1),
(6, 6, 1, '2014-05-19 15:48:31', 1);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
