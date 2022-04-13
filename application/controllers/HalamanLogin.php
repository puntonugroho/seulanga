<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class HalamanLogin extends CI_Controller {
	function __construct() {
        parent::__construct();
        $this->load->model('ModelLogin','model');
    }

	public function index(){
		$data['browser'] = $this->agent->browser();
		$this->load->view('login/index',$data);	
	}

	private function arr2md5($arrinput){	
		$hasil='';
        foreach($arrinput as $val){
        	if($hasil==''){
        		$hasil=md5($val);
        	}else {
        		$code=md5($val);
        		for($hit=0;$hit<min(array(strlen($code),strlen($hasil)));$hit++){
        			$hasil[$hit]=chr(ord($hasil[$hit]) ^ ord($code[$hit]));
        		}
        	}
        }
        return(md5($hasil));
    }


	public function validasi(){
		$this->form_validation->set_rules('nama', 'Nama Pengguna','trim|required|min_length[3]|max_length[100]');
		$this->form_validation->set_rules('password', 'Kata Kunci','trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Tidak Berhasil:<br/>'.validation_errors()));
			return;
		}

		$nama= $this->input->post('nama');
		$password= $this->input->post('password');

		$queryPengguna = $this->model->get_seleksi_pengguna($nama);
		$cekPengguna = $queryPengguna->num_rows();
		//die(var_dump($cekPengguna));
		if($cekPengguna==1){
			$code_activation = $queryPengguna->row()->code_activation;
			$passwordEnkrip = $this->arr2md5(array($code_activation,$password));
			$passDB = $queryPengguna->row()->password;
			//die(var_dump($passDB==$passwordEnkrip));

			if($passDB==$passwordEnkrip){
				$userid = $queryPengguna->row()->userid;
				$fullname = $queryPengguna->row()->fullname; 
				$username =	$queryPengguna->row()->username; 
				$group_id =	$queryPengguna->row()->group_id; 
				$group_name = $queryPengguna->row()->group_name;
				$status_satker = $queryPengguna->row()->status_pegawai; 
				$ip_addr = $this->input->ip_address();
				$user_agent = $this->input->user_agent();
								
				$this->session->set_userdata('status_login',TRUE);
				$this->session->set_userdata('userid',$userid);
				$this->session->set_userdata('fullname',$fullname); 
				$this->session->set_userdata('username',$username); 
				$this->session->set_userdata('status_satker',$status_satker);
				$this->session->set_userdata('group_id',$group_id); 
				$this->session->set_userdata('group_name',$group_name);
				$data_login = array('userid' => $userid,
								'host_address' => $ip_addr,
								'user_agent' => $user_agent );
				$queryLogin = $this->model->log_online($data_login);
				$this->session->set_userdata('login_id',$queryLogin);

				$kewenangan_dashboard = array('-1','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31','32','33','34','35','36','37','38','39');
				$kewenangan_persuratan = array('-1','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31','32','33','34','35','36','37','38','39','40');
				$kewenangan_disposisi = array('1','2','3','4','5','6','7','8','9','10','12','13','14','15','16','17','18','19','23','24','25','26','27','31');
				$kewenangan_referensi = array('-1','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31','32','33','34','35','36','37','38','39');
				$kewenangan_konfigurasi = array('-1','1','2','3');
				$kewenangan_suratketerangan = array('-1','1','2','3','7','22');
				$kewenangan_input = array('-1','1','2','3','4','16','19','40');
				$kewenangan_hapus = array('-1','1','2','3','4','16','19');
			
				$this->session->set_userdata('kewenangan_dashboard',$kewenangan_dashboard);
				$this->session->set_userdata('kewenangan_persuratan',$kewenangan_persuratan);
				$this->session->set_userdata('kewenangan_referensi',$kewenangan_referensi);
				$this->session->set_userdata('kewenangan_konfigurasi',$kewenangan_konfigurasi);
				$this->session->set_userdata('kewenangan_disposisi',$kewenangan_disposisi);
				$this->session->set_userdata('kewenangan_suratketerangan',$kewenangan_suratketerangan);
				$this->session->set_userdata('kewenangan_inputsurat',$kewenangan_input);
				$this->session->set_userdata('kewenangan_hapus',$kewenangan_hapus);
				
				$queryKonfigurasi1 = $this->model->get_konfigurasi('22');
				$queryKonfigurasi2 = $this->model->get_konfigurasi('4');
				$logo = base_url().'assets/img/'.$queryKonfigurasi1->row()->value;
				$nama_ms = (!empty($queryKonfigurasi2->row()->value) ? $queryKonfigurasi2->row()->value : "MAHKAMAH SYAR"."'IYAH ...");
				$this->session->set_userdata('logo_pengadilan',$logo);
				$this->session->set_userdata('nama_pengadilan',$nama_ms);
				
				$data['groupid'] = $group_id;

				redirect('dashboard'); 
			} else {
				redirect('keluar'); 
			}
		} else {
			redirect('keluar'); 
		}
	}


	public function keluar(){
		$this->session->sess_destroy(); 
		$this->output->set_header("Cache-Control: no-store, no-cache, must-revalidate, no-transform, max-age=0, post-check=0, pre-check=0"); 
		$this->output->set_header("Pragma: no-cache");
		redirect('login'); 
	}
}
