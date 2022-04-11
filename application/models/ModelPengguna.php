<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class ModelPengguna extends CI_Model {

	public function __construct(){
		parent::__construct();
	}

	var $table = 'v_users';
	
	private function _get_datatables_query(){
		$this->db->where('group_id>','1');
		$this->db->from($this->table);
		if($_POST['search']['value']){
			$this->db->group_start();
			$this->db->like('fullname', $_POST['search']['value']);
			$this->db->or_like('username', $_POST['search']['value']);
			$this->db->or_like('group_name', $_POST['search']['value']);
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



















	public function get_data_pengguna(){
		try {
			$this->db->where('group_id>','1');
			return $this->db->get('v_users');
		} catch (Exception $e) {
			return 0;
		}
	}


	public function get_data_pengguna_id($userid){
		try {
			$this->db->where('userid',$userid);
			return $this->db->get('v_users');
		} catch (Exception $e) {
			return 0;
		}
	}

	public function get_pegawai(){
		try {
			return $this->db->get('pegawai');
		} catch (Exception $e) {
			return 0;
		}
	}

	public function get_seleksi_pegawai($id){
		try {
			$this->db->where('id',$id);
			return $this->db->get('pegawai');
		} catch (Exception $e) {
			return 0;
		}
	}


	private function add_audittrail($action,$title,$descrip){
		try {
			$data = array(
				'datetime' => date("Y-m-d H:i:s"),
				'ipaddress' => $this->input->ip_address(),
				'username' => '',
				'tablename' => 'sys_users',
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



	public function get_kewenangan(){
		try {
			return $this->db->get('v_groups');
		} catch (Exception $e) {
			return 0;
		}
	}

	public function get_pengguna($userid){
		try {
			$this->db->where('userid',$userid);
			return $this->db->get('v_groups');
		} catch (Exception $e) {
			return 0;
		}
	}

	public function get_last_id(){
		try {
			return $query = $this->db->query("SELECT MAX(userid)+1 AS userid FROM sys_users");
		} catch (Exception $e) {
			return 0;
		}
	}

	public function pengguna($userid=''){
		try {
			if($userid!=''){
				$where = "  WHERE userid=".$userid." ";
			} else {
				$where = " WHERE groupid>='2' ";
			}

			return $query = $this->db->query("SELECT * FROM v_users ".$where." ORDER BY userid DESC");
		} catch (Exception $e) {
			return 0;
		}
	}

	public function group(){
		try {
			return $query = $this->db->query("SELECT sys_groups.groupid AS groupid, getTreeName((sys_groups.level - 2),sys_groups.name)  AS group_name FROM sys_groups WHERE ((sys_groups.enable = 1) AND (sys_groups.lft > 2) AND (sys_groups.rgt <= 1000)) AND groupid>2 ORDER BY sys_groups.lft");
		} catch (Exception $e) {
			return 0;
		}
	}


	public function users_add($data_user,$data_group){
		try {
			if($this->db->insert('sys_users', $data_user)){
				$this->db->insert('sys_user_group', $data_group);				
			}

			$title = "Tambah Pengguna [Username=<b>".$data_user['username']."</b>]<br />Tambah table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=".$data_user['userid']."]";
			$descrip = $this->fetch_description($title,$data_user);
			$this->add_audittrail("INSERT",$title,$descrip);
			return 1;
		} catch (Exception $e) {
			return 0;
		}
	}

	public function get_activation($email){
		try {
			return $query = $this->db->query("SELECT activation FROM sys_users where email = '".$email."'");
		} catch (Exception $e) {
			return 0;
		}
	}

	public function aktivasi_pengguna($code){
		try {
			return $query = $this->db->query("UPDATE sys_users set block=0 where activation = '".$code."'");
		} catch (Exception $e) {
			return 0;
		}
	}

	public function users_update($data_user,$data_group,$userid){
		try {
			$this->db->where('userid', $userid);
			$this->db->update('sys_users', $data_user);
			$this->db->where('userid', $userid);
			$this->db->update('sys_user_group', $data_group);
			
			$title = "Edit Pengguna [Username=<b>".$data_user['username']."</b>]<br />Edit table <b>sys_users</b> dari halaman <b>users_edit</b> dengan Primary Key [userid=".$userid."]";
			$descrip = $this->fetch_description($title,$data_user);
			$this->add_audittrail("UPDATE",$title,$descrip);
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