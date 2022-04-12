<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class ModelSuratKeterangan extends CI_Model {

	public function __construct(){
		parent::__construct();
		
	}

	private function _get_datatables_query(){
		if($this->input->post('bulan_register_cari')){ $this->db->where('MONTH(tanggal_register)', $this->input->post('bulan_register_cari')); }
		if($this->input->post('tahun_register_cari')){ $this->db->where('tahun_register', $this->input->post('tahun_register_cari')); }
		if($this->input->post('jenis_suratketerangan')){ $this->db->where('jenis_keterangan_id', $this->input->post('jenis_suratketerangan')); }
		$this->db->from('register_surat_keterangan');
		if($_POST['search']['value']){
			$this->db->group_start();
			$this->db->like('jenis_keterangan', $_POST['search']['value']);
			$this->db->or_like('tahun_register', $_POST['search']['value']);
			$this->db->or_like('tanggal_register', $_POST['search']['value']);
			$this->db->or_like('nomor_register', $_POST['search']['value']);
			$this->db->or_like('pemohon_nama', $_POST['search']['value']);
			$this->db->or_like('pemohon_alasan', $_POST['search']['value']);
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

	public function count_filtered(){
		$this->_get_datatables_query();
		$query = $this->db->get();
		return $query->num_rows();
	}

	public function count_all(){
		$this->db->from('register_surat_keterangan');
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

	public function get_seleksi_nomor_index($tahun_seleksi){
		try {
			$this->db->select_max('nomor_index');
			$this->db->where('tahun_register',$tahun_seleksi);
			return $this->db->get('register_surat_keterangan');
		} catch (Exception $e) {
			return 0;
		}
	}


	public function get_seleksi_pihak($nama_pihak,$jenis_perkara){
		try {
			$where_perkara = ($jenis_perkara=='1' ? "B.alur_perkara_id>'100'" : "B.alur_perkara_id<'100'" );
			$this->sipp = $this->load->database('database_sipp',TRUE);
			return $this->sipp->query("SELECT
				A.nama AS nama,
				A.alamat AS alamat,
				B.nomor_perkara AS nomor_perkara
				FROM perkara_pihak2 AS A
				LEFT JOIN perkara AS B ON B.perkara_id=A.perkara_id
				LEFT JOIN pihak AS C ON C.id=A.pihak_id
				WHERE ".$where_perkara."
				AND B.alur_perkara_id<>'114'
				AND A.nama LIKE '%".$nama_pihak."%'");
			$this->sipp->close();
		} catch (Exception $e) {
			return 0;
		}	
	}

	public function get_register_cetak($periode){
		try {
			return $this->db->query("SELECT * FROM register_surat_keterangan WHERE LEFT(tanggal_register,7)='$periode'");
		} catch (Exception $e) {
			return 0;
		}	
	}

	public function get_ref_surat_keterangan(){
		try {
			return $this->db->query("SELECT * FROM ref_jenis_surat_keterangan");
		} catch (Exception $e) {
			return 0;
		}
	}

	

}