<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class ModelLogin extends CI_Model {

	public function __construct(){
		parent::__construct();
	}

	public function get_seleksi_pengguna($username){
		try {
			$this->db->where('username',$username);
			return $this->db->get('v_users');
		} catch (Exception $e) {
			return 0;
		}
	}


	public function log_online($data_login){
		try {
			$this->db->insert('sys_user_online', $data_login);
			return $this->db->insert_id();
		} catch (Exception $e) {
			return 0;
		}
	}

	public function get_konfigurasi($id){
		try {
			$this->db->where('id',$id);
			return $this->db->get('sys_config');
		} catch (Exception $e) {
			return 0;
		}	
	}


}