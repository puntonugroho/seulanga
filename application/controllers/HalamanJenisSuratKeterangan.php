<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class HalamanJenisSuratKeterangan extends CI_Controller {

	function __construct() {
        parent::__construct();
        if($this->session->userdata('status_login')==FALSE){ redirect('keluar'); }
        if(!in_array($this->session->userdata('group_id'), $this->session->userdata('kewenangan_suratketerangan'))) { redirect('keluar'); }
        $this->load->model('ModelJenisSuratKeterangan','model');
        $queryCek = $this->model->get_seleksi('sys_user_online','id',$this->session->userdata('login_id'));
		if(($queryCek->row()->host_address!=$this->input->ip_address())&&($queryCek->row()->userid!=$this->session->userdata('userid'))&&($queryCek->row()->user_agent!=$this->input->user_agent())) { redirect('keluar'); }
    }

    	
	public function index(){
		$data['register_id'] = base64_encode($this->encrypt->encode('-1'));
		$this->load->view('header');
		$this->load->view('jenissuratketerangan/index',$data);
		$this->load->view('footer');
	}

	public function jenissuratketerangan_data(){
		$query = $this->model->get_datatables();
		$data = array();
		$no = $_POST['start'];
		foreach ($query as $row) {
			$no++;
			$UserData = array();
			$UserData[] = "<div align='center'>".$no."</div>";
			$UserData[] = "<div align='center'>".$row->kode."</div>";
			$UserData[] = $row->nama;
			$UserData[] = "<div align='center'>".($row->aktif=='1' ? 'Ya' : 'Tidak')."</div>";
			$UserData[] = '<div align="center">
				<button type="button" onclick="BukaModal(\''.base64_encode($this->encrypt->encode($row->id)).'\')" class="btn btn-success btn-sm m-r-5"><div><i class="fa fa-2x fa-edit"></i></div></button>
				</div>';
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


	public function jenissuratketerangan_add(){
		$this->form_validation->set_rules('id', '', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$id = $this->encrypt->decode(base64_decode($this->input->post('id')));

		$array_aktif = array('' => 'Pilih', '1' => 'Ya','2' => 'Tidak');
		$array_register = array('' => 'Pilih', '1' => 'Register Pidana','2' => 'Register Perdata');

		if($id=='-1'){
			$judul = "TAMBAH DATA JENIS SURAT KETERANGAN";
			$aktif = form_dropdown('aktif', $array_aktif,'', 'class="form-control" id="aktif"');
			$register = form_dropdown('register', $array_register,'', 'class="form-control" id="register"');
			$kode = "";
			$nama = "";
			$download = "";

		} else {
			$judul = "EDIT DATA JENIS SURAT KETERANGAN";

			$queryRegister = $this->model->get_seleksi('ref_jenis_surat_keterangan','id',$id);
			$kode = $queryRegister->row()->kode;
			$nama = $queryRegister->row()->nama;
			$aktif_id = $queryRegister->row()->aktif;
			$register_id = $queryRegister->row()->register_id;
			$dokumen = $queryRegister->row()->dokumen;
			if(!empty($dokumen)){
				$download = '<a href="'.base_url().'dokumentemplate/'.$dokumen.'" download>UNDUH</a>';
			} else {
				$download = '<font color="red">DOKUMEN TIDAK TERSEDIA</font>';
			}
			$aktif = form_dropdown('aktif', $array_aktif,$aktif_id, 'class="form-control" id="aktif"');
			$register = form_dropdown('register', $array_register,$register_id, 'class="form-control" id="register"');
		}

		echo json_encode(array('st'=>1,
					'id'=>base64_encode($this->encrypt->encode($id)),
					'kode'=>$kode,
					'nama'=>$nama,
					'dokumen'=>$download,
					'aktif'=>$aktif,
					'register'=>$register,
					'judul'=>$judul));
		return;
	}

	public function jenissuratketerangan_simpan(){
		$this->form_validation->set_rules('id', 'Data Surat Keterangan', 'trim|required');
		$this->form_validation->set_rules('kode', 'Kode Jenis Surat', 'trim|required');
		$this->form_validation->set_rules('nama', 'Nama Jenis Surat', 'trim|required');
		$this->form_validation->set_rules('register', 'Data Register', 'trim|required');
		$this->form_validation->set_rules('aktif', 'Status Aktif', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Tidak Berhasil:<br/>'.validation_errors()));
			return;
		}

		$id = $this->encrypt->decode(base64_decode($this->input->post('id')));
		$kode= $this->input->post('kode');
		$nama= $this->input->post('nama');
		$aktif= $this->input->post('aktif');
		$register_id= $this->input->post('register');

		$upload_data = "";
		if(!empty($_FILES['dokumen']['name'])){
			$config = array(
				'upload_path' => './dokumentemplate/',
				'allowed_types' => "rtf",
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
		}

		if($id=='-1'){
			$data = array('kode' => $kode,
						'nama' => $nama,
						'aktif' => $aktif,
						'register_id' => $register_id,
						'dokumen' => $upload_data['file_name']);

			$querySimpan = $this->model->simpan_data('ref_jenis_surat_keterangan',$data);
		} else {
			if(!empty($upload_data['file_name'])){
				$data = array('kode' => $kode,
						'nama' => $nama,
						'aktif' => $aktif,
						'register_id' => $register_id,
						'dokumen' => $upload_data['file_name']);
			} else {
				$data = array('kode' => $kode,
						'nama' => $nama,
						'register_id' => $register_id,
						'aktif' => $aktif);
			}

			$querySimpan = $this->model->pembaharuan_data('ref_jenis_surat_keterangan',$data,'id',$id);
		}
		redirect('jenissuratketerangan'); 
	}

	

}
