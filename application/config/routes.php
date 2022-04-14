<?php
defined('BASEPATH') OR exit('No direct script access allowed');

$route['default_controller']  = 'HalamanUtama';
$route['404_override']  = '';
$route['translate_uri_dashes'] = FALSE;

$route['dashboard']  = 'HalamanUtama';
$route['dashboard_modal_disposisi']  = 'HalamanUtama/dashboard_modal_disposisi';
$route['dashboard_simpan_disposisi']  = 'HalamanUtama/dashboard_simpan_disposisi';
$route['dashboard_modal_pegawai']  = 'HalamanUtama/dashboard_modal_pegawai';

$route['login'] = 'HalamanLogin/index';
$route['login_validasi'] = 'HalamanLogin/validasi';

$route['keluar'] = 'HalamanLogin/keluar';

$route['konfigurasi']  = 'HalamanKonfigurasi/index';
$route['konfigurasi_add'] = 'HalamanKonfigurasi/konfigurasi_add';
$route['konfigurasi_simpan'] = 'HalamanKonfigurasi/konfigurasi_simpan';
$route['konfigurasi_satker'] = 'HalamanKonfigurasi/konfigurasi_satker';

$route['pengguna']  = 'HalamanPengguna/index';
$route['pengguna_data'] = 'HalamanPengguna/pengguna_data';
$route['pengguna_add'] = 'HalamanPengguna/pengguna_add';
$route['pengguna_simpan'] = 'HalamanPengguna/pengguna_simpan';

$route['pegawai']  = 'HalamanPegawai/index';
$route['pegawai_data'] = 'HalamanPegawai/pegawai_data';
$route['pegawai_add'] = 'HalamanPegawai/pegawai_add';
$route['pegawai_pangkat'] = 'HalamanPegawai/pegawai_pangkat';
$route['pegawai_simpan'] = 'HalamanPegawai/pegawai_simpan';
$route['pegawai_hapus'] = 'HalamanPegawai/pegawai_hapus';

$route['riwayat']  = 'HalamanRiwayatPengguna/index';
$route['riwayat_data'] = 'HalamanRiwayatPengguna/riwayat_data';
$route['riwayat_detil'] = 'HalamanRiwayatPengguna/riwayat_detil';

$route['kategori_faq']  = 'HalamanKategoriFAQ/index';
$route['kategori_faq_data'] = 'HalamanKategoriFAQ/kategori_data';
$route['kategori_faq_add'] = 'HalamanKategoriFAQ/kategori_add';
$route['kategori_faq_simpan'] = 'HalamanKategoriFAQ/kategori_simpan';
$route['kategori_faq_hapus'] = 'HalamanKategoriFAQ/kategori_hapus';

$route['bukutamu']  = 'HalamanBukuTamu/index';
$route['bukutamu_data'] = 'HalamanBukuTamu/bukutamu_data';
$route['bukutamu_pegawai'] = 'HalamanBukuTamu/bukutamu_pegawai';
$route['bukutamu_add'] = 'HalamanBukuTamu/bukutamu_add';
$route['bukutamu_simpan'] = 'HalamanBukuTamu/bukutamu_simpan';
$route['bukutamu_hapus'] = 'HalamanBukuTamu/bukutamu_hapus';

$route['suratmasuk']  = 'HalamanSuratMasuk/index';
$route['suratmasuk_data'] = 'HalamanSuratMasuk/suratmasuk_data';
$route['suratmasukeks_data'] = 'HalamanSuratMasuk/suratmasukeks_data';
$route['suratmasuk_data_pelaksana'] = 'HalamanSuratMasuk/suratmasuk_data_pelaksana';
$route['suratmasuk_pelaksana_tambah'] = 'HalamanSuratMasuk/suratmasuk_pelaksana_tambah';
$route['suratmasuk_pelaksana_edit'] = 'HalamanSuratMasuk/suratmasuk_pelaksana_edit';
$route['suratmasuk_pelaksana_hapus'] = 'HalamanSuratMasuk/suratmasuk_pelaksana_hapus';
$route['suratmasuk_pelaksana_pegawai'] = 'HalamanSuratMasuk/suratmasuk_pelaksana_pegawai';
$route['suratmasuk_simpan_pelaksanaan'] = 'HalamanSuratMasuk/suratmasuk_simpan_pelaksanaan';
$route['suratmasuk_tampil_pelaksana'] = 'HalamanSuratMasuk/suratmasuk_tampil_pelaksana';
$route['suratmasuk_add'] = 'HalamanSuratMasuk/suratmasuk_add';
$route['suratmasuk_eks_add'] = 'HalamanSuratMasuk/suratmasuk_eks_add';
$route['suratmasuk_detil'] = 'HalamanSuratMasuk/suratmasuk_detil';
$route['suratmasuk_simpan'] = 'HalamanSuratMasuk/suratmasuk_simpan';
$route['suratmasukeksternal_simpan'] = 'HalamanSuratMasuk/suratmasukeksternal_simpan';
$route['suratmasuk_hapus'] = 'HalamanSuratMasuk/suratmasuk_hapus';
$route['suratmasuk_disposisi'] = 'HalamanSuratMasuk/suratmasuk_disposisi';
$route['suratmasuk_nomoragenda'] = 'HalamanSuratMasuk/suratmasuk_nomoragenda';
$route['suratmasuk_nomoragenda_eks'] = 'HalamanSuratMasuk/suratmasuk_nomoragenda_eks';
$route['suratmasuk_pencarian'] = 'HalamanSuratMasuk/suratmasuk_pencarian';
$route['suratmasuk_periode_cetak'] = 'HalamanSuratMasuk/suratmasuk_periode_cetak';
$route['suratmasuk_register_cetak'] = 'HalamanSuratMasuk/suratmasuk_register_cetak';

$route['suratkeluar']  = 'HalamanSuratKeluar/index';
$route['suratkeluar_data'] = 'HalamanSuratKeluar/suratkeluar_data';
$route['suratkeluar_add'] = 'HalamanSuratKeluar/suratkeluar_add';
$route['suratkeluar_jenissurat'] = 'HalamanSuratKeluar/suratkeluar_jenissurat';
$route['suratkeluar_tujuan_satker'] = 'HalamanSuratKeluar/suratkeluar_tujuan_satker';
$route['suratkeluar_simpan'] = 'HalamanSuratKeluar/suratkeluar_simpan';
$route['suratkeluar_detil'] = 'HalamanSuratKeluar/suratkeluar_detil';
$route['suratkeluar_pengiriman'] = 'HalamanSuratKeluar/suratkeluar_pengiriman';
$route['suratkeluar_pengiriman_simpan'] = 'HalamanSuratKeluar/suratkeluar_pengiriman_simpan';
$route['suratkeluar_pencarian'] = 'HalamanSuratKeluar/suratkeluar_pencarian';
$route['suratkeluar_periode_cetak'] = 'HalamanSuratKeluar/suratkeluar_periode_cetak';
$route['suratkeluar_register_cetak'] = 'HalamanSuratKeluar/suratkeluar_register_cetak';
$route['suratkeluar_hapus'] = 'HalamanSuratKeluar/suratkeluar_hapus';

$route['penomoran']  = 'HalamanPenomoran/index';
$route['penomoran_data'] = 'HalamanPenomoran/penomoran_data';
$route['penomoran_add'] = 'HalamanPenomoran/penomoran_add';
$route['penomoran_simpan'] = 'HalamanPenomoran/penomoran_simpan';
$route['penomoran_hapus'] = 'HalamanPenomoran/penomoran_hapus';

$route['suratketerangan']  = 'HalamanSuratKeterangan/index';
$route['suratketerangan_data']  = 'HalamanSuratKeterangan/suratketerangan_data';
$route['suratketerangan_detil']  = 'HalamanSuratKeterangan/suratketerangan_detil';
$route['suratketerangan_add']  = 'HalamanSuratKeterangan/suratketerangan_add';
$route['suratketerangan_data_perkara']  = 'HalamanSuratKeterangan/suratketerangan_data_perkara';
$route['suratketerangan_simpan']  = 'HalamanSuratKeterangan/suratketerangan_simpan';
$route['suratketerangan_cetak/(:any)/(:any)']  = 'HalamanSuratKeterangan/suratketerangan_cetak/$1/$1';
$route['suratketerangan_generate_nomor']  = 'HalamanSuratKeterangan/suratketerangan_generate_nomor';
$route['suratketerangan_register_umum']  = 'HalamanSuratKeterangan/suratketerangan_register_umum';
$route['suratketerangan_register_umum_simpan']  = 'HalamanSuratKeterangan/suratketerangan_register_umum_simpan';
$route['suratketerangan_dokumen_simpan']  = 'HalamanSuratKeterangan/suratketerangan_dokumen_simpan';
$route['suratketerangan_pencarian']  = 'HalamanSuratKeterangan/suratketerangan_pencarian';
$route['suratketerangan_periode_cetak']  = 'HalamanSuratKeterangan/suratketerangan_periode_cetak';
$route['suratketerangan_register_cetak']  = 'HalamanSuratKeterangan/suratketerangan_register_cetak';
$route['suratketerangan_penetapan']  = 'HalamanSuratKeterangan/suratketerangan_penetapan';
$route['suratketerangan_penetapan_pegawai']  = 'HalamanSuratKeterangan/suratketerangan_penetapan_pegawai';
$route['suratketerangan_register_umum_hapus']  = 'HalamanSuratKeterangan/suratketerangan_register_umum_hapus';
$route['suratketerangan_hapus']  = 'HalamanSuratKeterangan/suratketerangan_hapus';

$route['jenissuratketerangan']  = 'HalamanJenisSuratKeterangan/index';
$route['jenissuratketerangan_data']  = 'HalamanJenisSuratKeterangan/jenissuratketerangan_data';
$route['jenissuratketerangan_add']  = 'HalamanJenisSuratKeterangan/jenissuratketerangan_add';
$route['jenissuratketerangan_simpan']  = 'HalamanJenisSuratKeterangan/jenissuratketerangan_simpan';
$route['jenissuratketerangan_upload_add']  = 'HalamanJenisSuratKeterangan/jenissuratketerangan_upload_add';

$route['penyitaan']  = 'HalamanPenyitaan/index';
$route['penyitaan_data']  = 'HalamanPenyitaan/penyitaan_data';
$route['penyitaan_detil']  = 'HalamanPenyitaan/penyitaan_detil';
$route['penyitaan_add']  = 'HalamanPenyitaan/penyitaan_add';
$route['penyitaan_simpan']  = 'HalamanPenyitaan/penyitaan_simpan';
$route['penyitaan_nomor_register']  = 'HalamanPenyitaan/penyitaan_nomor_register';
$route['penyitaan_register_umum']  = 'HalamanPenyitaan/penyitaan_register_umum';
$route['penyitaan_register_umum_simpan']  = 'HalamanPenyitaan/penyitaan_register_umum_simpan';
$route['penyitaan_register_umum_hapus']  = 'HalamanPenyitaan/penyitaan_register_umum_hapus';
$route['penyitaan_dokumen_simpan']  = 'HalamanPenyitaan/penyitaan_dokumen_simpan';
$route['penyitaan_pencarian']  = 'HalamanPenyitaan/penyitaan_pencarian';
$route['penyitaan_hapus']  = 'HalamanPenyitaan/penyitaan_hapus';
$route['penyitaan_penetapan']  = 'HalamanPenyitaan/penyitaan_penetapan';
$route['penyitaan_penetapan_pegawai']  = 'HalamanPenyitaan/penyitaan_penetapan_pegawai';
$route['penyitaan_cetak/(:any)/(:any)']  = 'HalamanPenyitaan/penyitaan_cetak/$1/$1';

$route['penggeledahan']  = 'HalamanPenggeledahan/index';
$route['penggeledahan_data']  = 'HalamanPenggeledahan/penggeledahan_data';
$route['penggeledahan_detil']  = 'HalamanPenggeledahan/penggeledahan_detil';
$route['penggeledahan_add']  = 'HalamanPenggeledahan/penggeledahan_add';
$route['penggeledahan_simpan']  = 'HalamanPenggeledahan/penggeledahan_simpan';
$route['penggeledahan_nomor_register']  = 'HalamanPenggeledahan/penggeledahan_nomor_register';
$route['penggeledahan_register_umum']  = 'HalamanPenggeledahan/penggeledahan_register_umum';
$route['penggeledahan_register_umum_simpan']  = 'HalamanPenggeledahan/penggeledahan_register_umum_simpan';
$route['penggeledahan_register_umum_hapus']  = 'HalamanPenggeledahan/penggeledahan_register_umum_hapus';
$route['penggeledahan_dokumen_simpan']  = 'HalamanPenggeledahan/penggeledahan_dokumen_simpan';
$route['penggeledahan_pencarian']  = 'HalamanPenggeledahan/penggeledahan_pencarian';
$route['penggeledahan_hapus']  = 'HalamanPenggeledahan/penggeledahan_hapus';
$route['penggeledahan_penetapan']  = 'HalamanPenggeledahan/penggeledahan_penetapan';
$route['penggeledahan_penetapan_pegawai']  = 'HalamanPenggeledahan/penggeledahan_penetapan_pegawai';
$route['penggeledahan_cetak/(:any)/(:any)']  = 'HalamanPenggeledahan/penggeledahan_cetak/$1/$1';