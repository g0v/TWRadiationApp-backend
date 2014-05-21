-- phpMyAdmin SQL Dump
-- version 3.5.8.1deb1
-- http://www.phpmyadmin.net
--
-- 主機: localhost
-- 產生日期: 2014 年 05 月 18 日 00:37
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores user defined actions triggered by certain events' AUTO_INCREMENT=1 ;

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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores a log of triggered actions' AUTO_INCREMENT=1 ;

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='For logging API activities' AUTO_INCREMENT=19 ;

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Holds information about categories defined for a deployment' AUTO_INCREMENT=17 ;

--
-- 轉存資料表中的資料 `category`
--

INSERT INTO `category` (`id`, `parent_id`, `locale`, `category_position`, `category_title`, `category_description`, `category_color`, `category_image`, `category_image_thumb`, `category_visible`, `category_trusted`) VALUES
(1, 0, 'en_US', 0, '高度分類', 'Category 1', '9900CC', NULL, NULL, 1, 0),
(2, 0, 'en_US', 3, '區域分類', 'Category 2', '3300FF', NULL, NULL, 1, 0),
(3, 0, 'en_US', 6, '儀器分類', 'Category 3', '663300', NULL, NULL, 1, 0),
(4, 0, 'en_US', 11, 'Trusted Reports', 'Reports from trusted reporters', '339900', NULL, NULL, 1, 1),
(6, 1, 'zh_TW', 1, '地板上', '地板上', '00e1ff', NULL, NULL, 1, 0),
(7, 1, 'zh_TW', 2, '一公尺', '一公尺', '00ff33', NULL, NULL, 1, 0),
(8, 2, 'zh_TW', 4, '於室內', '於室內', 'fff582', NULL, NULL, 1, 0),
(9, 2, 'zh_TW', 5, '於室外', '於室外', 'ff7247', NULL, NULL, 1, 0),
(10, 3, 'zh_TW', 7, '儀器A', '儀器A', '085aff', NULL, NULL, 1, 0),
(11, 3, 'zh_TW', 8, '儀器B', '儀器B', '0022ff', NULL, NULL, 1, 0),
(12, 3, 'zh_TW', 9, '儀器C', '儀器C', '632963', NULL, NULL, 1, 0),
(13, 3, 'zh_TW', 10, '儀器D', '儀器D', '008051', NULL, NULL, 1, 0),
(14, 0, 'zh_TW', 12, '人員分類', '人員分類', '79ff5e', NULL, NULL, 1, 0),
(15, 14, 'zh_TW', 13, '專業人士', '專業人士', '003e54', NULL, NULL, 1, 0),
(16, 14, 'zh_TW', 14, '一般人士', '一般人士', 'ffd500', NULL, NULL, 1, 0);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores reports submitted' AUTO_INCREMENT=2 ;

--
-- 轉存資料表中的資料 `incident`
--

INSERT INTO `incident` (`id`, `location_id`, `form_id`, `locale`, `user_id`, `incident_title`, `incident_description`, `incident_date`, `incident_mode`, `incident_active`, `incident_verified`, `incident_dateadd`, `incident_dateadd_gmt`, `incident_datemodify`, `incident_alert_status`, `incident_zoom`) VALUES
(1, 1, 1, 'en_US', 1, 'Hello Ushahidi!', 'Welcome to Ushahidi. Please replace this report with a valid incident', '2012-04-04 12:54:31', 1, 1, 1, NULL, NULL, NULL, 0, NULL);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores submitted reports categories' AUTO_INCREMENT=2 ;

--
-- 轉存資料表中的資料 `incident_category`
--

INSERT INTO `incident_category` (`id`, `incident_id`, `category_id`) VALUES
(1, 1, 1);

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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Holds information provided by people who submit reports' AUTO_INCREMENT=1 ;

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores location information' AUTO_INCREMENT=2 ;

--
-- 轉存資料表中的資料 `location`
--

INSERT INTO `location` (`id`, `location_name`, `country_id`, `latitude`, `longitude`, `location_visible`, `location_date`) VALUES
(1, 'Nairobi', 115, -1.28730007070501, 36.8214511820082, 1, '2009-06-30 00:00:00');

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
(1, 3);

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
(1, 'Feeds', 1400342821, -1, -1, -1, 0, 's_feeds', 1),
(2, 'Alerts', 1400343974, -1, -1, -1, -1, 's_alerts', 1),
(3, 'Email', 1400342821, -1, -1, -1, 0, 's_email', 1),
(4, 'Twitter', 1400342821, -1, -1, -1, 0, 's_twitter', 1),
(5, 'Cleanup', 1400342822, -1, -1, -1, 0, 's_cleanup', 1);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores a log of scheduler actions' AUTO_INCREMENT=56 ;

--
-- 轉存資料表中的資料 `scheduler_log`
--

INSERT INTO `scheduler_log` (`id`, `scheduler_id`, `scheduler_status`, `scheduler_date`) VALUES
(1, 1, '200', 1400231789),
(2, 2, '200', 1400231789),
(3, 3, '200', 1400231789),
(4, 4, '200', 1400231789),
(5, 5, '200', 1400231789),
(6, 2, '200', 1400231821),
(7, 2, '200', 1400232600),
(8, 2, '200', 1400232605),
(9, 1, '200', 1400243240),
(10, 2, '200', 1400243240),
(11, 3, '200', 1400243240),
(12, 4, '200', 1400243240),
(13, 5, '200', 1400243240),
(14, 2, '200', 1400244783),
(15, 2, '200', 1400244921),
(16, 2, '200', 1400244961),
(17, 2, '200', 1400245038),
(18, 1, '200', 1400308583),
(19, 2, '200', 1400308583),
(20, 3, '200', 1400308583),
(21, 4, '200', 1400308583),
(22, 5, '200', 1400308583),
(23, 2, '200', 1400308857),
(24, 2, '200', 1400308863),
(25, 1, '200', 1400325231),
(26, 2, '200', 1400325231),
(27, 3, '200', 1400325231),
(28, 4, '200', 1400325231),
(29, 5, '200', 1400325231),
(30, 1, '200', 1400339841),
(31, 2, '200', 1400339841),
(32, 3, '200', 1400339842),
(33, 4, '200', 1400339842),
(34, 5, '200', 1400339842),
(35, 2, '200', 1400339901),
(36, 2, '200', 1400339975),
(37, 2, '200', 1400340005),
(38, 2, '200', 1400340060),
(39, 2, '200', 1400340086),
(40, 2, '200', 1400340139),
(41, 2, '200', 1400340182),
(42, 2, '200', 1400340251),
(43, 2, '200', 1400340306),
(44, 2, '200', 1400340376),
(45, 2, '200', 1400340473),
(46, 2, '200', 1400340501),
(47, 2, '200', 1400340548),
(48, 2, '200', 1400340655),
(49, 2, '200', 1400340680),
(50, 1, '200', 1400342821),
(51, 2, '200', 1400342821),
(52, 3, '200', 1400342821),
(53, 4, '200', 1400342821),
(54, 5, '200', 1400342822),
(55, 2, '200', 1400343974);

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
('o4jqts4aheqibsnfuamsqdjme1', 1400340011, 'f51bRWD9qWI4kYxKa2XyijSsdtbql3o0JB7ztgq9ceP6lVEtyee52jDoMZ9u4DCThc+dUhb2gAgIr3RBkzz50Bjz7sF6Qif5a8rIBJLPslTww4lbw10v1l0ZEHqryc6KN1Gorichnqf2hjSNColE/Bl1j+0GQY5QGzrIGaPv2uCidHK7nJdUhYuBXeqKDr1SltSq0gnIqdW6yY/O6EmFNI6+kGCZ2ke3OCkPbd9Hynui0pPxa2qZ03b8ROgbtoSvkd6Z1Ns2kRYVnDMPQGsuf1eG/67kDcti/hL0t6mM6VIoZCmOB+w/ls50GQqboKnHRM0+S/tyuhCcwyZhBe8GIMD9G7SvfEGpIamMPr4m48MO+eDHJ9SH12AQk19/qrCV7kVHj8tAquIPwPeJcxxcF4ILrm/fWvSoQogXHhuTy6Swz/sM0YXKO18djWtpuF6+aHM6lAZAG/fK6VNBcvdpJb0Ps1AKZqYy3K6jPW5AzBnLdb8xuHiKTeaLAimYAzvR5Oxdy3pnC6U9Jm+YnuC9/dBMUQ=='),
('132btk2qphcpeqeh5hajnh31m6', 1400344014, 'YGa2FCT4fM6HHiZalkBrQnluEQDHInPsGXcTB7wwH/Z2RtMPDXdtZl53nvMY9O5J9EUOFAS4MIc/M70pmB2UNgoVd714ZjvR6/q7txhghCDlh91gSFVPlTy20v0VLiSJLazXhY4wnS+YZuMrtXTq5piYII7ALc92OnDD24vMHZY/jP2IfSfX99u+QRjcjaTU9Y3luCUYq/9dL6ndJdQz5zLxER4aY/aCdn3qy4xITLtpQFttGdzdbsHBCgKK8RxWRAxgzcuS+kPFaJeOcQAbE/9qcrjoaYEvkw0RN+LY9TFE4GnHYXJpp+ZQhz+oilIdg9CwN5t1LqWAWKdXYW+Q9F7MvwB7JqtJSdThWMNeaClCU47kemMdT3H81ti84Zx3iOnidC1czOxr1a2FqNVZhewLjpL85Z/Zv0SWLbLqMGieMND5dUOr0pEywZDGFqV2YE1IDv68wp7Uue9NyjklzIsZ7/zo8/G6oAYz6L9vyPWAtfl72zovj08V/Odo/JvcPsImyo1Rb4djTcJ+DHq2RPaIA33CVGQ0q2+KP+GJzxWDYOoYLsN0VYQjGqwDLn+qNhKmpb8JoBNOqepxY4Q8xJRpt3ky1AFWFAMMBZNOCl4IcwvLaDn3Ic94NBZZvt7uca81E12cKjO1/tvNSASIPCni4AlV1KgjGuyEDnst3ecr52fpVv6PPlQ8e19V9H38DQ6hd/vQxjiyggsFWbWFbkyZxdpgSc0E9fgDDqZFVNtBvtUdk8OckOSGGvJbHKz4iPsOfNjKxZHC2uS//qegk0y+KYVke2uyF+4FfYRaDcGQa/fbImQ5wTL7YmH1jOpleD3CHfYeH/FKdbGEMtW+AM0DyHeooHDfnzRuCUeN0fN2APAU/RHd+ytfg/NDxc9ub/fYE8nev7/dPiSPn+tycvrwBlbzBh7/Dcx9eLX2l8xnNG9KAUMDADOIIPqYb8e6u8EQROq43nP9BrUNJKFFSlXzajbv96LSlmGMB2Py0M5JeXnlcrTnYVrgXz58VTbKqcTYAFq4jObmXNf7WdHv1TzVOQEXbgHpE6GOMSJfCLTkLlfvC3bcKarLuTbIDauDVfEvlgCc4RWRqQmazDzchJbcDswknixupXqcNh4hxCF6HmMOB0no3o0TJZY+4lXPCNzEyY47ptjkDIx39UMn+di/DVFerN2u/Hm5a+qGdtOKbv75zS0SvllHOWD2IcRNC6NyzZoi8AXj9MDpIPY6SIlHATxat7lWZ2v1u5YPhwhD6jitnybEh0zyhdFe3yuspkruCWtX1XYZPyyonMGI61PS823P95aQMpTOvoJsrKe57vzW6OMuAYIThF4h2YrXxdqa2+IgG4dLAsKXZG/eDZvjdhx1jDlP/qn6sOlXxDdyzhueavV/ign6rEBR0iIJyhh0U19qvM/E6HcrKRZBbMSMWh1wi8zE97EZplUC5YovWtSfgUp3HmpW1l4LZNhioJ91DheDhGtnRXX4QICMhrBopXBA');

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
(6, 'site_language', 'en_US'),
(7, 'site_style', 'nuclear'),
(8, 'site_timezone', NULL),
(9, 'site_contact_page', '1'),
(10, 'site_help_page', '1'),
(11, 'site_message', NULL),
(12, 'site_copyright_statement', NULL),
(13, 'site_submit_report_message', NULL),
(14, 'allow_reports', '1'),
(15, 'allow_comments', '1'),
(16, 'allow_feed', '1'),
(17, 'allow_stat_sharing', '1'),
(18, 'allow_clustering', '1'),
(19, 'cache_pages', '0'),
(20, 'cache_pages_lifetime', '1800'),
(21, 'private_deployment', '0'),
(22, 'default_map', 'google_normal'),
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
(40, 'google_analytics', NULL),
(41, 'twitter_hashtags', NULL),
(42, 'blocks', 'news_block|reports_block'),
(43, 'blocks_per_row', '2'),
(44, 'date_modify', '2014-05-17 15:20:03'),
(45, 'stat_id', NULL),
(46, 'stat_key', NULL),
(47, 'email_username', NULL),
(48, 'email_password', NULL),
(49, 'email_port', NULL),
(50, 'email_host', NULL),
(51, 'email_servertype', NULL),
(52, 'email_ssl', NULL),
(53, 'ftp_server', NULL),
(54, 'ftp_user_name', NULL),
(55, 'alerts_email', NULL),
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores browser tokens assigned to users' AUTO_INCREMENT=1 ;

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores registered usersâ€™ information' AUTO_INCREMENT=2 ;

--
-- 轉存資料表中的資料 `users`
--

INSERT INTO `users` (`id`, `riverid`, `name`, `email`, `username`, `password`, `logins`, `last_login`, `notify`, `updated`, `color`, `code`, `confirmed`, `public_profile`, `approved`, `needinfo`) VALUES
(1, '', 'Administrator', 'admin@gg.tw', 'admin', '95bf499afd4867a272485ee3992339812ea23a87864a0f0af1', 4, 1400339906, 0, '2014-05-17 15:18:26', 'FF0000', NULL, 1, 0, 1, 0);

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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores all verified reports' AUTO_INCREMENT=1 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
