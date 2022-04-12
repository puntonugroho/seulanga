<?php
defined('BASEPATH') or exit('No direct script access allowed');

class HalamanSuratMasuk extends CI_Controller
{
	function __construct()
	{
		parent::__construct();
		if ($this->session->userdata('status_login') == FALSE) {
			redirect('keluar');
		}
		if (!in_array($this->session->userdata('group_id'), $this->session->userdata('kewenangan_dashboard'))) {
			redirect('keluar');
		}
		$this->load->model('ModelSuratMasuk', 'model');
		$this->load->helper('telebot_helper');
		$queryCek = $this->model->get_seleksi('sys_user_online', 'id', $this->session->userdata('login_id'));
		if (($queryCek->row()->host_address != $this->input->ip_address()) && ($queryCek->row()->userid != $this->session->userdata('userid')) && ($queryCek->row()->user_agent != $this->input->user_agent())) {
			redirect('keluar');
		}
	}

	public function index()
	{
		$data['register_id'] = base64_encode($this->encrypt->encode('-1'));
		$this->load->view('header');
		$this->load->view('suratmasuk/index', $data);
		$this->load->view('suratmasuk/footer');
	}


	public function suratmasuk_data()
	{
		$query = $this->model->get_datatables();
		$data = array();
		$no = $_POST['start'];
		foreach ($query as $row) {
			$no++;
			$UserData = array();
			$UserData[] = "<div>" . $no . "</div>";
			$UserData[] = $this->tanggalhelper->convertDayDate($row->tanggal_register);
			$UserData[] = $row->nomor_surat;
			$UserData[] = $row->nomor_agenda;
			$UserData[] = $row->jenis_surat;
			$UserData[] = $row->pengirim;
			$UserData[] = $row->status_pelaksanaan;
			$UserData[] = '<div>
					<div class="input-group-btn">
	                	<ul class="dropdown-menu pull-right" style="padding:12px">
	                    	<li><a href="#" onclick="BukaModalDetil(\'' . base64_encode($this->encrypt->encode($row->register_id)) . '\')">Detil</a></li>
	                    	<li><a href="#" onclick="BukaModal(\'' . base64_encode($this->encrypt->encode($row->register_id)) . '\')">Edit Register</a></li>
	                    	<li><a href="#" onclick="CetakDisposisi(\'' . base64_encode($this->encrypt->encode($row->register_id)) . '\')">Cetak Disposisi</a></li>
	                    </ul>
	                    <button type="button" class="btn btn-warning dropdown-toggle" data-toggle="dropdown">
	                    <span class="caret"></span>
	                    </button>
	             	</div>
				</div>';

			//$UserData[] = '<div align="center"><button type="button" onclick="BukaModalDetil(\''.base64_encode($this->encrypt->encode($row->register_id)).'\')" class="btn btn-success btn-sm m-r-5">Detil</button></div>';
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


	public function suratmasuk_pencarian()
	{
		$this->form_validation->set_rules('register_id', 'ID Register', 'trim|required');
		if ($this->form_validation->run() == FALSE) {
			echo json_encode(array('st' => 0, 'msg' => 'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		if ($this->encrypt->decode(base64_decode($this->input->post('register_id'))) != '-1') {
			echo json_encode(array('st' => 0, 'msg' => 'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$queryRegister = $this->model->get_data('v_suratmasuk');
		$arrayTahunRegister = array();
		$arrayTahunRegister[''] = "Pilih";
		foreach ($queryRegister->result() as $row) {
			$arrayTahunRegister[$row->tahun_register] = $row->tahun_register;
		}

		$queryJabatan = $this->model->get_data('v_groups');
		$arrayJabatan = array();
		$arrayJabatan[''] = "Pilih";
		foreach ($queryJabatan->result() as $row) {
			$arrayJabatan[$row->group_id] = $row->group_name;
		}

		$jabatan = form_dropdown('jabatan_cari', $arrayJabatan, '', 'class="form-control" id="jabatan_cari"');
		$tahun_register = form_dropdown('tahun_register_cari', $arrayTahunRegister, '', 'class="form-control" id="tahun_register_cari"');

		echo json_encode(array(
			'st' => 1,
			'jabatan' => $jabatan,
			'tahun_register' => $tahun_register
		));
		return;
	}

	public function suratmasuk_periode_cetak()
	{
		$this->form_validation->set_rules('register_id', 'ID Register', 'trim|required');
		if ($this->form_validation->run() == FALSE) {
			echo json_encode(array('st' => 0, 'msg' => 'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		if ($this->encrypt->decode(base64_decode($this->input->post('register_id'))) != '-1') {
			echo json_encode(array('st' => 0, 'msg' => 'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$queryRegister = $this->model->get_data('v_suratmasuk');
		$arrayTahunRegister = array();
		$arrayTahunRegister[''] = "Pilih";
		foreach ($queryRegister->result() as $row) {
			$arrayTahunRegister[$row->tahun_register] = $row->tahun_register;
		}

		$arrayBulanRegister = array(
			'' => 'Pilih',
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
			'12' => 'Desember'
		);

		$bulan_register = form_dropdown('bulan_register_periode', $arrayBulanRegister, '', 'class="form-control" id="bulan_register_periode"');
		$tahun_register = form_dropdown('tahun_register_periode', $arrayTahunRegister, '', 'class="form-control" id="tahun_register_periode"');

		echo json_encode(array('st' => 1, 'bulan_register' => $bulan_register, 'tahun_register' => $tahun_register));
		return;
	}


	public function suratmasuk_register_cetak()
	{
		$this->form_validation->set_rules('bulan_register_periode', 'Periode Bulan Register', 'trim|required');
		$this->form_validation->set_rules('tahun_register_periode', 'Periode Tahun Register', 'trim|required');
		if ($this->form_validation->run() == FALSE) {
			echo json_encode(array('st' => 0, 'msg' => 'Tidak Berhasil:<br/>' . validation_errors()));
			return;
		}

		$bulan_register_periode = $this->input->post('bulan_register_periode');
		$tahun_register_periode = $this->input->post('tahun_register_periode');

		$periode = $tahun_register_periode . '-' . $bulan_register_periode;

		$queryRegister = $this->model->get_register_cetak($periode);
		$dataRegister = "";
		$a = 0;
		foreach ($queryRegister->result() as $row) {
			$a++;
			$dataRegister .= "<tr>";
			$dataRegister .= "<td><div align='center'>" . $a . "</div></td>";
			$dataRegister .= "<td><div align='center'>" . $row->nomor_agenda . "</div></td>";
			$dataRegister .= "<td>" . $this->tanggalhelper->convertDayDate($row->tanggal_register) . "</td>";
			$dataRegister .= "<td>" . $this->tanggalhelper->convertDayDate($row->tanggal_surat) . "</td>";
			$dataRegister .= "<td align='center'>" . $row->pengirim . "</td>";
			$dataRegister .= "<td align='center'>" . $row->perihal . "</td>";
			$dataRegister .= "<td>" . $row->status_pelaksanaan . "</td>";
			$dataRegister .= "</tr>";
		}
		$register = $dataRegister;

		echo json_encode(array('st' => 1, 'register' => $register));
	}


	public function suratmasuk_add()
	{
		$this->form_validation->set_rules('register_id', 'ID Register', 'trim|required');
		if ($this->form_validation->run() == FALSE) {
			echo json_encode(array('st' => 0, 'msg' => 'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$register_id = $this->encrypt->decode(base64_decode($this->input->post('register_id')));

		$queryJenis = $this->model->get_data('ref_jenis_surat');
		$JenisSurat = array();
		$JenisSurat[''] = "Pilih";
		foreach ($queryJenis->result() as $row) {
			$JenisSurat[$row->id] = $row->nama;
		}

		$array_generate_nomor = array('1' => 'Ya', '2' => 'Tidak');
		$queryJabatan = $this->model->get_list_jabatan();
		$InitJabatan = array('' => 'Pilih');
		foreach ($queryJabatan->result() as $row) {
			$JabatanQuery[$row->group_id] = $row->group_name;
		}
		$JenisJabatan = array_merge($InitJabatan,$JabatanQuery);
		// $JenisJabatan = array('' => 'Pilih', '2' => 'Ketua Mahkamah', '3' => 'Wakil Ketua Mahkamah', '4' => 'Panitera', '5' => 'Panitera Muda Jinayat', '6' => 'Panitera Muda Hukum ', '7' => 'Panitera Muda Gugatan', '10' => 'Panitera Muda Permohonan', '16' => 'Sekretaris', '17' => 'Kasubbag PTIP', '18' => 'Kasubbag Kepegawaian', '19' => 'Kasubbag Umum dan Keuangan');

		if ($register_id == '-1') {
			$judul = "TAMBAH SURAT MASUK";
			$tanggal_register = date("d/m/Y");

			$tanggal_surat = "";
			$nomor_surat = "";
			$pengirim = "";
			$perihal = "";
			$keterangan = "";
			$tahun_register = date("Y");

			$queryNomorIndex = $this->model->get_seleksi_nomor_index($tahun_register);
			$nomor_index = (!empty($queryNomorIndex->row()->nomor_index) ? $queryNomorIndex->row()->nomor_index + 1 : '1');

			$queryKonfigurasi = $this->model->get_seleksi('sys_config', 'id', '24');
			$format_agenda = $queryKonfigurasi->row()->value;

			$kataganti = str_replace("NMR_AGENDA", $nomor_index, $format_agenda);
			$nomor_agenda = str_replace("TAHUN_AGENDA", $tahun_register, $kataganti);

			$jenis_surat = form_dropdown('jenis_surat', $JenisSurat, '', 'class="form-control" required id="JenisSurat"');
			$jabatan = form_dropdown('jabatan', $JenisJabatan, '', 'class="form-control" required id="jabatan"');
			$generate_nomor = form_dropdown('generate_nomor', $array_generate_nomor, '', 'class="form-control" required onChange="GantiGenerateNomor()" id="generate_nomor"');
		} else {
			$querySurat = $this->model->get_seleksi('v_suratmasuk', 'register_id', $register_id);
			$tanggal_register = $this->tanggalhelper->convertToInputDate($querySurat->row()->tanggal_register);
			$jenis_surat_id = $querySurat->row()->jenis_surat_id;
			$tanggal_surat = $this->tanggalhelper->convertToInputDate($querySurat->row()->tanggal_surat);
			$nomor_surat = $querySurat->row()->nomor_surat;
			$pengirim = $querySurat->row()->pengirim;
			$tujuan_id = $querySurat->row()->tujuan_id;
			$perihal = $querySurat->row()->perihal;
			$keterangan = $querySurat->row()->keterangan;
			$nomor_index = $querySurat->row()->nomor_index;
			$nomor_agenda = $querySurat->row()->nomor_agenda;
			$tahun_register = $querySurat->row()->tahun_register;

			$judul = "EDIT SURAT MASUK";
			$jenis_surat = form_dropdown('jenis_surat', $JenisSurat, $jenis_surat_id, 'class="form-control" required id="JenisSurat"');
			$jabatan = form_dropdown('jabatan', $JenisJabatan, $tujuan_id, 'class="form-control" required id="jabatan"');
			$generate_nomor = form_dropdown('generate_nomor', $array_generate_nomor, '', 'class="form-control" required onChange="GantiGenerateNomor()" id="generate_nomor"');
		}
		echo json_encode(array(
			'st' => 1,
			'register_id' => base64_encode($this->encrypt->encode($register_id)),
			'nomor_index' => $nomor_index,
			'nomor_agenda' => $nomor_agenda,
			'tanggal_register' => $tanggal_register,
			'tanggal_surat' => $tanggal_surat,
			'nomor_surat' => $nomor_surat,
			'pengirim' => $pengirim,
			'perihal' => $perihal,
			'keterangan' => $keterangan,
			'generate_nomor' => $generate_nomor,
			'jabatan' => $jabatan,
			'jenis_surat' => $jenis_surat,
			'tahun_register' => $tahun_register,
			'judul' => $judul
		));
		return;
	}



	public function suratmasuk_nomoragenda()
	{
		$this->form_validation->set_rules('tanggal_register', 'Tanggal Register', 'trim|required');
		if ($this->form_validation->run() == FALSE) {
			echo json_encode(array('st' => 0, 'msg' => 'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$tanggal_register = $this->tanggalhelper->convertToMysqlDate($this->input->post('tanggal_register'));
		$tahun_register = date("Y", strtotime($tanggal_register));

		$queryNomorIndex = $this->model->get_seleksi_nomor_index($tahun_register);
		$nomor_index = (!empty($queryNomorIndex->row()->nomor_index) ? $queryNomorIndex->row()->nomor_index + 1 : '1');

		$queryKonfigurasi = $this->model->get_seleksi('sys_config', 'id', '24');
		$format_agenda = $queryKonfigurasi->row()->value;

		$kataganti = str_replace("NMR_AGENDA", $nomor_index, $format_agenda);
		$nomor_agenda = str_replace("TAHUN_AGENDA", $tahun_register, $kataganti);

		echo json_encode(array(
			'st' => 1,
			'nomor_index' => $nomor_index,
			'tahun_register' => $tahun_register,
			'nomor_agenda' => $nomor_agenda
		));
		return;
	}


	public function suratmasuk_hapus()
	{
		$this->form_validation->set_rules('register_id', 'Data Surat Masuk', 'trim|required');
		if ($this->form_validation->run() == FALSE) {
			echo json_encode(array('st' => 0, 'msg' => 'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$register_id = $this->encrypt->decode(base64_decode($this->input->post('register_id')));

		$queryData = $this->model->get_seleksi('v_suratmasuk', 'register_id', $register_id);
		$tanggal_register = $this->tanggalhelper->convertDayDate($queryData->row()->tanggal_register);
		$nomor_surat = $queryData->row()->nomor_surat;
		$dokumen = $queryData->row()->dokumen_elektronik;

		$queryHapus = $this->model->hapus_data('register_surat', 'register_id', $register_id);
		$queryHapusPelaksanaan = $this->model->hapus_data('register_pelaksanaan', 'register_id', $register_id);

		if (!empty($dokumen)) {
			unlink('./dokumen/' . $dokumen);
		}

		if ($queryHapus == 1) {
			echo json_encode(array('st' => 1, 'msg' => 'Data Surat Masuk Nomor ' . $nomor_surat . ', Tanggal Register ' . $tanggal_register . ' <b>BERHASIL DIHAPUS</b>'));
		} else {
			echo json_encode(array('st' => 0, 'msg' => 'Data Surat Masuk Nomor ' . $nomor_surat . ', Tanggal Register ' . $tanggal_register . ' <b>GAGAL DIHAPUS</b>'));
		}
		return;
	}


	public function suratmasuk_detil()
	{
		$this->form_validation->set_rules('register_id', 'ID Register', 'trim|required');
		if ($this->form_validation->run() == FALSE) {
			echo json_encode(array('st' => 0, 'msg' => 'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$register_id = $this->encrypt->decode(base64_decode($this->input->post('register_id')));

		// die(var_dump($register_id));

		$queryRegister = $this->model->get_seleksi('v_suratmasuk', 'register_id', $register_id);
		$klasifikasi_surat_id = $queryRegister->row()->klasifikasi_surat_id;
		$klasifikasi_surat = $queryRegister->row()->klasifikasi_surat;
		$jenis_surat_id = $queryRegister->row()->jenis_surat_id;
		$jenis_surat = $queryRegister->row()->jenis_surat;
		$tanggal_register = $this->tanggalhelper->convertDayDate($queryRegister->row()->tanggal_register);
		$tanggal_surat = $this->tanggalhelper->convertDayDate($queryRegister->row()->tanggal_surat);
		$nomor_surat = $queryRegister->row()->nomor_surat;
		$nomor_agenda = $queryRegister->row()->nomor_agenda;
		$pengirim = $queryRegister->row()->pengirim;
		$tujuan_id = $queryRegister->row()->tujuan_id;
		$tujuan = $queryRegister->row()->tujuan;
		$perihal = $queryRegister->row()->perihal;
		$dokumen = $queryRegister->row()->dokumen_elektronik;

		if (!empty($dokumen)) {
			// $TampilDokumenElektronik = '<object id="pdf" height="1024px" width="100%" type="application/pdf" data="'.base_url().'dokumen/'.$dokumen.'"></object>';
			$TampilDokumenElektronik = '<iframe src = "' . base_url() . '/ViewerJS/#../dokumen/' . $dokumen . '" width="100%" height="640" allowfullscreen webkitallowfullscreen></iframe>';
		} else {
			$TampilDokumenElektronik = '<object id="pdf" height="1024px" width="100%" type="application/pdf" data=""><span align="center">Dokumen Elektronik Tidak Tersedia</span></object>';
		}

		$TombolEditSuratMasuk = '';

		$judul = "DETIL SURAT MASUK";

		echo json_encode(array(
			'st' => 1,
			'register_id' => base64_encode($this->encrypt->encode($register_id)),
			'klasifikasi_surat_id' => $klasifikasi_surat_id,
			'klasifikasi_surat' => $klasifikasi_surat,
			'jenis_surat_id' => $jenis_surat_id,
			'jenis_surat' => $jenis_surat,
			'tanggal_register' => $tanggal_register,
			'tanggal_surat' => $tanggal_surat,
			'nomor_surat' => $nomor_surat,
			'nomor_agenda' => $nomor_agenda,
			'pengirim' => $pengirim,
			'tujuan_id' => $tujuan_id,
			'tujuan' => $tujuan,
			'perihal' => $perihal,
			'judul' => $judul,
			'tombol_edit_surat_masuk' => $TombolEditSuratMasuk,
			'dokumen_elektronik' => $TampilDokumenElektronik
		));
		return;
	}

	public function suratmasuk_pelaksana_pegawai()
	{
		$this->form_validation->set_rules('jenis_jabatan', 'ID Register', 'trim|required');
		if ($this->form_validation->run() == FALSE) {
			echo json_encode(array('st' => 0, 'msg' => 'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$jenis_jabatan = $this->input->post('jenis_jabatan');
		$queryPegawai = $this->model->get_seleksi('pegawai', 'jabatan_id', $jenis_jabatan);
		$arrayPegawai = array();
		$arrayPegawai[''] = "Pilih";
		foreach ($queryPegawai->result() as $row) {
			$arrayPegawai[$row->id] = $row->nama_gelar;
		}

		$pegawai = form_dropdown('pegawai', $arrayPegawai, '', 'class="form-control" required id="pegawai"');

		echo json_encode(array('st' => 1, 'pegawai' => $pegawai));
		return;
	}


	public function suratmasuk_data_pelaksana()
	{
		$this->form_validation->set_rules('register_id', 'ID Register', 'trim|required');
		if ($this->form_validation->run() == FALSE) {
			echo json_encode(array('st' => 0, 'msg' => 'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$register_id = $this->encrypt->decode(base64_decode($this->input->post('register_id')));

		$query = $this->model->get_seleksi('register_pelaksanaan', 'register_id', $register_id);
		$jumlahData = $query->num_rows();
		$dataTerakhir = $query->last_row();
		$data = array();
		$no = $_POST['start'];
		foreach ($query->result() as $row) {
			$no++;
			$UserData = array();
			//$UserData[] = $register_id;
			$UserData[] = "<div>" . $no . "</div>";
			$UserData[] = $this->tanggalhelper->convertToInputDate($row->tanggal_pelaksanaan);
			$UserData[] = $row->jenis_pelaksanaan;
			// $UserData[] = $row->dari_fullname . '<br/>' . $row->dari_jabatan;
			$UserData[] = $row->dari_jabatan;
			// $UserData[] = $row->kepada_fullname . '<br/>' . $row->kepada_jabatan;
			$UserData[] = $row->kepada_jabatan;
			$UserData[] = $row->keterangan;
			if ($dataTerakhir->pelaksanaan_id == $row->pelaksanaan_id) {
				$UserData[] = '<div>
					<button type="button" onclick="EditPelaksanaan(\'' . base64_encode($this->encrypt->encode($row->pelaksanaan_id)) . '\')" class="btn btn-success btn-sm m-r-5">Edit</button>
					<button type="button" onclick="HapusPelaksanaan(\'' . base64_encode($this->encrypt->encode($row->pelaksanaan_id)) . '\')" class="btn btn-danger btn-sm m-r-5">Hapus</button>
					</div>';
			} else {
				$UserData[] = '';
			}
			$data[] = $UserData;
		}

		$json_data = array(
			"draw" => $_POST['draw'],
			"recordsTotal" => $jumlahData,
			"recordsFiltered" => $jumlahData,
			"data" => $data,
		);
		echo json_encode($json_data);
	}



	public function suratmasuk_pelaksana_edit()
	{
		$this->form_validation->set_rules('pelaksanaan_id', 'Data Pelaksanaan', 'trim|required');
		if ($this->form_validation->run() == FALSE) {
			echo json_encode(array('st' => 0, 'msg' => 'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$pelaksanaan_id = $this->encrypt->decode(base64_decode($this->input->post('pelaksanaan_id')));

		$queryPelaksanaan = $this->model->get_seleksi('register_pelaksanaan', 'pelaksanaan_id', $pelaksanaan_id);
		$jenis_pelaksanaan_id = $queryPelaksanaan->row()->jenis_pelaksanaan_id;
		$tanggal_pelaksanaan = $this->tanggalhelper->convertToInputDate($queryPelaksanaan->row()->tanggal_pelaksanaan);
		$dari_userid = $queryPelaksanaan->row()->dari_userid;
		$dari_jabatan_id = $queryPelaksanaan->row()->dari_jabatan_id;
		$kepada_userid = $queryPelaksanaan->row()->kepada_userid;
		$kepada_jabatan_id = $queryPelaksanaan->row()->kepada_jabatan_id;
		$keterangan = $queryPelaksanaan->row()->keterangan;
		$dari_fullname = $queryPelaksanaan->row()->dari_fullname;
		$dari_jabatan = $queryPelaksanaan->row()->dari_jabatan;


		$array_pelaksanaan = array('' => 'Pilih', '10' => 'Disposisi', '20' => 'Dilaksanakan', '30' => 'Diteruskan');
		$jenis_pelaksanaan = form_dropdown('jenis_pelaksanaan', $array_pelaksanaan, $jenis_pelaksanaan_id, 'class="form-control" required id="jenis_pelaksanaan" onChange="JenisPelaksanaan()"');


		$queryJabatan = $this->model->get_jabatan_pelaksana($dari_jabatan_id);
		$JenisJabatan = array();
		$JenisJabatan[''] = "Pilih";
		foreach ($queryJabatan->result() as $row) {
			$JenisJabatan[$row->group_id] = $row->group_name;
		}

		$queryPegawai = $this->model->get_seleksi('pegawai', 'jabatan_id', $kepada_jabatan_id);
		$arrayPegawai = array();
		$arrayPegawai[''] = "Pilih";
		foreach ($queryPegawai->result() as $row) {
			$arrayPegawai[$row->id] = $row->nama_gelar;
		}

		$pegawai = form_dropdown('pegawai', $arrayPegawai, $kepada_userid, 'class="form-control" required id="pegawai"');

		$jenis_jabatan = form_dropdown('jenis_jabatan', $JenisJabatan, $kepada_jabatan_id, 'class="form-control" required id="jenis_jabatan" onChange="TampilPegawai()"');

		echo json_encode(array(
			'st' => 1,
			'pelaksanaan_id' => base64_encode($this->encrypt->encode($pelaksanaan_id)),
			'jenis_pelaksanaan_id' => $jenis_pelaksanaan_id,
			'tanggal_pelaksanaan' => $tanggal_pelaksanaan,
			'dari_userid' => $dari_userid,
			'dari_jabatan_id' => $dari_jabatan_id,
			'kepada_userid' => $kepada_userid,
			'kepada_jabatan_id' => $kepada_jabatan_id,
			'keterangan' => $keterangan,
			'jenis_pelaksanaan' => $jenis_pelaksanaan,
			'pegawai' => $pegawai,
			'jenis_jabatan' => $jenis_jabatan,
			'dari_fullname' => $dari_fullname,
			'dari_jabatan' => $dari_jabatan
		));
		return;
	}



	public function suratmasuk_tampil_pelaksana()
	{
		$this->form_validation->set_rules('jenis_pelaksanaan', 'Jenis Pelaksanaan', 'trim|required');
		if ($this->form_validation->run() == FALSE) {
			echo json_encode(array('st' => 0, 'msg' => 'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$jenis_pelaksanaan_id = $this->input->post('jenis_pelaksanaan');
		if (($jenis_pelaksanaan_id == 10) || ($jenis_pelaksanaan_id == 30)) {
			$queryJabatan = $this->model->get_data('v_groups');
			$JenisJabatan = array();
			$JenisJabatan[''] = "Pilih";
			foreach ($queryJabatan->result() as $row) {
				$JenisJabatan[$row->group_id] = $row->group_name;
			}

			$jenis_jabatan = form_dropdown('jenis_jabatan', $JenisJabatan, '', 'class="form-control" required id="jenis_jabatan" onChange="TampilPegawai()"');
			echo json_encode(array('st' => 1, 'jenis_jabatan' => $jenis_jabatan));
			return;
		} else {
			echo json_encode(array('st' => 0, 'msg' => 'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}
	}



	public function suratmasuk_pelaksana_tambah()
	{
		$this->form_validation->set_rules('register_id', 'ID Register', 'trim|required');
		if ($this->form_validation->run() == FALSE) {
			echo json_encode(array('st' => 0, 'msg' => 'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$register_id = $this->encrypt->decode(base64_decode($this->input->post('register_id')));
		$pelaksanaan_id = '-1';
		$queryPelaksana = $this->model->get_last_pelaksana($register_id);
		$cekPelaksanaan = $queryPelaksana->num_rows();
		if ($cekPelaksanaan != 0) {
			$jenis_pelaksanaan_id = $queryPelaksana->row()->jenis_pelaksanaan_id;
			$dari_jabatan_id = $queryPelaksana->row()->dari_jabatan_id;
			$dari_jabatan = $queryPelaksana->row()->dari_jabatan;
			$tanggal_pelaksanaan = $queryPelaksana->row()->tanggal_pelaksanaan;
		} else {
			$jenis_pelaksanaan_id = "";
			$dari_jabatan_id = "2";
			$dari_jabatan = "";
			$tanggal_pelaksanaan = "";
		}

		$tanggal_sekarang = date("d/m/Y");

		$array_pelaksanaan = array('' => 'Pilih', '10' => 'Disposisi', '20' => 'Dilaksanakan', '30' => 'Diteruskan');
		$jenis_pelaksanaan = form_dropdown('jenis_pelaksanaan', $array_pelaksanaan, '', 'class="form-control" required id="jenis_pelaksanaan" onChange="JenisPelaksanaan()"');

		$queryJabatan = $this->model->get_jabatan_pelaksana($dari_jabatan_id);
		$JenisJabatan = array();
		$JenisJabatan[''] = "Pilih";
		foreach ($queryJabatan->result() as $row) {
			$JenisJabatan[$row->group_id] = $row->group_name;
		}

		$jenis_jabatan = form_dropdown('jenis_jabatan', $JenisJabatan, '', 'class="form-control" required id="jenis_jabatan" onChange="TampilPegawai()"');

		echo json_encode(array(
			'st' => 1,
			'pelaksanaan_id' => base64_encode($this->encrypt->encode($pelaksanaan_id)),
			'jenis_pelaksanaan_id' => $jenis_pelaksanaan_id,
			'dari_jabatan_id' => $dari_jabatan_id,
			'dari_jabatan' => $dari_jabatan,
			'tanggal_pelaksanaan' => $tanggal_pelaksanaan,
			'jenis_pelaksanaan' => $jenis_pelaksanaan,
			'jenis_jabatan' => $jenis_jabatan,
			'tanggal_sekarang' => $tanggal_sekarang
		));
		return;
	}



	public function suratmasuk_simpan_pelaksanaan()
	{
		$this->form_validation->set_rules('register_id', 'ID Register', 'trim|required');
		$this->form_validation->set_rules('pelaksanaan_id', 'ID Surat Masuk', 'trim|required');
		$this->form_validation->set_rules('tanggal_pelaksanaan', 'Tanggal Register', 'trim|required');
		$this->form_validation->set_rules('jenis_pelaksanaan', 'Tanggal Surat', 'trim|required');
		$this->form_validation->set_rules('keterangan', 'Keterangan', 'trim');
		if ($this->form_validation->run() == FALSE) {
			echo json_encode(array('st' => 0, 'msg' => 'Tidak Berhasil:<br/>' . validation_errors()));
			return;
		}

		$pelaksanaan_id = $this->encrypt->decode(base64_decode($this->input->post('pelaksanaan_id')));
		$register_id = $this->encrypt->decode(base64_decode($this->input->post('register_id')));
		$tanggal_pelaksanaan = $this->tanggalhelper->convertToMysqlDate($this->input->post('tanggal_pelaksanaan'));
		$jenis_pelaksanaan_id = $this->input->post('jenis_pelaksanaan');

		$message_text = "" . $namaJabatan . " MS Aceh Anda Menerima Surat Nomor : "
			. $nomor_surat . " tanggal " . $tanggal_surat . " dari " . $pengirim .
			". Mohon agar segera ditindaklanjuti, Terima Kasih.";

		if ($jenis_pelaksanaan_id == '10') {
			$jenis_pelaksanaan = "Disposisi";
		} else if ($jenis_pelaksanaan_id == '20') {
			$jenis_pelaksanaan = "Dilaksanakan";
		} else if ($jenis_pelaksanaan_id == '30') {
			$jenis_pelaksanaan = "Diteruskan";
		}
		$keterangan = $this->input->post('keterangan');

		if (($jenis_pelaksanaan_id == '10') || ($jenis_pelaksanaan_id == '30')) {
			$this->form_validation->set_rules('jenis_jabatan', 'Jenis Jabatan', 'trim|required');
			$this->form_validation->set_rules('pegawai', 'Pegawai Pelaksana', 'trim');
			if ($this->form_validation->run() == FALSE) {
				echo json_encode(array('st' => 0, 'msg' => 'Tidak Berhasil:<br/>' . validation_errors()));
				return;
			}

			$jenis_jabatan_tujuan_id = $this->input->post('jenis_jabatan');
			$pegawai_tujuan_id = $this->input->post('pegawai');

			$queryJabatan = $this->model->get_seleksi('sys_groups', 'groupid', $jenis_jabatan_tujuan_id);
			$jabatan = $queryJabatan->row()->name;

			$queryPegawai = $this->model->get_seleksi('pegawai', 'id', $pegawai_tujuan_id);
			$pegawai_tujuan = $queryPegawai->row()->nama_gelar;
			$pegawai_tujuan_group_id = $queryPegawai->row()->jabatan_id;
			$pegawai_tujuan_group = $queryPegawai->row()->jabatan_nama;
		} else {
			$jenis_jabatan_tujuan_id = "";
			$pegawai_tujuan_id = "";
			$pegawai_tujuan = "";
			$pegawai_tujuan_group_id = "";
			$pegawai_tujuan_group = "";
		}


		$pengguna_id = $this->session->userdata('userid');
		$queryPengguna = $this->model->get_seleksi('v_users', 'userid', $pengguna_id);
		$pegawai_nama = $queryPengguna->row()->fullname;
		$pegawai_group_id = $queryPengguna->row()->group_id;
		$pegawai_group = $queryPengguna->row()->group_name;

		// var_dump($pelaksanaan_id);

		if ($pelaksanaan_id == '-1') {
			$data = array(
				'register_id' => $register_id,
				'jenis_pelaksanaan_id' => $jenis_pelaksanaan_id,
				'jenis_pelaksanaan' => $jenis_pelaksanaan,
				'tanggal_pelaksanaan' => $tanggal_pelaksanaan,
				'dari_userid' => $pengguna_id,
				'dari_fullname' => $pegawai_nama,
				'dari_jabatan_id' => $pegawai_group_id,
				'dari_jabatan' => $pegawai_group,
				'kepada_userid' => $pegawai_tujuan_id,
				'kepada_fullname' => $pegawai_tujuan,
				'kepada_jabatan_id' => $pegawai_tujuan_group_id,
				'kepada_jabatan' => $pegawai_tujuan_group,
				'keterangan' => $keterangan,
				'diinput_oleh' => $this->session->userdata('username'),
				'diinput_tanggal' => date("Y-m-d h:i:s", time())
			);
			$querySimpan = $this->model->simpan_data('register_pelaksanaan', $data);

			$queryRegister = $this->model->get_last_pelaksana($register_id);
			$jenis_pelaksanaan_update_id = (!empty($queryRegister->row()->jenis_pelaksanaan_id) ? $queryRegister->row()->jenis_pelaksanaan_id : '1');
			$jenis_pelaksanaan_update = (!empty($queryRegister->row()->jenis_pelaksanaan) ? $queryRegister->row()->jenis_pelaksanaan : 'Pendaftaran');

			$data_status = array('status_pelaksanaan_id' => $jenis_pelaksanaan_update_id, 'status_pelaksanaan' => $jenis_pelaksanaan_update);
			$queryUpdate = $this->model->pembaharuan_data('register_surat', $data_status, 'register_id', $register_id);
		} else {
			$data = array(
				'register_id' => $register_id,
				'jenis_pelaksanaan_id' => $jenis_pelaksanaan_id,
				'jenis_pelaksanaan' => $jenis_pelaksanaan,
				'tanggal_pelaksanaan' => $tanggal_pelaksanaan,
				'dari_userid' => $pengguna_id,
				'dari_fullname' => $pegawai_nama,
				'dari_jabatan_id' => $pegawai_group_id,
				'dari_jabatan' => $pegawai_group,
				'kepada_userid' => $pegawai_tujuan_id,
				'kepada_fullname' => $pegawai_tujuan,
				'kepada_jabatan_id' => $pegawai_tujuan_group_id,
				'kepada_jabatan' => $pegawai_tujuan_group,
				'keterangan' => $keterangan,
				'diperbaharui_oleh' => $this->session->userdata('username'),
				'diperbaharui_tanggal' => date("Y-m-d h:i:s", time())
			);
			$querySimpan = $this->model->pembaharuan_data('register_pelaksanaan', $data, 'pelaksanaan_id', $pelaksanaan_id);

			$queryRegister = $this->model->get_last_pelaksana($register_id);
			$jenis_pelaksanaan_update_id = (!empty($queryRegister->row()->jenis_pelaksanaan_id) ? $queryRegister->row()->jenis_pelaksanaan_id : '1');
			$jenis_pelaksanaan_update = (!empty($queryRegister->row()->jenis_pelaksanaan_id) ? $queryRegister->row()->jenis_pelaksanaan_id : 'Pendaftaran');

			$data_status = array('status_pelaksanaan_id' => $jenis_pelaksanaan_update_id, 'status_pelaksanaan' => $jenis_pelaksanaan_update);
			$queryUpdate = $this->model->pembaharuan_data('register_surat', $data_status, 'register_id', $register_id);
		}

		$querydetail = $this->model->get_seleksi('register_surat', 'register_id', $register_id);
		$nomor_surat = $querydetail->row()->nomor_surat;
		$tanggal_surat = $querydetail->row()->tanggal_surat;
		$telegram_id = $this->model->get_seleksi('pegawai', 'jabatan_id', $pegawai_tujuan_group_id)->row()->chatid;

		if ($jenis_pelaksanaan_id == '10') {
			$message_text = "Sdr. " . $pegawai_tujuan . " Anda Menerima Disposisi Surat Nomor : "
				. $nomor_surat . " tanggal " . $tanggal_surat . " dari " . $pegawai_group . " " . $pegawai_nama .
				". Mohon agar segera ditindaklanjuti, Terima Kasih.";
		} else if ($jenis_pelaksanaan_id == '30') {
			$message_text = "Sdr. " . $pegawai_tujuan . " Anda Menerima Terusan Surat Nomor : "
				. $nomor_surat . " tanggal " . $tanggal_surat . " dari " . $pegawai_group . " " . $pegawai_nama .
				". Mohon agar segera ditindaklanjuti, Terima Kasih.";
		}

		if ($querySimpan == 1) {
			kirimNotifikasiTelegram($telegram_id, $message_text);
			echo json_encode(array('st' => 1, 'tele_id' => $telegram_id));
		} else {
			echo json_encode(array('st' => 0, 'msg' => 'Simpan Data Pelaksanaan Gagal'));
		}
		return;
	}

	public function suratmasuk_simpan()
	{
		$this->form_validation->set_rules('register_id', 'ID Surat Masuk', 'trim|required');
		if ($this->form_validation->run() == FALSE) {
			echo json_encode(array('st' => 0, 'msg' => 'Tidak Berhasil:<br/>' . validation_errors()));
			return;
		}

		$register_id = $this->encrypt->decode(base64_decode($this->input->post('register_id')));

		$upload_data = "";
		if (!empty($_FILES['dokumen']['name'])) {
			$config = array(
				'upload_path' => './dokumen/',
				'allowed_types' => "pdf",
				'file_ext_tolower' => TRUE,
				'encrypt_name' => TRUE,
				'overwrite' => TRUE,
				'remove_spaces' => TRUE,
				'max_size' => "100000"
			);

			$this->load->library('upload', $config);
			$this->upload->initialize($config);

			$this->upload->do_upload('dokumen');
			$upload_data = $this->upload->data();
		}


		if ($register_id == "-1") {

			$this->form_validation->set_rules('tanggal_surat', 'Tanggal Surat', 'trim|required');
			$this->form_validation->set_rules('generate_nomor', 'Status Generate Nomor Register', 'trim|required');
			$this->form_validation->set_rules('jenis_surat', 'Jenis Surat', 'trim|required');
			$this->form_validation->set_rules('nomor_surat', 'Nomor Surat', 'trim');
			$this->form_validation->set_rules('pengirim', 'Pengirim', 'trim');
			$this->form_validation->set_rules('jabatan', 'Tujuan Surat', 'trim|required');
			$this->form_validation->set_rules('perihal', 'Perihal', 'trim|required');
			$this->form_validation->set_rules('keterangan', 'Keterangan', 'trim');
			$this->form_validation->set_rules('tanggal_register', 'Tanggal Register', 'trim|required');
			if ($this->form_validation->run() == FALSE) {
				echo json_encode(array('st' => 0, 'msg' => 'Tidak Berhasil:<br/>' . validation_errors()));
				return;
			}

			$tanggal_register = $this->tanggalhelper->convertToMysqlDate($this->input->post('tanggal_register'));
			$tanggal_surat = $this->tanggalhelper->convertToMysqlDate($this->input->post('tanggal_surat'));
			$jenis_surat_id = $this->input->post('jenis_surat');
			$nomor_surat = $this->input->post('nomor_surat');
			$pengirim = $this->input->post('pengirim');
			$jabatan_id = $this->input->post('jabatan');
			$perihal = $this->input->post('perihal');
			$keterangan = $this->input->post('keterangan');
			$generate_nomor = $this->input->post('generate_nomor');

			$klasifikasi_surat_id = '1';
			$klasifikasi_surat = 'Surat Masuk';

			$queryJabatan = $this->model->get_seleksi('sys_groups', 'groupid', $jabatan_id);
			$namaJabatan = $queryJabatan->row()->name;

			$queryJenisSurat = $this->model->get_seleksi('ref_jenis_surat', 'id', $jenis_surat_id);
			$namaJenisSurat = $queryJenisSurat->row()->nama;


			if ($generate_nomor == 2) {
				$this->form_validation->set_rules('nomor_index_manual', 'Nomor Manual', 'trim|required');
				$this->form_validation->set_rules('kode_nomor_manual', 'Tahun', 'trim|required');
				if ($this->form_validation->run() == FALSE) {
					echo json_encode(array('st' => 0, 'msg' => 'Tidak Berhasil:<br/>' . validation_errors()));
					return;
				}

				$nomor_index = $this->input->post('nomor_index_manual');
				$tahun = $this->input->post('kode_nomor_manual');

				$nomor_agenda = $nomor_index . "/" . $tahun;
			} else {
				$this->form_validation->set_rules('nomor_index', 'Nomor Index', 'trim|required');
				$this->form_validation->set_rules('nomor_agenda', 'Nomor Agenda', 'trim|required');
				if ($this->form_validation->run() == FALSE) {
					echo json_encode(array('st' => 0, 'msg' => 'Tidak Berhasil:<br/>' . validation_errors()));
					return;
				}

				$nomor_index = $this->input->post('nomor_index');
				$nomor_agenda = $this->input->post('nomor_agenda');
			}


			$data = array(
				'klasifikasi_surat_id' => $klasifikasi_surat_id,
				'klasifikasi_surat' => $klasifikasi_surat,
				'nomor_index' => $nomor_index,
				'nomor_agenda' => $nomor_agenda,
				'jenis_surat_id' => $jenis_surat_id,
				'jenis_surat' => $namaJenisSurat,
				'tanggal_register' => $tanggal_register,
				'tanggal_surat' => $tanggal_surat,
				'nomor_surat' => $nomor_surat,
				'pengirim' => $pengirim,
				'tujuan_id' => $jabatan_id,
				'tujuan' => $namaJabatan,
				'perihal' => $perihal,
				'dokumen_elektronik' => (!empty($upload_data['file_name']) ? $upload_data['file_name'] : NULL),
				'keterangan' => $keterangan,
				'status_pelaksanaan_id' => "1",
				'status_pelaksanaan' => "Pendaftaran",
				'diinput_oleh' => $this->session->userdata('username'),
				'diinput_tanggal' => date("Y-m-d h:i:s", time())
			);

			$querySimpan = $this->model->simpan_data('register_surat', $data);
		} else {
			$this->form_validation->set_rules('nomor_surat', 'Nomor Surat', 'trim');
			$this->form_validation->set_rules('pengirim', 'Pengirim', 'trim');
			$this->form_validation->set_rules('perihal', 'Perihal', 'trim|required');
			$this->form_validation->set_rules('keterangan', 'Keterangan', 'trim');
			if ($this->form_validation->run() == FALSE) {
				echo json_encode(array('st' => 0, 'msg' => 'Tidak Berhasil:<br/>' . validation_errors()));
				return;
			}

			$nomor_surat = $this->input->post('nomor_surat');
			$pengirim = $this->input->post('pengirim');
			$perihal = $this->input->post('perihal');
			$keterangan = $this->input->post('keterangan');

			if (!empty($upload_data['file_name'])) {
				$data = array(
					'nomor_surat' => $nomor_surat,
					'pengirim' => $pengirim,
					'perihal' => $perihal,
					'dokumen_elektronik' => $upload_data['file_name'],
					'keterangan' => $keterangan,
					'diperbaharui_oleh' => $this->session->userdata('username'),
					'diperbaharui_tanggal' => date("Y-m-d h:i:s", time())
				);
			} else {
				$data = array(
					'nomor_surat' => $nomor_surat,
					'pengirim' => $pengirim,
					'perihal' => $perihal,
					'keterangan' => $keterangan,
					'diperbaharui_oleh' => $this->session->userdata('username'),
					'diperbaharui_tanggal' => date("Y-m-d h:i:s", time())
				);
			}

			$querySimpan = $this->model->pembaharuan_data('register_surat', $data, 'register_id', $register_id);
		}
		// perihal " . $perihal
		$message_text = "" . $namaJabatan . " MS Aceh Anda Menerima Surat Nomor : "
			. $nomor_surat . " tanggal " . $tanggal_surat . " dari " . $pengirim .
			". Mohon agar segera ditindaklanjuti, Terima Kasih.";

		$telegram_id = $this->model->get_seleksi('pegawai', 'jabatan_id', $jabatan_id)->row()->chatid;
		$ress = kirimNotifikasiTelegram($telegram_id, $message_text);
		if ($ress = 'sukses') {
			echo json_encode(array('st' => 1, 'msg' => $message_text, 'tujuan_id' => $telegram_id));
		} else {
			echo json_encode(array('st' => 0, 'msg' => $ress));
		}
		redirect('suratmasuk');
	}



	public function suratmasuk_pelaksana_hapus()
	{
		$this->form_validation->set_rules('pelaksanaan_id', 'ID Pelaksanaan', 'trim|required');
		if ($this->form_validation->run() == FALSE) {
			echo json_encode(array('st' => 0, 'msg' => 'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$pelaksanaan_id = $this->encrypt->decode(base64_decode($this->input->post('pelaksanaan_id')));

		$queryPelaksanaan = $this->model->get_seleksi('register_pelaksanaan', 'pelaksanaan_id', $pelaksanaan_id);
		$tanggal_pelaksanaan = $this->tanggalhelper->convertDayDate($queryPelaksanaan->row()->tanggal_pelaksanaan);
		$register_id = $queryPelaksanaan->row()->register_id;
		$queryHapus = $this->model->hapus_data('register_pelaksanaan', 'pelaksanaan_id', $pelaksanaan_id);

		$queryRegister = $this->model->get_last_pelaksana($register_id);
		$jenis_pelaksanaan_update_id = (!empty($queryRegister->row()->jenis_pelaksanaan_id) ? $queryRegister->row()->jenis_pelaksanaan_id : '1');
		$jenis_pelaksanaan_update = (!empty($queryRegister->row()->jenis_pelaksanaan) ? $queryRegister->row()->jenis_pelaksanaan : 'Pendaftaran');

		$data_status = array('status_pelaksanaan_id' => $jenis_pelaksanaan_update_id, 'status_pelaksanaan' => $jenis_pelaksanaan_update);
		$queryUpdate = $this->model->pembaharuan_data('register_surat', $data_status, 'register_id', $register_id);

		if ($queryHapus == 1) {
			echo json_encode(array('st' => 1, 'msg' => 'Hapus Riwayat Pelaksanaan tanggal ' . $tanggal_pelaksanaan . ' Berhasil'));
			return;
		} else {
			echo json_encode(array('st' => 0, 'msg' => 'Hapus Riwayat Pelaksanaan tanggal ' . $tanggal_pelaksanaan . ' Gagal'));
			return;
		}
	}


	public function suratmasuk_disposisi()
	{
		$this->form_validation->set_rules('register_id', 'ID Register', 'trim|required');
		if ($this->form_validation->run() == FALSE) {
			echo json_encode(array('st' => 0, 'msg' => 'Tidak Berhasil:<br/>' . validation_errors()));
			return;
		}

		$register_id = $this->encrypt->decode(base64_decode($this->input->post('register_id')));
		//die(var_dump($register_id));

		$queryKonfigurasi1 = $this->model->get_seleksi('sys_config', 'id', '4');
		$queryKonfigurasi2 = $this->model->get_seleksi('sys_config', 'id', '22');
		$queryKonfigurasi3 = $this->model->get_seleksi('sys_config', 'id', '5');
		$namaPengadilan = $queryKonfigurasi1->row()->value;
		$logoPengadilan = $queryKonfigurasi2->row()->value;
		$alamat_pengadilan = $queryKonfigurasi3->row()->value;

		$logo_pengadilan = '<img src="' . base_url() . 'assets/img/' . $logoPengadilan . '" width="100px" height="120px""></img>';

		$queryRegister = $this->model->get_seleksi('v_suratmasuk', 'register_id', $register_id);
		$jenis_surat = $queryRegister->row()->jenis_surat;
		$tanggal_register = $this->tanggalhelper->convertDayDate($queryRegister->row()->tanggal_register);
		$tanggal_surat = $this->tanggalhelper->convertDayDate($queryRegister->row()->tanggal_surat);
		$nomor_surat = $queryRegister->row()->nomor_surat;
		$pengirim = $queryRegister->row()->pengirim;
		$tujuan = $queryRegister->row()->tujuan;
		$perihal = $queryRegister->row()->perihal;
		$nomor_agenda = $queryRegister->row()->nomor_agenda;

		$queryPelaksanaan = $this->model->get_seleksi('register_pelaksanaan', 'register_id', $register_id);
		//$a = 0;
		$TampilPelaksanaan = "<tr height='300px'>
							<td colspan='2' width='40%'' align='center'></td>
							<td width='30%' align='center'></td>
							<td width='30%' align='center'></td></tr>";
		//die(var_dump($queryPelaksanaan->result()));
		$tampil_pelaksanaan2 = array();
		foreach ($queryPelaksanaan->result() as $row) {
			//$a++;
			if (!empty($row->kepada_jabatan)) {
				//$namaJabatan = "<b>" . $row->kepada_jabatan . "</b><br/>" . $row->kepada_fullname;
				$namaJabatan = "<b>" . $row->kepada_jabatan . "</b>";
			} else {
				$namaJabatan = "-";
			}
			$tampil_pelaksanaan2[] = "<tr>";
			// $tampil_pelaksanaan2[] .= "<td colspan='2'><b>" . $row->dari_jabatan . "</b><br/>" . $row->dari_fullname . "</td>";
			$tampil_pelaksanaan2[] .= "<td colspan='2'><b>" . $row->dari_jabatan . "</b>";
			$tampil_pelaksanaan2[] .= "<td width='30'>" . $namaJabatan . "</td>";
			$tampil_pelaksanaan2[] .= "<td width='30'>" . $row->keterangan . "</td>";
			$tampil_pelaksanaan2[] .= "</tr>";
		}

		$tampil_pelaksanaan = $tampil_pelaksanaan2;

		echo json_encode(array(
			'st' => 1,
			'nama_pengadilan' => $namaPengadilan,
			'tampil_pelaksanaan' => $tampil_pelaksanaan,
			'logo_pengadilan' => $logo_pengadilan,
			'alamat_pengadilan' => $alamat_pengadilan,
			'jenis_surat' => $jenis_surat,
			'nomor_surat' => $nomor_surat,
			'nomor_agenda' => $nomor_agenda,
			'tanggal_register' => $tanggal_register,
			'tanggal_surat' => $tanggal_surat,
			'pengirim' => $pengirim,
			'tujuan' => $tujuan,
			'perihal' => $perihal
		));
		return;
	}
}
