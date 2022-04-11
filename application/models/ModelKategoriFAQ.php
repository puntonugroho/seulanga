<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class ModelKategoriFAQ extends CI_Model {

	public function __construct(){
		parent::__construct();
	}


	private function add_audittrail($action,$title,$descrip){
		try {
			$data = array(
				'datetime' => date("Y-m-d H:i:s"),
				'ipaddress' => $this->input->ip_address(),
				'username' => '',
				'tablename' => 'faq_jenis',
				'formname' => 'Data Kategori FAQ',
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

	public function get_data_kategori_faq(){
		try {
			return $this->db->get('faq_jenis');
		} catch (Exception $e) {
			return 0;
		}
	}


	public function get_data_kategori_faq_id($id){
		try {
			$this->db->where('id',$id);
			return $this->db->get('faq_jenis');
		} catch (Exception $e) {
			return 0;
		}
	}

	public function update_data_kategori($kategori_id,$data_faq){
		try {
			$this->db->where('id',$kategori_id);
			$this->db->update('faq_jenis',$data_faq);

			$title = "Pembaharuan Kategori FAQ <br />Tambah table <b>faq_jenis</b> dari halaman <b>kategori_faq</b>";
			$descrip = $this->fetch_description($title,$data_faq);
			$this->add_audittrail("PEMBAHARUAN",$title,$descrip);

			return TRUE;
		} catch (Exception $e) {
			return FALSE;
		}	
	}

	public function simpan_data_kategori($data_faq){
		try {
			$this->db->insert('faq_jenis',$data_faq);
			$title = "Tambah Kategori FAQ <br />Tambah table <b>faq_jenis</b> dari halaman <b>kategori_faq</b>";
			$descrip = $this->fetch_description($title,$data_faq);
			$this->add_audittrail("SIMPAN",$title,$descrip);
			return TRUE;
		} catch (Exception $e) {
			return FALSE;
		}	
	}

	public function cek_data_faq($kategori_id){
		try {
			$this->db->where('jenis_id',$kategori_id);
			return $this->db->get('faq_data');
		} catch (Exception $e) {
			return FALSE;
		}	
	}

	public function hapus_data_kategori_faq($id,$data_faq){
		try {
			$this->db->where('id',$id);
			$this->db->delete('faq_jenis');
			$title = "Hapus Kategori FAQ <br />Hapus table <b>faq_jenis</b> dari halaman <b>kategori_faq</b>";
			$descrip = $this->fetch_description($title,$data_faq);
			$this->add_audittrail("HAPUS",$title,$descrip);
			return TRUE;
		} catch (Exception $e) {
			return 0;
		}
	}


}