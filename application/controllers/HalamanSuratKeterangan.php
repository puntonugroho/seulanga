<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class HalamanSuratKeterangan extends CI_Controller {
	function __construct() {
        parent::__construct();
        if($this->session->userdata('status_login')==FALSE){ redirect('keluar'); }
        if(!in_array($this->session->userdata('group_id'), $this->session->userdata('kewenangan_suratketerangan'))) { redirect('keluar'); }
        $this->load->model('ModelSuratKeterangan','model');
        $queryCek = $this->model->get_seleksi('sys_user_online','id',$this->session->userdata('login_id'));
		if(($queryCek->row()->host_address!=$this->input->ip_address())&&($queryCek->row()->userid!=$this->session->userdata('userid'))&&($queryCek->row()->user_agent!=$this->input->user_agent())) { redirect('keluar'); }
    }

	public function index(){
		$data['register_id'] = base64_encode($this->encrypt->encode('-1'));
		$this->load->view('header');
		$this->load->view('suratketerangan/index',$data);
		$this->load->view('footer');	
	}

	public function suratketerangan_data(){
		$query = $this->model->get_datatables();
		$data = array();
		$no = $_POST['start'];
		foreach ($query as $row) {
			$no++;
			$UserData = array();
			$UserData[] = "<div align='center'>".$no."</div>";
			$UserData[] = $row->jenis_keterangan;
			$UserData[] = $this->tanggalhelper->convertDayDate($row->tanggal_register);
			$UserData[] = $row->nomor_register;
			$UserData[] = $row->pemohon_nama;
			if(!in_array($this->session->userdata('group_id'), $this->session->userdata('kewenangan_suratketerangan'))){
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
                    	<li><a href="#" onclick="BukaModalPenomoran(\''.base64_encode($this->encrypt->encode($row->register_id)).'\')">Nomor Surat Umum</a></li>
                    	<li><a href="#" onclick="BukaModalUpload(\''.base64_encode($this->encrypt->encode($row->register_id)).'\')">Dokumen Elektronik</a></li>
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



	public function suratketerangan_penetapan(){
		$this->form_validation->set_rules('register_id', '', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
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


	public function suratketerangan_penetapan_pegawai(){
		$this->form_validation->set_rules('penetapan', '', 'trim|required');
		$this->form_validation->set_rules('register_id', '', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$penetapan_id = $this->input->post('penetapan');
		$register_id = $this->input->post('register_id');
		
		$queryPegawai = $this->model->get_seleksi('v_groups_struktural','groupid',$penetapan_id);
		$nama = (!empty($queryPegawai->row()->nama) ? $queryPegawai->row()->nama : "<font color='red'>Data Tidah Tersedia</font>" );
		$pegawai_id = $queryPegawai->row()->pegawai_id;
		$nip = $queryPegawai->row()->nip;

		if($nip==''){
			$tombol_cetak_penetapan = '<button onclick="CetakDokumen(\''.$register_id.'\')" class="btn btn-sm btn-success disabled">Cetak</button>';
		} else {
			$tombol_cetak_penetapan = '<button onclick="CetakDokumen(\''.$register_id.'\')" class="btn btn-sm btn-success">Cetak</button>';
		}

		echo json_encode(array('st'=>1,'nama'=>$nama,'pegawai_id'=>$pegawai_id,'nip'=>$nip,'tombol_cetak_penetapan'=>$tombol_cetak_penetapan));
		return;

	}

	public function suratketerangan_pencarian(){
		$this->form_validation->set_rules('register_id', '', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$register_id = $this->encrypt->decode(base64_decode($this->input->post('register_id')));
		if($register_id!='-1'){ echo json_encode(array('st'=>0,'msg'=>'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));return; }

		$queryTahun = $this->model->get_data('v_tahun_suratketerangan');
		$arrayTahunRegister = array();
		$arrayTahunRegister['']= "Pilih";
		foreach ($queryTahun->result() as $row){ 
			$arrayTahunRegister[$row->tahun_register] = $row->tahun_register; 
		}

		$queryJenisSurat = $this->model->get_seleksi('ref_jenis_surat_keterangan','aktif','1');
		$array_jenis_surat = array();
		$array_jenis_surat['']= "Pilih";
		foreach ($queryJenisSurat->result() as $row){ 
			$array_jenis_surat[$row->id] = $row->nama; 
		}

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
		$jenis_surat_keterangan = form_dropdown('jenis_suratketerangan_cari', $array_jenis_surat,'', 'class="form-control" id="jenis_suratketerangan_cari"');

		echo json_encode(array('st'=>1, 
				'bulan_register'=>$bulan_register,
				'jenis_surat_keterangan'=>$jenis_surat_keterangan,  
				'tahun_register'=>$tahun_register));
		return;
	}


	public function suratketerangan_periode_cetak(){
		$this->form_validation->set_rules('register_id', '', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$register_id = $this->encrypt->decode(base64_decode($this->input->post('register_id')));
		if($register_id!='-1'){ echo json_encode(array('st'=>0,'msg'=>'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));return; }

		$queryTahun = $this->model->get_data('v_tahun_suratketerangan');
		$arrayTahunRegister = array();
		$arrayTahunRegister['']= "Pilih";
		foreach ($queryTahun->result() as $row){ 
			$arrayTahunRegister[$row->tahun_register] = $row->tahun_register; 
		}

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

		$bulan_register = form_dropdown('bulan_register_periode', $arrayBulanRegister,'', 'class="form-control" id="bulan_register_periode"');
		$tahun_register = form_dropdown('tahun_register_periode', $arrayTahunRegister,'', 'class="form-control" id="tahun_register_periode"');

		echo json_encode(array('st'=>1, 
				'bulan_register'=>$bulan_register,
				'tahun_register'=>$tahun_register));
		return;
	}


	public function suratketerangan_register_cetak(){
		$this->form_validation->set_rules('bulan_register_periode', 'Periode Bulan Register', 'trim|required');
		$this->form_validation->set_rules('tahun_register_periode', 'Periode Tahun Register', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Tidak Berhasil:<br/>'.validation_errors()));
			return;
		}

		$bulan_register_periode= $this->input->post('bulan_register_periode');
		$tahun_register_periode= $this->input->post('tahun_register_periode');

		$periode = $tahun_register_periode.'-'.$bulan_register_periode;

		$queryRegister = $this->model->get_register_cetak($periode);
		$dataRegister = "";
		$a = 0;
		foreach ($queryRegister->result() as $row){ $a++;
			$dataRegister .= "<tr>";
			$dataRegister .= "<td><div align='center'>".$a."</div></td>";
			$dataRegister .= "<td>".$row->nomor_register."</td>";
			$dataRegister .= "<td><div align='center'>".$this->tanggalhelper->convertToInputDate($row->tanggal_register)."</div></td>";
			$dataRegister .= "<td>".$row->jenis_keterangan."</td>";
			$dataRegister .= "<td>".$row->pemohon_nama."</td>";
			$dataRegister .= "<td>".$row->pemohon_alasan."</td>";
			$dataRegister .= "</tr>"; 
		}
		$register = $dataRegister;

		echo json_encode(array('st'=>1, 'register'=>$register ));
	}






	public function suratketerangan_register_umum(){
		$this->form_validation->set_rules('register_id', '', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$register_id = $this->encrypt->decode(base64_decode($this->input->post('register_id')));
		if($register_id=='-1'){ echo json_encode(array('st'=>0,'msg'=>'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));return; }

		$queryRegister = $this->model->get_seleksi('register_surat_keterangan','register_id',$register_id);
		$tanggal_register = (!empty($queryRegister->row()->tanggal_agenda_surat_keluar) ? $this->tanggalhelper->convertToInputDate($queryRegister->row()->tanggal_agenda_surat_keluar) : date("d/m/Y") );
		$nomor_register = (!empty($queryRegister->row()->nomor_agenda_surat_keluar) ? $queryRegister->row()->nomor_agenda_surat_keluar : '' );

		if($nomor_register) {
			$tombol_hapus_nomor_umum = '<button onclick="HapusRegisterUmum(\''.base64_encode($this->encrypt->encode($register_id)).'\')" data-dismiss="modal" class="btn btn-sm btn-danger">Hapus</button>';
		} else {
			$tombol_hapus_nomor_umum = "";
		}

		echo json_encode(array('st'=>1,'tanggal_register'=>$tanggal_register,
			'tombol_hapus_nomor_umum'=>$tombol_hapus_nomor_umum,
			'nomor_register'=>$nomor_register, 
			'register_id'=>base64_encode($this->encrypt->encode($register_id)) ));
		return;
	}


	public function suratketerangan_register_umum_simpan(){
		$this->form_validation->set_rules('tanggal_register', '', 'trim|required');
		$this->form_validation->set_rules('register_id', '', 'trim|required');
		$this->form_validation->set_rules('nomor_register', '', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}
		$register_id = $this->encrypt->decode(base64_decode($this->input->post('register_id')));
		$tanggal_register = $this->tanggalhelper->convertToMysqlDate($this->input->post('tanggal_register'));
		$nomor_register = $this->input->post('nomor_register');

		$data = array('tanggal_agenda_surat_keluar' => $tanggal_register,
						'nomor_agenda_surat_keluar' => $nomor_register,
						'diperbaharui_oleh' => $this->session->userdata('username'),
						'diperbaharui_tanggal' => date("Y-m-d h:i:s",time()));

		$queryRegister = $this->model->pembaharuan_data('register_surat_keterangan',$data,'register_id',$register_id);
		if($queryRegister==1){
			echo json_encode(array('st'=>1,'register_id'=>base64_encode($this->encrypt->encode($register_id)),'msg'=>'Data Nomor Register Surat Keluar Berhasil Disimpan' ));
		} else {
			echo json_encode(array('st'=>0,'msg'=>'Data Nomor Register Surat Keluar Gagal Disimpan' ));
		}
		return;
	}

	function suratketerangan_register_umum_hapus(){
		$this->form_validation->set_rules('register_id', 'Data Register Penyitaan', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Tidak Berhasil:<br/>'.validation_errors()));
			return;
		}

		$register_id = $this->encrypt->decode(base64_decode($this->input->post('register_id')));
		
		$data = array('tanggal_agenda_surat_keluar' => NULL,
						'nomor_agenda_surat_keluar' => NULL,
						'diperbaharui_oleh' => $this->session->userdata('username'),
						'diperbaharui_tanggal' => date("Y-m-d h:i:s",time()) );

		$querySimpan = $this->model->pembaharuan_data('register_surat_keterangan',$data,'register_id',$register_id);

		if($querySimpan==1){
			echo json_encode(array('st'=>1,'register_id'=>base64_encode($this->encrypt->encode($register_id)),'msg'=>'Hapus Data Nomor Register Umum Berhasil'));
		} else {
			echo json_encode(array('st'=>0,'msg'=>'Hapus Data Nomor Register Umum Gagal'));
		}
		return;
	}



	public function suratketerangan_generate_nomor(){
		$this->form_validation->set_rules('tanggal_register', '', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$tanggal_register = $this->tanggalhelper->convertToMysqlDate($this->input->post('tanggal_register'));
		$exp = explode("-",$tanggal_register);
		$tahun = $exp[0];
		$bulan = $exp[1];
		$tanggal = $exp[2];

		if(strlen($tahun)<>4){ echo json_encode(array('st'=>0,'msg'=>'Format Tahun Register Tidak Sesuai')); return; }
		if(strlen($bulan)<>2){ echo json_encode(array('st'=>0,'msg'=>'Format Bulan Register Tidak Sesuai')); return; }

		$queryNomorIndex = $this->model->get_seleksi_nomor_index($tahun);
		$nomor_index = (!empty($queryNomorIndex->row()->nomor_index) ? $queryNomorIndex->row()->nomor_index+1 : '1');

		$queryKonfigurasi1 = $this->model->get_seleksi('sys_config','id','25');
		$queryKonfigurasi2 = $this->model->get_seleksi('sys_config','id','26');
		$FormatNomorSK = $queryKonfigurasi1->row()->value;
		$KodeSatker = $queryKonfigurasi2->row()->value;

		$kataganti1 = str_replace("#NMR_SK#",$nomor_index,$FormatNomorSK);
		$kataganti2 = str_replace("#BLN#",$bulan,$kataganti1);
		$kataganti3 = str_replace("#THN#",$tahun,$kataganti2);
		$nomor_register = str_replace("#KD_PN#",$KodeSatker,$kataganti3);

		echo json_encode(array('st'=>1,'nomor_register'=>$nomor_register ));
		return;


	}


	public function suratketerangan_add(){
		$this->form_validation->set_rules('register_id', '', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$register_id = $this->encrypt->decode(base64_decode($this->input->post('register_id')));

		$queryJenisSurat = $this->model->get_seleksi('ref_jenis_surat_keterangan','aktif','1');
		$array_jenis_surat = array();
		$array_jenis_surat['']= "Pilih";
		foreach ($queryJenisSurat->result() as $row){ 
			$array_jenis_surat[$row->id] = '['.$row->kode.'] '.$row->nama; 
		}

		$queryJenisIdentitas = $this->model->get_data('jenis_identitas');
		$array_jenis_identitas = array();
		$array_jenis_identitas['']= "Pilih";
		foreach ($queryJenisIdentitas->result() as $row){ 
			$array_jenis_identitas[$row->id] = $row->nama; 
		}
	

		$array_jenis_kelamin = array('' => 'Pilih', '1' => 'Laki-Laki', '2' => 'Perempuan');

		if($register_id=='-1'){
			$judul = "TAMBAH DATA SURAT KETERANGAN";

			$tanggal_register = date("d/m/Y");
			$tahun_register = date("Y");
			$bulan_register = date("m");
			$queryNomorIndex = $this->model->get_seleksi_nomor_index($tahun_register);
			$nomor_index = (!empty($queryNomorIndex->row()->nomor_index) ? $queryNomorIndex->row()->nomor_index+1 : '1');

			$queryKonfigurasi1 = $this->model->get_seleksi('sys_config','id','25');
			$queryKonfigurasi2 = $this->model->get_seleksi('sys_config','id','26');
			$FormatNomorSK = $queryKonfigurasi1->row()->value;
			$KodeSatker = $queryKonfigurasi2->row()->value;

			$kataganti1 = str_replace("#NMR_SK#",$nomor_index,$FormatNomorSK);
			$kataganti2 = str_replace("#BLN#",$bulan_register,$kataganti1);
			$kataganti3 = str_replace("#THN#",$tahun_register,$kataganti2);
			$nomor_register = str_replace("#KD_PN#",$KodeSatker,$kataganti3);

			$pemohon_nomor_identitas="";
			$pemohon_nama="";
			$pemohon_tempat_lahir="";
			$pemohon_tanggal_lahir="";
			$pemohon_pekerjaan="";
			$pemohon_jabatan="";
			$pemohon_alamat="";
			$pemohon_alasan="";
			$nomor_skck="";
			$pemohon_pendidikan="";

			$jenis_surat_keterangan = form_dropdown('jenis_surat_keterangan', $array_jenis_surat,'', 'class="form-control" required id="jenis_surat_keterangan"');
			$jenis_identitas = form_dropdown('jenis_identitas', $array_jenis_identitas,'', 'class="form-control" required id="jenis_identitas" style="width:50%;"');
			$jenis_kelamin = form_dropdown('jenis_kelamin', $array_jenis_kelamin,'', 'class="form-control" required id="jenis_kelamin" style="width:30%;"');
		} else {
			$judul = "EDIT DATA SURAT KETERANGAN";


			$queryRegister = $this->model->get_seleksi('register_surat_keterangan','register_id',$register_id);
			$jenis_keterangan_id = $queryRegister->row()->jenis_keterangan_id;
			$tanggal_permohonan = $this->tanggalhelper->convertToInputDate($queryRegister->row()->tanggal_permohonan);
			$tanggal_register = $this->tanggalhelper->convertToInputDate($queryRegister->row()->tanggal_register);
			$nomor_register = $queryRegister->row()->nomor_register;
			$pemohon_identitas_id = $queryRegister->row()->pemohon_identitas_id;
			$pemohon_nomor_identitas = $queryRegister->row()->pemohon_nomor_identitas;
			$pemohon_nama = $queryRegister->row()->pemohon_nama;
			$pemohon_kelamin = $queryRegister->row()->pemohon_kelamin;
			$pemohon_tempat_lahir = $queryRegister->row()->pemohon_tempat_lahir;
			$pemohon_tanggal_lahir = $this->tanggalhelper->convertToInputDate($queryRegister->row()->pemohon_tanggal_lahir);
			$pemohon_pekerjaan = $queryRegister->row()->pemohon_pekerjaan;
			$pemohon_jabatan = $queryRegister->row()->pemohon_jabatan;
			$pemohon_alamat = $queryRegister->row()->pemohon_alamat;
			$pemohon_alasan = $queryRegister->row()->pemohon_alasan;
			$nomor_skck = $queryRegister->row()->nomor_skck;
			$pemohon_pendidikan = $queryRegister->row()->pemohon_pendidikan;
			$nomor_agenda_surat_keluar = $queryRegister->row()->nomor_agenda_surat_keluar;
			$tahun_register = $queryRegister->row()->tahun_register;
			$nomor_index = $queryRegister->row()->nomor_index;

			$jenis_surat_keterangan = form_dropdown('jenis_surat_keterangan', $array_jenis_surat,$jenis_keterangan_id, 'class="form-control" required id="jenis_surat_keterangan"');
			$jenis_identitas = form_dropdown('jenis_identitas', $array_jenis_identitas,$pemohon_identitas_id, 'class="form-control" required id="jenis_identitas" style="width:50%;"');
			$jenis_kelamin = form_dropdown('jenis_kelamin', $array_jenis_kelamin,$pemohon_kelamin,'class="form-control" required id="jenis_kelamin" style="width:30%;"');
		}

		echo json_encode(array('st'=>1,
					'register_id'=>base64_encode($this->encrypt->encode($register_id)),
					'tanggal_register'=>$tanggal_register,
					'nomor_register'=>$nomor_register,
					'pemohon_nomor_identitas'=>$pemohon_nomor_identitas,
					'pemohon_nama'=>$pemohon_nama,
					'pemohon_tempat_lahir'=>$pemohon_tempat_lahir,
					'pemohon_tanggal_lahir'=>$pemohon_tanggal_lahir,
					'pemohon_pekerjaan'=>$pemohon_pekerjaan,
					'pemohon_jabatan'=>$pemohon_jabatan,
					'pemohon_alamat'=>$pemohon_alamat,
					'pemohon_alasan'=>$pemohon_alasan,
					'nomor_skck'=>$nomor_skck,
					'pemohon_pendidikan'=>$pemohon_pendidikan,
					'judul'=>$judul,
					'nomor_index'=>$nomor_index,
					'tahun_register'=>$tahun_register,
					'jenis_identitas'=>$jenis_identitas,
					'jenis_kelamin'=>$jenis_kelamin,
					'jenis_surat_keterangan'=>$jenis_surat_keterangan));
		return;
	}


	public function suratketerangan_data_perkara(){
		$this->form_validation->set_rules('pemohon_nama', 'Nama Pemohon', 'trim|required');
		$this->form_validation->set_rules('jenis_surat_keterangan', 'Jenis Surat Keterangan', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$pemohon_nama = $this->input->post('pemohon_nama');
		$jenis_suratketerangan_id = $this->input->post('jenis_surat_keterangan');

		$queryJenis = $this->model->get_seleksi('ref_jenis_surat_keterangan','id',$jenis_suratketerangan_id);
		$jenis_register_id = $queryJenis->row()->register_id;

		$queryPihak = $this->model->get_seleksi_pihak($pemohon_nama,$jenis_register_id);
		$dataPihak = "";
		foreach ($queryPihak->result() as $row){ 
			$dataPihak .= "<tr>";
			$dataPihak .= "<td><b>".$row->nama."</b><br/>".$row->nomor_perkara."</td>";
			$dataPihak .= "<td>".$row->alamat."</td>";
			$dataPihak .= "</tr>";
		}

		$data_pihak = $dataPihak;
		echo json_encode(array('st'=>1,'pihak'=>$dataPihak));
		return;
	}


	public function suratketerangan_detil(){
		$this->form_validation->set_rules('register_id', '', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Anda asd Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$register_id = $this->encrypt->decode(base64_decode($this->input->post('register_id')));

		$queryRegister = $this->model->get_seleksi('register_surat_keterangan','register_id',$register_id);
		$jenis_keterangan = $queryRegister->row()->jenis_keterangan;
		$tanggal_permohonan = $this->tanggalhelper->convertDayDate($queryRegister->row()->tanggal_permohonan);
		$tanggal_register = $this->tanggalhelper->convertDayDate($queryRegister->row()->tanggal_register);
		$nomor_register = $queryRegister->row()->nomor_register;
		$pemohon_identitas = $queryRegister->row()->pemohon_identitas;
		$pemohon_nomor_identitas = $queryRegister->row()->pemohon_nomor_identitas;
		$pemohon_nama = $queryRegister->row()->pemohon_nama;
		$pemohon_kelamin = ($queryRegister->row()->pemohon_kelamin=='1' ? 'Laki-Laki': 'Perempuan');
		$pemohon_tempat_lahir = $queryRegister->row()->pemohon_tempat_lahir;
		$pemohon_tanggal_lahir = $this->tanggalhelper->convertToInputDate($queryRegister->row()->pemohon_tanggal_lahir);
		$pemohon_pekerjaan = $queryRegister->row()->pemohon_pekerjaan;
		$pemohon_jabatan = $queryRegister->row()->pemohon_jabatan;
		$pemohon_alamat = $queryRegister->row()->pemohon_alamat;
		$pemohon_alasan = $queryRegister->row()->pemohon_alasan;
		$nomor_skck = $queryRegister->row()->nomor_skck;
		$pemohon_pendidikan = $queryRegister->row()->pemohon_pendidikan;
		$nomor_agenda_surat_keluar = $queryRegister->row()->nomor_agenda_surat_keluar;
		$dokumen_suratketerangan = $queryRegister->row()->dokumen_suratketerangan;

		if(!empty($dokumen_suratketerangan)){
			$TampilDokumenElektronik = '<object id="pdf" height="1024px" width="100%" type="application/pdf" data="'.base_url().'dokumensuratketerangan/'.$dokumen_suratketerangan.'"><span align="center">Dokumen Elektronik Tidak Tersedia</span></object>';
		} else {
			$TampilDokumenElektronik = '<object id="pdf" width="100%" type="application/pdf" data=""><span align="center">Dokumen Elektronik Tidak Tersedia</span></object>';
		}

		$judul = "DETIL SURAT KETERANGAN";

		$TombolEdit = '';
		$TombolUpload = '';
		$TombolUmum = '';
		if(!in_array($this->session->userdata('group_id'), $this->session->userdata('kewenangan_suratketerangan'))){
			$TombolHapus = '';
		} else {
			$TombolHapus = '<button onclick="HapusSuratKeterangan(\''.base64_encode($this->encrypt->encode($register_id)).'\')" data-dismiss="modal" class="btn btn-sm btn-danger">Hapus</button>';
			
		}

		echo json_encode(array('st'=>1,
					'register_id'=>base64_encode($this->encrypt->encode($register_id)),
					'jenis_keterangan'=>$jenis_keterangan,
					'tanggal_permohonan'=>$tanggal_permohonan,
					'tanggal_register'=>$tanggal_register,
					'nomor_register'=>$nomor_register,
					'nomor_agenda_surat_keluar'=>$nomor_agenda_surat_keluar,
					'pemohon_identitas'=>$pemohon_identitas,
					'pemohon_nomor_identitas'=>$pemohon_nomor_identitas,
					'pemohon_nama'=>$pemohon_nama,
					'pemohon_kelamin'=>$pemohon_kelamin,
					'pemohon_tempat_lahir'=>$pemohon_tempat_lahir,
					'pemohon_tanggal_lahir'=>$pemohon_tanggal_lahir,
					'pemohon_pekerjaan'=>$pemohon_pekerjaan,
					'pemohon_jabatan'=>$pemohon_jabatan,
					'pemohon_alamat'=>$pemohon_alamat,
					'pemohon_alasan'=>$pemohon_alasan,
					'nomor_skck'=>$nomor_skck,
					'judul'=>$judul,
					'TombolHapus'=>$TombolHapus,
					'dokumen_suratketerangan'=>$TampilDokumenElektronik,
					'tombol_edit_suratketerangan'=>$TombolEdit,
					'tombol_unggah_suratketerangan'=>$TombolUpload,
					'tombol_umum_suratketerangan'=>$TombolUmum,
					'pemohon_pendidikan'=>$pemohon_pendidikan));
		return;

	}


	public function suratketerangan_simpan(){
		$this->form_validation->set_rules('register_id', 'Data Register', 'trim|required');
		$this->form_validation->set_rules('jenis_kelamin', 'Jenis Kelamin', 'trim|required');
		$this->form_validation->set_rules('pemohon_tempat_lahir', 'Tempat Lahir', 'trim|required');
		$this->form_validation->set_rules('pemohon_tanggal_lahir', 'Tanggal Lahir', 'trim|required');
		$this->form_validation->set_rules('pemohon_alamat', 'Alamat Pemohon', 'trim|required');
		$this->form_validation->set_rules('pemohon_pekerjaan', 'Pekerjaan', 'trim|required');
		$this->form_validation->set_rules('pemohon_jabatan', 'Jabatan', 'trim');
		$this->form_validation->set_rules('pemohon_alasan', 'Alasan Permohonan', 'trim|required');
		$this->form_validation->set_rules('pemohon_pendidikan', 'Pendidikan Pemohon', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Tidak Berhasil:<br/>'.validation_errors()));
			return;
		}

		$register_id = $this->encrypt->decode(base64_decode($this->input->post('register_id')));
		
		$pemohon_nama = $this->input->post('pemohon_nama');
		$jenis_kelamin = $this->input->post('jenis_kelamin');
		$pemohon_tempat_lahir = $this->input->post('pemohon_tempat_lahir');
		$pemohon_tanggal_lahir = $this->tanggalhelper->convertToMysqlDate($this->input->post('pemohon_tanggal_lahir'));
		$pemohon_alamat = $this->input->post('pemohon_alamat');
		$pemohon_pekerjaan = $this->input->post('pemohon_pekerjaan');
		$pemohon_jabatan = $this->input->post('pemohon_jabatan');
		$pemohon_alasan = $this->input->post('pemohon_alasan');
		$pemohon_pendidikan = $this->input->post('pemohon_pendidikan');
	
		
		if($register_id=='-1'){
			$this->form_validation->set_rules('tanggal_register', 'Tanggal Register', 'trim|required');
			$this->form_validation->set_rules('nomor_index', 'Data Nomor Index', 'trim|required');
			$this->form_validation->set_rules('nomor_register', 'Nomor Register', 'trim|required');
			$this->form_validation->set_rules('tanggal_permohonan', 'Tanggal Permohonan', 'trim|required');
			$this->form_validation->set_rules('jenis_surat_keterangan', 'Jenis Surat Keterangan', 'trim|required');
			$this->form_validation->set_rules('jenis_identitas', 'Jenis Idenitas', 'trim|required');
			$this->form_validation->set_rules('nomor_identitas', 'Nomor Identitas', 'trim|required');
			$this->form_validation->set_rules('pemohon_nama', 'Nama Pemohon', 'trim|required');
			$this->form_validation->set_rules('nomor_skck', 'Nomor SKCK', 'trim|required');
			if ($this->form_validation->run() == FALSE){
				echo json_encode(array('st'=>0,'msg'=>'Tidak Berhasil:<br/>'.validation_errors()));
				return;
			}

			$tanggal_register = $this->tanggalhelper->convertToMysqlDate($this->input->post('tanggal_register'));
			$tanggal_permohonan = $this->tanggalhelper->convertToMysqlDate($this->input->post('tanggal_permohonan'));
			$nomor_register = $this->input->post('nomor_register');
			$jenis_surat_keterangan_id = $this->input->post('jenis_surat_keterangan');
			$jenis_identitas_id = $this->input->post('jenis_identitas');
			$nomor_identitas = $this->input->post('nomor_identitas');
			$nomor_skck = $this->input->post('nomor_skck');
			$nomor_index = $this->input->post('nomor_index');

			$tahun_register = date("Y", strtotime($tanggal_register));
			$queryJenis = $this->model->get_seleksi('ref_jenis_surat_keterangan','id',$jenis_surat_keterangan_id);
			$jenis_surat_keterangan = $queryJenis->row()->nama;

			$queryJenisIdentitas = $this->model->get_seleksi('jenis_identitas','id',$jenis_identitas_id);
			$jenis_identitas = $queryJenisIdentitas->row()->nama;

			$data = array('jenis_keterangan_id' => $jenis_surat_keterangan_id,
						'jenis_keterangan' => $jenis_surat_keterangan,
						'tanggal_permohonan' => $tanggal_permohonan,
						'tahun_register' => $tahun_register,
						'tanggal_register' => $tanggal_register,
						'nomor_index' => $nomor_index,
						'nomor_register' => $nomor_register,
						'pemohon_identitas_id' => $jenis_identitas_id,
						'pemohon_identitas' => $jenis_identitas,
						'pemohon_nomor_identitas' => $nomor_identitas,
						'nomor_skck' => $nomor_skck,
						'pemohon_nama' => $pemohon_nama,
						'pemohon_kelamin' => $jenis_kelamin,
						'pemohon_tanggal_lahir' => $pemohon_tanggal_lahir,
						'pemohon_tempat_lahir' => $pemohon_tempat_lahir,
						'pemohon_pekerjaan' => $pemohon_pekerjaan,
						'pemohon_pendidikan' => $pemohon_pendidikan,
						'pemohon_jabatan' => $pemohon_jabatan,
						'pemohon_alamat' => $pemohon_alamat,
						'pemohon_alasan' => $pemohon_alasan,
						'diinput_oleh' => $this->session->userdata('username'),
						'diinput_tanggal' => date("Y-m-d h:i:s",time()));
			$querySimpan = $this->model->simpan_data('register_surat_keterangan',$data);
			if($querySimpan==1){
				echo json_encode(array('st'=>1,'register_id'=>'','msg'=>'Simpan Data Surat Keterangan Berhasil'));
			} else {
				echo json_encode(array('st'=>1,'msg'=>'Simpan Data Surat Keterangan Gagal'));
			}

		} else {

			$data = array('pemohon_kelamin' => $jenis_kelamin,
						'pemohon_tanggal_lahir' => $pemohon_tanggal_lahir,
						'pemohon_tempat_lahir' => $pemohon_tempat_lahir,
						'pemohon_pekerjaan' => $pemohon_pekerjaan,
						'pemohon_pendidikan' => $pemohon_pendidikan,
						'pemohon_jabatan' => $pemohon_jabatan,
						'pemohon_alamat' => $pemohon_alamat,
						'pemohon_alasan' => $pemohon_alasan,
						'diperbaharui_oleh' => $this->session->userdata('username'),
						'diperbaharui_tanggal' => date("Y-m-d h:i:s",time()));
			$querySimpan = $this->model->pembaharuan_data('register_surat_keterangan',$data,'register_id',$register_id);

			if($querySimpan==1){
				echo json_encode(array('st'=>1,'register_id'=>base64_encode($this->encrypt->encode($register_id)),'msg'=>'Pembaharuan Data Surat Keterangan Berhasil'));
			} else {
				echo json_encode(array('st'=>1,'msg'=>'Pembaharuan Data Surat Keterangan Gagal'));
			}
		}
		return;
	}


	public function suratketerangan_dokumen_simpan(){
		$this->form_validation->set_rules('register_id', 'Data Register', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Tidak Berhasil:<br/>'.validation_errors()));
			return;
		}

		$register_id = $this->encrypt->decode(base64_decode($this->input->post('register_id')));

		$upload_data = "";
		if(!empty($_FILES['dokumen']['name'])){
			$config = array(
				'upload_path' => './dokumensuratketerangan/',
				'allowed_types' => "pdf",
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

		$data = array('dokumen_suratketerangan' => $upload_data['file_name'] );
		$querySimpan = $this->model->pembaharuan_data('register_surat_keterangan',$data,'register_id',$register_id);
		if($querySimpan==1){
			redirect('suratketerangan');
		} else {
			redirect('suratketerangan');
		}
	}


	public function suratketerangan_cetak(){
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
        
        $queryRegister = $this->model->get_seleksi('register_surat_keterangan','register_id',$register_id);
		$data['tanggal_register'] = $this->tanggalhelper->convertDate($queryRegister->row()->tanggal_register);
		$data['tanggal_permohonan'] = $queryRegister->row()->tanggal_permohonan;
		$data['pemohon_nama'] = $queryRegister->row()->pemohon_nama;
		if($queryRegister->row()->pemohon_kelamin=='1'){
			$data['pemohon_kelamin'] = "Laki-Laki";
		} else {
			$data['pemohon_kelamin'] = "Perempuan";
		}
		$data['pemohon_tempat_lahir'] = $this->tanggalhelper->ucname($queryRegister->row()->pemohon_tempat_lahir);
		$data['pemohon_tanggal_lahir'] = $this->tanggalhelper->convertDate($queryRegister->row()->pemohon_tanggal_lahir);
		$data['pemohon_pekerjaan'] = $this->tanggalhelper->ucname($queryRegister->row()->pemohon_pekerjaan);
		$data['pemohon_jabatan'] = $this->tanggalhelper->ucname($queryRegister->row()->pemohon_jabatan);
		$data['pemohon_alamat'] = $this->tanggalhelper->ucname($queryRegister->row()->pemohon_alamat);
		$data['pemohon_alasan'] = $this->tanggalhelper->ucname($queryRegister->row()->pemohon_alasan);
		$data['pemohon_pendidikan'] = $queryRegister->row()->pemohon_pendidikan;
		$data['jenis_keterangan_id'] = $queryRegister->row()->jenis_keterangan_id;

		if($queryRegister->row()->nomor_agenda_surat_keluar!=''){
			$data['nomor_register'] = $queryRegister->row()->nomor_agenda_surat_keluar;
		} else {
			$data['nomor_register'] = $queryRegister->row()->nomor_register;
		}


		$queryDokumen = $this->model->get_seleksi('ref_jenis_surat_keterangan','id',$data['jenis_keterangan_id']);
		if(!empty($queryDokumen->row()->dokumen)){
			$data['nama_dokumen'] = $queryDokumen->row()->dokumen;

			$queryKonfigurasi1 = $this->model->get_seleksi('sys_config','id','4');
			$queryKonfigurasi2 = $this->model->get_seleksi('sys_config','id','5');
			$queryKonfigurasi3 = $this->model->get_seleksi('sys_config','id','22');
			$queryKonfigurasi4 = $this->model->get_seleksi('sys_config','id','27');
			$data['nama_pengadilan_header'] = $queryKonfigurasi1->row()->value;
			$data['nama_pengadilan'] = $this->tanggalhelper->ucname($queryKonfigurasi1->row()->value);
			$data['alamat_pengadilan'] = $queryKonfigurasi2->row()->value;
			$data['logo_pengadilan'] = $queryKonfigurasi3->row()->value;
			$data['nama_kota'] = $this->tanggalhelper->ucname($this->tanggalhelper->namaKota($queryKonfigurasi1->row()->value));

			$this->load->view('generatetemplate/cetaksuratketerangan',$data);

		} else {
			redirect('suratketerangan');
		}
		
	}



	public function suratketerangan_hapus(){
		$this->form_validation->set_rules('register_id', 'Data Register', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Tidak Berhasil:<br/>'.validation_errors()));
			return;
		}

		$register_id = $this->encrypt->decode(base64_decode($this->input->post('register_id')));

		$queryRegister = $this->model->get_seleksi('register_surat_keterangan','register_id',$register_id);
		$nomor_register = $queryRegister->row()->nomor_register;

		if(empty($nomor_register)){
			echo json_encode(array('st'=>0,'msg'=>'Register Surat Keterangan Tidak Terdaftar'));
			return;
		}

		$queryHapus = $this->model->hapus_data('register_surat_keterangan','register_id',$register_id);
		if($queryHapus=='1'){
			echo json_encode(array('st'=>1,'msg'=>'Hapus Data Surat Keterangan Nomor: '.$nomor_register.' Berhasil Dilakukan'));
		} else {
			echo json_encode(array('st'=>0,'msg'=>'Hapus Data Surat Keterangan Nomor: '.$nomor_register.' Gagal Dilakukan'));
		}
		return;
	}

}
