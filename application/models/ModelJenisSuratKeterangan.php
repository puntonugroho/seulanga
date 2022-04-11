<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class ModelJenisSuratKeterangan extends CI_Model {

	public function __construct(){
		parent::__construct();		
	}

	private function _get_datatables_query(){
		$this->db->from('ref_jenis_surat_keterangan');
		if($_POST['search']['value']){
			$this->db->group_start();
			$this->db->like('nama', $_POST['search']['value']);
			$this->db->or_like('aktif', $_POST['search']['value']);
			$this->db->or_like('kode', $_POST['search']['value']);
			$this->db->group_end();		
		}
	}

	public function get_datatables(){
		$this->_get_datatables_query();
        if($_POST['length'] != -1)
        $this->db->limit($_POST['length'], $_POST['start']);
    	$this->db->order_by('id','DESC');
		$query = $this->db->get();
		return $query->result();
	}

	public function count_filtered(){
		$this->_get_datatables_query();
		$query = $this->db->get();
		return $query->num_rows();
	}

	public function count_all(){
		$this->db->from('ref_jenis_surat_keterangan');
		return $this->db->count_all_results();
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

	public function get_seleksi2($nama_tabel,$kolom_seleksi1,$seleksi1,$kolom_seleksi2,$seleksi2){
		try {
			$this->db->where($kolom_seleksi1,$seleksi1);
			$this->db->where($kolom_seleksi2,$seleksi2);
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