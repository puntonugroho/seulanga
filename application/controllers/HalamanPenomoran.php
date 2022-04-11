<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class HalamanPenomoran extends CI_Controller {
	function __construct() {
        parent::__construct();
        if($this->session->userdata('status_login')==FALSE){ redirect('keluar'); }
        if(!in_array($this->session->userdata('group_id'), $this->session->userdata('kewenangan_referensi'))) { redirect('keluar'); }
        $this->load->model('ModelPenomoran','model');
        $queryCek = $this->model->get_seleksi('sys_user_online','id',$this->session->userdata('login_id'));
		if(($queryCek->row()->host_address!=$this->input->ip_address())&&($queryCek->row()->userid!=$this->session->userdata('userid'))&&($queryCek->row()->user_agent!=$this->input->user_agent())) { redirect('keluar'); }
    }

	public function index(){
		$data['penomoran_id'] = base64_encode($this->encrypt->encode('-1'));
		$this->load->view('header');
		$this->load->view('penomoran/index',$data);
		$this->load->view('penomoran/footer');	
	}


	public function penomoran_data(){
		$query = $this->model->get_datatables();
		$data = array();
		$no = $_POST['start'];
		foreach ($query as $row) {
			$no++;
			$UserData = array();
			$UserData[] = "<div>".$no."</div>";
			$UserData[] = $row->kode;
			$UserData[] = $row->jenis;
			$UserData[] = "<div>".($row->aktif==1 ? 'Ya' : 'Tidak')."</div>";
			$UserData[] = '<div><button type="button" onclick="BukaModal(\''.base64_encode($this->encrypt->encode($row->id)).'\')" class="btn btn-success btn-sm m-r-5">Detil</button></div>';

			$data[] = $UserData;
		}

		$json_data = array(
				"draw" => $_POST['draw'],
				"recordsTotal" => $this->model->count_all(),
				"recordsFiltered" => $this->model->count_filtered(),
				"data" => $data,
				);
		echo json_encode($json_data);
	}



	public function penomoran_add(){
		$this->form_validation->set_rules('penomoran_id', 'IDPengguna', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$penomoran_id = $this->encrypt->decode(base64_decode($this->input->post('penomoran_id')));
		
		$array_status = array(''=>"Pilih",'1'=>'Ya','2'=>'Tidak');

		$kode = "";
		$jenis = "";
		$keterangan = "";
		$TombolHapus = "";
	    if ($penomoran_id=='-1'){
			$judul = "TAMBAH KODE PENOMORAN SURAT KELUAR";
		  	$status= form_dropdown('status', $array_status, '', 'class="form-control" required id="status"');
		} else {
			$judul = "EDIT KODE PENOMORAN SURAT KELUAR";
			$queryPenomoran = $this->model->get_seleksi('ref_penomoran','id',$penomoran_id);
			$kode = $queryPenomoran->row()->kode;
			$jenis = $queryPenomoran->row()->jenis;
			$keterangan = $queryPenomoran->row()->keterangan;
			$aktif = $queryPenomoran->row()->aktif;
			
			$status= form_dropdown('status', $array_status,$aktif, 'class="form-control" required id="status"');

			$TombolHapus = '<button onclick="HapusModal(\''.base64_encode($this->encrypt->encode($penomoran_id)).'\')" id="TombolHapus" class="btn btn-sm btn-danger">Hapus</button>';
		}
		echo json_encode(array('st'=>1,
					'penomoran_id'=>base64_encode($this->encrypt->encode($penomoran_id)),
					'kode'=>$kode, 
					'jenis'=>$jenis,
					'status'=>$status,
					'tombol_hapus'=>$TombolHapus,
					'keterangan'=>$keterangan,
					'judul'=>$judul));
		return;
	}


	public function penomoran_hapus(){
		$this->form_validation->set_rules('penomoran_id', 'Data Format Nomor ', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$penomoran_id = $this->encrypt->decode(base64_decode($this->input->post('penomoran_id')));
		
		$queryHapus = $this->model->hapus_data('ref_penomoran','id',$penomoran_id);

		if($queryHapus==1){
			echo json_encode(array('st'=>1,'msg'=>'Data Format Penomoran Surat Berhasil Dihapus'));
		} else {
			echo json_encode(array('st'=>0,'msg'=>'Data Format Penomoran Surat Gagal Dihapus'));
		}
		return;
	}


	

	public function penomoran_simpan(){
		$this->form_validation->set_rules('penomoran_id', 'Data Penomoran', 'trim|required');
		$this->form_validation->set_rules('nama', 'Nama Kode Penomoran Surat Keluar', 'trim|required');
		$this->form_validation->set_rules('keterangan', 'Keterangan', 'trim|required');
		$this->form_validation->set_rules('status', 'Status Kode Penomoran', 'trim|required|exact_length[1]|in_list[1,2]');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Tidak Berhasil:<br/>'.validation_errors()));
			return;
		}

		$id= $this->encrypt->decode(base64_decode($this->input->post('penomoran_id')));
		$nama= $this->input->post('nama');
		$keterangan= $this->input->post('keterangan');
		$status= $this->input->post('status');

		$data = array(
				'jenis' => $nama,
				'keterangan' => $keterangan,
				'aktif' => $status);
		
		if($id=='-1'){
			$querySimpan = $this->model->simpan_data('ref_penomoran',$data);
		} else {
			$querySimpan = $this->model->pembaharuan_data('ref_penomoran',$data,'id',$id);
		}
		if($querySimpan==1){
			echo json_encode(array('st'=>1,'msg'=>'Data Format Penomoran Surat Berhasil Disimpan'));
		} else {
			echo json_encode(array('st'=>0,'msg'=>'Data Format Penomoran Surat Gagal Disimpan'));
		}
		return;

	}


}
