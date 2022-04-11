<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class ModelBukuTamu extends CI_Model {

	public function __construct(){
		parent::__construct();
	}

	var $table = 'bukutamu';
	var $v_table_groups = 'v_groups';
	var $table_pegawai = 'pegawai';
	var $table_groups = 'sys_groups';

	private function _get_datatables_query(){
		$this->db->from($this->table);
		if($_POST['search']['value']){
			$this->db->group_start();
			$this->db->like('tujuan_nama', $_POST['search']['value']);
			$this->db->or_like('tujuan_jabatan', $_POST['search']['value']);
			$this->db->or_like('nama', $_POST['search']['value']);
			$this->db->group_end();		
		}
	}


	public function get_datatables(){
		$this->_get_datatables_query();
        if($_POST['length'] != -1)
        $this->db->limit($_POST['length'], $_POST['start']);
		$query = $this->db->get();
		return $query->result();
	}

	public function count_filtered(){
		$this->_get_datatables_query();
		$query = $this->db->get();
		return $query->num_rows();
	}

	public function count_all(){
		$this->db->from($this->table);
		return $this->db->count_all_results();
	}


	public function hapus_data($nama_tabel,$kolom_seleksi,$seleksi){
		try {
			$this->db->where($kolom_seleksi,$seleksi);
			return $this->db->delete($nama_tabel);
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


	public function get_seleksi_bukutamu($id){
		try {
			$this->db->where('id',$id);
			return $this->db->get($this->table);
		} catch (Exception $e) {
			return 0;
		}
	}

	public function get_kewenangan(){
		try {
			return $this->db->get($this->v_table_groups);
		} catch (Exception $e) {
			return 0;
		}
	}


	public function get_seleksi_pegawai($jabatan_id){
		try {
			$this->db->where('jabatan_id',$jabatan_id);
			return $this->db->get($this->table_pegawai);
		} catch (Exception $e) {
			return 0;
		}
	}

	public function get_seleksi_jabatan($jabatan_id){
		try {
			$this->db->where('jabatan_id',$jabatan_id);
			return $this->db->get($this->table_groups);
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


	public function audittrail($tabel,$action,$title,$descrip){
		try {
			$data = array(
				'datetime' => date("Y-m-d H:i:s"),
				'ipaddress' => $this->input->ip_address(),
				'username' => $this->session->userdata('username'),
				'tablename' => $tabel,
				'action' => $action,
				'title' => $title,
				'description' => $descrip
			);
			$this->db->insert('sys_audittrail', $data);
		} catch (Exception $e) {
			
		}
	}

	public function fetch_description($title,$data){
		$descrip = '<br><table style="vertical-align:top" cellspacing="0" cellpadding="1" border="1">';
		$descrip .= '<tr><th>Nama Kolom</th><th>Nilai</th></tr>';
		foreach ($data as $key => $value) {
			$descrip .= '<tr>';
			$descrip .= '<td>'.$key.'</td>';
			$descrip .= '<td>'.$value.'</td>';
			$descrip .= '</tr>';
		}
		$descrip .= '</table>';
		return $descrip;
	}


}