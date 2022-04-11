-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 11, 2022 at 09:46 AM
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

DELIMITER $$
--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `getTreeName`(`var_level` INTEGER(11), `var_nama` VARCHAR(150)) RETURNS varchar(255) CHARSET latin1
BEGIN
    DECLARE var_hasil varchar(255);
    DECLARE a INT Default 0 ;
    IF var_level=0 THEN
    	SET var_hasil=var_nama;
    #ELSEIF var_level=1 THEN 
    #	SET var_hasil=concat('&nbsp;+- ', var_nama);
    ELSE
    	SET var_hasil='';
    	simple_loop: LOOP
			SET a=a+1;
			IF a=var_level THEN
				SET var_hasil= concat(var_hasil, '|-- ');
				LEAVE simple_loop;	
            ELSE
            	SET var_hasil= concat(var_hasil, '|-- ');
			END IF;
		END LOOP simple_loop;
        SET var_hasil= concat(var_hasil, var_nama);
			
    END IF;
	
  RETURN var_hasil;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `agama`
--

CREATE TABLE IF NOT EXISTS `agama` (
  `id` int(11) unsigned NOT NULL COMMENT 'Primary key (by system)',
  `nama` varchar(50) NOT NULL DEFAULT '' COMMENT 'Nama: isian bebas',
  `keterangan` varchar(255) DEFAULT NULL COMMENT 'Keterangan: isian bebas',
  `aktif` char(1) NOT NULL DEFAULT 'Y' COMMENT 'Status Aktif: pilihan Y=Ya; T=Tidak',
  `diedit_oleh` varchar(30) DEFAULT NULL COMMENT 'Diedit Oleh: (by system)',
  `diedit_tanggal` datetime DEFAULT NULL COMMENT 'Diedit Tanggal: (by system)',
  `diinput_oleh` varchar(30) DEFAULT NULL COMMENT 'Diinput Oleh: (by system)',
  `diinput_tanggal` datetime DEFAULT NULL COMMENT 'Diinput Tanggal: (by system)',
  `diperbaharui_oleh` varchar(30) DEFAULT NULL COMMENT 'Diperbaharui Oleh: (by system)',
  `diperbaharui_tanggal` datetime DEFAULT NULL COMMENT 'Diperbaharui Tanggal: (by system)'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Referensi Agama';

--
-- Dumping data for table `agama`
--

INSERT INTO `agama` (`id`, `nama`, `keterangan`, `aktif`, `diedit_oleh`, `diedit_tanggal`, `diinput_oleh`, `diinput_tanggal`, `diperbaharui_oleh`, `diperbaharui_tanggal`) VALUES
(1, 'Islam', '', 'Y', '', NULL, NULL, NULL, 'admin', '2012-03-12 00:33:07'),
(2, 'Protestan', NULL, 'Y', 'admin', '2012-06-29 13:34:09', NULL, NULL, '1', '2010-11-08 12:34:51'),
(3, 'Katolik', NULL, 'Y', NULL, NULL, NULL, NULL, NULL, NULL),
(4, 'Budha', NULL, 'Y', '', NULL, NULL, NULL, NULL, NULL),
(5, 'Hindu', NULL, 'Y', '', NULL, NULL, NULL, NULL, NULL),
(6, 'Kong Hu Cu', '', 'Y', '', NULL, '', NULL, 'system', '2012-11-01 00:56:41'),
(7, 'Lainnya', NULL, 'Y', NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `jenis_identitas`
--

CREATE TABLE IF NOT EXISTS `jenis_identitas` (
  `id` tinyint(4) NOT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `diinput_oleh` varchar(30) DEFAULT NULL,
  `diinput_tanggal` datetime DEFAULT NULL,
  `diperbaharui_oleh` varchar(30) DEFAULT NULL,
  `diperbaharui_tanggal` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `jenis_identitas`
--

INSERT INTO `jenis_identitas` (`id`, `nama`, `diinput_oleh`, `diinput_tanggal`, `diperbaharui_oleh`, `diperbaharui_tanggal`) VALUES
(1, 'Kartu BPJS', 'System', '2015-04-24 10:04:26', NULL, NULL),
(2, 'Kartu Keluarga', 'System', '2015-04-24 10:04:26', NULL, NULL),
(3, 'Kartu Pelajar', 'System', '2015-04-24 10:04:26', NULL, NULL),
(4, 'KTP', 'System', '2015-04-24 10:04:26', NULL, NULL),
(5, 'Paspor', 'System', '2015-04-24 10:04:26', NULL, NULL),
(6, 'SIM', 'System', '2015-04-24 10:04:26', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pegawai`
--

CREATE TABLE IF NOT EXISTS `pegawai` (
  `id` int(11) unsigned NOT NULL COMMENT 'Primary key: (by system)',
  `nip` varchar(20) DEFAULT '' COMMENT 'NIP(Nomor Induk Pegawai): isian bebas',
  `nama` varchar(50) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL COMMENT 'Nama Lengkap (tanpa gelar dan singkatan): isian bebas',
  `nama_gelar` varchar(50) DEFAULT NULL COMMENT 'Nama Lengkap Dengan Gelar: isian bebas',
  `golongan_id` int(11) DEFAULT NULL COMMENT 'ref_pangkat',
  `golongan` varchar(20) DEFAULT NULL,
  `pangkat` varchar(30) DEFAULT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `keterangan` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT '' COMMENT 'Keterangan: isian bebas',
  `aktif` char(1) NOT NULL DEFAULT 'Y' COMMENT 'Status Aktif: pilihan Y=Ya; T=Tidak',
  `foto` blob,
  `jabatan_id` int(11) DEFAULT NULL,
  `jabatan_nama` varchar(255) DEFAULT NULL,
  `chatid` int(11) DEFAULT NULL,
  `diinput_oleh` varchar(30) DEFAULT '' COMMENT 'Diinput Oleh: (by system)',
  `diinput_tanggal` datetime DEFAULT NULL COMMENT 'Diinput Tanggal: (by system)',
  `diperbaharui_oleh` varchar(30) DEFAULT '' COMMENT 'Diperbaharui Oleh: (by system)',
  `diperbaharui_tanggal` datetime DEFAULT NULL COMMENT 'Diperbaharui Tanggal: (by system)'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Referensi Panitera Pengadilan Negeri';

--
-- Dumping data for table `pegawai`
--

INSERT INTO `pegawai` (`id`, `nip`, `nama`, `nama_gelar`, `golongan_id`, `golongan`, `pangkat`, `alamat`, `keterangan`, `aktif`, `foto`, `jabatan_id`, `jabatan_nama`, `chatid`, `diinput_oleh`, `diinput_tanggal`, `diperbaharui_oleh`, `diperbaharui_tanggal`) VALUES
(1, '195412081979032007', '', 'Dra. Hj. Rosmawardani, S.H., M.H', 18, 'IV/e', 'Pembina Utama', 'Banda Aceh', '', 'Y', NULL, 2, 'Ketua Pengadilan', NULL, 'admin', '2021-08-04 03:29:18', '', NULL),
(2, '196202101994031003', '', 'Drs. Syafruddin', 17, 'IV/d', 'Pembina Utama Madya', 'Banda Aceh', '', 'Y', NULL, 4, 'Panitera', NULL, 'admin', '2021-08-04 03:30:14', '', NULL),
(3, '195803141983031004', '', 'Rafi', 18, 'IV/e', 'Pembina Utama', 'Banda Aceh', '', 'Y', NULL, 3, 'Wakil Ketua Pengadilan', NULL, 'admin', '2021-08-04 04:13:03', '', NULL),
(4, '-', '', 'latif', 14, 'IV/a', 'Pembina', 'Banda Aceh', '', 'Y', NULL, 6, 'Panitera Muda Perdata', NULL, 'admin', '2021-08-04 04:13:43', 'admin', '2021-08-04 04:51:33'),
(5, '-', '', 'bahrun', 14, 'IV/a', 'Pembina', 'Banda Aceh', '', 'Y', NULL, 19, 'Kepala Sub Bagian Umum dan Keuangan aceh', NULL, 'admin', '2021-08-04 04:14:13', '', NULL),
(6, '-', '', 'Khairuddin, S.H., M.H.', 17, 'IV/d', 'Pembina Utama Madya', 'Banda Aceh', '', 'Y', NULL, 16, 'Sekretaris', 226437812, 'admin', '2021-08-04 04:50:09', '', NULL),
(7, '-', '', 'Drs. Ilyas, S.H., M.H', 14, 'IV/a', 'Pembina', 'Banda Aceh', '', 'Y', NULL, 7, 'Panitera Muda Hukum', NULL, 'admin', '2021-08-04 04:51:17', 'admin', '2021-08-04 04:51:39'),
(8, '-', '', 'ratna', 14, 'IV/a', 'Pembina', 'Banda Aceh', '', 'Y', NULL, 5, 'Panitera Muda Pidana', NULL, 'admin', '2021-08-04 04:52:01', '', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pengadilan_negeri`
--

CREATE TABLE IF NOT EXISTS `pengadilan_negeri` (
  `id` int(11) unsigned NOT NULL,
  `pt_id` int(11) unsigned DEFAULT NULL,
  `kode` varchar(50) DEFAULT NULL,
  `kode_pn` varchar(20) DEFAULT NULL,
  `nama` varchar(100) NOT NULL,
  `alamat` varchar(500) DEFAULT NULL,
  `aktif` char(1) NOT NULL DEFAULT 'Y',
  `jenis_pengadilan` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pengadilan_negeri`
--

INSERT INTO `pengadilan_negeri` (`id`, `pt_id`, `kode`, `kode_pn`, `nama`, `alamat`, `aktif`, `jenis_pengadilan`) VALUES
(1, 1, '98441', 'BNA', 'PENGADILAN NEGERI BANDA ACEH', 'Jl Cut Meutia N0 23', 'Y', 1),
(2, 1, '98455', '', 'PENGADILAN NEGERI SABANG', 'jl Jend. Ahmad Yani no 04', 'Y', 1),
(3, 1, '98462', '', 'PENGADILAN NEGERI SIGLI', 'Jl. Tgk. Chik Ditiro No. 48', 'Y', 1),
(4, 1, '98476', '', 'PENGADILAN NEGERI BIREUEN', 'Jl Sultan Malaikussaleh', 'Y', 1),
(5, 1, '98480', 'LSK', 'PENGADILAN NEGERI LHOKSUKON', 'Jl. T.P Polem no 3', 'Y', 1),
(6, 1, '98497', '', 'PENGADILAN NEGERI LHOKSEUMAWE', 'Jl Iskandar Muda', 'Y', 1),
(7, 1, '98502', '', 'PENGADILAN NEGERI TAKENGON', 'Jl. Yos Sudarso no 154 Takengon', 'Y', 1),
(8, 1, '98519', '', 'PENGADILAN NEGERI LANGSA', 'Jl. W.R Supratman No 10', 'Y', 1),
(9, 1, '98523', '', 'PENGADILAN NEGERI IDI', 'Jl. Petua Husin No 4', 'Y', 1),
(10, 1, '98530', '', 'PENGADILAN NEGERI KUALA SIMPANG', 'Jl. Ir. H. juanda Karang Baru no 22', 'Y', 1),
(11, 1, '98544', '', 'PENGADILAN NEGERI BLANGKEJEREN', 'Jl Kongbur no 52', 'Y', 1),
(12, 1, '98551', '', 'PENGADILAN NEGERI KUTACANE', 'Jl Cut Nyak Dien No 174', 'Y', 1),
(13, 1, '98565', '', 'PENGADILAN NEGERI MEULABOH', 'Jl. Dr .Sutomo No 5', 'Y', 1),
(14, 1, '98572', '', 'PENGADILAN NEGERI CALANG', 'Jl. Pengadilan No. 10', 'Y', 1),
(15, 1, '98586', '', 'PENGADILAN NEGERI SINABANG', 'Jl. T. Diujung No406', 'Y', 1),
(16, 1, '98590', '', 'PENGADILAN NEGERI TAPAKTUAN', 'Jl. syech abdurauf No 11', 'Y', 1),
(17, 1, '98608', '', 'PENGADILAN NEGERI SINGKIL', 'Jl Singkil Km 20', 'Y', 1),
(18, 1, '400415', '', 'PENGADILAN NEGERI JANTHO', 'JL. Bachtiar Panglima Polem No 3', 'Y', 1),
(19, 2, '98629', 'MDN', 'PENGADILAN NEGERI MEDAN', 'Jl. Pengadilan No. 8 Medan', 'Y', 1),
(20, 2, '98633', '', 'PENGADILAN NEGERI BINJAI', 'Jl. Jend. Gatot Subroto No. 77', 'Y', 1),
(21, 2, '98640', '', 'PENGADILAN NEGERI TANJUNG BALAI ASAHAN', 'Jl. Pahlawan No. 9 Tanjungbalai', 'Y', 1),
(22, 2, '98654', 'SDK', 'PENGADILAN NEGERI SIDIKALANG', 'Jl. Ahmad Yani No. 133', 'Y', 1),
(23, 2, '98661', '', 'PENGADILAN NEGERI KABANJAHE', 'Jl. Jamin Ginting No. 9 Kabanjahe', 'Y', 1),
(24, 2, '98675', '', 'PENGADILAN NEGERI RANTAU PRAPAT', 'Jl. Sisingamangaraja No. 58 Rantauprapat', 'Y', 1),
(25, 2, '98682', 'TTD', 'PENGADILAN NEGERI TEBING TINGGI', 'Jl. Merdeka No. 2 Tebing Tinggi', 'Y', 1),
(26, 2, '98696', '', 'PENGADILAN NEGERI GUNUNG SITOLI', 'Jl. Pancasila No. 12 Gunungsitoli', 'Y', 1),
(27, 2, '98701', '', 'PENGADILAN NEGERI PEMATANG SIANTAR', 'Jl. Jend. Sudirman No. 15 Pematangsiantar', 'Y', 1),
(28, 2, '98718', '', 'PENGADILAN NEGERI TARUTUNG', 'Jl. MAYJEN YUNUS SAMOSIR NO 93 TARUTUNG', 'Y', 1),
(29, 2, '98722', '', 'PENGADILAN NEGERI PADANG SIDEMPUAN', 'Jl. Jend. Sudirman No. 10 Padangsidimpuan', 'Y', 1),
(30, 2, '98739', '', 'PENGADILAN NEGERI SIBOLGA', 'Jl. Padangsidimpuan No. 6 Sibolga', 'Y', 1),
(31, 2, '108025', 'STB', 'PENGADILAN NEGERI STABAT', 'Jl. Proklamasi No. 49 Stabat', 'Y', 1),
(32, 2, '400370', '', 'PENGADILAN NEGERI SIMALUNGUN', 'Jl. Asahan Km. 4  Kec. Siantar, Kab. Simalungun', 'Y', 1),
(33, 2, '400389', '', 'PENGADILAN NEGERI KISARAN', 'Jl. Ahmad Yani No. 33 Kisaran', 'Y', 1),
(34, 2, '400395', '', 'PENGADILAN NEGERI LUBUK PAKAM', 'Jl. Jend. Sudirman No. 58 Lubuk Pakam', 'Y', 1),
(35, 2, '477399', '', 'PENGADILAN NEGERI MANDAILING NATAL', 'Jl. Lintas Sumatera Km. 7 Panyabungan', 'Y', 1),
(36, 2, '672910', '', 'PENGADILAN NEGERI BALIGE', 'Jl. Patuan Nagari No. 6 Balige', 'Y', 1),
(37, 3, '98750', '', 'PENGADILAN NEGERI PADANG', 'Jl. Khatib Sulaiman No.80 Padang', 'Y', 1),
(38, 3, '98764', 'SWL', 'PENGADILAN NEGERI SAWAHLUNTO', 'Jl. Jenderal Sudirman No. 3 Sawahlunto', 'Y', 1),
(39, 3, '98771', '', 'PENGADILAN NEGERI BATUSANGKAR', 'Jln. Lareh Nan Panjang No.103', 'Y', 1),
(40, 3, '98785', '', 'PENGADILAN NEGERI SOLOK', 'Jl. Lubuk Sikarah No. 32', 'Y', 1),
(41, 3, '98792', '', 'PENGADILAN NEGERI PARIAMAN', 'Jl. Imam Bonjol No. 26', 'Y', 1),
(42, 3, '98807', '', 'PENGADILAN NEGERI PAINAN', 'Jl. Jenderal Sudirman No. 158 Salido Painan', 'Y', 1),
(43, 3, '98811', '', 'PENGADILAN NEGERI BUKITTINGGI', 'Jl. Veteran No. 219 A Kota Bukittinggi', 'Y', 1),
(44, 3, '98828', '', 'PENGADILAN NEGERI LUBUK SIKAPING', 'Jl. Sudirman No.64', 'Y', 1),
(45, 3, '98832', '', 'PENGADILAN NEGERI PAYAKUMBUH', 'Jl. Soekarno Hatta No. 240', 'Y', 1),
(46, 3, '400188', 'PP', 'PENGADILAN NEGERI PADANG PANJANG', 'Jl.Soekarno Hatta, No.7', 'Y', 1),
(47, 3, '400333', '', 'PENGADILAN NEGERI LUBUK BASUNG', 'Jl. DR. M. Hatta No. 538', 'Y', 1),
(48, 3, '400421', '', 'PENGADILAN NEGERI TANJUNG PATI', 'JALAN RAYA NEGARA KM.7 TANJUNG PATI', 'Y', 1),
(49, 3, '400446', '', 'PENGADILAN NEGERI KOTOBARU', 'Jl. Raya Koto Baru', 'Y', 1),
(50, 3, '400461', 'MR', 'PENGADILAN NEGERI MUARO', 'Jl. Prof. M. Yamin, SH No. 51  Muaro Sijunjung', 'Y', 1),
(51, 3, '477352', '', 'PENGADILAN NEGERI PASAMAN BARAT', 'JL. SOEKARNO-HATTA', 'Y', 1),
(52, 4, '98849', '', 'PENGADILAN NEGERI PEKANBARU', 'Jl. Teratai No.85', 'Y', 1),
(53, 4, '98853', '', 'PENGADILAN NEGERI BENGKALIS', 'Jl. Karimun No. 12 Bengkalis', 'Y', 1),
(54, 4, '98860', '', 'PENGADILAN NEGERI RENGAT/INDRAGIRI', 'Jl. Raya Belilas Pematang Reba', 'Y', 1),
(55, 4, '98874', '', 'PENGADILAN NEGERI TEMBILAHAN', 'JL. PROF. M. YAMIN, SH. NO. 02', 'Y', 1),
(56, 4, '400141', '', 'PENGADILAN NEGERI BANGKINANG', 'Jl. Letnan Boyak No. 77 Bangkinang', 'Y', 1),
(57, 4, '400327', '', 'PENGADILAN NEGERI DUMAI', 'Jl.RAYA BUKIT DATUK', 'Y', 1),
(58, 4, '477255', 'PLW', 'PENGADILAN NEGERI PELALAWAN', 'Jl. Hangtuah SP. VI Pangkalan Kerinci', 'Y', 1),
(59, 4, '477261', 'RHL', 'PENGADILAN NEGERI ROKAN HILIR', 'Jl. Lintas Riau-Sumut KM 167 Banjar XII Ujung Tanjung', 'Y', 1),
(60, 4, '477343', '', 'PENGADILAN NEGERI SIAK SRI INDRAPURA', 'Komplek Perkantoran Tanjung Agung', 'Y', 1),
(61, 4, '662990', '', 'PENGADILAN NEGERI PASIR PENGARAIAN', 'Jl. Diponegoro No. 102 Pasir Pangaraian', 'Y', 1),
(62, 5, '98895', '', 'PENGADILAN NEGERI JAMBI', 'Jl. A. Yani No. 16', 'Y', 1),
(63, 5, '98900', '', 'PENGADILAN NEGERI MUARA BUNGO', 'R.M. THAHER No. 495', 'Y', 1),
(64, 5, '98917', '', 'PENGADILAN NEGERI KUALA TUNGKAL', 'Jl. Prof. Dr. Sri Soedewi MS, SH Kuala Tungkal', 'Y', 1),
(65, 5, '98921', '', 'PENGADILAN NEGERI SUNGAI PENUH', 'Jl. Depati Parbo No.24', 'Y', 1),
(66, 5, '400311', '', 'PENGADILAN NEGERI BANGKO', 'JL. JEND. SUDIRMAN KM.2 BANGKO', 'Y', 1),
(67, 5, '400430', '', 'PENGADILAN NEGERI MUARA BULIAN', 'Jend. Sudirman Muara Bulian', 'Y', 1),
(68, 5, '477368', '', 'PENGADILAN NEGERI TEBO', 'Komp. Perkantoran Seentak Galah Serengkuh Dayung Jalan Lintas Tebo-Bungo Km.12 Muara Tebo', 'Y', 1),
(69, 5, '477374', '', 'PENGADILAN NEGERI SAROLANGUN', 'Komplek Perkantoran Gunung Kembang', 'Y', 1),
(70, 5, '477400', '', 'PENGADILAN NEGERI TANJUNG JABUNG TIMUR', 'Komplek Perkantoran Bukit Menderang', 'Y', 1),
(71, 5, '663012', '', 'PENGADILAN NEGERI SENGETI', 'Jl. Lintar Timur Sengeti', 'Y', 1),
(72, 6, '98942', 'PLG', 'PENGADILAN NEGERI PALEMBANG', 'JL. KAPTEN A. RIVAI NO.16', 'Y', 1),
(73, 6, '98959', 'KAG', 'PENGADILAN NEGERI KAYUAGUNG', 'JL. LETNAN MUCHTAR SALEH NO. 119', 'Y', 1),
(74, 6, '98963', 'BTA', 'PENGADILAN NEGERI BATURAJA', 'Jl.HS.Simanjuntak No.0792', 'Y', 1),
(75, 6, '98970', '', 'PENGADILAN NEGERI LUBUK LINGGAU', 'JL.DEPATI SAID,No. 01, Kel. SIDOREJO', 'Y', 1),
(76, 6, '98984', '', 'PENGADILAN NEGERI LAHAT', 'Jalan Kolonel Barlian Bandar Jaya', 'Y', 1),
(77, 6, '98991', '', 'PENGADILAN NEGERI MUARA ENIM', 'JL. JEND. AHMAD YANI NO. 17 A', 'Y', 1),
(78, 6, '99003', '', 'PENGADILAN NEGERI SEKAYU', 'JL. MERDEKA NO.485 LK.I SEKAYU', 'Y', 1),
(79, 8, '400452', '', 'PENGADILAN NEGERI KALIANDA', 'Jl. Indra Bangsawan No. 37 Kalianda', 'Y', 1),
(80, 7, '400110', '', 'PENGADILAN NEGERI BENGKULU', 'Jl. S. PArman', 'Y', 1),
(81, 7, '400126', '', 'PENGADILAN NEGERI CURUP', 'jl. Basuki Rahmat No. 15 curup', 'Y', 1),
(82, 7, '400132', '', 'PENGADILAN NEGERI MANNA', 'Jl. Affan Bachsin No. 109 Manna', 'Y', 1),
(83, 7, '400239', '', 'PENGADILAN NEGERI ARGA MAKMUR', 'isi', 'Y', 1),
(84, 7, '672994', '', 'PENGADILAN NEGERI BINTUHAN', 'Jl. Pengadilan - Padang Kempas Kab. Kaur', 'Y', 1),
(85, 7, '673041', '', 'PENGADILAN NEGERI KEPAHIANG', 'Jl. Aipda Muan Komplek Perkantoran Pemkab Kepahiang', 'Y', 1),
(86, 8, '99031', '', 'PENGADILAN NEGERI TANJUNG KARANG', 'Jl. Wolter Monginsidi No. 27 Tanjung Karang', 'Y', 1),
(87, 8, '99045', '', 'PENGADILAN NEGERI METRO', 'Jl. Sutan Sjahrir, Kota Metro', 'Y', 1),
(88, 8, '99052', '', 'PENGADILAN NEGERI KOTABUMI', 'Jl. Jend. Sudirman No. 136 Kotabumi', 'Y', 1),
(89, 8, '477306', '', 'PENGADILAN NEGERI KOTA AGUNG', 'Jl. Jend. Suprapto Kota Agung,', 'Y', 1),
(90, 8, '614883', '', 'PENGADILAN NEGERI LIWA KABUPATEN LAMPUNG BARAT', 'Jl. Raden Intan Liwa', 'Y', 1),
(91, 8, '663026', '', 'PENGADILAN NEGERI MENGGALA', 'Jl. Cemara Komp. Perkantoran Pemda Tulang Bawang', 'Y', 1),
(92, 8, '663030', '', 'PENGADILAN NEGERI GUNUNG SUGIH', 'Jl. Negara Gunung Sugih', 'Y', 1),
(93, 8, '663047', '', 'PENGADILAN NEGERI SUKADANA', 'Jl. Sampurna Jaya No. 1 Sukadana', 'Y', 1),
(94, 8, '663051', '', 'PENGADILAN NEGERI BLAMBANGAN UMPU', 'Jl. R. Jambat No. 65 Blambangan Umpu', 'Y', 1),
(95, 9, '99010', '', 'PENGADILAN NEGERI PANGKALPINANG', 'Jl. Jendral Sudirman No.09 Pangkalpinang', 'Y', 1),
(96, 9, '99024', '', 'PENGADILAN NEGERI SUNGAI LIAT', 'Jl. Pemuda no. 12 Sungailiat', 'Y', 1),
(97, 9, '400600', '', 'PENGADILAN NEGERI TANJUNG PANDAN', 'Jl. Sriwijaya No. 1  Tanjungpandan', 'Y', 1),
(98, 4, '98881', '', 'PENGADILAN NEGERI TANJUNG PINANG', 'Jl. Jend. A. Yani No. 29', 'Y', 1),
(99, 4, '108309', '', 'PENGADILAN NEGERI BATAM', 'Engku Putri Batam Center Kota Batam', 'Y', 1),
(100, 4, '663005', '', 'PENGADILAN NEGERI TANJUNG BALAI KARIMUN', 'Jln. Jend. Sudirman', 'Y', 1),
(101, 11, '97471', '', 'PENGADILAN NEGERI JAKARTA PUSAT', 'Jalan Gajah Mada No.17', 'Y', 1),
(102, 11, '97488', '', 'PENGADILAN NEGERI JAKARTA BARAT', 'Jl.Let.Jend.S.Parman Kav.71 Slipi Jak-bar', 'Y', 1),
(103, 11, '97492', 'JKT.TIM', 'PENGADILAN NEGERI JAKARTA TIMUR', 'Jl. Dr. SUMARNO No.1, Penggilingan', 'Y', 1),
(104, 11, '400214', '', 'PENGADILAN NEGERI JAKARTA SELATAN', 'Jalan Ampera Raya No.133 Ragunan Jakarta Selatan', 'Y', 1),
(105, 11, '400220', '', 'PENGADILAN NEGERI JAKARTA UTARA', 'JL. RE MARTADINATA NO. 4 ANCOL SELATAN', 'Y', 1),
(106, 12, '97514', 'BDG', 'PENGADILAN NEGERI BANDUNG', 'Jl. RE Martadinata no. 74-80', 'Y', 1),
(107, 12, '97521', 'SMD', 'PENGADILAN NEGERI SUMEDANG', 'Jln. Raya Sumedang-Cirebon Km. 04 No. 52', 'Y', 1),
(108, 12, '97535', '', 'PENGADILAN NEGERI TASIKMALAYA', 'Jl. Siliwangi no. 18', 'Y', 1),
(109, 12, '97542', 'GRT', 'PENGADILAN NEGERI GARUT', 'Jl. merdeka No. 123', 'Y', 1),
(110, 12, '97556', '', 'PENGADILAN NEGERI CIAMIS', 'Jl. Jenderal Sudirman No.116', 'Y', 1),
(111, 12, '97603', '', 'PENGADILAN NEGERI PURWAKARTA', 'Jl. Kolonel Singawinata No. 101', 'Y', 1),
(112, 12, '97610', '', 'PENGADILAN NEGERI BEKASI', 'Jl.Pramuka No.81, Bekasi', 'Y', 1),
(113, 12, '97624', '', 'PENGADILAN NEGERI KARAWANG', 'Jl. Jend.A Yani (By Pass)', 'Y', 1),
(114, 12, '97631', '', 'PENGADILAN NEGERI SUBANG', 'Jl. Mayjen Sutoyo. S. No. 1', 'Y', 1),
(115, 12, '97645', '', 'PENGADILAN NEGERI BOGOR', 'Jl. Pengadilan No.10 Bogor', 'Y', 1),
(116, 12, '97652', '', 'PENGADILAN NEGERI SUKABUMI', 'Jl. Bhayangkara No. 105', 'Y', 1),
(117, 12, '97666', '', 'PENGADILAN NEGERI CIANJUR', 'Jl. Dr. Muwardi No. 174', 'Y', 1),
(118, 12, '97670', '', 'PENGADILAN NEGERI CIREBON', 'Jl DR Wahidin Sudirohusodo No. 18', 'Y', 1),
(119, 12, '97687', '', 'PENGADILAN NEGERI INDRAMAYU', 'JL. JEND. SUDIRMAN NO. 183', 'Y', 1),
(120, 12, '97691', '', 'PENGADILAN NEGERI MAJALENGKA', 'K.H.Abdul Halim 499 Majalengka', 'Y', 1),
(121, 12, '97709', '', 'PENGADILAN NEGERI KUNINGAN', 'JL.Pengadilan No. 2', 'Y', 1),
(122, 12, '400409', '', 'PENGADILAN NEGERI CIBADAK', 'Jln. Jend. Sudirman Blok Jajaway No. 2  Palabuhanratu', 'Y', 1),
(123, 12, '400477', '', 'PENGADILAN NEGERI SUMBER', 'Jl. Sunan Drajat No. 4', 'Y', 1),
(124, 12, '400483', '', 'PENGADILAN NEGERI BALE BANDUNG', 'Jl. Jaksa Naranata No. 1 Bale Endah', 'Y', 1),
(125, 12, '477292', '', 'PENGADILAN NEGERI DEPOK', 'Jalan Boulevard No. 7 komplek Perkantoran Kota Depok', 'Y', 1),
(126, 12, '613519', '', 'PENGADILAN NEGERI CIBINONG', 'Jl.Tegar Beriman No.5 Cibinong', 'Y', 1),
(127, 13, '97720', 'SMG', 'PENGADILAN NEGERI SEMARANG', 'Jl. Siliwangi No.512', 'Y', 1),
(128, 13, '97734', '', 'PENGADILAN NEGERI TEGAL', 'Jl. Mayjend. Sutoyo SM. No. 9', 'Y', 1),
(129, 13, '97741', '', 'PENGADILAN NEGERI PEKALONGAN', 'Jalan Cendrawasih Nomor 2 Pekalongan', 'Y', 1),
(130, 13, '97755', 'KDS', 'PENGADILAN NEGERI KUDUS', 'Jl. Sunan Muria No. 1', 'Y', 1),
(131, 13, '97762', '', 'PENGADILAN NEGERI PATI', 'Jalan Raya Pati-Kudus KM 3', 'Y', 1),
(132, 13, '97776', '', 'PENGADILAN NEGERI BREBES', 'Jl. A. Yani No. 89', 'Y', 1),
(133, 13, '97780', '', 'PENGADILAN NEGERI PEMALANG', 'Jl. Pemuda No. 59 Pemalang', 'Y', 1),
(134, 13, '97797', '', 'PENGADILAN NEGERI KENDAL', 'Jl. Soekarno Hatta No.220', 'Y', 1),
(135, 13, '97802', '', 'PENGADILAN NEGERI DEMAK', 'Jl. Sultan Trenggono No. 27 Demak', 'Y', 1),
(136, 13, '97819', '', 'PENGADILAN NEGERI PURWODADI', 'Jl. Letjen R. Soeprapto No. 109 Purwodadi', 'Y', 1),
(137, 13, '97823', '', 'PENGADILAN NEGERI SALATIGA', 'JL. VETERAN NO.4', 'Y', 1),
(138, 13, '97830', '', 'PENGADILAN NEGERI KABUPATEN SEMARANG DI UNGARAN', 'Jln. Gatot Subroto No.16, Ungaran', 'Y', 1),
(139, 13, '97844', '', 'PENGADILAN NEGERI JEPARA', 'Jl. KHA. Fauzan No. 04', 'Y', 1),
(140, 13, '97851', '', 'PENGADILAN NEGERI BLORA', 'Jl. Raya Blora-Cepu Km. 5', 'Y', 1),
(141, 13, '97865', '', 'PENGADILAN NEGERI REMBANG', 'Jl. P. Diponegoro No. 97', 'Y', 1),
(142, 13, '97872', '', 'PENGADILAN NEGERI BATANG', 'Jl. Slamet Riyadi No. 05', 'Y', 1),
(143, 13, '97886', '', 'PENGADILAN NEGERI PURWOREJO', 'Jalan Tentara Pelajar KM.4', 'Y', 1),
(144, 13, '97890', '', 'PENGADILAN NEGERI MAGELANG', 'Jl. Veteran No. 1 Magelang', 'Y', 1),
(145, 13, '97908', '', 'PENGADILAN NEGERI KEBUMEN', 'JL.Indrakila No.15', 'Y', 1),
(146, 13, '97912', '', 'PENGADILAN NEGERI TEMANGGUNG', 'Jl.Jend.sudirman', 'Y', 1),
(147, 13, '97929', '', 'PENGADILAN NEGERI WONOSOBO', 'Jl. Tumenggung Jogonegoro No. 38', 'Y', 1),
(148, 13, '97933', '', 'PENGADILAN NEGERI SURAKARTA', 'Jl. Slamet riyadi no.290 Surakarta', 'Y', 1),
(149, 13, '97940', '', 'PENGADILAN NEGERI SRAGEN', 'JL.Raya Sukowati No.253 Sragen', 'Y', 1),
(150, 13, '97954', '', 'PENGADILAN NEGERI WONOGIRI', 'Jl. RM.Said', 'Y', 1),
(151, 13, '97961', '', 'PENGADILAN NEGERI SUKOHARJO', 'Jl. Jenderal Sudirman No. 193 Sukoharjo', 'Y', 1),
(152, 13, '97975', '', 'PENGADILAN NEGERI KARANGANYAR', 'Jl. Lawu Barat No. 76 B', 'Y', 1),
(153, 13, '97982', '', 'PENGADILAN NEGERI BOYOLALI', 'Jl. Perintis Kemerdekaan No.2', 'Y', 1),
(154, 13, '97996', 'KLT', 'PENGADILAN NEGERI KLATEN', 'Jl. Raya-Klaten Solo Km. 2, Klaten', 'Y', 1),
(155, 13, '98001', '', 'PENGADILAN NEGERI PURWOKERTO', 'Jl.Gerilya.no.241 Purwokerto', 'Y', 1),
(156, 13, '98015', '', 'PENGADILAN NEGERI CILACAP', 'Jln. Letjen Suprapto No. 67', 'Y', 1),
(157, 13, '98022', '', 'PENGADILAN NEGERI BANYUMAS', 'Jl. Pramuka No. 9', 'Y', 1),
(158, 13, '98036', '', 'PENGADILAN NEGERI PURBALINGGA', 'Jl. Letnan Akhmadi D-80 Purbalingga', 'Y', 1),
(159, 13, '98040', '', 'PENGADILAN NEGERI BANJARNEGARA', 'Jln. Let. Jend. Soeprapto 121/ 44', 'Y', 1),
(160, 13, '400565', '', 'PENGADILAN NEGERI KABUPATEN TEGAL DI SLAWI', 'JL. A.YANI NO. 99 PROCOT, SLAWI', 'Y', 1),
(161, 13, '400571', '', 'PENGADILAN NEGERI KABUPATEN MAGELANG DI MUNGKID', 'Jalan Soekarno Hatta No. 9 Mungkid', 'Y', 1),
(162, 14, '98057', '', 'PENGADILAN NEGERI YOGYAKARTA', 'Jalan Kapas No. 10', 'Y', 1),
(163, 14, '98061', 'WT', 'PENGADILAN NEGERI WATES', 'Jalan Sugiman No. 19 Wates', 'Y', 1),
(164, 14, '98078', '', 'PENGADILAN NEGERI WONOSARI', 'Jl. Taman Bhakti No. 1', 'Y', 1),
(165, 14, '98082', 'SLMN', 'PENGADILAN NEGERI SLEMAN', 'Jl.Merapi,beran,Sleman', 'Y', 1),
(166, 14, '400172', '', 'PENGADILAN NEGERI BANTUL', 'Jl. Prof. Dr. Soepomo, SH. No.04', 'Y', 1),
(167, 15, '98111', 'SBY', 'PENGADILAN NEGERI SURABAYA', 'Jl. Raya Arjuna No. 16-18', 'Y', 1),
(168, 15, '98125', '', 'PENGADILAN NEGERI BOJONEGORO', 'Jl. Hayam Wuruk No. 131', 'Y', 1),
(169, 15, '98132', 'TBN', 'PENGADILAN NEGERI TUBAN', 'Jl. Veteran No. 8', 'Y', 1),
(170, 15, '98146', '', 'PENGADILAN NEGERI LAMONGAN', 'Jl. Veteran No. 18', 'Y', 1),
(171, 15, '98150', '', 'PENGADILAN NEGERI GRESIK', 'Jl. Raya Permata No. 6', 'Y', 1),
(172, 15, '98167', 'SDA', 'PENGADILAN NEGERI SIDOARJO', 'Jl. Jaksa Agung R. Suprapto No. 10', 'Y', 1),
(173, 15, '98171', 'MKT', 'PENGADILAN NEGERI MOJOKERTO', 'Jl. RA. Basuni No. 11', 'Y', 1),
(174, 15, '98188', '', 'PENGADILAN NEGERI JOMBANG', 'Jl. KH. Wahid Hasyim No. 135', 'Y', 1),
(175, 15, '98192', '', 'PENGADILAN NEGERI BONDOWOSO', 'Jl. Santawi No. 59', 'Y', 1),
(176, 15, '98200', '', 'PENGADILAN NEGERI JEMBER', 'Jl. Kalimantan No. 3, Kotak Pos 103', 'Y', 1),
(177, 15, '98214', '', 'PENGADILAN NEGERI BANYUWANGI', 'Jl. Adi Sucipto No. 26', 'Y', 1),
(178, 15, '98221', '', 'PENGADILAN NEGERI SITUBONDO', 'Jl. PB Sudirman No. 97', 'Y', 1),
(179, 15, '98235', '', 'PENGADILAN NEGERI KEDIRI', 'Jl. Dr. Saharjo No. 20', 'Y', 1),
(180, 15, '98242', '', 'PENGADILAN NEGERI NGANJUK', 'Jl. Dermojoyo No. 20', 'Y', 1),
(181, 15, '98256', 'TA', 'PENGADILAN NEGERI TULUNGAGUNG', 'Jl. Jayengkusuma no.21 Tulungagung', 'Y', 1),
(182, 15, '98260', 'TL', 'PENGADILAN NEGERI TRENGGALEK', 'Jl. Dewi Sartika No.1', 'Y', 1),
(183, 15, '98277', '', 'PENGADILAN NEGERI BLITAR', 'Jl. Imam Bonjol No. 68', 'Y', 1),
(184, 15, '98281', '', 'PENGADILAN NEGERI MALANG', 'Jl. Jend. A. Yani Utara No. 198', 'Y', 1),
(185, 15, '98298', '', 'PENGADILAN NEGERI PASURUAN', 'Jl. Pahlawan No. 24', 'Y', 1),
(186, 15, '98303', '', 'PENGADILAN NEGERI PROBOLINGGO', 'Jl. Dr. Moch. Saleh No. 26', 'Y', 1),
(187, 15, '98310', '', 'PENGADILAN NEGERI LUMAJANG', 'Jl. Jend. Gatot Subroto No. 74', 'Y', 1),
(188, 15, '98324', '', 'PENGADILAN NEGERI BANGIL', 'Jl. Dr. Sutomo No. 25', 'Y', 1),
(189, 15, '98331', '', 'PENGADILAN NEGERI KRAKSAAN', 'Jl. Raya Panglima Sudirman No. 5 Kraksaan', 'Y', 1),
(190, 15, '98345', '', 'PENGADILAN NEGERI MADIUN', 'Jl. R.A. Kartni No. 7', 'Y', 1),
(191, 15, '98352', '', 'PENGADILAN NEGERI PONOROGO', 'Jl. Ir. H. Juanda No. 23', 'Y', 1),
(192, 15, '98366', '', 'PENGADILAN NEGERI PACITAN', 'Jl. Yos Sudarso No. 2', 'Y', 1),
(193, 15, '98370', '', 'PENGADILAN NEGERI NGAWI', 'Jl. PB Sudirman No. 97', 'Y', 1),
(194, 15, '98387', '', 'PENGADILAN NEGERI MAGETAN', 'Jl. Karya Dharma No. 10', 'Y', 1),
(195, 15, '98391', '', 'PENGADILAN NEGERI PAMEKASAN', 'Jl. Pangeran Trunojoyo', 'Y', 1),
(196, 15, '98409', '', 'PENGADILAN NEGERI SUMENEP', 'Jl. K.H. Mansyur (Pabian) No. 49', 'Y', 1),
(197, 15, '98413', '', 'PENGADILAN NEGERI BANGKALAN', 'Jl. Sukarno Hatta No. 4', 'Y', 1),
(198, 15, '98420', '', 'PENGADILAN NEGERI SAMPANG', 'Jl. Jaksa Agung Suprapto No. 74', 'Y', 1),
(199, 15, '400580', '', 'PENGADILAN NEGERI KAB. KEDIRI', 'Jl. Pamenang No. 60Gampeng Rejo,', 'Y', 1),
(200, 15, '400596', '', 'PENGADILAN NEGERI KAB. MADIUN', 'Jl. Soekarno - Hatta No. 15', 'Y', 1),
(201, 15, '626156', '', 'PENGADILAN NEGERI KEPANJEN', 'Jl. R. Panji No. 205, Kepanjen', 'Y', 1),
(202, 16, '97560', 'SRG', 'PENGADILAN NEGERI SERANG', 'JL. K.H. ABDUL HADI NO. 29', 'Y', 1),
(203, 16, '97577', '', 'PENGADILAN NEGERI RANGKASBITUNG', 'Jl. RA. Kartini No. 55 Rangkasbitung', 'Y', 1),
(204, 16, '97581', '', 'PENGADILAN NEGERI PANDEGLANG', 'Jl. Raya Serang KM.1 Curug Sawer', 'Y', 1),
(205, 16, '97598', '', 'PENGADILAN NEGERI TANGERANG', 'Jl. T.M.P Taruna Tangerang No. 7', 'Y', 1),
(206, 17, '99780', 'DPS', 'PENGADILAN NEGERI DENPASAR', 'Jl. P. B. Sudirman No.1 Denpasar', 'Y', 1),
(207, 17, '99794', '', 'PENGADILAN NEGERI SINGARAJA', 'Jalan Kartini No. 2', 'Y', 1),
(208, 17, '99802', '', 'PENGADILAN NEGERI NEGARA', 'JL. MAYOR SUGIANYAR 1 NEGARA', 'Y', 1),
(209, 17, '99816', '', 'PENGADILAN NEGERI SEMARAPURA', 'Jl. Gajah Mada no 59 Semarapura', 'Y', 1),
(210, 17, '99820', '', 'PENGADILAN NEGERI TABANAN', 'Jl. Pahlawan No.6', 'Y', 1),
(211, 17, '99837', '', 'PENGADILAN NEGERI AMLAPURA', 'Jl. Kapten Jaya Tirta No 14, Amlapura', 'Y', 1),
(212, 17, '99841', '', 'PENGADILAN NEGERI GIANYAR', 'Jl. Ciung Wenara No.1 B Gianyar', 'Y', 1),
(213, 17, '99858', 'BLI', 'PENGADILAN NEGERI BANGLI', 'Jl. Brigjen Ngurah Rai No. 61', 'Y', 1),
(214, 18, '99862', '', 'PENGADILAN NEGERI MATARAM', 'Jl. Langko No. 68A', 'Y', 1),
(215, 18, '99879', '', 'PENGADILAN NEGERI RABA/BIMA', 'JL.SOEKARNO HATTA NO. 161', 'Y', 1),
(216, 18, '99883', 'SBB', 'PENGADILAN NEGERI SUMBAWA BESAR', 'JL. GARUDA NO.105', 'Y', 1),
(217, 18, '99890', '', 'PENGADILAN NEGERI SELONG', 'JL.PROF.SOEPOMO NO.1', 'Y', 1),
(218, 18, '99905', 'DOM', 'PENGADILAN NEGERI DOMPU', 'JL. BERINGIN NO. 2', 'Y', 1),
(219, 18, '99912', '', 'PENGADILAN NEGERI PRAYA', 'Jl.Diponegoro No.2 Praya', 'Y', 1),
(220, 19, '99926', '', 'PENGADILAN NEGERI KUPANG', 'Jl. PALAPA', 'Y', 1),
(221, 19, '99930', '', 'PENGADILAN NEGERI ATAMBUA', 'Jl. Prof. Soepomo, SH.', 'Y', 1),
(222, 19, '99947', '', 'PENGADILAN NEGERI SOE', 'Soe', 'Y', 1),
(223, 19, '99951', '', 'PENGADILAN NEGERI KEFAMENANU', 'kefa', 'Y', 1),
(224, 19, '99968', '', 'PENGADILAN NEGERI WAINGAPU', 'M. T. Haryono Nomor 11', 'Y', 1),
(225, 19, '99972', '', 'PENGADILAN NEGERI WAIKABUBAK', 'Jl.Jend.Sudirman No.10', 'Y', 1),
(226, 19, '99989', '', 'PENGADILAN NEGERI ENDE', 'Ende', 'Y', 1),
(227, 19, '99993', '', 'PENGADILAN NEGERI MAUMERE', 'Jl. AHMAD YANI NO.18', 'Y', 1),
(228, 19, '400007', '', 'PENGADILAN NEGERI LARANTUKA', 'Larantuka', 'Y', 1),
(229, 19, '400013', '', 'PENGADILAN NEGERI RUTENG', 'Jl. Komodo Nomor 30 - Ruteng', 'Y', 1),
(230, 19, '400157', '', 'PENGADILAN NEGERI BAJAWA', '400158', 'Y', 1),
(231, 19, '400163', '', 'PENGADILAN NEGERI KALABAHI', 'JL. Jend. Sudirman No. 20, Kalabahi', 'Y', 1),
(232, 19, '477230', '', 'PENGADILAN NEGERI LEMBATA', 'Jalan Trans Atadei', 'Y', 1),
(233, 19, '477249', '', 'PENGADILAN NEGERI ROTE NDAO', 'Rote', 'Y', 1),
(234, 20, '99066', '', 'PENGADILAN NEGERI PONTIANAK', 'Jl. Sultan Abdurrahman No. 89', 'Y', 1),
(235, 20, '99070', '', 'PENGADILAN NEGERI SINGKAWANG', 'FIRDAUS H. RAIS NO. 3', 'Y', 1),
(236, 20, '99087', '', 'PENGADILAN NEGERI SINTANG', 'Jl. Letjen S. Parman No.106', 'Y', 1),
(237, 20, '99091', '', 'PENGADILAN NEGERI KETAPANG', 'JL. Jendral Sudirman No. 19', 'Y', 1),
(238, 20, '99109', '', 'PENGADILAN NEGERI MEMPAWAH', 'Jl. Raden Kusno No. 80 Mempawah', 'Y', 1),
(239, 20, '99113', 'SGU', 'PENGADILAN NEGERI SANGGAU', 'Jl. Jenderal Sudirman No. 1/XXI', 'Y', 1),
(240, 20, '400194', '', 'PENGADILAN NEGERI PUTUSSIBAU', 'Jl. Antasari No. 03', 'Y', 1),
(241, 20, '670227', '', 'PENGADILAN NEGERI SAMBAS', 'Jl. Pembangunan Sambas', 'Y', 1),
(242, 20, '670231', '', 'PENGADILAN NEGERI BENGKAYANG', 'Jl. Trans Rangkang', 'Y', 1),
(243, 21, '99120', '', 'PENGADILAN NEGERI PALANGKARAYA', 'Jl.Diponegoro No. 21 Palangka Raya', 'Y', 1),
(244, 21, '99134', '', 'PENGADILAN NEGERI PANGKALAN BUN', 'Jl. Sutan Syahrir No. 16', 'Y', 1),
(245, 21, '99141', '', 'PENGADILAN NEGERI MUARA TEWEH', 'Jln. Yetro Sinseng No. 08', 'Y', 1),
(246, 21, '99155', '', 'PENGADILAN NEGERI KUALA KAPUAS', 'Jl. Tambun Bungai No. 55', 'Y', 1),
(247, 21, '99162', '', 'PENGADILAN NEGERI BUNTOK', 'Jl. Pelita Raya  No. 20', 'Y', 1),
(248, 21, '99176', '', 'PENGADILAN NEGERI SAMPIT', 'Jl.HM.Arsyad No.36', 'Y', 1),
(249, 21, '670191', '', 'PENGADILAN NEGERI TAMIANG LAYANG', 'Jl. A. Yani, Tamiang Layang', 'Y', 1),
(250, 25, '672980', '', 'PENGADILAN NEGERI PARIGI', 'JL. sungai pakabata', 'Y', 1),
(251, 22, '99197', '', 'PENGADILAN NEGERI BANJARMASIN', 'Jl. May. Jend. DI Panjaitan No. 27 Banjarmasin', 'Y', 1),
(252, 22, '99202', '', 'PENGADILAN NEGERI KANDANGAN', 'Jl. Pangeran Antasari No. 2', 'Y', 1),
(253, 22, '99219', '', 'PENGADILAN NEGERI KOTABARU', 'Jl. Jamrud 1', 'Y', 1),
(254, 22, '99223', '', 'PENGADILAN NEGERI BARABAI', 'Murakata No.1', 'Y', 1),
(255, 22, '99230', '', 'PENGADILAN NEGERI MARTAPURA', 'Jalan Jenderal A. yani N0. 32 Martapura', 'Y', 1),
(256, 22, '99244', '', 'PENGADILAN NEGERI TANJUNG', 'Jl. Jend.Sudirman No. 18 Tanjung 71513', 'Y', 1),
(257, 22, '99251', '', 'PENGADILAN NEGERI AMUNTAI', 'Jl. A. Yani No. 5 Amuntai', 'Y', 1),
(258, 22, '99265', '', 'PENGADILAN NEGERI RANTAU', 'Jl. Brig. Jend. H. Hasan Basery No. 38 Rantau', 'Y', 1),
(259, 22, '400260', '', 'PENGADILAN NEGERI MARABAHAN', 'Jl. Putri Junjung Buih No.77', 'Y', 1),
(260, 22, '400282', '', 'PENGADILAN NEGERI PELAIHARI', 'Jl.H.Boejasin Komplek Perkantoran Gagas Pelaihari', 'Y', 1),
(261, 22, '653458', '', 'PENGADILAN NEGERI BANJARBARU', 'Jl. Trikora No.3', 'Y', 1),
(262, 23, '99272', '', 'PENGADILAN NEGERI TARAKAN', 'Jl. Diponegoro, No. 99 Tarakan', 'Y', 1),
(263, 23, '99286', 'SMDA', 'PENGADILAN NEGERI SAMARINDA', 'Jl. M. Yamin Samarinda', 'Y', 1),
(264, 23, '99290', '', 'PENGADILAN NEGERI TENGGARONG', 'Jl. Ahmad Yani no. 16 Tenggarong', 'Y', 1),
(265, 23, '99308', '', 'PENGADILAN NEGERI BALIKPAPAN', 'Jl. Jenderal Sudirman No. 788', 'Y', 1),
(266, 23, '400291', '', 'PENGADILAN NEGERI TANJUNG REDEP', 'Jl. Pemuda No. 26, Tanjung Redeb', 'Y', 1),
(267, 23, '400302', '', 'PENGADILAN NEGERI TANAH GROGOT', 'Jl. Jenderal Sudirman, No. 19, Tanah Grogot', 'Y', 1),
(268, 23, '477270', '', 'PENGADILAN NEGERI NUNUKAN', 'Jl. Ujang Dewa, Sedadap, Nunukan', 'Y', 1),
(269, 23, '477286', 'MLN', 'PENGADILAN NEGERI MALINAU', 'Jl. Pusat Pemerintahan, Malinau', 'Y', 1),
(270, 23, '477380', '', 'PENGADILAN NEGERI KUTAI BARAT', 'Jl. Sendawar Raya, Barong Tongkok', 'Y', 1),
(271, 23, '662972', '', 'PENGADILAN NEGERI BONTANG', 'Jl. Awang Long, No. 10, Bontang', 'Y', 1),
(272, 23, '662986', '', 'PENGADILAN NEGERI SANGATTA', 'Jl. Prof. Dr. Wirjono Projodjodikoro, S.H, No. 1, Bukit Pelangi, Sangatta', 'Y', 1),
(273, 23, '670170', '', 'PENGADILAN NEGERI TANJUNG SELOR', 'Jl. Jelarai Raya, Tanjung Selor', 'Y', 1),
(274, 24, '99329', '', 'PENGADILAN NEGERI MANADO', 'Jl. Sam Ratulangi No. 18', 'Y', 1),
(275, 24, '99333', '', 'PENGADILAN NEGERI KOTAMOBAGU', 'Jl. Mayjend Soetoyo No. 348', 'Y', 1),
(276, 24, '99340', '', 'PENGADILAN NEGERI TAHUNA', 'Jl. Sam Ratulangi No. 10 Tahuna 95812', 'Y', 1),
(277, 24, '99354', '', 'PENGADILAN NEGERI TONDANO', 'Manguni No. 75 Tondano', 'Y', 1),
(278, 24, '568725', '', 'PENGADILAN NEGERI BITUNG', 'Jl. DR. Sam Ratulangi No.58', 'Y', 1),
(279, 24, '670210', '', 'PENGADILAN NEGERI AIRMADIDI', 'Kompleks Perkantoran Bupati Minahasa Utara', 'Y', 1),
(280, 25, '99375', '', 'PENGADILAN NEGERI PALU', 'Jl. Samratulangi Palu', 'Y', 1),
(281, 25, '99382', '', 'PENGADILAN NEGERI TOLI-TOLI', 'Jl. Magamu No. 84 Kel. Baru Kec. Baolan', 'Y', 1),
(282, 25, '99396', '', 'PENGADILAN NEGERI LUWUK', 'Jl.Jenderal Ahmad Yani No. 6 Luwuk', 'Y', 1),
(283, 25, '99401', '', 'PENGADILAN NEGERI POSO', 'Jalan Pulau Kalimantan No. 11', 'Y', 1),
(284, 25, '477202', '', 'PENGADILAN NEGERI DONGGALA', 'Jl. VATUBALA NO. 4', 'Y', 1),
(285, 25, '670248', '', 'PENGADILAN NEGERI BUOL', 'Jl. DR.Wahidin Sudirohusodo No.13 Kel. Leok II Kec. Biau', 'Y', 1),
(286, 26, '99422', 'MKS', 'PENGADILAN NEGERI MAKASSAR', 'Jln. R.A. Kartini No. 18/23', 'Y', 1),
(287, 26, '99439', '', 'PENGADILAN NEGERI SUNGGUMINASA', 'Jl. Usman Salengke No 103', 'Y', 1),
(288, 26, '99443', '', 'PENGADILAN NEGERI PANGKAJENE', 'Jl. Sultan Hasanuddin No. 38', 'Y', 1),
(289, 26, '99450', '', 'PENGADILAN NEGERI BARRU', 'Jl. St. Hasanuddin No.1', 'Y', 1),
(290, 26, '99464', '', 'PENGADILAN NEGERI TAKALAR', 'Jl. Jend. Sudirman No. 11', 'Y', 1),
(291, 26, '99471', '', 'PENGADILAN NEGERI MAROS', 'Jl. DR. Sam Ratulangi No. 58', 'Y', 1),
(292, 26, '99485', '', 'PENGADILAN NEGERI JENEPONTO', 'Jl. Pahlawan No. 14', 'Y', 1),
(293, 26, '99492', '', 'PENGADILAN NEGERI PARE-PARE', 'Jl. Jend. Sudirman No. 39', 'Y', 1),
(294, 26, '99507', '', 'PENGADILAN NEGERI ENREKANG', 'Jl. Lasinrang No. 2', 'Y', 1),
(295, 26, '99511', '', 'PENGADILAN NEGERI SIDRAP', 'Jl. Jend. Sudirman No. 169', 'Y', 1),
(296, 26, '99528', '', 'PENGADILAN NEGERI PINRANG', 'Jl. Jend. Sukawati No. 38', 'Y', 1),
(297, 26, '99532', '', 'PENGADILAN NEGERI WATAMPONE', 'Jl. Let. Jend. M. T. Haryono', 'Y', 1),
(298, 26, '99549', '', 'PENGADILAN NEGERI WATANSOPPENG', 'Jl. Kemakmuran No. 18', 'Y', 1),
(299, 26, '99553', '', 'PENGADILAN NEGERI SENGKANG', 'Jl. Bau Baharudin No. 9', 'Y', 1),
(300, 26, '99560', '', 'PENGADILAN NEGERI BANTAENG', 'Jl. Andi Manappiang No. 15', 'Y', 1),
(301, 26, '99574', '', 'PENGADILAN NEGERI SINJAI', 'Jl. Jend. Sudirman No.1', 'Y', 1),
(302, 26, '99581', '', 'PENGADILAN NEGERI BULUKUMBA', 'Jl. Nangka No. 2', 'Y', 1),
(303, 26, '99595', '', 'PENGADILAN NEGERI SELAYAR', 'Jl. Kelapa No. 7', 'Y', 1),
(304, 26, '99600', 'PLP', 'PENGADILAN NEGERI PALOPO', 'Jl. Andi Djemma No. 126', 'Y', 1),
(305, 26, '99617', '', 'PENGADILAN NEGERI MAKALE', 'Jl. Pongtiku No. 48', 'Y', 1),
(306, 27, '99659', '', 'PENGADILAN NEGERI KENDARI', 'JL. MAYJEN SUTOYO NO. 37 TIPULU', 'Y', 1),
(307, 27, '99663', '', 'PENGADILAN NEGERI BAU-BAU', 'Jln. Betoambari No. 57', 'Y', 1),
(308, 27, '99670', '', 'PENGADILAN NEGERI RAHA', 'JL.M.H.THAMRIN NO.33 RAHA', 'Y', 1),
(309, 27, '99684', '', 'PENGADILAN NEGERI KOLAKA', 'Jln. Pemuda No. 175 Kolaka', 'Y', 1),
(310, 27, '477224', 'UNH', 'PENGADILAN NEGERI UNAAHA', 'Jl. Inolobunggadue II No. 821', 'Y', 1),
(311, 28, '99361', '', 'PENGADILAN NEGERI GORONTALO', 'Jl. Achmad Nadjamuddin', 'Y', 1),
(312, 28, '400208', '', 'PENGADILAN NEGERI LIMBOTO', 'Jl. Kol. Rauf Moo Kel. Kayubulan', 'Y', 1),
(313, 28, '477218', '', 'PENGADILAN NEGERI TILAMUTA', 'Jl.Jend. Ahmad Yani', 'Y', 1),
(314, 26, '99621', '', 'PENGADILAN NEGERI MAJENE', 'Jalan Jenderal Sudirman', 'Y', 1),
(315, 26, '99638', '', 'PENGADILAN NEGERI MAMUJU', 'Jalan A.P. Pettarani', 'Y', 1),
(316, 26, '99642', '', 'PENGADILAN NEGERI POLEWALI', 'Jl.Mr.Muh.Yamin No.15', 'Y', 1),
(317, 30, '99706', 'PN Amb', 'PENGADILAN NEGERI AMBON', 'Jl.Sultan Hairun No. 1 Ambon', 'Y', 1),
(318, 30, '99710', '', 'PENGADILAN NEGERI MASOHI', 'Jl. Geser No.1 Masohi', 'Y', 1),
(319, 30, '99727', '', 'PENGADILAN NEGERI TUAL', 'Jl. Karel Sadsuitubun no. 1', 'Y', 1),
(320, 30, '672931', '', 'PENGADILAN NEGERI SAUMLAKI', 'Jalan Ir. Soekarno', 'Y', 1),
(321, 31, '99731', '', 'PENGADILAN NEGERI TERNATE', 'Jl. Jati Lurus No. 338', 'Y', 1),
(322, 31, '99748', '', 'PENGADILAN NEGERI TOBELO', 'Jl. SISWA - Tobelo', 'Y', 1),
(323, 31, '99752', '', 'PENGADILAN NEGERI LABUHA', 'Jalan Molunjunga', 'Y', 1),
(324, 31, '99769', '', 'PENGADILAN NEGERI SOASIU', 'Jl. Jend A. Yani N0. 8', 'Y', 1),
(325, 33, '400069', '', 'PENGADILAN NEGERI MANOKWARI', 'Jl.Pahlawan', 'Y', 1),
(326, 33, '400075', '', 'PENGADILAN NEGERI SORONG', 'Jln. Jend. Sudirman No. 5', 'Y', 1),
(327, 33, '400081', '', 'PENGADILAN NEGERI FAK FAK', 'Jl. Yos Sudarso No.92 Wagom - Fakfak', 'Y', 1),
(328, 33, '400038', 'Jpr', 'PENGADILAN NEGERI JAYAPURA', 'Jl.Raya Abepura', 'Y', 1),
(329, 33, '400044', '', 'PENGADILAN NEGERI WAMENA', 'Wamena', 'Y', 1),
(330, 33, '400050', '', 'PENGADILAN NEGERI MERAUKE', 'Jl.Brawijaya No. 166 Mopah Baru', 'Y', 1),
(331, 33, '400090', '', 'PENGADILAN NEGERI BIAK', 'JL. Majapahit No. 1 Biak Papua', 'Y', 1),
(332, 33, '400101', '', 'PENGADILAN NEGERI NABIRE', 'JL. Merdeka No.69 Nabire', 'Y', 1),
(333, 33, '400276', '', 'PENGADILAN NEGERI SERUI', 'Jl. Sumatera Serui', 'Y', 1),
(334, 33, '614890', '', 'PENGADILAN NEGERI KOTA TIMIKA KABUPATEN MIMIKA', 'Jln. Yos Sudarso No. 42 Sempan - Timika', 'Y', 1),
(335, 4, '672948', '', 'PENGADILAN NEGERI RANAI', 'Datuk Kaya Wan Mohd. Benteng', 'Y', 1),
(336, 6, '672969', '', 'PENGADILAN NEGERI PAGAR ALAM', 'Komplek Perkantoran Gunung Gare', 'Y', 1),
(337, 6, '672952', 'PBM', 'PENGADILAN NEGERI PRABUMULIH', 'Jl. Jend. Sudirman KM 12', 'Y', 1),
(338, 7, '673009', '', 'PENGADILAN NEGERI TAIS', 'JL.S.PARMAN NO 01 KEL.TALANG SALING', 'Y', 1),
(339, 7, '673055', '', 'PENGADILAN NEGERI TUBEI', 'Jalan Raya Lebong-Argamakmur', 'Y', 1),
(341, 22, '670206', '', 'PENGADILAN NEGERI BATULICIN', 'Jl. Dharma Praja No.68 Gungung Tinggi Batulicin', 'Y', 1),
(342, 21, '672973', '', 'PENGADILAN NEGERI KASONGAN', 'Jl. A. Yani (Komplek Perkantoran Pemkab. Katingan) Kereng Humbang Kasongan', 'Y', 1),
(343, 20, '681450', '', 'PENGADILAN NEGERI NGABANG', 'Jalan Raya Ngabang Km.70 Kecamatan Amboyo Inti Kabupaten Landak', 'Y', 1),
(345, 26, '672927', '', 'PENGADILAN NEGERI MASAMBA', 'Jalan Letnan Jenderal Ahmad Yani No. 21', 'Y', 1),
(346, 26, '673013', '', 'PENGADILAN NEGERI MALILI', 'JL. SOEKARNO-HATTA', 'Y', 1),
(347, 26, '681422', '', 'PENGADILAN NEGERI PASANGKAYU', 'Jl. Andi Bandaco', 'Y', 1),
(348, 27, '681440', '', 'PENGADILAN NEGERI ANDOOLO', '', 'Y', 1),
(349, 27, '681444', '', 'PENGADILAN NEGERI PASARWAJO', '', 'Y', 1),
(350, 24, '673034', '', 'PENGADILAN NEGERI AMURANG', 'Jl. Trans Sulawesi Kel. Pondang', 'Y', 1),
(351, 28, '670185', '', 'PENGADILAN NEGERI MARISA', '', 'Y', 1),
(352, 19, '673021', '', 'PENGADILAN NEGERI LABUAN BAJO', '', 'Y', 1),
(353, 19, '681418', 'OLM', 'PENGADILAN NEGERI OELAMASI', '(Komp. Civic Centre Kab. Kupang) Jl. Timor Raya KM. 36 Oelamasi', 'Y', 1),
(354, 1, '673062', 'Str', 'PENGADILAN NEGERI SIMPANG TIGA REDELONG', 'Jl.Bandara Rembele -Pante Raya Simpang Tiga Redelong', 'Y', 1),
(355, 34, '578818', 'BNA', 'PENGADILAN TATA USAHA NEGARA BANDA ACEH', 'JL. IR M.THAHIR 25 LUENG BATA', 'Y', 3),
(356, 34, '526746', 'MDN', 'PENGADILAN TATA USAHA NEGARA MEDAN', 'Jl. Bunga Raya No. 18 Kel. Asam Kumbang Kec. Medan Selayang', 'Y', 3),
(357, 34, '531844', 'PDG', 'PENGADILAN TATA USAHA NEGARA PADANG', 'Jl. Diponegoro No. 8 Padang', 'Y', 3),
(358, 34, '578822', 'PBR', 'PENGADILAN TATA USAHA NEGARA PEKANBARU', 'Jl. HR Subrantas KM 9 Pekanbaru', 'Y', 3),
(359, 34, '578839', 'JBI', 'PENGADILAN TATA USAHA NEGARA JAMBI', 'Jln. Kol. M. Kukuh No. 1 Kota Baru', 'Y', 3),
(360, 34, '526750', 'PLG', 'PENGADILAN TATA USAHA NEGARA PALEMBANG', 'Jl.A.Yani No.67', 'Y', 3),
(361, 34, '559840', 'BL', 'PENGADILAN TATA USAHA NEGARA BANDAR LAMPUNG', 'JL.P.Emir M Noer NO. 27', 'Y', 3),
(362, 34, '578885', 'BKL', 'PENGADILAN TATA USAHA NEGARA BENGKULU', 'Jl. RE. Martadinata No. 01 Bengkulu', 'Y', 3),
(363, 34, '689309', 'TPI', 'PENGADILAN TATA USAHA NEGARA TANJUNG PINANG', 'Jl. Ir. Sutami No. 3 sekupang', 'Y', 3),
(364, 35, '526732', 'JKT', 'PENGADILAN TATA USAHA NEGARA JAKARTA', 'Jl. Sentra Primer Baru Timur, Pulo Gebang', 'Y', 3),
(365, 35, '531823', 'BDG', 'PENGADILAN TATA USAHA NEGARA BANDUNG', 'Jl. Diponegoro No. 34 Bandung', 'Y', 3),
(366, 35, '531851', 'PTK', 'PENGADILAN TATA USAHA NEGARA PONTIANAK', 'Jl. Jenderal A. Yani No. 10', 'Y', 3),
(367, 35, '578843', 'PLK', 'PENGADILAN TATA USAHA NEGARA PALANGKARAYA', 'Jl. Cilik Riwut Km.5', 'Y', 3),
(368, 35, '531865', 'BJM', 'PENGADILAN TATA USAHA NEGARA BANJARMASIN', 'Jl. Brigjen H. Hasan Basri No. 32', 'Y', 3),
(369, 35, '559857', 'SMD', 'PENGADILAN TATA USAHA NEGARA SAMARINDA', 'Jl. Bung Tomo, No. 136, Samarinda Seberang', 'Y', 3),
(370, 36, '531830', 'SMG', 'PENGADILAN TATA USAHA NEGARA SEMARANG', 'Jl.Abdulrahman saleh no.89', 'Y', 3),
(371, 36, '578801', 'YK', 'PENGADILAN TATA USAHA NEGARA YOGYAKARTA', 'Jl. Janti No. 66', 'Y', 3),
(372, 36, '526767', 'SBY', 'PENGADILAN TATA USAHA NEGARA SURABAYA', 'Jl. Raya Ir. H. Juanda No.89 Semambung Gedangan', 'Y', 3),
(373, 36, '559861', 'DPS', 'PENGADILAN TATA USAHA NEGARA DENPASAR', 'Jl. Kapten Cok Agung Tresna No 4', 'Y', 3),
(374, 36, '578871', 'MTR', 'PENGADILAN TATA USAHA NEGARA MATARAM', 'Jl. Dr. Soedjono Lingkar Selatan', 'Y', 3),
(375, 36, '539121', 'KPG', 'PENGADILAN TATA USAHA NEGARA KUPANG', 'Jl. PALAPA No. 16 A', 'Y', 3),
(376, 37, '689313', 'MDO', 'PENGADILAN TATA USAHA NEGARA MANADO', 'Jl. Pomorouw No. 66 Manado', 'Y', 3),
(377, 37, '578850', 'PL', 'PENGADILAN TATA USAHA NEGARA PALU', 'Moh. Yamin Nomor 52 Palu', 'Y', 3),
(378, 37, '526771', 'MKS', 'PENGADILAN TATA USAHA NEGARA MAKASAR', 'Raya Pendidikan No. 1', 'Y', 3),
(379, 37, '578864', 'KDI', 'PENGADILAN TATA USAHA NEGARA KENDARI', 'Jl.Badak no.7', 'Y', 3),
(380, 37, '539117', 'ABN', 'PENGADILAN TATA USAHA NEGARA AMBON', 'Jl.Wortel Mongensidi Lateri-Ambon', 'Y', 3),
(381, 37, '539138', 'JPR', 'PENGADILAN TATA USAHA NEGARA JAYAPURA', 'Jl.Raya Sentani-Waena', 'Y', 3),
(383, 39, '663182', 'PM.I-01', 'PENGADILAN MILITER I-01 BANDA ACEH', 'Jln. T.Imeum Lueng Bata No. 108', 'Y', 2),
(384, 39, '663199', 'PM.I-02', 'PENGADILAN MILITER I-02 MEDAN', 'Jl. Ngumban Surbakti No. 45 Medan', 'Y', 2),
(385, 39, '663204', 'PM.I-03', 'PENGADILAN MILITER I-03 PADANG', 'JL RAYA BY PASS KM 16', 'Y', 2),
(386, 39, '663211', 'PM.I-04', 'PENGADILAN MILITER I-04 PALEMBANG', 'Jl. Gubernur H.A Bastari Komplek OPI Palembang', 'Y', 2),
(387, 39, '663225', 'PM.I-05', 'PENGADILAN MILITER I-05 PONTIANAK', 'Jl.Ahmad Yani No.10 A', 'Y', 2),
(388, 39, '663232', 'PM.I-06', 'PENGADILAN MILITER I-06 BANJARMASIN', 'Jl.Trikora No 106 Banjarbaru', 'Y', 2),
(389, 39, '663246', 'PM.I-07', 'PENGADILAN MILITER I-07 BALIKPAPAN', 'Jl. Syarifoedin Yoes No.39 Sepinggan, Balikpapan', 'Y', 2),
(390, 40, '663267', 'PM.II-08', 'PENGADILAN MILITER II-08 JAKARTA', 'Jl Raya Penggilingan 7 Cakung Jakarta Timur', 'Y', 2),
(391, 40, '663271', 'PM.II-09', 'PENGADILAN MILITER II-09 BANDUNG', 'Jalan Soekarno Hatta No 745 Bandung', 'Y', 2),
(392, 40, '663288', 'PM.II-10', 'PENGADILAN MILITER II-10 SEMARANG', 'JL. Kertanegara VI/8 Semarang', 'Y', 2),
(393, 40, '663292', 'PM.II-11', 'PENGADILAN MILITER II-11 YOGYAKARTA', 'Jl. Perempatan Ring Road Timur Banguntapan Bantul', 'Y', 2),
(394, 41, '663314', 'PM.III-12', 'PENGADILAN MILITER III-12 SURABAYA', 'Jl. Raya Ir. H. Juanda No. 85', 'Y', 2),
(395, 41, '663321', 'PM.III-13', 'PENGADILAN MILITER III-13 MADIUN', 'Jl. SALAK III NO. 38', 'Y', 2),
(396, 41, '663335', 'PM.III-14', 'PENGADILAN MILITER III-14 DENPASAR', 'Jl. Yos Sudarso No. 1 Denpasar', 'Y', 2),
(397, 41, '663342', 'PM.III-15', 'PENGADILAN MILITER III-15 KUPANG', 'Jl. Perintis Kemerdekaan I, Kayu Putih', 'Y', 2),
(398, 41, '663356', 'PM.III-16', 'PENGADILAN MILITER III-16 MAKASSAR', 'Jl. Batara Bira No.5 KM.16, Badoka, Makassar', 'Y', 2),
(399, 41, '663360', 'PM.III-17', 'PENGADILAN MILITER III-17 MANADO', 'Jalan Sam Ratulangi No. 16 Manado', 'Y', 2),
(400, 41, '663377', 'PM.III-18', 'PENGADILAN MILITER III-18 AMBON', 'Jln. Sultan Hasanudin Tantui', 'Y', 2),
(401, 41, '663381', 'PM.III-19', 'PENGADILAN MILITER III-19 JAYAPURA', 'Jl. Samratulangi No.17 Jayapura', 'Y', 2),
(402, 35, '690202', 'SRG', 'PENGADILAN TATA USAHA NEGARA SERANG', 'Jl. Syech Nawawi Al-Bantani No.3 Km 5 Kel Banjarsari Serang - Provinsi Banten Telp/Fax.(0254) 214085/214855', 'Y', 3),
(403, 42, '400631', 'PA.JB', 'PENGADILAN AGAMA JAKARTA BARAT', 'Jl. Pesanggrahan Raya No. 32 Kembangan', 'Y', 4),
(404, 42, '400616', 'PA.JP', 'PENGADILAN AGAMA JAKARTA PUSAT', 'Jl. Rawasari Selatan No. 51, Kelurahan Rawasari Kecamatan Cempaka Putih Kota Jakarta Pusat', 'Y', 4),
(405, 42, '400653', 'PA.JS', 'PENGADILAN AGAMA JAKARTA SELATAN', 'Jl. Harsono RM No.1 Ragunan Pasar Minggu', 'Y', 4),
(406, 42, '400647', 'PA.JT', 'PENGADILAN AGAMA JAKARTA TIMUR', 'Jalan Raya PKP No. 24, Kelapa Dua Wetan, Ciracas', 'Y', 4),
(407, 42, '400622', 'PA.JU', 'PENGADILAN AGAMA JAKARTA UTARA', 'Jl. Raya Plumpang Semper No. 5 Koja, Kota Jakarta Utara', 'Y', 4),
(408, 43, '652076', 'PA.Clg', 'PENGADILAN AGAMA CILEGON', 'Jl. Sukabumi 2 Kavling Blok i Kelurahan Ciwedus Kecamatan Cilegon, Kota Cilegon ', 'Y', 4),
(409, 43, '400801', 'PA.Pdlg', 'PENGADILAN AGAMA PANDEGLANG', 'Jl. Raya Labuan Km.03 Maja Sukaratu Kabupaten Pandeglang', 'Y', 4),
(410, 43, '400817', 'PA.Rks', 'PENGADILAN AGAMA RANGKASBITUNG', 'Jend. Sudirman KM.03 Narimbang Mulya', 'Y', 4),
(411, 43, '400797', 'PA.Srg', 'PENGADILAN AGAMA SERANG', 'Jl. Raya Petir Km 03 Cipocok Jaya Serang Banten', 'Y', 4),
(412, 43, '400823', 'PA.Tng', 'PENGADILAN AGAMA TANGERANG', 'Jl. Perintis Kemerdekaan II, Kel. Babakan Kecamatan Tangerang Kota Tangerang', 'Y', 4),
(413, 43, '604723', 'PA.Tgrs', 'PENGADILAN AGAMA TIGARAKSA', 'Jl. Atiek Soeardi Tigaraksa', 'Y', 4),
(414, 44, '308035', 'PA.AGM', 'PENGADILAN AGAMA ARGA MAKMUR', 'Jalan Prof. M. Yamin No. 68 Arga Makmur', 'Y', 4),
(415, 44, '308152', 'PA.Bn', 'PENGADILAN AGAMA BENGKULU', 'Jalan Jend Basuki Rahmat No 11 Kota Bengkulu', 'Y', 4),
(416, 44, '308021', 'PA.Crp', 'PENGADILAN AGAMA CURUP', 'Jalan S. Sukowati No. 24 Curup Kabupaten Rejang Lebong Propinsi Bengkulu', 'Y', 4),
(417, 44, '308014', 'PA.Mna', 'PENGADILAN AGAMA MANNA', 'Jalan Raya Padang Panjang Manna', 'Y', 4),
(418, 44, '682253', 'PA.Lbg', 'PENGADILAN AGAMA LEBONG', 'Jl. Frans Nala, Batu Cermin, Kecamatan Komodo, Kabupaten Manggarai Barat, NTT, 86554', 'Y', 4),
(419, 45, '401225', 'PA.Btl', 'PENGADILAN AGAMA BANTUL', 'Jl. Urip Sumoharjo No.8, Bantul, Kec. Bantul, D.I.Yogyakarta - 55711', 'Y', 4),
(420, 45, '401200', 'PA.Smn', 'PENGADILAN AGAMA SLEMAN', 'Jl. Parasamya, Beran, Tridadi, Sleman 55511', 'Y', 4),
(421, 45, '401219', 'PA.Wt', 'PENGADILAN AGAMA WATES', 'JL. KH Ahmad Dahlan KM 2,6 Wates Kulon Progo', 'Y', 4),
(422, 45, '401231', 'PA.Wno', 'PENGADILAN AGAMA WONOSARI', 'KRT. Judoningrat, Siraman, Wonosari', 'Y', 4),
(423, 45, '401199', 'PA.YK', 'PENGADILAN AGAMA YOGYAKARTA', 'Jln. Ipda Tut Harsono No 53 Yogyakarta', 'Y', 4),
(424, 46, '307250', 'PA.Gtlo', 'PENGADILAN AGAMA GORONTALO', ' Jalan Achmad Nadjamudin, Kecamatan Wumialo, Kota Gorontalo KP. 96138 ', 'Y', 4),
(425, 46, '402690', 'PA.Lbt', 'PENGADILAN AGAMA LIMBOTO', 'Jl. Baso Bobihoe No. 9, Limboto, Kabupaten Gorontalo, Propinsi Gorontalo, 96211', 'Y', 4),
(426, 46, '652130', 'PA.Tlm', 'PENGADILAN AGAMA TILAMUTA', 'Jl. Trans Sulawesi, Desa Lamu, Kec. Tilamuta, Kab. Boalemo, Provinsi Gorontalo 96313', 'Y', 4),
(427, 46, '682185', 'PA.Msa', 'PENGADILAN AGAMA MARISA', 'Jln. Pangeran Diponegoro, Desa Palopo, Kecamatan Marisa, Kabupaten Pohuwato, 96265', 'Y', 4),
(428, 47, '402891', 'PA.Bik', 'PENGADILAN AGAMA BIAK', 'Jalan Majapahit', 'Y', 4),
(429, 47, '402902', 'PA.FF', 'PENGADILAN AGAMA FAK-FAK', 'Jl. Jendral Sudirman No. 7 Wagom', 'Y', 4),
(430, 47, '402876', 'PA.Jpr', 'PENGADILAN AGAMA JAYAPURA', 'Jl.Raya Kota Raja', 'Y', 4),
(431, 47, '402911', 'PA.Mw', 'PENGADILAN AGAMA MANOKWARI', 'Kompleks Business Park Ruko C3 & C4, Kel. Wosi, Kec. Manokwari Barat, Sanggeng Distrk Manokwari Barat', 'Y', 4),
(432, 47, '402958', 'PA.Mrk', 'PENGADILAN AGAMA MERAUKE', 'Jl. TMP Trikora No.96, Kec. Merauke, Kabupaten Merauke, Papua 99614', 'Y', 4),
(433, 47, '614773', 'PA.Mmk', 'PENGADILAN AGAMA MIMIKA', 'Jl. Yos Sudarso KM 4, Nawaripi - Timika', 'Y', 4),
(434, 47, '402927', 'PA.Nbr', 'PENGADILAN AGAMA NABIRE', 'Jl.Mandala Bumiwonorejo,kecamatan Nabire, Kabupaten Nabire', 'Y', 4),
(435, 47, '614780', 'PA.Pan', 'PENGADILAN AGAMA PANIAI', 'Jl. DR. Soetomo, Kelurahan Nabarua Kecamatan Nabire Kabupaten Nabire tlp. 0984 22522', 'Y', 4),
(436, 47, '614769', 'PA.Stn', 'PENGADILAN AGAMA SENTANI', 'Jalan Raya Sentani - Depapre Gunung Merah (Kompleks Kantor Bupati Kabupaten Jayapura)', 'Y', 4),
(437, 47, '402942', 'PA.Sri', 'PENGADILAN AGAMA SERUI', 'Jalan Irian, Serui', 'Y', 4),
(438, 47, '402933', 'PA.W', 'PENGADILAN AGAMA WAMENA', 'Jl. Diponegoro No. 10', 'Y', 4),
(439, 47, '402882', 'PA.Srog', 'PENGADILAN AGAMA SORONG', 'Jl. Pahlawan - Kelurahan Remu Utara', 'Y', 4),
(440, 47, '682300', 'PA.Ars', 'PENGADILAN AGAMA ARSO', 'Jl.Trans Swakarsa', 'Y', 4),
(441, 48, '402211', 'PA.Bko', 'PENGADILAN AGAMA BANGKO', 'Jl. Jenderal Sudirman KM 2 Bangko', 'Y', 4),
(442, 48, '402185', 'PA.Jmb', 'PENGADILAN AGAMA JAMBI', 'Jalan Jakarta Kecamatan Kota Baru Kota Jambi 36128', 'Y', 4),
(443, 48, '402205', 'PA.Ktl', 'PENGADILAN AGAMA KUALA TUNGKAL', 'Jl. Prof. Dr. Sri Soedewi MS. SH Kuala Tungkal, Jambi 36551', 'Y', 4),
(444, 48, '403052', 'PA.Mbl', 'PENGADILAN AGAMA MUARA BULIAN', 'Jl. Gajah Mada No. 10 Muara Bulian Kabupaten Batanghari', 'Y', 4),
(445, 48, '402191', 'PA.Mab', 'PENGADILAN AGAMA MUARA BUNGO', 'Jl. Raden Mataher Rimbo Tengah Muara Bungo', 'Y', 4),
(446, 48, '632022', 'PA.MS', 'PENGADILAN AGAMA MUARA SABAK', 'Jl. Komplek Perkantoran Bukit Menderang Muara Sabak', 'Y', 4),
(447, 48, '652020', 'PA.Mto', 'PENGADILAN AGAMA MUARA TEBO', 'Jl. Lintas Tebo -  Bungo Km 12 Muara Tebo', 'Y', 4),
(448, 48, '632018', 'PA.Srl', 'PENGADILAN AGAMA SAROLANGUN', 'Jl. Komplek Perkantoran Gunung Kembang, Kabupaten Sarolangun, Propinsi Jambi 37481', 'Y', 4),
(449, 48, '652034', 'PA.Sgt', 'PENGADILAN AGAMA SENGETI', 'Jl. Lintas Timur Komplek Perkantoran Bukit Cinto Kenang Muaro Jambi 36001', 'Y', 4),
(450, 48, '402220', 'PA.Spn', 'PENGADILAN AGAMA SUNGAI PENUH', 'Jl. Depati Parbo, Sungai Penuh', 'Y', 4),
(451, 49, '400662', 'PA.Badg', 'PENGADILAN AGAMA BANDUNG', 'Jl. Terusan Jakarta No.120,  Antapani Tengah', 'Y', 4),
(452, 49, '400832', 'PA.Bks', 'PENGADILAN AGAMA BEKASI', 'Jl. Jend. Ahmad Yani No. 10', 'Y', 4),
(453, 49, '400729', 'PA.Bgr', 'PENGADILAN AGAMA BOGOR', 'Jl. KH. Abdullah Bin Nuh', 'Y', 4),
(454, 49, '400690', 'PA.Cms', 'PENGADILAN AGAMA CIAMIS', 'Jl. RAA. Sastrawinata No. 2 Kabupaten Ciamis 46211', 'Y', 4),
(455, 49, '400741', 'PA.CJR', 'PENGADILAN AGAMA CIANJUR', 'Jl. Raya Bandung No.45', 'Y', 4),
(456, 49, '402995', 'PA.Cbd', 'PENGADILAN AGAMA CIBADAK', 'Jl. Jenderal Sudirman No. 3 Komplek Perkantoran OPD, Palabuhanratu, Kabupaten Sukabumi', 'Y', 4),
(457, 49, '604719', 'PA.Cbn', 'PENGADILAN AGAMA CIBINONG', 'Jl. Bersih No. 1 Komp. Pemda Kabupaten Bogor', 'Y', 4),
(458, 49, '614706', 'PA.Ckr', 'PENGADILAN AGAMA CIKARANG', 'Komplek Pemda Kab. Bekasi Blok E2 Sukamahi Cikarang Pusat', 'Y', 4),
(459, 49, '400684', 'PA.Cmi', 'PENGADILAN AGAMA CIMAHI', 'Jl. Raya Soreang Km. 17 Komp. Pemda Kab Bandung', 'Y', 4),
(460, 49, '400750', 'PA.CN', 'PENGADILAN AGAMA CIREBON', 'Jl. Brigjend H. Dharsono No. 05 (By Pass) Cirebon 45131', 'Y', 4),
(461, 49, '652062', 'PA.Dpk', 'PENGADILAN AGAMA DEPOK', 'Jl. Boulevard Sektor Anggrek Grand Depok City Kota Depok Jawa Barat (021-77835414 Fax 021-77828434) ', 'Y', 4),
(462, 49, '400710', 'PA.Grt', 'PENGADILAN AGAMA GARUT', 'Jl. Suherman No.39 , Desa Jati, Kecamatan Tarogong Kaler, Kab. Garut', 'Y', 4),
(463, 49, '400766', 'PA.IM', 'PENGADILAN AGAMA INDRAMAYU', 'Jl. M.T. Haryono  No. 2A Kec. Sindang Kab. Indramayu 45222', 'Y', 4),
(464, 49, '400848', 'PA.Krw', 'PENGADILAN AGAMA KARAWANG', 'Jl. Jend. Ahmad Yani No. 53 Kabupaten Karawang', 'Y', 4),
(465, 49, '400781', 'PA.Kng', 'PENGADILAN AGAMA KUNINGAN', 'Jalan Perjuangan No. 63, Ancaran', 'Y', 4),
(466, 49, '400772', 'PA.Mjl', 'PENGADILAN AGAMA MAJALENGKA', 'Jl. Gerakan Koperasi No. 33 Kabupaten Majalengka, Jawa Barat', 'Y', 4),
(467, 49, '400854', 'PA.Pwk', 'PENGADILAN AGAMA PURWAKARTA', 'Jl. Ir. H. Djuanda No.03 Purwakarta', 'Y', 4),
(468, 49, '402587', 'PA.Sbg', 'PENGADILAN AGAMA SUBANG', 'Jl. Aipda KS. Tubun No.1 Kabupaten Subang', 'Y', 4),
(469, 49, '400735', 'PA.SMI', 'PENGADILAN AGAMA SUKABUMI', 'Jl. Taman Bahagia No. 19 Kota Sukabumi', 'Y', 4),
(470, 49, '403009', 'PA.Sbr', 'PENGADILAN AGAMA SUMBER', 'Jl. Sunan Drajat No 1A Sumber', 'Y', 4),
(471, 49, '400678', 'PA.Smdg', 'PENGADILAN AGAMA SUMEDANG', 'Jl. Statistik No. 35 Sumedang', 'Y', 4),
(472, 49, '400704', 'PA.Tsm', 'PENGADILAN AGAMA TASIKMALAYA', 'Jl. By Pass Linggasari Komplek Perkantoran Pemkab Tasikmalaya', 'Y', 4),
(473, 49, '682150', 'PA.Tmk', 'PENGADILAN AGAMA KOTA TASIKMALAYA', 'Jln. Bebedahan II No.24/30 Kota Tasikmalaya', 'Y', 4),
(474, 49, '682164', 'PA.Bjr', 'PENGADILAN AGAMA KOTA BANJAR', 'Jl. Perintis Kemerdekaan No. 64 Kota Banjar ', 'Y', 4),
(475, 50, '402593', 'PA.Amb', 'PENGADILAN AGAMA AMBARAWA', 'Jl. Mgr. Soegijopranoto No. 105 Ambarawa', 'Y', 4),
(476, 50, '401106', 'PA.Ba', 'PENGADILAN AGAMA BANJARNEGARA', 'Jl. Letnan Jendral Suprapto', 'Y', 4),
(477, 50, '401070', 'PA.Bms', 'PENGADILAN AGAMA BANYUMAS', 'Jl. Raya Kaliori No. 58 Kec. Kaliori Kab. Banyumas', 'Y', 4),
(478, 50, '400905', 'PA.Btg', 'PENGADILAN AGAMA BATANG', 'Jl. KH AHMAD DAHLAN NO.62B BATANG', 'Y', 4),
(479, 50, '401002', 'PA.Bla', 'PENGADILAN AGAMA BLORA', 'Jl. Raya Blora Cepu Km. 3 Blora', 'Y', 4),
(480, 50, '401137', 'PA.Bi', 'PENGADILAN AGAMA BOYOLALI', 'Jl. Pandanaran No 167 Boyolali', 'Y', 4),
(481, 50, '400891', 'PA.Bbs', 'PENGADILAN AGAMA BREBES', 'Jl. Ahmad Yani No. 92', 'Y', 4),
(482, 50, '401086', 'PA.Clp', 'PENGADILAN AGAMA CILACAP', 'Jalan Dr. Rajiman No. 25B Cilacap', 'Y', 4),
(483, 50, '400942', 'PA.Dmk', 'PENGADILAN AGAMA DEMAK', 'Jl. Sultan Trenggono No. 23 Demak 59571', 'Y', 4),
(484, 50, '400982', 'PA.Jepr', 'PENGADILAN AGAMA JEPARA', 'Jl. Shima No. 18, Pengkol Jepara', 'Y', 4),
(485, 50, '401174', 'PA.Kra', 'PENGADILAN AGAMA KARANGANYAR', 'Jl. Lawu Timur No.137', 'Y', 4),
(486, 50, '401055', 'PA.Kbm', 'PENGADILAN AGAMA KEBUMEN', 'Jl.Indrakila No.42', 'Y', 4),
(487, 50, '400936', 'PA.Kdl', 'PENGADILAN AGAMA KENDAL', 'Jalan Soekarno Hatta Km. 4, Brangsong', 'Y', 4),
(488, 50, '401121', 'PA.Klt', 'PENGADILAN AGAMA KLATEN', 'Jl. K. H. Samanhudi No. 9 Klaten', 'Y', 4),
(489, 50, '400973', 'PA.Kds', 'PENGADILAN AGAMA KUDUS', 'Jl. Raya Kudus-Pati KM. 4', 'Y', 4),
(490, 50, '401018', 'PA.Mgl', 'PENGADILAN AGAMA MAGELANG', 'Jl. Sunan Giri Jurangombo Selatan', 'Y', 4),
(491, 50, '403021', 'PA.Mkd', 'PENGADILAN AGAMA MUNGKID', 'Jalan Soekarno - Hatta, Kota Mungkid, Kabupaten Magelang, 56511', 'Y', 4),
(492, 50, '400967', 'PA.Pt', 'PENGADILAN AGAMA PATI', 'Jl. P.  Sudirman No.67', 'Y', 4),
(493, 50, '400860', 'PA.Pkl', 'PENGADILAN AGAMA PEKALONGAN', 'Jl. Dr. Sutomo No.190 Pekalongan', 'Y', 4),
(494, 50, '400879', 'PA.PML', 'PENGADILAN AGAMA PEMALANG', 'Jl. Sulawesi Nomor 9A', 'Y', 4),
(495, 50, '401092', 'PA.Pbg', 'PENGADILAN AGAMA PURBALINGGA', 'Jl. Let Jend S. Parman No. 10', 'Y', 4),
(496, 50, '400951', 'PA.Pwd', 'PENGADILAN AGAMA PURWODADI', 'Jl. M. H. Thamrin  No. 09 Purwodadi', 'Y', 4),
(497, 50, '401061', 'PA.Pwt', 'PENGADILAN AGAMA PURWOKERTO', 'Jl. Gerilya No. 7A Purwokerto', 'Y', 4),
(498, 50, '401049', 'PA.Pwr', 'PENGADILAN AGAMA PURWOREJO', 'Jalan Pahlawan Nomor 5 Purworejo', 'Y', 4),
(499, 50, '400998', 'PA.Rbg', 'PENGADILAN AGAMA REMBANG', 'Jl. Pemuda Km.3 Rembang', 'Y', 4),
(500, 50, '400920', 'PA.Sal', 'PENGADILAN AGAMA SALATIGA', 'Jl. Lingkar Selatan, Argomulyo, Salatiga', 'Y', 4),
(501, 50, '400911', 'PA.Smg', 'PENGADILAN AGAMA SEMARANG', 'Jl. Urip Sumoharjo No. 5 Semarang 50152', 'Y', 4),
(502, 50, '403015', 'PA.Slw', 'PENGADILAN AGAMA SLAWI', 'Jl.Gajah Mada Po.Box.34 Slawi', 'Y', 4),
(503, 50, '401143', 'PA.Sr', 'PENGADILAN AGAMA SRAGEN', 'Jl. Dr. Soetomo No. 3A', 'Y', 4),
(504, 50, '401168', 'PA.Skh', 'PENGADILAN AGAMA SUKOHARJO', 'Jl.  Rajawali No. 10 Sukoharjo 57513', 'Y', 4),
(505, 50, '401180', 'PA.Ska', 'PENGADILAN AGAMA SURAKARTA', 'Jl. Veteran No. 273', 'Y', 4),
(506, 50, '400885', 'PA.Tg', 'PENGADILAN AGAMA TEGAL', 'Jl. Mataram No. 6', 'Y', 4),
(507, 50, '401024', 'PA.Tmg', 'PENGADILAN AGAMA TEMANGGUNG', 'Jl. Pahlawan No. 3 Temanggung (56214)', 'Y', 4),
(508, 50, '401152', 'PA.Wng', 'PENGADILAN AGAMA WONOGIRI', 'Jl. Pemuda No. 01, Kabupaten Wonogiri', 'Y', 4);
INSERT INTO `pengadilan_negeri` (`id`, `pt_id`, `kode`, `kode_pn`, `nama`, `alamat`, `aktif`, `jenis_pengadilan`) VALUES
(509, 50, '401030', 'PA.Wsb', 'PENGADILAN AGAMA WONOSOBO', 'Jl. Mayjend Bambang Sugeng Km 3', 'Y', 4),
(510, 50, '614710', 'PA.Kjn', 'PENGADILAN AGAMA KAJEN', 'Jl. Teuku Umar No. 9 Kajen Kabupaten Pekalongan', 'Y', 4),
(511, 51, '401441', 'PA.Bgl', 'PENGADILAN AGAMA BANGIL', 'Jl. Raya Raci - Bangil, Kab. Pasuruan, Prov. Jawa Timur', 'Y', 4),
(512, 51, '401545', 'PA.Bkl', 'PENGADILAN AGAMA BANGKALAN', 'Jalan Soekarno-Hatta no.49 Bangkalan', 'Y', 4),
(513, 51, '401369', 'PA.Bwi', 'PENGADILAN AGAMA BANYUWANGI', 'Jl. Ahmad Yani No. 106 Banyuwangi', 'Y', 4),
(514, 51, '401287', 'PA.Bwn', 'PENGADILAN AGAMA BAWEAN', 'Jl. Masjid Jami No.3 Sangkapura-Bawean', 'Y', 4),
(515, 51, '401401', 'PA.BL', 'PENGADILAN AGAMA BLITAR', 'Jalan Imam Bonjol No.42', 'Y', 4),
(516, 51, '401307', 'PA.Bjn', 'PENGADILAN AGAMA BOJONEGORO', 'M. H. Tharmin No. 88', 'Y', 4),
(517, 51, '401344', 'PA.Bdw', 'PENGADILAN AGAMA BONDOWOSO', 'Jl. Santawi No.94 A', 'Y', 4),
(518, 51, '401293', 'PA.Gs', 'PENGADILAN AGAMA GRESIK', 'Jl. Dr. Wahidin Sudirohusodo No. 45 Gresik', 'Y', 4),
(519, 51, '401338', 'PA.Jr', 'PENGADILAN AGAMA JEMBER', 'Jalan Cendrawasih No. 27 Jember', 'Y', 4),
(520, 51, '401271', 'PA.Jbg', 'PENGADILAN AGAMA JOMBANG', 'Jl. Prof. Dr. Nurcholish Madjid  Denanyar, Kab. Jombang', 'Y', 4),
(521, 51, '401375', 'PA.Kab.Kdr', 'PENGADILAN AGAMA KABUPATEN KEDIRI', 'Jl. Sekartaji No. 12', 'Y', 4),
(522, 51, '403030', 'PA.Kab.Mn', 'PENGADILAN AGAMA KABUPATEN MADIUN', ' Jl. Raya Tiron Km.06, Kecamatan Madiun, Madiun', 'Y', 4),
(523, 51, '604730', 'PA.KAB.MLG', 'PENGADILAN AGAMA KABUPATEN MALANG', 'Jl. Raya Mojosari No. 77 Kec. Kepanjen', 'Y', 4),
(524, 51, '401576', 'PA.Kgn', 'PENGADILAN AGAMA KANGEAN', 'Jl. Raya Duko No. 10 Arjasa Kepulauan Kangean', 'Y', 4),
(525, 51, '403046', 'PA.Kdr', 'PENGADILAN AGAMA KOTA MADYA KEDIRI', 'Jalan Sunan Ampel No.1', 'Y', 4),
(526, 51, '401488', 'PA.Mn', 'PENGADILAN AGAMA KOTA MADYA MADIUN', 'Jln Ring Road Barat No 1', 'Y', 4),
(527, 51, '401426', 'PA.MLG', 'PENGADILAN AGAMA KOTA MADYA MALANG', 'Jl. R. Panji Suroso No. 1', 'Y', 4),
(528, 51, '401463', 'PA.Krs', 'PENGADILAN AGAMA KRAKSAAN', 'Jl. Mayjen Sutoyo No. 69 Kraksaan,Kabupaten Probolinggo, Jawa Timur 67282', 'Y', 4),
(529, 51, '401322', 'PA.Lmg.', 'PENGADILAN AGAMA LAMONGAN', 'Jalan Panglima Sudirman 738 B Lamongan 62291', 'Y', 4),
(530, 51, '401472', 'PA.Lmj', 'PENGADILAN AGAMA LUMAJANG', 'Jl. Soekarno Hatta No.11 Lumajang', 'Y', 4),
(531, 51, '401494', 'PA.Mgt', 'PENGADILAN AGAMA MAGETAN', 'Jl. Raya Magetan Maospati Km.06', 'Y', 4),
(532, 51, '401256', 'PA.Mr', 'PENGADILAN AGAMA MOJOKERTO', 'Jalan Raya Prajurit Kulon No. 17 Mojokerto Jawa Timur 61326 Indonesia ', 'Y', 4),
(533, 51, '401410', 'PA.NGJ', 'PENGADILAN AGAMA NGANJUK', 'Jl. Gatot Subroto - Nganjuk', 'Y', 4),
(534, 51, '401508', 'PA.Ngw', 'PENGADILAN AGAMA NGAWI', 'Jalan Trunojoyo N0. 59 Ngawi', 'Y', 4),
(535, 51, '401520', 'PA.Pct', 'PENGADILAN AGAMA PACITAN', 'Jl. K.S. Tubun No. 09 Pacitan', 'Y', 4),
(536, 51, '401539', 'PA.Pmk', 'PENGADILAN AGAMA PAMEKASAN', 'Jalan Raya Tlanakan', 'Y', 4),
(537, 51, '401432', 'PA.Pas', 'PENGADILAN AGAMA PASURUAN', 'Jl. Ir. H. JUANDA NO. 11 A', 'Y', 4),
(538, 51, '401514', 'PA.Po', 'PENGADILAN AGAMA PONOROGO', 'Jl. Ir. H. Juanda No. 25 Ponorogo, Jawa Timur 63418', 'Y', 4),
(539, 51, '401457', 'PA.Prob', 'PENGADILAN AGAMA PROBOLINGGO', 'Jl. Bromo KM. 07 Probolinggo', 'Y', 4),
(540, 51, '401551', 'PA.Spg', 'PENGADILAN AGAMA SAMPANG', 'Jl. Jaksa Agung Suprapto No.86,Kec. Sampang,Kabupaten Sampang, Jawa Timur 69216', 'Y', 4),
(541, 51, '401262', 'PA.Sda', 'PENGADILAN AGAMA SIDOARJO', 'Jl Hasanuddin 90 Sidoarjo', 'Y', 4),
(542, 51, '401350', 'PA.Sit', 'PENGADILAN AGAMA SITUBONDO', 'Jl. Jaksa Agung Suprapto No. 18', 'Y', 4),
(543, 51, '401560', 'PA.Smp', 'PENGADILAN AGAMA SUMENEP', 'Jln. Trunojoyo KM. 3 No. 300 Sumenep', 'Y', 4),
(544, 51, '401240', 'PA.Sby', 'PENGADILAN AGAMA SURABAYA', 'Jl. Ketintang Madya VI/3 Surabaya', 'Y', 4),
(545, 51, '401390', 'PA.TL', 'PENGADILAN AGAMA TRENGGALEK', 'Jl. Dr. Sutomo No. 21 Trenggalek', 'Y', 4),
(546, 51, '450737', 'PA.Tbn', 'PENGADILAN AGAMA TUBAN', 'Jl. Sunan Kalijogo No. 27', 'Y', 4),
(547, 51, '401381', 'PA.TA', 'PENGADILAN AGAMA TULUNGAGUNG', 'Jl. Ir. Soekarno Hatta No.117 Balerejo, Kauman, Tulungagung', 'Y', 4),
(548, 52, '632039', 'PA.Bky', 'PENGADILAN AGAMA BENGKAYANG', 'Jalan Alianyang No. 34 A Singkawang', 'Y', 4),
(549, 52, '402386', 'PA.Ktp', 'PENGADILAN AGAMA KETAPANG', 'Jl. Letjend. S. Parman No. 67 Ketapang', 'Y', 4),
(550, 52, '402669', 'PA.Mpw', 'PENGADILAN AGAMA MEMPAWAH', 'Jl. Raden Kusno No. 39 Mempawah', 'Y', 4),
(551, 52, '402361', 'PA.Ptk', 'PENGADILAN AGAMA PONTIANAK', 'Jl. Jenderal Ahmad Yani No.8', 'Y', 4),
(552, 52, '402412', 'PA.Pts', 'PENGADILAN AGAMA PUTUSSIBAU', 'Jl. D.I. Pandjaitan Nomor 10 Putussibau', 'Y', 4),
(553, 52, '402370', 'PA.Sbs', 'PENGADILAN AGAMA SAMBAS', 'Jln. Pembangunan -  Sambas', 'Y', 4),
(554, 52, '402392', 'PA.Sgu', 'PENGADILAN AGAMA SANGGAU', 'Jl. Jend. Sudirman km 7 No.14A Sanggau', 'Y', 4),
(555, 52, '402406', 'PA.Stg', 'PENGADILAN AGAMA SINTANG', 'Jalan.PKP. Mujahidin No.14 Sintang', 'Y', 4),
(556, 53, '402556', 'PA.AMT', 'PENGADILAN AGAMA AMUNTAI', 'Jl.Empu Mandastana No.10 Kel.Sungai Malang Kec. Amuntai Tengah', 'Y', 4),
(557, 53, '632043', 'PA.BJB', 'PENGADILAN AGAMA BANJARBARU', 'Jl.Trikora No.4', 'Y', 4),
(558, 53, '402500', 'PA.Bjm', 'PENGADILAN AGAMA BANJARMASIN', 'Jl.Gatot Subroto No. 97', 'Y', 4),
(559, 53, '402540', 'PA.Brb', 'PENGADILAN AGAMA BARABAI', 'Jl. H. Abdul Muis Redhani No. 42', 'Y', 4),
(560, 53, '402531', 'PA.Kdg', 'PENGADILAN AGAMA KANDANGAN', 'Jl.Jend Sudirman Km.2 No.35', 'Y', 4),
(561, 53, '307122', 'PA.KTB', 'PENGADILAN AGAMA KOTA BARU', 'Jl.Raya Stagen Km.10 RT.2', 'Y', 4),
(562, 53, '307101', 'PA.Mrb', 'PENGADILAN AGAMA MARABAHAN', 'Jln. Jenderal Sudirman Komp. Perkantoran Marabahan', 'Y', 4),
(563, 53, '402519', 'PA.Mtp', 'PENGADILAN AGAMA MARTAPURA', 'Jl.Perwira No.47G Martapura', 'Y', 4),
(564, 53, '307115', 'PA.Plh', 'PENGADILAN AGAMA PELAIHARI', 'Jl.H.Boejasin Komp.Perk Gagas', 'Y', 4),
(565, 53, '682260', 'PA.Blcn', 'PENGADILAN AGAMA BATULICIN', 'JL. Dharma Praja No. 45 RT.02 RW. 01 Gunung Tinggi', 'Y', 4),
(566, 53, '402525', 'PA.Rtu', 'PENGADILAN AGAMA RANTAU', 'Jl.R.Suprapto No.30', 'Y', 4),
(567, 53, '402562', 'PA.Tjg', 'PENGADILAN AGAMA TANJUNG', 'Jl.Tanjung Selatan Raya No.661 Rt.17 Kelurahan Pembataan Kecamatan Murung Pudak Kabupaten Tabalong', 'Y', 4),
(568, 53, '402571', 'PA.Negr', 'PENGADILAN AGAMA NEGARA', 'Jl. Negara Kandangan Km.3,5 No.160 Negara Kandangan', 'Y', 4),
(569, 54, '402452', 'PA.Btk', 'PENGADILAN AGAMA BUNTOK', 'JL. Buntok Ampah Km. 12 No. 62', 'Y', 4),
(570, 54, '402468', 'PA.K.Kps', 'PENGADILAN AGAMA KUALA KAPUAS', 'Jl. Pemuda KM. 5,5 Kuala Kapuas', 'Y', 4),
(571, 54, '402443', 'PA.Mtw', 'PENGADILAN AGAMA MUARA TEWEH', 'Jl. Yetro Sinseng No. 25 Telp. (0519) 21240 / Fax. (0519) 24605 Muara Teweh 73812', 'Y', 4),
(572, 54, '402421', 'PA.Plk', 'PENGADILAN AGAMA PALANGKARAYA', 'Jl. Kapten Piere Tendean No. 2 Palangka Raya', 'Y', 4),
(573, 54, '402437', 'PA.PBun', 'PENGADILAN AGAMA PANGKALAN BUN', 'Jl.Pasir Panjang Kumpai Batu Atas Km. 5,5', 'Y', 4),
(574, 54, '402474', 'PA.Spt', 'PENGADILAN AGAMA SAMPIT', 'Jl. Jend. Sudirman km 3,5 Sampit', 'Y', 4),
(575, 55, '307199', 'PA.Bpp', 'PENGADILAN AGAMA BALIKPAPAN', 'Jl. Kol. H. Syarifuddin Yoes, No. 1 Balikpapan', 'Y', 4),
(576, 55, '652080', 'PA.Botg', 'PENGADILAN AGAMA BONTANG', 'Jl. Awang Long, No. 69, Bontang', 'Y', 4),
(577, 55, '307161', 'PA.Tgr', 'PENGADILAN AGAMA TENGGARONG', 'Jl Pesut, Kelurahan Timbau', 'Y', 4),
(578, 55, '307178', 'PA.Smd', 'PENGADILAN AGAMA SAMARINDA', 'Jl. Ir. H. Juanda No. 64 Samarinda', 'Y', 4),
(579, 55, '652097', 'PA.Sgta', 'PENGADILAN AGAMA SANGATTA', 'Jl. Prof. Dr. Baharudin Lopa, S.H, No.1, Bukit Pelangi Sangatta', 'Y', 4),
(580, 55, '307182', 'PA.Tgt', 'PENGADILAN AGAMA TANAH GROGOT', 'Jl. Sultan Ibrahim Khaliluddin, Tanah Grogot', 'Y', 4),
(581, 55, '307204', 'PA.TR', 'PENGADILAN AGAMA TANJUNG REDEB', 'Jalan Mangga I No. 09, Tanjung Redeb Kabupaten Berau ', 'Y', 4),
(582, 55, '307211', 'PA.TSe', 'PENGADILAN AGAMA TANJUNG SELOR', 'Jalan Sengkawit, RT. 5 Tanjung Selor', 'Y', 4),
(583, 55, '402675', 'PA.Trk', 'PENGADILAN AGAMA TARAKAN', 'Jl. Sei. Sesayap, No. 1, Tarakan', 'Y', 4),
(584, 55, '682295', 'PA.Nnk', 'PENGADILAN AGAMA NUNUKAN', 'Komplek Perkantoran Vertikal Jl. Ujang Dewa, Kelurahan Nunukan Selatan, Kabupaten Nunukan', 'Y', 4),
(585, 56, '402302', 'PA.PKP', 'PENGADILAN AGAMA PANGKAL PINANG', 'Jl. Pulau Bangka Komplek Perkantoran Pemprov. Kep. Bangka Belitung', 'Y', 4),
(586, 56, '403092', 'PA.Sglt', 'PENGADILAN AGAMA SUNGAILIAT', 'Jl. Jend. Ahmad Yani Jalur II - Sungailiat', 'Y', 4),
(587, 56, '402318', 'PA.TDN', 'PENGADILAN AGAMA TANJUNG PANDAN', 'Jl. Anwar N0. 5 Tanjungpandan', 'Y', 4),
(588, 56, '682249', 'PA.MTK', 'PENGADILAN AGAMA MENTOK', 'Komplek Perkantoran Pemkab Bangka Barat, Dusun IV Daya Baru,Desa Belo Laut,Kecamatan Muntok', 'Y', 4),
(589, 57, '652055', 'PA.Blu', 'PENGADILAN AGAMA BLAMBANGAN UMPU', 'Jl. Mayjend Ryacudu Km. 5 Blambangan Umpu', 'Y', 4),
(590, 57, '652041', 'PA.Gsg', 'PENGADILAN AGAMA GUNUNG SUGIH', 'Jalan Negara No. 99 Gunung Sugih', 'Y', 4),
(591, 57, '402644', 'PA.Kla', 'PENGADILAN AGAMA KALIANDA', 'Jl. Kolonel Makmun Rasyid No.48  Kalianda', 'Y', 4),
(592, 57, '402349', 'PA.Ktbm', 'PENGADILAN AGAMA KOTABUMI', 'Jl. Letjend. H. Alamsyah Ratu Perwira Negara No.138 Kotabumi', 'Y', 4),
(593, 57, '402330', 'PA.Kr', 'PENGADILAN AGAMA KRUI', 'JL. Mawar No. 10 Way Mengaku Liwa', 'Y', 4),
(594, 57, '402355', 'PA.Mt', 'PENGADILAN AGAMA METRO', 'Jl. Raya Stadion 24 B, Kelurahan Tejoagung, Kecamatan Metro Timur, Kota Metro', 'Y', 4),
(595, 57, '402324', 'PA.Tnk', 'PENGADILAN AGAMA TANJUNG KARANG', 'Jl. Untung Surapati No. 2 Bandar Lampung', 'Y', 4),
(596, 57, '614691', 'PA.Tgm', 'PENGADILAN AGAMA TANGGAMUS', 'Jl. Jend. Ahmad Yani Komplek Pemkab Tanggamus', 'Y', 4),
(597, 57, '614684', 'PA.Tlb', 'PENGADILAN AGAMA TULANG BAWANG', 'Jl. Cemara Komplek Pemda Tulang Bawang   , Menggala', 'Y', 4),
(598, 58, '307754', 'PA.Ab', 'PENGADILAN AGAMA AMBON', 'Jln. KH. Achmad Dahlan - Air Kuning', 'Y', 4),
(599, 58, '307775', 'PA.Msh', 'PENGADILAN AGAMA MASOHI', 'Jln. Kuako No 4, Kota Masohi. Kabupaten Maluku Tengah', 'Y', 4),
(600, 58, '307761', 'PA. Tl', 'PENGADILAN AGAMA TUAL', 'Jln. Jenderal Soedirman, Ohoijang, Langgur, Kabupaten Maluku Tenggara - 97610', 'Y', 4),
(601, 59, '307818', 'PA.Lbh', 'PENGADILAN AGAMA LABUHA', 'JL. BENTENG BARNAVELD, LABUHA, BACAN.', 'Y', 4),
(602, 59, '307796', 'PA.MORTB', 'PENGADILAN AGAMA MOROTAI', 'Jl. Tugu Nusantara, Desa Gosoma, Kecamatan Tobelo, Kabupaten Halmahera Utara, Propinsi Maluku Utara', 'Y', 4),
(603, 59, '307801', 'PA.SS', 'PENGADILAN AGAMA SOASIO', 'JL. Jenderal Ahmad Yani, No. 10', 'Y', 4),
(604, 59, '307782', 'PA.Tte', 'PENGADILAN AGAMA TERNATE ', 'Jln. Tugu Makugawene Ternate Selatan', 'Y', 4),
(605, 60, '401591', 'MS.Bna', 'MAHKAMAH SYAR''IYAH BANDA ACEH', 'Jl. Soekarno Hatta KM.02 Gampong Mibo, Banda Raya, Banda Aceh', 'Y', 4),
(606, 60, '401633', 'MS.BIR', 'MAHKAMAH SYAR''IYAH BIREUEN', 'Jln. Banda Aceh - Medan Km. 210 Blang Bladeh, Bireuen', 'Y', 4),
(607, 60, '401709', 'MS.Bkj', 'MAHKAMAH SYAR''IYAH BLANGKEJEREN', 'Jln. Inen Mayak Teri, Blangkejeren, Kab. Gayo Lues, 24653', 'Y', 4),
(608, 60, '401746', 'MS.Cag', 'MAHKAMAH SYAR''IYAH CALANG', 'Jln. Pengadilan No. 2 Gampong Blang, Calang, Aceh Jaya', 'Y', 4),
(609, 60, '401670', 'MS.Idi', 'MAHKAMAH SYAR''IYAH IDI', 'Jln. Banda Aceh-Medan, Km. 381, Paya Gajah, Peureulak Barat, Aceh Timur', 'Y', 4),
(610, 60, '402607', 'MS.Jth', 'MAHKAMAH SYAR''IYAH JANTHO ', 'Jln. T. Bachtiar P. Polem, SH', 'Y', 4),
(611, 60, '401695', 'MS.KSG', 'MAHKAMAH SYAR''IYAH KUALA SIMPANG', 'Jln. Sekerak-Kampung Bundar Karang Baru, Komplek Perkantoran Pemkab A. Tamiang', 'Y', 4),
(612, 60, '401715', 'MS.KC', 'MAHKAMAH SYAR''IYAH KUTACANE', 'Jln. Bedussamad No. 259', 'Y', 4),
(613, 60, '401689', 'MS.Lgs', 'MAHKAMAH SYAR''IYAH LANGSA', 'Jln. T.M. Bahrum', 'Y', 4),
(614, 60, '401664', 'MS.Lsm', 'MAHKAMAH SYAR''IYAH LHOKSEUMAWE', 'Jln. Banda Aceh - Medan Desa Alue Awe Kecamatan Muara Dua', 'Y', 4),
(615, 60, '401642', 'MS.Lsk', 'MAHKAMAH SYARI''YAH LHOKSUKON', 'Jln. Medan- Banda Aceh Gampong Alue Mudem', 'Y', 4),
(616, 60, '401721', 'MS.Mbo', 'MAHKAMAH SYAR''IYAH MEULABOH', 'Jl. Rahmat Tsunami No. 03 Peunaga Paya, Meureubo - Aceh Barat', 'Y', 4),
(617, 60, '401627', 'MS.Mrd', 'MAHKAMAH SYAR''IYAH MEUREUDU', 'Komplek Perkantoran Pemkab. Pidie Jaya, Cot Trieng', 'Y', 4),
(618, 60, '401602', 'MS.Sab', 'MAHKAMAH SYAR''IYAH SABANG', 'Jln. Yossudarso Gp. Cot Ba''u Kota Sabang', 'Y', 4),
(619, 60, '401611', 'MS.Sgi', 'MAHKAMAH SYAR''IYAH SIGLI', 'Jln. Lingkar-Blang Paseh Sigli', 'Y', 4),
(620, 60, '401730', 'MS.Snb', 'MAHKAMAH SYAR''IYAH SINABANG', 'Jln. Tgk. Diujung KM. 5 Desa Suak Buluh, Kecamatan Simeulue Timur, Kabupaten Simeulue', 'Y', 4),
(621, 60, '401752', 'MS.Skl', 'MAHKAMAH SYARI''YAH SINGKIL', 'Jln. Raya Singkil Rimo KM. 20', 'Y', 4),
(622, 60, '401658', 'MS.Tkn', 'MAHKAMAH SYAR''IYAH TAKENGON', 'Jln. Lukup Badak, Blang Bebangka Kecamatan Pegasing, Kabupaten Aceh Tengah', 'Y', 4),
(623, 60, '401761', 'MS.Ttn', 'MAHKAMAH SYAR''IYAH TAPAK TUAN', 'Jln. T. Ben Mahmud, Air Berudang ', 'Y', 4),
(624, 60, '682228', 'MS.STR', 'MAHKAMAH SYAR''IYAH SIMPANG TIGA REDELONG', 'Jln. Bandara Rembele, Kampung Wonosobo, Kecamatan Wih Pesam, Kabupaten Bener Meriah', 'Y', 4),
(625, 61, '614731', 'PA.BDG', 'PENGADILAN AGAMA BADUNG', 'Jalan Raya Sempidi No. 1 Mengwi', 'Y', 4),
(626, 61, '402726', 'PA.Bagl', 'PENGADILAN AGAMA BANGLI', 'Jl. Merdeka No. 140 Bangli', 'Y', 4),
(627, 61, '307822', 'PA.Dps', 'PENGADILAN AGAMA DENPASAR', 'Jl. Cokroaminoto Gg. Katalia I', 'Y', 4),
(628, 61, '402772', 'PA.Gia', 'PENGADILAN AGAMA GIANYAR', 'Jl. By Pass Dharma Giri, Buruan, Gianyar', 'Y', 4),
(629, 61, '402741', 'PA.Kras', 'PENGADILAN AGAMA KARANGASEM', 'Jl. RA. Kartini - Amlapura', 'Y', 4),
(630, 61, '402763', 'PA.Klg', 'PENGADILAN AGAMA KLUNGKUNG', 'JL. Raya Takmung No. 88, Banjarangkan, Kabupaten Klungkung, Bali 80716', 'Y', 4),
(631, 61, '402732', 'PA.Ngr', 'PENGADILAN AGAMA NEGARA', 'Jln.Ngurah Rai No. 122 Negara-Bali', 'Y', 4),
(632, 61, '307839', 'PA.Sgr', 'PENGADILAN AGAMA SINGARAJA', 'Jl. Udayana No.15', 'Y', 4),
(633, 61, '402757', 'PA.Tbnan', 'PENGADILAN AGAMA TABANAN', 'Jl. Pulau Batam No.12 B Tabanan', 'Y', 4),
(634, 61, '307928', 'PA.Bm', 'PENGADILAN AGAMA BIMA', 'Jl. Gatot Subroto No. 10 Raba-Bima', 'Y', 4),
(635, 61, '307932', 'PA.Dp', 'PENGADILAN AGAMA DOMPU', 'JL. SONOKLING NO.5', 'Y', 4),
(636, 61, '614727', 'PA.GM', 'PENGADILAN AGAMA GIRI MENANG', 'JL. Soekarno-Hatta No.2, Kec. Gerung, Kab. Lombok Barat-NTB', 'Y', 4),
(637, 61, '307885', 'PA.Mtr', 'PENGADILAN AGAMA MATARAM', 'JL. LANGKO NO.3', 'Y', 4),
(638, 61, '307907', 'PA.Pra', 'PENGADILAN AGAMA PRAYA', 'Jl. Jendral A Yani No. 3 Praya Kabupaten Lombok Tengah NTB', 'Y', 4),
(639, 61, '307911', 'PA.SEL', 'PENGADILAN AGAMA SELONG', 'Jln. Dr. Cipto Mangunkusumo No. 200  Selong, Lombok Timur', 'Y', 4),
(640, 61, '307892', 'PA.SUB', 'PENGADILAN AGAMA SUMBAWA BESAR', 'JL.BUNGUR NO.4 B', 'Y', 4),
(641, 61, '682274', 'PA.TLG', 'PENGADILAN AGAMA TALIWANG', 'Jl. Pendidikan no. 46 Taliwang, Kabupaten Sumbawa Barat', 'Y', 4),
(642, 62, '402814', 'PA.Atb', 'PENGADILAN AGAMA ATAMBUA', 'Jl. Sultan Hamengkubuwono IX No.3, Atambua', 'Y', 4),
(643, 62, '402845', 'PA.BJW', 'PENGADILAN AGAMA BAJAWA', 'Jln. Patimura - Bajawa', 'Y', 4),
(644, 62, '307974', 'PA.Ed', 'PENGADILAN AGAMA ENDE', 'Jl.Gatot Subroto, Kilometer 4, Kelurahan Mautapaga, Kecamatan Ende Timur, Kabupaten Ende, Nusa Tenggara Timur', 'Y', 4),
(645, 62, '307960', 'PA.Klb', 'PENGADILAN AGAMA KALABAHI', 'Jl. Soekarno-Hatta Batunirwala Kalabahi', 'Y', 4),
(646, 62, '402839', 'PA.Kfn', 'PENGADILAN AGAMA KEFAMENANU', 'Jl. Benpasi No.1 Kefamenanu ', 'Y', 4),
(647, 62, '307953', 'PA.Kp', 'PENGADILAN AGAMA KUPANG', 'Jl.Kejora', 'Y', 4),
(648, 62, '402794', 'PA.Lrt', 'PENGADILAN AGAMA LARANTUKA', 'Jl.Ahmad Yani No. 10', 'Y', 4),
(649, 62, '632064', 'PA.Lwb', 'PENGADILAN AGAMA LEWOLEBA', 'J. Trans Atadei, Lusikawak, Lewoleba-Lembata (0383) 2343133', 'Y', 4),
(650, 62, '402851', 'PA.Mur', 'PENGADILAN AGAMA MAUMERE', 'Jl.Diponegoro , Kelurahan Wolomarang, Kecamatan Alok Barat, Maumere', 'Y', 4),
(651, 62, '402808', 'PA.Rtg', 'PENGADILAN AGAMA RUTENG', 'Jl. Satar Tacik, Ruteng-NTT', 'Y', 4),
(652, 62, '402820', 'PA.Soe', 'PENGADILAN AGAMA SOE', 'Jl. Cendana, Soe - Nusa tenggara Timur 85512', 'Y', 4),
(653, 62, '307949', 'PA.WKB', 'PENGADILAN AGAMA WAIKABUBAK', 'Jl. Nangka No.14, Waikabubak', 'Y', 4),
(654, 62, '307981', 'PA.WGP', 'PENGADILAN AGAMA WAINGAPU', 'Jl. Soeharto, Waingapu - Nusa Tenggara Timur - Kode Pos 87112', 'Y', 4),
(655, 62, '682281', 'PA.Lbj', 'PENGADILAN AGAMA LABUAN BAJO', 'Jl. Frans Nala, Batu Cermin, Kecamatan Komodo, Kabupaten Manggarai Barat, NTT, 86554', 'Y', 4),
(656, 63, '402101', 'PA.Bkn', 'PENGADILAN AGAMA BANGKINANG', 'Jln. Jend. Sudirman No. 99 Kel. Langgini, Kec. Bangkinang Kota, Kab. Kampar Prov. Riau', 'Y', 4),
(657, 63, '402117', 'PA.Bkls', 'PENGADILAN AGAMA BENGKALIS', 'Jln. Lembaga No.01 Senggoro - Bengkalis', 'Y', 4),
(658, 63, '402622', 'PA.Dum', 'PENGADILAN AGAMA DUMAI', 'Jl. Putri Tujuh', 'Y', 4),
(659, 63, '631999', 'Pa.Pkc', 'PENGADILAN AGAMA PANGKALAN KERINCI', 'Jl. Hangtuah Sp. 6', 'Y', 4),
(660, 63, '402123', 'PA.Ppg', 'PENGADILAN AGAMA PASIR PENGARAIAN', 'Jl. Diponegoro KM. 2 No. 10-11, Pasir Pengaraian', 'Y', 4),
(661, 63, '402072', 'PA.Pbr', 'PENGADILAN AGAMA PEKANBARU', 'Jl. Datuk Setia Maharaja/Parit Indah, Kota Pekanbaru', 'Y', 4),
(662, 63, '402081', 'PA.Rgt', 'PENGADILAN AGAMA RENGAT', 'Jl. Batu Canai No. 17 Pematang Reba, Rengat, Indragiri Hulu, Riau 29351', 'Y', 4),
(663, 63, '402132', 'PA.Slp', 'PENGADILAN AGAMA SELAT PANJANG', 'Jl. Dorak', 'Y', 4),
(664, 63, '402097', 'PA.Tbh', 'PENGADILAN AGAMA TEMBILAHAN', 'JL Bunga No 06', 'Y', 4),
(665, 63, '632001', 'PA.Utj', 'PENGADILAN AGAMA UJUNG TANJUNG', 'JL. Lintas Riau - Sumut KM. 167, Kel. Banjar XII, Kec. Tanah Putih, Kab. Rohil', 'Y', 4),
(666, 63, '547699', 'PA.Btm', 'PENGADILAN AGAMA BATAM', 'Jl.Ir Sutami Sekupang- Batam', 'Y', 4),
(667, 63, '402154', 'PA.DBS', 'PENGADILAN AGAMA DABO SINGKEP', 'Jl. Kartini No. 48 Dabo Singkep Kab. Lingga 29171 ', 'Y', 4),
(668, 63, '614670', 'PA.Ntn', 'PENGADILAN AGAMA NATUNA', 'Jl. HR. Soebrantas No. 127 - Ranai', 'Y', 4),
(669, 63, '402148', 'PA.TPI', 'PENGADILAN AGAMA TANJUNGPINANG', 'Jln. Raya Senggarang Tanjungpinang', 'Y', 4),
(670, 63, '402179', 'PA.Trp', 'PENGADILAN AGAMA TAREMPA', 'Jl. Jend. A  Yani No. 40 A Tarempa Kabupaten Kepulauan Anambas Provinsi Kepulauan Riau', 'Y', 4),
(671, 63, '402160', 'PA.TBK', 'PENGADILAN AGAMA TANJUNG BALAI KARIMUN', 'Jl.Jendral Sudirman/ Poros Tanjung Balai Karimun Propinsi Kepulauan Riau', 'Y', 4),
(672, 64, '307534', 'PA.Batg', 'PENGADILAN AGAMA BANTAENG', 'Jl.A.Manappiang No.1', 'Y', 4),
(673, 64, '307487', 'PA.Br', 'PENGADILAN AGAMA BARRU', 'Jalan Sultan Hasanuddin No. 111', 'Y', 4),
(674, 64, '307541', 'PA.Blk', 'PENGADILAN AGAMA BULUKUMBA', 'Jl.Lanto Dg.Pasewang No.18, Kelurahan Tanah Kongkong, Kecamatan Ujung Bulu, Kabuptaen Bulukumba, Prov. Sulawesi Selatan', 'Y', 4),
(675, 64, '307597', 'PA.EK', 'PENGADILAN AGAMA ENREKANG', 'Jalan Sultan Hasanuddin No. 190/450', 'Y', 4),
(676, 64, '307466', 'PA.Jnp', 'PENGADILAN AGAMA JENEPONTO', 'Jl. Pahlawan, Kel. Empoang, Kec. Binamu, Kab. Jeneponto', 'Y', 4),
(677, 64, '307644', 'PA.Mj', 'PENGADILAN AGAMA MAJENE', 'Jl. Jenderal Sudirman No.91 Majene, Sulawesi Barat', 'Y', 4),
(678, 64, '307623', 'PA.Mkl', 'PENGADILAN AGAMA MAKALE', 'Jl. Merdeka No. 15, Makale', 'Y', 4),
(679, 64, '307651', 'PA.Mmj', 'PENGADILAN AGAMA MAMUJU', 'Jalan KS Tubun No. 68 Mamuju Sulawesi Barat', 'Y', 4),
(680, 64, '307445', 'PA.Mrs', 'PENGADILAN AGAMA MAROS', 'Jl. Jend. Sudirman No. 9 Maros', 'Y', 4),
(681, 64, '632050', 'PA.Msb', 'PENGADILAN AGAMA MASAMBA', 'Jl.Simpurusiang No.- Masamba, Kab. Luwu Utara, Prop. Sulawesi Selatan', 'Y', 4),
(682, 64, '307619', 'PA.Plp', 'PENGADILAN AGAMA PALOPO', 'Jl.Andi Djemma', 'Y', 4),
(683, 64, '307431', 'PA.Pkj', 'PENGADILAN AGAMA PANGKAJENE', 'Jl. Poros Makassar Pare-Pare (Mattampa) Kec. Bungoro, Kab. Pangkep', 'Y', 4),
(684, 64, '307576', 'PA.Pare', 'PENGADILAN AGAMA PARE-PARE', 'Jenderal Sudirman No. 74', 'Y', 4),
(685, 64, '307580', 'PA.Prg', 'PENGADILAN AGAMA PINRANG', 'Jl. Bintang, Kelurahan Maccorawalie, Kecamatan Watang Sawitto, Kabupaten Pinrang', 'Y', 4),
(686, 64, '307630', 'PA.Pwl', 'PENGADILAN AGAMA POLEWALI', 'Jl. Budi Utomo No. 23, Polewali, Kabupaten Polewali Mandar ', 'Y', 4),
(687, 64, '307562', 'PA.Sly', 'PENGADILAN AGAMA SELAYAR', 'Jl. Jend. Ahmad Yani No. 133 Benteng Kepulauan Selayar', 'Y', 4),
(688, 64, '307513', 'PA.Skg', 'PENGADILAN AGAMA SENGKANG', 'Jalan Beringin I Sengkang', 'Y', 4),
(689, 64, '307602', 'PA.SIDRAP', 'PENGADILAN AGAMA SIDENRENG RAPPANG', 'Jl.Korban 40.000 No.4', 'Y', 4),
(690, 64, '307555', 'PA.Sj', 'PENGADILAN AGAMA SINJAI', 'Jl. Jend. Sudirman No. 5', 'Y', 4),
(691, 64, '307491', 'PA.Sgm', 'PENGADILAN AGAMA SUNGGUMINASA', 'Jalan Masjid Raya Sungguminasa', 'Y', 4),
(692, 64, '307470', 'PA.Tkl', 'PENGADILAN AGAMA TAKALAR', 'Jl. Pangeran Diponegoro No. 5 Takalar', 'Y', 4),
(693, 64, '307509', 'PA.Wtp', 'PENGADILAN AGAMA WATAMPONE', 'Jl. Laksamana Yos Sudarso No. 49A, Kab. Bone', 'Y', 4),
(694, 64, '307520', 'PA.Wsp', 'PENGADILAN AGAMA WATANSOPPENG', 'Jl.Salotungo', 'Y', 4),
(695, 64, '307452', 'PA.Mks', 'PENGADILAN AGAMA MAKASSAR', 'Jl. Perintis Kemerdekaan Km.14 Daya, Makassar', 'Y', 4),
(696, 65, '652123', 'PA.Bgi', 'PENGADILAN AGAMA BANGGAI', 'Jl. Ki Hajar Dewantara, Timbong, Kec. Banggai Tengah, Kab. Banggai Laut, Prov. Sulawesi Tengah', 'Y', 4),
(697, 65, '652119', 'PA.Buk', 'PENGADILAN AGAMA BUNGKU', 'Jl. Trans Sulawesi - Kec. Bungku Tengah', 'Y', 4),
(698, 65, '652102', 'PA.Buol', 'PENGADILAN AGAMA BUOL', 'Jalan Ir. Karim Mbow, Kel. Leok 2, Kec. Biau, Kab. Buol', 'Y', 4),
(699, 65, '604765', 'PA.Dgl', 'PENGADILAN AGAMA DONGGALA', 'JL. VATU BALA KOMPLEKS PERKANTORAN DONGGALA', 'Y', 4),
(700, 65, '307271', 'PA.PAL', 'PENGADILAN AGAMA PALU', 'Jalan WR.Supratman No. 10 Palu', 'Y', 4),
(701, 65, '307300', 'PA.Lwk', 'PENGADILAN AGAMA LUWUK', 'Jl. Tanjung Tuwis Bukit Halimun', 'Y', 4),
(702, 65, '307292', 'PA.Pso', 'PENGADILAN AGAMA POSO', 'Jl. Pulau Kalimantan No.30, Kelurahan Gebangrejo, Kecamatan Poso Kota', 'Y', 4),
(703, 65, '307288', 'PA.Tli', 'PENGADILAN AGAMA TOLI-TOLI', 'Jl.Hi.Mallu. No.23, Kel. Tuweley, Kec. Baolan, Kab. Tolitoli, Provinsi Sulawesi Tengah', 'Y', 4),
(704, 65, '682192', 'PA.Prgi', 'PENGADILAN AGAMA PARIGI', 'Jl. Sungai Pakabata, Bambalemo, Parigi Moutong 94371 ', 'Y', 4),
(705, 66, '307729', 'PA.Bb', 'PENGADILAN AGAMA BAU-BAU', 'Jalan Raya Palagimata, Kota Baubau ', 'Y', 4),
(706, 66, '307712', 'PA.Kdi', 'PENGADILAN AGAMA KENDARI', 'Jl. Kapt. Pierre Tendean No. 45', 'Y', 4),
(707, 66, '307690', 'PA.Klk', 'PENGADILAN AGAMA KOLAKA', 'Jl. Pemuda KM. 5 Balandete', 'Y', 4),
(708, 66, '307708', 'PA.Rh', 'PENGADILAN AGAMA RAHA', 'Jl. Gatot Subroto No... Poros Raha-Tampo', 'Y', 4),
(709, 66, '604772', 'PA.Una', 'PENGADILAN AGAMA UNAAHA', 'Jl. Inolobunggadue II', 'Y', 4),
(710, 66, '682207', 'PA.Adl', 'PENGADILAN AGAMA ANDOOLO', 'Jalan Kompleks Perkantoran Pemda Konawe Selatan', 'Y', 4),
(711, 66, '682211', 'PA.Pw', 'PENGADILAN AGAMA PASARWAJO', 'Jl. Protokol No... Kel. Takimpo, Pasarwajo', 'Y', 4),
(712, 67, '604751', 'PA.Bitg', 'PENGADILAN AGAMA BITUNG', 'Jalan Stadion Dua Sudara Manembo-nembo Kecamatan Matuari Kota Bitung Propinsi Sulawesi Utara', 'Y', 4),
(713, 67, '307232', 'PA.Ktg', 'PENGADILAN AGAMA KOTAMOBAGU', 'Jln. Kinalang Kecamatan Kotobangon Kota Kotamobagu Propinsi Sulawesi Utara', 'Y', 4),
(714, 67, '307225', 'PA.Mdo', 'PENGADILAN AGAMA MANADO', 'Jln. Cendrawasih No. 2, Kel. Malendeng, Kec. Paal 2, Manado 95129', 'Y', 4),
(715, 67, '307246', 'PA.Thn', 'PENGADILAN AGAMA TAHUNA', 'Jalan Baru Tona No. 11 Kecamatan Tona I Kabupaten Kepulauan Sangihe Propinsi Sulawesi Utara', 'Y', 4),
(716, 67, '402701', 'PA.Tdo', 'PENGADILAN AGAMA TONDANO', 'Jln. Manguni Nomor 85, Kec. Tondano Utara, Kab. Minahasa, Provinsi Sulawesi Utara 95615', 'Y', 4),
(717, 67, '682171', 'PA.Amg.', 'PENGADILAN AGAMA AMURANG', 'Jalan Trans Sulawesi Kec. Amurang Timur, Kabupaten Minahasa Selatan, Sulawesi Utara ', 'Y', 4),
(718, 68, '401947', 'PA.Bsk', 'PENGADILAN AGAMA BATUSANGKAR', 'Jl. Sudirman No. 1 Lima Kaum Batusangkar', 'Y', 4),
(719, 68, '402010', 'PA.Bkt', 'PENGADILAN AGAMA BUKITTINGGI', 'Jl. Kusuma Bhakti, Kel. Gula Bancah, Kec. Mandiangin Koto Selayan, Kota Bukittinggi, Prov. Sumatera Barat', 'Y', 4),
(720, 68, '401984', 'PA.KBr', 'PENGADILAN AGAMA KOTO BARU', 'Jalan Lintas Solok-Padang, KM.18, Pasar Usang, Koto Gadang Guguak, Kecamatan Gunung Talang, Kabupaten Solok, 27365', 'Y', 4),
(721, 68, '402613', 'PA.LB', 'PENGADILAN AGAMA LUBUK BASUNG', 'Jl. Sutan Syahrir No. 2', 'Y', 4),
(722, 68, '402029', 'PA.Lbs', 'PENGADILAN AGAMA LUBUK SIKAPING', 'Jl. A. Yani No. 40 Lubuk Sikaping', 'Y', 4),
(723, 68, '402041', 'PA.Min', 'PENGADILAN AGAMA MANINJAU', 'Jln. Bukittinggi - Lubuk Basung km. 26, Padang Galanggang, Matur', 'Y', 4),
(724, 68, '401990', 'PA.ML', 'PENGADILAN AGAMA MUARA LABUH', 'Jln. Raya Muara Labuh-Padang Aro, Km.12 Ampalu', 'Y', 4),
(725, 68, '401953', 'PA.Pdg', 'PENGADILAN AGAMA PADANG', 'Jln. Durian Tarung No. 1 Kelurahan Pasar Ambacang Kecamatan Kuranji Kota Padang Propinsi Sumatera Barat', 'Y', 4),
(726, 68, '401962', 'PA.PP', 'PENGADILAN AGAMA PADANG PANJANG', 'Jl. H. Agus Salim No. 04 Kelurahan Guguk Malintang Kecamatan Padang Panjang Timur, Kota Padang Panjang Propinsi Sumatera Barat', 'Y', 4),
(727, 68, '402004', 'PA.Pn', 'PENGADILAN AGAMA PAINAN', 'Jl. Dr. Moh. Hatta Painan', 'Y', 4),
(728, 68, '401916', 'PA.Prm', 'PENGADILAN AGAMA PARIAMAN', 'Jl. Syekh Burhanuddin No. 106 Pariaman', 'Y', 4),
(729, 68, '402050', 'PA.Pyk', 'PENGADILAN AGAMA PAYAKUMBUH', 'Jln. Soekarno-Hatta No. 214 Payakumbuh', 'Y', 4),
(730, 68, '401931', 'PA.Swl', 'PENGADILAN AGAMA SAWAHLUNTO', 'Jl. Khatib Sulaiman KM 8 Kolok Mudik Kota Sawahlunto', 'Y', 4),
(731, 68, '401978', 'PA.Sjj', 'PENGADILAN AGAMA SIJUNJUNG', 'Jl. Prof. M.Yamin No. 65, Muaro Sijunjung', 'Y', 4),
(732, 68, '401922', 'PA.Slk', 'PENGADILAN AGAMA SOLOK', 'Jln. Kapten Bahar Hamid Laing Kota Solok', 'Y', 4),
(733, 68, '402035', 'PA TALU', 'PENGADILAN AGAMA TALU', 'Jl. Jati II Simpang Empat Pasaman Barat', 'Y', 4),
(734, 68, '402066', 'PA.LK', 'PENGADILAN AGAMA TANJUNG PATI', 'Jl. Negara Km. 11 Tanjung Pati, Kecamatan Harau Kabupaten Lima Puluh Kota', 'Y', 4),
(735, 69, '402267', 'PA.Bta', 'PENGADILAN AGAMA BATURAJA', 'Jl. Jend. A. Yani Km. 7 Kemelak Bindung Langit Baturaja', 'Y', 4),
(736, 69, '402273', 'PA.KAG', 'PENGADILAN AGAMA KAYUAGUNG', 'Jl. Letjend. M. Yusuf Singadekane No. 228 Kelurahan Jua - Jua Kecamatan Kota Kayuagung Kabupaten Ogan Komering Ilir - Sumatera Selatan', 'Y', 4),
(737, 69, '402251', 'PA.Lt', 'PENGADILAN AGAMA LAHAT', 'Jalan Kolonel Barlian Bandar Jaya Lahat 31414', 'Y', 4),
(738, 69, '402298', 'PA.LLG', 'PENGADILAN AGAMA LUBUK LINGGAU', 'Jl. Yos sudarso No. 34 Km.7 Taba Pingin Lubuklingau Sumatera Selatan Indonesia 31626', 'Y', 4),
(739, 69, '402282', 'PA.ME', 'PENGADILAN AGAMA MUARA ENIM', 'Jl. Mayor Tjik Agus Kiemas, S.H. Nomor 1 Muara Enim', 'Y', 4),
(740, 69, '402242', 'PA.PLG', 'PENGADILAN AGAMA PALEMBANG', 'Jln. Pangeran ratu rt 24 rw.09 kel. 15 ulu jakabaring', 'Y', 4),
(741, 69, '402638', 'PA.SKY', 'PENGADILAN AGAMA SEKAYU', 'Merdeka Lingkungan I No. 497', 'Y', 4),
(742, 70, '401865', 'PA.BLG', 'PENGADILAN AGAMA BALIGE', 'Jl. Balige-Laguboti Km. 5 Tambunan Lumban Pea Timur', 'Y', 4),
(743, 70, '401783', 'PA.Bji', 'PENGADILAN AGAMA BINJAI', 'Jl. Sultan Hasanuddin No. 24 Binjai', 'Y', 4),
(744, 70, '401896', 'PA.Gst', 'PENGADILAN AGAMA GUNUNG SITOLI', 'Jl. Pancasila No. 29 Gunungsitoli', 'Y', 4),
(745, 70, '401792', 'PA.Kbj', 'PENGADILAN AGAMA KABANJAHE', 'Jl. Jamin Ginting No. 73 Kabanjahe', 'Y', 4),
(746, 70, '403061', 'PA.Kis', 'PENGADILAN AGAMA KISARAN', 'Jl. Jend. Ahmad Yani No. 73 Kisaran', 'Y', 4),
(747, 70, '403077', 'PA.Lpk', 'PENGADILAN AGAMA LUBUK PAKAM', 'Jl. Mahoni No. 3 Komp. Perkantoran Pemkab. Deli Serdang', 'Y', 4),
(748, 70, '401803', 'PA.Mdn', 'PENGADILAN AGAMA MEDAN', 'Jl. SM. Raja Km. 8,8 No. 198 Medan', 'Y', 4),
(749, 70, '401880', 'PA.Psp', 'PENGADILAN AGAMA PADANG SIDEMPUAN', 'Jl. H.T. Rizal Nurdin km. 7 Padangsidempuan', 'Y', 4),
(750, 70, '604744', 'PA.Pdn', 'PENGADILAN AGAMA PANDAN', 'Jl. D.I. Panjaitan/Almuslimin No. 4 Pandan', 'Y', 4),
(751, 70, '631982', 'PA.Pyb', 'PENGADILAN AGAMA PANYABUNGAN', 'Jl. Willem Iskandar No. 5 Panyabungan', 'Y', 4),
(752, 70, '401859', 'PA.PST', 'PENGADILAN AGAMA PEMATANG SIANTAR', 'Jl. Sisingamangaraja No. 47 Kelurahan Naga Huta Kecamatan Siantar Marimbun Kota Pematangsiantar', 'Y', 4),
(753, 70, '401812', 'PA.RAP', 'PENGADILAN AGAMA RANTAU PRAPAT', 'Jl. Sisingamangaraja Komp. Asrama Haji No. 4 Rantauprapat', 'Y', 4),
(754, 70, '401871', 'PA.Sbga', 'PENGADILAN AGAMA SIBOLGA', 'Jl. Perintis Kemerdekaan No. 1 Sibolga', 'Y', 4),
(755, 70, '401840', 'PA.Sdk', 'PENGADILAN AGAMA SIDIKALANG', 'Rumah Sakit Umum No. 16', 'Y', 4),
(756, 70, '403083', 'PA.Sim', 'PENGADILAN AGAMA SIMALUNGUN', 'Jl. Asahan Km. 3 Siantar-Simalungun', 'Y', 4),
(757, 70, '547682', 'PA.Stb', 'PENGADILAN AGAMA STABAT', 'Jl. Proklamasi No. 46 Stabat', 'Y', 4),
(758, 70, '401828', 'PA.Tba', 'PENGADILAN AGAMA TANJUNG BALAI', 'Jl. Jend. Sudirman Km. 5,5 Sijambi Tanjungbalai', 'Y', 4),
(759, 70, '631978', 'PA.Trt', 'PENGADILAN AGAMA TARUTUNG', 'Jl. Raja Yohanes Hutabarat No. 51 Tarutung', 'Y', 4),
(760, 70, '401834', 'PA.Ttd', 'PENGADILAN AGAMA TEBING TINGGI', 'Jalan Tuanku Imam Bonjol No 7, Kota Tebing Tinggi 20631 ', 'Y', 4),
(761, 70, '682232', 'PA.Pspk', 'PENGADILAN AGAMA KOTA PADANG SIDEMPUAN', 'jl. williem iskandar iv, sadabuan', 'Y', 4),
(762, 60, '401582', 'MS.Bpd', 'MAHKAMAH SYAR''IYAH BLANGPIDIE', 'Jalan Bukit Hijau, Komplek Perkantoran Aceh Barat Daya', 'Y', 4);

-- --------------------------------------------------------

--
-- Table structure for table `pengadilan_tinggi`
--

CREATE TABLE IF NOT EXISTS `pengadilan_tinggi` (
  `id` int(11) unsigned NOT NULL,
  `kode` varchar(50) DEFAULT NULL,
  `nama` varchar(100) NOT NULL DEFAULT '',
  `alamat` varchar(500) DEFAULT NULL,
  `aktif` char(1) NOT NULL DEFAULT 'Y',
  `jenis_pengadilan` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pengadilan_tinggi`
--

INSERT INTO `pengadilan_tinggi` (`id`, `kode`, `nama`, `alamat`, `aktif`, `jenis_pengadilan`) VALUES
(1, NULL, 'PENGADILAN TINGGI BANDA ACEH', NULL, 'Y', 1),
(2, NULL, 'PENGADILAN TINGGI MEDAN', NULL, 'Y', 1),
(3, NULL, 'PENGADILAN TINGGI PADANG', NULL, 'Y', 1),
(4, NULL, 'PENGADILAN TINGGI PEKANBARU', NULL, 'Y', 1),
(5, NULL, 'PENGADILAN TINGGI JAMBI', NULL, 'Y', 1),
(6, NULL, 'PENGADILAN TINGGI PALEMBANG', 'Jl. Jenderal Sudirman Km. 3,5 Palembang (0711) 352900, 311666', 'Y', 1),
(7, NULL, 'PENGADILAN TINGGI BENGKULU', NULL, 'Y', 1),
(8, NULL, 'PENGADILAN TINGGI TANJUNG KARANG', NULL, 'Y', 1),
(9, NULL, 'PENGADILAN TINGGI BANGKA BELITUNG', NULL, 'Y', 1),
(11, NULL, 'PENGADILAN TINGGI JAKARTA', NULL, 'Y', 1),
(12, NULL, 'PENGADILAN TINGGI BANDUNG', NULL, 'Y', 1),
(13, NULL, 'PENGADILAN TINGGI SEMARANG', NULL, 'Y', 1),
(14, NULL, 'PENGADILAN TINGGI YOGYAKARTA', 'Jl. Prof.DR. Soepomo No.10 Yogyakarta Telp. (0274) 87324, 87227', 'Y', 1),
(15, NULL, 'PENGADILAN TINGGI SURABAYA', 'Jl. Sumatera No.42 Surabaya, Jawa Timur Telp. (031) 44409,44410, 5033042,5024408', 'Y', 1),
(16, NULL, 'PENGADILAN TINGGI BANTEN', NULL, 'Y', 1),
(17, NULL, 'PENGADILAN TINGGI DENPASAR', NULL, 'Y', 1),
(18, NULL, 'PENGADILAN TINGGI MATARAM', NULL, 'Y', 1),
(19, NULL, 'PENGADILAN TINGGI KUPANG', NULL, 'Y', 1),
(20, NULL, 'PENGADILAN TINGGI PONTIANAK', NULL, 'Y', 1),
(21, NULL, 'PENGADILAN TINGGI PALANGKARAYA', NULL, 'Y', 1),
(22, NULL, 'PENGADILAN TINGGI BANJARMASIN', NULL, 'Y', 1),
(23, NULL, 'PENGADILAN TINGGI SAMARINDA', NULL, 'Y', 1),
(24, NULL, 'PENGADILAN TINGGI MANADO', NULL, 'Y', 1),
(25, NULL, 'PENGADILAN TINGGI PALU', NULL, 'Y', 1),
(26, NULL, 'PENGADILAN TINGGI MAKASSAR', NULL, 'Y', 1),
(27, NULL, 'PENGADILAN TINGGI KENDARI', NULL, 'Y', 1),
(28, NULL, 'PENGADILAN TINGGI GORONTALO', NULL, 'Y', 1),
(30, NULL, 'PENGADILAN TINGGI AMBON', NULL, 'Y', 1),
(31, NULL, 'PENGADILAN TINGGI MALUKU UTARA', NULL, 'Y', 1),
(33, NULL, 'PENGADILAN TINGGI JAYAPURA', NULL, 'Y', 1),
(34, 'MDN', 'PENGADILAN TINGGI TATA USAHA NEGARA MEDAN', NULL, 'Y', 3),
(35, 'JKT', 'PENGADILAN TINGGI TATA USAHA NEGARA JAKARTA', NULL, 'Y', 3),
(36, 'SBY', 'PENGADILAN TINGGI TATA USAHA NEGARA SURABAYA', NULL, 'Y', 3),
(37, 'MKS', 'PENGADILAN TINGGI TATA USAHA NEGARA MAKASSAR', NULL, 'Y', 3),
(39, 'PMT.I', 'PENGADILAN MILITER TINGGI I MEDAN', NULL, 'Y', 2),
(40, 'PMT.II', 'PENGADILAN MILITER TINGGI II JAKARTA', NULL, 'Y', 2),
(41, 'PMT.III', 'PENGADILAN MILITER TINGGI III SURABAYA', NULL, 'Y', 2),
(42, 'PTA.JK', 'PENGADILAN TINGGI AGAMA JAKARTA', 'Jl. Raden Intan II No.3 Duren Sawit, Jakarta Timur', 'Y', 4),
(43, 'PTA.Btn', 'PENGADILAN TINGGI AGAMA BANTEN', 'Jl. Raya Pandeglang KM. 7 Serang, Banten, 42171 - Telp. 0254-251485, Fax.  0254-251484', 'Y', 4),
(44, 'PTA.Bn', 'PENGADILAN TINGGI AGAMA BENGKULU', 'JI. Sungai Rupat No. 60 A, Pagar Dewa, Telp. 52373 - 52374, Fax. 52373 Bengkulu 38225', 'Y', 4),
(45, 'PTA.Yk', 'PENGADILAN TINGGI AGAMA YOGYAKARTA', 'JI. Lingkaran Selatan No. 321, Telp. 380355, Yogyakarta 55188', 'Y', 4),
(46, 'PTA.Gtlo', 'PENGADILAN TINGGI AGAMA GORONTALO', 'Jl. Tina Loga, Kode Pos 96128 Telp (0435) 831591 Fax 831625', 'Y', 4),
(47, 'PTA.Jpr', 'PENGADILAN TINGGI AGAMA JAYAPURA', 'JI. Baru 103 Kotaraja', 'Y', 4),
(48, 'PTA.Jb', 'PENGADILAN TINGGI AGAMA JAMBI', 'Jl. H. Agus Salim Kec. Kota Baru Provinsi Jambi, Telp. 41092, Jambi 36128', 'Y', 4),
(49, 'PTA.Bdg', 'PENGADILAN TINGGI AGAMA BANDUNG', 'Jl. Soekarno Hatta No. 714 Gedebage - Bandung, Telp (022) 7810365 - Fax. (022) 7810349 Bandung', 'Y', 4),
(50, 'PTA.Smg', 'PENGADILAN TINGGI AGAMA SEMARANG', 'Jl. Hanoman No. 18, Telp. 7603866 - 7600803, Semarang 50146', 'Y', 4),
(51, 'PTA.Sby', 'PENGADILAN TINGGI AGAMA SURABAYA', 'Jl. Mayjen Sungkono No. 7 Po. Box. 3, Telp. 5681797, Surabaya 60225', 'Y', 4),
(52, 'PTA.Ptk', 'PENGADILAN TINGGI AGAMA PONTIANAK', 'Jalan Jenderal Ahmad Yani No. 252 Pontianak - 78062', 'Y', 4),
(53, 'PTA.Bjm', 'PENGADILAN TINGGI AGAMA BANJARMASIN', 'JI. Jend. Gatot Subroto No. 8, Telp. 252319 - Fax. 253742, Banjarmasin 70235', 'Y', 4),
(54, 'PTA.PIk', 'PENGADILAN TINGGI AGAMA PALANGKARAYA', 'JI. Cilik Riwut Km. 4,5, Palangkaraya 73112 Kalimantan Tengah', 'Y', 4),
(55, 'PTA.Smd', 'PENGADILAN TINGGI AGAMA SAMARINDA', 'Jl. Letjen MT. Haryono No. 24, Telp. 733337, Samarinda 75126', 'Y', 4),
(56, 'PTA.BB', 'PENGADILAN TINGGI AGAMA KEPULAUAN BANGKA BELITUNG', 'Jl. Pulau Bangka Komplek Perkantoran Pemerintah Provinsi Kepulauan Bangka Belitung, Kelurahan Air Itam', 'Y', 4),
(57, 'PTA.Bdl', 'PENGADILAN TINGGI AGAMA BANDAR LAMPUNG', 'Jl. Basuki Rahmat No. 24 - Teluk Betung Utara - Bandar Lampung - Lampung - 35215', 'Y', 4),
(58, 'PTA.AB', 'PENGADILAN TINGGI AGAMA AMBON', 'Jl.. Jend. Sudirman, Batu Merah Atas, Telp./Fax. 355296, 341171, Ambon 97128', 'Y', 4),
(59, 'PTA.MU', 'PENGADILAN TINGGI AGAMA MALUKU UTARA', 'Jalan Raya 40 Sofifi', 'Y', 4),
(60, 'MS.Aceh', 'MAHKAMAH SYARIYAH ACEH', 'Jln. T. Nyak Arief - Komplek Keistimewaan Aceh Banda Aceh 23242', 'Y', 4),
(61, 'PTA.Mtr', 'PENGADILAN TINGGI AGAMA MATARAM', 'JI. Majapahit - Mataram - 83126', 'Y', 4),
(62, 'PTA.Kp', 'PENGADILAN TINGGI AGAMA KUPANG', 'Jl. Perintis Kemerdekaan, Telp. 827611, Kupang, NTT 85225', 'Y', 4),
(63, 'PTA.Pbr', 'PENGADILAN TINGGI AGAMA PEKANBARU', 'Jl. Jend. Sudirman No. 198, Telp. 32548, Fax. 26624, Pekanbaru 28282', 'Y', 4),
(64, 'PTA.Mks', 'PENGADILAN TINGGI AGAMA MAKASSAR', 'Jl. A.P. Petta Rani No. 66, Telp. 452653, Fax. 449146 Makassar 90231', 'Y', 4),
(65, 'PTA.Pal', 'PENGADILAN TINGGI AGAMA PALU', 'Jl.. Prof. Moh. Yamin No. 36, Telp. 487285 -Fax. 487284, P a l u 94111', 'Y', 4),
(66, 'PTA.Kdi', 'PENGADILAN TINGGI AGAMA KENDARI', 'Jl. Wulele No. 8 Kendari Samping Asrama Haji Sulawesi Tenggara Telp (0401) 3194475 Fax (0401) 3196322 Kendari 93117', 'Y', 4),
(67, 'PTA.Mdo', 'PENGADILAN TINGGI AGAMA MANADO', 'Jl. 17 Agustus No.46 A, Po. Box. 1241,  Manado 95012', 'Y', 4),
(68, 'PTA.Pdg', 'PENGADILAN TINGGI AGAMA PADANG', 'Jl. Prof.Dr. Hamka Lanud Tabing Padang', 'Y', 4),
(69, 'PTA.Plg', 'PENGADILAN TINGGI AGAMA PALEMBANG', 'Jl. Jend. Sudirman 43 Km. 3.5,  Telp. 351170 - 367718, Palembang 30126', 'Y', 4),
(70, 'PTA.Mdn', 'PENGADILAN TINGGI AGAMA MEDAN', 'Jl. Kapt. Sumarsono No. 12, Telp. 8457461, Fax. 8457461, Medan 20124', 'Y', 4);

-- --------------------------------------------------------

--
-- Table structure for table `pihak`
--

CREATE TABLE IF NOT EXISTS `pihak` (
  `id` bigint(20) unsigned NOT NULL COMMENT 'Primary key (by system)',
  `jenis_pihak_id` tinyint(1) unsigned DEFAULT NULL COMMENT 'Jenis Pihak: merujuk ke tabel jenis_pihak kolom id',
  `jenis_indentitas` varchar(50) DEFAULT NULL COMMENT 'Jenis identitas: diisi dengan KTP/SIM/PASPOR',
  `nomor_indentitas` varchar(50) DEFAULT NULL COMMENT 'Nomor Identitas: isian bebas',
  `nama` varchar(1500) DEFAULT NULL COMMENT 'Nama: isian bebas',
  `tempat_lahir` varchar(50) DEFAULT NULL COMMENT 'Tempat Lahir: isian bebas',
  `tanggal_lahir` date DEFAULT NULL COMMENT 'Tanggal lahir: selisih tanggal lahir dengan tanggal hari ini tidak boleh kurang dari 5 tahun',
  `jenis_kelamin` varchar(1) DEFAULT NULL COMMENT 'Jenis Kelamin: L= Laki-laki, P=Perempuan',
  `golongan_darah` varchar(2) DEFAULT NULL COMMENT 'Golongan darah: A/B/AB/O',
  `alamat` varchar(500) DEFAULT NULL COMMENT 'Alamat: Isian bebas',
  `rtrw` varchar(20) DEFAULT NULL COMMENT 'RT/RW: isian bebas',
  `kelurahan` varchar(50) DEFAULT NULL COMMENT 'Kelurahan/Desa: isian bebas',
  `kecamatan` varchar(50) DEFAULT NULL COMMENT 'Kecamatan: Isian bebas',
  `kabupaten_id` int(11) unsigned DEFAULT NULL COMMENT 'Kabupaten/Kota: merujuk ke tabel kabupaten kolom id',
  `kabupaten` varchar(50) DEFAULT NULL COMMENT 'Kabupaten/Kota: merujuk ke tabel kabupaten kolom nama(by system)',
  `propinsi_id` int(11) unsigned DEFAULT NULL COMMENT 'Propinsi: merujuk ke tabel propinsi kolom id',
  `propinsi` varchar(50) DEFAULT NULL COMMENT 'Propinsi: merujuk ke tabel propinsi kolom nama(by system)',
  `telepon` varchar(50) DEFAULT NULL COMMENT 'Nomor telepon: isian bebas',
  `fax` varchar(50) DEFAULT NULL COMMENT 'Nomor Fax: isian bebas',
  `email` varchar(50) DEFAULT NULL COMMENT 'Alamat email: isan format email',
  `agama_id` int(11) unsigned DEFAULT NULL COMMENT 'Agama: merujuk ke tabel agama kolom id',
  `agama_nama` varchar(50) DEFAULT NULL COMMENT 'Nama Agama: merujuk ke tabel agama kolom nama(by system)',
  `status_kawin` varchar(20) DEFAULT NULL COMMENT 'Statu Kawin: diisi dengan Kawin/Belum Kawin',
  `pekerjaan` varchar(255) DEFAULT NULL COMMENT 'Pekerjaan: isian bebas',
  `pendidikan_id` int(11) unsigned DEFAULT NULL COMMENT 'Id Tingkat Pendidikan Terakhir: merujuk ke tabel tingkat_pendidikan kolom id',
  `pendidikan` varchar(50) DEFAULT NULL COMMENT 'Pendidikan terakhir: merujuk ke tabel pendidikan kolom kode',
  `warga_negara_id` int(11) unsigned DEFAULT NULL COMMENT 'Id Negara: merujuk ke tabel negara kolom id',
  `warga_negara` varchar(50) DEFAULT NULL COMMENT 'Warga Negara: merujuk ke tabel negara kolom nama (by system)',
  `nama_ayah` varchar(50) DEFAULT NULL COMMENT 'Nama Ayah: isian bebas',
  `nama_ibu` varchar(50) DEFAULT NULL COMMENT 'Nama ibu: isian bebas',
  `keterangan` varchar(255) DEFAULT NULL COMMENT 'Keterangan: isian bebas',
  `foto` blob,
  `diedit_oleh` varchar(30) DEFAULT NULL COMMENT 'Diedit Oleh: (by system)',
  `diedit_tanggal` datetime DEFAULT NULL COMMENT 'Diedit Tanggal: (by system)',
  `diinput_oleh` varchar(30) DEFAULT NULL COMMENT 'Diinput Oleh: (by system)',
  `diinput_tanggal` datetime DEFAULT NULL COMMENT 'Diinput Tanggal: (by system)',
  `diperbaharui_oleh` varchar(30) DEFAULT NULL COMMENT 'Diperbaharui Oleh: (by system)',
  `diperbaharui_tanggal` datetime DEFAULT NULL COMMENT 'Diperbaharui Tanggal: (by system)'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AVG_ROW_LENGTH=537 COMMENT='Data Para Pihak';

-- --------------------------------------------------------

--
-- Table structure for table `ref_instruksi`
--

CREATE TABLE IF NOT EXISTS `ref_instruksi` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `aktif` tinyint(1) DEFAULT NULL COMMENT '1:ya;2:tidak;'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ref_instruksi`
--

INSERT INTO `ref_instruksi` (`id`, `nama`, `aktif`) VALUES
(1, 'Pertimbangkan', 1),
(2, 'Tindak Lanjuti', 1),
(3, 'Proses Segera', 1),
(4, 'Teliti Laporkan', 1),
(5, 'Tanggapi / Surati', 1),
(6, 'Perhatikan', 1),
(7, 'Teruskan', 1),
(8, 'Disetujui', 1),
(9, 'Delegasi', 1),
(10, 'Arsip', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ref_jenis_surat`
--

CREATE TABLE IF NOT EXISTS `ref_jenis_surat` (
  `id` int(11) NOT NULL,
  `kode` varchar(20) DEFAULT NULL,
  `nama` varchar(100) NOT NULL,
  `keterangan` varchar(200) DEFAULT NULL,
  `diinput_oleh` varchar(30) DEFAULT NULL,
  `diinput_tanggal` datetime DEFAULT NULL,
  `diperbaharui_oleh` varchar(30) DEFAULT NULL,
  `diperbaharui_tanggal` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ref_jenis_surat`
--

INSERT INTO `ref_jenis_surat` (`id`, `kode`, `nama`, `keterangan`, `diinput_oleh`, `diinput_tanggal`, `diperbaharui_oleh`, `diperbaharui_tanggal`) VALUES
(1, 'R', 'Rahasia', NULL, NULL, NULL, NULL, NULL),
(2, 'P', 'Penting', NULL, NULL, NULL, NULL, NULL),
(3, 'B', 'Biasa', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ref_jenis_surat_keterangan`
--

CREATE TABLE IF NOT EXISTS `ref_jenis_surat_keterangan` (
  `id` int(11) NOT NULL,
  `kode` varchar(5) DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `aktif` tinyint(1) DEFAULT '1' COMMENT '1:aktif; 2:tidak;',
  `register_id` tinyint(1) DEFAULT NULL COMMENT '1:Perdata; 2:Pidana;',
  `dokumen` varchar(155) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ref_jenis_surat_keterangan`
--

INSERT INTO `ref_jenis_surat_keterangan` (`id`, `kode`, `nama`, `keterangan`, `aktif`, `register_id`, `dokumen`) VALUES
(1, 'SK_1', '[Kepala Daerah] Surat Keterangan Tidak Sedang Dinyatakan Pailit', NULL, 1, 2, '2b791fb4b33f5e6280b3dadb073ac9e7.rtf'),
(2, 'SK_2', '[Kepala Daerah] Surat Keterangan Tidak Pernah Sebagai Terpidana', NULL, 1, 1, 'd2a1decb00909a29c75653ce8708f61f.rtf'),
(3, 'SK_3', '[Kepala Daerah] Surat Keterangan Tidak Sedang Dicabut Hak Pilihnya', NULL, 1, 1, '84e15a5b188687bb15f4c4dfdd2cdf2b.rtf'),
(4, 'SK_4', '[Kepala Daerah] Surat Keterangan di Pidana Karena Kealpaan Ringan atau Alasan Politik', NULL, 1, 1, '1b65b4a11cf9ef3cec5aafb6c73e7d25.rtf'),
(5, 'SK_5', '[Kepala Daerah] Surat Keterangan Tidak memiliki Tanggungan Utang Secara Perorangan dan/atau Secara Badan Hukum yang Menjadi Tanggung Jawabnya yang Merugikan Keuangan Negara', NULL, 1, 2, '2784f76ad87687b71530e5bf363b39c3.rtf'),
(6, 'SK_6', '[Umum] Surat Keterangan Tidak Pernah Sebagai Terpidana', NULL, 1, 1, 'e7f9e9f83c460f3b4fd06a8bed394914.rtf');

-- --------------------------------------------------------

--
-- Table structure for table `ref_pangkat`
--

CREATE TABLE IF NOT EXISTS `ref_pangkat` (
  `id` int(11) NOT NULL,
  `golongan` varchar(20) NOT NULL,
  `pangkat` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ref_pangkat`
--

INSERT INTO `ref_pangkat` (`id`, `golongan`, `pangkat`) VALUES
(1, 'I/a', 'Juru Muda'),
(2, 'I/b', 'Juru Muda Tingkat I'),
(3, 'I/c', 'Juru'),
(4, 'I/d', 'Juru Tingkat I'),
(5, 'II/a', 'Pengatur Muda'),
(6, 'II/b', 'Pengatur Muda Tingkat I'),
(7, 'II/c', 'Pengatur'),
(8, 'II/d', 'Pengatur Tingkat I'),
(10, 'III/a', 'Penata Muda'),
(11, 'III/b', 'Penata Muda Tingkat I'),
(12, 'III/c', 'Penata'),
(13, 'III/d', 'Penata Tingkat I'),
(14, 'IV/a', 'Pembina'),
(15, 'IV/b', 'Pembina Tingkat I'),
(16, 'IV/c', 'Pembina Utama Muda'),
(17, 'IV/d', 'Pembina Utama Madya'),
(18, 'IV/e', 'Pembina Utama'),
(99, 'Pegawai Tidak Tetap', 'Pegawai Tidak Tetap (PTT)');

-- --------------------------------------------------------

--
-- Table structure for table `ref_pengiriman`
--

CREATE TABLE IF NOT EXISTS `ref_pengiriman` (
  `id` int(11) NOT NULL,
  `jenis_pengiriman` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ref_pengiriman`
--

INSERT INTO `ref_pengiriman` (`id`, `jenis_pengiriman`) VALUES
(1, 'PT POS Indonesia'),
(2, 'Ekspedisi (TIKI/JNE/dll)'),
(3, 'Kurir'),
(4, 'Lain-lain');

-- --------------------------------------------------------

--
-- Table structure for table `ref_penomoran`
--

CREATE TABLE IF NOT EXISTS `ref_penomoran` (
  `id` int(11) NOT NULL,
  `kode` varchar(100) DEFAULT NULL,
  `jenis` varchar(100) DEFAULT NULL,
  `keterangan` text,
  `aktif` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ref_penomoran`
--

INSERT INTO `ref_penomoran` (`id`, `kode`, `jenis`, `keterangan`, `aktif`) VALUES
(1, 'KD_SURAT/NMR/OT.0/BLN/THN', 'Organisasi', 'berhubungan dengan pembentukan, perubahan organisasi, uraian pekerjaan dan pembahasannya mulai dari awal sampai akhir dan jalur pertanggung jawabannya', 1),
(2, 'KD_SURAT/NMR/OT.1.1/BLN/THN', 'Perencanaan', 'berhubungan dengan penyusunan perencanaan/program kerja oleh unit kerja mahkamah agung secara keseluruhan, termasuk segala jenis pertemuan dalam rangka penentuan kebijaksanaan perencanaan', 1),
(3, 'KD_SURAT/NMR/OT.01.2/BLN/THN', 'Laporan', 'berhubungan dengan laporan umum, monitoring, evaluasi dan unit kerja baik laporan: bulanan, triwulan, semester dan tahunan', 1),
(4, 'KD_SURAT/NMR/OT.01.3/BLN/THN', 'Penyusunan Prosedur Kerja', 'berkenaan dengan penyusunan sistem, prosedur, pedoman, petunjuk pelaksanaan, tata kerja dan hubungan kerja', 1),
(5, 'KD_SURAT/NMR/OT.01.4/BLN/THN', 'Penyusunan Pembakuan Sarana Kerja', 'berhubungan dengan penyusunan pembakuan sarana kerja yakni penentuan kualitas dan kuantitas yang meliputi: ukuran, jenis, merek dan sebagainya', 1),
(6, 'KD_SURAT/NMR/HM.00/BLN/THN', 'Penerangan', 'berkenaan dengan segala kegiatan yang berkenaan dengan penerangan terhadap masyarakat tentang kegiatan Mahkamah Agung RI, termasuk di dalamnya: konperensi pers, pameran, wawancara', 1),
(7, 'KD_SURAT/NMR/HM.01.1/BLN/THN', 'Hubungan', 'berkenaan dengan segala intern Mahkamah Agung RI dan antara Mahkamah Agung RO dengan pihak lain, baik dalam maupun luar negeri dalam bidang kehumasan, koordinasi antara lain: bakohumas, hearing DPR, POKJA dan organisasi mass media', 1),
(8, 'KD_SURAT/NMR/HM.01.2/BLN/THN', 'Keprotokolan', 'berkenaan dengan masalah keprotokolan seperti tamu-tamu pimpinan Mahkamah Agung RI baik dalam maupun luar negeri, Kunjungan kerja pimpinan dan pejabat Mahkamah Agung RI, Upacara hari nasional dan HUT Mahkamah Agung RI', 1),
(9, 'KD_SURAT/NMR/HM.02.1/BLN/THN', 'Dokumentasi', 'Surat-surat yang berkenaan dengan kegiatan yang berhubungan dengan penyediaan/pengumpulan bahan/dokumentasi, termasuk penyebarannya', 1),
(10, 'KD_SURAT/NMR/HM.02.2/BLN/THN', 'Kepustakaan', 'berkenaan dengan  penyediaan, pengumpulan dan penataan bahan kepustakaan', 1),
(11, 'KD_SURAT/NMR/HM.02.3/BLN/THN', 'Teknologi Informasi', 'berkenaan dengan kegiatan yagn berhubungan dengan perencanaan, penyediaan, pemeliharaan, pengelolaan dan hal-hal lain yang berkaitan dengan teknologi informasi', 1),
(12, 'KD_SURAT/NMR/KP.00.1/BLN/THN', 'Pengadaan Formasi', 'berkenaan dengan perencanaan pengadaan pegawai, nota usul formasi, smpai dengan persetujuan termasuk di dalamnya besetting', 1),
(13, 'KD_SURAT/NMR/KP.00.2/BLN/THN', 'Pengadaan Penerimaan', 'berkenaan dengan penerimaan pegawai baru, mulai dan pengumuman penerimaan, panggilan testing/psikotes/clearance test, sampai dengan pengumuman yang diterima, termasuk di dalamnya pegawai honorer', 1),
(14, 'KD_SURAT/NMR/KP.00.3/BLN/THN', 'Pengadaan Pengangkatan', 'berkenaan dengan seluruh proses pengangkatan dan penmpatan calon pegawai sampai dengan menjadi pegawai mulai dari persyaratan, pemeriksaan kesehatan dan keterangan-keterangan lainnya yang berhubungan dengan pengangkatan', 1),
(15, 'KD_SURAT/NMR/KP.01.1/BLN/THN', 'Izin / Dispensasi', 'berkenaan dengan izin tidak masuk kerja atas permintaan yang diajukan oleh pegawai yang bersangkutan', 1),
(16, 'KD_SURAT/NMR/KP.01.2/BLN/THN', 'Keterangan', 'berkenaan dengan keterangan pegawai dan keluarganya, termasuk berkaitan dengan NIP, KARPEG, KARSU/KARSI dan data pegawai', 1),
(17, 'KD_SURAT/NMR/KP.02.1/BLN/THN', 'Penilaian', 'berkenaan dengan penilaian pelaksanaan pekerjaan, \ndisiplin pegawai, pemalsuan administrasi kepegawaian, rehabi litasi dan \npemulihan nama baik.', 1),
(18, 'KD_SURAT/NMR/KP.02.2/BLN/THN', 'Hukuman', 'berkenaan dengan hukuman pegawai', 1),
(19, 'KD_SURAT/NMR/KP.03/BLN/THN', 'Pembinaan Mental', 'berkenaan  dengan pembinaan mental pegawai, termasuk didalamnya pembinaan kerokhanian', 1),
(20, 'KD_SURAT/NMR/KP.04.1/BLN/THN', 'Kepangkatan', 'berkenaan dengan kenaikan pangkat/golongan, termasuk \ndidalamnya ujian dinas, ujian penyesuaian ijazah, dan daftar urut \nkepangkatan', 1),
(21, 'KD_SURAT/NMR/KP.04.2/BLN/THN', 'Kenaikan Gaji Berkala', 'berkaitan dengan kenaikan gaji berkala', 1),
(22, 'KD_SURAT/NMR/KP.04.3/BLN/THN', 'Penyesuaian Masa Kerja', 'berkenaan dengan penyesuaian masa kerja untuk perubahan ruang gaji dan impassing', 1),
(23, 'KD_SURAT/NMR/KP.04.4/BLN/THN', 'Penyesuaian Tunjangan Keluarga', 'berkenaan dengan penyesuaian tunjangan keluarga', 1),
(24, 'KD_SURAT/NMR/KP.04.5/BLN/THN', 'Alih Tugas', 'berkenaan dengan alih tugas bagi  para pelaksana/staf, perpindahan dalam rangka pemantapan tugas kerja termasuk mengenai fasilitasnya', 1),
(25, 'KD_SURAT/NMR/KP.04.6/BLN/THN', 'Jabatan Struktural/Fungsional', 'berkenaan dengan pengangkatan dan pemberhentian \ndalam jabatan  structural/  fungsional, termasuk tunjangan jabatan sewaktu \npenugasan atau pemberian kuasa untuk menjabat sementara', 1),
(26, 'KD_SURAT/NMR/KP.05.1/BLN/THN', 'Kesehatan', 'berkenaan  dengan penyelenggaraan kesehatan bagi : asuransi kesehatan, general checkup bagi pimpinan\npegawai', 1),
(27, 'KD_SURAT/NMR/KP.05.2/BLN/THN', 'Cuti', 'berkenaan dengan cuti pegawai: cuti sakit, cuti hamil/bersalin, cuti diluar tanggungan negara', 1),
(28, 'KD_SURAT/NMR/KP.05.3/BLN/THN', 'Rekreasi dan Olahraga', 'berkenaan dengan rekreasi dan olah raga', 1),
(29, 'KD_SURAT/NMR/KP.05.4/BLN/THN', 'Bantuan Sosial', 'berkenaan dengan pemberian bantuan/tunjangan sosial kepada pegawai dan keluarga yang mengalami musibah, termasuk ucapan bela sungkawa', 1),
(30, 'KD_SURAT/NMR/KP.05.5/BLN/THN', 'Koperasi', 'berkenaan dengan organisasi koperasi termasuk didalamnya masalah pengurusan kebutuhan bahan pokok', 1),
(31, 'KD_SURAT/NMR/KP.05.6/BLN/THN', 'Perumahan', 'berkenaan dengan perumahan pegawai, pejabat struktural/fungsional, pimpinan dan hakim agung', 1),
(32, 'KD_SURAT/NMR/KP.05.7/BLN/THN', 'Antar Jemput', 'berkenaan dengan transportasi pegawai', 1),
(33, 'KD_SURAT/NMR/KP.05.8/BLN/THN', 'Penghargaan', 'berkenaan dengan penghargaan, tanda jasa, piagam, \nsatya lencana, dan sejenisnya', 1),
(34, 'KD_SURAT/NMR/KP.06/BLN/THN', 'Pemutusan Hubungan Kerja', 'berkenaan dengan pensiun pegawai, termasuk jaminan asuransi karena berhenti atas permintaan sendiri, berhenti dengan hormat bukan karena hukuman, pindah/keluar dari MARI dan meninggal dunia', 1),
(35, 'KD_SURAT/NMR/KU.00/BLN/THN', 'Akuntansi', 'berkenaan dengan, penyiapan bahan pelaksanaan dan \npembinaan pembukuan keuangan, serta penyusunan perhitungan anggaran', 1),
(36, 'KD_SURAT/NMR/KU.01/BLN/THN', 'Pelaksanaan Anggaran', 'berkenaan dengan penyiapan bahan bimbingan dalam pelaksanaan penggunaan anggaran dan pertanggung jawaban keuangan', 1),
(37, 'KD_SURAT/NMR/KU.02/BLN/THN', 'Verifikasi dan Tuntutan Ganti Rugi', 'berkenaan dengan penyiapan bahan pencatatan, penelitian, \npembinaan, dan penyusunan laporan tentang verifikasi dan tuntutan ganti \nrugi.', 1),
(38, 'KD_SURAT/NMR/KU.03/BLN/THN', 'Perbendaharaan', 'berkenaan dengan penyiapan bahan bimbingan dalam \nketatausahaan perbendaharaan, penyelesaiaan masalah perbendaharaan, \ndan pelaksanaan pembinaan bendaharawan', 1),
(39, 'KD_SURAT/NMR/KU.04.1/BLN/THN', 'Pajak', 'berkenaan dengan pendapatan negara dan hasil pajak yang meliputi :   MPO, PPN,  Pajak Jasa,  PPH,  PPN,  dan pajak lainnya', 1),
(40, 'KD_SURAT/NMR/KU.04.2/BLN/THN', 'Bukan Pajak', 'berkenaan dengan pendapatan negara dan hasil bukan pajak yang meliputi penerimaan dan:   biaya perkara,  biaya salinan putusan,  biaya sewa dari inventaris Negara,   hasil penjualan barang-barang inventaris yang dihapus,  dan penerimaan Negara bukan pajak lainnya', 1),
(41, 'KD_SURAT/NMR/KU.05/BLN/THN', 'Perbankan', 'berkenaan dengan perbankan antara lain : pembukaan rekening, spesement tandatangan, valuta asing,  rekening koran dan prodak perbankan lainnya', 1),
(42, 'KD_SURAT/NMR/KU.06/BLN/THN', 'Sumbangan/Bantuan', 'berkenaan dengan permintaan, pemberian sumbangan/bantuan khusus diluar tugas pokok Mahkamah Agung', 1),
(43, 'KD_SURAT/NMR/KS.00/BLN/THN', 'Kerumahtanggaan', 'berkenaan dengan : penggunaan fasilitas, ketertiban dan keamanan, konsumsi, pakaian dinas, papan nama, stempel, lambang, alamat kantor dan pejabat, telekomunikasi, listrik, air dan lain sebagainya', 1),
(44, 'KD_SURAT/NMR/PL.01/BLN/THN', 'Gedung dan Rumah Dinas', 'berkenaan dengan perencanaa, pengadaan, pelelangan, pendistribusian, pemeliharaan dan penghapusan : bangunan kantor, rumah dinas, persetujuan gambar gedung dan lain sebagainya', 1),
(45, 'KD_SURAT/NMR/PL.02/BLN/THN', 'Tanah', 'berkenaan dengan perencanaa, pengadaan/ pelelangan, pemeliharaan, penghapusan dan tukar guling tanah', 1),
(46, 'KD_SURAT/NMR/PL.03/BLN/THN', 'Alat Kantor', 'berkenaan dengan perencanaan, pengadaan, pelelangan, pendistribusian, pemeliharaan dan penghapusan: ATK (Alat Tulis Kantor), formulir-formulir, dan lain-lain', 1),
(47, 'KD_SURAT/NMR/PL.04/BLN/THN', 'Mesin Kantor/Alat Elektronik', 'berkenaan dengan perencanaan, pengadaan, pelelangan, pendistribusian, pemeliharaan dan penghapusan antara lain:\r\nAC, Aplifier, Foto Copy, Mesin Ketik, Infocus dan sebagainya', 1),
(48, 'KD_SURAT/NMR/PL.05/BLN/THN', 'Perabot Kantor', 'berkenaan dengan perencanaan, pengadaan, pelelangan, pendistribusian, pemeliharaan dan penghapusan antara lain:\r\nKursi, Meja, Lemari, Filing cabinet rak, dan lain-lain yang sejenis', 1),
(49, 'KD_SURAT/NMR/PL.06/BLN/THN', 'Kendaraan', 'berkenaan dengan masalah kendaraan dari perencanaan, pengadaan, pelelangan, pendistribusian, pemeliharaan dan penghapusan', 1),
(50, 'KD_SURAT/NMR/PL.07/BLN/THN', 'Inventaris Perlengkapan', 'berkenaan dengan inventaris  perlengkapan, laporan inventaris perlengkapan baik pusat maupun daerah', 1),
(51, 'KD_SURAT/NMR/PL.08/BLN/THN', 'Penawaran Umum', 'berkenaan dengan pelelangan dari mulai persiapan \npelelangan, penyusunan RKS, pelaksanaan pelelangan dan pengumuman \npemenang, serta hal-hal lain yang berkaitan dengan pelaksanaan pelelangan', 1),
(52, 'KD_SURAT/NMR/PL.09/BLN/THN', 'Ketatausahaan', 'berkenaan dengan korespondensi, kearsipan, penandatangan \nsurat dan wewenangnya, cap dinas, dan lain sebagainya', 1),
(53, 'KD_SURAT/NMR/HK.00/BLN/THN', 'Peraturan Perundang-undangan', 'berkenaan dengan  proses penyusunan peraturan perundangundangan produk Mahkamah Agung, dari konsep/draf sampai selesai, maupun \nproduk peraturan perundang-undangan yang diterima baik intern Mahkamah \nAgung maupun dari instansi lainnya', 1),
(54, 'KD_SURAT/NMR/HK.00.1/BLN/THN', 'Undang-undang, termasuk PERPU', 'berkenaan dengan  proses penyusunan peraturan perundangundangan produk Mahkamah Agung, dari konsep/draf sampai selesai, maupun \nproduk peraturan perundang-undangan yang diterima baik intern Mahkamah \nAgung maupun dari instansi lainnya', 1),
(55, 'KD_SURAT/NMR/HK.00.2/BLN/THN', 'Peraturan Pemerintah', 'berkenaan dengan  proses penyusunan peraturan perundangundangan produk Mahkamah Agung, dari konsep/draf sampai selesai, maupun \nproduk peraturan perundang-undangan yang diterima baik intern Mahkamah \nAgung maupun dari instansi lainnya', 1),
(56, 'KD_SURAT/NMR/HK.00.3/BLN/THN', 'Keputusan Presiden, Instruksi Presiden, Penetapan Presiden', 'berkenaan dengan  proses penyusunan peraturan perundangundangan produk Mahkamah Agung, dari konsep/draf sampai selesai, maupun \r\nproduk peraturan perundang-undangan yang diterima baik intern Mahkamah \r\nAgung maupun dari instansi lainnya', 1),
(57, 'KD_SURAT/NMR/HK.00.4/BLN/THN', 'Peraturan Ketua Mahkamah Agung', 'berkenaan dengan  proses penyusunan peraturan perundangundangan produk Mahkamah Agung, dari konsep/draf sampai selesai, maupun \nproduk peraturan perundang-undangan yang diterima baik intern Mahkamah \nAgung maupun dari instansi lainnya', 1),
(58, 'KD_SURAT/NMR/HK.00.5/BLN/THN', 'Keputusan Mahkamah Agung, Intruksi Mahkamah Agung', 'berkenaan dengan  proses penyusunan peraturan perundangundangan produk Mahkamah Agung, dari konsep/draf sampai selesai, maupun \nproduk peraturan perundang-undangan yang diterima baik intern Mahkamah \nAgung maupun dari instansi lainnya', 1),
(59, 'KD_SURAT/NMR/HK.00.6/BLN/THN', 'Keputusan Pejabat Eselon I', 'berkenaan dengan  proses penyusunan peraturan perundangundangan produk Mahkamah Agung, dari konsep/draf sampai selesai, maupun \nproduk peraturan perundang-undangan yang diterima baik intern Mahkamah \nAgung maupun dari instansi lainnya', 1),
(60, 'KD_SURAT/NMR/HK.00.7/BLN/THN', 'Surat Edaran Pejabat Eselon I', 'berkenaan dengan  proses penyusunan peraturan perundangundangan produk Mahkamah Agung, dari konsep/draf sampai selesai, maupun \nproduk peraturan perundang-undangan yang diterima baik intern Mahkamah \nAgung maupun dari instansi lainnya', 1),
(61, 'KD_SURAT/NMR/HK.00.8/BLN/THN', 'Peraturan Pengadilan Tingkat Banding dan Tingkat Pertama', 'berkenaan dengan  proses penyusunan peraturan perundangundangan produk Mahkamah Agung, dari konsep/draf sampai selesai, maupun \nproduk peraturan perundang-undangan yang diterima baik intern Mahkamah \nAgung maupun dari instansi lainnya', 1),
(62, 'KD_SURAT/NMR/HK.00.9/BLN/THN', 'Peraturan PEMDA Tk I dan PEMDA Tk II', 'berkenaan dengan  proses penyusunan peraturan perundangundangan produk Mahkamah Agung, dari konsep/draf sampai selesai, maupun \nproduk peraturan perundang-undangan yang diterima baik intern Mahkamah \nAgung maupun dari instansi lainnya', 1),
(63, 'KD_SURAT/NMR/HK.01/BLN/THN', 'Pidana', 'berkenaan dengan penyelesaiaan perkara pidana, baik pidana \nkejahatan maupun pidana pelanggaran', 1),
(64, 'KD_SURAT/NMR/HK.02/BLN/THN', 'Perdata', 'berkenaan dengan penyelesaian  perkara perdata, baik \ngugatan maupun permohonan', 1),
(65, 'KD_SURAT/NMR/HK.03/BLN/THN', 'Perdata Niaga', 'berkenaan dengan penyelesaian perkara perdata niaga', 1),
(66, 'KD_SURAT/NMR/HK.04/BLN/THN', 'Pidana Militer', 'Surat  yang  berkenaan  dengan  penyelesaian\nperkara pidana militer', 1),
(67, 'KD_SURAT/NMR/HK.05/BLN/THN', 'Perdata Agama', 'Surat  yang  berkenaan  dengan  penyelesaian\nperkara perdata agama', 1),
(68, 'KD_SURAT/NMR/HK.06/BLN/THN', 'Tata Usaha Negara', 'Surat  yang  berkenaan  dengan  penyelesaian\nperkara tata usaha Negara', 1),
(69, 'KD_SURAT/NMR/HK.07/BLN/THN', 'Pidana Khusus', 'berkenaan dengan penyelesaian perkara pidana khusus', 1),
(70, 'KD_SURAT/NMR/PP.00.1/BLN/THN', 'Pendidikan dan Pelatihan Teknis Hakim', 'berkenaan dengan perencanaan, pelaksanaan, dan \nevaluasi penyelenggaraan pendidikan dan pelatihan hakim', 1),
(71, 'KD_SURAT/NMR/PP.00.2/BLN/THN', 'Pendidikan dan Pelatihan Teknis Panitera', 'berkenaan dengan perencanaan, pelaksanaan, dan \nevaluasi penyelenggaraan pendidikan dan pelatihan panitera', 1),
(72, 'KD_SURAT/NMR/PP.00.3/BLN/THN', 'Pendidikan dan Pelatihan Teknis Jurusita', 'berkenaan dengan perencanaan, pelaksanaan, dan \nevaluasi penyelenggaraan pendidikan dan pelatihanjurusita', 1),
(73, 'KD_SURAT/NMR/PP.00.4/BLN/THN', 'Pendidikan dan Pelatihan Teknis Teknis Lainya', 'berkenaan dengan  perencanaan, pelaksanaan, dan \nevaluasi penyelenggaraan pendidikan dan pelatihan teknis lainnya', 1),
(74, 'KD_SURAT/NMR/PP.01.1/BLN/THN', 'Pendidikan dan Latihan Perjenjangan', 'berkenaan dengan pendidikan perjenjangan, antara lain:\r\nDiklatpim Tingkat IV, III, II, I, LEMHANAS\r\nmulai dari perencanaan, pelaksanaan dan evaluasi', 1),
(75, 'KD_SURAT/NMR/PP.01.2/BLN/THN', 'Pendidikan dan Latihan Kepangkatan', 'berkenaan dengan pendidikan kepangkatan: Pra Jabatan, SISCATUR, SUSCATA, SUSCABIN mulai dari perencanaan, pelaksanaan, dan evaluasi', 1),
(76, 'KD_SURAT/NMR/PP.01.3/BLN/THN', 'Pendidikan dan Latihan/Kursus/Penataran Manajemen', 'berkenaan dengan latihan tenaga administrasi, kursus, \ndan penataran, di bidang  manajemen atau lainnya, baik dalam maupun \nluar negeri, mulai dari perencanaan, pelaksanaan, dan evaluasi', 1),
(77, 'KD_SURAT/NMR/PB.00/BLN/THN', 'Penelitian Hukum', 'berkenaan dengan penelitian dan pengembangan hukum, \nsejak dari perencanaan,  perizinan, pelaksanaan, sampai dengan pelaporan \nhasil penelitian', 1),
(78, 'KD_SURAT/NMR/PB.01/BLN/THN', 'Penelitian Peradilan', 'berkenaan dengan penelitian dan pengembangan \nperadilan, sejak dari perencanaan, perizinan, pelaksanaan, sampai \ndengan pelaporan hasil penelitian', 1),
(79, 'KD_SURAT/NMR/PB.02/BLN/THN', 'Pengembangan Peradilan', 'berkenaan dengan masalah-masalah pengembangan penelitian \ndan perencanaan, pelaksanaan sampai dengan pelaporan', 1),
(80, 'KD_SURAT/NMR/PS.03/BLN/THN', 'Penyelenggaraan Peradilan', 'berkenaan dengan pengawasan atas penyelenggaraan pelaksaanaan peradilan', 1),
(81, 'KD_SURAT/NMR/PS.04/BLN/THN', 'Pengawasan Administrasi Peradilan', 'berkenaan dengan pengawasan atas pengelolaan administrasi \nperadilan, baik administrasi perkara dan administrasi umum', 1),
(82, 'KD_SURAT/NMR/PS.05/BLN/THN', 'Penanganan Pengaduan Masyarakat', 'berkenaan dengan pengawasan atas pengaduan masyarakat terhadap perilaku aparat peradilan dan pelayanan publik oleh lembaga peradilan', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ref_tujuan_surat`
--

CREATE TABLE IF NOT EXISTS `ref_tujuan_surat` (
  `groupid` int(11) NOT NULL COMMENT 'Primary Key: (by system)',
  `parent_id` int(11) DEFAULT NULL COMMENT 'Grup induk: merujuk ke tabel sys_groups kolom groupid',
  `level` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Level tree (by system)',
  `lft` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set left:(by system)',
  `rgt` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set right:(by system)',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT 'Nama Grup: isian bebas',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT 'Keterangan: isian bebas',
  `enable` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Aktif: pilihan 1=Ya; 0=Tidak',
  `ordering` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Urutan Grup Per Induknya',
  `lock_by` varchar(30) NOT NULL DEFAULT '' COMMENT 'Diedit Oleh: (by system)',
  `lock_on` datetime DEFAULT NULL COMMENT 'Diedit Tanggal: (by system)',
  `created_by` varchar(30) DEFAULT NULL COMMENT 'Diinput Oleh: (by system)',
  `created_on` datetime DEFAULT NULL COMMENT 'Diinput Tanggal: (by system)',
  `modified_by` varchar(30) DEFAULT NULL COMMENT 'Diperbaharui Oleh: (by system)',
  `modified_on` datetime DEFAULT NULL COMMENT 'Diperbaharui Tanggal: (by system)'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Data Grup User aplikasi';

--
-- Dumping data for table `ref_tujuan_surat`
--

INSERT INTO `ref_tujuan_surat` (`groupid`, `parent_id`, `level`, `lft`, `rgt`, `name`, `description`, `enable`, `ordering`, `lock_by`, `lock_on`, `created_by`, `created_on`, `modified_by`, `modified_on`) VALUES
(1, 0, 1, 2, 59, 'Mahkamah Agung RI', '', 1, 1, 'system', '2013-02-08 11:02:03', '', NULL, 'admin', '2012-11-13 12:44:56'),
(2, 1, 2, 3, 58, 'Ketua Mahkamah Agung RI', '', 1, 1, '', NULL, 'admin', '2017-09-30 21:31:00', '', '2017-09-30 22:41:30'),
(3, 2, 3, 4, 9, 'Wakil Ketua Mahkamah Agung RI Bidang Non Yudisial', '', 1, 1, '', NULL, 'admin', '2017-09-30 21:34:16', '', '2017-09-30 21:36:16'),
(4, 2, 3, 10, 19, 'Wakil Ketua Mahkamah Agung RI Bidang Yudisial', '', 1, 2, '', NULL, 'admin', '2017-09-30 21:36:37', '', NULL),
(5, 3, 4, 5, 6, 'Ketua Kamar  Pembinaan', '', 1, 1, '', NULL, 'admin', '2017-09-30 21:39:19', '', NULL),
(6, 3, 4, 7, 8, 'ketua Kamar Pengawasan', '', 1, 2, '', NULL, 'admin', '2017-09-30 21:39:42', '', NULL),
(7, 4, 4, 11, 12, 'Ketua Kamar Perdata', '', 1, 1, '', NULL, 'admin', '2017-09-30 21:41:37', '', NULL),
(8, 4, 4, 13, 14, 'Ketua Kamar Pidana', '', 1, 2, '', NULL, 'admin', '2017-09-30 21:41:54', '', NULL),
(9, 4, 4, 15, 16, 'Ketua Kamar Agama', '', 1, 3, '', NULL, 'admin', '2017-09-30 21:42:13', '', NULL),
(10, 4, 4, 17, 18, 'Ketua Kamar Tata Usaha Negara', '', 1, 4, '', NULL, 'admin', '2017-09-30 21:42:47', '', NULL),
(11, 2, 3, 20, 33, 'Sekretaris Mahkamah Agung RI', '', 1, 3, '', NULL, 'admin', '2017-09-30 21:48:01', '', NULL),
(12, 2, 3, 34, 35, 'Panitera Mahkamah Agung RI', '', 1, 4, '', NULL, 'admin', '2017-09-30 21:48:19', '', NULL),
(13, 11, 4, 21, 22, 'Badan Urusan Administrasi', '', 1, 1, '', NULL, 'admin', '2017-09-30 21:48:48', '', NULL),
(14, 11, 4, 23, 24, 'Direktorat Jenderal Badan Peradilan Umum', '', 1, 2, '', NULL, 'admin', '2017-09-30 21:49:15', '', NULL),
(15, 11, 4, 25, 26, 'Direktorat Jenderal Badan Peradilan Agama', '', 1, 3, '', NULL, 'admin', '2017-09-30 21:49:41', '', '2017-09-30 21:49:59'),
(16, 11, 4, 27, 28, 'Direktorat Jenderal Badan Peradilan Militer dan Tata Usaha Negara', '', 1, 4, '', NULL, 'admin', '2017-09-30 21:50:26', '', NULL),
(17, 11, 4, 29, 30, 'Badan Pengawasan Mahkamah Agung RI', '', 1, 5, '', NULL, 'admin', '2017-09-30 21:50:43', '', '2017-09-30 21:52:00'),
(18, 11, 4, 31, 32, 'Badan Penelitian Pengembangan Pendidikan dan Pelatihan Hukum dan Peradilan', '', 1, 6, '', NULL, 'admin', '2017-09-30 21:51:41', '', NULL),
(19, 2, 3, 36, 37, '/-------------------------------------------------------------------/', '', 1, 5, '', NULL, 'admin', '2017-09-30 22:34:42', '', '2017-09-30 22:35:27'),
(20, 2, 3, 38, 41, 'Pengadilan Tinggi', '', 1, 6, '', NULL, 'admin', '2017-09-30 22:36:21', '', NULL),
(21, 2, 3, 42, 45, 'Pengadilan Tinggi Agama', '', 1, 7, '', NULL, 'admin', '2017-09-30 22:37:07', '', NULL),
(22, 2, 3, 46, 49, 'Pengadilan Tinggi Tata Usaha Negara', '', 1, 8, '', NULL, 'admin', '2017-09-30 22:37:32', '', NULL),
(23, 2, 3, 50, 55, 'Pengadilan Militer Utama', '', 1, 9, '', NULL, 'admin', '2017-09-30 22:38:06', '', NULL),
(24, 20, 4, 39, 40, 'Pengadilan Negeri', '', 1, 1, '', NULL, 'admin', '2017-09-30 22:39:00', '', NULL),
(25, 21, 4, 43, 44, 'Pengadilan Agama', '', 1, 1, '', NULL, 'admin', '2017-09-30 22:39:16', '', NULL),
(26, 22, 4, 47, 48, 'Pengadilan Tata Usaha Negara', '', 1, 1, '', NULL, 'admin', '2017-09-30 22:39:38', '', NULL),
(27, 23, 4, 51, 54, 'Pengadilan Militer Tinggi', '', 1, 1, '', NULL, 'admin', '2017-09-30 22:40:02', '', NULL),
(28, 27, 5, 52, 53, 'Pengadilan Militer', '', 1, 1, '', NULL, 'admin', '2017-09-30 22:40:24', '', NULL),
(29, 2, 3, 56, 57, 'Lain-Lain', '', 1, 10, '', NULL, 'admin', '2017-09-30 22:42:33', '', NULL),
(30, 0, 1, 59, 60, ' /-------------------------------------------------------------------/', '', 1, 0, '', NULL, NULL, NULL, NULL, NULL),
(31, 0, 1, 61, 62, 'Instansi Pemerintah', '', 1, 0, '', NULL, NULL, NULL, NULL, NULL),
(32, 0, 1, 63, 64, 'Badan Hukum', '', 1, 0, '', NULL, NULL, NULL, NULL, NULL),
(33, 0, 1, 65, 66, 'Perseorangan', '', 1, 0, '', NULL, NULL, NULL, NULL, NULL),
(34, 0, 1, 67, 68, 'Lain-Lain', '', 1, 0, '', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `register_pelaksanaan`
--

CREATE TABLE IF NOT EXISTS `register_pelaksanaan` (
  `pelaksanaan_id` bigint(20) NOT NULL,
  `register_id` bigint(20) NOT NULL,
  `jenis_pelaksanaan_id` int(11) DEFAULT NULL COMMENT '10:Disposisi; 20:Dilaksanakan; 30:Dikembalikan;',
  `jenis_pelaksanaan` varchar(100) DEFAULT NULL,
  `sifat_pelaksanaan_id` int(11) DEFAULT NULL COMMENT '1:Penting; 2:Biasa;',
  `sifat_pelaksanaan` varchar(100) DEFAULT NULL,
  `tanggal_pelaksanaan` date DEFAULT NULL,
  `dari_userid` int(11) DEFAULT NULL COMMENT 'pegawai_id, tabel pegawai',
  `dari_fullname` varchar(255) DEFAULT NULL,
  `dari_jabatan_id` int(11) DEFAULT NULL,
  `dari_jabatan` varchar(255) DEFAULT NULL,
  `kepada_userid` int(11) DEFAULT NULL COMMENT 'pegawai_id, tabel pegawai',
  `kepada_fullname` varchar(255) DEFAULT NULL,
  `kepada_jabatan_id` int(11) DEFAULT NULL,
  `kepada_jabatan` varchar(255) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `diinput_oleh` varchar(30) DEFAULT NULL,
  `diinput_tanggal` datetime DEFAULT NULL,
  `diperbaharui_oleh` varchar(30) DEFAULT NULL,
  `diperbaharui_tanggal` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `register_pelaksanaan`
--

INSERT INTO `register_pelaksanaan` (`pelaksanaan_id`, `register_id`, `jenis_pelaksanaan_id`, `jenis_pelaksanaan`, `sifat_pelaksanaan_id`, `sifat_pelaksanaan`, `tanggal_pelaksanaan`, `dari_userid`, `dari_fullname`, `dari_jabatan_id`, `dari_jabatan`, `kepada_userid`, `kepada_fullname`, `kepada_jabatan_id`, `kepada_jabatan`, `keterangan`, `diinput_oleh`, `diinput_tanggal`, `diperbaharui_oleh`, `diperbaharui_tanggal`) VALUES
(4, 3, 10, 'Disposisi', NULL, NULL, '2022-04-02', 2, 'Drs. Syafruddin', 4, 'Panitera', 5, 'bahrun', 19, 'Kasubbag PTIP', 'laksanakan bos', 'syaf', '2022-04-02 09:38:32', NULL, NULL),
(5, 3, 20, 'Dilaksanakan', NULL, NULL, '2022-04-02', 5, 'bahrun', 19, 'Kasubbag PTIP', 0, '', 0, '', 'oke siap', 'bahrun', '2022-04-02 09:39:04', NULL, NULL),
(11, 7, 20, 'Dilaksanakan', NULL, NULL, '2022-04-03', 6, 'khair', 16, 'Sekretaris', 0, '', 0, '', '', 'khair', '2022-04-03 11:08:51', NULL, NULL),
(19, 12, 10, 'Disposisi', NULL, NULL, '2022-04-03', 1, 'Dra. Hj. Rosmawardani, S.H., M.H', 2, 'Ketua Mahkamah Syar''iyah', 6, 'Khairuddin, S.H., M.H.', 16, 'Sekretaris', 'Tindak Lanjuti', 'ros', '2022-04-03 12:40:19', NULL, NULL),
(20, 12, 10, 'Disposisi', NULL, NULL, '2022-04-11', 6, 'Khairuddin, S.H., M.H.', 16, 'Sekretaris', 4, 'latif', 6, 'Panitera Muda Permohonan', '', 'khair', '2022-04-11 04:07:56', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `register_penggeledahan`
--

CREATE TABLE IF NOT EXISTS `register_penggeledahan` (
  `register_id` bigint(20) NOT NULL,
  `kepolisian` varchar(100) DEFAULT NULL,
  `tanggal_register` date DEFAULT NULL,
  `tanggal_register_umum` date DEFAULT NULL,
  `jenis_penggeledahan_id` int(1) DEFAULT NULL COMMENT '1:ijin_penyitaan; 2:persetujuan_penyitaan',
  `jenis_penggeledahan` varchar(100) DEFAULT NULL,
  `generate_nomor` int(1) DEFAULT NULL,
  `nomor_index` int(11) DEFAULT NULL,
  `nomor_register` varchar(100) DEFAULT NULL,
  `nomor_register_umum` varchar(100) DEFAULT NULL,
  `nomor_suratpermohonan_penyidik` varchar(100) DEFAULT NULL,
  `tanggal_suratpermohonan_penyidik` date DEFAULT NULL,
  `nomor_suratperintahpenggeledahan_penyidik` varchar(100) DEFAULT NULL,
  `tanggal_suratperintahpenggeledahan_penyidik` date DEFAULT NULL,
  `tanggal_laporan_penyidik` date DEFAULT NULL,
  `penyidik` varchar(100) DEFAULT NULL,
  `nomor_laporan_penyidik` varchar(100) DEFAULT NULL,
  `tanggal_ba_penggeledahan` date DEFAULT NULL,
  `nomor_ba_penggeledahan` varchar(100) DEFAULT NULL,
  `nama` varchar(150) DEFAULT NULL,
  `tempat_lahir` varchar(100) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `jenis_kelamin` int(1) DEFAULT NULL COMMENT '1:Laki; 2:Perempuan',
  `kebangsaan` varchar(100) DEFAULT NULL,
  `tempat_tinggal` varchar(255) DEFAULT NULL,
  `agama` int(1) DEFAULT NULL,
  `pekerjaan` varchar(100) DEFAULT NULL,
  `penggeledahan_terhadap` varchar(255) DEFAULT NULL,
  `penggeledahan_di` varchar(255) DEFAULT NULL,
  `dokumen` varchar(255) DEFAULT NULL,
  `diinput_oleh` varchar(30) DEFAULT NULL,
  `diinput_tanggal` datetime DEFAULT NULL,
  `diperbaharui_oleh` varchar(30) DEFAULT NULL,
  `diperbaharui_tanggal` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `register_penyitaan`
--

CREATE TABLE IF NOT EXISTS `register_penyitaan` (
  `register_id` bigint(20) NOT NULL,
  `kepolisian` varchar(100) DEFAULT NULL,
  `tanggal_register` date DEFAULT NULL,
  `tanggal_register_umum` date DEFAULT NULL,
  `jenis_penyitaan_id` int(1) DEFAULT NULL COMMENT '1:ijin_penyitaan; 2:persetujuan_penyitaan',
  `jenis_penyitaan` varchar(100) DEFAULT NULL,
  `generate_nomor` int(1) DEFAULT NULL,
  `nomor_index` int(11) DEFAULT NULL,
  `nomor_register` varchar(100) DEFAULT NULL,
  `nomor_register_umum` varchar(100) DEFAULT NULL,
  `nomor_suratpermohonan_penyidik` varchar(100) DEFAULT NULL,
  `tanggal_suratpermohonan_penyidik` date DEFAULT NULL,
  `nomor_suratperintahpenyitaan_penyidik` varchar(100) DEFAULT NULL,
  `tanggal_suratperintahpenyitaan_penyidik` date DEFAULT NULL,
  `tanggal_laporan_penyidik` date DEFAULT NULL,
  `penyidik` varchar(100) DEFAULT NULL,
  `nomor_laporan_penyidik` varchar(100) DEFAULT NULL,
  `tanggal_ba_penyitaan` date DEFAULT NULL,
  `nomor_ba_penyitaan` varchar(100) DEFAULT NULL,
  `nama` varchar(150) DEFAULT NULL,
  `tempat_lahir` varchar(100) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `jenis_kelamin` int(1) DEFAULT NULL COMMENT '1:Laki; 2:Perempuan',
  `kebangsaan` varchar(100) DEFAULT NULL,
  `tempat_tinggal` varchar(255) DEFAULT NULL,
  `agama` int(1) DEFAULT NULL,
  `pekerjaan` varchar(100) DEFAULT NULL,
  `penyitaan_terhadap` varchar(255) DEFAULT NULL,
  `penyitaan` text,
  `dokumen` varchar(255) DEFAULT NULL,
  `diinput_oleh` varchar(30) DEFAULT NULL,
  `diinput_tanggal` datetime DEFAULT NULL,
  `diperbaharui_oleh` varchar(30) DEFAULT NULL,
  `diperbaharui_tanggal` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `register_surat`
--

CREATE TABLE IF NOT EXISTS `register_surat` (
  `register_id` bigint(20) NOT NULL,
  `klasifikasi_surat_id` int(11) NOT NULL COMMENT '1:masuk; 2:keluar;',
  `klasifikasi_surat` varchar(100) DEFAULT NULL,
  `jenis_surat_id` int(11) DEFAULT NULL,
  `jenis_surat` varchar(100) DEFAULT NULL,
  `tanggal_register` date DEFAULT NULL,
  `tanggal_surat` date DEFAULT NULL,
  `nomor_index` int(11) DEFAULT NULL,
  `nomor_surat` varchar(100) DEFAULT NULL,
  `nomor_agenda` varchar(100) DEFAULT NULL,
  `pengirim_id` int(11) DEFAULT NULL,
  `pengirim` varchar(255) DEFAULT NULL,
  `tujuan_id` int(11) DEFAULT NULL,
  `tujuan_satker_id` int(11) DEFAULT NULL,
  `tujuan` varchar(255) DEFAULT NULL,
  `perihal` varchar(500) DEFAULT NULL,
  `jenis_ekspedisi_id` int(11) DEFAULT NULL,
  `jenis_ekspedisi` varchar(100) DEFAULT NULL,
  `dokumen_elektronik` varchar(255) DEFAULT NULL,
  `tanggal_kirim` date DEFAULT NULL,
  `status_pelaksanaan_id` int(11) DEFAULT NULL,
  `status_pelaksanaan` varchar(100) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `diinput_oleh` varchar(30) DEFAULT NULL,
  `diinput_tanggal` datetime DEFAULT NULL,
  `diperbaharui_oleh` varchar(30) DEFAULT NULL,
  `diperbaharui_tanggal` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `register_surat`
--

INSERT INTO `register_surat` (`register_id`, `klasifikasi_surat_id`, `klasifikasi_surat`, `jenis_surat_id`, `jenis_surat`, `tanggal_register`, `tanggal_surat`, `nomor_index`, `nomor_surat`, `nomor_agenda`, `pengirim_id`, `pengirim`, `tujuan_id`, `tujuan_satker_id`, `tujuan`, `perihal`, `jenis_ekspedisi_id`, `jenis_ekspedisi`, `dokumen_elektronik`, `tanggal_kirim`, `status_pelaksanaan_id`, `status_pelaksanaan`, `keterangan`, `diinput_oleh`, `diinput_tanggal`, `diperbaharui_oleh`, `diperbaharui_tanggal`) VALUES
(3, 1, 'Surat Masuk', 3, 'Biasa', '2022-04-02', '2022-04-04', 1, 'W1-A12/41/HK.00.4/4/2022', '1/2022', NULL, 'Mahkamah Agung', 4, NULL, 'Panitera', 'Diklat', NULL, NULL, NULL, NULL, 20, 'Dilaksanakan', 'Diklat', 'ros', '2022-04-02 09:34:50', NULL, NULL),
(7, 1, 'Surat Masuk', 1, 'Rahasia', '2022-04-04', '2022-04-05', 2, 'W1-A12/51/PL.05/4/2022', '2/2022', NULL, 'Badilag', 16, NULL, 'Sekretaris', 'Sosialisasi Aplikasi Badilag', NULL, NULL, '14183b8caefab824317498f310716225.pdf', NULL, 20, 'Dilaksanakan', 'Sosialisasi Aplikasi Badilag', 'ros', '2022-04-03 11:07:26', NULL, NULL),
(12, 1, 'Surat Masuk', 3, 'Biasa', '2022-04-08', '2022-04-07', 6, 'W11-A21/20/PL.01/2/2022', '6/2022', NULL, 'Badilag', 2, NULL, 'Ketua Mahkamah Syar''iyah', 'APlikasi Baru', NULL, NULL, NULL, NULL, 10, 'Disposisi', 'APlikasi Baru', 'ros', '2022-04-03 12:33:52', NULL, NULL),
(15, 2, 'Surat Keluar', 1, 'Organisasi', '2022-04-08', NULL, 1, 'W1-A21/1/OT.0/08/2022', NULL, 2, 'Ketua Mahkamah Syar''iyah', 1, NULL, 'Izin Usulan Mutasi Hakim', 'Izin Usulan Mutasi Hakim', 1, 'PT POS Indonesia', '', NULL, 1, 'Pendaftaran', '', 'admin', '2022-04-09 08:16:45', NULL, NULL),
(16, 1, 'Surat Masuk', 1, 'Rahasia', '2022-04-11', '2022-04-08', 7, 'W1-A21/43/HK.00.4/4/2022', '7/2022', NULL, 'Menpan RB', 2, NULL, 'Ketua Mahkamah Syar''iyah', 'Petunjuk Pemilihan Agen Perubahan Thn 2022', NULL, NULL, 'e398a4f7c61413c8d8e6fb98c3edca43.pdf', NULL, 1, 'Pendaftaran', 'Petunjuk Tata CaraPemilihan Agen Perubahan Thn 2022', 'admin', '2022-04-10 06:39:27', NULL, NULL),
(17, 1, 'Surat Masuk', 1, 'Rahasia', '2022-04-12', '2022-04-11', 8, 'W1-A21/1/OT.0/05/2022', '8/2022', NULL, 'Badilag', 16, NULL, 'Sekretaris', 'Mutasi', NULL, NULL, NULL, NULL, 1, 'Pendaftaran', '', 'admin', '2022-04-10 05:24:07', NULL, NULL),
(19, 1, 'Surat Masuk', 3, 'Biasa', '2022-04-11', '2022-04-11', 10, 'W11-A21/23/PL.01/2/2022', '10/2022', NULL, 'Badilag', 2, NULL, 'Ketua Mahkamah Syar''iyah', 'perihal surat', NULL, NULL, NULL, NULL, 1, 'Pendaftaran', 'keterangan', 'ros', '2022-04-11 06:35:22', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `register_surat_keterangan`
--

CREATE TABLE IF NOT EXISTS `register_surat_keterangan` (
  `register_id` bigint(20) NOT NULL,
  `jenis_keterangan_id` int(11) DEFAULT NULL,
  `jenis_keterangan` varchar(255) DEFAULT NULL,
  `tanggal_permohonan` date DEFAULT NULL,
  `tahun_register` year(4) DEFAULT NULL,
  `tanggal_register` date DEFAULT NULL,
  `nomor_agenda_surat_masuk` varchar(100) DEFAULT NULL,
  `tanggal_agenda_surat_keluar` date DEFAULT NULL,
  `nomor_agenda_surat_keluar` varchar(100) DEFAULT NULL,
  `nomor_index` int(11) NOT NULL,
  `nomor_register` varchar(100) DEFAULT NULL,
  `pemohon_identitas_id` tinyint(1) DEFAULT NULL,
  `pemohon_identitas` varchar(100) DEFAULT NULL,
  `pemohon_nomor_identitas` varchar(100) DEFAULT NULL,
  `pemohon_nama` varchar(100) DEFAULT NULL,
  `pemohon_kelamin` tinyint(1) DEFAULT NULL COMMENT '1:Laki; 2:Perempuan;',
  `pemohon_tempat_lahir` varchar(100) DEFAULT NULL,
  `pemohon_tanggal_lahir` date DEFAULT NULL,
  `pemohon_pekerjaan` varchar(100) DEFAULT NULL,
  `pemohon_jabatan` varchar(100) DEFAULT NULL,
  `pemohon_alamat` varchar(255) DEFAULT NULL,
  `pemohon_alasan` varchar(255) DEFAULT NULL,
  `nomor_skck` varchar(100) DEFAULT NULL,
  `pemohon_pendidikan` varchar(100) DEFAULT NULL,
  `dokumen_identitas` varchar(255) DEFAULT NULL,
  `dokumen_skck` varchar(255) DEFAULT NULL,
  `dokumen_suratketerangan` varchar(255) DEFAULT NULL,
  `diinput_oleh` varchar(30) DEFAULT NULL,
  `diinput_tanggal` datetime DEFAULT NULL,
  `diperbaharui_oleh` varchar(30) DEFAULT NULL,
  `diperbaharui_tanggal` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sys_audittrail`
--

CREATE TABLE IF NOT EXISTS `sys_audittrail` (
  `id` bigint(20) unsigned NOT NULL COMMENT 'Primary key: (by system)',
  `datetime` datetime NOT NULL COMMENT 'Waktu Aktifitas: (by system)',
  `ipaddress` varchar(15) NOT NULL DEFAULT '' COMMENT 'Alamat IP: (by system)',
  `username` varchar(30) NOT NULL DEFAULT '' COMMENT 'Username: (by system)',
  `tablename` varchar(250) NOT NULL DEFAULT '' COMMENT 'Nama Tabel: (by system)',
  `action` varchar(250) NOT NULL DEFAULT '' COMMENT 'Aktifitas: (by system)',
  `title` varchar(500) NOT NULL DEFAULT '' COMMENT 'Keterangan Aktifitas: (by system)',
  `description` longtext COMMENT 'Informasi detil Aktifitas: (by system)'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Data Audittrail';

--
-- Dumping data for table `sys_audittrail`
--

INSERT INTO `sys_audittrail` (`id`, `datetime`, `ipaddress`, `username`, `tablename`, `action`, `title`, `description`) VALUES
(1, '2021-08-04 03:29:19', '::1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Dra. Hj. Rosmawardani, S.H., M.H</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style="vertical-align:top" cellspacing="0" cellpadding="1" border="1"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>195412081979032007</td></tr><tr><td>nama_gelar</td><td>Dra. Hj. Rosmawardani, S.H., M.H</td></tr><tr><td>golongan_id</td><td>18</td></tr><tr><td>golongan</td><td>IV/e</td></tr><tr><td>pangkat</td><td>Pembina Utama</td></tr><tr><td>alamat</td><td>Banda Aceh</td></tr><tr><td>jabatan_id</td><td>2</td></tr><tr><td>jabatan_nama</td><td>Ketua Pengadilan</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2021-08-04 03:29:18</td></tr></table>'),
(2, '2021-08-04 03:29:52', '::1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>ros</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=2]', '<br><table style="vertical-align:top" cellspacing="0" cellpadding="1" border="1"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>2</td></tr><tr><td>pegawai_id</td><td>1</td></tr><tr><td>fullname</td><td>Dra. Hj. Rosmawardani, S.H., M.H</td></tr><tr><td>username</td><td>ros</td></tr><tr><td>password</td><td>c5449bcadaec011e4bc554dcde34056e</td></tr><tr><td>email</td><td>ros@gmail.com</td></tr><tr><td>activation</td><td>6b0b41f29b854a34bc5036cf95a0d74f</td></tr><tr><td>code_activation</td><td>64911d63fedf4fb6d4255e2130e6e904</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2021-08-04 03:29:52</td></tr></table>'),
(3, '2021-08-04 03:30:14', '::1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Drs. Syafruddin</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style="vertical-align:top" cellspacing="0" cellpadding="1" border="1"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>196202101994031003</td></tr><tr><td>nama_gelar</td><td>Drs. Syafruddin</td></tr><tr><td>golongan_id</td><td>17</td></tr><tr><td>golongan</td><td>IV/d</td></tr><tr><td>pangkat</td><td>Pembina Utama Madya</td></tr><tr><td>alamat</td><td>Banda Aceh</td></tr><tr><td>jabatan_id</td><td>4</td></tr><tr><td>jabatan_nama</td><td>Panitera</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2021-08-04 03:30:14</td></tr></table>'),
(4, '2021-08-04 03:31:48', '::1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>syaf</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=3]', '<br><table style="vertical-align:top" cellspacing="0" cellpadding="1" border="1"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>3</td></tr><tr><td>pegawai_id</td><td>2</td></tr><tr><td>fullname</td><td>Drs. Syafruddin</td></tr><tr><td>username</td><td>syaf</td></tr><tr><td>password</td><td>80776312162d09d86406a3ea9f4151f1</td></tr><tr><td>email</td><td>syaf@gmail.com</td></tr><tr><td>activation</td><td>dcf3dd060300e5ae0fe500d65781bfbe</td></tr><tr><td>code_activation</td><td>527b9c87c3ea750538746364a99596fd</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2021-08-04 03:31:48</td></tr></table>'),
(5, '2021-08-04 04:13:04', '::1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Rafi</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style="vertical-align:top" cellspacing="0" cellpadding="1" border="1"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>195803141983031004</td></tr><tr><td>nama_gelar</td><td>Rafi</td></tr><tr><td>golongan_id</td><td>18</td></tr><tr><td>golongan</td><td>IV/e</td></tr><tr><td>pangkat</td><td>Pembina Utama</td></tr><tr><td>alamat</td><td>Banda Aceh</td></tr><tr><td>jabatan_id</td><td>3</td></tr><tr><td>jabatan_nama</td><td>Wakil Ketua Pengadilan</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2021-08-04 04:13:03</td></tr></table>'),
(6, '2021-08-04 04:13:43', '::1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>latif</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style="vertical-align:top" cellspacing="0" cellpadding="1" border="1"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>-</td></tr><tr><td>nama_gelar</td><td>latif</td></tr><tr><td>golongan_id</td><td>14</td></tr><tr><td>golongan</td><td>IV/a</td></tr><tr><td>pangkat</td><td>Pembina</td></tr><tr><td>alamat</td><td>Banda Aceh</td></tr><tr><td>jabatan_id</td><td>7</td></tr><tr><td>jabatan_nama</td><td>Panitera Muda Hukum</td></tr><tr><td>aktif</td><td>T</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2021-08-04 04:13:43</td></tr></table>'),
(7, '2021-08-04 04:14:13', '::1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>bahrun</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style="vertical-align:top" cellspacing="0" cellpadding="1" border="1"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>-</td></tr><tr><td>nama_gelar</td><td>bahrun</td></tr><tr><td>golongan_id</td><td>14</td></tr><tr><td>golongan</td><td>IV/a</td></tr><tr><td>pangkat</td><td>Pembina</td></tr><tr><td>alamat</td><td>Banda Aceh</td></tr><tr><td>jabatan_id</td><td>19</td></tr><tr><td>jabatan_nama</td><td>Kepala Sub Bagian Umum dan Keuangan</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2021-08-04 04:14:13</td></tr></table>'),
(8, '2021-08-04 04:17:50', '::1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>latif</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=4]', '<br><table style="vertical-align:top" cellspacing="0" cellpadding="1" border="1"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>4</td></tr><tr><td>pegawai_id</td><td>4</td></tr><tr><td>fullname</td><td>latif</td></tr><tr><td>username</td><td>latif</td></tr><tr><td>password</td><td>1a8a5d83ce5b455ea31cb36666a948c3</td></tr><tr><td>email</td><td>latif@gmail.com</td></tr><tr><td>activation</td><td>89723a3c2dbc6c19ec0131852747efd2</td></tr><tr><td>code_activation</td><td>eeb3a028814776c51a4148819f20f785</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2021-08-04 04:17:50</td></tr></table>'),
(9, '2021-08-04 04:50:10', '::1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>khair</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style="vertical-align:top" cellspacing="0" cellpadding="1" border="1"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>-</td></tr><tr><td>nama_gelar</td><td>khair</td></tr><tr><td>golongan_id</td><td>17</td></tr><tr><td>golongan</td><td>IV/d</td></tr><tr><td>pangkat</td><td>Pembina Utama Madya</td></tr><tr><td>alamat</td><td>Banda Aceh</td></tr><tr><td>jabatan_id</td><td>16</td></tr><tr><td>jabatan_nama</td><td>Sekretaris</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2021-08-04 04:50:09</td></tr></table>'),
(10, '2021-08-04 04:51:17', '::1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Drs. Ilyas, S.H., M.H</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style="vertical-align:top" cellspacing="0" cellpadding="1" border="1"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>-</td></tr><tr><td>nama_gelar</td><td>Drs. Ilyas, S.H., M.H</td></tr><tr><td>golongan_id</td><td>14</td></tr><tr><td>golongan</td><td>IV/a</td></tr><tr><td>pangkat</td><td>Pembina</td></tr><tr><td>alamat</td><td>Banda Aceh</td></tr><tr><td>jabatan_id</td><td>22</td></tr><tr><td>jabatan_nama</td><td>Staf  Panitera Muda Hukum</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2021-08-04 04:51:17</td></tr></table>'),
(11, '2021-08-04 04:52:01', '::1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>ratna</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style="vertical-align:top" cellspacing="0" cellpadding="1" border="1"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>-</td></tr><tr><td>nama_gelar</td><td>ratna</td></tr><tr><td>golongan_id</td><td>14</td></tr><tr><td>golongan</td><td>IV/a</td></tr><tr><td>pangkat</td><td>Pembina</td></tr><tr><td>alamat</td><td>Banda Aceh</td></tr><tr><td>jabatan_id</td><td>5</td></tr><tr><td>jabatan_nama</td><td>Panitera Muda Pidana</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2021-08-04 04:52:01</td></tr></table>'),
(12, '2021-08-04 04:53:25', '::1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>rafi</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=5]', '<br><table style="vertical-align:top" cellspacing="0" cellpadding="1" border="1"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>5</td></tr><tr><td>pegawai_id</td><td>3</td></tr><tr><td>fullname</td><td>Rafi</td></tr><tr><td>username</td><td>rafi</td></tr><tr><td>password</td><td>85ccab9353ea7aef6526a822ca28006d</td></tr><tr><td>email</td><td>rafi@gmail.com</td></tr><tr><td>activation</td><td>ed2b8ba914746d536d843e831d6aafec</td></tr><tr><td>code_activation</td><td>b4e57699a8e544863256c0cd196c92d0</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2021-08-04 04:53:25</td></tr></table>'),
(13, '2021-08-04 04:54:20', '::1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>bahrun</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=6]', '<br><table style="vertical-align:top" cellspacing="0" cellpadding="1" border="1"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>6</td></tr><tr><td>pegawai_id</td><td>5</td></tr><tr><td>fullname</td><td>bahrun</td></tr><tr><td>username</td><td>bahrun</td></tr><tr><td>password</td><td>7ee720947fb1383ddbc646763175e4c6</td></tr><tr><td>email</td><td>bahrun@gmail.com</td></tr><tr><td>activation</td><td>682935d98be8f3bc4cc6d52b2f188668</td></tr><tr><td>code_activation</td><td>a1a23f6f09ec7efee8d576a823e2338a</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2021-08-04 04:54:19</td></tr></table>'),
(14, '2021-08-04 04:55:55', '::1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>khair</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=7]', '<br><table style="vertical-align:top" cellspacing="0" cellpadding="1" border="1"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>7</td></tr><tr><td>pegawai_id</td><td>6</td></tr><tr><td>fullname</td><td>khair</td></tr><tr><td>username</td><td>khair</td></tr><tr><td>password</td><td>e5f2f4d0253a8312784195f9409f065f</td></tr><tr><td>email</td><td>khair@gmail.com</td></tr><tr><td>activation</td><td>faae5361878bd81899f2ea65a10245ac</td></tr><tr><td>code_activation</td><td>3286bf3ce458f4e3b638dae25a05a82f</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2021-08-04 04:55:54</td></tr></table>'),
(15, '2021-08-04 04:56:20', '::1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>ilyas</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=8]', '<br><table style="vertical-align:top" cellspacing="0" cellpadding="1" border="1"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>8</td></tr><tr><td>pegawai_id</td><td>7</td></tr><tr><td>fullname</td><td>Drs. Ilyas, S.H., M.H</td></tr><tr><td>username</td><td>ilyas</td></tr><tr><td>password</td><td>4a5211cf2de2e5897cbec7f2c4203f63</td></tr><tr><td>email</td><td>ilyas@gmail.com</td></tr><tr><td>activation</td><td>b65d370f50477300fcbd02ebfcd9bbd3</td></tr><tr><td>code_activation</td><td>87a55d74550b86c4d46e57f14c79eb69</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2021-08-04 04:56:19</td></tr></table>'),
(16, '2021-08-04 04:56:46', '::1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>ratna</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=9]', '<br><table style="vertical-align:top" cellspacing="0" cellpadding="1" border="1"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>9</td></tr><tr><td>pegawai_id</td><td>8</td></tr><tr><td>fullname</td><td>ratna</td></tr><tr><td>username</td><td>ratna</td></tr><tr><td>password</td><td>8ad1888c5e6a47a6947cade86dd2d61a</td></tr><tr><td>email</td><td>ratna@gmail.com</td></tr><tr><td>activation</td><td>e64233156482aaf65ad22b327d75b159</td></tr><tr><td>code_activation</td><td>3cfbc00fc9d66b8e74b680858d16d217</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2021-08-04 04:56:46</td></tr></table>');

-- --------------------------------------------------------

--
-- Table structure for table `sys_config`
--

CREATE TABLE IF NOT EXISTS `sys_config` (
  `id` int(11) unsigned NOT NULL COMMENT 'Primari Key',
  `category` varchar(50) NOT NULL DEFAULT 'System' COMMENT 'Kategori Konfigurasi',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT 'Nama Konfigurasi',
  `value` varchar(255) DEFAULT NULL,
  `ordering` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Urutan'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Data Konfigurasi Sistem';

--
-- Dumping data for table `sys_config`
--

INSERT INTO `sys_config` (`id`, `category`, `name`, `value`, `ordering`) VALUES
(1, 'system', 'SiteName', 'Register Surat Masuk dan Keluar', 0),
(2, 'system', 'SiteTitle', 'Register Surat Masuk dan Keluar', 0),
(3, 'system', 'KodePN', '401582', 0),
(4, 'system', 'NamaPN', 'MAHKAMAH SYAR''IYAH ACEH', 0),
(5, 'system', 'AlamatPN', 'Jln. T. Nyak Arief - Komplek Keistimewaan Aceh Banda Aceh 23242', 0),
(6, 'system', 'KetuaPNNama', NULL, 0),
(7, 'system', 'KetuaPNNIP', NULL, 0),
(8, 'system', 'WakilKetuaPNNama', NULL, 0),
(9, 'system', 'WakilKetuaPNNIP', NULL, 0),
(10, 'system', 'PanSekNama', NULL, 0),
(11, 'system', 'PanSekNIP', NULL, 0),
(12, 'system', 'WaPanNama', NULL, 0),
(13, 'system', 'WaPanNIP', NULL, 0),
(14, 'system', 'WaSekNama', NULL, 0),
(15, 'system', 'WaSekNIP', NULL, 0),
(16, 'system', 'ZonaWaktu', NULL, 0),
(17, 'system', 'NamaPT', 'MAHKAMAH SYARIYAH ACEH', 0),
(18, 'system', 'AlamatPT', 'Jln. T. Nyak Arief - Komplek Keistimewaan Aceh Banda Aceh 23242', 0),
(19, 'system', 'VersiAplikasi', '1.0', 0),
(20, 'system', 'IDPN', '762', 0),
(21, 'System', 'IDPT', '60', 0),
(22, 'System', 'LogoPN', '895b815562c67b209e91bfcc60491826.png', 0),
(23, 'System', 'KodeSurat', 'W1-A21', 0),
(24, 'System', 'FormatAgendaSurat', 'NMR_AGENDA/TAHUN_AGENDA', 0),
(25, 'System', 'FormatSuratKeterangan', '#NMR_SK#/SK/HK/#BLN#/#THN#/#KD_PN#', 0),
(26, 'System', 'KodePerkara', 'MS.ACEH', 0),
(27, 'System', 'NamaKotaKab', '', 0),
(28, 'System', 'FormatRegisterPenyitaan', '#NMR_SK#/Pen.Pid/#THN#/#KD_PN#', 0);

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

-- --------------------------------------------------------

--
-- Table structure for table `sys_users`
--

CREATE TABLE IF NOT EXISTS `sys_users` (
  `userid` int(11) NOT NULL COMMENT 'UserId: (by system)',
  `pegawai_id` int(11) NOT NULL,
  `fullname` varchar(255) NOT NULL DEFAULT '' COMMENT 'Nama Lengkap: isian bebas',
  `username` varchar(30) NOT NULL DEFAULT '' COMMENT 'Nama User: isian bebas',
  `password` varchar(100) NOT NULL DEFAULT '' COMMENT 'Password: sudah di-encript',
  `old_password` varchar(400) NOT NULL DEFAULT '' COMMENT 'Password Lama: menggunakan separator semicolon (by system)',
  `email` varchar(100) NOT NULL DEFAULT '' COMMENT 'Alamat Email: format email',
  `alternative_email` varchar(255) NOT NULL DEFAULT '' COMMENT 'Alamat Email Alternatif: menggunakan separator semicolon',
  `allow_concurrent_login` tinyint(1) NOT NULL DEFAULT '-1' COMMENT 'Diperbolehkan Login Bersamaan: Pilihan (-1=global; 0=single login 1=multiple login)',
  `has_change_password` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Sudah Ganti Password: 0=belum 1=sudah (by system)',
  `enable_change_password` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Diperbolehkan Ganti Password: pilihan 0=Tidak; 1=Ya',
  `last_change_password` datetime DEFAULT NULL COMMENT 'Waktu Terakhir Ganti Password: (by system)',
  `password_expired_remainder` int(11) NOT NULL DEFAULT '-1' COMMENT 'Pengingat Password Kadaluarsa: Pilihan \r\n(-1=ikut ke global konfigurasi)',
  `attemp_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Jumlah Kesalahan Password',
  `attemp_time` datetime DEFAULT NULL COMMENT 'Waktu Terakhir Kesalahan Password',
  `user_expired` datetime DEFAULT NULL COMMENT 'Waktu Kadaluarsa User: isian tanggal',
  `last_login` datetime DEFAULT NULL COMMENT 'Tanggal Terakhir Login: (by system)',
  `block` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Blok User: pilihan 0=Tidak; 1=ya',
  `activation` varchar(100) NOT NULL DEFAULT '' COMMENT 'kode aktivasi',
  `code_activation` varchar(100) DEFAULT NULL COMMENT 'kode aktivasi',
  `params` text NOT NULL COMMENT 'parameter lain',
  `lock_by` varchar(30) NOT NULL DEFAULT '' COMMENT 'Diedit Oleh: (by system)',
  `lock_on` datetime DEFAULT NULL COMMENT 'Diedit Tanggal: (by system)',
  `created_by` varchar(30) DEFAULT NULL COMMENT 'Diinput Oleh: (by system)',
  `created_on` datetime DEFAULT NULL COMMENT 'Diinput Tanggal: (by system)',
  `modified_by` varchar(30) DEFAULT NULL COMMENT 'Diperbaharui oleh: (by system)',
  `modified_on` datetime DEFAULT NULL COMMENT 'Diperbaharui Tanggal: (by system)'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AVG_ROW_LENGTH=372 COMMENT='Data User';

--
-- Dumping data for table `sys_users`
--

INSERT INTO `sys_users` (`userid`, `pegawai_id`, `fullname`, `username`, `password`, `old_password`, `email`, `alternative_email`, `allow_concurrent_login`, `has_change_password`, `enable_change_password`, `last_change_password`, `password_expired_remainder`, `attemp_count`, `attemp_time`, `user_expired`, `last_login`, `block`, `activation`, `code_activation`, `params`, `lock_by`, `lock_on`, `created_by`, `created_on`, `modified_by`, `modified_on`) VALUES
(1, 0, 'Super Administrator', 'admin', '22d3b91575acfd31a747aa90148723e2', '9e24d23de65f136b32ef8ffaad9d2086;9e24d23de65f136b32ef8ffaad9d2086;', 'admin@mail.go.id', '', -1, 1, 1, '2013-03-08 10:47:55', -1, 0, NULL, NULL, '2017-09-06 09:44:56', 0, 'b1a9d413781b40e7961c8c48a024f24e', '1672e5d8d1ae74efbe5d36c5c64b518f', '', '', NULL, '', '2011-03-22 23:36:46', 'system', '2012-08-29 00:15:45'),
(2, 1, 'Dra. Hj. Rosmawardani, S.H., M.H', 'ros', 'c5449bcadaec011e4bc554dcde34056e', '', 'ros@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, '6b0b41f29b854a34bc5036cf95a0d74f', '64911d63fedf4fb6d4255e2130e6e904', '', '', NULL, 'admin', '2021-08-04 03:29:52', NULL, NULL),
(3, 2, 'Drs. Syafruddin', 'syaf', '80776312162d09d86406a3ea9f4151f1', '', 'syaf@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, 'dcf3dd060300e5ae0fe500d65781bfbe', '527b9c87c3ea750538746364a99596fd', '', '', NULL, 'admin', '2021-08-04 03:31:48', NULL, NULL),
(4, 4, 'latif', 'latif', '1a8a5d83ce5b455ea31cb36666a948c3', '', 'latif@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, '89723a3c2dbc6c19ec0131852747efd2', 'eeb3a028814776c51a4148819f20f785', '', '', NULL, 'admin', '2021-08-04 04:17:50', NULL, NULL),
(5, 3, 'Rafi', 'rafi', '85ccab9353ea7aef6526a822ca28006d', '', 'rafi@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, 'ed2b8ba914746d536d843e831d6aafec', 'b4e57699a8e544863256c0cd196c92d0', '', '', NULL, 'admin', '2021-08-04 04:53:25', NULL, NULL),
(6, 5, 'bahrun', 'bahrun', '7ee720947fb1383ddbc646763175e4c6', '', 'bahrun@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, '682935d98be8f3bc4cc6d52b2f188668', 'a1a23f6f09ec7efee8d576a823e2338a', '', '', NULL, 'admin', '2021-08-04 04:54:19', NULL, NULL),
(7, 6, 'Khairuddin, S.H., M.H.', 'khair', 'e5f2f4d0253a8312784195f9409f065f', '', 'khair@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, 'faae5361878bd81899f2ea65a10245ac', '3286bf3ce458f4e3b638dae25a05a82f', '', '', NULL, 'admin', '2021-08-04 04:55:54', NULL, NULL),
(8, 7, 'Drs. Ilyas, S.H., M.H', 'ilyas', '4a5211cf2de2e5897cbec7f2c4203f63', '', 'ilyas@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, 'b65d370f50477300fcbd02ebfcd9bbd3', '87a55d74550b86c4d46e57f14c79eb69', '', '', NULL, 'admin', '2021-08-04 04:56:19', NULL, NULL),
(9, 8, 'ratna', 'ratna', '8ad1888c5e6a47a6947cade86dd2d61a', '', 'ratna@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, 'e64233156482aaf65ad22b327d75b159', '3cfbc00fc9d66b8e74b680858d16d217', '', '', NULL, 'admin', '2021-08-04 04:56:46', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sys_user_group`
--

CREATE TABLE IF NOT EXISTS `sys_user_group` (
  `userid` int(11) NOT NULL DEFAULT '0' COMMENT 'UserId: merujuk ke tabel sys_users kolom userid',
  `groupid` int(11) NOT NULL DEFAULT '0' COMMENT 'Foreign Key to groups.groupid'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Data Hubungan User Dengan Grup';

--
-- Dumping data for table `sys_user_group`
--

INSERT INTO `sys_user_group` (`userid`, `groupid`) VALUES
(1, 1),
(2, 2),
(3, 4),
(4, 6),
(5, 3),
(6, 19),
(7, 16),
(8, 7),
(9, 5);

-- --------------------------------------------------------

--
-- Table structure for table `sys_user_online`
--

CREATE TABLE IF NOT EXISTS `sys_user_online` (
  `id` bigint(20) NOT NULL COMMENT 'SessionId (by system)',
  `userid` int(11) unsigned NOT NULL COMMENT 'UserId: merujuk ke tabel sys_users ke kolom userid (by system)',
  `host_address` varchar(50) NOT NULL DEFAULT '' COMMENT 'Alamat IP (by system)',
  `login_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Waktu login (by system)',
  `user_agent` varchar(255) NOT NULL DEFAULT '' COMMENT 'Jenis browser (by system)',
  `uri` varchar(1024) NOT NULL DEFAULT '' COMMENT 'Alamat URL (by system)',
  `current_page` varchar(50) NOT NULL DEFAULT '' COMMENT 'Halaman saat ini (by system)',
  `last_visit` datetime DEFAULT NULL COMMENT 'Terakhir Berkunjung (by system)',
  `data` text COMMENT 'Data Lain (by system)'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Data User Yang Sedang Online';

--
-- Dumping data for table `sys_user_online`
--

INSERT INTO `sys_user_online` (`id`, `userid`, `host_address`, `login_time`, `user_agent`, `uri`, `current_page`, `last_visit`, `data`) VALUES
(1, 1, '::1', '2021-08-04 01:11:36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(2, 2, '::1', '2021-08-04 01:30:40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(3, 1, '::1', '2021-08-04 01:31:27', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(4, 3, '::1', '2021-08-04 01:31:58', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(5, 3, '::1', '2021-08-04 01:32:18', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(6, 1, '::1', '2021-08-04 01:39:23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(7, 3, '::1', '2021-08-04 01:58:47', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(8, 3, '::1', '2021-08-04 02:05:59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(9, 1, '::1', '2021-08-04 02:12:25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(10, 1, '::1', '2021-08-04 02:16:52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(11, 4, '::1', '2021-08-04 02:18:12', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(12, 1, '::1', '2021-08-04 02:18:39', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(13, 1, '::1', '2021-08-04 02:45:35', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(14, 4, '::1', '2021-08-04 02:45:55', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(15, 1, '::1', '2021-08-04 02:46:32', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(16, 4, '::1', '2021-08-04 03:08:43', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(17, 1, '::1', '2021-08-04 03:08:59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(18, 4, '::1', '2021-08-04 03:09:51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(19, 4, '::1', '2021-08-04 03:11:21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(20, 8, '::1', '2021-08-04 03:12:12', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(21, 3, '::1', '2021-08-04 03:14:32', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(22, 2, '::1', '2021-08-04 04:32:30', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(23, 3, '::1', '2021-08-04 07:38:54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(24, 8, '::1', '2021-08-04 07:39:07', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(25, 4, '::1', '2021-08-04 08:14:03', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(26, 4, '::1', '2021-08-04 08:14:23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(27, 2, '::1', '2021-08-04 08:14:31', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(28, 6, '::1', '2021-08-04 08:40:23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(29, 4, '::1', '2021-08-04 08:41:22', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(30, 1, '::1', '2021-08-04 08:41:43', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(31, 4, '::1', '2021-08-04 08:44:24', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(32, 4, '::1', '2021-08-04 08:44:31', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(33, 1, '::1', '2021-08-04 08:46:07', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(34, 4, '::1', '2021-08-04 09:02:10', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(35, 1, '::1', '2021-08-04 09:03:23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(36, 3, '::1', '2021-08-04 09:05:24', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(37, 3, '::1', '2021-08-04 09:33:11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(38, 3, '::1', '2021-08-04 09:33:12', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(39, 1, '::1', '2021-08-04 09:33:33', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(40, 3, '::1', '2021-08-04 09:35:01', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(41, 1, '::1', '2021-08-04 09:54:05', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(42, 3, '::1', '2021-08-04 10:11:17', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(43, 1, '::1', '2021-08-04 10:22:23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(44, 3, '::1', '2021-08-05 01:07:36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(45, 8, '::1', '2021-08-05 01:42:11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(46, 4, '::1', '2021-08-05 01:43:22', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(47, 4, '::1', '2021-08-05 01:53:56', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(48, 1, '::1', '2021-08-05 02:30:35', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(49, 4, '::1', '2021-08-05 02:35:47', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(50, 4, '::1', '2021-08-05 02:35:47', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(51, 2, '::1', '2021-08-05 02:35:55', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(52, 2, '::1', '2021-08-05 02:36:24', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(53, 2, '::1', '2021-08-05 02:38:57', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(54, 1, '::1', '2021-08-05 07:24:42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36', '', '', NULL, NULL),
(55, 1, '::1', '2021-08-27 09:10:46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36 Edg/92.0.902.78', '', '', NULL, NULL),
(56, 1, '::1', '2021-08-27 09:21:12', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36 Edg/92.0.902.78', '', '', NULL, NULL),
(57, 1, '::1', '2021-08-27 09:22:50', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36 Edg/92.0.902.78', '', '', NULL, NULL),
(58, 8, '::1', '2021-08-27 09:23:54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36 Edg/92.0.902.78', '', '', NULL, NULL),
(59, 2, '::1', '2021-08-27 09:24:15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36 Edg/92.0.902.78', '', '', NULL, NULL),
(60, 1, '::1', '2021-09-06 01:59:42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.63 Safari/537.36 Edg/93.0.961.38', '', '', NULL, NULL),
(61, 1, '::1', '2021-09-06 02:01:49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.63 Safari/537.36 Edg/93.0.961.38', '', '', NULL, NULL),
(62, 1, '::1', '2021-09-06 03:04:38', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.63 Safari/537.36 Edg/93.0.961.38', '', '', NULL, NULL),
(63, 1, '::1', '2021-09-06 03:16:09', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.63 Safari/537.36 Edg/93.0.961.38', '', '', NULL, NULL),
(64, 1, '::1', '2021-09-06 03:20:18', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.63 Safari/537.36 Edg/93.0.961.38', '', '', NULL, NULL),
(65, 2, '::1', '2021-09-06 03:21:15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.63 Safari/537.36 Edg/93.0.961.38', '', '', NULL, NULL),
(66, 8, '::1', '2021-09-06 03:21:31', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.63 Safari/537.36 Edg/93.0.961.38', '', '', NULL, NULL),
(67, 1, '::1', '2021-09-06 03:21:51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.63 Safari/537.36 Edg/93.0.961.38', '', '', NULL, NULL),
(68, 1, '127.0.0.1', '2022-04-02 04:32:26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(69, 1, '127.0.0.1', '2022-04-02 05:33:20', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(70, 1, '127.0.0.1', '2022-04-02 07:01:29', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(71, 4, '127.0.0.1', '2022-04-02 07:04:18', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(72, 4, '192.168.10.224', '2022-04-02 07:26:10', 'Mozilla/5.0 (Linux; Android 11; SM-A307GN) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.73 Mobile Safari/537.36', '', '', NULL, NULL),
(73, 4, '127.0.0.1', '2022-04-02 07:28:46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(74, 1, '127.0.0.1', '2022-04-02 07:30:22', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(75, 3, '127.0.0.1', '2022-04-02 07:31:22', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(76, 1, '127.0.0.1', '2022-04-02 07:33:08', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(77, 2, '127.0.0.1', '2022-04-02 07:33:21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(78, 6, '127.0.0.1', '2022-04-02 07:36:00', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(79, 1, '127.0.0.1', '2022-04-02 07:36:22', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(80, 3, '127.0.0.1', '2022-04-02 07:37:40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(81, 6, '127.0.0.1', '2022-04-02 07:38:42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(82, 1, '127.0.0.1', '2022-04-02 09:00:50', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(83, 2, '127.0.0.1', '2022-04-02 09:04:39', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(84, 2, '127.0.0.1', '2022-04-02 12:06:03', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(85, 2, '127.0.0.1', '2022-04-02 16:15:08', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(86, 2, '127.0.0.1', '2022-04-03 04:20:35', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(87, 2, '127.0.0.1', '2022-04-03 05:01:01', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(88, 1, '127.0.0.1', '2022-04-03 05:11:30', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(89, 2, '127.0.0.1', '2022-04-03 05:12:22', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(90, 2, '127.0.0.1', '2022-04-03 07:54:01', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(91, 2, '127.0.0.1', '2022-04-03 08:41:37', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(92, 1, '127.0.0.1', '2022-04-03 08:45:03', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(93, 1, '127.0.0.1', '2022-04-03 08:46:35', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(94, 2, '::1', '2022-04-03 08:49:07', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.60 Safari/537.36', '', '', NULL, NULL),
(95, 1, '::1', '2022-04-03 08:50:53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.60 Safari/537.36', '', '', NULL, NULL),
(96, 1, '127.0.0.1', '2022-04-03 09:03:31', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(97, 2, '127.0.0.1', '2022-04-03 09:03:40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(98, 7, '127.0.0.1', '2022-04-03 09:08:27', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(99, 2, '127.0.0.1', '2022-04-03 09:09:12', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(100, 2, '127.0.0.1', '2022-04-03 09:12:02', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(101, 7, '127.0.0.1', '2022-04-03 09:17:52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(102, 2, '127.0.0.1', '2022-04-03 09:22:50', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(103, 2, '127.0.0.1', '2022-04-03 09:30:19', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(104, 6, '127.0.0.1', '2022-04-03 10:07:03', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(105, 2, '127.0.0.1', '2022-04-03 10:07:43', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(106, 7, '127.0.0.1', '2022-04-03 10:08:31', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(107, 7, '::1', '2022-04-03 10:17:07', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.60 Safari/537.36', '', '', NULL, NULL),
(108, 1, '127.0.0.1', '2022-04-03 10:24:35', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(109, 7, '127.0.0.1', '2022-04-03 10:25:31', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(110, 2, '::1', '2022-04-03 10:32:59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.60 Safari/537.36', '', '', NULL, NULL),
(111, 2, '127.0.0.1', '2022-04-04 11:27:13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(112, 1, '127.0.0.1', '2022-04-04 17:06:07', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(113, 2, '::1', '2022-04-04 17:23:11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.60 Safari/537.36', '', '', NULL, NULL),
(114, 1, '127.0.0.1', '2022-04-05 11:33:48', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(115, 1, '127.0.0.1', '2022-04-05 16:50:35', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(116, 7, '127.0.0.1', '2022-04-05 17:12:10', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(117, 2, '127.0.0.1', '2022-04-06 09:11:42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(118, 7, '127.0.0.1', '2022-04-06 09:13:59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(119, 7, '::1', '2022-04-06 13:18:49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL),
(120, 7, '::1', '2022-04-06 14:33:34', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL),
(121, 7, '127.0.0.1', '2022-04-06 16:47:06', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(122, 1, '::1', '2022-04-06 16:52:49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL),
(123, 2, '::1', '2022-04-06 16:56:02', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL),
(124, 2, '::1', '2022-04-06 18:37:48', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL),
(125, 1, '::1', '2022-04-07 11:13:23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL),
(126, 7, '::1', '2022-04-07 11:13:43', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL),
(127, 1, '::1', '2022-04-07 12:56:18', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL),
(128, 2, '::1', '2022-04-07 12:56:37', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL),
(129, 7, '::1', '2022-04-07 12:56:53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL),
(130, 2, '::1', '2022-04-07 14:11:15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL),
(131, 7, '::1', '2022-04-07 14:11:35', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL),
(132, 1, '::1', '2022-04-07 14:11:49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL),
(133, 7, '::1', '2022-04-07 14:12:05', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL),
(134, 2, '::1', '2022-04-07 14:14:47', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL),
(135, 7, '::1', '2022-04-07 14:26:04', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL),
(136, 7, '127.0.0.1', '2022-04-07 17:28:50', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0', '', '', NULL, NULL),
(137, 7, '::1', '2022-04-07 18:23:20', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL),
(138, 1, '127.0.0.1', '2022-04-08 02:48:23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(139, 2, '127.0.0.1', '2022-04-08 02:48:46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(140, 7, '127.0.0.1', '2022-04-08 04:27:19', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(141, 7, '::1', '2022-04-08 07:04:55', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL),
(142, 2, '::1', '2022-04-08 07:31:56', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL),
(143, 7, '::1', '2022-04-08 07:32:41', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL),
(144, 7, '192.168.82.219', '2022-04-08 08:16:40', 'Mozilla/5.0 (Linux; Android 11; SM-A307GN) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.73 Mobile Safari/537.36', '', '', NULL, NULL),
(145, 7, '127.0.0.1', '2022-04-09 03:49:16', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(146, 7, '::1', '2022-04-09 03:56:59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL),
(147, 1, '::1', '2022-04-09 06:11:08', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL),
(148, 1, '::1', '2022-04-09 06:13:58', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL),
(149, 1, '127.0.0.1', '2022-04-09 06:15:12', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(150, 7, '127.0.0.1', '2022-04-09 10:22:31', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(151, 1, '127.0.0.1', '2022-04-09 10:22:42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(152, 1, '::1', '2022-04-09 12:32:46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL),
(153, 1, '127.0.0.1', '2022-04-09 13:07:57', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(154, 1, '127.0.0.1', '2022-04-10 03:19:46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(155, 1, '127.0.0.1', '2022-04-10 03:28:43', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(156, 1, '127.0.0.1', '2022-04-10 03:44:31', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(157, 7, '127.0.0.1', '2022-04-10 04:02:30', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(158, 1, '127.0.0.1', '2022-04-10 04:35:03', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(159, 7, '127.0.0.1', '2022-04-10 04:39:44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(160, 2, '127.0.0.1', '2022-04-10 04:40:06', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(161, 1, '127.0.0.1', '2022-04-10 15:19:04', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(162, 7, '127.0.0.1', '2022-04-10 15:24:37', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(163, 1, '127.0.0.1', '2022-04-10 15:24:52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(164, 7, '127.0.0.1', '2022-04-10 15:25:25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(165, 1, '127.0.0.1', '2022-04-10 15:26:29', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(166, 7, '127.0.0.1', '2022-04-10 16:17:50', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(167, 2, '127.0.0.1', '2022-04-10 17:05:35', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(168, 7, '127.0.0.1', '2022-04-10 17:12:38', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(169, 1, '127.0.0.1', '2022-04-11 01:43:57', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(170, 8, '127.0.0.1', '2022-04-11 02:02:12', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(171, 4, '127.0.0.1', '2022-04-11 02:02:50', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(172, 1, '127.0.0.1', '2022-04-11 02:05:31', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(173, 7, '127.0.0.1', '2022-04-11 02:06:19', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(174, 1, '::1', '2022-04-11 02:37:11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL),
(175, 2, '::1', '2022-04-11 04:34:43', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL),
(176, 7, '::1', '2022-04-11 04:37:21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL),
(177, 2, '::1', '2022-04-11 04:37:41', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL),
(178, 7, '192.168.17.93', '2022-04-11 05:26:03', 'Mozilla/5.0 (Linux; Android 11; SM-A307GN) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.73 Mobile Safari/537.36', '', '', NULL, NULL),
(179, 2, '192.168.17.93', '2022-04-11 05:26:35', 'Mozilla/5.0 (Linux; Android 11; SM-A307GN) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.73 Mobile Safari/537.36', '', '', NULL, NULL),
(180, 2, '192.168.17.93', '2022-04-11 05:36:34', 'Mozilla/5.0 (Linux; Android 11; SM-A307GN) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.73 Mobile Safari/537.36', '', '', NULL, NULL),
(0, 1, '::1', '2022-04-11 06:54:20', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_groups`
--
CREATE TABLE IF NOT EXISTS `v_groups` (
`group_id` int(11)
,`group_name` varchar(255)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `v_groups_struktural`
--
CREATE TABLE IF NOT EXISTS `v_groups_struktural` (
`groupid` int(11)
,`group_name` varchar(255)
,`bagian` varchar(255)
,`pegawai_id` int(11) unsigned
,`nip` varchar(20)
,`nama` varchar(50)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `v_pelaksanaan_suratkeluar`
--
CREATE TABLE IF NOT EXISTS `v_pelaksanaan_suratkeluar` (
`tanggal_register` date
,`tahun_register` int(4)
,`nomor_surat` varchar(100)
,`tujuan` varchar(255)
,`waktu` bigint(21)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `v_pelaksanaan_suratmasuk`
--
CREATE TABLE IF NOT EXISTS `v_pelaksanaan_suratmasuk` (
`tanggal_register` date
,`tahun_register` int(4)
,`nomor_surat` varchar(100)
,`pengirim` varchar(255)
,`perihal` varchar(500)
,`tujuan_disposisi_nama` varchar(255)
,`tujuan_disposisi_jabatan` varchar(255)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `v_suratkeluar`
--
CREATE TABLE IF NOT EXISTS `v_suratkeluar` (
`register_id` bigint(20)
,`klasifikasi_surat_id` int(11)
,`klasifikasi_surat` varchar(100)
,`jenis_surat_id` int(11)
,`jenis_surat` varchar(100)
,`tahun_register` int(4)
,`tanggal_register` date
,`nomor_index` int(11)
,`nomor_surat` varchar(100)
,`pengirim_id` int(11)
,`pengirim` varchar(255)
,`tujuan_id` int(11)
,`tujuan_satker_id` int(11)
,`tujuan` varchar(255)
,`perihal` varchar(500)
,`jenis_ekspedisi_id` int(11)
,`jenis_ekspedisi` varchar(100)
,`dokumen_elektronik` varchar(255)
,`tanggal_kirim` date
,`keterangan` varchar(255)
,`status_pelaksanaan_id` int(11)
,`status_pelaksanaan` varchar(100)
,`waktu` bigint(21)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `v_suratmasuk`
--
CREATE TABLE IF NOT EXISTS `v_suratmasuk` (
`register_id` bigint(20)
,`klasifikasi_surat_id` int(11)
,`klasifikasi_surat` varchar(100)
,`jenis_surat_id` int(11)
,`jenis_surat` varchar(100)
,`tahun_register` int(4)
,`tanggal_register` date
,`tanggal_surat` date
,`nomor_index` int(11)
,`nomor_agenda` varchar(100)
,`nomor_surat` varchar(100)
,`pengirim` varchar(255)
,`tujuan_id` int(11)
,`tujuan` varchar(255)
,`tujuan_disposisi_dari_nama` varchar(255)
,`tujuan_disposisi_dari_jabatan` varchar(255)
,`tujuan_disposisi_tanggal` date
,`tujuan_disposisi_id` bigint(11)
,`tujuan_disposisi_nama` varchar(255)
,`tujuan_disposisi_jabatan_id` bigint(11)
,`tujuan_disposisi_keterangan` varchar(255)
,`perihal` varchar(500)
,`dokumen_elektronik` varchar(255)
,`status_pelaksanaan_id` int(11)
,`status_pelaksanaan` varchar(100)
,`keterangan` varchar(255)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `v_tahun_penggeledahan`
--
CREATE TABLE IF NOT EXISTS `v_tahun_penggeledahan` (
`tahun_register` int(4)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `v_tahun_penyitaan`
--
CREATE TABLE IF NOT EXISTS `v_tahun_penyitaan` (
`tahun_register` int(4)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `v_tahun_suratkeluar`
--
CREATE TABLE IF NOT EXISTS `v_tahun_suratkeluar` (
`tahun_register` int(4)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `v_tahun_suratketerangan`
--
CREATE TABLE IF NOT EXISTS `v_tahun_suratketerangan` (
`tahun_register` int(4)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `v_tahun_suratmasuk`
--
CREATE TABLE IF NOT EXISTS `v_tahun_suratmasuk` (
`tahun_register` int(4)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `v_tujuan_surat`
--
CREATE TABLE IF NOT EXISTS `v_tujuan_surat` (
`group_id` int(11)
,`group_name` varchar(255)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `v_users`
--
CREATE TABLE IF NOT EXISTS `v_users` (
`userid` int(11)
,`pegawai_id` int(11)
,`fullname` varchar(255)
,`username` varchar(30)
,`password` varchar(100)
,`old_password` varchar(400)
,`email` varchar(100)
,`alternative_email` varchar(255)
,`allow_concurrent_login` tinyint(1)
,`has_change_password` tinyint(1)
,`enable_change_password` tinyint(1)
,`last_change_password` datetime
,`password_expired_remainder` int(11)
,`attemp_count` int(11)
,`attemp_time` datetime
,`user_expired` datetime
,`last_login` datetime
,`block` tinyint(1)
,`activation` varchar(100)
,`code_activation` varchar(100)
,`params` text
,`lock_by` varchar(30)
,`lock_on` datetime
,`created_by` varchar(30)
,`created_on` datetime
,`modified_by` varchar(30)
,`modified_on` datetime
,`group_id` text
,`group_name` text
,`group_lft` bigint(11)
,`group_lvl` int(3) unsigned
,`group_rgt` bigint(11)
);
-- --------------------------------------------------------

--
-- Structure for view `v_groups`
--
DROP TABLE IF EXISTS `v_groups`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_groups` AS select `sys_groups`.`groupid` AS `group_id`,`getTreeName`((`sys_groups`.`level` - 2),`sys_groups`.`name`) AS `group_name` from `sys_groups` where ((`sys_groups`.`enable` = 1) and (`sys_groups`.`lft` > 2) and (`sys_groups`.`rgt` <= 1000) and (`sys_groups`.`groupid` >= 2) and (`sys_groups`.`inter_exter` = 1)) order by `sys_groups`.`lft`;

-- --------------------------------------------------------

--
-- Structure for view `v_groups_struktural`
--
DROP TABLE IF EXISTS `v_groups_struktural`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_groups_struktural` AS select `a`.`groupid` AS `groupid`,`getTreeName`((`a`.`level` - 2),`a`.`name`) AS `group_name`,`getTreeName`((`a`.`level` - 2),`a`.`description`) AS `bagian`,`b`.`id` AS `pegawai_id`,`b`.`nip` AS `nip`,`b`.`nama_gelar` AS `nama` from (`sys_groups` `a` left join `pegawai` `b` on((`b`.`jabatan_id` = `a`.`groupid`))) where (`a`.`groupid` in (2,3,4,5,6,7,8,9,10,11,12,13,14,16,17,18,19));

-- --------------------------------------------------------

--
-- Structure for view `v_pelaksanaan_suratkeluar`
--
DROP TABLE IF EXISTS `v_pelaksanaan_suratkeluar`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_pelaksanaan_suratkeluar` AS select `register_surat`.`tanggal_register` AS `tanggal_register`,year(`register_surat`.`tanggal_register`) AS `tahun_register`,`register_surat`.`nomor_surat` AS `nomor_surat`,`register_surat`.`tujuan` AS `tujuan`,(case when (`register_surat`.`tanggal_kirim` is not null) then timestampdiff(DAY,`register_surat`.`tanggal_register`,`register_surat`.`tanggal_kirim`) else timestampdiff(DAY,`register_surat`.`tanggal_register`,now()) end) AS `waktu` from `register_surat` where ((`register_surat`.`klasifikasi_surat_id` = '2') and isnull(`register_surat`.`tanggal_kirim`));

-- --------------------------------------------------------

--
-- Structure for view `v_pelaksanaan_suratmasuk`
--
DROP TABLE IF EXISTS `v_pelaksanaan_suratmasuk`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_pelaksanaan_suratmasuk` AS select `register_surat`.`tanggal_register` AS `tanggal_register`,year(`register_surat`.`tanggal_register`) AS `tahun_register`,`register_surat`.`nomor_surat` AS `nomor_surat`,`register_surat`.`pengirim` AS `pengirim`,`register_surat`.`perihal` AS `perihal`,(select `register_pelaksanaan`.`kepada_fullname` from `register_pelaksanaan` where (`register_pelaksanaan`.`register_id` = `register_surat`.`register_id`) order by `register_pelaksanaan`.`pelaksanaan_id` desc limit 0,1) AS `tujuan_disposisi_nama`,(select `register_pelaksanaan`.`kepada_jabatan` from `register_pelaksanaan` where (`register_pelaksanaan`.`register_id` = `register_surat`.`register_id`) order by `register_pelaksanaan`.`pelaksanaan_id` desc limit 0,1) AS `tujuan_disposisi_jabatan` from `register_surat` where ((`register_surat`.`klasifikasi_surat_id` = '1') and (`register_surat`.`status_pelaksanaan_id` <> '20')) order by `register_surat`.`tanggal_register` desc;

-- --------------------------------------------------------

--
-- Structure for view `v_suratkeluar`
--
DROP TABLE IF EXISTS `v_suratkeluar`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_suratkeluar` AS select `register_surat`.`register_id` AS `register_id`,`register_surat`.`klasifikasi_surat_id` AS `klasifikasi_surat_id`,`register_surat`.`klasifikasi_surat` AS `klasifikasi_surat`,`register_surat`.`jenis_surat_id` AS `jenis_surat_id`,`register_surat`.`jenis_surat` AS `jenis_surat`,year(`register_surat`.`tanggal_register`) AS `tahun_register`,`register_surat`.`tanggal_register` AS `tanggal_register`,`register_surat`.`nomor_index` AS `nomor_index`,`register_surat`.`nomor_surat` AS `nomor_surat`,`register_surat`.`pengirim_id` AS `pengirim_id`,`register_surat`.`pengirim` AS `pengirim`,`register_surat`.`tujuan_id` AS `tujuan_id`,`register_surat`.`tujuan_satker_id` AS `tujuan_satker_id`,`register_surat`.`tujuan` AS `tujuan`,`register_surat`.`perihal` AS `perihal`,`register_surat`.`jenis_ekspedisi_id` AS `jenis_ekspedisi_id`,`register_surat`.`jenis_ekspedisi` AS `jenis_ekspedisi`,`register_surat`.`dokumen_elektronik` AS `dokumen_elektronik`,`register_surat`.`tanggal_kirim` AS `tanggal_kirim`,`register_surat`.`keterangan` AS `keterangan`,`register_surat`.`status_pelaksanaan_id` AS `status_pelaksanaan_id`,`register_surat`.`status_pelaksanaan` AS `status_pelaksanaan`,(case when (`register_surat`.`tanggal_kirim` is not null) then timestampdiff(DAY,`register_surat`.`tanggal_register`,`register_surat`.`tanggal_kirim`) else timestampdiff(DAY,`register_surat`.`tanggal_register`,now()) end) AS `waktu` from `register_surat` where (`register_surat`.`klasifikasi_surat_id` = '2');

-- --------------------------------------------------------

--
-- Structure for view `v_suratmasuk`
--
DROP TABLE IF EXISTS `v_suratmasuk`;

CREATE ALGORITHM=TEMPTABLE DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_suratmasuk` AS select `register_surat`.`register_id` AS `register_id`,`register_surat`.`klasifikasi_surat_id` AS `klasifikasi_surat_id`,`register_surat`.`klasifikasi_surat` AS `klasifikasi_surat`,`register_surat`.`jenis_surat_id` AS `jenis_surat_id`,`register_surat`.`jenis_surat` AS `jenis_surat`,year(`register_surat`.`tanggal_register`) AS `tahun_register`,`register_surat`.`tanggal_register` AS `tanggal_register`,`register_surat`.`tanggal_surat` AS `tanggal_surat`,`register_surat`.`nomor_index` AS `nomor_index`,`register_surat`.`nomor_agenda` AS `nomor_agenda`,`register_surat`.`nomor_surat` AS `nomor_surat`,`register_surat`.`pengirim` AS `pengirim`,`register_surat`.`tujuan_id` AS `tujuan_id`,`register_surat`.`tujuan` AS `tujuan`,(select `register_pelaksanaan`.`dari_fullname` from `register_pelaksanaan` where (`register_pelaksanaan`.`register_id` = `register_surat`.`register_id`) order by `register_pelaksanaan`.`pelaksanaan_id` desc limit 0,1) AS `tujuan_disposisi_dari_nama`,(select `register_pelaksanaan`.`dari_jabatan` from `register_pelaksanaan` where (`register_pelaksanaan`.`register_id` = `register_surat`.`register_id`) order by `register_pelaksanaan`.`pelaksanaan_id` desc limit 0,1) AS `tujuan_disposisi_dari_jabatan`,(select `register_pelaksanaan`.`tanggal_pelaksanaan` from `register_pelaksanaan` where (`register_pelaksanaan`.`register_id` = `register_surat`.`register_id`) order by `register_pelaksanaan`.`pelaksanaan_id` desc limit 0,1) AS `tujuan_disposisi_tanggal`,(select `register_pelaksanaan`.`kepada_userid` from `register_pelaksanaan` where (`register_pelaksanaan`.`register_id` = `register_surat`.`register_id`) order by `register_pelaksanaan`.`pelaksanaan_id` desc limit 0,1) AS `tujuan_disposisi_id`,(select `register_pelaksanaan`.`kepada_fullname` from `register_pelaksanaan` where (`register_pelaksanaan`.`register_id` = `register_surat`.`register_id`) order by `register_pelaksanaan`.`pelaksanaan_id` desc limit 0,1) AS `tujuan_disposisi_nama`,(select `register_pelaksanaan`.`kepada_jabatan_id` from `register_pelaksanaan` where (`register_pelaksanaan`.`register_id` = `register_surat`.`register_id`) order by `register_pelaksanaan`.`pelaksanaan_id` desc limit 0,1) AS `tujuan_disposisi_jabatan_id`,(select `register_pelaksanaan`.`keterangan` from `register_pelaksanaan` where (`register_pelaksanaan`.`register_id` = `register_surat`.`register_id`) order by `register_pelaksanaan`.`pelaksanaan_id` desc limit 0,1) AS `tujuan_disposisi_keterangan`,`register_surat`.`perihal` AS `perihal`,`register_surat`.`dokumen_elektronik` AS `dokumen_elektronik`,`register_surat`.`status_pelaksanaan_id` AS `status_pelaksanaan_id`,`register_surat`.`status_pelaksanaan` AS `status_pelaksanaan`,`register_surat`.`keterangan` AS `keterangan` from `register_surat` where (`register_surat`.`klasifikasi_surat_id` = '1');

-- --------------------------------------------------------

--
-- Structure for view `v_tahun_penggeledahan`
--
DROP TABLE IF EXISTS `v_tahun_penggeledahan`;

CREATE ALGORITHM=TEMPTABLE DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_tahun_penggeledahan` AS select distinct year(`register_penggeledahan`.`tanggal_register`) AS `tahun_register` from `register_penggeledahan`;

-- --------------------------------------------------------

--
-- Structure for view `v_tahun_penyitaan`
--
DROP TABLE IF EXISTS `v_tahun_penyitaan`;

CREATE ALGORITHM=TEMPTABLE DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_tahun_penyitaan` AS select distinct year(`register_penyitaan`.`tanggal_register`) AS `tahun_register` from `register_penyitaan`;

-- --------------------------------------------------------

--
-- Structure for view `v_tahun_suratkeluar`
--
DROP TABLE IF EXISTS `v_tahun_suratkeluar`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_tahun_suratkeluar` AS select distinct year(`register_surat`.`tanggal_register`) AS `tahun_register` from `register_surat` where (`register_surat`.`klasifikasi_surat_id` = '2');

-- --------------------------------------------------------

--
-- Structure for view `v_tahun_suratketerangan`
--
DROP TABLE IF EXISTS `v_tahun_suratketerangan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_tahun_suratketerangan` AS select distinct year(`register_surat_keterangan`.`tanggal_register`) AS `tahun_register` from `register_surat_keterangan`;

-- --------------------------------------------------------

--
-- Structure for view `v_tahun_suratmasuk`
--
DROP TABLE IF EXISTS `v_tahun_suratmasuk`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_tahun_suratmasuk` AS select distinct year(`register_surat`.`tanggal_register`) AS `tahun_register` from `register_surat` where (`register_surat`.`klasifikasi_surat_id` = '1');

-- --------------------------------------------------------

--
-- Structure for view `v_tujuan_surat`
--
DROP TABLE IF EXISTS `v_tujuan_surat`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_tujuan_surat` AS select `ref_tujuan_surat`.`groupid` AS `group_id`,`getTreeName`((`ref_tujuan_surat`.`level` - 1),`ref_tujuan_surat`.`name`) AS `group_name` from `ref_tujuan_surat` where ((`ref_tujuan_surat`.`enable` = 1) and (`ref_tujuan_surat`.`lft` >= 1) and (`ref_tujuan_surat`.`rgt` <= 1000) and (`ref_tujuan_surat`.`groupid` >= 1)) order by `ref_tujuan_surat`.`lft`;

-- --------------------------------------------------------

--
-- Structure for view `v_users`
--
DROP TABLE IF EXISTS `v_users`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_users` AS select `sys_users`.`userid` AS `userid`,`sys_users`.`pegawai_id` AS `pegawai_id`,`sys_users`.`fullname` AS `fullname`,`sys_users`.`username` AS `username`,`sys_users`.`password` AS `password`,`sys_users`.`old_password` AS `old_password`,`sys_users`.`email` AS `email`,`sys_users`.`alternative_email` AS `alternative_email`,`sys_users`.`allow_concurrent_login` AS `allow_concurrent_login`,`sys_users`.`has_change_password` AS `has_change_password`,`sys_users`.`enable_change_password` AS `enable_change_password`,`sys_users`.`last_change_password` AS `last_change_password`,`sys_users`.`password_expired_remainder` AS `password_expired_remainder`,`sys_users`.`attemp_count` AS `attemp_count`,`sys_users`.`attemp_time` AS `attemp_time`,`sys_users`.`user_expired` AS `user_expired`,`sys_users`.`last_login` AS `last_login`,`sys_users`.`block` AS `block`,`sys_users`.`activation` AS `activation`,`sys_users`.`code_activation` AS `code_activation`,`sys_users`.`params` AS `params`,`sys_users`.`lock_by` AS `lock_by`,`sys_users`.`lock_on` AS `lock_on`,`sys_users`.`created_by` AS `created_by`,`sys_users`.`created_on` AS `created_on`,`sys_users`.`modified_by` AS `modified_by`,`sys_users`.`modified_on` AS `modified_on`,(select group_concat(cast(`sys_user_group`.`groupid` as char(4) charset latin1) order by `sys_user_group`.`groupid` ASC separator ', ') AS `groupid` from `sys_user_group` where (`sys_user_group`.`userid` = `sys_users`.`userid`)) AS `group_id`,(select group_concat(`sys_groups`.`name` order by `sys_user_group`.`groupid` ASC separator ', ') AS `groupname` from (`sys_user_group` left join `sys_groups` on((`sys_user_group`.`groupid` = `sys_groups`.`groupid`))) where (`sys_user_group`.`userid` = `sys_users`.`userid`)) AS `group_name`,(select min(`sys_groups`.`lft`) AS `grplft` from (`sys_user_group` left join `sys_groups` on((`sys_user_group`.`groupid` = `sys_groups`.`groupid`))) where (`sys_user_group`.`userid` = `sys_users`.`userid`)) AS `group_lft`,(select min(`sys_groups`.`level`) AS `grplvl` from (`sys_user_group` left join `sys_groups` on((`sys_user_group`.`groupid` = `sys_groups`.`groupid`))) where (`sys_user_group`.`userid` = `sys_users`.`userid`)) AS `group_lvl`,(select max(`sys_groups`.`rgt`) AS `grprgt` from (`sys_user_group` left join `sys_groups` on((`sys_user_group`.`groupid` = `sys_groups`.`groupid`))) where (`sys_user_group`.`userid` = `sys_users`.`userid`)) AS `group_rgt` from `sys_users`;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `agama`
--
ALTER TABLE `agama`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `nama` (`nama`), ADD KEY `aktif` (`aktif`), ADD KEY `diinput_tanggal` (`diinput_tanggal`), ADD KEY `diperbaharui_tanggal` (`diperbaharui_tanggal`);

--
-- Indexes for table `jenis_identitas`
--
ALTER TABLE `jenis_identitas`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pegawai`
--
ALTER TABLE `pegawai`
 ADD PRIMARY KEY (`id`), ADD KEY `nama` (`nama`), ADD KEY `nip` (`nip`), ADD KEY `nama_gelar` (`nama_gelar`), ADD KEY `aktif` (`aktif`), ADD KEY `diinput_tanggal` (`diinput_tanggal`), ADD KEY `diperbaharui_tanggal` (`diperbaharui_tanggal`);

--
-- Indexes for table `pengadilan_negeri`
--
ALTER TABLE `pengadilan_negeri`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `pn_index` (`id`,`nama`), ADD UNIQUE KEY `pt_pn_index` (`id`,`pt_id`,`nama`), ADD KEY `aktif` (`aktif`), ADD KEY `pt_id` (`pt_id`);

--
-- Indexes for table `pengadilan_tinggi`
--
ALTER TABLE `pengadilan_tinggi`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `nama` (`nama`), ADD KEY `aktif` (`aktif`);

--
-- Indexes for table `pihak`
--
ALTER TABLE `pihak`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ref_instruksi`
--
ALTER TABLE `ref_instruksi`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ref_jenis_surat`
--
ALTER TABLE `ref_jenis_surat`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ref_jenis_surat_keterangan`
--
ALTER TABLE `ref_jenis_surat_keterangan`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ref_pangkat`
--
ALTER TABLE `ref_pangkat`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ref_pengiriman`
--
ALTER TABLE `ref_pengiriman`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ref_penomoran`
--
ALTER TABLE `ref_penomoran`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ref_tujuan_surat`
--
ALTER TABLE `ref_tujuan_surat`
 ADD PRIMARY KEY (`groupid`), ADD UNIQUE KEY `idx_groups_parent_title_lookup` (`parent_id`,`name`), ADD KEY `idx_groups_title_lookup` (`name`), ADD KEY `idx_groups_adjacency_lookup` (`parent_id`), ADD KEY `level` (`level`), ADD KEY `ordering` (`ordering`), ADD KEY `idx_groups_nested_set_lookup` (`lft`,`rgt`);

--
-- Indexes for table `register_pelaksanaan`
--
ALTER TABLE `register_pelaksanaan`
 ADD PRIMARY KEY (`pelaksanaan_id`,`register_id`);

--
-- Indexes for table `register_penggeledahan`
--
ALTER TABLE `register_penggeledahan`
 ADD PRIMARY KEY (`register_id`);

--
-- Indexes for table `register_penyitaan`
--
ALTER TABLE `register_penyitaan`
 ADD PRIMARY KEY (`register_id`);

--
-- Indexes for table `register_surat`
--
ALTER TABLE `register_surat`
 ADD PRIMARY KEY (`register_id`,`klasifikasi_surat_id`);

--
-- Indexes for table `register_surat_keterangan`
--
ALTER TABLE `register_surat_keterangan`
 ADD PRIMARY KEY (`register_id`);

--
-- Indexes for table `sys_audittrail`
--
ALTER TABLE `sys_audittrail`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `sys_config`
--
ALTER TABLE `sys_config`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `sys_groups`
--
ALTER TABLE `sys_groups`
 ADD PRIMARY KEY (`groupid`), ADD UNIQUE KEY `idx_groups_parent_title_lookup` (`parent_id`,`name`), ADD KEY `idx_groups_title_lookup` (`name`), ADD KEY `idx_groups_adjacency_lookup` (`parent_id`), ADD KEY `level` (`level`), ADD KEY `ordering` (`ordering`), ADD KEY `idx_groups_nested_set_lookup` (`lft`,`rgt`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
