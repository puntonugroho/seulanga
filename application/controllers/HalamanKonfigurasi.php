<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class HalamanKonfigurasi extends CI_Controller {
	function __construct() {
        parent::__construct();
        if($this->session->userdata('status_login')==FALSE){ redirect('keluar'); }
        if(!in_array($this->session->userdata('group_id'), $this->session->userdata('kewenangan_konfigurasi'))) { redirect('keluar'); }
        $this->load->model('ModelKonfigurasi','model');
        $queryCek = $this->model->get_seleksi('sys_user_online','id',$this->session->userdata('login_id'));
		if(($queryCek->row()->host_address!=$this->input->ip_address())&&($queryCek->row()->userid!=$this->session->userdata('userid'))&&($queryCek->row()->user_agent!=$this->input->user_agent())) { redirect('keluar'); }
    }

	public function index(){
		$queryKonfigurasi1 = $this->model->get_seleksi('sys_config','id','20');
		$queryKonfigurasi2 = $this->model->get_seleksi('sys_config','id','21');
		$queryKonfigurasi3 = $this->model->get_seleksi('sys_config','id','22');
		$queryKonfigurasi4 = $this->model->get_seleksi('sys_config','id','4');
		$queryKonfigurasi5 = $this->model->get_seleksi('sys_config','id','5');
		$queryKonfigurasi6 = $this->model->get_seleksi('sys_config','id','23');
		$queryKonfigurasi7 = $this->model->get_seleksi('sys_config','id','26');

		$data['IDPN'] = $queryKonfigurasi1->row()->value;
		$data['IDPT'] = $queryKonfigurasi2->row()->value;
		$data['LogoPN'] = base_url().'assets/img/'.$queryKonfigurasi3->row()->value;
		$data['NamaPN'] = $queryKonfigurasi4->row()->value;
		$data['AlamatPN'] = $queryKonfigurasi5->row()->value;
		$data['KodeSurat'] = $queryKonfigurasi6->row()->value;
		$data['KodePerkara'] = $queryKonfigurasi7->row()->value;

		$queryPT = $this->model->get_seleksi('pengadilan_tinggi','jenis_pengadilan','4');
		$arrayPT = array();
		$arrayPT['']= "Pilih";
		foreach ($queryPT->result() as $row){ 
			$arrayPT[$row->id] = $row->nama; 
		}

		$queryPN = $this->model->get_seleksi('pengadilan_negeri','jenis_pengadilan','4');
		$arrayPN = array();
		$arrayPN['']= "Pilih";
		foreach ($queryPN->result() as $row){ 
			$arrayPN[$row->id] = $row->nama; 
		}

		$data['dataPN'] = $arrayPN;
		$data['dataPT'] = $arrayPT;

		$this->load->view('header');
		$this->load->view('konfigurasi/index',$data);
		$this->load->view('konfigurasi/footer');	
	}

	public function konfigurasi_satker(){
		$this->form_validation->set_rules('pengadilan_tinggi','Data Pengadilan Tinggi', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$pt_id = $this->input->post('pengadilan_tinggi');

		$queryPN = $this->model->get_seleksi('pengadilan_negeri','pt_id',$pt_id);
		$arrayPN = array();
		$arrayPN['']= "Pilih";
		foreach ($queryPN->result() as $row){ 
			$arrayPN[$row->id] = $row->nama; 
		}

		$pengadilan_negeri = form_dropdown('pengadilan_negeri', $arrayPN,'', 'class="form-control" required id="pengadilan_negeri"');

		echo json_encode(array('st'=>1,'pengadilan_negeri'=>$pengadilan_negeri));
		return;
	}

	public function konfigurasi_simpan(){
		$this->form_validation->set_rules('pengadilan_tinggi', 'Tingkat Banding', 'trim');
		$this->form_validation->set_rules('pengadilan_negeri', 'Tingkat Pertama', 'trim');
		$this->form_validation->set_rules('kode_surat', 'Kode Surat', 'trim|required');
		$this->form_validation->set_rules('kode_perkara', 'Kode Perkara', 'trim|required');
		$this->form_validation->set_rules('alamat', 'Alamat', 'trim|required');
		if ($this->form_validation->run() == FALSE){ redirect('konfigurasi'); }

		$pt_id = $this->input->post('pengadilan_tinggi');
		$pn_id = $this->input->post('pengadilan_negeri');
		$alamat = $this->input->post('alamat');
		$kode_surat = $this->input->post('kode_surat');
		$kode_perkara = $this->input->post('kode_perkara');

		if($pt_id!=''){
			$queryPT = $this->model->get_seleksi('pengadilan_tinggi','id',$pt_id);
			$NamaPT = $queryPT->row()->nama;
			$AlamatPT = $queryPT->row()->alamat;

			$data2 = array('value' => $pt_id );
			$data3 = array('value' => $NamaPT );
			$data4 = array('value' => $AlamatPT );

			$query2 = $this->model->pembaharuan_data('sys_config',$data2,'id','21');
			$query3 = $this->model->pembaharuan_data('sys_config',$data3,'id','17');
			$query4 = $this->model->pembaharuan_data('sys_config',$data4,'id','18');

		}

		if($pn_id!=''){
			$queryPN = $this->model->get_seleksi('pengadilan_negeri','id',$pn_id);
			$NamaPN = $queryPN->row()->nama;
			$KodePN = $queryPN->row()->kode;

			$data1 = array('value' => $pn_id );
			$data5 = array('value' => $KodePN );
			$data6 = array('value' => $NamaPN );

			$query1 = $this->model->pembaharuan_data('sys_config',$data1,'id','20');
			$query5 = $this->model->pembaharuan_data('sys_config',$data5,'id','3');
			$query6 = $this->model->pembaharuan_data('sys_config',$data6,'id','4');

		}

		$upload_data = "";
		if(!empty($_FILES['dokumen']['name'])){
			$config = array(
				'upload_path' => './assets/img/',
				'allowed_types' => "jpg|jpeg|png",
				'file_ext_tolower' => TRUE,
				'encrypt_name' => TRUE,
				'overwrite' => TRUE,
				'remove_spaces' => TRUE,
				'max_size' => "10485760"
			);

			$this->load->library('upload',$config);
            $this->upload->initialize($config);

            $this->upload->do_upload('dokumen');
            $upload_data = $this->upload->data();    

            $data8 = array('value' => $upload_data['file_name'] ); 	
            $query8 = $this->model->pembaharuan_data('sys_config',$data8,'id','22');	
		}
		
		$data7 = array('value' => $alamat );
		$data9 = array('value' => $kode_surat );
		$data10 = array('value' => $kode_perkara );
		
		$query7 = $this->model->pembaharuan_data('sys_config',$data7,'id','5');
		$query9 = $this->model->pembaharuan_data('sys_config',$data9,'id','23');
		$query10 = $this->model->pembaharuan_data('sys_config',$data10,'id','26');

		redirect('konfigurasi');
	}
}
