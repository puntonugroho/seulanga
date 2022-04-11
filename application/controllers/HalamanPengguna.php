<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class HalamanPengguna extends CI_Controller {
	function __construct() {
        parent::__construct();
        if($this->session->userdata('status_login')==FALSE){ redirect('keluar'); }
        if(!in_array($this->session->userdata('group_id'), $this->session->userdata('kewenangan_konfigurasi'))) { redirect('keluar'); }
        $this->load->model('ModelPengguna','model');
        $queryCek = $this->model->get_seleksi('sys_user_online','id',$this->session->userdata('login_id'));
		if(($queryCek->row()->host_address!=$this->input->ip_address())&&($queryCek->row()->userid!=$this->session->userdata('userid'))&&($queryCek->row()->user_agent!=$this->input->user_agent())) { redirect('keluar'); }
    }

	public function index(){
		$data['userid'] = base64_encode($this->encrypt->encode('-1'));
		$this->load->view('header');
		$this->load->view('pengguna/index',$data);
		$this->load->view('pengguna/footer');	
	}


	public function pengguna_data(){
		$query = $this->model->get_datatables();
		$data = array();
		$no = $_POST['start'];
		foreach ($query as $row) {
			$no++;
			$UserData = array();
			$UserData[] = "<div>".$no."</div>";
			$UserData[] = $row->fullname;
			$UserData[] = $row->username;
			$UserData[] = $row->email;
			$UserData[] = $row->group_name;
			$UserData[] = "<div>".($row->block==1 ? 'Ya' : 'Tidak')."</div>";
			$UserData[] = '<div><button type="button" onclick="BukaModal(\''.base64_encode($this->encrypt->encode($row->userid)).'\')" class="btn btn-success btn-sm m-r-5">Detil</button></div>';

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



	public function pengguna_add(){
		$this->form_validation->set_rules('userid', 'IDPengguna', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$userid = $this->encrypt->decode(base64_decode($this->input->post('userid')));
		
		$queryPegawai = $this->model->get_pegawai();
		$dataPegawai = array();
		$dataPegawai[''] = "Pilih";
		foreach ($queryPegawai->result() as $row){ 
			$dataPegawai[$row->id] = $row->nama_gelar; 
		} 

	    	$blok = array(''=>"Pilih",'0'=>'Tidak','1'=>'Ya');

	    	$fullname = "";
	    	$username = "";
	    	$email = "";
		if ($userid=='-1'){
			$judul = "TAMBAH PENGGUNA";
		  	$status= form_dropdown('blok', $blok, '', 'class="form-control" required id="blok"');
	    	$pegawai= form_dropdown('pegawai', $dataPegawai, '', 'class="form-control" required id="pegawai"');

		} else {
			$judul = "EDIT PENGGUNA";
			$queryPengguna = $this->model->get_data_pengguna_id($userid);
			$pegawai_id = $queryPengguna->row()->pegawai_id;
			$fullname = $queryPengguna->row()->fullname;
			$username = $queryPengguna->row()->username;
			$email = $queryPengguna->row()->email;
			$status = $queryPengguna->row()->block;
			
			$status= form_dropdown('blok', $blok, $status, 'class="form-control" required id="blok"');
	        		$pegawai= form_dropdown('pegawai', $dataPegawai,$pegawai_id, 'class="form-control" required id="pegawai"');
		}
		echo json_encode(array('st'=>1,
					'pegawai'=>$pegawai, 
					'userid'=>$userid,
					'status'=>$status, 
					'fullname'=>$fullname,
					'username'=>$username,
					'email'=>$email,
					'judul'=>$judul));
		return;
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


	public function pengguna_simpan(){
		$this->form_validation->set_rules('userid', 'ID Pengguna', 'trim|required');
		$this->form_validation->set_rules('pegawai', 'Nama Pegawai', 'trim|required');
		$this->form_validation->set_rules('username', 'Username Pengguna', 'trim|required|min_length[3]|max_length[100]');
		$this->form_validation->set_rules('password', 'Password Pengguna', 'trim|required|min_length[3]|max_length[100]');
		$this->form_validation->set_rules('ulang_password', 'Password Pengguna', 'trim|required|min_length[3]|max_length[100]|matches[password]');
		$this->form_validation->set_rules('email', 'Email Pengguna', 'trim|required|min_length[3]|max_length[100]|valid_email');
		$this->form_validation->set_rules('blok', 'Status Pengguna', 'trim|required|exact_length[1]|in_list[0,1]');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Tidak Berhasil:<br/>'.validation_errors()));
			return;
		}

		$pegawai_id= $this->input->post('pegawai');
		$username= $this->input->post('username');
		$password= $this->input->post('password');
		$email= $this->input->post('email');
		$block= $this->input->post('blok');
		$userid = $this->input->post('userid');

		$queryPegawai = $this->model->get_seleksi_pegawai($pegawai_id);
		$namaPegawai = $queryPegawai->row()->nama_gelar;
		$jabatanPegawaiID = $queryPegawai->row()->jabatan_id; 

		$code_activation = md5(uniqid());
		$password = $this->arr2md5(array($code_activation,$password));
		$activation = $this->arr2md5(array($namaPegawai,$username,$email));

		if($userid=='-1'){
			$queryPengguna = $this->model->get_seleksi('v_users','pegawai_id',$pegawai_id);
			$cekPengguna = $queryPengguna->num_rows();
			if($cekPengguna!=0){
				echo json_encode(array('st'=>0,'msg'=>'Data Gagal Disimpan, Pengguna Sudah Terdaftar'));
				return;
			} else {
				$queryUserID= $this->model->get_last_id();
				$userid = $queryUserID->row()->userid;

				$data_pengguna = array(
					'userid' => $userid,
					'pegawai_id' => $pegawai_id,
					'fullname' => $namaPegawai,
					'username' => $username,
					'password' => $password,
					'email' => $email,
					'activation' => $activation,
					'code_activation' => $code_activation,
					'block' => $block,
					'created_by' => $this->session->userdata('username'),
					'created_on' => date("Y-m-d h:i:s",time())
				);

				$data_group = array('userid' => $userid,'groupid' => $jabatanPegawaiID);
				$querySimpan = $this->model->users_add($data_pengguna,$data_group);
				if($querySimpan==1){
					echo json_encode(array('st'=>1,'msg'=>'Data Berhasil Disimpan'));
					return;
				} else {
					echo json_encode(array('st'=>0,'msg'=>'Data Gagal Disimpan'));
					return;
				}
			}
		} else {
			
			$data_pengguna = array(
				'pegawai_id' => $pegawai_id,
				'fullname' => $namaPegawai,
				'username' => $username,
				'password' => $password,
				'email' => $email,
				'activation' => $activation,
				'code_activation' => $code_activation,
				'block' => $block,
				'modified_by' => $this->session->userdata('username'),
				'modified_on' => date("Y-m-d h:i:s",time())
			);

			$data_group = array( 'groupid' => $jabatanPegawaiID );

			$querySimpan = $this->model->users_update($data_pengguna,$data_group,$userid);
			if($querySimpan==1){
				echo json_encode(array('st'=>1,'msg'=>'Data Berhasil Disimpan'));
				return;
			} else {
				echo json_encode(array('st'=>0,'msg'=>'Data Gagal Disimpan'));
				return;
			}
		}
	}
}
