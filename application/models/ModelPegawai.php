<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class ModelPegawai extends CI_Model {

	public function __construct(){
		parent::__construct();
	}

	var $table = 'pegawai';

	private function _get_datatables_query(){
		$this->db->from($this->table);
		if($_POST['search']['value']){
			$this->db->group_start();
			$this->db->like('nip', $_POST['search']['value']);
			$this->db->or_like('nama_gelar', $_POST['search']['value']);
			$this->db->or_like('pangkat', $_POST['search']['value']);
			$this->db->or_like('jabatan_nama', $_POST['search']['value']);
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


	private function add_audittrail($action,$title,$descrip){
		try {
			$data = array(
				'datetime' => date("Y-m-d H:i:s"),
				'ipaddress' => $this->input->ip_address(),
				'username' => $this->session->userdata('username'),
				'tablename' => 'pegawai',
				'action' => $action,
				'title' => $title,
				'description' => $descrip
			);
			$this->db->insert('sys_audittrail', $data);
		} catch (Exception $e) {
			
		}
	}

	private function fetch_description($title,$data){
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

	public function get_seleksi_pegawai($id){
		try {
			$this->db->where('id',$id);
			return $this->db->get('pegawai');
		} catch (Exception $e) {
			return 0;
		}
	}

	public function get_seleksi_golongan($id){
		try {
			$this->db->where('id',$id);
			return $this->db->get('ref_pangkat');
		} catch (Exception $e) {
			return 0;
		}
	}


	public function get_golongan(){
		try {
			return $this->db->get('ref_pangkat');
		} catch (Exception $e) {
			return 0;
		}
	}

	public function get_seleksi_jabatan($groupid){
		try {
			$this->db->where('groupid',$groupid);
			return $this->db->get('sys_groups');
		} catch (Exception $e) {
			return 0;
		}
	}


	public function get_kewenangan(){
		try {
			return $this->db->get('v_groups');
		} catch (Exception $e) {
			return 0;
		}
	}

	public function pegawai_add($data_pegawai){
		try {
			$this->db->insert('pegawai', $data_pegawai);
			$title = "Tambah Pegawai [Pegawai=<b>".$data_pegawai['nama_gelar']."</b>]<br />Tambah tabel <b>pegawai</b>]";
			$descrip = $this->fetch_description($title,$data_pegawai);
			$this->add_audittrail("TAMBAH",$title,$descrip);
			return 1;
		} catch (Exception $e) {
			return 0;
		}
	}

	public function pegawai_update($data_pegawai,$id,$data_group,$data_pengguna,$userid){
		try {
			$this->db->where('id', $id);
			$this->db->update('pegawai', $data_pegawai);
			$this->db->where('userid', $userid);
			$this->db->update('sys_user_group', $data_group);
			$this->db->where('userid', $userid);
			$this->db->update('sys_users', $data_pengguna);
			
			$title = "Edit Pegawai [Pegawai=<b>".$data_pegawai['nama_gelar']."</b>]<br />Edit tabel <b>pegawai</b>]";
			$descrip = $this->fetch_description($title,$data_pegawai);
			$this->add_audittrail("EDIT",$title,$descrip);
			return 1;
		} catch (Exception $e) {
			return 0;
		}
	}


	public function get_seleksi_pengguna($pegawai_id){
		try {
			$this->db->where('pegawai_id',$pegawai_id);
			return $this->db->get('v_users');
		} catch (Exception $e) {
			return 0;
		}
	}


	public function hapus_pegawai($id){
		try {
			$this->db->where('id',$id);
			$this->db->delete('pegawai');
			return TRUE;
		} catch (Exception $e) {
			return FALSE;
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

	public function hapus_data($nama_tabel,$kolom_seleksi,$seleksi){
		try {
			$this->db->where($kolom_seleksi,$seleksi);
			$this->db->delete($nama_tabel);
			return 1;
		} catch (Exception $e) {
			return 0;
		}
	}








}