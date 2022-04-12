-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 12, 2022 at 05:33 AM
-- Server version: 5.5.39
-- PHP Version: 5.4.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `amsal`
--

-- --------------------------------------------------------

--
-- Table structure for table `sys_groups`
--

CREATE TABLE IF NOT EXISTS `sys_groups` (
  `groupid` int(11) NOT NULL COMMENT 'Primary Key: (by system)',
  `parent_id` int(11) DEFAULT NULL COMMENT 'Grup induk: merujuk ke tabel sys_groups kolom groupid',
  `level` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Level tree (by system)',
  `lft` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set left:(by system)',
  `rgt` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set right:(by system)',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT 'Nama Grup: isian bebas',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT 'Keterangan: isian bebas',
  `enable` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Aktif: pilihan 1=Ya; 0=Tidak',
  `ordering` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Urutan Grup Per Induknya',
  `inter_exter` tinyint(1) NOT NULL COMMENT 'Pegawai Internal = 1; Pegawai External = 2',
  `lock_by` varchar(30) NOT NULL DEFAULT '' COMMENT 'Diedit Oleh: (by system)',
  `lock_on` datetime DEFAULT NULL COMMENT 'Diedit Tanggal: (by system)',
  `created_by` varchar(30) DEFAULT NULL COMMENT 'Diinput Oleh: (by system)',
  `created_on` datetime DEFAULT NULL COMMENT 'Diinput Tanggal: (by system)',
  `modified_by` varchar(30) DEFAULT NULL COMMENT 'Diperbaharui Oleh: (by system)',
  `modified_on` datetime DEFAULT NULL COMMENT 'Diperbaharui Tanggal: (by system)'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Data Grup User aplikasi';

--
-- Dumping data for table `sys_groups`
--

INSERT INTO `sys_groups` (`groupid`, `parent_id`, `level`, `lft`, `rgt`, `name`, `description`, `enable`, `ordering`, `inter_exter`, `lock_by`, `lock_on`, `created_by`, `created_on`, `modified_by`, `modified_on`) VALUES
(-1, NULL, 0, 1, 62, 'Root', 'Root', 1, 1, 0, '', NULL, NULL, NULL, NULL, NULL),
(1, -1, 1, 2, 61, 'Super Administrator', 'Super Administrator', 1, 1, 0, 'system', '2013-02-08 11:02:03', '', NULL, 'admin', '2012-11-13 12:44:56'),
(2, 1, 2, 3, 4, 'Ketua Mahkamah Syar''iyah', 'Ketua Mahkamah Syar''iyah', 1, 1, 1, '', NULL, 'admin', '2017-10-08 08:43:05', '', NULL),
(3, 1, 2, 5, 6, 'Wakil Ketua Mahkamah Syar''iyah', 'Wakil Ketua Mahkamah Syar''iyah', 1, 2, 1, '', NULL, 'admin', '2017-10-08 08:43:20', '', '2017-10-08 08:45:17'),
(4, 1, 2, 7, 46, 'Panitera', 'Panitera', 1, 3, 1, '', NULL, 'admin', '2017-10-08 08:46:01', '', '2017-10-08 08:46:24'),
(5, 4, 3, 8, 11, 'Panitera Muda Jinayat', 'Kepaniteraan Muda Jinayat', 1, 1, 1, '', NULL, 'admin', '2017-10-08 08:46:44', '', NULL),
(6, 4, 3, 12, 15, 'Panitera Muda Banding', 'Kepaniteraan Muda Banding', 1, 2, 1, '', NULL, 'admin', '2017-10-08 08:47:38', '', NULL),
(7, 4, 3, 16, 19, 'Panitera Muda Hukum', 'Kepaniteraan Muda hukum', 1, 3, 1, '', NULL, 'admin', '2017-10-08 08:48:06', '', NULL),
(8, 4, 4, 20, 21, 'Panitera Pengganti', '', 1, 10, 1, '', NULL, 'admin', '2017-10-08 08:52:49', '', NULL),
(9, 4, 4, 22, 23, 'Jurusita / Jurusita Pengganti', '', 1, 11, 1, '', NULL, 'admin', '2017-10-08 08:53:18', '', NULL),
(13, 16, 4, 49, 52, 'Kepala Sub Bagian Keuangan dan Pelaporan', 'Sub Bagian Keuangan dan Pelaporan', 1, 9, 1, '', NULL, 'admin', '2017-10-08 08:52:02', '', NULL),
(16, 1, 2, 47, 80, 'Sekretaris', 'Sekretaris', 1, 4, 1, '', NULL, 'admin', '2017-10-08 08:54:41', '', NULL),
(17, 16, 4, 58, 61, 'Kepala Sub Bagian Kepegawaian dan TI', 'Sub Bagian Kepegawaian, Organisasi dan Tatalaksana', 1, 1, 1, '', NULL, 'admin', '2017-10-08 08:55:50', '', '2017-10-08 08:58:29'),
(18, 16, 4, 62, 65, 'Kepala Sub Bagian Renprog\r\n', 'Sub Bagian Perencanaan, Teknologi Informasi dan Pelaporan', 1, 2, 1, '', NULL, 'admin', '2017-10-08 08:59:20', '', NULL),
(19, 16, 4, 53, 56, 'Kepala Sub Bagian TURT', 'Sub Bagian Umum dan Keuangan', 1, 3, 1, '', NULL, 'admin', '2017-10-08 08:59:54', '', NULL),
(20, 5, 4, 9, 10, 'Staf Panitera Muda Jinayat', '', 0, 1, 1, '', NULL, 'admin', '2017-10-08 09:04:32', '', NULL),
(21, 6, 4, 13, 14, 'Staf Panitera Muda Banding', '', 0, 1, 1, '', NULL, 'admin', '2017-10-08 09:04:45', '', NULL),
(22, 7, 4, 17, 18, 'Staf  Panitera Muda Hukum', '', 0, 1, 1, '', NULL, 'admin', '2017-10-08 09:04:57', '', NULL),
(23, 13, 5, 51, 52, 'Staf Sub Bagian Keuangan dan Pelaporan', '', 0, 1, 1, '', NULL, 'admin', '2017-10-08 09:05:11', '', NULL),
(24, 16, 4, 65, 66, 'Pranata Komputer', '', 1, 1, 1, '', NULL, 'admin', '2017-10-08 09:05:24', '', NULL),
(25, 10, 4, 67, 68, 'Pengelola Keuangan', '', 1, 1, 1, '', NULL, 'admin', '2017-10-08 09:05:40', '', NULL),
(26, 11, 4, 69, 70, 'Pranata Keuangan', '', 1, 1, 1, '', NULL, 'admin', '2017-10-08 09:05:52', '', NULL),
(27, 4, 4, 24, 25, 'Pranata Peradilan', '', 1, 1, 1, '', NULL, 'admin', '2017-10-08 09:06:10', '', NULL),
(28, 17, 5, 60, 61, 'Staf Sub Bagian Kepegawaian dan TI', '', 0, 1, 1, '', NULL, 'admin', '2017-10-08 09:06:53', '', NULL),
(29, 18, 5, 64, 65, 'Staf Sub Bagian Renprog', '', 0, 1, 1, '', NULL, 'admin', '2017-10-08 09:07:06', '', NULL),
(30, 19, 5, 55, 56, 'Staf Sub Bagian Sub Bagian TURT', '', 0, 1, 1, '', NULL, 'admin', '2017-10-08 09:07:21', '', NULL),
(31, 16, 3, 48, 56, 'Kabag Umum dan Keuangan', 'Sub Bagian Umum dan Keuangan', 1, 4, 1, '', NULL, 'admin', '2017-10-08 08:48:50', '', '2017-10-08 08:49:09'),
(32, 16, 3, 57, 64, 'Kabag Perencanaan dan Kepegawaian', 'Sub Bagian Perencanaan dan Kepegawaian', 1, 5, 1, '', NULL, 'admin', '2017-10-08 08:49:50', '', '2017-10-08 09:03:51'),
(33, 2, 2, 71, 72, 'Pengurus IKAHI', 'Pengurus IKAHI', 1, 1, 1, '', NULL, NULL, NULL, NULL, NULL),
(34, 2, 2, 73, 74, 'Pengurus IPASPI', 'Pengurus IPASPI', 1, 1, 1, '', NULL, NULL, NULL, NULL, NULL),
(35, 2, 2, 75, 76, 'Pengurus PTWP', 'Pengurus PTWP', 1, 1, 1, '', NULL, NULL, NULL, NULL, NULL),
(36, 2, 2, 77, 78, 'Pengurus Dharmayukti Karini', 'Pengurus Dharmayukti Karini', 1, 1, 1, '', NULL, NULL, NULL, NULL, NULL),
(37, 2, 2, 79, 80, 'Pengurus Koperasi', 'Pengurus Koperasi', 1, 1, 1, '', NULL, NULL, NULL, NULL, NULL),
(38, 2, 2, 81, 82, 'Pengurus PPHIMM', 'Pengurus PPHIMM', 1, 1, 1, '', NULL, NULL, NULL, NULL, NULL),
(39, 2, 2, 83, 84, 'Pengurus ZIS', 'Pengurus ZIS', 1, 1, 1, '', NULL, NULL, NULL, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `sys_groups`
--
ALTER TABLE `sys_groups`
 ADD PRIMARY KEY (`groupid`), ADD UNIQUE KEY `idx_groups_parent_title_lookup` (`parent_id`,`name`), ADD KEY `idx_groups_title_lookup` (`name`), ADD KEY `idx_groups_adjacency_lookup` (`parent_id`), ADD KEY `level` (`level`), ADD KEY `ordering` (`ordering`), ADD KEY `idx_groups_nested_set_lookup` (`lft`,`rgt`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
