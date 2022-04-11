<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class HalamanPenyitaan extends CI_Controller {
	function __construct() {
        parent::__construct();
        if($this->session->userdata('status_login')==FALSE){ redirect('keluar'); }
        if(!in_array($this->session->userdata('group_id'), $this->session->userdata('kewenangan_pidana'))) { redirect('keluar'); }
        $this->load->model('ModelPenyitaan','model');
        $queryCek = $this->model->get_seleksi('sys_user_online','id',$this->session->userdata('login_id'));
		if(($queryCek->row()->host_address!=$this->input->ip_address())&&($queryCek->row()->userid!=$this->session->userdata('userid'))&&($queryCek->row()->user_agent!=$this->input->user_agent())) { redirect('keluar'); }
    }

	public function index(){
		$data['register_id'] = base64_encode($this->encrypt->encode('-1'));
		$this->load->view('header');
		$this->load->view('penyitaan/index',$data);
		$this->load->view('footer');	
	}

	public function penyitaan_data(){
		$query = $this->model->get_datatables();
		$data = array();
		$no = $_POST['start'];
		foreach ($query as $row) {
			$no++;
			$UserData = array();
			$UserData[] = "<div align='center'>".$no."</div>";
			$UserData[] = $this->tanggalhelper->convertDayDate($row->tanggal_register);
			$UserData[] = $row->jenis_penyitaan;
			$UserData[] = $row->nomor_register;
			$UserData[] = $row->kepolisian;
			if(!in_array($this->session->userdata('group_id'), $this->session->userdata('kewenangan_pidana'))){
				$UserData[] = '<div align="center">
					<div class="input-group-btn">
	                	<ul class="dropdown-menu pull-right">
	                    	<li><a href="#" onclick="BukaModalDetil(\''.base64_encode($this->encrypt->encode($row->register_id)).'\')">Detil</a></li>
	                    </ul>
	                    <button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown">
	                    <span class="caret"></span>
	                    </button>
	             	</div>
				</div>';
			} else {
				$UserData[] = '<div align="center">
					<div class="input-group-btn">
	                	<ul class="dropdown-menu pull-right">
	                    	<li><a href="#" onclick="BukaModalDetil(\''.base64_encode($this->encrypt->encode($row->register_id)).'\')">Detil</a></li>
	                    	<li><a href="#" onclick="BukaModal(\''.base64_encode($this->encrypt->encode($row->register_id)).'\')">Edit Register</a></li>
	                    	<li><a href="#" onclick="BukaModalUpload(\''.base64_encode($this->encrypt->encode($row->register_id)).'\')">Dokumen Elektronik</a></li>
	                    	<li><a href="#" onclick="BukaModalPenomoran(\''.base64_encode($this->encrypt->encode($row->register_id)).'\')">Nomor Register Umum</a></li>
	                    	<li><a href="#" onclick="BukaModalCetak(\''.base64_encode($this->encrypt->encode($row->register_id)).'\')">Cetak</a></li>
	                    </ul>
	                    <button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown">
	                    <span class="caret"></span>
	                    </button>
	             	</div>
				</div>';
			}
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


	public function penyitaan_dokumen_upload(){
		$this->form_validation->set_rules('register_id', '', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$register_id = $this->encrypt->decode(base64_decode($this->input->post('register_id')));

		$queryRegister = $this->model->get_seleksi('register_penyitaan','register_id',$register_id);
		$cekRegister = $queryRegister->num_rows();
		if($cekRegister==0){
			echo json_encode(array('st'=>0,'msg'=>'Penyitaan Tidak Terdaftar pada Register'));
		} else {
			$nomor_register = $queryRegister->row()->nomor_register;
			$dokumen = $queryRegister->row()->dokumen;
			if(!empty($dokumen)){
				$statusDokumen = "<a href='".base_url()."dokumenpenyitaan/".$dokumensuratketerangan."'><b><font color='blue'>UNDUH</font></b></a>";
			} else {
				$statusDokumen = "<b><font color='red'>TIDAK TERSEDIA</font></b>";
			}
			echo json_encode(array('st'=>1,
						'nomor_register'=>$nomor_register,
						'statusDokumen'=>$statusDokumen,
						'register_id'=>base64_encode($this->encrypt->encode($register_id))));
		}
		return;
	}


	public function penyitaan_pencarian(){
		$this->form_validation->set_rules('register_id', '', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$register_id = $this->encrypt->decode(base64_decode($this->input->post('register_id')));
		if($register_id!='-1'){ echo json_encode(array('st'=>0,'msg'=>'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));return; }

		$queryTahun = $this->model->get_data('v_tahun_penyitaan');
		$arrayTahunRegister = array();
		$arrayTahunRegister['']= "Pilih";
		foreach ($queryTahun->result() as $row){ 
			$arrayTahunRegister[$row->tahun_register] = $row->tahun_register; 
		}

		$array_jenis_penyitaan = array('' => 'Pilih', 
							'1' => 'Penetapan Ijin Penyitaan', 
							'2' => 'Penetapan Persetujuan Penyitaan',
							'3' => 'Penetapan Ijin Penyitaan Khusus Pasal 43',
							'4' => 'Penetapan  Penolakan Ijin Penyitaan');

		$arrayBulanRegister = array('' => 'Pilih',
						'01' => 'Januari',
						'02' => 'Februari',
						'03' => 'Maret',
						'04' => 'April',
						'05' => 'Mei',
						'06' => 'Juni',
						'07' => 'Juli',
						'08' => 'Agustus',
						'09' => 'September',
						'10' => 'Oktober',
						'11' => 'November',
						'12' => 'Desember');

		$bulan_register = form_dropdown('bulan_register_cari', $arrayBulanRegister,'', 'class="form-control" id="bulan_register_cari"');
		$tahun_register = form_dropdown('tahun_register_cari', $arrayTahunRegister,'', 'class="form-control" id="tahun_register_cari"');
		$jenis_penyitaan = form_dropdown('jenis_penyitaan_cari', $array_jenis_penyitaan,'', 'class="form-control" id="jenis_penyitaan_cari"');

		echo json_encode(array('st'=>1, 
				'bulan_register'=>$bulan_register,
				'jenis_penyitaan'=>$jenis_penyitaan,  
				'tahun_register'=>$tahun_register));
		return;
	}


	public function penyitaan_nomor_register(){
		$this->form_validation->set_rules('tanggal_register', '', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$tanggal_register= $this->tanggalhelper->convertToMysqlDate($this->input->post('tanggal_register'));
		$tahun_register = date("Y", strtotime($tanggal_register));

		$queryNomorIndex = $this->model->get_seleksi_nomor_index($tahun_register);
		$nomor_index = (!empty($queryNomorIndex->row()->nomor_index) ? $queryNomorIndex->row()->nomor_index+1 : '1');

		$queryKonfig1 = $this->model->get_seleksi('sys_config','id','28');
		$queryKonfig2 = $this->model->get_seleksi('sys_config','id','26');
		$format_nomor_register = $queryKonfig1->row()->value;
		$kode_satker = $queryKonfig2->row()->value;

		$kataganti1 = str_replace("#NMR_SK#",$nomor_index,$format_nomor_register);
		$kataganti2 = str_replace("#THN#",$tahun_register,$kataganti1);
		$kataganti3 = str_replace("#KD_PN#",$kode_satker,$kataganti2);

		$nomor_register = $kataganti3;

		$tmp = explode("/", $kataganti3);
		$kode_nomor_manual = $tmp[1]."/".$tmp[2]."/".$tmp[3];
		$nomor_index_manual = $nomor_index;

		echo json_encode(array('st'=>1,
					'nomor_register'=>$nomor_register,
					'kode_nomor_manual'=>$kode_nomor_manual,
					'nomor_index_manual'=>$nomor_index_manual));
		return;
	}


	public function penyitaan_add(){
		$this->form_validation->set_rules('register_id', '', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$register_id = $this->encrypt->decode(base64_decode($this->input->post('register_id')));

		$array_jenis_kelamin = array('' => 'Pilih', '1' => 'Laki-Laki', '2' => 'Perempuan');
		$array_jenis_penyitaan = array('' => 'Pilih', 
							'1' => 'Penetapan Ijin Penyitaan', 
							'2' => 'Penetapan Persetujuan Penyitaan',
							'3' => 'Penetapan Ijin Penyitaan Khusus Pasal 43',
							'4' => 'Penetapan  Penolakan Ijin Penyitaan');

		$array_generate_nomor = array('1' => 'Ya', '2' => 'Tidak');

		$queryAgana = $this->model->get_data('agama');
		$array_agama = array();
		$array_agama['']= "Pilih";
		foreach ($queryAgana->result() as $row){ 
			$array_agama[$row->id] = $row->nama; 
		}

		if($register_id=='-1'){
			$judul = "TAMBAH DATA PENYITAAN";

			$tanggal_register = date("d/m/Y");
			$tahun_register = date("Y");
			$queryNomorIndex = $this->model->get_seleksi_nomor_index($tahun_register);
			$nomor_index = (!empty($queryNomorIndex->row()->nomor_index) ? $queryNomorIndex->row()->nomor_index+1 : '1');
			$queryKonfig1 = $this->model->get_seleksi('sys_config','id','28');
			$queryKonfig2 = $this->model->get_seleksi('sys_config','id','26');
			$format_nomor_register = $queryKonfig1->row()->value;
			$kode_satker = $queryKonfig2->row()->value;

			$kataganti1 = str_replace("#NMR_SK#",$nomor_index,$format_nomor_register);
			$kataganti2 = str_replace("#THN#",$tahun_register,$kataganti1);
			$kataganti3 = str_replace("#KD_PN#",$kode_satker,$kataganti2);

			$tmp = explode("/", $kataganti3);
			$kode_nomor_manual = $tmp[1]."/".$tmp[2]."/".$tmp[3];
			$nomor_index_manual = $nomor_index;

			$nomor_register = $kataganti3;

			$kepolisian = "";
			$nomor_suratpermohonan_penyidik = "";
			$tanggal_suratpermohonan_penyidik = "";
			$nomor_suratperintahpenyitaan_penyidik = "";
			$tanggal_suratperintahpenyitaan_penyidik = "";
			$tanggal_laporan_penyidik = "";
			$penyidik = "";
			$nomor_laporan_penyidik = "";
			$tanggal_ba_penyitaan = "";
			$nomor_ba_penyitaan = "";
			$nama = "";
			$tempat_lahir = "";
			$tanggal_lahir = "";
			$kebangsaan = "";
			$tempat_tinggal = "";
			$pekerjaan = "";
			$penyitaan_terhadap = "";
			$penyitaan = "";
			$jenis_penyitaan_id = "";


			$jenis_kelamin = form_dropdown('jenis_kelamin', $array_jenis_kelamin,'', 'class="form-control" required id="jenis_kelamin"');
			$jenis_penyitaan = form_dropdown('jenis_penyitaan', $array_jenis_penyitaan,'', 'class="form-control" required id="jenis_penyitaan" onChange="SeleksiJenisPenyitaan()"');
			$agama = form_dropdown('agama', $array_agama,'', 'class="form-control" required id="agama"');
			$generate_nomor = form_dropdown('generate_nomor', $array_generate_nomor,'', 'class="form-control" required onChange="GantiGenerateNomor()" id="generate_nomor"');

		} else {
			$judul = "EDIT DATA PENYITAAN";

			$queryRegister = $this->model->get_seleksi('register_penyitaan','register_id',$register_id);
			$kepolisian = $queryRegister->row()->kepolisian;
			$nomor_index = $queryRegister->row()->nomor_index;
			$nomor_register = $queryRegister->row()->nomor_register;
			$tanggal_register = $this->tanggalhelper->convertToInputDate($queryRegister->row()->tanggal_register);
			$jenis_penyitaan_id = $queryRegister->row()->jenis_penyitaan_id;
			$jenis_penyitaan = $queryRegister->row()->jenis_penyitaan;
			$nomor_suratpermohonan_penyidik = $queryRegister->row()->nomor_suratpermohonan_penyidik;
			$tanggal_suratpermohonan_penyidik = $this->tanggalhelper->convertToInputDate($queryRegister->row()->tanggal_suratpermohonan_penyidik);
			$nomor_suratperintahpenyitaan_penyidik = $queryRegister->row()->nomor_suratperintahpenyitaan_penyidik;
			$tanggal_suratperintahpenyitaan_penyidik = $this->tanggalhelper->convertToInputDate($queryRegister->row()->tanggal_suratperintahpenyitaan_penyidik);
			$tanggal_laporan_penyidik = $this->tanggalhelper->convertToInputDate($queryRegister->row()->tanggal_laporan_penyidik);
			$penyidik = $queryRegister->row()->penyidik;
			$nomor_laporan_penyidik = $queryRegister->row()->nomor_laporan_penyidik;
			$tanggal_ba_penyitaan = $this->tanggalhelper->convertToInputDate($queryRegister->row()->tanggal_ba_penyitaan);
			$nomor_ba_penyitaan = $queryRegister->row()->nomor_ba_penyitaan;
			$nama = $queryRegister->row()->nama;
			$tempat_lahir = $queryRegister->row()->tempat_lahir;
			$tanggal_lahir = $this->tanggalhelper->convertToInputDate($queryRegister->row()->tanggal_lahir);
			$jenis_kelamin_id = $queryRegister->row()->jenis_kelamin;
			$kebangsaan = $queryRegister->row()->kebangsaan;
			$tempat_tinggal = $queryRegister->row()->tempat_tinggal;
			$agama_id = $queryRegister->row()->agama;
			$pekerjaan = $queryRegister->row()->pekerjaan;
			$penyitaan_terhadap = $queryRegister->row()->penyitaan_terhadap;
			$penyitaan = $queryRegister->row()->penyitaan;
			$kode_nomor_manual = "";
			$nomor_index_manual = "";
			$generate_nomor_id = $queryRegister->row()->generate_nomor;

			$jenis_kelamin = form_dropdown('jenis_kelamin', $array_jenis_kelamin,$jenis_kelamin_id, 'class="form-control" required id="jenis_kelamin"');
			$jenis_penyitaan = form_dropdown('jenis_penyitaan', $array_jenis_penyitaan,$jenis_penyitaan_id, 'class="form-control" required id="jenis_penyitaan" onChange="SeleksiJenisPenyitaan()"');
			$agama = form_dropdown('agama', $array_agama,$agama_id, 'class="form-control" required id="agama"');
			$generate_nomor = form_dropdown('generate_nomor', $array_generate_nomor,$generate_nomor_id, 'class="form-control" required onChange="GantiGenerateNomor()" id="generate_nomor"');
		}

		echo json_encode(array('st'=>1,
					'register_id'=>base64_encode($this->encrypt->encode($register_id)),
					'judul'=>$judul,
					'jenis_penyitaan_id'=>$jenis_penyitaan_id,
					'kode_nomor_manual'=>$kode_nomor_manual,
					'nomor_index_manual'=>$nomor_index_manual,
					'nomor_index'=>$nomor_index,
					'nomor_register'=>$nomor_register,
					'tanggal_register'=>$tanggal_register,
					'jenis_kelamin'=>$jenis_kelamin,
					'jenis_penyitaan'=>$jenis_penyitaan,
					'generate_nomor'=>$generate_nomor,
					'kepolisian'=>$kepolisian,
					'nomor_suratpermohonan_penyidik'=>$nomor_suratpermohonan_penyidik,
					'tanggal_suratpermohonan_penyidik'=>$tanggal_suratpermohonan_penyidik,
					'nomor_suratperintahpenyitaan_penyidik'=>$nomor_suratperintahpenyitaan_penyidik,
					'tanggal_suratperintahpenyitaan_penyidik'=>$tanggal_suratperintahpenyitaan_penyidik,
					'tanggal_laporan_penyidik'=>$tanggal_laporan_penyidik,
					'penyidik'=>$penyidik,
					'nomor_laporan_penyidik'=>$nomor_laporan_penyidik,
					'tanggal_ba_penyitaan'=>$tanggal_ba_penyitaan,
					'nomor_ba_penyitaan'=>$nomor_ba_penyitaan,
					'nama'=>$nama,
					'tempat_lahir'=>$tempat_lahir,
					'tanggal_lahir'=>$tanggal_lahir,
					'kebangsaan'=>$kebangsaan,
					'tempat_tinggal'=>$tempat_tinggal,
					'pekerjaan'=>$pekerjaan,
					'penyitaan_terhadap'=>$penyitaan_terhadap,
					'penyitaan'=>$penyitaan,
					'agama'=>$agama));
		return;
	}



	function penyitaan_detil(){
		$this->form_validation->set_rules('register_id', 'Data Register', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Tidak Berhasil:<br/>'.validation_errors()));
			return;
		}

		$register_id= $this->encrypt->decode(base64_decode($this->input->post('register_id')));

		$queryRegister = $this->model->get_seleksi('register_penyitaan','register_id',$register_id);
		$kepolisian = $queryRegister->row()->kepolisian;
		$nomor_register = $queryRegister->row()->nomor_register;
		$tanggal_register = $this->tanggalhelper->convertDayDate($queryRegister->row()->tanggal_register);
		$jenis_penyitaan_id = $queryRegister->row()->jenis_penyitaan_id;
		$jenis_penyitaan = $queryRegister->row()->jenis_penyitaan;
		$nomor_suratpermohonan_penyidik = $queryRegister->row()->nomor_suratpermohonan_penyidik;
		$tanggal_suratpermohonan_penyidik = $this->tanggalhelper->convertDayDate($queryRegister->row()->tanggal_suratpermohonan_penyidik);
		$nomor_suratperintahpenyitaan_penyidik = $queryRegister->row()->nomor_suratperintahpenyitaan_penyidik;
		$tanggal_suratperintahpenyitaan_penyidik = $this->tanggalhelper->convertDayDate($queryRegister->row()->tanggal_suratperintahpenyitaan_penyidik);
		$tanggal_laporan_penyidik = $this->tanggalhelper->convertDayDate($queryRegister->row()->tanggal_laporan_penyidik);
		$penyidik = $queryRegister->row()->penyidik;
		$nomor_laporan_penyidik = $queryRegister->row()->nomor_laporan_penyidik;
		$tanggal_ba_penyitaan = $this->tanggalhelper->convertDayDate($queryRegister->row()->tanggal_ba_penyitaan);
		$nomor_ba_penyitaan = $queryRegister->row()->nomor_ba_penyitaan;
		$nama = $queryRegister->row()->nama;
		$tempat_lahir = $queryRegister->row()->tempat_lahir;
		$tanggal_lahir = $this->tanggalhelper->convertDayDate($queryRegister->row()->tanggal_lahir);
		$jenis_kelamin = (($queryRegister->row()->jenis_kelamin=='1') ? 'Laki-Laki' : 'Perempuan' );
		$kebangsaan = $queryRegister->row()->kebangsaan;
		$tempat_tinggal = $queryRegister->row()->tempat_tinggal;
		$agama_id = $queryRegister->row()->agama;
		$pekerjaan = $queryRegister->row()->pekerjaan;
		$penyitaan_terhadap = $queryRegister->row()->penyitaan_terhadap;
		$penyitaan = $queryRegister->row()->penyitaan;
		$dokumen = $queryRegister->row()->dokumen;
		$tanggal_register_umum = $queryRegister->row()->tanggal_register_umum;
		$nomor_register_umum = $queryRegister->row()->nomor_register_umum;



		$queryAgama = $this->model->get_seleksi('agama','id',$agama_id);
		$agama = $queryAgama->row()->nama;

		

		if(!in_array($this->session->userdata('group_id'), $this->session->userdata('kewenangan_pidana'))){
			$TombolUploadPenyitaan = "";
			$TombolPengiriman = '';
			$TombolHapus = '';
			$TombolEditPenyitaan = '';
		} else {
			$TombolUploadPenyitaan = '';
			$TombolPengiriman = '';
			$TombolHapus = '<button onclick="HapusPenyitaan(\''.base64_encode($this->encrypt->encode($register_id)).'\')" data-dismiss="modal" class="btn btn-sm btn-danger">Hapus</button>';
			$TombolEditPenyitaan = '';
		}

		if(!empty($dokumen)){
			$TampilDokumenElektronik = '<object id="pdf" height="1024px" width="100%" type="application/pdf" data="'.base_url().'dokumenpenyitaan/'.$dokumen.'"></object>';
		} else {
			$TampilDokumenElektronik = '<object id="pdf" width="100%" type="application/pdf" data=""><span align="center">Dokumen Elektronik Tidak Tersedia</span></object>';
		}

		$judul = "DETIL REGISTER PENYITAAN";


		echo json_encode(array('st'=>1,
					'register_id'=>base64_encode($this->encrypt->encode($register_id)),
					'judul'=>$judul,
					'tanggal_register_umum'=>$tanggal_register_umum,
					'nomor_register_umum'=>$nomor_register_umum,
					'TombolEditPenyitaan'=>$TombolEditPenyitaan,
					'TombolPengiriman'=>$TombolPengiriman,
					'TombolUploadPenyitaan'=>$TombolUploadPenyitaan,
					'TombolHapus'=>$TombolHapus,
					'TampilDokumenElektronik'=>$TampilDokumenElektronik,
					'kepolisian'=>$kepolisian,
					'nomor_register'=>$nomor_register,
					'tanggal_register'=>$tanggal_register,
					'jenis_penyitaan_id'=>$jenis_penyitaan_id,
					'jenis_penyitaan'=>$jenis_penyitaan,
					'nomor_suratpermohonan_penyidik'=>$nomor_suratpermohonan_penyidik,
					'tanggal_suratpermohonan_penyidik'=>$tanggal_suratpermohonan_penyidik,
					'nomor_suratperintahpenyitaan_penyidik'=>$nomor_suratperintahpenyitaan_penyidik,
					'tanggal_suratperintahpenyitaan_penyidik'=>$tanggal_suratperintahpenyitaan_penyidik,
					'tanggal_laporan_penyidik'=>$tanggal_laporan_penyidik,
					'penyidik'=>$penyidik,
					'nomor_laporan_penyidik'=>$nomor_laporan_penyidik,
					'tanggal_ba_penyitaan'=>$tanggal_ba_penyitaan,
					'nomor_ba_penyitaan'=>$nomor_ba_penyitaan,
					'nama'=>$nama,
					'tempat_lahir'=>$tempat_lahir,
					'tanggal_lahir'=>$tanggal_lahir,
					'jenis_kelamin'=>$jenis_kelamin,
					'kebangsaan'=>$kebangsaan,
					'tempat_tinggal'=>$tempat_tinggal,
					'agama'=>$agama,
					'pekerjaan'=>$pekerjaan,
					'penyitaan_terhadap'=>$penyitaan_terhadap,
					'penyitaan'=>$penyitaan));
		return;

	}


	function penyitaan_register_umum(){
		$this->form_validation->set_rules('register_id', 'Data Register', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Tidak Berhasil:<br/>'.validation_errors()));
			return;
		}

		$register_id = $this->encrypt->decode(base64_decode($this->input->post('register_id')));
		if($register_id=='-1'){ echo json_encode(array('st'=>0,'msg'=>'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));return; }

		$queryRegister = $this->model->get_seleksi('register_penyitaan','register_id',$register_id);
		$tanggal_register = (!empty($queryRegister->row()->tanggal_register_umum) ? $this->tanggalhelper->convertToInputDate($queryRegister->row()->tanggal_register_umum) : date("d/m/Y") );
		$nomor_register = (!empty($queryRegister->row()->nomor_register_umum) ? $queryRegister->row()->nomor_register_umum : '' );

		if($nomor_register) {
			$tombol_hapus_nomor_umum = '<button onclick="HapusRegisterUmum(\''.base64_encode($this->encrypt->encode($register_id)).'\')" data-dismiss="modal" class="btn btn-sm btn-danger">Hapus</button>';
		} else {
			$tombol_hapus_nomor_umum = "";
		}

		echo json_encode(array('st'=>1,'tombol_hapus_nomor_umum'=>$tombol_hapus_nomor_umum,'tanggal_register'=>$tanggal_register,'nomor_register'=>$nomor_register, 'register_id'=>base64_encode($this->encrypt->encode($register_id)) ));
		return;
	}

	function penyitaan_register_umum_simpan(){
		$this->form_validation->set_rules('register_id', 'Data Register Penyitaan', 'trim|required');
		$this->form_validation->set_rules('tanggal_register_umum', 'Tanggal Register Umum', 'trim|required');
		$this->form_validation->set_rules('nomor_register_umum', 'Nomor Register Umum', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Tidak Berhasil:<br/>'.validation_errors()));
			return;
		}

		$register_id = $this->encrypt->decode(base64_decode($this->input->post('register_id')));
		$tanggal_register_umum= $this->tanggalhelper->convertToMysqlDate($this->input->post('tanggal_register_umum'));
		$nomor_register_umum= $this->input->post('nomor_register_umum');

		$data = array('tanggal_register_umum' => $tanggal_register_umum,
						'nomor_register_umum' => $nomor_register_umum,
						'diperbaharui_oleh' => $this->session->userdata('username'),
						'diperbaharui_tanggal' => date("Y-m-d h:i:s",time()) );

		$querySimpan = $this->model->pembaharuan_data('register_penyitaan',$data,'register_id',$register_id);
		if($querySimpan==1){
			echo json_encode(array('st'=>1,'register_id'=>base64_encode($this->encrypt->encode($register_id)),'msg'=>'Simpan Data Nomor Register Umum Berhasil'));
		} else {
			echo json_encode(array('st'=>0,'msg'=>'Simpan Data Nomor Register Umum Gagal'));
		}
		return;
	}


	function penyitaan_register_umum_hapus(){
		$this->form_validation->set_rules('register_id', 'Data Register Penyitaan', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Tidak Berhasil:<br/>'.validation_errors()));
			return;
		}

		$register_id = $this->encrypt->decode(base64_decode($this->input->post('register_id')));
		
		$data = array('tanggal_register_umum' => NULL,
						'nomor_register_umum' => NULL,
						'diperbaharui_oleh' => $this->session->userdata('username'),
						'diperbaharui_tanggal' => date("Y-m-d h:i:s",time()) );

		$querySimpan = $this->model->pembaharuan_data('register_penyitaan',$data,'register_id',$register_id);

		if($querySimpan==1){
			echo json_encode(array('st'=>1,'register_id'=>base64_encode($this->encrypt->encode($register_id)),'msg'=>'Hapus Data Nomor Register Umum Berhasil'));
		} else {
			echo json_encode(array('st'=>0,'msg'=>'Hapus Data Nomor Register Umum Gagal'));
		}
		return;
	}




	function penyitaan_simpan(){
		$this->form_validation->set_rules('register_id', 'ID Register', 'trim|required');
		$this->form_validation->set_rules('generate_nomor', 'Status Generate Nomor', 'trim|required');
		
		$this->form_validation->set_rules('nomor_index', 'Nomor Indek', 'trim|required');
		$this->form_validation->set_rules('tanggal_register', 'Tanggal Register', 'trim|required');
		$this->form_validation->set_rules('nomor_register', 'Nomor Register', 'trim|required');
		$this->form_validation->set_rules('penyitaan_terhadap', 'Penyitaan Terhadap', 'trim|required');
		$this->form_validation->set_rules('kepolisian', 'Kepolisian', 'trim|required');
		$this->form_validation->set_rules('jenis_penyitaan', 'Jenis Penyitaan', 'trim|required');
		$this->form_validation->set_rules('tanggal_suratpermohonan_penyidik', 'Tanggal Surat Permohonan Penyidik', 'trim|required');
		$this->form_validation->set_rules('nomor_suratpermohonan_penyidik', 'Tanggal Surat Permohonan Penyidik', 'trim|required');
		$this->form_validation->set_rules('tanggal_suratperintahpenyitaan_penyidik', 'Tanggal Surat Perintah Penyitaan', 'trim');
		$this->form_validation->set_rules('nomor_suratperintahpenyitaan_penyidik', 'Nomor Surat Perintah Penyitaan', 'trim');
		
		$this->form_validation->set_rules('penyitaan', 'Penyitaan', 'trim');
		$this->form_validation->set_rules('nama', 'Nama Tersangka', 'trim|required');
		$this->form_validation->set_rules('tempat_lahir', 'Tempat Lahir Tersangka', 'trim|required');
		$this->form_validation->set_rules('tanggal_lahir', 'Tanggal Lahir Tersangka', 'trim|required');
		$this->form_validation->set_rules('jenis_kelamin', 'Jenis Kelamin Tersangka', 'trim|required');
		$this->form_validation->set_rules('kebangsaan', 'Kebangsaan Tersangka', 'trim|required');
		$this->form_validation->set_rules('tempat_tinggal', 'Tempat Tinggal Tersangka', 'trim|required');
		$this->form_validation->set_rules('agama', 'Agama Tersangka', 'trim|required');
		$this->form_validation->set_rules('pekerjaan', 'Pekerjaan Tersangka', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Tidak Berhasil DON:<br/>'.validation_errors()));
			return;
		}

		$register_id= $this->encrypt->decode(base64_decode($this->input->post('register_id')));
		$tanggal_register= $this->tanggalhelper->convertToMysqlDate($this->input->post('tanggal_register'));
		$generate_nomor= $this->input->post('generate_nomor');


		

		$penyitaan_terhadap= $this->input->post('penyitaan_terhadap');
		
		$kepolisian= $this->input->post('kepolisian');
		$jenis_penyitaan_id= $this->input->post('jenis_penyitaan');
		if($jenis_penyitaan_id==1){
			$jenis_penyitaan = 'Permohonan Ijin Penyitaan';
		} else {
			$jenis_penyitaan = 'Permohonan Persetujuan Penyitaan';
		}


		$tanggal_suratpermohonan_penyidik= $this->tanggalhelper->convertToMysqlDate($this->input->post('tanggal_suratpermohonan_penyidik'));
		$nomor_suratpermohonan_penyidik= $this->input->post('nomor_suratpermohonan_penyidik');
		$tanggal_suratperintahpenyitaan_penyidik= $this->tanggalhelper->convertToMysqlDate($this->input->post('tanggal_suratperintahpenyitaan_penyidik'));
		$nomor_suratperintahpenyitaan_penyidik= $this->input->post('nomor_suratperintahpenyitaan_penyidik');
		
		$penyitaan= $this->input->post('penyitaan');
		$nama= $this->input->post('nama');
		$tempat_lahir= $this->input->post('tempat_lahir');
		$tanggal_lahir= $this->tanggalhelper->convertToMysqlDate($this->input->post('tanggal_lahir'));
		$jenis_kelamin= $this->input->post('jenis_kelamin');
		$kebangsaan= $this->input->post('kebangsaan');
		$tempat_tinggal= $this->input->post('tempat_tinggal');
		$agama= $this->input->post('agama');
		$pekerjaan= $this->input->post('pekerjaan');

		$tanggal_laporan_penyidik= NULL;
		$penyidik= NULL;
		$nomor_laporan_penyidik= NULL;
		$tanggal_ba_penyitaan= NULL;
		$nomor_ba_penyitaan= NULL;
		if($jenis_penyitaan_id=='2'){
			$this->form_validation->set_rules('penyidik', 'Penyidik', 'trim|required|required');
			$this->form_validation->set_rules('tanggal_laporan_penyidik', 'Tanggal Laporan Penyidik', 'trim|required');
			$this->form_validation->set_rules('nomor_laporan_penyidik', 'Nomor Laporan Penyidik', 'trim|required');
			$this->form_validation->set_rules('tanggal_ba_penyitaan', 'Tanggal BA Penyitaan', 'trim|required|required');
			$this->form_validation->set_rules('nomor_ba_penyitaan', 'Nomor BA Penyitaan', 'trim|required');
			if ($this->form_validation->run() == FALSE){
				echo json_encode(array('st'=>0,'msg'=>'Tidak Berhasil:<br/>'.validation_errors()));
				return;
			}
			$tanggal_laporan_penyidik= $this->tanggalhelper->convertToMysqlDate($this->input->post('tanggal_laporan_penyidik'));
			$penyidik= $this->input->post('penyidik');
			$nomor_laporan_penyidik= $this->input->post('nomor_laporan_penyidik');
			$tanggal_ba_penyitaan= $this->tanggalhelper->convertToMysqlDate($this->input->post('tanggal_ba_penyitaan'));
			$nomor_ba_penyitaan= $this->input->post('nomor_ba_penyitaan');
		}


		if($register_id=='-1'){
			if($generate_nomor==1){
				$nomor_index = $this->input->post('nomor_index');
				$nomor_register= $this->input->post('nomor_register');
			} else {
				$this->form_validation->set_rules('nomor_index_manual', 'Nomor Index Manual', 'trim|required');
				$this->form_validation->set_rules('kode_nomor_manual', 'Kode Nomor Manual', 'trim|required');	
				if ($this->form_validation->run() == FALSE){
					echo json_encode(array('st'=>0,'msg'=>'Tidak Berhasil:<br/>'.validation_errors()));
					return;
				}
				$nomor_index = $this->input->post('nomor_index_manual');
				$nomor_register= $this->input->post('nomor_index_manual')."/".$this->input->post('kode_nomor_manual');
			}

			$data = array('kepolisian' => $kepolisian,
						'tanggal_register' => $tanggal_register,
						'jenis_penyitaan_id' => $jenis_penyitaan_id,
						'generate_nomor' => $generate_nomor,
						'jenis_penyitaan' => $jenis_penyitaan,
						'penyitaan_terhadap' => $penyitaan_terhadap,
						'nomor_index' => $nomor_index,
						'nomor_register' => $nomor_register,
						'nomor_suratpermohonan_penyidik' => $nomor_suratpermohonan_penyidik,
						'tanggal_suratpermohonan_penyidik' => $tanggal_suratpermohonan_penyidik,
						'nomor_suratperintahpenyitaan_penyidik' => $nomor_suratperintahpenyitaan_penyidik,
						'tanggal_suratperintahpenyitaan_penyidik' => $tanggal_suratperintahpenyitaan_penyidik,
						'tanggal_laporan_penyidik' => $tanggal_laporan_penyidik,
						'penyidik' => $penyidik,
						'nomor_laporan_penyidik' => $nomor_laporan_penyidik,
						'tanggal_ba_penyitaan' => $tanggal_ba_penyitaan,
						'nomor_ba_penyitaan' => $nomor_ba_penyitaan,
						'nama' => $nama,
						'tempat_lahir' => $tempat_lahir,
						'tanggal_lahir' => $tanggal_lahir,
						'jenis_kelamin' => $jenis_kelamin,
						'kebangsaan' => $kebangsaan,
						'tempat_tinggal' => $tempat_tinggal,
						'agama' => $agama,
						'pekerjaan' => $pekerjaan,
						'penyitaan' => $penyitaan,
						'diinput_oleh' => $this->session->userdata('username') ,
						'diinput_tanggal' => date("Y-m-d h:i:s",time())  );

			$querySimpan = $this->model->simpan_data('register_penyitaan',$data);
			if($querySimpan==1){
				echo json_encode(array('st'=>1,'msg'=>'Simpan Data Penyitaan Berhasil'));
			} else {
				echo json_encode(array('st'=>0,'msg'=>'Simpan Data Penyitaan Gagal'));
			}
			return;
		} else {
			$data = array('nama' => $nama,
						'tempat_lahir' => $tempat_lahir,
						'tanggal_lahir' => $tanggal_lahir,
						'jenis_kelamin' => $jenis_kelamin,
						'kebangsaan' => $kebangsaan,
						'tempat_tinggal' => $tempat_tinggal,
						'agama' => $agama,
						'pekerjaan' => $pekerjaan,
						'penyitaan' => $penyitaan,
						'penyitaan_terhadap' => $penyitaan_terhadap,
						'diperbaharui_oleh' => $this->session->userdata('username') ,
						'diperbaharui_tanggal' => date("Y-m-d h:i:s",time()) );

			$querySimpan = $this->model->pembaharuan_data('register_penyitaan',$data,'register_id',$register_id);
			if($querySimpan==1){
				echo json_encode(array('st'=>1,'register_id'=>base64_encode($this->encrypt->encode($register_id)),'msg'=>'Simpan Data Penyitaan Berhasil'));
			} else {
				echo json_encode(array('st'=>0,'msg'=>'Simpan Data Penyitaan Gagal'));
			}
			return;
		}
	}


	public function penyitaan_dokumen_simpan(){
		$this->form_validation->set_rules('register_id', 'Data Register', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Tidak Berhasil:<br/>'.validation_errors()));
			return;
		}

		$register_id = $this->encrypt->decode(base64_decode($this->input->post('register_id')));

		$upload_data = "";
		if(!empty($_FILES['dokumen']['name'])){
			$config = array(
				'upload_path' => './dokumenpenyitaan/',
				'allowed_types' => "pdf",
				'file_ext_tolower' => TRUE,
				'encrypt_name' => TRUE,
				'overwrite' => FALSE,
				'remove_spaces' => TRUE,
				'max_size' => "10485760"
			);

			$this->load->library('upload',$config);
            $this->upload->initialize($config);

            $this->upload->do_upload('dokumen');
            $upload_data = $this->upload->data();     		
		}

		$data = array('dokumen' => $upload_data['file_name'] );
		$querySimpan = $this->model->pembaharuan_data('register_penyitaan',$data,'register_id',$register_id);
		if($querySimpan==1){
			redirect('penyitaan');
		} else {
			redirect('penyitaan');
		}
	}


	public function penyitaan_hapus(){
		$this->form_validation->set_rules('register_id', 'Data Register', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Tidak Berhasil:<br/>'.validation_errors()));
			return;
		}

		$register_id = $this->encrypt->decode(base64_decode($this->input->post('register_id')));
		$queryHapus = $this->model->hapus_data('register_penyitaan','register_id',$register_id);
		if($queryHapus==1){
			echo json_encode(array('st'=>1,'msg'=>'Hapus Data Penyitaan Berhasil'));
		} else {
			echo json_encode(array('st'=>0,'msg'=>'Hapus Data Penyitaan Gagal'));
		}
		return;

	}


	public function penyitaan_penetapan(){
		$this->form_validation->set_rules('register_id', 'Data Register', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Tidak Berhasil:<br/>'.validation_errors()));
			return;
		}

		$register_id = $this->input->post('register_id');
		
		$array_penetapan =  array('' => 'Pilih','2' => 'Ketua Pengadilan','3' => 'Wakil Ketua Pengadilan' );
		$penetapan = form_dropdown('penetapan', $array_penetapan,'', 'class="form-control" id="penetapan" onChange="CariPenetapanPegawai()"');

		$tombol_cetak_penetapan = '<button onclick="CetakDokumen(\''.$register_id.'\')" class="btn btn-sm btn-success">Cetak</button>';

		echo json_encode(array('st'=>1, 
				'register_id'=>$register_id,
				'tombol_cetak_penetapan'=>$tombol_cetak_penetapan,
				'penetapan'=>$penetapan));
		return;
	}


	public function penyitaan_penetapan_pegawai(){
		$this->form_validation->set_rules('penetapan', '', 'trim|required');
		$this->form_validation->set_rules('register_id', '', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$penetapan_id = $this->input->post('penetapan');
		$register_id = $this->input->post('register_id');
		
		$queryPegawai = $this->model->get_seleksi('v_groups_struktural','groupid',$penetapan_id);
		$nama = (!empty($queryPegawai->row()->nama) ? $queryPegawai->row()->nama : "<font color='red'>Data Tidak Tersedia</font>" );
		$pegawai_id = $queryPegawai->row()->pegawai_id;
		$nip = $queryPegawai->row()->nip;

		if($nip==''){
			$tombol_cetak_penetapan = '<button onclick="CetakDokumen(\''.$register_id.'\')" class="btn btn-sm btn-success disabled">Cetak</button>';
		} else {
			$tombol_cetak_penetapan = '<button onclick="CetakDokumen(\''.$register_id.'\')" class="btn btn-sm btn-success">Cetak</button>';
		}

		echo json_encode(array('st'=>1,
					'nama'=>$nama,
					'pegawai_id'=>$pegawai_id,
					'nip'=>$nip,
					'tombol_cetak_penetapan'=>$tombol_cetak_penetapan));
		return;

	}


	public function penyitaan_cetak(){
		$segment = $this->uri->segment_array();
        $register_id=$this->encrypt->decode(base64_decode($this->uri->segment('2'))); 
        $penetapan_id=$this->uri->segment('3'); 
        
        if($penetapan_id==2){
        	$data['penetapan'] = "Ketua";
        } else {
        	$data['penetapan'] = "Wakil Ketua";
        }


        $queryPenetapan = $this->model->get_seleksi('v_groups_struktural','groupid',$penetapan_id);
        $data['panetapan_nama'] = $queryPenetapan->row()->nama;
        $data['panetapan_nip'] = $queryPenetapan->row()->nip;


        $queryRegister = $this->model->get_seleksi('register_penyitaan','register_id',$register_id);
        $data['kepolisian'] = $this->tanggalhelper->ucname($queryRegister->row()->kepolisian);
        $data['jenis_penyitaan_id'] = $queryRegister->row()->jenis_penyitaan_id;
        $data['jenis_penyitaan'] = $queryRegister->row()->jenis_penyitaan;

        $data['nomor_suratpermohonan_penyidik'] = $queryRegister->row()->nomor_suratpermohonan_penyidik;
        $data['tanggal_suratpermohonan_penyidik'] = $this->tanggalhelper->convertDate($queryRegister->row()->tanggal_suratpermohonan_penyidik);
        $data['nomor_suratperintahpenyitaan_penyidik'] = $queryRegister->row()->nomor_suratperintahpenyitaan_penyidik;
        $data['tanggal_suratperintahpenyitaan_penyidik'] = $this->tanggalhelper->convertDate($queryRegister->row()->tanggal_suratperintahpenyitaan_penyidik);
        $data['tanggal_laporan_penyidik'] = $this->tanggalhelper->convertDate($queryRegister->row()->tanggal_laporan_penyidik);
        $data['penyidik'] = $this->tanggalhelper->ucname($queryRegister->row()->penyidik);
        $data['nomor_laporan_penyidik'] = $queryRegister->row()->nomor_laporan_penyidik;
        $data['tanggal_ba_penyitaan'] = $this->tanggalhelper->convertDate($queryRegister->row()->tanggal_ba_penyitaan);
        $data['nomor_ba_penyitaan'] = $queryRegister->row()->nomor_ba_penyitaan;
        $data['penyitaan_terhadap'] = $queryRegister->row()->penyitaan_terhadap;
        $data['penyitaan'] = $queryRegister->row()->penyitaan;

        $data['nama'] = $this->tanggalhelper->ucname($queryRegister->row()->nama);
        $data['tempat_lahir'] = $this->tanggalhelper->ucname($queryRegister->row()->tempat_lahir);
        $data['tanggal_lahir'] = $this->tanggalhelper->convertDate($queryRegister->row()->tanggal_lahir);
        $data['kebangsaan'] = $this->tanggalhelper->ucname($queryRegister->row()->kebangsaan);
        $data['tempat_tinggal'] = $this->tanggalhelper->ucname($queryRegister->row()->tempat_tinggal);
        $data['pekerjaan'] = $this->tanggalhelper->ucname($queryRegister->row()->pekerjaan);

        if($queryRegister->row()->jenis_kelamin=='1'){
			$data['jenis_kelamin'] = "Laki-Laki";
		} else {
			$data['jenis_kelamin'] = "Perempuan";
		}

		$queryAgama = $this->model->get_seleksi('agama','id',$queryRegister->row()->agama);
		$data['agama'] = $queryAgama->row()->nama;

        if($queryRegister->row()->nomor_register_umum!=''){
			$data['nomor_register'] = $queryRegister->row()->nomor_register_umum;
			$data['tanggal_register'] = $this->tanggalhelper->convertDate($queryRegister->row()->tanggal_register_umum);
		} else {
			$data['nomor_register'] = $queryRegister->row()->nomor_register;
			$data['tanggal_register'] = $this->tanggalhelper->convertDate($queryRegister->row()->tanggal_register);
		}

		if($queryRegister->row()->jenis_penyitaan_id=='1'){
			$data['dokumen_template'] = base_url()."dokumentemplate/penetapan_ijin_penyitaan.rtf";
		} else if ($queryRegister->row()->jenis_penyitaan_id=='2'){
			$data['dokumen_template'] = base_url()."dokumentemplate/penetapan_persetujuan_penyitaan.rtf";
		} else if ($queryRegister->row()->jenis_penyitaan_id=='3'){
			$data['dokumen_template'] = base_url()."dokumentemplate/penetapan_ijin_penyitaan_khusus_43.rtf";
		} else if ($queryRegister->row()->jenis_penyitaan_id=='4'){
			$data['dokumen_template'] = base_url()."dokumentemplate/penolakan_ijin_penyitaan.rtf";
		}

		$queryKonfigurasi = $this->model->get_seleksi('sys_config','id','4');
		$data['nama_kota'] = $this->tanggalhelper->ucname($this->tanggalhelper->namaKota($queryKonfigurasi->row()->value));
		$data['nama_pengadilan'] = $this->tanggalhelper->ucname($queryKonfigurasi->row()->value);

		$this->load->view('generatetemplate/cetakpenetapanpenyitaan',$data);

	}
	


}
