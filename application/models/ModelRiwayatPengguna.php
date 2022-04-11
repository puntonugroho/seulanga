<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class ModelRiwayatPengguna extends CI_Model {

	public function __construct(){
		parent::__construct();
	}

	var $table = 'sys_audittrail';
	var $column_order = array(NULL,'datetime','ipaddress','username','action','title',NULL);
	var $order = array('id' => 'DESC');

	private function _get_datatables_query(){
		$this->db->from($this->table);
		if($_POST['search']['value']){
			$this->db->group_start();
			$this->db->like('username', $_POST['search']['value']);
			$this->db->or_like('action', $_POST['search']['value']);
			$this->db->group_end();		
		}

		if(isset($_POST['order'])) {
			$this->db->order_by($this->column_order[$_POST['order']['0']['column']], $_POST['order']['0']['dir']);
		} else if(isset($this->order)){
			$order = $this->order;
			$this->db->order_by(key($order), $order[key($order)]);
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


	public function get_data_riwayat_id($id){
		try {
			$this->db->where('id',$id);
			return $this->db->get($this->table);
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


}