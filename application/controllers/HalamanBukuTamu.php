<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class HalamanBukuTamu extends CI_Controller {
	function __construct() {
        parent::__construct();
        if($this->session->userdata('status_login')==FALSE){ redirect('keluar'); }
        if(!in_array($this->session->userdata('group_id'), $this->session->userdata('kewenangan_bukutamu'))) { redirect('keluar'); }
        $this->load->model('ModelBukuTamu','model');
		$queryCek = $this->model->get_seleksi('sys_user_online','id',$this->session->userdata('login_id'));
		if(($queryCek->row()->host_address!=$this->input->ip_address())&&($queryCek->row()->userid!=$this->session->userdata('userid'))&&($queryCek->row()->user_agent!=$this->input->user_agent())) { redirect('keluar'); }
    }

	public function index(){
		$data['id'] = base64_encode($this->encrypt->encode('-1'));
		$this->load->view('header');
		$this->load->view('bukutamu/index',$data);
		$this->load->view('footer');	
	}


	public function bukutamu_data(){
		$query = $this->model->get_datatables();
		$data = array();
		$no = $_POST['start'];
		foreach ($query as $row) {
			$no++;
			$UserData = array();
			$UserData[] = "<div align='center'>".$no."</div>";
			$UserData[] = "<div align='center'>".$this->tanggalhelper->convertDayDate($row->tanggal)."</div>";
			$UserData[] = $row->tujuan_jabatan;
			$UserData[] = $row->nama;
			$UserData[] = $row->alamat;
			$UserData[] = $row->telepon;
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


	public function bukutamu_hapus(){
		$this->form_validation->set_rules('id','Buku Tamu', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$id = $this->encrypt->decode(base64_decode($this->input->post('id')));

		$queryHapus = $this->model->hapus_data('bukutamu','id',$id);

		if($queryHapus==1){
			echo json_encode(array('st'=>1,'msg'=>'Data Berhasil Dihapus'));
		} else {
			echo json_encode(array('st'=>0,'msg'=>'Data Gagal Dihapus'));
		}
		return;

	}


	public function bukutamu_add(){
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

		$status_menghadap = array(''=>"Pilih",'Y'=>'Ya','T'=>'Tidak');

		$tujuan_id = "";
		$tujuan_jabatan = "";
		$tujuan_nama = "";
		$tanggal = "";
		$nama = "";
		$alamat = "";
		$telepon = "";
		$keperluan = "";
		$status = "";
		$hapus = "";
		$pegawai= "";
		$tujuan_jabatan_id = "";
		$menghadap = "";

	  	if ($id=='-1'){
			$judul = "Tambah Buku Tamu";
		  	$jabatan = form_dropdown('group', $group,'', 'class="form-control" required id="group" onChange="CariPegawai()"');	    	
		} else {
			$judul = "Edit Buku Tamu";
			$queryBukuTamu = $this->model->get_seleksi_bukutamu($id);
			$tujuan_nama_id = $queryBukuTamu->row()->tujuan_nama_id;
			$tujuan_nama = $queryBukuTamu->row()->tujuan_nama;
			$tujuan_jabatan_id = $queryBukuTamu->row()->tujuan_jabatan_id;
			$tujuan_jabatan = $queryBukuTamu->row()->tujuan_jabatan;
			$tujuan_nama = $queryBukuTamu->row()->tujuan_nama;
			$tanggal = $queryBukuTamu->row()->tanggal;
			$nama = $queryBukuTamu->row()->nama;
			$alamat = $queryBukuTamu->row()->alamat;
			$telepon = $queryBukuTamu->row()->telepon;
			$keperluan = $queryBukuTamu->row()->keperluan;
			$status = $queryBukuTamu->row()->status;

			$queryPegawai = $this->model->get_seleksi('pegawai','jabatan_id',$tujuan_jabatan_id);
			$pegawai = array();
			$pegawai['']= "Pilih";
			foreach ($queryPegawai->result() as $row){ 
				$pegawai[$row->id] = $row->nama_gelar; 
			}

			$pegawai= form_dropdown('pegawai', $pegawai,$tujuan_nama_id, 'class="form-control" required id="pegawai"');
			$jabatan= form_dropdown('group', $group, $tujuan_jabatan_id, 'class="form-control" required id="group" onChange="CariPegawai()"');
	        $menghadap= form_dropdown('menghadap', $status_menghadap, $status, 'class="form-control" required id="menghadap"');
	        $hapus = '<button onclick="HapusModal(\''.base64_encode($this->encrypt->encode($id)).'\')" data-dismiss="modal" class="btn btn-sm btn-danger">Hapus</button>';
		}
		echo json_encode(array('st'=>1,
					'id'=>base64_encode($this->encrypt->encode($id)),
					'tujuan_id'=>$tujuan_id, 
					'tujuan_jabatan'=>$tujuan_jabatan, 
					'tujuan_nama'=>$tujuan_nama,
					'tanggal'=>$this->tanggalhelper->convertToInputDate($tanggal),
					'nama'=>$nama,
					'alamat'=>$alamat,
					'telepon'=>$telepon,
					'keperluan'=>$keperluan,
					'jabatan'=>$jabatan,
					'tujuan_jabatan_id'=>$tujuan_jabatan_id,
					'menghadap'=>$menghadap,
					'pegawai'=>$pegawai,
					'hapus'=>$hapus,
					'judul'=>$judul));
		return;
	}


	public function bukutamu_pegawai(){
		$this->form_validation->set_rules('jabatan', 'Jabatan Pegawai', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$jabatan_id = $this->input->post('jabatan');
		$queryPegawai = $this->model->get_seleksi('pegawai','jabatan_id',$jabatan_id);
		$pegawai = array();
		$pegawai['']= "Pilih";
		foreach ($queryPegawai->result() as $row){ 
			$pegawai[$row->id] = $row->nama_gelar; 
		}

		$pegawai= form_dropdown('pegawai', $pegawai,'', 'class="form-control" required id="pegawai"');

		echo json_encode(array('st'=>1,'pegawai'=>$pegawai));
		return;
	}



	public function bukutamu_simpan(){
		$this->form_validation->set_rules('id', 'ID Buku Tamu', 'trim|required');
		$this->form_validation->set_rules('tanggal', 'Tanggal Menghadap', 'trim|required');
		$this->form_validation->set_rules('nama', 'Nama Tamu', 'trim|required|min_length[3]|max_length[100]');
		$this->form_validation->set_rules('alamat', 'Alamat Tamu', 'trim|required');
		$this->form_validation->set_rules('telepon', 'Telepon Tamu', 'trim|max_length[20]|integer');
		$this->form_validation->set_rules('alasan', 'Alasan Menghadap', 'trim|required');
		$this->form_validation->set_rules('jabatan', 'Tujuan Menghadap', 'trim|required');
		$this->form_validation->set_rules('pegawai', 'Pegawai', 'trim|required|integer');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Tidak Berhasil:<br/>'.validation_errors()));
			return;
		}

		$id = $this->encrypt->decode(base64_decode($this->input->post('id')));
		$tanggal= $this->tanggalhelper->convertToMysqlDate($this->input->post('tanggal'));
		$nama= $this->input->post('nama');
		$alamat= $this->input->post('alamat');
		$telepon= $this->input->post('telepon');
		$alasan= $this->input->post('alasan');
		$jabatan_id= $this->input->post('jabatan');
		$pegawai_id= $this->input->post('pegawai');

		$queryJabatan = $this->model->get_seleksi('sys_groups','groupid',$jabatan_id);
		$namaJabatan = $queryJabatan->row()->name;

		$queryPegawai = $this->model->get_seleksi('pegawai','id',$pegawai_id);
		$namaPegawai = $queryPegawai->row()->nama_gelar;

		if($id='-1'){
			$data = array('tujuan_nama_id' => $pegawai_id,
						'tujuan_nama' => $namaPegawai,
						'tujuan_jabatan_id' => $jabatan_id,
						'tujuan_jabatan' => $namaJabatan,
						'tanggal' => $tanggal,
						'nama' => $nama,
						'alamat' => $alamat,
						'telepon' => $telepon,
						'keperluan' => $alasan,
						'diinput_oleh' => $this->session->userdata('username'),
						'diinput_tanggal' => date("Y-m-d h:i:s",time()) );

			$querySimpan = $this->model->simpan_data('bukutamu',$data);
			
		} else {
			$data = array('tujuan_nama_id' => $pegawai_id,
						'tujuan_nama' => $namaPegawai,
						'tujuan_jabatan_id' => $jabatan_id,
						'tujuan_jabatan' => $namaJabatan,
						'tanggal' => $tanggal,
						'nama' => $nama,
						'alamat' => $alamat,
						'telepon' => $telepon,
						'keperluan' => $alasan,
						'diperbaharui_oleh' => $this->session->userdata('username'),
						'diperbaharui_tanggal' => date("Y-m-d h:i:s",time()) );

			$querySimpan = $this->model->pembaharuan_data('bukutamu',$data,'id',$id);
		}

		if($querySimpan==1){
			echo json_encode(array('st'=>1,'msg'=>'Data Berhasil Disimpan'));
		} else {
			echo json_encode(array('st'=>0,'msg'=>'Data Gagal Disimpan'));
		}
		return;
	}

}
