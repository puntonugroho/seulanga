<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class ModelUtama extends CI_Model {

	public function __construct(){
		parent::__construct();
	}

	private function _get_datatables_query(){
		$pengguna_id = $this->session->userdata('userid');
		$group_id = $this->session->userdata('group_id');
		
		if($group_id=='2' || $group_id=='3'){
			$arr_group = array('2','3' );
			$arr_pelaksanaan = array('1','30' );
			$this->db->where('tujuan_id',$group_id);
			$this->db->where('tujuan_disposisi_jabatan_id', '2');
			$this->db->where_in('status_pelaksanaan_id',$arr_pelaksanaan);
			$this->db->from('v_suratmasuk');
		} else {
			$this->db->where('status_pelaksanaan_id<>','20');
			$this->db->where('tujuan_disposisi_id',$pengguna_id);
			$this->db->from('v_suratmasuk');
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

	public function count_filtered(){
		$this->_get_datatables_query();
		$query = $this->db->get();
		return $query->num_rows();
	}

	public function count_all(){
		$this->db->from('v_suratmasuk');
		return $this->db->count_all_results();
	}

	public function get_seleksi($nama_tabel,$kolom_seleksi,$seleksi){
		try {
			$this->db->where($kolom_seleksi,$seleksi);
			return $this->db->get($nama_tabel);
		} catch (Exception $e) {
			return 0;
		}
	}

	public function get_seleksi_pertama($groupid){
		try {
			return $this->db->query('SELECT * FROM v_suratmasuk WHERE CASE WHEN tujuan_disposisi_jabatan_id IS NULL THEN tujuan_id='.$groupid.' ELSE tujuan_disposisi_jabatan_id='.$groupid.' END');
		} catch (Exception $e) {
			return 0;
		}
	}

	public function get_history_pelaksanaan($nama_tabel,$register_id,$reg){
		try {
			$this->db->select('tanggal_pelaksanaan,dari_jabatan,keterangan');
			$this->db->where($register_id,$reg);
			$this->db->order_by('pelaksanaan_id','ASC');
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