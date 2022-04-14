<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class ModelSuratMasuk extends CI_Model {

	public function __construct(){
		parent::__construct();
	}

	var $v_table = 'v_suratmasuk';

	private function _get_datatables_query(){
		if($this->input->post('tahun_register')){
            $this->db->where('tahun_register', $this->input->post('tahun_register'));
        }
        if($this->input->post('tujuan_jabatan')){
            $this->db->where('tujuan_id', $this->input->post('tujuan_jabatan'));
        }
		$this->db->from($this->v_table);
		if($_POST['search']['value']){
			$this->db->group_start();
			$this->db->like('jenis_surat', $_POST['search']['value']);
			$this->db->or_like('tahun_register', $_POST['search']['value']);
			$this->db->or_like('nomor_surat', $_POST['search']['value']);
			$this->db->or_like('pengirim', $_POST['search']['value']);
			$this->db->group_end();		
		}
	}

	public function get_datatables(){
		$this->_get_datatables_query();
        if($_POST['length'] != -1)
        $this->db->limit($_POST['length'], $_POST['start']);
    	$this->db->order_by('register_id','DESC');
		$query = $this->db->get();
		return $query->result();
	}

	private function _get_datatables_eksternal_query($pengirim_id){
		if($this->input->post('tahun_register')){
            $this->db->where('tahun_register', $this->input->post('tahun_register'));
        }
        if($this->input->post('tujuan_jabatan')){
            $this->db->where('tujuan_id', $this->input->post('tujuan_jabatan'));
        }
		$this->db->from($this->v_table);
		if($_POST['search']['value']){
			$this->db->group_start();
			$this->db->like('jenis_surat', $_POST['search']['value']);
			$this->db->or_like('tahun_register', $_POST['search']['value']);
			$this->db->or_like('nomor_surat', $_POST['search']['value']);
			$this->db->or_like('pengirim', $_POST['search']['value']);
			$this->db->where('pengirim_id',$pengirim_id);
			$this->db->group_end();		
		}
	}

	public function get_datatables_eks($pengirim_id){
		$this->_get_datatables_eksternal_query($pengirim_id);
        if($_POST['length'] != -1)
        $this->db->where('pengirim_id', $pengirim_id);
		$this->db->limit($_POST['length'], $_POST['start']);
    	$this->db->order_by('register_id','DESC');
		$query = $this->db->get();
		return $query->result();
	}

	public function count_filtered(){
		$this->_get_datatables_query();
		$query = $this->db->get();
		return $query->num_rows();
	}

	public function count_all(){
		$this->db->from($this->v_table);
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

	public function get_last_pelaksana($register_id){
		try {
			return $this->db->query("SELECT * FROM register_pelaksanaan WHERE register_id=$register_id ORDER BY pelaksanaan_id DESC LIMIT 1");
		} catch (Exception $e) {
			return 0;
		}	
	}

	public function get_list_jabatan(){
		try {
			return $this->db->query("SELECT * FROM v_groups");
		} catch (Exception $e) {
			return 0;
		}	
	}

	public function get_jabatan_pelaksana($groupid){
		try {
			return $this->db->query("SELECT * FROM v_groups WHERE group_id>$groupid");
		} catch (Exception $e) {
			return 0;
		}	
	}

	public function get_register_cetak($periode){
		try {
			return $this->db->query("SELECT * FROM v_suratmasuk WHERE LEFT(tanggal_register,7)='$periode'");
		} catch (Exception $e) {
			return 0;
		}	
	}

	public function get_seleksi_nomor_index($tahun_seleksi){
		try {
			$this->db->select_max('nomor_index');
			$this->db->where('YEAR(tanggal_register)',$tahun_seleksi);
			return $this->db->get('v_suratmasuk');
		} catch (Exception $e) {
			return 0;
		}
	}


	

}