-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 14 Apr 2022 pada 11.38
-- Versi server: 10.1.38-MariaDB
-- Versi PHP: 5.6.40

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `amsal`
--

DELIMITER $$
--
-- Fungsi
--
CREATE DEFINER=`root`@`localhost` FUNCTION `getTreeName` (`var_level` INTEGER(11), `var_nama` VARCHAR(150)) RETURNS VARCHAR(255) CHARSET latin1 BEGIN
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
-- Struktur dari tabel `agama`
--

CREATE TABLE `agama` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'Primary key (by system)',
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
-- Dumping data untuk tabel `agama`
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
-- Struktur dari tabel `jenis_identitas`
--

CREATE TABLE `jenis_identitas` (
  `id` tinyint(4) NOT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `diinput_oleh` varchar(30) DEFAULT NULL,
  `diinput_tanggal` datetime DEFAULT NULL,
  `diperbaharui_oleh` varchar(30) DEFAULT NULL,
  `diperbaharui_tanggal` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `jenis_identitas`
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
-- Struktur dari tabel `pegawai`
--

CREATE TABLE `pegawai` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'Primary key: (by system)',
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
  `chatid` varchar(50) DEFAULT NULL,
  `status_pegawai` tinyint(1) DEFAULT NULL,
  `diinput_oleh` varchar(30) DEFAULT '' COMMENT 'Diinput Oleh: (by system)',
  `diinput_tanggal` datetime DEFAULT NULL COMMENT 'Diinput Tanggal: (by system)',
  `diperbaharui_oleh` varchar(30) DEFAULT '' COMMENT 'Diperbaharui Oleh: (by system)',
  `diperbaharui_tanggal` datetime DEFAULT NULL COMMENT 'Diperbaharui Tanggal: (by system)'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Referensi Panitera Pengadilan Negeri';

--
-- Dumping data untuk tabel `pegawai`
--

INSERT INTO `pegawai` (`id`, `nip`, `nama`, `nama_gelar`, `golongan_id`, `golongan`, `pangkat`, `alamat`, `keterangan`, `aktif`, `foto`, `jabatan_id`, `jabatan_nama`, `chatid`, `status_pegawai`, `diinput_oleh`, `diinput_tanggal`, `diperbaharui_oleh`, `diperbaharui_tanggal`) VALUES
(1, '196105011988031002', '', 'Drs. H. Zulkifli Yus, S.H., M.H.', 18, 'IV/e', 'Pembina Utama', 'Banda Aceh', '', 'Y', NULL, 2, 'Ketua', '5374955751', 0, 'admin', '2021-08-04 03:29:18', 'admin', '2022-04-14 08:17:08'),
(2, '196202101994031003', '', 'Drs. Syafruddin, M.H.', 17, 'IV/d', 'Pembina Utama Madya', 'Banda Aceh', '', 'Y', NULL, 4, 'Panitera', NULL, 0, 'admin', '2021-08-04 03:30:14', 'admin', '2022-04-14 08:18:00'),
(4, '196507311994031003', '', 'Abd. Latif, S.H, M.H.', 14, 'IV/a', 'Pembina', 'Banda Aceh', '', 'Y', NULL, 6, 'Panitera Muda Banding', NULL, 0, 'admin', '2021-08-04 04:13:43', 'admin', '2021-08-04 04:51:33'),
(5, '196711121990121001', '', 'Bahrun, S.H., M.H.', 14, 'III/d', 'Penata Tingkat I', 'Banda Aceh', '', 'Y', NULL, 19, 'Kepala Sub Bagian Tata Usaha dan Rumah Tangga', NULL, 0, 'admin', '2021-08-04 04:14:13', '', NULL),
(6, '196708121994031007	', '', 'H. Hilman Lubis, S.H., M.H.', 17, 'IV/c', 'Pembina Utama Muda', 'Banda Aceh', '', 'Y', NULL, 16, 'Sekretaris', '904668492', 0, 'admin', '2021-08-04 04:50:09', '', NULL),
(7, '196202101994031003', '', 'Drs. Ilyas, S.H., M.H', 14, 'IV/a', 'Pembina', 'Banda Aceh', '', 'Y', NULL, 7, 'Panitera Muda Hukum', '844068325', 0, 'admin', '2021-08-04 04:51:17', 'admin', '2021-08-04 04:51:39'),
(8, '196810131997032001', '', 'Ratna Juita, S.Ag., S.H., M.H.', 14, 'IV/a', 'Pembina', 'Banda Aceh', '', 'Y', NULL, 5, 'Panitera Muda Jinayat', NULL, 0, 'admin', '2021-08-04 04:52:01', '', NULL),
(9, '197404061994031001', '', 'Mirza, S.H., M.H.', 15, 'IV/b', 'Pembina Tingkat I', 'Banda Aceh', '', 'Y', NULL, 31, 'Kabag Umum dan Keuangan', '819396842', 0, 'admin', '2022-04-12 08:20:28', '', NULL),
(10, '197404072006041002', '', 'Fahmi Riswin, S.E.Ak.', 13, 'III/d', 'Penata Tingkat I', 'Banda Aceh', '', 'Y', NULL, 18, 'Kepala Sub Bagian Renprog', NULL, 0, 'admin', '2022-04-12 08:25:55', 'admin', '2022-04-14 10:52:05'),
(11, '198408142007041001', '', 'Jainal Tabrani, S.H., M.H.', 13, 'III/d', 'Penata Tingkat I', 'Banda Aceh', '', 'Y', NULL, 17, 'Kepala Sub Bagian Kepegawaian dan TI', NULL, 0, 'admin', '2022-04-12 08:27:37', '', NULL),
(12, '198512292009122003', '', 'Yani Riyanti, S.E., M.Si.', 13, 'III/d', 'Penata Tingkat I', 'Banda Aceh', '', 'Y', NULL, 30, 'Kepala Sub Bagian Keuangan dan Pelaporan', NULL, 0, 'admin', '2022-04-12 08:50:29', '', NULL),
(13, '197607262006042003', '', 'Yosi Dirola, S.E.', 13, 'III/d', 'Penata Tingkat I', 'Banda Aceh', '', 'Y', NULL, 25, 'Pengelola Keuangan', NULL, 0, 'admin', '2022-04-12 08:52:59', '', NULL),
(14, '197905012009122001', '', 'Isnawati, S.E.', 12, 'III/c', 'Penata', 'Banda Aceh', '', 'Y', NULL, 25, 'Pengelola Keuangan', NULL, 0, 'admin', '2022-04-12 08:54:30', '', NULL),
(15, '198106102010032002', '', 'Monik Zarinah, SE, M.Si.', 12, 'III/c', 'Penata', 'Banda Aceh', '', 'Y', NULL, 25, 'Pengelola Keuangan', NULL, 0, 'admin', '2022-04-12 08:55:25', '', NULL),
(16, '198709122009041002', '', 'Armada, S.E.', 11, 'III/b', 'Penata Muda Tingkat I', 'Banda Aceh', '', 'Y', NULL, 25, 'Pengelola Keuangan', NULL, 0, 'admin', '2022-04-12 08:56:02', '', NULL),
(17, '198211232009041002', '', 'Denny Kurniawan, S.T.', 13, 'III/d', 'Penata Tingkat I', 'Banda Aceh', '', 'Y', NULL, 26, 'Pranata Keuangan', NULL, 0, 'admin', '2022-04-12 08:56:56', '', NULL),
(18, '198212012009121004', '', 'Mohd Hanafi, S.H.I.', 12, 'III/c', 'Penata', 'Banda Aceh', '', 'Y', NULL, 26, 'Pranata Keuangan', NULL, 0, 'admin', '2022-04-12 08:57:40', '', NULL),
(19, '198007132006041002', '', 'Muhammad Kadri, S.T.', 12, 'III/c', 'Penata', 'Banda Aceh', '', 'Y', NULL, 24, 'Pranata Komputer', NULL, 0, 'admin', '2022-04-12 09:00:11', '', NULL),
(20, '198312122011011011', '', 'Heri Irawan, A.Md.', 10, 'III/a', 'Penata Muda', 'Banda Aceh', '', 'Y', NULL, 24, 'Pranata Komputer', NULL, 0, 'admin', '2022-04-12 09:01:09', '', NULL),
(21, '196202021993031003', '', 'Drs. A Murad, M.H.', 15, 'IV/b', 'Pembina Tingkat I', 'Banda Aceh', '', 'Y', NULL, 8, 'Panitera Pengganti', NULL, 0, 'admin', '2022-04-12 09:02:22', '', NULL),
(22, '401582', '', 'Mahkamah Syar\'iyah Banda Aceh', 99, 'Pegawai Tidak Tetap', 'Pegawai Tidak Tetap (PTT)', 'Banda Aceh', '', 'Y', NULL, 40, 'Operator Satker', '', 1, '', NULL, 'admin', '2022-04-14 11:00:01'),
(23, '401584', '', 'Mahkamah Syar\'iyah Jantho', 99, 'Pegawai Tidak Tetap', 'Pegawai Tidak Tetap (PTT)', 'Aceh', '', 'Y', NULL, 40, 'Operator Satker', '', 1, '', NULL, 'admin', '2022-04-14 10:59:39'),
(26, '-', '', 'Mahkamah Syar\'iyah Sigli', 99, 'Pegawai Tidak Tetap', 'Pegawai Tidak Tetap (PTT)', 'Aceh', '', 'Y', NULL, 40, 'Operator Satker', '', NULL, 'admin', '2022-04-14 10:59:14', '', NULL),
(27, '-', '', 'Mahkamah Syar\'iyah Bireuen', 99, 'Pegawai Tidak Tetap', 'Pegawai Tidak Tetap (PTT)', 'Aceh', '', 'Y', NULL, 40, 'Operator Satker', '', NULL, 'admin', '2022-04-14 11:00:47', '', NULL),
(28, '-', '', 'Mahkamah Syar\'iyah Meureudeu', 99, 'Pegawai Tidak Tetap', 'Pegawai Tidak Tetap (PTT)', 'Aceh', '', 'Y', NULL, 40, 'Operator Satker', '', NULL, 'admin', '2022-04-14 11:01:27', '', NULL),
(29, '-', '', 'Mahkamah Syar\'iyah Lhokseumawe', 99, 'Pegawai Tidak Tetap', 'Pegawai Tidak Tetap (PTT)', 'Aceh', '', 'Y', NULL, 40, 'Operator Satker', '', NULL, 'admin', '2022-04-14 11:02:05', '', NULL),
(30, '-', '', 'Mahkamah Syar\'iyah Lhoksukon', 99, 'Pegawai Tidak Tetap', 'Pegawai Tidak Tetap (PTT)', 'Aceh', '', 'Y', NULL, 40, 'Operator Satker', '', NULL, 'admin', '2022-04-14 11:02:52', '', NULL),
(31, '-', '', 'Mahkamah Syar\'iyah Idi', 99, 'Pegawai Tidak Tetap', 'Pegawai Tidak Tetap (PTT)', 'Aceh', '', 'Y', NULL, 40, 'Operator Satker', '', NULL, 'admin', '2022-04-14 11:03:40', '', NULL),
(32, '-', '', 'Mahkamah Syar\'iyah Langsa', 99, 'Pegawai Tidak Tetap', 'Pegawai Tidak Tetap (PTT)', 'Aceh', '', 'Y', NULL, 40, 'Operator Satker', '', NULL, 'admin', '2022-04-14 11:04:28', '', NULL),
(33, '-', '', 'Mahkamah Syar\'iyah Kuala Simpang', 99, 'Pegawai Tidak Tetap', 'Pegawai Tidak Tetap (PTT)', 'Aceh', '', 'Y', NULL, 40, 'Operator Satker', '', NULL, 'admin', '2022-04-14 11:05:33', '', NULL),
(34, '-', '', 'Mahkamah Syar\'iyah Kutacane', 99, 'Pegawai Tidak Tetap', 'Pegawai Tidak Tetap (PTT)', 'Aceh', '', 'Y', NULL, 40, 'Operator Satker', '', NULL, 'admin', '2022-04-14 11:06:20', '', NULL),
(35, '-', '', 'Mahkamah Syar\'iyah Blangkejeren', 99, 'Pegawai Tidak Tetap', 'Pegawai Tidak Tetap (PTT)', 'Aceh', '', 'Y', NULL, 40, 'Operator Satker', '', NULL, 'admin', '2022-04-14 11:07:11', '', NULL),
(36, '-', '', 'Mahkamah Syar\'iyah Takengon', 99, 'Pegawai Tidak Tetap', 'Pegawai Tidak Tetap (PTT)', 'Aceh', '', 'Y', NULL, 40, 'Operator Satker', '', NULL, 'admin', '2022-04-14 11:07:44', '', NULL),
(37, '-', '', 'Mahkamah Syar\'iyah Simpang Tiga Redelong', 99, 'Pegawai Tidak Tetap', 'Pegawai Tidak Tetap (PTT)', 'Aceh', '', 'Y', NULL, 40, 'Operator Satker', '', NULL, 'admin', '2022-04-14 11:08:28', '', NULL),
(38, '-', '', 'Mahkamah Syar\'iyah Calang', 99, 'Pegawai Tidak Tetap', 'Pegawai Tidak Tetap (PTT)', 'Aceh', '', 'Y', NULL, 40, 'Operator Satker', '', NULL, 'admin', '2022-04-14 11:08:56', '', NULL),
(39, '-', '', 'Mahkamah Syar\'iyah Meulaboh', 99, 'Pegawai Tidak Tetap', 'Pegawai Tidak Tetap (PTT)', 'Aceh', '', 'Y', NULL, 40, 'Operator Satker', '', NULL, 'admin', '2022-04-14 11:09:24', '', NULL),
(40, '401966', '', 'Mahkamah Syar\'iyah Suka Makmue', 99, 'Pegawai Tidak Tetap', 'Pegawai Tidak Tetap (PTT)', 'Aceh', '', 'Y', NULL, 40, 'Operator Satker', '', NULL, 'admin', '2022-04-14 11:10:07', '', NULL),
(41, '401965', '', 'Mahkamah Syar\'iyah Blangpidie', 99, 'Pegawai Tidak Tetap', 'Pegawai Tidak Tetap (PTT)', 'Aceh', '', 'Y', NULL, 40, 'Operator Satker', '', NULL, 'admin', '2022-04-14 11:10:32', '', NULL),
(42, '401968', '', 'Mahkamah Syar\'iyah Tapaktuan', 99, 'Pegawai Tidak Tetap', 'Pegawai Tidak Tetap (PTT)', 'Aceh', '', 'Y', NULL, 40, 'Operator Satker', '', NULL, 'admin', '2022-04-14 11:11:17', '', NULL),
(43, '401967', '', 'Mahkamah Syar\'iyah Kota Subulussalam', 99, 'Pegawai Tidak Tetap', 'Pegawai Tidak Tetap (PTT)', 'Aceh', '', 'Y', NULL, 40, 'Operator Satker', '', NULL, 'admin', '2022-04-14 11:11:44', '', NULL),
(44, '-', '', 'Mahkamah Syar\'iyah Singkil', 99, 'Pegawai Tidak Tetap', 'Pegawai Tidak Tetap (PTT)', 'Aceh', '', 'Y', NULL, 40, 'Operator Satker', '', NULL, 'admin', '2022-04-14 11:12:08', '', NULL),
(45, '-', '', 'Mahkamah Syar\'iyah Sinabang', 99, 'Pegawai Tidak Tetap', 'Pegawai Tidak Tetap (PTT)', 'Aceh', '', 'Y', NULL, 40, 'Operator Satker', '', NULL, 'admin', '2022-04-14 11:12:50', '', NULL),
(46, '-', '', 'Mahkamah Syar\'iyah Sabang', 99, 'Pegawai Tidak Tetap', 'Pegawai Tidak Tetap (PTT)', 'Aceh', '', 'Y', NULL, 40, 'Operator Satker', '', NULL, 'admin', '2022-04-14 11:13:24', '', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pengadilan_negeri`
--

CREATE TABLE `pengadilan_negeri` (
  `id` int(11) UNSIGNED NOT NULL,
  `pt_id` int(11) UNSIGNED DEFAULT NULL,
  `kode` varchar(50) DEFAULT NULL,
  `kode_pn` varchar(20) DEFAULT NULL,
  `nama` varchar(100) NOT NULL,
  `alamat` varchar(500) DEFAULT NULL,
  `aktif` char(1) NOT NULL DEFAULT 'Y',
  `jenis_pengadilan` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `pengadilan_negeri`
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
(605, 60, '401591', 'MS.Bna', 'MAHKAMAH SYAR\'IYAH BANDA ACEH', 'Jl. Soekarno Hatta KM.02 Gampong Mibo, Banda Raya, Banda Aceh', 'Y', 4),
(606, 60, '401633', 'MS.BIR', 'MAHKAMAH SYAR\'IYAH BIREUEN', 'Jln. Banda Aceh - Medan Km. 210 Blang Bladeh, Bireuen', 'Y', 4),
(607, 60, '401709', 'MS.Bkj', 'MAHKAMAH SYAR\'IYAH BLANGKEJEREN', 'Jln. Inen Mayak Teri, Blangkejeren, Kab. Gayo Lues, 24653', 'Y', 4),
(608, 60, '401746', 'MS.Cag', 'MAHKAMAH SYAR\'IYAH CALANG', 'Jln. Pengadilan No. 2 Gampong Blang, Calang, Aceh Jaya', 'Y', 4),
(609, 60, '401670', 'MS.Idi', 'MAHKAMAH SYAR\'IYAH IDI', 'Jln. Banda Aceh-Medan, Km. 381, Paya Gajah, Peureulak Barat, Aceh Timur', 'Y', 4),
(610, 60, '402607', 'MS.Jth', 'MAHKAMAH SYAR\'IYAH JANTHO ', 'Jln. T. Bachtiar P. Polem, SH', 'Y', 4),
(611, 60, '401695', 'MS.KSG', 'MAHKAMAH SYAR\'IYAH KUALA SIMPANG', 'Jln. Sekerak-Kampung Bundar Karang Baru, Komplek Perkantoran Pemkab A. Tamiang', 'Y', 4),
(612, 60, '401715', 'MS.KC', 'MAHKAMAH SYAR\'IYAH KUTACANE', 'Jln. Bedussamad No. 259', 'Y', 4),
(613, 60, '401689', 'MS.Lgs', 'MAHKAMAH SYAR\'IYAH LANGSA', 'Jln. T.M. Bahrum', 'Y', 4),
(614, 60, '401664', 'MS.Lsm', 'MAHKAMAH SYAR\'IYAH LHOKSEUMAWE', 'Jln. Banda Aceh - Medan Desa Alue Awe Kecamatan Muara Dua', 'Y', 4),
(615, 60, '401642', 'MS.Lsk', 'MAHKAMAH SYARI\'YAH LHOKSUKON', 'Jln. Medan- Banda Aceh Gampong Alue Mudem', 'Y', 4),
(616, 60, '401721', 'MS.Mbo', 'MAHKAMAH SYAR\'IYAH MEULABOH', 'Jl. Rahmat Tsunami No. 03 Peunaga Paya, Meureubo - Aceh Barat', 'Y', 4),
(617, 60, '401627', 'MS.Mrd', 'MAHKAMAH SYAR\'IYAH MEUREUDU', 'Komplek Perkantoran Pemkab. Pidie Jaya, Cot Trieng', 'Y', 4),
(618, 60, '401602', 'MS.Sab', 'MAHKAMAH SYAR\'IYAH SABANG', 'Jln. Yossudarso Gp. Cot Ba\'u Kota Sabang', 'Y', 4),
(619, 60, '401611', 'MS.Sgi', 'MAHKAMAH SYAR\'IYAH SIGLI', 'Jln. Lingkar-Blang Paseh Sigli', 'Y', 4),
(620, 60, '401730', 'MS.Snb', 'MAHKAMAH SYAR\'IYAH SINABANG', 'Jln. Tgk. Diujung KM. 5 Desa Suak Buluh, Kecamatan Simeulue Timur, Kabupaten Simeulue', 'Y', 4),
(621, 60, '401752', 'MS.Skl', 'MAHKAMAH SYARI\'YAH SINGKIL', 'Jln. Raya Singkil Rimo KM. 20', 'Y', 4),
(622, 60, '401658', 'MS.Tkn', 'MAHKAMAH SYAR\'IYAH TAKENGON', 'Jln. Lukup Badak, Blang Bebangka Kecamatan Pegasing, Kabupaten Aceh Tengah', 'Y', 4),
(623, 60, '401761', 'MS.Ttn', 'MAHKAMAH SYAR\'IYAH TAPAK TUAN', 'Jln. T. Ben Mahmud, Air Berudang ', 'Y', 4),
(624, 60, '682228', 'MS.STR', 'MAHKAMAH SYAR\'IYAH SIMPANG TIGA REDELONG', 'Jln. Bandara Rembele, Kampung Wonosobo, Kecamatan Wih Pesam, Kabupaten Bener Meriah', 'Y', 4),
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
(762, 60, '401965', 'MS.Bpd', 'MAHKAMAH SYAR\'IYAH BLANGPIDIE', 'Jalan Bukit Hijau, Komplek Perkantoran Aceh Barat Daya', 'Y', 4),
(763, 60, '401966', 'MS.Skm', 'MAHKAMAH SYAR\'IYAH SUKAMAKMUE', 'Jl. Bukit Kantor Nagan Raya', 'Y', 4),
(764, 60, '401968', 'MS.Sus', 'MAHKAMAH SYAR\'IYAH KOTA SUBULUSSALAM', NULL, 'Y', 4);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pengadilan_tinggi`
--

CREATE TABLE `pengadilan_tinggi` (
  `id` int(11) UNSIGNED NOT NULL,
  `kode` varchar(50) DEFAULT NULL,
  `nama` varchar(100) NOT NULL DEFAULT '',
  `alamat` varchar(500) DEFAULT NULL,
  `aktif` char(1) NOT NULL DEFAULT 'Y',
  `jenis_pengadilan` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `pengadilan_tinggi`
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
-- Struktur dari tabel `pihak`
--

CREATE TABLE `pihak` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Primary key (by system)',
  `jenis_pihak_id` tinyint(1) UNSIGNED DEFAULT NULL COMMENT 'Jenis Pihak: merujuk ke tabel jenis_pihak kolom id',
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
  `kabupaten_id` int(11) UNSIGNED DEFAULT NULL COMMENT 'Kabupaten/Kota: merujuk ke tabel kabupaten kolom id',
  `kabupaten` varchar(50) DEFAULT NULL COMMENT 'Kabupaten/Kota: merujuk ke tabel kabupaten kolom nama(by system)',
  `propinsi_id` int(11) UNSIGNED DEFAULT NULL COMMENT 'Propinsi: merujuk ke tabel propinsi kolom id',
  `propinsi` varchar(50) DEFAULT NULL COMMENT 'Propinsi: merujuk ke tabel propinsi kolom nama(by system)',
  `telepon` varchar(50) DEFAULT NULL COMMENT 'Nomor telepon: isian bebas',
  `fax` varchar(50) DEFAULT NULL COMMENT 'Nomor Fax: isian bebas',
  `email` varchar(50) DEFAULT NULL COMMENT 'Alamat email: isan format email',
  `agama_id` int(11) UNSIGNED DEFAULT NULL COMMENT 'Agama: merujuk ke tabel agama kolom id',
  `agama_nama` varchar(50) DEFAULT NULL COMMENT 'Nama Agama: merujuk ke tabel agama kolom nama(by system)',
  `status_kawin` varchar(20) DEFAULT NULL COMMENT 'Statu Kawin: diisi dengan Kawin/Belum Kawin',
  `pekerjaan` varchar(255) DEFAULT NULL COMMENT 'Pekerjaan: isian bebas',
  `pendidikan_id` int(11) UNSIGNED DEFAULT NULL COMMENT 'Id Tingkat Pendidikan Terakhir: merujuk ke tabel tingkat_pendidikan kolom id',
  `pendidikan` varchar(50) DEFAULT NULL COMMENT 'Pendidikan terakhir: merujuk ke tabel pendidikan kolom kode',
  `warga_negara_id` int(11) UNSIGNED DEFAULT NULL COMMENT 'Id Negara: merujuk ke tabel negara kolom id',
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
) ENGINE=InnoDB AVG_ROW_LENGTH=537 DEFAULT CHARSET=latin1 COMMENT='Data Para Pihak';

-- --------------------------------------------------------

--
-- Struktur dari tabel `ref_instruksi`
--

CREATE TABLE `ref_instruksi` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `aktif` tinyint(1) DEFAULT NULL COMMENT '1:ya;2:tidak;'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `ref_instruksi`
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
-- Struktur dari tabel `ref_jenis_surat`
--

CREATE TABLE `ref_jenis_surat` (
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
-- Dumping data untuk tabel `ref_jenis_surat`
--

INSERT INTO `ref_jenis_surat` (`id`, `kode`, `nama`, `keterangan`, `diinput_oleh`, `diinput_tanggal`, `diperbaharui_oleh`, `diperbaharui_tanggal`) VALUES
(1, 'R', 'Rahasia', NULL, NULL, NULL, NULL, NULL),
(2, 'P', 'Penting', NULL, NULL, NULL, NULL, NULL),
(3, 'B', 'Biasa', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `ref_jenis_surat_keterangan`
--

CREATE TABLE `ref_jenis_surat_keterangan` (
  `id` int(11) NOT NULL,
  `kode` varchar(5) DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `aktif` tinyint(1) DEFAULT '1' COMMENT '1:aktif; 2:tidak;',
  `register_id` tinyint(1) DEFAULT NULL COMMENT '1:Perdata; 2:Pidana;',
  `dokumen` varchar(155) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `ref_jenis_surat_keterangan`
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
-- Struktur dari tabel `ref_pangkat`
--

CREATE TABLE `ref_pangkat` (
  `id` int(11) NOT NULL,
  `golongan` varchar(20) NOT NULL,
  `pangkat` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `ref_pangkat`
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
-- Struktur dari tabel `ref_pengiriman`
--

CREATE TABLE `ref_pengiriman` (
  `id` int(11) NOT NULL,
  `jenis_pengiriman` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `ref_pengiriman`
--

INSERT INTO `ref_pengiriman` (`id`, `jenis_pengiriman`) VALUES
(1, 'PT POS Indonesia'),
(2, 'Ekspedisi (TIKI/JNE/dll)'),
(3, 'Kurir'),
(4, 'Lain-lain');

-- --------------------------------------------------------

--
-- Struktur dari tabel `ref_penomoran`
--

CREATE TABLE `ref_penomoran` (
  `id` int(11) NOT NULL,
  `kode` varchar(100) DEFAULT NULL,
  `jenis` varchar(100) DEFAULT NULL,
  `keterangan` text,
  `aktif` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `ref_penomoran`
--

INSERT INTO `ref_penomoran` (`id`, `kode`, `jenis`, `keterangan`, `aktif`) VALUES
(1, 'KD_SURAT/NMR/OT.00/BLN/THN', 'Organisasi', 'berhubungan dengan pembentukan, perubahan organisasi, uraian pekerjaan dan pembahasannya mulai dari awal sampai akhir dan jalur pertanggung jawabannya', 1),
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
-- Struktur dari tabel `ref_satker`
--

CREATE TABLE `ref_satker` (
  `id` varchar(7) NOT NULL,
  `nama_satker` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `ref_satker`
--

INSERT INTO `ref_satker` (`id`, `nama_satker`) VALUES
('401582', 'Mahkamah Syar\'iyah Banda Aceh'),
('401584', 'Mahkamah Syar\'iyah Jantho');

-- --------------------------------------------------------

--
-- Struktur dari tabel `ref_tujuan_surat`
--

CREATE TABLE `ref_tujuan_surat` (
  `groupid` int(11) NOT NULL COMMENT 'Primary Key: (by system)',
  `parent_id` int(11) DEFAULT NULL COMMENT 'Grup induk: merujuk ke tabel sys_groups kolom groupid',
  `level` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Level tree (by system)',
  `lft` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set left:(by system)',
  `rgt` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set right:(by system)',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT 'Nama Grup: isian bebas',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT 'Keterangan: isian bebas',
  `enable` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Aktif: pilihan 1=Ya; 0=Tidak',
  `ordering` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Urutan Grup Per Induknya',
  `lock_by` varchar(30) NOT NULL DEFAULT '' COMMENT 'Diedit Oleh: (by system)',
  `lock_on` datetime DEFAULT NULL COMMENT 'Diedit Tanggal: (by system)',
  `created_by` varchar(30) DEFAULT NULL COMMENT 'Diinput Oleh: (by system)',
  `created_on` datetime DEFAULT NULL COMMENT 'Diinput Tanggal: (by system)',
  `modified_by` varchar(30) DEFAULT NULL COMMENT 'Diperbaharui Oleh: (by system)',
  `modified_on` datetime DEFAULT NULL COMMENT 'Diperbaharui Tanggal: (by system)'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Data Grup User aplikasi';

--
-- Dumping data untuk tabel `ref_tujuan_surat`
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
-- Struktur dari tabel `register_pelaksanaan`
--

CREATE TABLE `register_pelaksanaan` (
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
-- Dumping data untuk tabel `register_pelaksanaan`
--

INSERT INTO `register_pelaksanaan` (`pelaksanaan_id`, `register_id`, `jenis_pelaksanaan_id`, `jenis_pelaksanaan`, `sifat_pelaksanaan_id`, `sifat_pelaksanaan`, `tanggal_pelaksanaan`, `dari_userid`, `dari_fullname`, `dari_jabatan_id`, `dari_jabatan`, `kepada_userid`, `kepada_fullname`, `kepada_jabatan_id`, `kepada_jabatan`, `keterangan`, `diinput_oleh`, `diinput_tanggal`, `diperbaharui_oleh`, `diperbaharui_tanggal`) VALUES
(19, 12, 10, 'Disposisi', NULL, NULL, '2022-04-03', 1, 'Dra. Hj. Rosmawardani, S.H., M.H', 2, 'Ketua Mahkamah Syar\'iyah', 6, 'Khairuddin, S.H., M.H.', 16, 'Sekretaris', 'Tindak Lanjuti', 'ros', '2022-04-03 12:40:19', NULL, NULL),
(20, 12, 10, 'Disposisi', NULL, NULL, '2022-04-11', 6, 'Khairuddin, S.H., M.H.', 16, 'Sekretaris', 4, 'latif', 6, 'Panitera Muda Permohonan', '', 'khair', '2022-04-11 04:07:56', NULL, NULL),
(37, 17, 10, 'Disposisi', NULL, NULL, '2022-04-13', 6, 'H. Hilman Lubis, S.H., M.H.', 16, 'Sekretaris', 1, 'Drs. H. Zulkifli Yus, M.H.', 2, 'Ketua', '', 'hilman', '2022-04-13 09:25:42', NULL, NULL),
(40, 17, 20, 'Dilaksanakan', NULL, NULL, '2022-04-13', 1, 'Drs. H. Zulkifli Yus, M.H.', 2, 'Ketua', 0, '', 0, '', '', 'zul', '2022-04-13 09:37:19', NULL, NULL),
(41, 24, 10, 'Disposisi', NULL, NULL, '2022-04-13', 1, 'Drs. H. Zulkifli Yus, M.H.', 2, 'Ketua', 6, 'H. Hilman Lubis, S.H., M.H.', 16, 'Sekretaris', '', 'zul', '2022-04-13 09:56:41', NULL, NULL),
(42, 24, 30, 'Diteruskan', NULL, NULL, '2022-04-13', 6, 'H. Hilman Lubis, S.H., M.H.', 16, 'Sekretaris', 9, 'Mirza, S.H., M.H.', 31, 'Kabag Umum dan Keuangan', '', 'hilman', '2022-04-13 09:58:02', NULL, NULL),
(43, 24, 10, 'Disposisi', NULL, NULL, '2022-04-13', 9, 'Mirza, S.H., M.H.', 31, 'Kabag Umum dan Keuangan', 1, 'Drs. H. Zulkifli Yus, M.H.', 2, 'Ketua', '', 'mirza', '2022-04-13 09:58:41', NULL, NULL),
(44, 24, 20, 'Dilaksanakan', NULL, NULL, '2022-04-13', 1, 'Drs. H. Zulkifli Yus, M.H.', 2, 'Ketua', 0, '', 0, '', '', 'zul', '2022-04-13 09:59:02', NULL, NULL),
(46, 26, 10, 'Disposisi', NULL, NULL, '2022-04-13', 6, 'Bahrun, S.H., M.H.', 19, 'Kepala Sub Bagian TURT', 1, 'Drs. H. Zulkifli Yus, M.H.', 2, 'Ketua', '', 'bahrun', '2022-04-13 10:36:18', NULL, NULL),
(47, 26, 10, 'Disposisi', NULL, NULL, '2022-04-13', 1, 'Drs. H. Zulkifli Yus, M.H.', 2, 'Ketua', 6, 'H. Hilman Lubis, S.H., M.H.', 16, 'Sekretaris', '', 'zul', '2022-04-13 10:40:42', NULL, NULL),
(48, 26, 10, 'Disposisi', NULL, NULL, '2022-04-13', 6, 'H. Hilman Lubis, S.H., M.H.', 16, 'Sekretaris', 7, 'Drs. Ilyas, S.H., M.H', 7, 'Panitera Muda Hukum', '', 'hilman', '2022-04-13 11:00:15', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `register_penggeledahan`
--

CREATE TABLE `register_penggeledahan` (
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
-- Struktur dari tabel `register_penyitaan`
--

CREATE TABLE `register_penyitaan` (
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
-- Struktur dari tabel `register_surat`
--

CREATE TABLE `register_surat` (
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
  `satker_id` varchar(3) DEFAULT NULL,
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
-- Dumping data untuk tabel `register_surat`
--

INSERT INTO `register_surat` (`register_id`, `klasifikasi_surat_id`, `klasifikasi_surat`, `jenis_surat_id`, `jenis_surat`, `tanggal_register`, `tanggal_surat`, `nomor_index`, `nomor_surat`, `nomor_agenda`, `pengirim_id`, `pengirim`, `tujuan_id`, `satker_id`, `tujuan`, `perihal`, `jenis_ekspedisi_id`, `jenis_ekspedisi`, `dokumen_elektronik`, `tanggal_kirim`, `status_pelaksanaan_id`, `status_pelaksanaan`, `keterangan`, `diinput_oleh`, `diinput_tanggal`, `diperbaharui_oleh`, `diperbaharui_tanggal`) VALUES
(12, 1, 'Surat Masuk', 3, 'Biasa', '2022-04-08', '2022-04-07', 6, 'W11-A21/20/PL.01/2/2022', '6/2022', NULL, 'Badilag', 2, NULL, 'Ketua Mahkamah Syar\'iyah', 'APlikasi Baru', NULL, NULL, NULL, NULL, 10, 'Disposisi', 'APlikasi Baru', 'ros', '2022-04-03 12:33:52', NULL, NULL),
(15, 2, 'Surat Keluar', 1, 'Organisasi', '2022-04-08', NULL, 1, 'W1-A21/1/OT.0/08/2022', NULL, 2, 'Ketua Mahkamah Syar\'iyah', 1, NULL, 'Izin Usulan Mutasi Hakim', 'Izin Usulan Mutasi Hakim', 1, 'PT POS Indonesia', '', NULL, 1, 'Pendaftaran', '', 'admin', '2022-04-09 08:16:45', NULL, NULL),
(17, 1, 'Surat Masuk', 1, 'Rahasia', '2022-04-12', '2022-04-11', 8, 'W1-A21/1/OT.0/05/2022', '8/2022', NULL, 'Badilag', 16, NULL, 'Sekretaris', 'Mutasi', NULL, NULL, NULL, NULL, 20, 'Dilaksanakan', '', 'admin', '2022-04-10 05:24:07', NULL, NULL),
(24, 1, 'Surat Masuk', 3, 'Biasa', '2022-04-13', '2022-04-13', 9, 'W11-A21/23/PL.01/5/2022', '9/2022', NULL, 'SEKMA', 2, NULL, 'Ketua', 'isi', NULL, NULL, NULL, NULL, 20, 'Dilaksanakan', 'isi', 'bahrun', '2022-04-13 09:40:39', NULL, NULL),
(26, 1, 'Surat Masuk', 1, 'Rahasia', '2022-04-13', '2022-04-13', 11, 'W11-A21/23/PL.01/4/2022', '11/2022', NULL, 'SEKMA', 16, NULL, 'Sekretaris', 'ISI', NULL, NULL, 'a134adf24566e61df05e6871f1f69423.pdf', NULL, 10, 'Disposisi', 'ISI', 'bahrun', '2022-04-13 10:34:11', NULL, NULL),
(29, 1, 'Surat Masuk', 1, 'Rahasia', '2022-04-13', '2022-04-13', 12, 'xxx', '12/2022', NULL, 'Badilag', 2, NULL, 'Ketua', '1', NULL, NULL, NULL, NULL, 1, 'Pendaftaran', '1', 'bahrun', '2022-04-13 11:10:09', NULL, NULL),
(30, 1, 'Surat Masuk', 1, 'Rahasia', '2022-04-13', '2022-04-13', 13, 'W11-A11/22/PL.08/4/2022', '13/2022', 22, 'Mahkamah Syar\'iyah Banda Aceh', 19, NULL, 'Kepala Sub Bagian TURT', 'Mutasi', NULL, NULL, '9b959492f77bff88072647ce74d3c9eb.pdf', NULL, 1, 'Pendaftaran', 'Ajuan Mutasi', 'banda', '2022-04-13 08:44:17', NULL, NULL),
(31, 1, 'Surat Masuk', 2, 'Penting', '2022-04-13', '2022-04-14', 14, 'W1-A21/3/OT.01/09/2022', '14/2022', 22, 'Mahkamah Syar\'iyah Banda Aceh', 19, NULL, 'Kepala Sub Bagian TURT', 'Pindahkan bg kicon', NULL, NULL, NULL, NULL, 1, 'Pendaftaran', 'Pindahkan bg kicon', 'banda', '2022-04-13 09:36:19', NULL, NULL),
(32, 1, 'Surat Masuk', 3, 'Biasa', '2022-04-14', '2022-04-14', 15, 'W1-A11/68/OT.04/04/2022', '15/2022', 22, 'Mahkamah Syar\'iyah Banda Aceh', 19, NULL, 'Kepala Sub Bagian TURT', 'Surat Permohonan Cuti', NULL, NULL, 'efdde6982cfdbe893da081e222b8c98a.pdf', NULL, 1, 'Pendaftaran', 'Surat Permohonan Cuti', 'banda', '2022-04-14 05:41:19', NULL, NULL),
(33, 1, 'Surat Masuk', 3, 'Biasa', '2022-04-14', '2022-04-14', 16, 'W1-A11/5/OT.00/04/2022', '16/2022', 23, 'Mahkamah Syar\'iyah Jantho', 19, NULL, 'Kepala Sub Bagian TURT', 'Surat Izin Belajar', NULL, NULL, '15ac9d733de11b42d5ac1cc9610e0647.pdf', NULL, 1, 'Pendaftaran', 'Surat Izin Belajar', 'jantho', '2022-04-14 05:46:30', NULL, NULL),
(34, 1, 'Surat Masuk', 2, 'Penting', '2022-04-15', '2022-04-14', 17, 'W11-A11/23/PL.01/5/2022', '17/2022', 23, 'Mahkamah Syar\'iyah Jantho', 19, NULL, 'Kepala Sub Bagian TURT', 'Sewa Mobil Dinas', NULL, NULL, NULL, NULL, 1, 'Pendaftaran', 'Sewa Mobil Dinas', 'jantho', '2022-04-14 06:56:28', NULL, NULL),
(35, 2, 'Surat Keluar', 1, 'Organisasi', '2022-04-14', NULL, 2, 'W1-A/2/OT.00/04/2022', NULL, 2, 'Ketua', 2, NULL, 'Mahkamah Agung', 'MA', 1, 'PT POS Indonesia', '', NULL, 1, 'Pendaftaran', 'MA', 'admin', '2022-04-14 08:15:03', NULL, NULL),
(36, 2, 'Surat Keluar', 3, 'Laporan', '2022-04-14', NULL, 3, 'W1-A/3/OT.01.2/04/2022', NULL, 16, 'Sekretaris', 2, NULL, 'Kabiro Pengadaan', 'Oke', 4, 'Lain-lain', '', NULL, 1, 'Pendaftaran', 'Oke', 'hilman', '2022-04-14 08:42:24', NULL, NULL),
(37, 1, 'Surat Masuk', 2, 'Penting', '2022-04-14', '2022-04-14', 18, 'W1-A/33/OT.01/4/2022', '18/2022', NULL, 'Pengurus Pusat', 35, NULL, 'Pengurus PTWP', 'Buka Bersama', NULL, NULL, NULL, NULL, 1, 'Pendaftaran', 'Bisa Gak Mun', 'bahrun', '2022-04-14 10:55:31', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `register_surat_keterangan`
--

CREATE TABLE `register_surat_keterangan` (
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
-- Struktur dari tabel `sys_audittrail`
--

CREATE TABLE `sys_audittrail` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Primary key: (by system)',
  `datetime` datetime NOT NULL COMMENT 'Waktu Aktifitas: (by system)',
  `ipaddress` varchar(15) NOT NULL DEFAULT '' COMMENT 'Alamat IP: (by system)',
  `username` varchar(30) NOT NULL DEFAULT '' COMMENT 'Username: (by system)',
  `tablename` varchar(250) NOT NULL DEFAULT '' COMMENT 'Nama Tabel: (by system)',
  `action` varchar(250) NOT NULL DEFAULT '' COMMENT 'Aktifitas: (by system)',
  `title` varchar(500) NOT NULL DEFAULT '' COMMENT 'Keterangan Aktifitas: (by system)',
  `description` longtext COMMENT 'Informasi detil Aktifitas: (by system)'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Data Audittrail';

--
-- Dumping data untuk tabel `sys_audittrail`
--

INSERT INTO `sys_audittrail` (`id`, `datetime`, `ipaddress`, `username`, `tablename`, `action`, `title`, `description`) VALUES
(1, '2021-08-04 03:29:19', '::1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Dra. Hj. Rosmawardani, S.H., M.H</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>195412081979032007</td></tr><tr><td>nama_gelar</td><td>Dra. Hj. Rosmawardani, S.H., M.H</td></tr><tr><td>golongan_id</td><td>18</td></tr><tr><td>golongan</td><td>IV/e</td></tr><tr><td>pangkat</td><td>Pembina Utama</td></tr><tr><td>alamat</td><td>Banda Aceh</td></tr><tr><td>jabatan_id</td><td>2</td></tr><tr><td>jabatan_nama</td><td>Ketua Pengadilan</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2021-08-04 03:29:18</td></tr></table>'),
(2, '2021-08-04 03:29:52', '::1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>ros</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=2]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>2</td></tr><tr><td>pegawai_id</td><td>1</td></tr><tr><td>fullname</td><td>Dra. Hj. Rosmawardani, S.H., M.H</td></tr><tr><td>username</td><td>ros</td></tr><tr><td>password</td><td>c5449bcadaec011e4bc554dcde34056e</td></tr><tr><td>email</td><td>ros@gmail.com</td></tr><tr><td>activation</td><td>6b0b41f29b854a34bc5036cf95a0d74f</td></tr><tr><td>code_activation</td><td>64911d63fedf4fb6d4255e2130e6e904</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2021-08-04 03:29:52</td></tr></table>'),
(3, '2021-08-04 03:30:14', '::1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Drs. Syafruddin</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>196202101994031003</td></tr><tr><td>nama_gelar</td><td>Drs. Syafruddin</td></tr><tr><td>golongan_id</td><td>17</td></tr><tr><td>golongan</td><td>IV/d</td></tr><tr><td>pangkat</td><td>Pembina Utama Madya</td></tr><tr><td>alamat</td><td>Banda Aceh</td></tr><tr><td>jabatan_id</td><td>4</td></tr><tr><td>jabatan_nama</td><td>Panitera</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2021-08-04 03:30:14</td></tr></table>'),
(4, '2021-08-04 03:31:48', '::1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>syaf</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=3]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>3</td></tr><tr><td>pegawai_id</td><td>2</td></tr><tr><td>fullname</td><td>Drs. Syafruddin</td></tr><tr><td>username</td><td>syaf</td></tr><tr><td>password</td><td>80776312162d09d86406a3ea9f4151f1</td></tr><tr><td>email</td><td>syaf@gmail.com</td></tr><tr><td>activation</td><td>dcf3dd060300e5ae0fe500d65781bfbe</td></tr><tr><td>code_activation</td><td>527b9c87c3ea750538746364a99596fd</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2021-08-04 03:31:48</td></tr></table>'),
(5, '2021-08-04 04:13:04', '::1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Rafi</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>195803141983031004</td></tr><tr><td>nama_gelar</td><td>Rafi</td></tr><tr><td>golongan_id</td><td>18</td></tr><tr><td>golongan</td><td>IV/e</td></tr><tr><td>pangkat</td><td>Pembina Utama</td></tr><tr><td>alamat</td><td>Banda Aceh</td></tr><tr><td>jabatan_id</td><td>3</td></tr><tr><td>jabatan_nama</td><td>Wakil Ketua Pengadilan</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2021-08-04 04:13:03</td></tr></table>'),
(6, '2021-08-04 04:13:43', '::1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>latif</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>-</td></tr><tr><td>nama_gelar</td><td>latif</td></tr><tr><td>golongan_id</td><td>14</td></tr><tr><td>golongan</td><td>IV/a</td></tr><tr><td>pangkat</td><td>Pembina</td></tr><tr><td>alamat</td><td>Banda Aceh</td></tr><tr><td>jabatan_id</td><td>7</td></tr><tr><td>jabatan_nama</td><td>Panitera Muda Hukum</td></tr><tr><td>aktif</td><td>T</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2021-08-04 04:13:43</td></tr></table>'),
(7, '2021-08-04 04:14:13', '::1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>bahrun</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>-</td></tr><tr><td>nama_gelar</td><td>bahrun</td></tr><tr><td>golongan_id</td><td>14</td></tr><tr><td>golongan</td><td>IV/a</td></tr><tr><td>pangkat</td><td>Pembina</td></tr><tr><td>alamat</td><td>Banda Aceh</td></tr><tr><td>jabatan_id</td><td>19</td></tr><tr><td>jabatan_nama</td><td>Kepala Sub Bagian Umum dan Keuangan</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2021-08-04 04:14:13</td></tr></table>'),
(8, '2021-08-04 04:17:50', '::1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>latif</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=4]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>4</td></tr><tr><td>pegawai_id</td><td>4</td></tr><tr><td>fullname</td><td>latif</td></tr><tr><td>username</td><td>latif</td></tr><tr><td>password</td><td>1a8a5d83ce5b455ea31cb36666a948c3</td></tr><tr><td>email</td><td>latif@gmail.com</td></tr><tr><td>activation</td><td>89723a3c2dbc6c19ec0131852747efd2</td></tr><tr><td>code_activation</td><td>eeb3a028814776c51a4148819f20f785</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2021-08-04 04:17:50</td></tr></table>'),
(9, '2021-08-04 04:50:10', '::1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>khair</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>-</td></tr><tr><td>nama_gelar</td><td>khair</td></tr><tr><td>golongan_id</td><td>17</td></tr><tr><td>golongan</td><td>IV/d</td></tr><tr><td>pangkat</td><td>Pembina Utama Madya</td></tr><tr><td>alamat</td><td>Banda Aceh</td></tr><tr><td>jabatan_id</td><td>16</td></tr><tr><td>jabatan_nama</td><td>Sekretaris</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2021-08-04 04:50:09</td></tr></table>'),
(10, '2021-08-04 04:51:17', '::1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Drs. Ilyas, S.H., M.H</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>-</td></tr><tr><td>nama_gelar</td><td>Drs. Ilyas, S.H., M.H</td></tr><tr><td>golongan_id</td><td>14</td></tr><tr><td>golongan</td><td>IV/a</td></tr><tr><td>pangkat</td><td>Pembina</td></tr><tr><td>alamat</td><td>Banda Aceh</td></tr><tr><td>jabatan_id</td><td>22</td></tr><tr><td>jabatan_nama</td><td>Staf  Panitera Muda Hukum</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2021-08-04 04:51:17</td></tr></table>'),
(11, '2021-08-04 04:52:01', '::1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>ratna</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>-</td></tr><tr><td>nama_gelar</td><td>ratna</td></tr><tr><td>golongan_id</td><td>14</td></tr><tr><td>golongan</td><td>IV/a</td></tr><tr><td>pangkat</td><td>Pembina</td></tr><tr><td>alamat</td><td>Banda Aceh</td></tr><tr><td>jabatan_id</td><td>5</td></tr><tr><td>jabatan_nama</td><td>Panitera Muda Pidana</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2021-08-04 04:52:01</td></tr></table>'),
(12, '2021-08-04 04:53:25', '::1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>rafi</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=5]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>5</td></tr><tr><td>pegawai_id</td><td>3</td></tr><tr><td>fullname</td><td>Rafi</td></tr><tr><td>username</td><td>rafi</td></tr><tr><td>password</td><td>85ccab9353ea7aef6526a822ca28006d</td></tr><tr><td>email</td><td>rafi@gmail.com</td></tr><tr><td>activation</td><td>ed2b8ba914746d536d843e831d6aafec</td></tr><tr><td>code_activation</td><td>b4e57699a8e544863256c0cd196c92d0</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2021-08-04 04:53:25</td></tr></table>'),
(13, '2021-08-04 04:54:20', '::1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>bahrun</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=6]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>6</td></tr><tr><td>pegawai_id</td><td>5</td></tr><tr><td>fullname</td><td>bahrun</td></tr><tr><td>username</td><td>bahrun</td></tr><tr><td>password</td><td>7ee720947fb1383ddbc646763175e4c6</td></tr><tr><td>email</td><td>bahrun@gmail.com</td></tr><tr><td>activation</td><td>682935d98be8f3bc4cc6d52b2f188668</td></tr><tr><td>code_activation</td><td>a1a23f6f09ec7efee8d576a823e2338a</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2021-08-04 04:54:19</td></tr></table>'),
(14, '2021-08-04 04:55:55', '::1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>khair</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=7]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>7</td></tr><tr><td>pegawai_id</td><td>6</td></tr><tr><td>fullname</td><td>khair</td></tr><tr><td>username</td><td>khair</td></tr><tr><td>password</td><td>e5f2f4d0253a8312784195f9409f065f</td></tr><tr><td>email</td><td>khair@gmail.com</td></tr><tr><td>activation</td><td>faae5361878bd81899f2ea65a10245ac</td></tr><tr><td>code_activation</td><td>3286bf3ce458f4e3b638dae25a05a82f</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2021-08-04 04:55:54</td></tr></table>'),
(15, '2021-08-04 04:56:20', '::1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>ilyas</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=8]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>8</td></tr><tr><td>pegawai_id</td><td>7</td></tr><tr><td>fullname</td><td>Drs. Ilyas, S.H., M.H</td></tr><tr><td>username</td><td>ilyas</td></tr><tr><td>password</td><td>4a5211cf2de2e5897cbec7f2c4203f63</td></tr><tr><td>email</td><td>ilyas@gmail.com</td></tr><tr><td>activation</td><td>b65d370f50477300fcbd02ebfcd9bbd3</td></tr><tr><td>code_activation</td><td>87a55d74550b86c4d46e57f14c79eb69</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2021-08-04 04:56:19</td></tr></table>'),
(16, '2021-08-04 04:56:46', '::1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>ratna</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=9]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>9</td></tr><tr><td>pegawai_id</td><td>8</td></tr><tr><td>fullname</td><td>ratna</td></tr><tr><td>username</td><td>ratna</td></tr><tr><td>password</td><td>8ad1888c5e6a47a6947cade86dd2d61a</td></tr><tr><td>email</td><td>ratna@gmail.com</td></tr><tr><td>activation</td><td>e64233156482aaf65ad22b327d75b159</td></tr><tr><td>code_activation</td><td>3cfbc00fc9d66b8e74b680858d16d217</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2021-08-04 04:56:46</td></tr></table>'),
(17, '2022-04-12 07:53:17', '::1', '', 'sys_users', 'UPDATE', 'Edit Pengguna [Username=<b>latif</b>]<br />Edit table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=4]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>pegawai_id</td><td>4</td></tr><tr><td>fullname</td><td>latif</td></tr><tr><td>username</td><td>latif</td></tr><tr><td>password</td><td>4bfa85f44d6b7df689285dbf2864b87a</td></tr><tr><td>email</td><td>latif@gmail.com</td></tr><tr><td>activation</td><td>89723a3c2dbc6c19ec0131852747efd2</td></tr><tr><td>code_activation</td><td>f88958e703296136aae79e5f0330071b</td></tr><tr><td>block</td><td>1</td></tr><tr><td>modified_by</td><td>admin</td></tr><tr><td>modified_on</td><td>2022-04-12 07:53:17</td></tr></table>'),
(18, '2022-04-12 08:06:24', '::1', '', 'sys_users', 'UPDATE', 'Edit Pengguna [Username=<b>hilman</b>]<br />Edit table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=7]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>pegawai_id</td><td>6</td></tr><tr><td>fullname</td><td>H. Hilman Lubis, S.H., M.H.</td></tr><tr><td>username</td><td>hilman</td></tr><tr><td>password</td><td>3cef1d538d50997a0db50d7d568456d0</td></tr><tr><td>email</td><td>hilman@gmail.com</td></tr><tr><td>activation</td><td>d289d16fc20e8ac4f00e59e1e66f0cf6</td></tr><tr><td>code_activation</td><td>d78477723a1dc7c22d920b363d0aec61</td></tr><tr><td>block</td><td>0</td></tr><tr><td>modified_by</td><td>admin</td></tr><tr><td>modified_on</td><td>2022-04-12 08:06:24</td></tr></table>'),
(19, '2022-04-12 08:12:13', '::1', '', 'sys_users', 'UPDATE', 'Edit Pengguna [Username=<b>bahrun</b>]<br />Edit table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=6]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>pegawai_id</td><td>5</td></tr><tr><td>fullname</td><td>Bahrun, S.H., M.H.</td></tr><tr><td>username</td><td>bahrun</td></tr><tr><td>password</td><td>e0c2383bdab93f0e3561f5142d3a9e67</td></tr><tr><td>email</td><td>bahrun@gmail.com</td></tr><tr><td>activation</td><td>62b7346f87f1f8e3bfb199ea4a458509</td></tr><tr><td>code_activation</td><td>3aff72b9fac7a9ca2ee560feed82b44f</td></tr><tr><td>block</td><td>0</td></tr><tr><td>modified_by</td><td>admin</td></tr><tr><td>modified_on</td><td>2022-04-12 08:12:13</td></tr></table>'),
(20, '2022-04-12 08:12:28', '::1', '', 'sys_users', 'UPDATE', 'Edit Pengguna [Username=<b>ratna</b>]<br />Edit table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=9]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>pegawai_id</td><td>8</td></tr><tr><td>fullname</td><td>Ratna Juita, S.Ag., S.H., M.H.</td></tr><tr><td>username</td><td>ratna</td></tr><tr><td>password</td><td>c7f5ef59a1c532aa27a806ae50ee0408</td></tr><tr><td>email</td><td>ratna@gmail.com</td></tr><tr><td>activation</td><td>2cc45ccf733c5eabaf811a29f99baee4</td></tr><tr><td>code_activation</td><td>94d9f3bb2c087dae935fe4e521bf6e71</td></tr><tr><td>block</td><td>0</td></tr><tr><td>modified_by</td><td>admin</td></tr><tr><td>modified_on</td><td>2022-04-12 08:12:28</td></tr></table>'),
(21, '2022-04-12 08:15:42', '::1', '', 'sys_users', 'UPDATE', 'Edit Pengguna [Username=<b>zul</b>]<br />Edit table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=2]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>pegawai_id</td><td>1</td></tr><tr><td>fullname</td><td>Drs. H. Zulkifli Yus, M.H.</td></tr><tr><td>username</td><td>zul</td></tr><tr><td>password</td><td>e3d0af46f614b635ab9b7529005e4864</td></tr><tr><td>email</td><td>zulkifliyus@gmail.com</td></tr><tr><td>activation</td><td>f6ce7e59c5dd95db4bcc67b482029006</td></tr><tr><td>code_activation</td><td>e9b336fafb19f43afcd2122b087381bb</td></tr><tr><td>block</td><td>0</td></tr><tr><td>modified_by</td><td>admin</td></tr><tr><td>modified_on</td><td>2022-04-12 08:15:41</td></tr></table>'),
(22, '2022-04-12 08:20:28', '::1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Mirza, S.H., M.H.</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>197404061994031001</td></tr><tr><td>nama_gelar</td><td>Mirza, S.H., M.H.</td></tr><tr><td>golongan_id</td><td>15</td></tr><tr><td>golongan</td><td>IV/b</td></tr><tr><td>pangkat</td><td>Pembina Tingkat I</td></tr><tr><td>alamat</td><td>Banda Aceh</td></tr><tr><td>jabatan_id</td><td>31</td></tr><tr><td>jabatan_nama</td><td>Kabag Umum dan Keuangan</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-12 08:20:28</td></tr></table>'),
(23, '2022-04-12 08:25:55', '::1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Fahmi Riswin, S.E.Ak.</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>197404072006041002</td></tr><tr><td>nama_gelar</td><td>Fahmi Riswin, S.E.Ak.</td></tr><tr><td>golongan_id</td><td>13</td></tr><tr><td>golongan</td><td>III/d</td></tr><tr><td>pangkat</td><td>Penata Tingkat I</td></tr><tr><td>alamat</td><td>Banda Aceh</td></tr><tr><td>jabatan_id</td><td>18</td></tr><tr><td>jabatan_nama</td><td>Kepala Sub Bagian Renprog</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-12 08:25:55</td></tr></table>'),
(24, '2022-04-12 08:27:37', '::1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Jainal Tabrani, S.H., M.H.</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>198408142007041001</td></tr><tr><td>nama_gelar</td><td>Jainal Tabrani, S.H., M.H.</td></tr><tr><td>golongan_id</td><td>13</td></tr><tr><td>golongan</td><td>III/d</td></tr><tr><td>pangkat</td><td>Penata Tingkat I</td></tr><tr><td>alamat</td><td>Banda Aceh</td></tr><tr><td>jabatan_id</td><td>17</td></tr><tr><td>jabatan_nama</td><td>Kepala Sub Bagian Kepegawaian dan TI</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-12 08:27:37</td></tr></table>'),
(25, '2022-04-12 08:50:29', '::1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Yani Riyanti, S.E., M.Si.</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>198512292009122003</td></tr><tr><td>nama_gelar</td><td>Yani Riyanti, S.E., M.Si.</td></tr><tr><td>golongan_id</td><td>13</td></tr><tr><td>golongan</td><td>III/d</td></tr><tr><td>pangkat</td><td>Penata Tingkat I</td></tr><tr><td>alamat</td><td>Banda Aceh</td></tr><tr><td>jabatan_id</td><td>30</td></tr><tr><td>jabatan_nama</td><td>Kepala Sub Bagian Keuangan dan Pelaporan</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-12 08:50:29</td></tr></table>'),
(26, '2022-04-12 08:52:59', '::1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Yosi Dirola, S.E.</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>197607262006042003</td></tr><tr><td>nama_gelar</td><td>Yosi Dirola, S.E.</td></tr><tr><td>golongan_id</td><td>13</td></tr><tr><td>golongan</td><td>III/d</td></tr><tr><td>pangkat</td><td>Penata Tingkat I</td></tr><tr><td>alamat</td><td>Banda Aceh</td></tr><tr><td>jabatan_id</td><td>25</td></tr><tr><td>jabatan_nama</td><td>Pengelola Keuangan</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-12 08:52:59</td></tr></table>'),
(27, '2022-04-12 08:54:30', '::1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Isnawati, S.E.</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>197905012009122001</td></tr><tr><td>nama_gelar</td><td>Isnawati, S.E.</td></tr><tr><td>golongan_id</td><td>12</td></tr><tr><td>golongan</td><td>III/c</td></tr><tr><td>pangkat</td><td>Penata</td></tr><tr><td>alamat</td><td>Banda Aceh</td></tr><tr><td>jabatan_id</td><td>25</td></tr><tr><td>jabatan_nama</td><td>Pengelola Keuangan</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-12 08:54:30</td></tr></table>'),
(28, '2022-04-12 08:55:25', '::1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Monik Zarinah, SE, M.Si.</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>198106102010032002</td></tr><tr><td>nama_gelar</td><td>Monik Zarinah, SE, M.Si.</td></tr><tr><td>golongan_id</td><td>12</td></tr><tr><td>golongan</td><td>III/c</td></tr><tr><td>pangkat</td><td>Penata</td></tr><tr><td>alamat</td><td>Banda Aceh</td></tr><tr><td>jabatan_id</td><td>25</td></tr><tr><td>jabatan_nama</td><td>Pengelola Keuangan</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-12 08:55:25</td></tr></table>'),
(29, '2022-04-12 08:56:03', '::1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Armada, S.E.</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>198709122009041002</td></tr><tr><td>nama_gelar</td><td>Armada, S.E.</td></tr><tr><td>golongan_id</td><td>11</td></tr><tr><td>golongan</td><td>III/b</td></tr><tr><td>pangkat</td><td>Penata Muda Tingkat I</td></tr><tr><td>alamat</td><td>Banda Aceh</td></tr><tr><td>jabatan_id</td><td>25</td></tr><tr><td>jabatan_nama</td><td>Pengelola Keuangan</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-12 08:56:02</td></tr></table>'),
(30, '2022-04-12 08:56:57', '::1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Denny Kurniawan, S.T.</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>198211232009041002</td></tr><tr><td>nama_gelar</td><td>Denny Kurniawan, S.T.</td></tr><tr><td>golongan_id</td><td>13</td></tr><tr><td>golongan</td><td>III/d</td></tr><tr><td>pangkat</td><td>Penata Tingkat I</td></tr><tr><td>alamat</td><td>Banda Aceh</td></tr><tr><td>jabatan_id</td><td>26</td></tr><tr><td>jabatan_nama</td><td>Pranata Keuangan</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-12 08:56:56</td></tr></table>'),
(31, '2022-04-12 08:57:41', '::1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Mohd Hanafi, S.H.I.</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>198212012009121004</td></tr><tr><td>nama_gelar</td><td>Mohd Hanafi, S.H.I.</td></tr><tr><td>golongan_id</td><td>12</td></tr><tr><td>golongan</td><td>III/c</td></tr><tr><td>pangkat</td><td>Penata</td></tr><tr><td>alamat</td><td>Banda Aceh</td></tr><tr><td>jabatan_id</td><td>26</td></tr><tr><td>jabatan_nama</td><td>Pranata Keuangan</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-12 08:57:40</td></tr></table>'),
(32, '2022-04-12 09:00:12', '::1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Muhammad Kadri, S.T.</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>198007132006041002</td></tr><tr><td>nama_gelar</td><td>Muhammad Kadri, S.T.</td></tr><tr><td>golongan_id</td><td>12</td></tr><tr><td>golongan</td><td>III/c</td></tr><tr><td>pangkat</td><td>Penata</td></tr><tr><td>alamat</td><td>Banda Aceh</td></tr><tr><td>jabatan_id</td><td>24</td></tr><tr><td>jabatan_nama</td><td>Pranata Komputer</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-12 09:00:11</td></tr></table>'),
(33, '2022-04-12 09:01:09', '::1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Heri Irawan, A.Md.</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>198312122011011011</td></tr><tr><td>nama_gelar</td><td>Heri Irawan, A.Md.</td></tr><tr><td>golongan_id</td><td>10</td></tr><tr><td>golongan</td><td>III/a</td></tr><tr><td>pangkat</td><td>Penata Muda</td></tr><tr><td>alamat</td><td>Banda Aceh</td></tr><tr><td>jabatan_id</td><td>24</td></tr><tr><td>jabatan_nama</td><td>Pranata Komputer</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-12 09:01:09</td></tr></table>'),
(34, '2022-04-12 09:02:23', '::1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Drs. A Murad, M.H.</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>196202021993031003</td></tr><tr><td>nama_gelar</td><td>Drs. A Murad, M.H.</td></tr><tr><td>golongan_id</td><td>15</td></tr><tr><td>golongan</td><td>IV/b</td></tr><tr><td>pangkat</td><td>Pembina Tingkat I</td></tr><tr><td>alamat</td><td>Banda Aceh</td></tr><tr><td>jabatan_id</td><td>8</td></tr><tr><td>jabatan_nama</td><td>Panitera Pengganti</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-12 09:02:22</td></tr></table>'),
(35, '2022-04-12 18:11:01', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>mirza</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=10]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>10</td></tr><tr><td>pegawai_id</td><td>9</td></tr><tr><td>fullname</td><td>Mirza, S.H., M.H.</td></tr><tr><td>username</td><td>mirza</td></tr><tr><td>password</td><td>399c0c446fd0e245efe3f66d4b269b1e</td></tr><tr><td>email</td><td>mirza@gmail.com</td></tr><tr><td>activation</td><td>5974e0f5104f30795175de362e35d317</td></tr><tr><td>code_activation</td><td>a60849391be249fb8cda9d50fe3cd23c</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-12 06:11:01</td></tr></table>'),
(36, '2022-04-12 18:13:58', '127.0.0.1', '', 'sys_users', 'UPDATE', 'Edit Pengguna [Username=<b>mirza</b>]<br />Edit table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=10]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>pegawai_id</td><td>9</td></tr><tr><td>fullname</td><td>Mirza, S.H., M.H.</td></tr><tr><td>username</td><td>mirza</td></tr><tr><td>password</td><td>c0f01a07caadb936988de6ec242f9bf5</td></tr><tr><td>email</td><td>mirza@gmail.com</td></tr><tr><td>activation</td><td>5974e0f5104f30795175de362e35d317</td></tr><tr><td>code_activation</td><td>2a7930e39b6cda30aff7bb18ab1120c7</td></tr><tr><td>block</td><td>0</td></tr><tr><td>modified_by</td><td>zul</td></tr><tr><td>modified_on</td><td>2022-04-12 06:13:58</td></tr></table>'),
(37, '2022-04-12 18:19:54', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>fahmi</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=11]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>11</td></tr><tr><td>pegawai_id</td><td>10</td></tr><tr><td>fullname</td><td>Fahmi Riswin, S.E.Ak.</td></tr><tr><td>username</td><td>fahmi</td></tr><tr><td>password</td><td>31231a278ac42727631a7c444185378b</td></tr><tr><td>email</td><td>fahmi@gmail.com</td></tr><tr><td>activation</td><td>3cd36cd8ef15bffa11f2b89689796778</td></tr><tr><td>code_activation</td><td>d0eb55437c9b78c5e0b466dd0b0a2a40</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-12 06:19:54</td></tr></table>'),
(38, '2022-04-12 19:24:39', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>hanafi</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=12]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>12</td></tr><tr><td>pegawai_id</td><td>18</td></tr><tr><td>fullname</td><td>Mohd Hanafi, S.H.I.</td></tr><tr><td>username</td><td>hanafi</td></tr><tr><td>password</td><td>d34e0ad4c19e3bc7b21175b18f11db5f</td></tr><tr><td>email</td><td>hanafi@gmail.com</td></tr><tr><td>activation</td><td>8cba2204245736591046f33496c65e2d</td></tr><tr><td>code_activation</td><td>a06601c49619d6418abd9105158ac077</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-12 07:24:39</td></tr></table>'),
(39, '2022-04-13 07:06:10', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>banda</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=13]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>13</td></tr><tr><td>pegawai_id</td><td>22</td></tr><tr><td>fullname</td><td>Mahkamah Syar\'iyah Banda Aceh</td></tr><tr><td>username</td><td>banda</td></tr><tr><td>password</td><td>08357d94dc762e9354f3cbc6e946a13a</td></tr><tr><td>email</td><td>msbna@gmail.com</td></tr><tr><td>activation</td><td>111c266fffce5219fff974b9559adf02</td></tr><tr><td>code_activation</td><td>af5b104b0ef187824dbef5e8f9901593</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>zul</td></tr><tr><td>created_on</td><td>2022-04-13 07:06:10</td></tr></table>'),
(40, '2022-04-14 05:44:06', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>jantho</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=14]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>14</td></tr><tr><td>pegawai_id</td><td>23</td></tr><tr><td>fullname</td><td>Mahkamah Syar\'iyah Jantho</td></tr><tr><td>username</td><td>jantho</td></tr><tr><td>password</td><td>d80f73987c8586cb04425f4d6bb193f2</td></tr><tr><td>email</td><td>jantho@gmail.com</td></tr><tr><td>activation</td><td>4b394d203612fb99b1708431837783b4</td></tr><tr><td>code_activation</td><td>142b6f7b17dd92a6f7beaedccdc87d0e</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 05:44:06</td></tr></table>'),
(41, '2022-04-14 08:15:56', '127.0.0.1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Mas Punto</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>-</td></tr><tr><td>nama_gelar</td><td>Mas Punto</td></tr><tr><td>golongan_id</td><td>10</td></tr><tr><td>golongan</td><td>III/a</td></tr><tr><td>pangkat</td><td>Penata Muda</td></tr><tr><td>alamat</td><td>Aceh</td></tr><tr><td>jabatan_id</td><td>34</td></tr><tr><td>jabatan_nama</td><td>Pengurus IPASPI</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-14 08:15:56</td></tr></table>'),
(42, '2022-04-14 08:16:22', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>maspt</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=15]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>15</td></tr><tr><td>pegawai_id</td><td>24</td></tr><tr><td>fullname</td><td>Mas Punto</td></tr><tr><td>username</td><td>maspt</td></tr><tr><td>password</td><td>bdc87f012d9debc8be38fac8951e8150</td></tr><tr><td>email</td><td>maspt@gmail.com</td></tr><tr><td>activation</td><td>efc8be10f9e97646bdfad6473438dfc6</td></tr><tr><td>code_activation</td><td>14aaa2f0418422568f2ca6daa4bfcb1b</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 08:16:22</td></tr></table>'),
(43, '2022-04-14 10:22:49', '127.0.0.1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Arif KHD</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>198807152020121010</td></tr><tr><td>nama_gelar</td><td>Arif KHD</td></tr><tr><td>golongan_id</td><td>10</td></tr><tr><td>golongan</td><td>III/a</td></tr><tr><td>pangkat</td><td>Penata Muda</td></tr><tr><td>alamat</td><td>Banda Aceh</td></tr><tr><td>chatid</td><td></td></tr><tr><td>jabatan_id</td><td>35</td></tr><tr><td>jabatan_nama</td><td>Pengurus PTWP</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-14 10:22:49</td></tr></table>'),
(44, '2022-04-14 10:59:14', '127.0.0.1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Mahkamah Syar\'iyah Sigli</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>-</td></tr><tr><td>nama_gelar</td><td>Mahkamah Syar\'iyah Sigli</td></tr><tr><td>golongan_id</td><td>99</td></tr><tr><td>golongan</td><td>Pegawai Tidak Tetap</td></tr><tr><td>pangkat</td><td>Pegawai Tidak Tetap (PTT)</td></tr><tr><td>alamat</td><td>Aceh</td></tr><tr><td>chatid</td><td></td></tr><tr><td>jabatan_id</td><td>40</td></tr><tr><td>jabatan_nama</td><td>Operator Satker</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-14 10:59:14</td></tr></table>'),
(45, '2022-04-14 11:00:47', '127.0.0.1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Mahkamah Syar\'iyah Bireuen</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>-</td></tr><tr><td>nama_gelar</td><td>Mahkamah Syar\'iyah Bireuen</td></tr><tr><td>golongan_id</td><td>99</td></tr><tr><td>golongan</td><td>Pegawai Tidak Tetap</td></tr><tr><td>pangkat</td><td>Pegawai Tidak Tetap (PTT)</td></tr><tr><td>alamat</td><td>Aceh</td></tr><tr><td>chatid</td><td></td></tr><tr><td>jabatan_id</td><td>40</td></tr><tr><td>jabatan_nama</td><td>Operator Satker</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-14 11:00:47</td></tr></table>'),
(46, '2022-04-14 11:01:28', '127.0.0.1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Mahkamah Syar\'iyah Meureudeu</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>-</td></tr><tr><td>nama_gelar</td><td>Mahkamah Syar\'iyah Meureudeu</td></tr><tr><td>golongan_id</td><td>99</td></tr><tr><td>golongan</td><td>Pegawai Tidak Tetap</td></tr><tr><td>pangkat</td><td>Pegawai Tidak Tetap (PTT)</td></tr><tr><td>alamat</td><td>Aceh</td></tr><tr><td>chatid</td><td></td></tr><tr><td>jabatan_id</td><td>40</td></tr><tr><td>jabatan_nama</td><td>Operator Satker</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-14 11:01:27</td></tr></table>'),
(47, '2022-04-14 11:02:05', '127.0.0.1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Mahkamah Syar\'iyah Lhokseumawe</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>-</td></tr><tr><td>nama_gelar</td><td>Mahkamah Syar\'iyah Lhokseumawe</td></tr><tr><td>golongan_id</td><td>99</td></tr><tr><td>golongan</td><td>Pegawai Tidak Tetap</td></tr><tr><td>pangkat</td><td>Pegawai Tidak Tetap (PTT)</td></tr><tr><td>alamat</td><td>Aceh</td></tr><tr><td>chatid</td><td></td></tr><tr><td>jabatan_id</td><td>40</td></tr><tr><td>jabatan_nama</td><td>Operator Satker</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-14 11:02:05</td></tr></table>'),
(48, '2022-04-14 11:02:53', '127.0.0.1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Mahkamah Syar\'iyah Lhoksukon</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>-</td></tr><tr><td>nama_gelar</td><td>Mahkamah Syar\'iyah Lhoksukon</td></tr><tr><td>golongan_id</td><td>99</td></tr><tr><td>golongan</td><td>Pegawai Tidak Tetap</td></tr><tr><td>pangkat</td><td>Pegawai Tidak Tetap (PTT)</td></tr><tr><td>alamat</td><td>Aceh</td></tr><tr><td>chatid</td><td></td></tr><tr><td>jabatan_id</td><td>40</td></tr><tr><td>jabatan_nama</td><td>Operator Satker</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-14 11:02:52</td></tr></table>'),
(49, '2022-04-14 11:03:40', '127.0.0.1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Mahkamah Syar\'iyah Idi</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>-</td></tr><tr><td>nama_gelar</td><td>Mahkamah Syar\'iyah Idi</td></tr><tr><td>golongan_id</td><td>99</td></tr><tr><td>golongan</td><td>Pegawai Tidak Tetap</td></tr><tr><td>pangkat</td><td>Pegawai Tidak Tetap (PTT)</td></tr><tr><td>alamat</td><td>Aceh</td></tr><tr><td>chatid</td><td></td></tr><tr><td>jabatan_id</td><td>40</td></tr><tr><td>jabatan_nama</td><td>Operator Satker</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-14 11:03:40</td></tr></table>'),
(50, '2022-04-14 11:04:28', '127.0.0.1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Mahkamah Syar\'iyah Langsa</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>-</td></tr><tr><td>nama_gelar</td><td>Mahkamah Syar\'iyah Langsa</td></tr><tr><td>golongan_id</td><td>99</td></tr><tr><td>golongan</td><td>Pegawai Tidak Tetap</td></tr><tr><td>pangkat</td><td>Pegawai Tidak Tetap (PTT)</td></tr><tr><td>alamat</td><td>Aceh</td></tr><tr><td>chatid</td><td></td></tr><tr><td>jabatan_id</td><td>40</td></tr><tr><td>jabatan_nama</td><td>Operator Satker</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-14 11:04:28</td></tr></table>'),
(51, '2022-04-14 11:05:33', '127.0.0.1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Mahkamah Syar\'iyah Kuala Simpang</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>-</td></tr><tr><td>nama_gelar</td><td>Mahkamah Syar\'iyah Kuala Simpang</td></tr><tr><td>golongan_id</td><td>99</td></tr><tr><td>golongan</td><td>Pegawai Tidak Tetap</td></tr><tr><td>pangkat</td><td>Pegawai Tidak Tetap (PTT)</td></tr><tr><td>alamat</td><td>Aceh</td></tr><tr><td>chatid</td><td></td></tr><tr><td>jabatan_id</td><td>40</td></tr><tr><td>jabatan_nama</td><td>Operator Satker</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-14 11:05:33</td></tr></table>'),
(52, '2022-04-14 11:06:20', '127.0.0.1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Mahkamah Syar\'iyah Kutacane</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>-</td></tr><tr><td>nama_gelar</td><td>Mahkamah Syar\'iyah Kutacane</td></tr><tr><td>golongan_id</td><td>99</td></tr><tr><td>golongan</td><td>Pegawai Tidak Tetap</td></tr><tr><td>pangkat</td><td>Pegawai Tidak Tetap (PTT)</td></tr><tr><td>alamat</td><td>Aceh</td></tr><tr><td>chatid</td><td></td></tr><tr><td>jabatan_id</td><td>40</td></tr><tr><td>jabatan_nama</td><td>Operator Satker</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-14 11:06:20</td></tr></table>'),
(53, '2022-04-14 11:07:11', '127.0.0.1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Mahkamah Syar\'iyah Blangkejeren</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>-</td></tr><tr><td>nama_gelar</td><td>Mahkamah Syar\'iyah Blangkejeren</td></tr><tr><td>golongan_id</td><td>99</td></tr><tr><td>golongan</td><td>Pegawai Tidak Tetap</td></tr><tr><td>pangkat</td><td>Pegawai Tidak Tetap (PTT)</td></tr><tr><td>alamat</td><td>Aceh</td></tr><tr><td>chatid</td><td></td></tr><tr><td>jabatan_id</td><td>40</td></tr><tr><td>jabatan_nama</td><td>Operator Satker</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-14 11:07:11</td></tr></table>'),
(54, '2022-04-14 11:07:44', '127.0.0.1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Mahkamah Syar\'iyah Takengon</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>-</td></tr><tr><td>nama_gelar</td><td>Mahkamah Syar\'iyah Takengon</td></tr><tr><td>golongan_id</td><td>99</td></tr><tr><td>golongan</td><td>Pegawai Tidak Tetap</td></tr><tr><td>pangkat</td><td>Pegawai Tidak Tetap (PTT)</td></tr><tr><td>alamat</td><td>Aceh</td></tr><tr><td>chatid</td><td></td></tr><tr><td>jabatan_id</td><td>40</td></tr><tr><td>jabatan_nama</td><td>Operator Satker</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-14 11:07:44</td></tr></table>'),
(55, '2022-04-14 11:08:28', '127.0.0.1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Mahkamah Syar\'iyah Simpang Tiga Redelong</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>-</td></tr><tr><td>nama_gelar</td><td>Mahkamah Syar\'iyah Simpang Tiga Redelong</td></tr><tr><td>golongan_id</td><td>99</td></tr><tr><td>golongan</td><td>Pegawai Tidak Tetap</td></tr><tr><td>pangkat</td><td>Pegawai Tidak Tetap (PTT)</td></tr><tr><td>alamat</td><td>Aceh</td></tr><tr><td>chatid</td><td></td></tr><tr><td>jabatan_id</td><td>40</td></tr><tr><td>jabatan_nama</td><td>Operator Satker</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-14 11:08:28</td></tr></table>'),
(56, '2022-04-14 11:08:56', '127.0.0.1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Mahkamah Syar\'iyah Calang</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>-</td></tr><tr><td>nama_gelar</td><td>Mahkamah Syar\'iyah Calang</td></tr><tr><td>golongan_id</td><td>99</td></tr><tr><td>golongan</td><td>Pegawai Tidak Tetap</td></tr><tr><td>pangkat</td><td>Pegawai Tidak Tetap (PTT)</td></tr><tr><td>alamat</td><td>Aceh</td></tr><tr><td>chatid</td><td></td></tr><tr><td>jabatan_id</td><td>40</td></tr><tr><td>jabatan_nama</td><td>Operator Satker</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-14 11:08:56</td></tr></table>'),
(57, '2022-04-14 11:09:24', '127.0.0.1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Mahkamah Syar\'iyah Meulaboh</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>-</td></tr><tr><td>nama_gelar</td><td>Mahkamah Syar\'iyah Meulaboh</td></tr><tr><td>golongan_id</td><td>99</td></tr><tr><td>golongan</td><td>Pegawai Tidak Tetap</td></tr><tr><td>pangkat</td><td>Pegawai Tidak Tetap (PTT)</td></tr><tr><td>alamat</td><td>Aceh</td></tr><tr><td>chatid</td><td></td></tr><tr><td>jabatan_id</td><td>40</td></tr><tr><td>jabatan_nama</td><td>Operator Satker</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-14 11:09:24</td></tr></table>'),
(58, '2022-04-14 11:10:07', '127.0.0.1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Mahkamah Syar\'iyah Suka Makmue</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>401966</td></tr><tr><td>nama_gelar</td><td>Mahkamah Syar\'iyah Suka Makmue</td></tr><tr><td>golongan_id</td><td>99</td></tr><tr><td>golongan</td><td>Pegawai Tidak Tetap</td></tr><tr><td>pangkat</td><td>Pegawai Tidak Tetap (PTT)</td></tr><tr><td>alamat</td><td>Aceh</td></tr><tr><td>chatid</td><td></td></tr><tr><td>jabatan_id</td><td>40</td></tr><tr><td>jabatan_nama</td><td>Operator Satker</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-14 11:10:07</td></tr></table>'),
(59, '2022-04-14 11:10:32', '127.0.0.1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Mahkamah Syar\'iyah Blangpidie</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>401965</td></tr><tr><td>nama_gelar</td><td>Mahkamah Syar\'iyah Blangpidie</td></tr><tr><td>golongan_id</td><td>99</td></tr><tr><td>golongan</td><td>Pegawai Tidak Tetap</td></tr><tr><td>pangkat</td><td>Pegawai Tidak Tetap (PTT)</td></tr><tr><td>alamat</td><td>Aceh</td></tr><tr><td>chatid</td><td></td></tr><tr><td>jabatan_id</td><td>40</td></tr><tr><td>jabatan_nama</td><td>Operator Satker</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-14 11:10:32</td></tr></table>');
INSERT INTO `sys_audittrail` (`id`, `datetime`, `ipaddress`, `username`, `tablename`, `action`, `title`, `description`) VALUES
(60, '2022-04-14 11:11:17', '127.0.0.1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Mahkamah Syar\'iyah Tapaktuan</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>401968</td></tr><tr><td>nama_gelar</td><td>Mahkamah Syar\'iyah Tapaktuan</td></tr><tr><td>golongan_id</td><td>99</td></tr><tr><td>golongan</td><td>Pegawai Tidak Tetap</td></tr><tr><td>pangkat</td><td>Pegawai Tidak Tetap (PTT)</td></tr><tr><td>alamat</td><td>Aceh</td></tr><tr><td>chatid</td><td></td></tr><tr><td>jabatan_id</td><td>40</td></tr><tr><td>jabatan_nama</td><td>Operator Satker</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-14 11:11:17</td></tr></table>'),
(61, '2022-04-14 11:11:44', '127.0.0.1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Mahkamah Syar\'iyah Kota Subulussalam</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>401967</td></tr><tr><td>nama_gelar</td><td>Mahkamah Syar\'iyah Kota Subulussalam</td></tr><tr><td>golongan_id</td><td>99</td></tr><tr><td>golongan</td><td>Pegawai Tidak Tetap</td></tr><tr><td>pangkat</td><td>Pegawai Tidak Tetap (PTT)</td></tr><tr><td>alamat</td><td>Aceh</td></tr><tr><td>chatid</td><td></td></tr><tr><td>jabatan_id</td><td>40</td></tr><tr><td>jabatan_nama</td><td>Operator Satker</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-14 11:11:44</td></tr></table>'),
(62, '2022-04-14 11:12:08', '127.0.0.1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Mahkamah Syar\'iyah Singkil</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>-</td></tr><tr><td>nama_gelar</td><td>Mahkamah Syar\'iyah Singkil</td></tr><tr><td>golongan_id</td><td>99</td></tr><tr><td>golongan</td><td>Pegawai Tidak Tetap</td></tr><tr><td>pangkat</td><td>Pegawai Tidak Tetap (PTT)</td></tr><tr><td>alamat</td><td>Aceh</td></tr><tr><td>chatid</td><td></td></tr><tr><td>jabatan_id</td><td>40</td></tr><tr><td>jabatan_nama</td><td>Operator Satker</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-14 11:12:08</td></tr></table>'),
(63, '2022-04-14 11:12:50', '127.0.0.1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Mahkamah Syar\'iyah Sinabang</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>-</td></tr><tr><td>nama_gelar</td><td>Mahkamah Syar\'iyah Sinabang</td></tr><tr><td>golongan_id</td><td>99</td></tr><tr><td>golongan</td><td>Pegawai Tidak Tetap</td></tr><tr><td>pangkat</td><td>Pegawai Tidak Tetap (PTT)</td></tr><tr><td>alamat</td><td>Aceh</td></tr><tr><td>chatid</td><td></td></tr><tr><td>jabatan_id</td><td>40</td></tr><tr><td>jabatan_nama</td><td>Operator Satker</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-14 11:12:50</td></tr></table>'),
(64, '2022-04-14 11:13:24', '127.0.0.1', 'admin', 'pegawai', 'TAMBAH', 'Tambah Pegawai [Pegawai=<b>Mahkamah Syar\'iyah Sabang</b>]<br />Tambah tabel <b>pegawai</b>]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>nip</td><td>-</td></tr><tr><td>nama_gelar</td><td>Mahkamah Syar\'iyah Sabang</td></tr><tr><td>golongan_id</td><td>99</td></tr><tr><td>golongan</td><td>Pegawai Tidak Tetap</td></tr><tr><td>pangkat</td><td>Pegawai Tidak Tetap (PTT)</td></tr><tr><td>alamat</td><td>Aceh</td></tr><tr><td>chatid</td><td></td></tr><tr><td>jabatan_id</td><td>40</td></tr><tr><td>jabatan_nama</td><td>Operator Satker</td></tr><tr><td>aktif</td><td>Y</td></tr><tr><td>diinput_oleh</td><td>admin</td></tr><tr><td>diinput_tanggal</td><td>2022-04-14 11:13:24</td></tr></table>'),
(65, '2022-04-14 11:14:01', '127.0.0.1', '', 'sys_users', 'UPDATE', 'Edit Pengguna [Username=<b>zul</b>]<br />Edit table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=2]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>pegawai_id</td><td>1</td></tr><tr><td>fullname</td><td>Drs. H. Zulkifli Yus, S.H., M.H.</td></tr><tr><td>username</td><td>zul</td></tr><tr><td>password</td><td>8e1ad4da10b93f7e977cdc769275fcca</td></tr><tr><td>email</td><td>zulkifliyus@gmail.com</td></tr><tr><td>activation</td><td>134d34f6c88791eac7787b0c8b63446e</td></tr><tr><td>code_activation</td><td>b55124faf80288b701001cdb595718e7</td></tr><tr><td>block</td><td>1</td></tr><tr><td>modified_by</td><td>admin</td></tr><tr><td>modified_on</td><td>2022-04-14 11:14:01</td></tr></table>'),
(66, '2022-04-14 11:14:12', '127.0.0.1', '', 'sys_users', 'UPDATE', 'Edit Pengguna [Username=<b>syaf</b>]<br />Edit table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=3]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>pegawai_id</td><td>2</td></tr><tr><td>fullname</td><td>Drs. Syafruddin, M.H.</td></tr><tr><td>username</td><td>syaf</td></tr><tr><td>password</td><td>481e538a50b4d3967cffe7930ad41195</td></tr><tr><td>email</td><td>syaf@gmail.com</td></tr><tr><td>activation</td><td>47946ecc39a1e4b8598e5eb5ce501c67</td></tr><tr><td>code_activation</td><td>43a4f02dc83bdfaa8dae0d2fc02ab4db</td></tr><tr><td>block</td><td>1</td></tr><tr><td>modified_by</td><td>admin</td></tr><tr><td>modified_on</td><td>2022-04-14 11:14:12</td></tr></table>'),
(67, '2022-04-14 11:14:23', '127.0.0.1', '', 'sys_users', 'UPDATE', 'Edit Pengguna [Username=<b>zul</b>]<br />Edit table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=2]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>pegawai_id</td><td>1</td></tr><tr><td>fullname</td><td>Drs. H. Zulkifli Yus, S.H., M.H.</td></tr><tr><td>username</td><td>zul</td></tr><tr><td>password</td><td>66d768969b26e91113c1596d82971e93</td></tr><tr><td>email</td><td>zulkifliyus@gmail.com</td></tr><tr><td>activation</td><td>134d34f6c88791eac7787b0c8b63446e</td></tr><tr><td>code_activation</td><td>d4064bfa82f4147152eae3f040964b22</td></tr><tr><td>block</td><td>0</td></tr><tr><td>modified_by</td><td>admin</td></tr><tr><td>modified_on</td><td>2022-04-14 11:14:23</td></tr></table>'),
(68, '2022-04-14 11:14:31', '127.0.0.1', '', 'sys_users', 'UPDATE', 'Edit Pengguna [Username=<b>syaf</b>]<br />Edit table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=3]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>pegawai_id</td><td>2</td></tr><tr><td>fullname</td><td>Drs. Syafruddin, M.H.</td></tr><tr><td>username</td><td>syaf</td></tr><tr><td>password</td><td>e753354cdb4ac38a1451fc36f228e688</td></tr><tr><td>email</td><td>syaf@gmail.com</td></tr><tr><td>activation</td><td>47946ecc39a1e4b8598e5eb5ce501c67</td></tr><tr><td>code_activation</td><td>18dfa011784e9edf2edc4d6a52d00086</td></tr><tr><td>block</td><td>0</td></tr><tr><td>modified_by</td><td>admin</td></tr><tr><td>modified_on</td><td>2022-04-14 11:14:31</td></tr></table>'),
(69, '2022-04-14 11:14:44', '127.0.0.1', '', 'sys_users', 'UPDATE', 'Edit Pengguna [Username=<b>latif</b>]<br />Edit table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=4]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>pegawai_id</td><td>4</td></tr><tr><td>fullname</td><td>Abd. Latif, S.H, M.H.</td></tr><tr><td>username</td><td>latif</td></tr><tr><td>password</td><td>9509cfa69ce109456147944917d8a15b</td></tr><tr><td>email</td><td>latif@gmail.com</td></tr><tr><td>activation</td><td>b2c338be812955c4f9278d7574dfb902</td></tr><tr><td>code_activation</td><td>c1fb7f0faf04e5338650d983db5fec1e</td></tr><tr><td>block</td><td>0</td></tr><tr><td>modified_by</td><td>admin</td></tr><tr><td>modified_on</td><td>2022-04-14 11:14:44</td></tr></table>'),
(70, '2022-04-14 11:17:32', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>jainal</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=12]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>12</td></tr><tr><td>pegawai_id</td><td>11</td></tr><tr><td>fullname</td><td>Jainal Tabrani, S.H., M.H.</td></tr><tr><td>username</td><td>jainal</td></tr><tr><td>password</td><td>635584246c847bd9757dbf59166cc416</td></tr><tr><td>email</td><td>jainal@gmail.com</td></tr><tr><td>activation</td><td>09d208586699d89e4347bdcd4ac644ef</td></tr><tr><td>code_activation</td><td>094c94ff7dd3ada690142c5a4919375f</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 11:17:32</td></tr></table>'),
(71, '2022-04-14 11:17:49', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>yani</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=13]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>13</td></tr><tr><td>pegawai_id</td><td>12</td></tr><tr><td>fullname</td><td>Yani Riyanti, S.E., M.Si.</td></tr><tr><td>username</td><td>yani</td></tr><tr><td>password</td><td>5509fb379a8ee8cef2554ca4c6bb488d</td></tr><tr><td>email</td><td>yani@gmail.com</td></tr><tr><td>activation</td><td>13c3a733ff7a6619396eb6ca530877e1</td></tr><tr><td>code_activation</td><td>4f11c1ef2733cfadd5fa5f9b0f2c4551</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 11:17:49</td></tr></table>'),
(72, '2022-04-14 11:18:10', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>yosi</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=14]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>14</td></tr><tr><td>pegawai_id</td><td>13</td></tr><tr><td>fullname</td><td>Yosi Dirola, S.E.</td></tr><tr><td>username</td><td>yosi</td></tr><tr><td>password</td><td>cd85a7b7db29224d8be02c11069b98b1</td></tr><tr><td>email</td><td>yosi@gmail.com</td></tr><tr><td>activation</td><td>dbf7fbe79d01ce111c815477bbd2a8d9</td></tr><tr><td>code_activation</td><td>4c0dd36e2057b47a4cb2e4d20a307d66</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 11:18:10</td></tr></table>'),
(73, '2022-04-14 11:18:54', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>isnawati</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=15]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>15</td></tr><tr><td>pegawai_id</td><td>14</td></tr><tr><td>fullname</td><td>Isnawati, S.E.</td></tr><tr><td>username</td><td>isnawati</td></tr><tr><td>password</td><td>c807ae2574775687a8e9dc38c3fef089</td></tr><tr><td>email</td><td>isnawati@gmail.com</td></tr><tr><td>activation</td><td>3e494a49a5f62c4c60914721e1451d1d</td></tr><tr><td>code_activation</td><td>23439ae7e13b741a36211d155787a6ea</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 11:18:54</td></tr></table>'),
(74, '2022-04-14 11:19:20', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>monik</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=16]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>16</td></tr><tr><td>pegawai_id</td><td>15</td></tr><tr><td>fullname</td><td>Monik Zarinah, SE, M.Si.</td></tr><tr><td>username</td><td>monik</td></tr><tr><td>password</td><td>b8fa32ef86d7f12aa3344cd536c8b8d4</td></tr><tr><td>email</td><td>monik@gmail.com</td></tr><tr><td>activation</td><td>9cee0224526cc6b743da997b29aa8c80</td></tr><tr><td>code_activation</td><td>cf3e093403b56f0d90e415451c40d26c</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 11:19:20</td></tr></table>'),
(75, '2022-04-14 11:19:44', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>armada</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=17]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>17</td></tr><tr><td>pegawai_id</td><td>16</td></tr><tr><td>fullname</td><td>Armada, S.E.</td></tr><tr><td>username</td><td>armada</td></tr><tr><td>password</td><td>7cc6bf2d654eea3ce043d973e19e22d2</td></tr><tr><td>email</td><td>armada@gmail.com</td></tr><tr><td>activation</td><td>3dc1b12ffe6eab3d19c0be1853f34f49</td></tr><tr><td>code_activation</td><td>532519a21556fe7e8b08117cb5ddae99</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 11:19:44</td></tr></table>'),
(76, '2022-04-14 11:21:28', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>denny</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=18]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>18</td></tr><tr><td>pegawai_id</td><td>17</td></tr><tr><td>fullname</td><td>Denny Kurniawan, S.T.</td></tr><tr><td>username</td><td>denny</td></tr><tr><td>password</td><td>76fb278b58e4824fadd5cb74eaff2702</td></tr><tr><td>email</td><td>denny@gmail.com</td></tr><tr><td>activation</td><td>972139f169ff948089e1fad963f963e7</td></tr><tr><td>code_activation</td><td>c5f852415e34b951417718d96f980397</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 11:21:28</td></tr></table>'),
(77, '2022-04-14 11:21:52', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>hanafi</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=19]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>19</td></tr><tr><td>pegawai_id</td><td>18</td></tr><tr><td>fullname</td><td>Mohd Hanafi, S.H.I.</td></tr><tr><td>username</td><td>hanafi</td></tr><tr><td>password</td><td>a24f25ecff9559f272cc0554de9007be</td></tr><tr><td>email</td><td>hanafi@gmail.com</td></tr><tr><td>activation</td><td>8cba2204245736591046f33496c65e2d</td></tr><tr><td>code_activation</td><td>ca248e31696fc26dccc1b671531d89c2</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 11:21:52</td></tr></table>'),
(78, '2022-04-14 11:22:21', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>kadri</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=20]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>20</td></tr><tr><td>pegawai_id</td><td>19</td></tr><tr><td>fullname</td><td>Muhammad Kadri, S.T.</td></tr><tr><td>username</td><td>kadri</td></tr><tr><td>password</td><td>14829362a7d3af2c942117737e98812b</td></tr><tr><td>email</td><td>kadri@gmail.com</td></tr><tr><td>activation</td><td>a29a62c2d0bb34c81443b3dfec720d7c</td></tr><tr><td>code_activation</td><td>16ce2888a9c0651aef0c97c0fc36778d</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 11:22:21</td></tr></table>'),
(79, '2022-04-14 11:23:01', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>heri</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=21]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>21</td></tr><tr><td>pegawai_id</td><td>20</td></tr><tr><td>fullname</td><td>Heri Irawan, A.Md.</td></tr><tr><td>username</td><td>heri</td></tr><tr><td>password</td><td>eaebc433b225932230759f27dc82129a</td></tr><tr><td>email</td><td>heri@gmail.com</td></tr><tr><td>activation</td><td>0b9c5b1262c36d2551d83ee82d5cc723</td></tr><tr><td>code_activation</td><td>6de95380ba0e113fdf370ede4c20ada3</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 11:23:01</td></tr></table>'),
(80, '2022-04-14 11:23:30', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>msbna</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=22]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>22</td></tr><tr><td>pegawai_id</td><td>22</td></tr><tr><td>fullname</td><td>Mahkamah Syar\'iyah Banda Aceh</td></tr><tr><td>username</td><td>msbna</td></tr><tr><td>password</td><td>341841db54973cb54eb22c45cb85ff63</td></tr><tr><td>email</td><td>msbna@gmail.com</td></tr><tr><td>activation</td><td>500bd61f77ce2566138eec5081794b10</td></tr><tr><td>code_activation</td><td>afcc76ef170e7289169034ae0ad8867d</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 11:23:30</td></tr></table>'),
(81, '2022-04-14 11:24:00', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>msjnt</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=23]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>23</td></tr><tr><td>pegawai_id</td><td>23</td></tr><tr><td>fullname</td><td>Mahkamah Syar\'iyah Jantho</td></tr><tr><td>username</td><td>msjnt</td></tr><tr><td>password</td><td>4ccac38766011a4b2d60104d182b1d5d</td></tr><tr><td>email</td><td>msjnt@gmail.com</td></tr><tr><td>activation</td><td>b496a01f205b567196ac0e8d954d3863</td></tr><tr><td>code_activation</td><td>a7fecfad48e2c2f74902d4d622901049</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 11:23:59</td></tr></table>'),
(82, '2022-04-14 11:24:26', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>mssgl</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=24]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>24</td></tr><tr><td>pegawai_id</td><td>26</td></tr><tr><td>fullname</td><td>Mahkamah Syar\'iyah Sigli</td></tr><tr><td>username</td><td>mssgl</td></tr><tr><td>password</td><td>39d5203c83c261533c9e1049b2ece2a4</td></tr><tr><td>email</td><td>mssgl@gmail.com</td></tr><tr><td>activation</td><td>e3592a01ea362ea44413b9c2bc157014</td></tr><tr><td>code_activation</td><td>0daa20a6e53cdb002c0e6835c1c8fe38</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 11:24:26</td></tr></table>'),
(83, '2022-04-14 11:24:47', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>msbrn</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=25]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>25</td></tr><tr><td>pegawai_id</td><td>27</td></tr><tr><td>fullname</td><td>Mahkamah Syar\'iyah Bireuen</td></tr><tr><td>username</td><td>msbrn</td></tr><tr><td>password</td><td>ed835809d4821021a56e09ab1d79f34c</td></tr><tr><td>email</td><td>msbrn@gmail.com</td></tr><tr><td>activation</td><td>1b0b2c4fa6eec8a1a84f8f60dfba7974</td></tr><tr><td>code_activation</td><td>c1f3d901e7bcbb081aeb9d8c2455cccf</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 11:24:47</td></tr></table>'),
(84, '2022-04-14 11:25:47', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>msmrd</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=26]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>26</td></tr><tr><td>pegawai_id</td><td>28</td></tr><tr><td>fullname</td><td>Mahkamah Syar\'iyah Meureudeu</td></tr><tr><td>username</td><td>msmrd</td></tr><tr><td>password</td><td>6181bfaca83fb5547efe7c6ebe31ff22</td></tr><tr><td>email</td><td>msmrd@gmail.com</td></tr><tr><td>activation</td><td>d79bfb71b22e470eee14ed92d14026c8</td></tr><tr><td>code_activation</td><td>2e51a1a4c633c4c6958a662bdfbda72f</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 11:25:47</td></tr></table>'),
(85, '2022-04-14 11:26:36', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>mslsm</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=27]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>27</td></tr><tr><td>pegawai_id</td><td>29</td></tr><tr><td>fullname</td><td>Mahkamah Syar\'iyah Lhokseumawe</td></tr><tr><td>username</td><td>mslsm</td></tr><tr><td>password</td><td>eec6d64925a4dd85462b0d244b812846</td></tr><tr><td>email</td><td>mslsm@gmail.com</td></tr><tr><td>activation</td><td>02baa657b81a24d3e1e41bbb65a4c333</td></tr><tr><td>code_activation</td><td>45fc81d7b3b698593422459dfef0e2c5</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 11:26:36</td></tr></table>'),
(86, '2022-04-14 11:27:13', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>mslsk</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=28]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>28</td></tr><tr><td>pegawai_id</td><td>30</td></tr><tr><td>fullname</td><td>Mahkamah Syar\'iyah Lhoksukon</td></tr><tr><td>username</td><td>mslsk</td></tr><tr><td>password</td><td>bd9d113f5c097e4f34e1ad8450400c7d</td></tr><tr><td>email</td><td>mslsk@gmail.com</td></tr><tr><td>activation</td><td>bf5d6586821953a6b68073925d424e83</td></tr><tr><td>code_activation</td><td>6fd62dc36f637061bde4fe8feeffd148</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 11:27:12</td></tr></table>'),
(87, '2022-04-14 11:27:36', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>msidi</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=29]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>29</td></tr><tr><td>pegawai_id</td><td>31</td></tr><tr><td>fullname</td><td>Mahkamah Syar\'iyah Idi</td></tr><tr><td>username</td><td>msidi</td></tr><tr><td>password</td><td>574c97a2443409804121ded3a8208237</td></tr><tr><td>email</td><td>msidi@gmail.com</td></tr><tr><td>activation</td><td>3a1729e0e29428c40991278b2a895b07</td></tr><tr><td>code_activation</td><td>dd5254b54327100ae3d37c1ae0db738e</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 11:27:36</td></tr></table>'),
(88, '2022-04-14 11:28:02', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>mslgs</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=30]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>30</td></tr><tr><td>pegawai_id</td><td>32</td></tr><tr><td>fullname</td><td>Mahkamah Syar\'iyah Langsa</td></tr><tr><td>username</td><td>mslgs</td></tr><tr><td>password</td><td>188e681fc8bcfda31211cd4922649c71</td></tr><tr><td>email</td><td>mslgs@gmail.com</td></tr><tr><td>activation</td><td>f95ec7825c09781e4d271eb245ae3be2</td></tr><tr><td>code_activation</td><td>1e9a4b35141d01451d94fb46ec5a1a4e</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 11:28:02</td></tr></table>'),
(89, '2022-04-14 11:28:46', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>msksp</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=31]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>31</td></tr><tr><td>pegawai_id</td><td>33</td></tr><tr><td>fullname</td><td>Mahkamah Syar\'iyah Kuala Simpang</td></tr><tr><td>username</td><td>msksp</td></tr><tr><td>password</td><td>71e2b90b5c98d89bacdc508399cf3cb3</td></tr><tr><td>email</td><td>msksp@gmail.com</td></tr><tr><td>activation</td><td>b4bb34d88a7fd4b4b594210be8004006</td></tr><tr><td>code_activation</td><td>bd9a51ba643deea826427825d66d55a8</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 11:28:46</td></tr></table>'),
(90, '2022-04-14 11:29:12', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>mskcn</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=32]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>32</td></tr><tr><td>pegawai_id</td><td>34</td></tr><tr><td>fullname</td><td>Mahkamah Syar\'iyah Kutacane</td></tr><tr><td>username</td><td>mskcn</td></tr><tr><td>password</td><td>8c956e40599425d1d75d8fc3856a0aa8</td></tr><tr><td>email</td><td>mskcn@gmail.com</td></tr><tr><td>activation</td><td>06d697cded8bec6f1f58b28aa992667e</td></tr><tr><td>code_activation</td><td>962cabaca9b5457d90737350821fcb06</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 11:29:12</td></tr></table>'),
(91, '2022-04-14 11:29:41', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>msbkj</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=33]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>33</td></tr><tr><td>pegawai_id</td><td>35</td></tr><tr><td>fullname</td><td>Mahkamah Syar\'iyah Blangkejeren</td></tr><tr><td>username</td><td>msbkj</td></tr><tr><td>password</td><td>9ed8dfa924d8193ccf9be0d479ea78ab</td></tr><tr><td>email</td><td>msbkj@gmail.com</td></tr><tr><td>activation</td><td>43a09eee6b3c4aa7eeb26c4413f55ff4</td></tr><tr><td>code_activation</td><td>ac4d11682480c7b152f9b996a627fd3c</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 11:29:41</td></tr></table>'),
(92, '2022-04-14 11:30:05', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>mstkn</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=34]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>34</td></tr><tr><td>pegawai_id</td><td>36</td></tr><tr><td>fullname</td><td>Mahkamah Syar\'iyah Takengon</td></tr><tr><td>username</td><td>mstkn</td></tr><tr><td>password</td><td>d57bad9a32797323b03ef1bcd51bdf87</td></tr><tr><td>email</td><td>mstkn@gmail.com</td></tr><tr><td>activation</td><td>8c2ee1203fa6aba2f1bb2ca115e96dbe</td></tr><tr><td>code_activation</td><td>fb25069b051e4a9d01c7371beafebcc7</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 11:30:05</td></tr></table>'),
(93, '2022-04-14 11:30:32', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>msstr</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=35]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>35</td></tr><tr><td>pegawai_id</td><td>37</td></tr><tr><td>fullname</td><td>Mahkamah Syar\'iyah Simpang Tiga Redelong</td></tr><tr><td>username</td><td>msstr</td></tr><tr><td>password</td><td>d691546f8c8e1db394890a09cb3492ec</td></tr><tr><td>email</td><td>msstr@gmail.com</td></tr><tr><td>activation</td><td>7ab27ff6847fc3f119d28ea3c1258428</td></tr><tr><td>code_activation</td><td>6dff7e2ea06e137e6b61cf0031c14d49</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 11:30:32</td></tr></table>'),
(94, '2022-04-14 11:30:55', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>mscln</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=36]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>36</td></tr><tr><td>pegawai_id</td><td>38</td></tr><tr><td>fullname</td><td>Mahkamah Syar\'iyah Calang</td></tr><tr><td>username</td><td>mscln</td></tr><tr><td>password</td><td>87158e7c4edbfeb93aee121e3b19cda7</td></tr><tr><td>email</td><td>mscln@gmail.com</td></tr><tr><td>activation</td><td>846fa04aa0f84df7a4aa1b4d4341418a</td></tr><tr><td>code_activation</td><td>c65b477a769478182f61d778de29d58b</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 11:30:55</td></tr></table>'),
(95, '2022-04-14 11:31:24', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>msmlb</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=37]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>37</td></tr><tr><td>pegawai_id</td><td>39</td></tr><tr><td>fullname</td><td>Mahkamah Syar\'iyah Meulaboh</td></tr><tr><td>username</td><td>msmlb</td></tr><tr><td>password</td><td>e0d826b2d649d624bb6c4dbc15d4ce69</td></tr><tr><td>email</td><td>msmlb@gmail.com</td></tr><tr><td>activation</td><td>e738ebb964437e99e6a2501f9f3eb8aa</td></tr><tr><td>code_activation</td><td>e80d99fc1bd5899b421e835867e4a983</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 11:31:24</td></tr></table>'),
(96, '2022-04-14 11:32:05', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>msskm</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=38]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>38</td></tr><tr><td>pegawai_id</td><td>40</td></tr><tr><td>fullname</td><td>Mahkamah Syar\'iyah Suka Makmue</td></tr><tr><td>username</td><td>msskm</td></tr><tr><td>password</td><td>a091fc2afaaccb83955c8ad2a02fc6f8</td></tr><tr><td>email</td><td>msskm@gmail.com</td></tr><tr><td>activation</td><td>7e49c1e1ab966b139ad7a46ea1442edb</td></tr><tr><td>code_activation</td><td>2979ff10d0f41364541bd74170e3e282</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 11:32:05</td></tr></table>'),
(97, '2022-04-14 11:33:01', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>msbpd</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=39]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>39</td></tr><tr><td>pegawai_id</td><td>41</td></tr><tr><td>fullname</td><td>Mahkamah Syar\'iyah Blangpidie</td></tr><tr><td>username</td><td>msbpd</td></tr><tr><td>password</td><td>c5abef3ef5ca6b9ecf5fddab58f0d563</td></tr><tr><td>email</td><td>msbpd@gmail.com</td></tr><tr><td>activation</td><td>bdae43f10532c72a901b60523af3c586</td></tr><tr><td>code_activation</td><td>469896e80d2afd4da278cd5e1c70a79b</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 11:33:00</td></tr></table>'),
(98, '2022-04-14 11:33:38', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>msttn</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=40]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>40</td></tr><tr><td>pegawai_id</td><td>42</td></tr><tr><td>fullname</td><td>Mahkamah Syar\'iyah Tapaktuan</td></tr><tr><td>username</td><td>msttn</td></tr><tr><td>password</td><td>876508aa6a318427147fd3e60fe3f688</td></tr><tr><td>email</td><td>msttn@gmail.com</td></tr><tr><td>activation</td><td>856bfa0f5d89ebfb0d38c0fb2a6457ea</td></tr><tr><td>code_activation</td><td>d31f7abd24f1bebe0b90b76ce4a2ff7e</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 11:33:38</td></tr></table>'),
(99, '2022-04-14 11:34:01', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>mssus</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=41]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>41</td></tr><tr><td>pegawai_id</td><td>43</td></tr><tr><td>fullname</td><td>Mahkamah Syar\'iyah Kota Subulussalam</td></tr><tr><td>username</td><td>mssus</td></tr><tr><td>password</td><td>ed1c9bc2163c82fad2594e97d75f5412</td></tr><tr><td>email</td><td>mssus@gmail.com</td></tr><tr><td>activation</td><td>b90a7ca923f4c9a7936be5fd2fb03807</td></tr><tr><td>code_activation</td><td>e95e1a32c7f45431ceb04b7996c17a1a</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 11:34:01</td></tr></table>'),
(100, '2022-04-14 11:34:21', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>msskl</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=42]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>42</td></tr><tr><td>pegawai_id</td><td>44</td></tr><tr><td>fullname</td><td>Mahkamah Syar\'iyah Singkil</td></tr><tr><td>username</td><td>msskl</td></tr><tr><td>password</td><td>7247e57fb004c15e7ea8ae020001e6bf</td></tr><tr><td>email</td><td>msskl@gmail.com</td></tr><tr><td>activation</td><td>b2f8294a463a23f88db47cc251ce3a4f</td></tr><tr><td>code_activation</td><td>2545a7087d7e11ba4d28d5f006c6c0a9</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 11:34:20</td></tr></table>'),
(101, '2022-04-14 11:34:41', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>mssnb</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=43]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>43</td></tr><tr><td>pegawai_id</td><td>45</td></tr><tr><td>fullname</td><td>Mahkamah Syar\'iyah Sinabang</td></tr><tr><td>username</td><td>mssnb</td></tr><tr><td>password</td><td>99afe6bef9d5d75260623111270ff40a</td></tr><tr><td>email</td><td>mssnb@gmail.com</td></tr><tr><td>activation</td><td>180b61051e85da5d233741547373ff88</td></tr><tr><td>code_activation</td><td>02fbdd1dbae8febe59c048554045ff96</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 11:34:41</td></tr></table>'),
(102, '2022-04-14 11:36:04', '127.0.0.1', '', 'sys_users', 'INSERT', 'Tambah Pengguna [Username=<b>mssbg</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=44]', '<br><table style=\"vertical-align:top\" cellspacing=\"0\" cellpadding=\"1\" border=\"1\"><tr><th>Nama Kolom</th><th>Nilai</th></tr><tr><td>userid</td><td>44</td></tr><tr><td>pegawai_id</td><td>46</td></tr><tr><td>fullname</td><td>Mahkamah Syar\'iyah Sabang</td></tr><tr><td>username</td><td>mssbg</td></tr><tr><td>password</td><td>8e87bd787ae4ec955452171f0bf1221b</td></tr><tr><td>email</td><td>mssbg@gmail.com</td></tr><tr><td>activation</td><td>ad1ba3109fe85ad901845fcbd656d1b0</td></tr><tr><td>code_activation</td><td>63471ca531933816db83fdcc743f17bb</td></tr><tr><td>block</td><td>0</td></tr><tr><td>created_by</td><td>admin</td></tr><tr><td>created_on</td><td>2022-04-14 11:36:04</td></tr></table>');

-- --------------------------------------------------------

--
-- Struktur dari tabel `sys_config`
--

CREATE TABLE `sys_config` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'Primari Key',
  `category` varchar(50) NOT NULL DEFAULT 'System' COMMENT 'Kategori Konfigurasi',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT 'Nama Konfigurasi',
  `value` varchar(255) DEFAULT NULL,
  `ordering` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Urutan'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Data Konfigurasi Sistem';

--
-- Dumping data untuk tabel `sys_config`
--

INSERT INTO `sys_config` (`id`, `category`, `name`, `value`, `ordering`) VALUES
(1, 'system', 'SiteName', 'Register Surat Masuk dan Keluar', 0),
(2, 'system', 'SiteTitle', 'Register Surat Masuk dan Keluar', 0),
(3, 'system', 'KodePN', '401582', 0),
(4, 'system', 'NamaPN', 'MAHKAMAH SYAR\'IYAH ACEH', 0),
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
(23, 'System', 'KodeSurat', 'W1-A', 0),
(24, 'System', 'FormatAgendaSurat', 'NMR_AGENDA/TAHUN_AGENDA', 0),
(25, 'System', 'FormatSuratKeterangan', '#NMR_SK#/SK/HK/#BLN#/#THN#/#KD_PN#', 0),
(26, 'System', 'KodePerkara', 'MS.ACEH', 0),
(27, 'System', 'NamaKotaKab', '', 0),
(28, 'System', 'FormatRegisterPenyitaan', '#NMR_SK#/Pen.Pid/#THN#/#KD_PN#', 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `sys_groups`
--

CREATE TABLE `sys_groups` (
  `groupid` int(11) NOT NULL COMMENT 'Primary Key: (by system)',
  `parent_id` int(11) DEFAULT NULL COMMENT 'Grup induk: merujuk ke tabel sys_groups kolom groupid',
  `level` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Level tree (by system)',
  `lft` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set left:(by system)',
  `rgt` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set right:(by system)',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT 'Nama Grup: isian bebas',
  `inter_exter` tinyint(1) NOT NULL COMMENT '1=Internal, 2=External',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT 'Keterangan: isian bebas',
  `enable` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Aktif: pilihan 1=Ya; 0=Tidak',
  `ordering` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Urutan Grup Per Induknya',
  `lock_by` varchar(30) NOT NULL DEFAULT '' COMMENT 'Diedit Oleh: (by system)',
  `lock_on` datetime DEFAULT NULL COMMENT 'Diedit Tanggal: (by system)',
  `created_by` varchar(30) DEFAULT NULL COMMENT 'Diinput Oleh: (by system)',
  `created_on` datetime DEFAULT NULL COMMENT 'Diinput Tanggal: (by system)',
  `modified_by` varchar(30) DEFAULT NULL COMMENT 'Diperbaharui Oleh: (by system)',
  `modified_on` datetime DEFAULT NULL COMMENT 'Diperbaharui Tanggal: (by system)'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Data Grup User aplikasi';

--
-- Dumping data untuk tabel `sys_groups`
--

INSERT INTO `sys_groups` (`groupid`, `parent_id`, `level`, `lft`, `rgt`, `name`, `inter_exter`, `description`, `enable`, `ordering`, `lock_by`, `lock_on`, `created_by`, `created_on`, `modified_by`, `modified_on`) VALUES
(-1, NULL, 0, 1, 62, 'Root', 1, 'Root', 1, 1, '', NULL, NULL, NULL, NULL, NULL),
(1, -1, 1, 2, 61, 'Super Administrator', 1, 'Super Administrator', 1, 1, 'system', '2013-02-08 11:02:03', '', NULL, 'admin', '2012-11-13 12:44:56'),
(2, 1, 2, 3, 4, 'Ketua', 1, 'Ketua', 1, 1, '', NULL, 'admin', '2017-10-08 08:43:05', '', NULL),
(3, 1, 2, 5, 6, 'Wakil Ketua ', 1, 'Wakil Ketua ', 1, 2, '', NULL, 'admin', '2017-10-08 08:43:20', '', '2017-10-08 08:45:17'),
(4, 1, 2, 7, 46, 'Panitera', 1, 'Panitera', 1, 3, '', NULL, 'admin', '2017-10-08 08:46:01', '', '2017-10-08 08:46:24'),
(5, 4, 3, 8, 11, 'Panitera Muda Jinayat', 1, 'Kepaniteraan Muda Jinayat', 1, 1, '', NULL, 'admin', '2017-10-08 08:46:44', '', NULL),
(6, 4, 3, 12, 15, 'Panitera Muda Banding', 1, 'Kepaniteraan Muda Banding', 1, 2, '', NULL, 'admin', '2017-10-08 08:47:38', '', NULL),
(7, 4, 3, 16, 19, 'Panitera Muda Hukum', 1, 'Kepaniteraan Muda Gugatan', 1, 3, '', NULL, 'admin', '2017-10-08 08:48:06', '', NULL),
(8, 4, 4, 25, 26, 'Panitera Pengganti', 1, '', 1, 10, '', NULL, 'admin', '2017-10-08 08:52:49', '', NULL),
(9, 4, 4, 27, 28, 'Jurusita / Jurusita Pengganti', 1, '', 1, 11, '', NULL, 'admin', '2017-10-08 08:53:18', '', NULL),
(16, 1, 2, 47, 80, 'Sekretaris', 1, 'Sekretaris', 1, 4, '', NULL, 'admin', '2017-10-08 08:54:41', '', NULL),
(17, 32, 4, 58, 61, 'Kepala Sub Bagian Kepegawaian dan TI', 1, '', 1, 1, '', NULL, 'admin', '2017-10-08 08:55:50', '', '2017-10-08 08:58:29'),
(18, 32, 4, 62, 65, 'Kepala Sub Bagian Renprog', 1, '', 1, 2, '', NULL, 'admin', '2017-10-08 08:59:20', '', NULL),
(19, 31, 4, 53, 54, 'Kepala Sub Bagian TURT', 1, '', 1, 3, '', NULL, 'admin', '2017-10-08 08:59:54', '', NULL),
(20, 5, 5, 9, 10, 'Staf Panitera Muda Jinayat', 1, '', 0, 1, '', NULL, 'admin', '2017-10-08 09:04:32', '', NULL),
(21, 6, 5, 13, 14, 'Staf Panitera Muda Banding', 1, '', 0, 1, '', NULL, 'admin', '2017-10-08 09:04:45', '', NULL),
(22, 7, 5, 17, 18, 'Staf Panitera Muda Hukum', 1, '', 0, 1, '', NULL, 'admin', '2017-10-08 09:04:57', '', NULL),
(24, 16, 4, 65, 66, 'Pranata Komputer', 1, '', 1, 1, '', NULL, 'admin', '2017-10-08 09:05:24', '', NULL),
(25, 16, 4, 67, 68, 'Pengelola Keuangan', 1, '', 1, 1, '', NULL, 'admin', '2017-10-08 09:05:40', '', NULL),
(26, 16, 4, 69, 70, 'Pranata Keuangan', 1, '', 1, 1, '', NULL, 'admin', '2017-10-08 09:05:52', '', NULL),
(27, 4, 4, 29, 30, 'Pranata Peradilan', 1, '', 1, 1, '', NULL, 'admin', '2017-10-08 09:06:10', '', NULL),
(28, 17, 5, 60, 61, 'Staf Sub Bagian Kepegawaian dan TI', 1, '', 0, 1, '', NULL, 'admin', '2017-10-08 09:06:53', '', NULL),
(29, 18, 5, 64, 65, 'Staf Sub Bagian Renprog', 1, '', 0, 1, '', NULL, 'admin', '2017-10-08 09:07:06', '', NULL),
(30, 31, 4, 55, 56, 'Kepala Sub Bagian Keuangan dan Pelaporan', 1, '', 1, 1, '', NULL, 'admin', '2017-10-08 09:07:21', '', NULL),
(31, 16, 3, 48, 56, 'Kabag Umum dan Keuangan', 1, '', 1, 0, '', NULL, NULL, NULL, NULL, NULL),
(32, 16, 3, 57, 64, 'Kabag Perencanaan dan Kepegawaian', 1, '', 1, 0, '', NULL, NULL, NULL, NULL, NULL),
(33, 2, 2, 71, 72, 'Pengurus IKAHI', 1, '', 1, 0, '', NULL, NULL, NULL, NULL, NULL),
(34, 2, 2, 73, 74, 'Pengurus IPASPI', 1, '', 1, 0, '', NULL, NULL, NULL, NULL, NULL),
(35, 2, 2, 75, 76, 'Pengurus PTWP', 1, '', 1, 0, '', NULL, NULL, NULL, NULL, NULL),
(36, 2, 2, 77, 78, 'Pengurus Dharmayukti Karini', 1, '', 1, 0, '', NULL, NULL, NULL, NULL, NULL),
(37, 2, 2, 79, 80, 'Pengurus Koperasi', 1, '', 1, 0, '', NULL, NULL, NULL, NULL, NULL),
(38, 2, 2, 81, 82, 'Pengurus PPHIMM', 1, '', 1, 0, '', NULL, NULL, NULL, NULL, NULL),
(39, 2, 2, 83, 84, 'Pengurus ZIS', 1, '', 1, 0, '', NULL, NULL, NULL, NULL, NULL),
(40, 2, 2, 85, 86, 'Operator Satker', 0, '', 1, 0, '', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `sys_users`
--

CREATE TABLE `sys_users` (
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
) ENGINE=InnoDB AVG_ROW_LENGTH=372 DEFAULT CHARSET=latin1 COMMENT='Data User';

--
-- Dumping data untuk tabel `sys_users`
--

INSERT INTO `sys_users` (`userid`, `pegawai_id`, `fullname`, `username`, `password`, `old_password`, `email`, `alternative_email`, `allow_concurrent_login`, `has_change_password`, `enable_change_password`, `last_change_password`, `password_expired_remainder`, `attemp_count`, `attemp_time`, `user_expired`, `last_login`, `block`, `activation`, `code_activation`, `params`, `lock_by`, `lock_on`, `created_by`, `created_on`, `modified_by`, `modified_on`) VALUES
(1, 0, 'Super Administrator', 'admin', '22d3b91575acfd31a747aa90148723e2', '9e24d23de65f136b32ef8ffaad9d2086;9e24d23de65f136b32ef8ffaad9d2086;', 'admin@mail.go.id', '', -1, 1, 1, '2013-03-08 10:47:55', -1, 0, NULL, NULL, '2017-09-06 09:44:56', 0, 'b1a9d413781b40e7961c8c48a024f24e', '1672e5d8d1ae74efbe5d36c5c64b518f', '', '', NULL, '', '2011-03-22 23:36:46', 'system', '2012-08-29 00:15:45'),
(2, 1, 'Drs. H. Zulkifli Yus, S.H., M.H.', 'zul', '66d768969b26e91113c1596d82971e93', '', 'zulkifliyus@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, '134d34f6c88791eac7787b0c8b63446e', 'd4064bfa82f4147152eae3f040964b22', '', '', NULL, 'admin', '2021-08-04 03:29:52', 'admin', '2022-04-14 11:14:23'),
(3, 2, 'Drs. Syafruddin, M.H.', 'syaf', 'e753354cdb4ac38a1451fc36f228e688', '', 'syaf@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, '47946ecc39a1e4b8598e5eb5ce501c67', '18dfa011784e9edf2edc4d6a52d00086', '', '', NULL, 'admin', '2021-08-04 03:31:48', 'admin', '2022-04-14 11:14:31'),
(4, 4, 'Abd. Latif, S.H, M.H.', 'latif', '9509cfa69ce109456147944917d8a15b', '', 'latif@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, 'b2c338be812955c4f9278d7574dfb902', 'c1fb7f0faf04e5338650d983db5fec1e', '', '', NULL, 'admin', '2021-08-04 04:17:50', 'admin', '2022-04-14 11:14:44'),
(6, 5, 'Bahrun, S.H., M.H.', 'bahrun', 'e0c2383bdab93f0e3561f5142d3a9e67', '', 'bahrun@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, '62b7346f87f1f8e3bfb199ea4a458509', '3aff72b9fac7a9ca2ee560feed82b44f', '', '', NULL, 'admin', '2021-08-04 04:54:19', 'admin', '2022-04-12 08:12:13'),
(7, 6, 'H. Hilman Lubis, S.H., M.H.', 'hilman', '3cef1d538d50997a0db50d7d568456d0', '', 'hilman@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, 'd289d16fc20e8ac4f00e59e1e66f0cf6', 'd78477723a1dc7c22d920b363d0aec61', '', '', NULL, 'admin', '2021-08-04 04:55:54', 'admin', '2022-04-12 08:06:24'),
(8, 7, 'Drs. Ilyas, S.H., M.H', 'ilyas', '4a5211cf2de2e5897cbec7f2c4203f63', '', 'ilyas@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, 'b65d370f50477300fcbd02ebfcd9bbd3', '87a55d74550b86c4d46e57f14c79eb69', '', '', NULL, 'admin', '2021-08-04 04:56:19', NULL, NULL),
(9, 8, 'Ratna Juita, S.Ag., S.H., M.H.', 'ratna', 'c7f5ef59a1c532aa27a806ae50ee0408', '', 'ratna@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, '2cc45ccf733c5eabaf811a29f99baee4', '94d9f3bb2c087dae935fe4e521bf6e71', '', '', NULL, 'admin', '2021-08-04 04:56:46', 'admin', '2022-04-12 08:12:28'),
(10, 9, 'Mirza, S.H., M.H.', 'mirza', 'c0f01a07caadb936988de6ec242f9bf5', '', 'mirza@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, '5974e0f5104f30795175de362e35d317', '2a7930e39b6cda30aff7bb18ab1120c7', '', '', NULL, 'admin', '2022-04-12 06:11:01', 'zul', '2022-04-12 06:13:58'),
(11, 10, 'Fahmi Riswin, S.E.Ak.', 'fahmi', '31231a278ac42727631a7c444185378b', '', 'fahmi@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, '3cd36cd8ef15bffa11f2b89689796778', 'd0eb55437c9b78c5e0b466dd0b0a2a40', '', '', NULL, 'admin', '2022-04-12 06:19:54', NULL, NULL),
(12, 11, 'Jainal Tabrani, S.H., M.H.', 'jainal', '635584246c847bd9757dbf59166cc416', '', 'jainal@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, '09d208586699d89e4347bdcd4ac644ef', '094c94ff7dd3ada690142c5a4919375f', '', '', NULL, 'admin', '2022-04-14 11:17:32', NULL, NULL),
(13, 12, 'Yani Riyanti, S.E., M.Si.', 'yani', '5509fb379a8ee8cef2554ca4c6bb488d', '', 'yani@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, '13c3a733ff7a6619396eb6ca530877e1', '4f11c1ef2733cfadd5fa5f9b0f2c4551', '', '', NULL, 'admin', '2022-04-14 11:17:49', NULL, NULL),
(14, 13, 'Yosi Dirola, S.E.', 'yosi', 'cd85a7b7db29224d8be02c11069b98b1', '', 'yosi@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, 'dbf7fbe79d01ce111c815477bbd2a8d9', '4c0dd36e2057b47a4cb2e4d20a307d66', '', '', NULL, 'admin', '2022-04-14 11:18:10', NULL, NULL),
(15, 14, 'Isnawati, S.E.', 'isnawati', 'c807ae2574775687a8e9dc38c3fef089', '', 'isnawati@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, '3e494a49a5f62c4c60914721e1451d1d', '23439ae7e13b741a36211d155787a6ea', '', '', NULL, 'admin', '2022-04-14 11:18:54', NULL, NULL),
(16, 15, 'Monik Zarinah, SE, M.Si.', 'monik', 'b8fa32ef86d7f12aa3344cd536c8b8d4', '', 'monik@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, '9cee0224526cc6b743da997b29aa8c80', 'cf3e093403b56f0d90e415451c40d26c', '', '', NULL, 'admin', '2022-04-14 11:19:20', NULL, NULL),
(17, 16, 'Armada, S.E.', 'armada', '7cc6bf2d654eea3ce043d973e19e22d2', '', 'armada@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, '3dc1b12ffe6eab3d19c0be1853f34f49', '532519a21556fe7e8b08117cb5ddae99', '', '', NULL, 'admin', '2022-04-14 11:19:44', NULL, NULL),
(18, 17, 'Denny Kurniawan, S.T.', 'denny', '76fb278b58e4824fadd5cb74eaff2702', '', 'denny@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, '972139f169ff948089e1fad963f963e7', 'c5f852415e34b951417718d96f980397', '', '', NULL, 'admin', '2022-04-14 11:21:28', NULL, NULL),
(19, 18, 'Mohd Hanafi, S.H.I.', 'hanafi', 'a24f25ecff9559f272cc0554de9007be', '', 'hanafi@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, '8cba2204245736591046f33496c65e2d', 'ca248e31696fc26dccc1b671531d89c2', '', '', NULL, 'admin', '2022-04-14 11:21:52', NULL, NULL),
(20, 19, 'Muhammad Kadri, S.T.', 'kadri', '14829362a7d3af2c942117737e98812b', '', 'kadri@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, 'a29a62c2d0bb34c81443b3dfec720d7c', '16ce2888a9c0651aef0c97c0fc36778d', '', '', NULL, 'admin', '2022-04-14 11:22:21', NULL, NULL),
(21, 20, 'Heri Irawan, A.Md.', 'heri', 'eaebc433b225932230759f27dc82129a', '', 'heri@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, '0b9c5b1262c36d2551d83ee82d5cc723', '6de95380ba0e113fdf370ede4c20ada3', '', '', NULL, 'admin', '2022-04-14 11:23:01', NULL, NULL),
(22, 22, 'Mahkamah Syar\'iyah Banda Aceh', 'msbna', '341841db54973cb54eb22c45cb85ff63', '', 'msbna@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, '500bd61f77ce2566138eec5081794b10', 'afcc76ef170e7289169034ae0ad8867d', '', '', NULL, 'admin', '2022-04-14 11:23:30', NULL, NULL),
(23, 23, 'Mahkamah Syar\'iyah Jantho', 'msjnt', '4ccac38766011a4b2d60104d182b1d5d', '', 'msjnt@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, 'b496a01f205b567196ac0e8d954d3863', 'a7fecfad48e2c2f74902d4d622901049', '', '', NULL, 'admin', '2022-04-14 11:23:59', NULL, NULL),
(24, 26, 'Mahkamah Syar\'iyah Sigli', 'mssgl', '39d5203c83c261533c9e1049b2ece2a4', '', 'mssgl@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, 'e3592a01ea362ea44413b9c2bc157014', '0daa20a6e53cdb002c0e6835c1c8fe38', '', '', NULL, 'admin', '2022-04-14 11:24:26', NULL, NULL),
(25, 27, 'Mahkamah Syar\'iyah Bireuen', 'msbrn', 'ed835809d4821021a56e09ab1d79f34c', '', 'msbrn@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, '1b0b2c4fa6eec8a1a84f8f60dfba7974', 'c1f3d901e7bcbb081aeb9d8c2455cccf', '', '', NULL, 'admin', '2022-04-14 11:24:47', NULL, NULL),
(26, 28, 'Mahkamah Syar\'iyah Meureudeu', 'msmrd', '6181bfaca83fb5547efe7c6ebe31ff22', '', 'msmrd@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, 'd79bfb71b22e470eee14ed92d14026c8', '2e51a1a4c633c4c6958a662bdfbda72f', '', '', NULL, 'admin', '2022-04-14 11:25:47', NULL, NULL),
(27, 29, 'Mahkamah Syar\'iyah Lhokseumawe', 'mslsm', 'eec6d64925a4dd85462b0d244b812846', '', 'mslsm@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, '02baa657b81a24d3e1e41bbb65a4c333', '45fc81d7b3b698593422459dfef0e2c5', '', '', NULL, 'admin', '2022-04-14 11:26:36', NULL, NULL),
(28, 30, 'Mahkamah Syar\'iyah Lhoksukon', 'mslsk', 'bd9d113f5c097e4f34e1ad8450400c7d', '', 'mslsk@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, 'bf5d6586821953a6b68073925d424e83', '6fd62dc36f637061bde4fe8feeffd148', '', '', NULL, 'admin', '2022-04-14 11:27:12', NULL, NULL),
(29, 31, 'Mahkamah Syar\'iyah Idi', 'msidi', '574c97a2443409804121ded3a8208237', '', 'msidi@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, '3a1729e0e29428c40991278b2a895b07', 'dd5254b54327100ae3d37c1ae0db738e', '', '', NULL, 'admin', '2022-04-14 11:27:36', NULL, NULL),
(30, 32, 'Mahkamah Syar\'iyah Langsa', 'mslgs', '188e681fc8bcfda31211cd4922649c71', '', 'mslgs@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, 'f95ec7825c09781e4d271eb245ae3be2', '1e9a4b35141d01451d94fb46ec5a1a4e', '', '', NULL, 'admin', '2022-04-14 11:28:02', NULL, NULL),
(31, 33, 'Mahkamah Syar\'iyah Kuala Simpang', 'msksp', '71e2b90b5c98d89bacdc508399cf3cb3', '', 'msksp@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, 'b4bb34d88a7fd4b4b594210be8004006', 'bd9a51ba643deea826427825d66d55a8', '', '', NULL, 'admin', '2022-04-14 11:28:46', NULL, NULL),
(32, 34, 'Mahkamah Syar\'iyah Kutacane', 'mskcn', '8c956e40599425d1d75d8fc3856a0aa8', '', 'mskcn@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, '06d697cded8bec6f1f58b28aa992667e', '962cabaca9b5457d90737350821fcb06', '', '', NULL, 'admin', '2022-04-14 11:29:12', NULL, NULL),
(33, 35, 'Mahkamah Syar\'iyah Blangkejeren', 'msbkj', '9ed8dfa924d8193ccf9be0d479ea78ab', '', 'msbkj@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, '43a09eee6b3c4aa7eeb26c4413f55ff4', 'ac4d11682480c7b152f9b996a627fd3c', '', '', NULL, 'admin', '2022-04-14 11:29:41', NULL, NULL),
(34, 36, 'Mahkamah Syar\'iyah Takengon', 'mstkn', 'd57bad9a32797323b03ef1bcd51bdf87', '', 'mstkn@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, '8c2ee1203fa6aba2f1bb2ca115e96dbe', 'fb25069b051e4a9d01c7371beafebcc7', '', '', NULL, 'admin', '2022-04-14 11:30:05', NULL, NULL),
(35, 37, 'Mahkamah Syar\'iyah Simpang Tiga Redelong', 'msstr', 'd691546f8c8e1db394890a09cb3492ec', '', 'msstr@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, '7ab27ff6847fc3f119d28ea3c1258428', '6dff7e2ea06e137e6b61cf0031c14d49', '', '', NULL, 'admin', '2022-04-14 11:30:32', NULL, NULL),
(36, 38, 'Mahkamah Syar\'iyah Calang', 'mscln', '87158e7c4edbfeb93aee121e3b19cda7', '', 'mscln@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, '846fa04aa0f84df7a4aa1b4d4341418a', 'c65b477a769478182f61d778de29d58b', '', '', NULL, 'admin', '2022-04-14 11:30:55', NULL, NULL),
(37, 39, 'Mahkamah Syar\'iyah Meulaboh', 'msmlb', 'e0d826b2d649d624bb6c4dbc15d4ce69', '', 'msmlb@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, 'e738ebb964437e99e6a2501f9f3eb8aa', 'e80d99fc1bd5899b421e835867e4a983', '', '', NULL, 'admin', '2022-04-14 11:31:24', NULL, NULL),
(38, 40, 'Mahkamah Syar\'iyah Suka Makmue', 'msskm', 'a091fc2afaaccb83955c8ad2a02fc6f8', '', 'msskm@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, '7e49c1e1ab966b139ad7a46ea1442edb', '2979ff10d0f41364541bd74170e3e282', '', '', NULL, 'admin', '2022-04-14 11:32:05', NULL, NULL),
(39, 41, 'Mahkamah Syar\'iyah Blangpidie', 'msbpd', 'c5abef3ef5ca6b9ecf5fddab58f0d563', '', 'msbpd@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, 'bdae43f10532c72a901b60523af3c586', '469896e80d2afd4da278cd5e1c70a79b', '', '', NULL, 'admin', '2022-04-14 11:33:00', NULL, NULL),
(40, 42, 'Mahkamah Syar\'iyah Tapaktuan', 'msttn', '876508aa6a318427147fd3e60fe3f688', '', 'msttn@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, '856bfa0f5d89ebfb0d38c0fb2a6457ea', 'd31f7abd24f1bebe0b90b76ce4a2ff7e', '', '', NULL, 'admin', '2022-04-14 11:33:38', NULL, NULL),
(41, 43, 'Mahkamah Syar\'iyah Kota Subulussalam', 'mssus', 'ed1c9bc2163c82fad2594e97d75f5412', '', 'mssus@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, 'b90a7ca923f4c9a7936be5fd2fb03807', 'e95e1a32c7f45431ceb04b7996c17a1a', '', '', NULL, 'admin', '2022-04-14 11:34:01', NULL, NULL),
(42, 44, 'Mahkamah Syar\'iyah Singkil', 'msskl', '7247e57fb004c15e7ea8ae020001e6bf', '', 'msskl@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, 'b2f8294a463a23f88db47cc251ce3a4f', '2545a7087d7e11ba4d28d5f006c6c0a9', '', '', NULL, 'admin', '2022-04-14 11:34:20', NULL, NULL),
(43, 45, 'Mahkamah Syar\'iyah Sinabang', 'mssnb', '99afe6bef9d5d75260623111270ff40a', '', 'mssnb@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, '180b61051e85da5d233741547373ff88', '02fbdd1dbae8febe59c048554045ff96', '', '', NULL, 'admin', '2022-04-14 11:34:41', NULL, NULL),
(44, 46, 'Mahkamah Syar\'iyah Sabang', 'mssbg', '8e87bd787ae4ec955452171f0bf1221b', '', 'mssbg@gmail.com', '', -1, 0, 1, NULL, -1, 0, NULL, NULL, NULL, 0, 'ad1ba3109fe85ad901845fcbd656d1b0', '63471ca531933816db83fdcc743f17bb', '', '', NULL, 'admin', '2022-04-14 11:36:04', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `sys_user_group`
--

CREATE TABLE `sys_user_group` (
  `userid` int(11) NOT NULL DEFAULT '0' COMMENT 'UserId: merujuk ke tabel sys_users kolom userid',
  `groupid` int(11) NOT NULL DEFAULT '0' COMMENT 'Foreign Key to groups.groupid'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Data Hubungan User Dengan Grup';

--
-- Dumping data untuk tabel `sys_user_group`
--

INSERT INTO `sys_user_group` (`userid`, `groupid`) VALUES
(1, 1),
(2, 2),
(3, 4),
(4, 6),
(6, 19),
(7, 16),
(8, 7),
(9, 5),
(10, 31),
(11, 18),
(12, 17),
(13, 30),
(14, 25),
(15, 25),
(16, 25),
(17, 25),
(18, 26),
(19, 26),
(20, 24),
(21, 24),
(22, 40),
(23, 40),
(24, 40),
(25, 40),
(26, 40),
(27, 40),
(28, 40),
(29, 40),
(30, 40),
(31, 40),
(32, 40),
(33, 40),
(34, 40),
(35, 40),
(36, 40),
(37, 40),
(38, 40),
(39, 40),
(40, 40),
(41, 40),
(42, 40),
(43, 40),
(44, 40);

-- --------------------------------------------------------

--
-- Struktur dari tabel `sys_user_online`
--

CREATE TABLE `sys_user_online` (
  `id` bigint(20) NOT NULL COMMENT 'SessionId (by system)',
  `userid` int(11) UNSIGNED NOT NULL COMMENT 'UserId: merujuk ke tabel sys_users ke kolom userid (by system)',
  `host_address` varchar(50) NOT NULL DEFAULT '' COMMENT 'Alamat IP (by system)',
  `login_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Waktu login (by system)',
  `user_agent` varchar(255) NOT NULL DEFAULT '' COMMENT 'Jenis browser (by system)',
  `uri` varchar(1024) NOT NULL DEFAULT '' COMMENT 'Alamat URL (by system)',
  `current_page` varchar(50) NOT NULL DEFAULT '' COMMENT 'Halaman saat ini (by system)',
  `last_visit` datetime DEFAULT NULL COMMENT 'Terakhir Berkunjung (by system)',
  `data` text COMMENT 'Data Lain (by system)'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Data User Yang Sedang Online';

--
-- Dumping data untuk tabel `sys_user_online`
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
(181, 2, '::1', '2022-04-12 04:54:31', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL),
(182, 2, '127.0.0.1', '2022-04-12 05:31:38', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(183, 1, '::1', '2022-04-12 05:51:00', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL),
(184, 1, '::1', '2022-04-12 05:51:23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL),
(185, 1, '::1', '2022-04-12 06:47:08', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL),
(186, 1, '::1', '2022-04-12 06:49:34', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL),
(187, 1, '::1', '2022-04-12 07:05:21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36', '', '', NULL, NULL),
(188, 2, '127.0.0.1', '2022-04-12 07:32:19', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(189, 7, '127.0.0.1', '2022-04-12 08:56:02', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(190, 2, '127.0.0.1', '2022-04-12 08:59:10', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(191, 2, '127.0.0.1', '2022-04-12 15:15:07', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(192, 1, '127.0.0.1', '2022-04-12 15:32:47', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(193, 4, '127.0.0.1', '2022-04-12 15:35:11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(194, 6, '127.0.0.1', '2022-04-12 15:35:23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(195, 2, '127.0.0.1', '2022-04-12 15:37:00', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(196, 6, '127.0.0.1', '2022-04-12 15:37:39', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(197, 2, '127.0.0.1', '2022-04-12 16:04:16', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(198, 7, '127.0.0.1', '2022-04-12 16:08:09', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(199, 1, '127.0.0.1', '2022-04-12 16:10:16', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(200, 1, '127.0.0.1', '2022-04-12 16:10:31', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(201, 10, '127.0.0.1', '2022-04-12 16:12:39', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(202, 10, '127.0.0.1', '2022-04-12 16:12:53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(203, 2, '127.0.0.1', '2022-04-12 16:12:59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(204, 10, '127.0.0.1', '2022-04-12 16:14:15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(205, 1, '127.0.0.1', '2022-04-12 16:18:26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(206, 11, '127.0.0.1', '2022-04-12 16:20:34', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(207, 10, '127.0.0.1', '2022-04-12 16:20:54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(208, 10, '127.0.0.1', '2022-04-12 16:25:05', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(209, 8, '127.0.0.1', '2022-04-12 16:30:54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(210, 7, '127.0.0.1', '2022-04-12 16:49:50', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(211, 4, '127.0.0.1', '2022-04-12 16:50:31', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(212, 9, '127.0.0.1', '2022-04-12 16:50:56', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(213, 6, '127.0.0.1', '2022-04-12 17:18:31', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(214, 2, '127.0.0.1', '2022-04-12 17:20:28', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(215, 3, '127.0.0.1', '2022-04-12 17:21:29', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(216, 1, '127.0.0.1', '2022-04-12 17:22:39', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(217, 12, '127.0.0.1', '2022-04-12 17:25:01', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(218, 2, '127.0.0.1', '2022-04-13 02:34:14', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(219, 6, '127.0.0.1', '2022-04-13 03:53:08', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(220, 2, '127.0.0.1', '2022-04-13 03:55:20', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(221, 2, '127.0.0.1', '2022-04-13 05:53:18', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(222, 13, '127.0.0.1', '2022-04-13 05:55:15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(223, 13, '127.0.0.1', '2022-04-13 05:55:33', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(224, 2, '127.0.0.1', '2022-04-13 05:58:04', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(225, 2, '127.0.0.1', '2022-04-13 06:05:17', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(226, 13, '127.0.0.1', '2022-04-13 06:05:26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(227, 2, '127.0.0.1', '2022-04-13 06:08:29', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(228, 13, '127.0.0.1', '2022-04-13 06:08:44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(229, 13, '127.0.0.1', '2022-04-13 06:10:01', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(230, 13, '127.0.0.1', '2022-04-13 06:13:59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(231, 13, '127.0.0.1', '2022-04-13 06:21:19', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(232, 13, '127.0.0.1', '2022-04-13 06:51:39', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(233, 13, '127.0.0.1', '2022-04-13 06:58:47', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(234, 7, '127.0.0.1', '2022-04-13 07:25:27', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(235, 13, '127.0.0.1', '2022-04-13 07:31:55', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(236, 2, '127.0.0.1', '2022-04-13 07:34:40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(237, 6, '127.0.0.1', '2022-04-13 07:37:54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(238, 2, '127.0.0.1', '2022-04-13 07:41:31', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(239, 2, '127.0.0.1', '2022-04-13 07:50:24', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(240, 7, '127.0.0.1', '2022-04-13 07:57:11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(241, 10, '127.0.0.1', '2022-04-13 07:58:16', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(242, 2, '127.0.0.1', '2022-04-13 07:58:53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(243, 13, '127.0.0.1', '2022-04-13 08:03:42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(244, 6, '127.0.0.1', '2022-04-13 08:18:46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(245, 7, '127.0.0.1', '2022-04-13 08:23:20', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(246, 6, '127.0.0.1', '2022-04-13 08:27:35', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(247, 2, '127.0.0.1', '2022-04-13 08:36:30', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(248, 7, '127.0.0.1', '2022-04-13 08:38:10', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(249, 2, '127.0.0.1', '2022-04-13 08:38:23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(250, 2, '127.0.0.1', '2022-04-13 08:39:09', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(251, 7, '127.0.0.1', '2022-04-13 08:40:57', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(252, 6, '127.0.0.1', '2022-04-13 08:46:24', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(253, 13, '127.0.0.1', '2022-04-13 08:46:51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(254, 1, '127.0.0.1', '2022-04-13 08:50:00', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(255, 7, '127.0.0.1', '2022-04-13 08:59:48', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(256, 6, '127.0.0.1', '2022-04-13 09:01:24', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(257, 2, '127.0.0.1', '2022-04-13 09:02:44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(258, 7, '127.0.0.1', '2022-04-13 09:03:27', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(259, 6, '127.0.0.1', '2022-04-13 09:04:30', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(260, 2, '127.0.0.1', '2022-04-13 09:05:37', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(261, 6, '127.0.0.1', '2022-04-13 09:09:39', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(262, 2, '127.0.0.1', '2022-04-13 09:10:24', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(263, 13, '127.0.0.1', '2022-04-13 14:25:05', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(264, 2, '127.0.0.1', '2022-04-13 14:43:17', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(265, 13, '127.0.0.1', '2022-04-13 14:43:32', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(266, 13, '127.0.0.1', '2022-04-13 19:08:14', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(267, 13, '127.0.0.1', '2022-04-13 19:09:29', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(268, 13, '127.0.0.1', '2022-04-13 19:11:23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(269, 13, '127.0.0.1', '2022-04-13 19:11:36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(270, 13, '127.0.0.1', '2022-04-13 19:12:10', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(271, 13, '127.0.0.1', '2022-04-13 19:20:03', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(272, 13, '127.0.0.1', '2022-04-13 19:24:05', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(273, 13, '127.0.0.1', '2022-04-13 19:34:17', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(274, 13, '127.0.0.1', '2022-04-14 03:20:50', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(275, 13, '::1', '2022-04-14 03:38:24', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.88 Safari/537.36', '', '', NULL, NULL),
(276, 1, '127.0.0.1', '2022-04-14 03:42:39', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(277, 14, '127.0.0.1', '2022-04-14 03:44:21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(278, 1, '127.0.0.1', '2022-04-14 03:47:07', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(279, 4, '127.0.0.1', '2022-04-14 03:48:10', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(280, 6, '127.0.0.1', '2022-04-14 03:50:39', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(281, 13, '127.0.0.1', '2022-04-14 04:03:27', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(282, 14, '127.0.0.1', '2022-04-14 04:07:44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(283, 14, '::1', '2022-04-14 04:08:02', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.88 Safari/537.36', '', '', NULL, NULL),
(284, 13, '::1', '2022-04-14 04:08:16', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.88 Safari/537.36', '', '', NULL, NULL),
(285, 1, '127.0.0.1', '2022-04-14 06:11:07', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(286, 2, '127.0.0.1', '2022-04-14 06:37:50', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(287, 7, '127.0.0.1', '2022-04-14 06:37:59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(288, 7, '127.0.0.1', '2022-04-14 06:38:57', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(289, 7, '127.0.0.1', '2022-04-14 06:39:26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(290, 3, '127.0.0.1', '2022-04-14 06:43:25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(291, 1, '127.0.0.1', '2022-04-14 06:44:18', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(292, 12, '127.0.0.1', '2022-04-14 06:44:48', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(293, 10, '127.0.0.1', '2022-04-14 06:45:08', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(294, 10, '127.0.0.1', '2022-04-14 06:45:40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(295, 11, '127.0.0.1', '2022-04-14 06:45:52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(296, 2, '127.0.0.1', '2022-04-14 06:46:44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(297, 1, '127.0.0.1', '2022-04-14 07:07:30', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(298, 1, '127.0.0.1', '2022-04-14 08:13:18', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(299, 1, '127.0.0.1', '2022-04-14 08:48:57', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(300, 1, '127.0.0.1', '2022-04-14 08:51:51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(301, 1, '127.0.0.1', '2022-04-14 08:53:37', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(302, 6, '127.0.0.1', '2022-04-14 08:54:09', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL),
(303, 1, '127.0.0.1', '2022-04-14 08:57:11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0', '', '', NULL, NULL);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_groups`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_groups` (
`group_id` int(11)
,`group_name` varchar(255)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_groups_struktural`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_groups_struktural` (
`groupid` int(11)
,`group_name` varchar(255)
,`bagian` varchar(255)
,`pegawai_id` int(11) unsigned
,`nip` varchar(20)
,`nama` varchar(50)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_groups_with_name`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_groups_with_name` (
`group_id` int(11)
,`nama` varchar(50)
,`group_name` varchar(255)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_pelaksanaan_suratkeluar`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_pelaksanaan_suratkeluar` (
`tanggal_register` date
,`tahun_register` int(4)
,`nomor_surat` varchar(100)
,`tujuan` varchar(255)
,`waktu` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_pelaksanaan_suratmasuk`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_pelaksanaan_suratmasuk` (
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
-- Stand-in struktur untuk tampilan `v_suratkeluar`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_suratkeluar` (
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
,`satker_id` varchar(3)
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
-- Stand-in struktur untuk tampilan `v_suratmasuk`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_suratmasuk` (
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
,`pengirim_id` int(11)
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
-- Stand-in struktur untuk tampilan `v_tahun_penggeledahan`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_tahun_penggeledahan` (
`tahun_register` int(4)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_tahun_penyitaan`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_tahun_penyitaan` (
`tahun_register` int(4)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_tahun_suratkeluar`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_tahun_suratkeluar` (
`tahun_register` int(4)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_tahun_suratketerangan`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_tahun_suratketerangan` (
`tahun_register` int(4)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_tahun_suratmasuk`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_tahun_suratmasuk` (
`tahun_register` int(4)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_tujuan_surat`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_tujuan_surat` (
`group_id` int(11)
,`group_name` varchar(255)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_users`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_users` (
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
,`status_pegawai` tinyint(1)
,`group_id` text
,`group_name` text
,`group_lft` bigint(11)
,`group_lvl` int(3) unsigned
,`group_rgt` bigint(11)
);

-- --------------------------------------------------------

--
-- Struktur untuk view `v_groups`
--
DROP TABLE IF EXISTS `v_groups`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_groups`  AS  select `sys_groups`.`groupid` AS `group_id`,`getTreeName`((`sys_groups`.`level` - 2),`sys_groups`.`name`) AS `group_name` from `sys_groups` where ((`sys_groups`.`enable` = 1) and (`sys_groups`.`lft` > 2) and (`sys_groups`.`rgt` <= 1000) and (`sys_groups`.`groupid` >= 2)) order by `sys_groups`.`lft` ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_groups_struktural`
--
DROP TABLE IF EXISTS `v_groups_struktural`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_groups_struktural`  AS  select `a`.`groupid` AS `groupid`,`getTreeName`((`a`.`level` - 2),`a`.`name`) AS `group_name`,`getTreeName`((`a`.`level` - 2),`a`.`description`) AS `bagian`,`b`.`id` AS `pegawai_id`,`b`.`nip` AS `nip`,`b`.`nama_gelar` AS `nama` from (`sys_groups` `a` left join `pegawai` `b` on((`b`.`jabatan_id` = `a`.`groupid`))) where (`a`.`groupid` in (2,3,4,5,6,7,8,9,10,11,12,13,14,16,17,18,19)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_groups_with_name`
--
DROP TABLE IF EXISTS `v_groups_with_name`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_groups_with_name`  AS  select `sys_groups`.`groupid` AS `group_id`,`pegawai`.`nama_gelar` AS `nama`,`getTreeName`((`sys_groups`.`level` - 2),`sys_groups`.`name`) AS `group_name` from (`sys_groups` left join `pegawai` on((`sys_groups`.`groupid` = `pegawai`.`jabatan_id`))) where ((`sys_groups`.`enable` = 1) and (`sys_groups`.`lft` > 2) and (`sys_groups`.`rgt` <= 1000) and (`sys_groups`.`groupid` >= 2)) order by `sys_groups`.`lft` ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_pelaksanaan_suratkeluar`
--
DROP TABLE IF EXISTS `v_pelaksanaan_suratkeluar`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_pelaksanaan_suratkeluar`  AS  select `register_surat`.`tanggal_register` AS `tanggal_register`,year(`register_surat`.`tanggal_register`) AS `tahun_register`,`register_surat`.`nomor_surat` AS `nomor_surat`,`register_surat`.`tujuan` AS `tujuan`,(case when (`register_surat`.`tanggal_kirim` is not null) then timestampdiff(DAY,`register_surat`.`tanggal_register`,`register_surat`.`tanggal_kirim`) else timestampdiff(DAY,`register_surat`.`tanggal_register`,now()) end) AS `waktu` from `register_surat` where ((`register_surat`.`klasifikasi_surat_id` = '2') and isnull(`register_surat`.`tanggal_kirim`)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_pelaksanaan_suratmasuk`
--
DROP TABLE IF EXISTS `v_pelaksanaan_suratmasuk`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_pelaksanaan_suratmasuk`  AS  select `register_surat`.`tanggal_register` AS `tanggal_register`,year(`register_surat`.`tanggal_register`) AS `tahun_register`,`register_surat`.`nomor_surat` AS `nomor_surat`,`register_surat`.`pengirim` AS `pengirim`,`register_surat`.`perihal` AS `perihal`,(select `register_pelaksanaan`.`kepada_fullname` from `register_pelaksanaan` where (`register_pelaksanaan`.`register_id` = `register_surat`.`register_id`) order by `register_pelaksanaan`.`pelaksanaan_id` desc limit 0,1) AS `tujuan_disposisi_nama`,(select `register_pelaksanaan`.`kepada_jabatan` from `register_pelaksanaan` where (`register_pelaksanaan`.`register_id` = `register_surat`.`register_id`) order by `register_pelaksanaan`.`pelaksanaan_id` desc limit 0,1) AS `tujuan_disposisi_jabatan` from `register_surat` where ((`register_surat`.`klasifikasi_surat_id` = '1') and (`register_surat`.`status_pelaksanaan_id` <> '20')) order by `register_surat`.`tanggal_register` desc ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_suratkeluar`
--
DROP TABLE IF EXISTS `v_suratkeluar`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_suratkeluar`  AS  select `register_surat`.`register_id` AS `register_id`,`register_surat`.`klasifikasi_surat_id` AS `klasifikasi_surat_id`,`register_surat`.`klasifikasi_surat` AS `klasifikasi_surat`,`register_surat`.`jenis_surat_id` AS `jenis_surat_id`,`register_surat`.`jenis_surat` AS `jenis_surat`,year(`register_surat`.`tanggal_register`) AS `tahun_register`,`register_surat`.`tanggal_register` AS `tanggal_register`,`register_surat`.`nomor_index` AS `nomor_index`,`register_surat`.`nomor_surat` AS `nomor_surat`,`register_surat`.`pengirim_id` AS `pengirim_id`,`register_surat`.`pengirim` AS `pengirim`,`register_surat`.`tujuan_id` AS `tujuan_id`,`register_surat`.`satker_id` AS `satker_id`,`register_surat`.`tujuan` AS `tujuan`,`register_surat`.`perihal` AS `perihal`,`register_surat`.`jenis_ekspedisi_id` AS `jenis_ekspedisi_id`,`register_surat`.`jenis_ekspedisi` AS `jenis_ekspedisi`,`register_surat`.`dokumen_elektronik` AS `dokumen_elektronik`,`register_surat`.`tanggal_kirim` AS `tanggal_kirim`,`register_surat`.`keterangan` AS `keterangan`,`register_surat`.`status_pelaksanaan_id` AS `status_pelaksanaan_id`,`register_surat`.`status_pelaksanaan` AS `status_pelaksanaan`,(case when (`register_surat`.`tanggal_kirim` is not null) then timestampdiff(DAY,`register_surat`.`tanggal_register`,`register_surat`.`tanggal_kirim`) else timestampdiff(DAY,`register_surat`.`tanggal_register`,now()) end) AS `waktu` from `register_surat` where (`register_surat`.`klasifikasi_surat_id` = '2') ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_suratmasuk`
--
DROP TABLE IF EXISTS `v_suratmasuk`;

CREATE ALGORITHM=TEMPTABLE DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_suratmasuk`  AS  select `register_surat`.`register_id` AS `register_id`,`register_surat`.`klasifikasi_surat_id` AS `klasifikasi_surat_id`,`register_surat`.`klasifikasi_surat` AS `klasifikasi_surat`,`register_surat`.`jenis_surat_id` AS `jenis_surat_id`,`register_surat`.`jenis_surat` AS `jenis_surat`,year(`register_surat`.`tanggal_register`) AS `tahun_register`,`register_surat`.`tanggal_register` AS `tanggal_register`,`register_surat`.`tanggal_surat` AS `tanggal_surat`,`register_surat`.`nomor_index` AS `nomor_index`,`register_surat`.`nomor_agenda` AS `nomor_agenda`,`register_surat`.`nomor_surat` AS `nomor_surat`,`register_surat`.`pengirim_id` AS `pengirim_id`,`register_surat`.`pengirim` AS `pengirim`,`register_surat`.`tujuan_id` AS `tujuan_id`,`register_surat`.`tujuan` AS `tujuan`,(select `register_pelaksanaan`.`dari_fullname` from `register_pelaksanaan` where (`register_pelaksanaan`.`register_id` = `register_surat`.`register_id`) order by `register_pelaksanaan`.`pelaksanaan_id` desc limit 0,1) AS `tujuan_disposisi_dari_nama`,(select `register_pelaksanaan`.`dari_jabatan` from `register_pelaksanaan` where (`register_pelaksanaan`.`register_id` = `register_surat`.`register_id`) order by `register_pelaksanaan`.`pelaksanaan_id` desc limit 0,1) AS `tujuan_disposisi_dari_jabatan`,(select `register_pelaksanaan`.`tanggal_pelaksanaan` from `register_pelaksanaan` where (`register_pelaksanaan`.`register_id` = `register_surat`.`register_id`) order by `register_pelaksanaan`.`pelaksanaan_id` desc limit 0,1) AS `tujuan_disposisi_tanggal`,(select `register_pelaksanaan`.`kepada_userid` from `register_pelaksanaan` where (`register_pelaksanaan`.`register_id` = `register_surat`.`register_id`) order by `register_pelaksanaan`.`pelaksanaan_id` desc limit 0,1) AS `tujuan_disposisi_id`,(select `register_pelaksanaan`.`kepada_fullname` from `register_pelaksanaan` where (`register_pelaksanaan`.`register_id` = `register_surat`.`register_id`) order by `register_pelaksanaan`.`pelaksanaan_id` desc limit 0,1) AS `tujuan_disposisi_nama`,(select `register_pelaksanaan`.`kepada_jabatan_id` from `register_pelaksanaan` where (`register_pelaksanaan`.`register_id` = `register_surat`.`register_id`) order by `register_pelaksanaan`.`pelaksanaan_id` desc limit 0,1) AS `tujuan_disposisi_jabatan_id`,(select `register_pelaksanaan`.`keterangan` from `register_pelaksanaan` where (`register_pelaksanaan`.`register_id` = `register_surat`.`register_id`) order by `register_pelaksanaan`.`pelaksanaan_id` desc limit 0,1) AS `tujuan_disposisi_keterangan`,`register_surat`.`perihal` AS `perihal`,`register_surat`.`dokumen_elektronik` AS `dokumen_elektronik`,`register_surat`.`status_pelaksanaan_id` AS `status_pelaksanaan_id`,`register_surat`.`status_pelaksanaan` AS `status_pelaksanaan`,`register_surat`.`keterangan` AS `keterangan` from `register_surat` where (`register_surat`.`klasifikasi_surat_id` = '1') ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_tahun_penggeledahan`
--
DROP TABLE IF EXISTS `v_tahun_penggeledahan`;

CREATE ALGORITHM=TEMPTABLE DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_tahun_penggeledahan`  AS  select distinct year(`register_penggeledahan`.`tanggal_register`) AS `tahun_register` from `register_penggeledahan` ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_tahun_penyitaan`
--
DROP TABLE IF EXISTS `v_tahun_penyitaan`;

CREATE ALGORITHM=TEMPTABLE DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_tahun_penyitaan`  AS  select distinct year(`register_penyitaan`.`tanggal_register`) AS `tahun_register` from `register_penyitaan` ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_tahun_suratkeluar`
--
DROP TABLE IF EXISTS `v_tahun_suratkeluar`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_tahun_suratkeluar`  AS  select distinct year(`register_surat`.`tanggal_register`) AS `tahun_register` from `register_surat` where (`register_surat`.`klasifikasi_surat_id` = '2') ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_tahun_suratketerangan`
--
DROP TABLE IF EXISTS `v_tahun_suratketerangan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_tahun_suratketerangan`  AS  select distinct year(`register_surat_keterangan`.`tanggal_register`) AS `tahun_register` from `register_surat_keterangan` ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_tahun_suratmasuk`
--
DROP TABLE IF EXISTS `v_tahun_suratmasuk`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_tahun_suratmasuk`  AS  select distinct year(`register_surat`.`tanggal_register`) AS `tahun_register` from `register_surat` where (`register_surat`.`klasifikasi_surat_id` = '1') ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_tujuan_surat`
--
DROP TABLE IF EXISTS `v_tujuan_surat`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_tujuan_surat`  AS  select `ref_tujuan_surat`.`groupid` AS `group_id`,`getTreeName`((`ref_tujuan_surat`.`level` - 1),`ref_tujuan_surat`.`name`) AS `group_name` from `ref_tujuan_surat` where ((`ref_tujuan_surat`.`enable` = 1) and (`ref_tujuan_surat`.`lft` >= 1) and (`ref_tujuan_surat`.`rgt` <= 1000) and (`ref_tujuan_surat`.`groupid` >= 1)) order by `ref_tujuan_surat`.`lft` ;

-- --------------------------------------------------------

--
-- Struktur untuk view `v_users`
--
DROP TABLE IF EXISTS `v_users`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_users`  AS  select `sys_users`.`userid` AS `userid`,`sys_users`.`pegawai_id` AS `pegawai_id`,`sys_users`.`fullname` AS `fullname`,`sys_users`.`username` AS `username`,`sys_users`.`password` AS `password`,`sys_users`.`old_password` AS `old_password`,`sys_users`.`email` AS `email`,`sys_users`.`alternative_email` AS `alternative_email`,`sys_users`.`allow_concurrent_login` AS `allow_concurrent_login`,`sys_users`.`has_change_password` AS `has_change_password`,`sys_users`.`enable_change_password` AS `enable_change_password`,`sys_users`.`last_change_password` AS `last_change_password`,`sys_users`.`password_expired_remainder` AS `password_expired_remainder`,`sys_users`.`attemp_count` AS `attemp_count`,`sys_users`.`attemp_time` AS `attemp_time`,`sys_users`.`user_expired` AS `user_expired`,`sys_users`.`last_login` AS `last_login`,`sys_users`.`block` AS `block`,`sys_users`.`activation` AS `activation`,`sys_users`.`code_activation` AS `code_activation`,`sys_users`.`params` AS `params`,`sys_users`.`lock_by` AS `lock_by`,`sys_users`.`lock_on` AS `lock_on`,`sys_users`.`created_by` AS `created_by`,`sys_users`.`created_on` AS `created_on`,`sys_users`.`modified_by` AS `modified_by`,`sys_users`.`modified_on` AS `modified_on`,`pegawai`.`status_pegawai` AS `status_pegawai`,(select group_concat(cast(`sys_user_group`.`groupid` as char(4) charset latin1) order by `sys_user_group`.`groupid` ASC separator ', ') AS `groupid` from `sys_user_group` where (`sys_user_group`.`userid` = `sys_users`.`userid`)) AS `group_id`,(select group_concat(`sys_groups`.`name` order by `sys_user_group`.`groupid` ASC separator ', ') AS `groupname` from (`sys_user_group` left join `sys_groups` on((`sys_user_group`.`groupid` = `sys_groups`.`groupid`))) where (`sys_user_group`.`userid` = `sys_users`.`userid`)) AS `group_name`,(select min(`sys_groups`.`lft`) AS `grplft` from (`sys_user_group` left join `sys_groups` on((`sys_user_group`.`groupid` = `sys_groups`.`groupid`))) where (`sys_user_group`.`userid` = `sys_users`.`userid`)) AS `group_lft`,(select min(`sys_groups`.`level`) AS `grplvl` from (`sys_user_group` left join `sys_groups` on((`sys_user_group`.`groupid` = `sys_groups`.`groupid`))) where (`sys_user_group`.`userid` = `sys_users`.`userid`)) AS `group_lvl`,(select max(`sys_groups`.`rgt`) AS `grprgt` from (`sys_user_group` left join `sys_groups` on((`sys_user_group`.`groupid` = `sys_groups`.`groupid`))) where (`sys_user_group`.`userid` = `sys_users`.`userid`)) AS `group_rgt` from (`sys_users` left join `pegawai` on((`pegawai`.`id` = `sys_users`.`pegawai_id`))) ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `agama`
--
ALTER TABLE `agama`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nama` (`nama`),
  ADD KEY `aktif` (`aktif`),
  ADD KEY `diinput_tanggal` (`diinput_tanggal`),
  ADD KEY `diperbaharui_tanggal` (`diperbaharui_tanggal`);

--
-- Indeks untuk tabel `jenis_identitas`
--
ALTER TABLE `jenis_identitas`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `pegawai`
--
ALTER TABLE `pegawai`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nama` (`nama`),
  ADD KEY `nip` (`nip`),
  ADD KEY `nama_gelar` (`nama_gelar`),
  ADD KEY `aktif` (`aktif`),
  ADD KEY `diinput_tanggal` (`diinput_tanggal`),
  ADD KEY `diperbaharui_tanggal` (`diperbaharui_tanggal`);

--
-- Indeks untuk tabel `pengadilan_negeri`
--
ALTER TABLE `pengadilan_negeri`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pn_index` (`id`,`nama`),
  ADD UNIQUE KEY `pt_pn_index` (`id`,`pt_id`,`nama`),
  ADD KEY `aktif` (`aktif`),
  ADD KEY `pt_id` (`pt_id`);

--
-- Indeks untuk tabel `pengadilan_tinggi`
--
ALTER TABLE `pengadilan_tinggi`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nama` (`nama`),
  ADD KEY `aktif` (`aktif`);

--
-- Indeks untuk tabel `pihak`
--
ALTER TABLE `pihak`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `ref_instruksi`
--
ALTER TABLE `ref_instruksi`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `ref_jenis_surat`
--
ALTER TABLE `ref_jenis_surat`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `ref_jenis_surat_keterangan`
--
ALTER TABLE `ref_jenis_surat_keterangan`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `ref_pangkat`
--
ALTER TABLE `ref_pangkat`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `ref_pengiriman`
--
ALTER TABLE `ref_pengiriman`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `ref_penomoran`
--
ALTER TABLE `ref_penomoran`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `ref_satker`
--
ALTER TABLE `ref_satker`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `ref_tujuan_surat`
--
ALTER TABLE `ref_tujuan_surat`
  ADD PRIMARY KEY (`groupid`),
  ADD UNIQUE KEY `idx_groups_parent_title_lookup` (`parent_id`,`name`),
  ADD KEY `idx_groups_title_lookup` (`name`),
  ADD KEY `idx_groups_adjacency_lookup` (`parent_id`),
  ADD KEY `level` (`level`),
  ADD KEY `ordering` (`ordering`),
  ADD KEY `idx_groups_nested_set_lookup` (`lft`,`rgt`);

--
-- Indeks untuk tabel `register_pelaksanaan`
--
ALTER TABLE `register_pelaksanaan`
  ADD PRIMARY KEY (`pelaksanaan_id`,`register_id`);

--
-- Indeks untuk tabel `register_penggeledahan`
--
ALTER TABLE `register_penggeledahan`
  ADD PRIMARY KEY (`register_id`);

--
-- Indeks untuk tabel `register_penyitaan`
--
ALTER TABLE `register_penyitaan`
  ADD PRIMARY KEY (`register_id`);

--
-- Indeks untuk tabel `register_surat`
--
ALTER TABLE `register_surat`
  ADD PRIMARY KEY (`register_id`,`klasifikasi_surat_id`);

--
-- Indeks untuk tabel `register_surat_keterangan`
--
ALTER TABLE `register_surat_keterangan`
  ADD PRIMARY KEY (`register_id`);

--
-- Indeks untuk tabel `sys_audittrail`
--
ALTER TABLE `sys_audittrail`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indeks untuk tabel `sys_config`
--
ALTER TABLE `sys_config`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indeks untuk tabel `sys_groups`
--
ALTER TABLE `sys_groups`
  ADD PRIMARY KEY (`groupid`),
  ADD UNIQUE KEY `idx_groups_parent_title_lookup` (`parent_id`,`name`),
  ADD KEY `idx_groups_title_lookup` (`name`),
  ADD KEY `idx_groups_adjacency_lookup` (`parent_id`),
  ADD KEY `level` (`level`),
  ADD KEY `ordering` (`ordering`),
  ADD KEY `idx_groups_nested_set_lookup` (`lft`,`rgt`);

--
-- Indeks untuk tabel `sys_users`
--
ALTER TABLE `sys_users`
  ADD PRIMARY KEY (`userid`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `username_2` (`username`);

--
-- Indeks untuk tabel `sys_user_group`
--
ALTER TABLE `sys_user_group`
  ADD PRIMARY KEY (`userid`,`groupid`),
  ADD KEY `groupid` (`groupid`);

--
-- Indeks untuk tabel `sys_user_online`
--
ALTER TABLE `sys_user_online`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `jenis_identitas`
--
ALTER TABLE `jenis_identitas`
  MODIFY `id` tinyint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `pegawai`
--
ALTER TABLE `pegawai`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Primary key: (by system)', AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT untuk tabel `ref_instruksi`
--
ALTER TABLE `ref_instruksi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `ref_jenis_surat`
--
ALTER TABLE `ref_jenis_surat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `ref_jenis_surat_keterangan`
--
ALTER TABLE `ref_jenis_surat_keterangan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `ref_penomoran`
--
ALTER TABLE `ref_penomoran`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT untuk tabel `register_pelaksanaan`
--
ALTER TABLE `register_pelaksanaan`
  MODIFY `pelaksanaan_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT untuk tabel `register_penggeledahan`
--
ALTER TABLE `register_penggeledahan`
  MODIFY `register_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `register_penyitaan`
--
ALTER TABLE `register_penyitaan`
  MODIFY `register_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `register_surat`
--
ALTER TABLE `register_surat`
  MODIFY `register_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT untuk tabel `register_surat_keterangan`
--
ALTER TABLE `register_surat_keterangan`
  MODIFY `register_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `sys_audittrail`
--
ALTER TABLE `sys_audittrail`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Primary key: (by system)', AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT untuk tabel `sys_config`
--
ALTER TABLE `sys_config`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Primari Key', AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT untuk tabel `sys_user_online`
--
ALTER TABLE `sys_user_online`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'SessionId (by system)', AUTO_INCREMENT=304;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `sys_user_group`
--
ALTER TABLE `sys_user_group`
  ADD CONSTRAINT `sys_user_group_fk` FOREIGN KEY (`userid`) REFERENCES `sys_users` (`userid`) ON DELETE CASCADE,
  ADD CONSTRAINT `sys_user_group_fk1` FOREIGN KEY (`groupid`) REFERENCES `sys_groups` (`groupid`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
