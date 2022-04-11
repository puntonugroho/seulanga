<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class ModelKonfigurasi extends CI_Model {

	public function __construct(){
		parent::__construct();
	}

	public function hapus_data($nama_tabel,$kolom_seleksi,$seleksi){
		try {
			$this->db->where($kolom_seleksi,$seleksi);
			$this->db->delete($nama_tabel);
			return 1;
		} catch (Exception $e) {
			return 0;
		}
	}


	public function get_seleksi($nama_tabel,$kolom_seleksi,$seleksi){
		try {
			$this->db->where($kolom_seleksi,$seleksi);
			return $this->db->get($nama_tabel);
		} catch (Exception $e) {
			return 0;
		}
	}


	public function get_data($nama_tabel){
		try {
			return $this->db->get($nama_tabel);
		} catch (Exception $e) {
			return 0;
		}
	}


	public function simpan_data($tabel,$data){
		try {
			$this->db->insert($tabel,$data);
			return 1;
		} catch (Exception $e) {
			return 0;
		}
	}


	public function pembaharuan_data($tabel,$data,$kolom_seleksi,$seleksi){
		try {
			$this->db->where($kolom_seleksi,$seleksi);
			$this->db->update($tabel,$data);
			return 1;
		} catch (Exception $e) {
			return 0;
		}
	}
}