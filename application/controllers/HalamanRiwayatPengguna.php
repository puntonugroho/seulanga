<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class HalamanRiwayatPengguna extends CI_Controller {
	function __construct() {
       	parent::__construct();
		if($this->session->userdata('status_login')==FALSE){ redirect('keluar'); }
        if(!in_array($this->session->userdata('group_id'), $this->session->userdata('kewenangan_konfigurasi'))) { redirect('keluar'); }
        $this->load->model('ModelRiwayatPengguna','model');
        $queryCek = $this->model->get_seleksi('sys_user_online','id',$this->session->userdata('login_id'));
		if(($queryCek->row()->host_address!=$this->input->ip_address())&&($queryCek->row()->userid!=$this->session->userdata('userid'))&&($queryCek->row()->user_agent!=$this->input->user_agent())) { redirect('keluar'); }
    }

	public function index(){
		$this->load->view('header');
		$this->load->view('riwayat/index');
		$this->load->view('footer');	
	}


	public function riwayat_data(){
		$query = $this->model->get_datatables();
		$data = array();
		$no = $_POST['start'];
		foreach ($query as $row) {
			$no++;
			$UserData = array();
			$UserData[] = "<div align='center'>".$no."</div>";
			$UserData[] = "<div align='center'>".$row->datetime."</div>";
			$UserData[] = "<div align='center'>".$row->ipaddress."</div>";
			$UserData[] = $row->username;
			$UserData[] = "<div align='center'>".$row->action."</div>";
			$UserData[] = $row->title;
			$UserData[] = '<div align="center"><button type="button" onclick="BukaModal(\''.base64_encode($this->encrypt->encode($row->id)).'\')" class="btn btn-success btn-sm m-r-5">Detil</button></div>';

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



	public function riwayat_detil(){
		$this->form_validation->set_rules('id', 'Data Riwayat', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$id = $this->encrypt->decode(base64_decode($this->input->post('id')));
		
		$judul = "Detil Riwayat Pengguna";
		$queryRiwayat = $this->model->get_data_riwayat_id($id);
		
		$datetime = $queryRiwayat->row()->datetime;
		$ipaddress = $queryRiwayat->row()->ipaddress;
		$username = $queryRiwayat->row()->username;
		$tablename = $queryRiwayat->row()->tablename;
		$action = $queryRiwayat->row()->action;
		$title = $queryRiwayat->row()->title;
		$description = $queryRiwayat->row()->description;
			
		echo json_encode(array('st'=>1,
					'datetime'=>$datetime, 
					'ipaddress'=>$ipaddress,
					'username'=>$username, 
					'tablename'=>$tablename,
					'action'=>$action,
					'title'=>$title,
					'judul'=>$judul,
					'description'=>$description));
		return;
	}


	

}
