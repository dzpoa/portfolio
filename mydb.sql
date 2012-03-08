-- phpMyAdmin SQL Dump
-- version 3.4.9
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 06, 2012 at 10:03 PM
-- Server version: 5.1.56
-- PHP Version: 5.2.9

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `mydb`
--

-- --------------------------------------------------------

--
-- Table structure for table `about`
--

CREATE TABLE IF NOT EXISTS `about` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `me` text COLLATE utf8_unicode_ci NOT NULL,
  `site` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `about`
--

INSERT INTO `about` (`id`, `me`, `site`) VALUES
(1, 'Hi, my name is Daniel Zander, i''m Brazilian, naturalized german and a web developer for more than 10 years. I''m graduated in information systems by the University of Vale do Rio dos Sinos (Unisinos), and have worked in many web sites for important clients in Brasil.', 'I made this site with the proposal of showing my programming portfolio and, most important, my style of code. Feel free to download the source code <a href=''https://github.com/dzpoa/portfolio'' target=''_blank''>here</a> for analisys. The tools I used were:');

-- --------------------------------------------------------

--
-- Table structure for table `captcha`
--

CREATE TABLE IF NOT EXISTS `captcha` (
  `captcha_id` bigint(13) unsigned NOT NULL AUTO_INCREMENT,
  `captcha_time` int(10) unsigned NOT NULL,
  `ip_address` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `word` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`captcha_id`),
  KEY `word` (`word`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE IF NOT EXISTS `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`) VALUES
(1, 'Language'),
(2, 'Framework'),
(3, 'Library'),
(4, 'Database'),
(5, 'CMS');

-- --------------------------------------------------------

--
-- Table structure for table `client`
--

CREATE TABLE IF NOT EXISTS `client` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firm_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`,`firm_id`),
  KEY `fk_client_firm1` (`firm_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=23 ;

--
-- Dumping data for table `client`
--

INSERT INTO `client` (`id`, `firm_id`, `name`, `url`) VALUES
(1, 1, 'Anpad (Associação Nacional de Pós-Graduação e Pesquisa em Administração)', 'http://www.anpad.org.br/'),
(2, 2, 'Junior Achievement', 'http://www.jabrasil.org.br/'),
(3, 2, 'Qual é a Dúvida?', 'http://www.qued.com.br/'),
(4, 2, 'PGQP - Programa Gaúcho da Qualidade e Produtividade', 'http://www.mbc.org.br/mbc/pgqp/'),
(5, 4, 'Agência Branco', 'http://www.agenciabranco.com.br/'),
(6, 4, 'Agência Escala', 'http://www.agenciaescala.com.br/'),
(7, 4, 'Clube dos 13', 'http://clubedostreze.globo.com/'),
(8, 4, 'Dakota', 'http://www.dakota.com.br/'),
(9, 4, 'Fruki', 'http://www.fruki.com.br/'),
(10, 4, 'Hype Studio', 'http://www.hypestudio.com.br/'),
(11, 4, 'Isabela', 'http://www.isabela.com.br/'),
(12, 4, 'Pepsi', 'http://www.pepsico.com.br/'),
(13, 4, 'Loop Reclame', 'http://www.loopreclame.com.br/'),
(14, 4, 'Pinkcats', 'http://www.pinkcats.com.br/'),
(15, 4, 'Tok', 'http://www.tok.com.br/'),
(16, 4, 'Unimed', 'http://www.unimed.com.br/'),
(17, 5, 'Mazer', 'http://www.mazer.com.br/'),
(18, 5, 'Domínio da Moda', 'http://www.dominiodamoda.com.br/'),
(19, 5, 'Burger King', 'http://www.burgerking.com.br/'),
(20, 2, 'Cadastra', 'http://www.cadastra.com.br/'),
(21, 4, 'Renner', 'http://www.lojasrenner.com.br/'),
(22, 3, 'CoreRS', 'http://www.core-rs.org.br/');

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE IF NOT EXISTS `contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `company` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `message` text COLLATE utf8_unicode_ci NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `firm`
--

CREATE TABLE IF NOT EXISTS `firm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `branch` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

--
-- Dumping data for table `firm`
--

INSERT INTO `firm` (`id`, `name`, `branch`, `url`) VALUES
(1, 'SouthTech', 'Telecom', 'http://www.stech.net.br/'),
(2, 'Worbi', 'Internet', 'http://www.worbi.com.br/'),
(3, 'Hardlink', 'Hardware, Software', 'http://www.hardlink.com.br/'),
(4, 'Box3', 'Internet', 'http://www.box3.com.br/'),
(5, 'Tolv12', 'Internet', 'http://www.tolv12.com.br/');

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

CREATE TABLE IF NOT EXISTS `project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `year` year(4) NOT NULL,
  PRIMARY KEY (`id`,`client_id`),
  KEY `fk_project_client1` (`client_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=31 ;

--
-- Dumping data for table `project`
--

INSERT INTO `project` (`id`, `client_id`, `name`, `description`, `year`) VALUES
(1, 1, 'EMA', 'development and maintenance of the paper submission and evaluation system', 2005),
(2, 1, 'EnEO', 'development and maintenance of the paper submission and evaluation system', 2005),
(3, 1, 'EnANPAD', 'development and maintenance of the paper submission and evaluation system', 2005),
(4, 1, 'EMA', 'development and maintenance of the paper submission and evaluation system', 2006),
(5, 1, 'EnEO', 'development and maintenance of the paper submission and evaluation system', 2006),
(6, 1, 'EnANPAD', 'development and maintenance of the paper submission and evaluation system', 2006),
(7, 2, NULL, 'system maintenance', 2007),
(8, 3, NULL, 'system maintenance', 2007),
(9, 4, NULL, 'creation and execution of a database migration routine', 2007),
(10, 5, NULL, 'system maintenance', 2009),
(11, 6, NULL, 'system maintenance', 2010),
(12, 7, NULL, 'system maintenance', 2010),
(13, 8, 'Summer 2010', 'development, installation and maintanance of a management system, and also integration with Flash', 2009),
(14, 11, 'Tortinhas', 'development, installation and maintanance of a management system, and also integration with Flash', 2010),
(15, 14, NULL, 'development, installation and maintanance of a management system, and also integration with Flash', 2010),
(16, 15, 'Winter 2010', 'development, installation and maintanance of a management system, and also integration with Flash', 2010),
(17, 8, 'Winter 2010', 'development, installation and maintanance of a management system, and also integration with Flash', 2010),
(18, 10, '', 'development, installation and maintanance of a management system, and also integration with Flash', 2010),
(19, 8, 'Summer 2011', 'development, installation and maintanance of a management system, and also integration with Flash', 2010),
(20, 9, NULL, 'development, installation and maintanance of a management system, and also integration with Flash', 2010),
(21, 12, 'Pepsi Musica', 'development, installation and maintanance of a management system, and also integration with Flash', 2010),
(22, 13, NULL, 'development, installation and maintanance of a management system, and also integration with Flash', 2010),
(23, 16, 'Projeto Bem Estar', 'system installation and maintanance', 2009),
(24, 17, NULL, 'system development, installation, migration and maintanance', 2011),
(25, 18, NULL, 'system maintenance', 2011),
(26, 19, NULL, 'development and maintenance of a management system', 2011),
(27, 20, NULL, 'system maintenance', 2007),
(28, 21, 'Grito de Gol', 'development, installation and maintanance of a management system, and also integration with Flash', 2010),
(29, 8, 'Dakotinha', 'development, installation and maintanance of a management system, and also integration with Flash', 2009),
(30, 22, NULL, 'system development and installation', 2010);

-- --------------------------------------------------------

--
-- Table structure for table `project_has_technology`
--

CREATE TABLE IF NOT EXISTS `project_has_technology` (
  `project_id` int(11) NOT NULL,
  `technology_id` int(11) NOT NULL,
  PRIMARY KEY (`project_id`,`technology_id`),
  KEY `fk_project_has_technology_technology1` (`technology_id`),
  KEY `fk_project_has_technology_project1` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `project_has_technology`
--

INSERT INTO `project_has_technology` (`project_id`, `technology_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1),
(29, 1),
(30, 1),
(1, 2),
(2, 2),
(3, 2),
(4, 2),
(5, 2),
(6, 2),
(7, 2),
(8, 2),
(9, 2),
(11, 2),
(12, 2),
(13, 2),
(14, 2),
(15, 2),
(16, 2),
(17, 2),
(18, 2),
(19, 2),
(20, 2),
(21, 2),
(22, 2),
(23, 2),
(24, 2),
(25, 2),
(26, 2),
(27, 2),
(28, 2),
(29, 2),
(30, 2),
(1, 3),
(2, 3),
(3, 3),
(4, 3),
(5, 3),
(6, 3),
(7, 3),
(8, 3),
(9, 3),
(13, 3),
(15, 3),
(16, 3),
(17, 3),
(18, 3),
(19, 3),
(21, 3),
(22, 3),
(24, 3),
(26, 3),
(28, 3),
(29, 3),
(1, 4),
(2, 4),
(3, 4),
(4, 4),
(5, 4),
(6, 4),
(13, 4),
(15, 4),
(16, 4),
(17, 4),
(18, 4),
(19, 4),
(21, 4),
(22, 4),
(24, 4),
(26, 4),
(28, 4),
(29, 4),
(1, 5),
(2, 5),
(3, 5),
(4, 5),
(5, 5),
(6, 5),
(30, 5),
(14, 6),
(15, 6),
(16, 6),
(17, 6),
(18, 6),
(19, 6),
(21, 6),
(22, 6),
(24, 6),
(26, 6),
(28, 6),
(30, 6),
(13, 7),
(15, 7),
(16, 7),
(17, 7),
(18, 7),
(19, 7),
(21, 7),
(22, 7),
(24, 7),
(26, 7),
(28, 7),
(29, 7),
(30, 7),
(13, 8),
(15, 8),
(16, 8),
(17, 8),
(18, 8),
(19, 8),
(21, 8),
(22, 8),
(28, 8),
(29, 8),
(7, 9),
(8, 9),
(24, 10),
(12, 11),
(13, 11),
(14, 11),
(15, 11),
(16, 11),
(17, 11),
(18, 11),
(19, 11),
(21, 11),
(22, 11),
(24, 11),
(28, 11),
(29, 11),
(23, 12);

-- --------------------------------------------------------

--
-- Table structure for table `technology`
--

CREATE TABLE IF NOT EXISTS `technology` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`,`category_id`),
  KEY `fk_technology_category1` (`category_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=13 ;

--
-- Dumping data for table `technology`
--

INSERT INTO `technology` (`id`, `category_id`, `name`) VALUES
(1, 1, 'PHP'),
(2, 4, 'Mysql'),
(3, 1, 'HTML'),
(4, 1, 'CSS'),
(5, 1, 'Javascript'),
(6, 2, 'Codeigniter'),
(7, 3, 'Jquery'),
(8, 2, 'AMFPHP'),
(9, 5, 'Joomla'),
(10, 1, 'XML'),
(11, 3, 'JSON'),
(12, 5, 'Wordpress');

-- --------------------------------------------------------

--
-- Table structure for table `tool`
--

CREATE TABLE IF NOT EXISTS `tool` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=10 ;

--
-- Dumping data for table `tool`
--

INSERT INTO `tool` (`id`, `description`) VALUES
(1, 'Codeigniter, a PHP MVC framework'),
(2, 'DataMapper, an Object Relational Mapper for Codeigniter'),
(3, 'Smarty, a template engine for PHP'),
(4, 'Jquery, a Javascript library'),
(5, 'Jquery UI, a jQuery user interface library'),
(6, 'wTooltip, a Jquery Tooltip Plugin'),
(7, 'jSlideto, an animated scrollto effect jQuery plugin'),
(8, 'jpGraph, a PHP graph drawing library'),
(9, 'Google Web Fonts, a collection of Open Source fonts');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `client`
--
ALTER TABLE `client`
  ADD CONSTRAINT `fk_client_firm1` FOREIGN KEY (`firm_id`) REFERENCES `firm` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `project`
--
ALTER TABLE `project`
  ADD CONSTRAINT `fk_project_client1` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `project_has_technology`
--
ALTER TABLE `project_has_technology`
  ADD CONSTRAINT `fk_project_has_technology_project1` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_project_has_technology_technology1` FOREIGN KEY (`technology_id`) REFERENCES `technology` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `technology`
--
ALTER TABLE `technology`
  ADD CONSTRAINT `fk_technology_category1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
