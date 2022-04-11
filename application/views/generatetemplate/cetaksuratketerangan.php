<?php
$url = base_url("dokumentemplate/".$nama_dokumen);
$Template = file_get_contents($url);

$logo_pengadilan = base_url()."/assets/img/".$logo_pengadilan;


$Template = str_replace("#NamaPengadilanHeader#",$nama_pengadilan_header,$Template);
$Template = str_replace("#AlamatPengadilanHeader#",$alamat_pengadilan,$Template);
$Template = str_replace("#PenetapanOleh#",$penetapan,$Template);
$Template = str_replace("#NamaDaerah#",''.$nama_kota.'',$Template);
$Template = str_replace("#TanggalPenetapan#",''.$tanggal_register.'',$Template);
$Template = str_replace("#NamaPenetap#",$panetapan_nama,$Template);
$Template = str_replace("#NamaPengadilan#",$nama_pengadilan,$Template);
$Template = str_replace("#NomorRegister#",$nomor_register,$Template);
$Template = str_replace("#LogoPengadilan#",$logo_pengadilan,$Template);

$Template = str_replace("#NamaPihak#",''.$pemohon_nama.'',$Template);
$Template = str_replace("#JenisKelamin#",''.$pemohon_kelamin.'',$Template);
$Template = str_replace("#TempatLahir#",''.$pemohon_tempat_lahir.'',$Template);
$Template = str_replace("#TanggalLahir#",''.$pemohon_tanggal_lahir.'',$Template);
$Template = str_replace("#Pekerjaan#",''.$pemohon_pekerjaan.'',$Template);
$Template = str_replace("#Jabatan#",''.$pemohon_jabatan.'',$Template);
$Template = str_replace("#Alamat#",''.$pemohon_alamat.'',$Template);
$Template = str_replace("#Pendidikan#",''.$pemohon_pendidikan.'',$Template);
$Template = str_replace("#AlasanPermohonanSK#",''.$pemohon_alasan.'',$Template);


header("Content-Type: application/vnd.ms-word");
header("Expires: 0");
header("Cache-Control:  must-revalidate, post-check=0, pre-check=0");
header("Content-disposition: attachment; filename=suratketerangan.rtf");
echo $Template;
?>