<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class HalamanPegawai extends CI_Controller {

	function __construct() {
        parent::__construct();
        if($this->session->userdata('status_login')==FALSE){ redirect('keluar'); }
        if(!in_array($this->session->userdata('group_id'), $this->session->userdata('kewenangan_referensi'))) { redirect('keluar'); }
        $this->load->model('ModelPegawai','model');
        $queryCek = $this->model->get_seleksi('sys_user_online','id',$this->session->userdata('login_id'));
		if(($queryCek->row()->host_address!=$this->input->ip_address())&&($queryCek->row()->userid!=$this->session->userdata('userid'))&&($queryCek->row()->user_agent!=$this->input->user_agent())) { redirect('keluar'); }
    }

	public function index(){
		$data['id'] = base64_encode($this->encrypt->encode('-1'));
		$this->load->view('header');
		$this->load->view('pegawai/index',$data);
		$this->load->view('pegawai/footer');	
	}


	public function pegawai_data(){
		$query = $this->model->get_datatables();
		$data = array();
		$no = $_POST['start'];
		foreach ($query as $row) {
			$no++;
			$UserData = array();
			$UserData[] = "<div>".$no."</div>";
			$UserData[] = $row->nip;
			$UserData[] = $row->nama_gelar;
			$UserData[] = $row->golongan."/".$row->pangkat;
			$UserData[] = $row->jabatan_nama;
			$UserData[] = "<div>".($row->aktif=='Y' ? 'Ya' : 'Tidak')."</div>";
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


	public function pegawai_pangkat(){
		$this->form_validation->set_rules('golongan_id', 'Golongan Pegawai', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}
		$golongan_id = $this->input->post('golongan_id');
		$queryGolongan= $this->model->get_seleksi_golongan($golongan_id);
		$pangkat = $queryGolongan->row()->pangkat;
		echo json_encode(array('st'=>1,'pangkat'=>$pangkat));
		return;
	}



	public function pegawai_add(){
		$this->form_validation->set_rules('id', 'IDPegawai', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$id = $this->encrypt->decode(base64_decode($this->input->post('id')));
		
		$queryGroup= $this->model->get_kewenangan();
		$group = array();
		$group['']= "Pilih";
		foreach ($queryGroup->result() as $row){ 
			$group[$row->group_id] = $row->group_name; 
		}

		$queryGolongan = $this->model->get_golongan();
		$golongan = array();
		$golongan['']= "Pilih";
		foreach ($queryGolongan->result() as $row){ 
			$golongan[$row->id] = $row->golongan; 
		}

	    $blok = array(''=>"Pilih",'Y'=>'Ya','T'=>'Tidak');

	    $nip = "";
		$nama_gelar = "";
		$golongan_id = "";
		$pangkat = "";
		$alamat = "";
		$aktif_id = "";
		$jabatan_id = "";
		$hapus = "";

		if ($id=='-1'){
			$judul = "TAMBAH PEGAWAI";
			$golongan = form_dropdown('golongan', $golongan, '', 'class="form-control" required id="golongan" onChange="CariPangkat()"');
		  	$jabatan = form_dropdown('group', $group, '', 'class="form-control" required id="group"');
	    	$aktif= form_dropdown('aktif', $blok, '', 'class="form-control" required id="aktif"');

		} else {
			$judul = "EDIT PEGAWAI";
			$queryPegawai = $this->model->get_seleksi_pegawai($id);
			$nip = $queryPegawai->row()->nip;
			$nama_gelar = $queryPegawai->row()->nama_gelar;
			$golongan_id = $queryPegawai->row()->golongan_id;
			$pangkat = $queryPegawai->row()->pangkat;
			$alamat = $queryPegawai->row()->alamat;
			$aktif_id = $queryPegawai->row()->aktif;
			$jabatan_id = $queryPegawai->row()->jabatan_id;

			$golongan = form_dropdown('golongan', $golongan,$golongan_id, 'class="form-control" required id="golongan" onChange="CariPangkat()"');
			$jabatan= form_dropdown('group', $group, $jabatan_id, 'class="form-control" required id="group"');
	        		$aktif= form_dropdown('aktif', $blok, $aktif_id, 'class="form-control" required id="aktif"');
	        		$hapus = '<button onclick="HapusModal(\''.base64_encode($this->encrypt->encode($id)).'\')" data-dismiss="modal" class="btn btn-sm btn-danger">Hapus</button>';
		}
		echo json_encode(array('st'=>1,
					'id'=>base64_encode($this->encrypt->encode($id)),
					'nip'=>$nip, 
					'nama_gelar'=>$nama_gelar, 
					'golongan'=>$golongan,
					'pangkat'=>$pangkat,
					'alamat'=>$alamat,
					'judul'=>$judul,
					'jabatan'=>$jabatan,
					'hapus'=>$hapus,
					'aktif'=>$aktif));
		return;
	}


	public function pegawai_hapus(){
		$this->form_validation->set_rules('id', 'IDPegawai', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$id = $this->encrypt->decode(base64_decode($this->input->post('id')));

		$queryPengguna = $this->model->get_seleksi2('v_users','pegawai_id',$id,'block','0');
		$cekPengguna = $queryPengguna->num_rows();
		if($cekPengguna==0){
			$queryHapusPengguna = $this->model->hapus_data('sys_users','pegawai_id',$id);
			$queryHapusPegawai = $this->model->hapus_pegawai($id);
			if($queryHapusPegawai==TRUE){
				echo json_encode(array('st'=>1,'msg'=>'Data Berhasil Dihapus'));
			} else {
				echo json_encode(array('st'=>0,'msg'=>'Data Gagal Dihapus'));
			}
		} else {
			echo json_encode(array('st'=>0,'msg'=>'Status Pengguna Aktif, Tidak Bisa Dilakukan Penghapusan'));
		}
	}


	public function pegawai_simpan(){
		$this->form_validation->set_rules('id', 'ID Pegawai', 'trim|required');
		$this->form_validation->set_rules('nip', 'NIP', 'trim');
		$this->form_validation->set_rules('nama_gelar', 'Nama Gelar Pegawai', 'trim|required|min_length[3]|max_length[100]');
		$this->form_validation->set_rules('golongan', 'Golongan Pegawai', 'trim|required');
		$this->form_validation->set_rules('pangkat', 'Pangkat Pegawai', 'trim|required');
		$this->form_validation->set_rules('jabatan', 'Jabatan Pegawai', 'trim|required');
		$this->form_validation->set_rules('alamat', 'Alamat Pegawai', 'trim');
		$this->form_validation->set_rules('aktif', 'Status Pegawai', 'trim|required|exact_length[1]|in_list[Y,T]');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Tidak Berhasil:<br/>'.validation_errors()));
			return;
		}

		$id = $this->encrypt->decode(base64_decode($this->input->post('id')));
		$nip= $this->input->post('nip');
		$nama_gelar= $this->input->post('nama_gelar');
		$golongan_id= $this->input->post('golongan');
		$pangkat= $this->input->post('pangkat');
		$jabatan_id = $this->input->post('jabatan');
		$alamat = $this->input->post('alamat');
		$aktif = $this->input->post('aktif');

		$queryGolongan = $this->model->get_seleksi_golongan($golongan_id);
		$golongan = $queryGolongan->row()->golongan;

		$queryJabatan = $this->model->get_seleksi_jabatan($jabatan_id);
		$jabatan = $queryJabatan->row()->name;

		if($id=='-1'){
			$array_jabatan_struktural = array(2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39); 
			if(in_array($jabatan_id,$array_jabatan_struktural)){
				$queryRegister = $this->model->get_seleksi2('pegawai','jabatan_id',$jabatan_id,'aktif','Y');
				$cekPengguna = $queryRegister->num_rows();
			}

			if($cekPengguna==0){
				$data_pegawai = array(
					'nip' => $nip,
					'nama_gelar' => $nama_gelar,
					'golongan_id' => $golongan_id,
					'golongan' => $golongan,
					'pangkat' => $pangkat,
					'alamat' => $alamat,
					'jabatan_id' => $jabatan_id,
					'jabatan_nama' => $jabatan,
					'aktif' => $aktif,
					'diinput_oleh' => $this->session->userdata('username'),
					'diinput_tanggal' => date("Y-m-d h:i:s",time())
				);

				$querySimpan = $this->model->pegawai_add($data_pegawai);
				if($querySimpan==1){
					echo json_encode(array('st'=>1,'msg'=>'Data Berhasil Disimpan'));
					return;
				} else {
					echo json_encode(array('st'=>0,'msg'=>'Data Gagal Disimpan'));
					return;
				}
			} else {
				echo json_encode(array('st'=>0,'register_id'=>base64_encode($this->encrypt->encode($id)),'msg'=>'Data Gagal Disimpan, Pegawai dengan Jabatan yang sama masih Aktif'));
				return;
			}	
		} else {
			$queryPengguna = $this->model->get_seleksi('v_users','pegawai_id',$id);
			$cekPengguna = $queryPengguna->num_rows();
			if($cekPengguna!=0){
				$userIDPengguna = $queryPengguna->row()->userid;
				$data_group = array( 'groupid' => $jabatan_id );
				$data_pengguna = array( 'fullname' => $nama_gelar );
				$querySimpanGroup = $this->model->pembaharuan_data('sys_user_group',$data_group,'userid',$userIDPengguna);
				$querySimpanPengguna = $this->model->pembaharuan_data('sys_users',$data_pengguna,'userid',$userIDPengguna);
			}

			// $array_jabatan_struktural = array(2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39); 
			// if(in_array($jabatan_id,$array_jabatan_struktural)){
			// 	$queryRegister = $this->model->get_seleksi2('pegawai','jabatan_id',$jabatan_id,'aktif','Y');
			// 	$cekPengguna = $queryRegister->num_rows();
			// 	if($cekPengguna!=0){
			// 		echo json_encode(array('st'=>0,'register_id'=>base64_encode($this->encrypt->encode($id)),'msg'=>'Data Gagal Disimpan, Pegawai dengan Jabatan yang sama masih Aktif'));
			// 		return;
			// 	}
			// }
			
			$data_pegawai = array(
				'nip' => $nip,
				'nama_gelar' => $nama_gelar,
				'golongan_id' => $golongan_id,
				'golongan' => $golongan,
				'pangkat' => $pangkat,
				'alamat' => $alamat,
				'jabatan_id' => $jabatan_id,
				'jabatan_nama' => $jabatan,
				'aktif' => $aktif,
				'diperbaharui_oleh' => $this->session->userdata('username'),
				'diperbaharui_tanggal' => date("Y-m-d h:i:s",time())
			);
			$querySimpan = $this->model->pembaharuan_data('pegawai',$data_pegawai,'id',$id);
			
			if($querySimpan==1){
				echo json_encode(array('st'=>1,'msg'=>'Data Berhasil Disimpan'));
			} else {
				echo json_encode(array('st'=>0,'msg'=>'Data Gagal Disimpan'));
			}
			return;

		}
		

	}


}
