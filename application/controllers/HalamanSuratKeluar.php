<?php
defined('BASEPATH') or exit('No direct script access allowed');

class HalamanSuratKeluar extends CI_Controller
{
	function __construct()
	{
		parent::__construct();
		if ($this->session->userdata('status_login') == FALSE) {
			redirect('keluar');
		}
		if (!in_array($this->session->userdata('group_id'), $this->session->userdata('kewenangan_persuratan'))) {
			redirect('keluar');
		}
		$this->load->model('ModelSuratKeluar', 'model');
		$queryCek = $this->model->get_seleksi('sys_user_online', 'id', $this->session->userdata('login_id'));
		if (($queryCek->row()->host_address != $this->input->ip_address()) && ($queryCek->row()->userid != $this->session->userdata('userid')) && ($queryCek->row()->user_agent != $this->input->user_agent())) {
			redirect('keluar');
		}
	}

	public function index()
	{
		$data['register_id'] = base64_encode($this->encrypt->encode('-1'));
		$this->load->view('header');
		$this->load->view('suratkeluar/index', $data);
		$this->load->view('suratkeluar/footer');
	}

	public function suratkeluar_data()
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
			$UserData[] = $row->jenis_surat;
			$UserData[] = $row->tujuan;
			$UserData[] = $row->status_pelaksanaan;
			$UserData[] = '<div><button type="button" onclick="BukaModalDetil(\'' . base64_encode($this->encrypt->encode($row->register_id)) . '\')" class="btn btn-success btn-sm m-r-5">Detil</button></div>';
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


	public function suratkeluar_periode_cetak()
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

		$queryRegister = $this->model->get_data('v_tahun_suratkeluar');
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


	public function suratkeluar_register_cetak()
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
			$dataRegister .= "<td>" . $row->nomor_surat . "</td>";
			$dataRegister .= "<td><div align='center'>" . $this->tanggalhelper->convertToInputDate($row->tanggal_register) . "</div></td>";
			$dataRegister .= "<td>" . $row->pengirim . "</td>";
			$dataRegister .= "<td align='center'>" . $row->jenis_surat . "</td>";
			$dataRegister .= "<td>" . $row->jenis_ekspedisi . "</td>";
			$dataRegister .= "<td><div align='center'>" . $this->tanggalhelper->convertToInputDate($row->tanggal_kirim) . "</div></td>";
			$dataRegister .= "</tr>";
		}
		$register = $dataRegister;

		echo json_encode(array('st' => 1, 'register' => $register));
	}


	public function suratkeluar_pencarian()
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

		// $queryJabatanStruktural = $this->model->get_data('v_groups_struktural');
		// $array_jabatan_struktural = array();
		// $array_jabatan_struktural[''] = "Pilih";
		// foreach ($queryJabatanStruktural->result() as $row) {
		// 	$array_jabatan_struktural[$row->groupid] = $row->group_name;
		// }

		$queryJabatan = $this->model->get_list_jabatan();
		$InitJabatan = array('' => 'Pilih');
		foreach ($queryJabatan->result() as $row) {
			$JabatanQuery[$row->group_id] = $row->group_name;
		}
		$array_jabatan_struktural = $InitJabatan+$JabatanQuery;

		// $queryPengiriman = $this->model->get_data('ref_pengiriman');
		// $array_pengiriman = array();
		// $array_pengiriman[''] = "Pilih";
		// foreach ($queryPengiriman->result() as $row) {
		// 	$array_pengiriman[$row->id] = $row->jenis_pengiriman;
		// }

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

		$queryRegister = $this->model->get_data('v_tahun_suratkeluar');
		$array_tahun = array();
		$array_tahun[''] = "Pilih";
		foreach ($queryRegister->result() as $row) {
			$array_tahun[$row->tahun_register] = $row->tahun_register;
		}

		$bulan_register = form_dropdown('bulan_register_cari', $arrayBulanRegister, '', 'class="form-control" id="bulan_register_cari"');
		$tahun_register = form_dropdown('tahun_register_cari', $array_tahun, '', 'class="form-control" id="tahun_register_cari"');
		// $pengiriman = form_dropdown('pengiriman_cari', $array_pengiriman, '', 'class="form-control" id="pengiriman_cari"');
		$jabatan_struktural = form_dropdown('jabatan_struktural_cari', $array_jabatan_struktural, '', 'class="form-control" id="jabatan_struktural_cari"');

		echo json_encode(array(
			'st' => 1,
			'bulan_register' => $bulan_register,
			'tahun_register' => $tahun_register,
			// 'pengiriman' => $pengiriman,
			'jabatan_struktural' => $jabatan_struktural
		));
		return;
	}


	public function suratkeluar_jenissurat()
	{
		$this->form_validation->set_rules('jenis_surat', 'Data Jenis Surat', 'trim|required');
		$this->form_validation->set_rules('tanggal_register', 'Tanggal Register', 'trim|required');
		if ($this->form_validation->run() == FALSE) {
			echo json_encode(array('st' => 0, 'msg' => 'Tidak Berhasil:<br/>' . validation_errors()));
			return;
		}

		$jenis_surat_id = $this->input->post('jenis_surat');
		$tanggal_register = $this->input->post('tanggal_register');

		$queryJenisSurat = $this->model->get_seleksi('ref_penomoran', 'id', $jenis_surat_id);
		$keterangan_jenis_surat = $queryJenisSurat->row()->keterangan;
		$format_nomor = $queryJenisSurat->row()->kode;

		$queryKodeSurat = $this->model->get_seleksi('sys_config', 'id', '23');
		$kode_surat = $queryKodeSurat->row()->value;

		error_reporting(0);
		$time_temp = strtr($tanggal_register,'/','-');
		$time = date_create_from_format("d-m-Y",$time_temp);
		$bulan_register = $time->format('m');
		$tahun_register = $time->format('Y');

		// $bulan_register = date("m", strtotime(date_format(date_create($tanggal_register),"d/m/Y H:i:s")));
		// $tahun_register = date("Y", strtotime($tanggal_register));

		//die(var_dump(date_format(date_create($tanggal_register),"d/m/Y H:i:s")));

		$queryNomorIndex = $this->model->get_seleksi_nomor_index($tahun_register);
		$nomor_index = $queryNomorIndex->row()->nomor_index + 1;


		$kataganti1 = str_replace("KD_SURAT", $kode_surat, $format_nomor);
		$kataganti2 = str_replace("BLN", $bulan_register, $kataganti1);
		$kataganti3 = str_replace("THN", $tahun_register, $kataganti2);
		$nomor_surat = str_replace("NMR", $nomor_index, $kataganti3);

		echo json_encode(array(
			'st' => 1,
			'keterangan_jenis_surat' => $keterangan_jenis_surat,
			'nomor_surat' => $nomor_surat,
		));
		return;
	}


	public function suratkeluar_add()
	{
		$this->form_validation->set_rules('register_id', 'ID Register', 'trim|required');
		if ($this->form_validation->run() == FALSE) {
			echo json_encode(array('st' => 0, 'msg' => 'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$register_id = $this->encrypt->decode(base64_decode($this->input->post('register_id')));

		$queryJenisSurat = $this->model->get_seleksi('ref_penomoran', 'aktif', '1');
		$array_jenis_surat = array();
		$array_jenis_surat[''] = "Pilih";
		foreach ($queryJenisSurat->result() as $row) {
			$array_jenis_surat[$row->id] = $row->jenis;
		}

		$queryPengiriman = $this->model->get_data('ref_pengiriman');
		$array_pengiriman = array();
		$array_pengiriman[''] = "Pilih";
		foreach ($queryPengiriman->result() as $row) {
			$array_pengiriman[$row->id] = $row->jenis_pengiriman;
		}

		$queryJenisTujuanSurat = $this->model->get_data('v_tujuan_surat');
		$array_jenis_tujuan_surat = array();
		$array_jenis_tujuan_surat[''] = "Pilih";
		foreach ($queryJenisTujuanSurat->result() as $row) {
			$array_jenis_tujuan_surat[$row->group_id] = $row->group_name;
		}

		$queryJabatan = $this->model->get_list_jabatan();
		$InitJabatan = array('' => 'Pilih');
		foreach ($queryJabatan->result() as $row) {
			$JabatanQuery[$row->group_id] = $row->group_name;
		}
		$array_jabatan_struktural = $InitJabatan+$JabatanQuery;

		// $queryJabatanStruktural = $this->model->get_data('v_groups_struktural');
		// $array_jabatan_struktural = array();
		// $array_jabatan_struktural[''] = "Pilih";
		// foreach ($queryJabatanStruktural->result() as $row) {
		// 	$array_jabatan_struktural[$row->groupid] = $row->group_name;
		// }

		if ($register_id == '-1') {
			$judul = "TAMBAH DATA SURAT KELUAR";
			$tanggal_register = date("d/m/Y");
			$tahun_register = date("Y");
			$queryNomorIndex = $this->model->get_seleksi_nomor_index($tahun_register);
			$nomor_index = $queryNomorIndex->row()->nomor_index + 1;

			$jenis_surat = form_dropdown('jenis_surat', $array_jenis_surat, '', 'class="form-control" required id="jenis_surat" onChange="TampilJenisSurat()"');
			$jenis_pengiriman = form_dropdown('jenis_pengiriman', $array_pengiriman, '', 'class="form-control" required id="jenis_pengiriman"');
			$jenis_tujuan_surat = form_dropdown('jenis_tujuan_surat', $array_jenis_tujuan_surat, '', 'class="form-control" required id="jenis_tujuan_surat" ');
			$jabatan_struktural = form_dropdown('jabatan_struktural', $array_jabatan_struktural, '', 'class="form-control" required id="jabatan_struktural"');

			$keterangan_jenis_surat = "";
			$nomor_surat = "";
			$tujuan = "";
			$perihal = "";
			$keterangan = "";
		} else {
			$queryRegister = $this->model->get_seleksi('v_suratkeluar', 'register_id', $register_id);
			$nomor_index = $queryRegister->row()->nomor_index;
			$jenis_surat_id = $queryRegister->row()->jenis_surat_id;
			$tanggal_register = $this->tanggalhelper->convertToInputDate($queryRegister->row()->tanggal_register);
			$nomor_surat = $queryRegister->row()->nomor_surat;
			$tujuan_id = $queryRegister->row()->tujuan_id;
			$tujuan = $queryRegister->row()->tujuan;
			$perihal = $queryRegister->row()->perihal;
			$jenis_ekspedisi_id = $queryRegister->row()->jenis_ekspedisi_id;
			$keterangan = $queryRegister->row()->keterangan;
			$pengirim_id = $queryRegister->row()->pengirim_id;

			$queryPenomoran = $this->model->get_seleksi('ref_penomoran', 'id', $jenis_surat_id);
			$keterangan_jenis_surat = $queryPenomoran->row()->keterangan;

			$judul = "EDIT DATA SURAT KELUAR";
			$jenis_surat = form_dropdown('jenis_surat', $array_jenis_surat, $jenis_surat_id, 'class="form-control" required id="jenis_surat" onChange="TampilJenisSurat()"');
			$jenis_pengiriman = form_dropdown('jenis_pengiriman', $array_pengiriman, $jenis_ekspedisi_id, 'class="form-control" required id="jenis_pengiriman"');
			$jenis_tujuan_surat = form_dropdown('jenis_tujuan_surat', $array_jenis_tujuan_surat, $tujuan_id, 'class="form-control" required id="jenis_tujuan_surat"');
			$jabatan_struktural = form_dropdown('jabatan_struktural', $array_jabatan_struktural, $pengirim_id, 'class="form-control" required id="jabatan_struktural"');
		}

		echo json_encode(array(
			'st' => 1,
			'register_id' => base64_encode($this->encrypt->encode($register_id)),
			'nomor_index' => $nomor_index,
			'keterangan_jenis_surat' => $keterangan_jenis_surat,
			'jabatan_struktural' => $jabatan_struktural,
			'nomor_surat' => $nomor_surat,
			'tujuan' => $tujuan,
			'perihal' => $perihal,
			'keterangan' => $keterangan,
			'judul' => $judul,
			'jenis_surat' => $jenis_surat,
			'jenis_tujuan_surat' => $jenis_tujuan_surat,
			'jenis_pengiriman' => $jenis_pengiriman,
			'tanggal_register' => $tanggal_register
		));
		return;
	}


	public function suratkeluar_simpan()
	{
		$this->form_validation->set_rules('register_id', 'Data Surat Keluar', 'trim|required');
		$this->form_validation->set_rules('nomor_index', 'Data Index Nomor', 'trim|required');
		$this->form_validation->set_rules('jenis_tujuan_surat', 'Jenis Tujuan Surat', 'trim');
		$this->form_validation->set_rules('tujuan', 'Tujuan Surat', 'trim|required');
		$this->form_validation->set_rules('perihal', 'Perihal', 'trim|required');
		$this->form_validation->set_rules('keterangan', 'Keterangan', 'trim');
		$this->form_validation->set_rules('jenis_pengiriman', 'Jenis Pengiriman', 'trim');
		if ($this->form_validation->run() == FALSE) {
			echo json_encode(array('st' => 0, 'msg' => 'Tidak Berhasil:<br/>' . validation_errors()));
			return;
		}

		$register_id = $this->encrypt->decode(base64_decode($this->input->post('register_id')));
		$nomor_index = $this->input->post('nomor_index');
		$jenis_tujuan_surat_id = $this->input->post('jenis_tujuan_surat');
		$tujuan = $this->input->post('tujuan');
		$perihal = $this->input->post('perihal');
		$keterangan = $this->input->post('keterangan');
		$jenis_pengiriman_id = $this->input->post('jenis_pengiriman');
		$nomor_surat = $this->input->post('nomor_surat');

		$klasifikasi_surat_id = '2';
		$klasifikasi_surat = 'Surat Keluar';


		$queryTujuanSurat = $this->model->get_seleksi('ref_tujuan_surat', 'groupid', $jenis_tujuan_surat_id);
		$jenis_tujuan_surat = $queryTujuanSurat->row()->name;

		$queryPengiriman = $this->model->get_seleksi('ref_pengiriman', 'id', $jenis_pengiriman_id);
		$jenis_pengiriman = $queryPengiriman->row()->jenis_pengiriman;



		$upload_data = "";
		if (!empty($_FILES['dokumen']['name'])) {
			$config = array(
				'upload_path' => './dokumen/',
				'allowed_types' => "pdf",
				'file_ext_tolower' => TRUE,
				'encrypt_name' => TRUE,
				'overwrite' => TRUE,
				'remove_spaces' => TRUE,
				'max_size' => "10485760"
			);

			$this->load->library('upload', $config);
			$this->upload->initialize($config);

			$this->upload->do_upload('dokumen');
			$upload_data = $this->upload->data();
		}


		if ($register_id == "-1") {
			$this->form_validation->set_rules('tanggal_register', 'Tanggal Register', 'trim|required');
			$this->form_validation->set_rules('jenis_surat', 'Jenis Surat', 'trim|required');
			$this->form_validation->set_rules('nomor_surat', 'Nomor Surat', 'trim');
			$this->form_validation->set_rules('jabatan_struktural', 'Data Bagian Pembuat Surat', 'trim|required');
			if ($this->form_validation->run() == FALSE) {
				echo json_encode(array('st' => 0, 'msg' => 'Tidak Berhasil:<br/>' . validation_errors()));
				return;
			}

			$jenis_surat_id = $this->input->post('jenis_surat');
			$queryJenisSurat = $this->model->get_seleksi('ref_penomoran', 'id', $jenis_surat_id);
			$jenis_surat = $queryJenisSurat->row()->jenis;
			$tanggal_register = $this->tanggalhelper->convertToMysqlDate($this->input->post('tanggal_register'));
			$nomor_surat = $this->input->post('nomor_surat');
			$jabatan_struktural_id = $this->input->post('jabatan_struktural');

			$queryJabatanStruktural = $this->model->get_seleksi('sys_groups', 'groupid', $jabatan_struktural_id);
			$jabatan_struktural = $queryJabatanStruktural->row()->name;

			$data = array(
				'klasifikasi_surat_id' => $klasifikasi_surat_id,
				'klasifikasi_surat' => $klasifikasi_surat,
				'jenis_surat_id' => $jenis_surat_id,
				'jenis_surat' => $jenis_surat,
				'tanggal_register' => $tanggal_register,
				'nomor_index' => $nomor_index,
				'nomor_surat' => $nomor_surat,
				'pengirim_id' => $jabatan_struktural_id,
				'pengirim' => $jabatan_struktural,
				'tujuan_id' => $jenis_tujuan_surat_id,
				'tujuan' => $tujuan,
				'perihal' => $perihal,
				'jenis_ekspedisi_id' => $jenis_pengiriman_id,
				'jenis_ekspedisi' => $jenis_pengiriman,
				'dokumen_elektronik' => $upload_data['file_name'],
				'keterangan' => $keterangan,
				'status_pelaksanaan_id' => "1",
				'status_pelaksanaan' => "Pendaftaran",
				'diinput_oleh' => $this->session->userdata('username'),
				'diinput_tanggal' => date("Y-m-d h:i:s", time())
			);

			$querySimpan = $this->model->simpan_data('register_surat', $data);
		} else {
			$data = array(
				'tujuan_id' => $jenis_tujuan_surat_id,
				'tujuan' => $tujuan,
				'perihal' => $perihal,
				'jenis_ekspedisi_id' => $jenis_pengiriman_id,
				'jenis_ekspedisi' => $jenis_pengiriman,
				'dokumen_elektronik' => $upload_data['file_name'],
				'keterangan' => $keterangan,
				'diperbaharui_oleh' => $this->session->userdata('username'),
				'diperbaharui_tanggal' => date("Y-m-d h:i:s", time()),
				'nomor_surat' => $nomor_surat
			);

			$querySimpan = $this->model->pembaharuan_data('register_surat', $data, 'register_id', $register_id);
		}
		redirect('suratkeluar');
	}


	public function suratkeluar_detil()
	{
		$this->form_validation->set_rules('register_id', 'ID Register', 'trim|required');
		if ($this->form_validation->run() == FALSE) {
			echo json_encode(array('st' => 0, 'msg' => 'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$register_id = $this->encrypt->decode(base64_decode($this->input->post('register_id')));

		$queryRegister = $this->model->get_seleksi('v_suratkeluar', 'register_id', $register_id);
		$tanggal_register = $this->tanggalhelper->convertDayDate($queryRegister->row()->tanggal_register);
		$nomor_surat = $queryRegister->row()->nomor_surat;
		$tujuan_id = $queryRegister->row()->tujuan_id;
		$tujuan = $queryRegister->row()->tujuan;
		$perihal = $queryRegister->row()->perihal;
		$jenis_ekspedisi = $queryRegister->row()->jenis_ekspedisi;
		$dokumen = $queryRegister->row()->dokumen_elektronik;
		$keterangan = $queryRegister->row()->keterangan;
		$tanggal_kirim = (!empty($queryRegister->row()->tanggal_kirim) ? $this->tanggalhelper->convertDayDate($queryRegister->row()->tanggal_kirim) : '');
		$status_pelaksanaan_id = $queryRegister->row()->status_pelaksanaan_id;
		$status_pelaksanaan = $queryRegister->row()->status_pelaksanaan;
		$waktu = $queryRegister->row()->waktu;
		$jabatan_struktural = $queryRegister->row()->pengirim;


		$queryJenisTujuanSurat = $this->model->get_seleksi('ref_tujuan_surat', 'groupid', $tujuan_id);
		$jenis_tujuan_surat = $queryJenisTujuanSurat->row()->name;

		$judul = "DETIL SURAT KELUAR";

		$TombolEditSuratKeluar = '<button onclick="BukaModalEdit(\'' . base64_encode($this->encrypt->encode($register_id)) . '\')" id="TombolEditSuratKeluar" class="btn btn-sm btn-warning btn-block">Edit</button>';
		$TombolPengiriman = '<button onclick="BukaModalPengiriman(\'' . base64_encode($this->encrypt->encode($register_id)) . '\')" id="TombolPengiriman" class="btn btn-sm btn-success btn-block">Kirim</button>';
		$TombolHapus = '<button onclick="HapusSuratKeluar(\'' . base64_encode($this->encrypt->encode($register_id)) . '\')" data-dismiss="modal" class="btn btn-sm btn-danger btn-block">Hapus</button>';

		if (!empty($dokumen)) {
			$TampilDokumenElektronik = '<object id="pdf" height="1024px" width="100%" type="application/pdf" data="' . base_url() . 'dokumen/' . $dokumen . '"><span align="center">Dokumen Elektronik Tidak Tersedia</span></object>';
		} else {
			$TampilDokumenElektronik = '<object id="pdf" width="100%" type="application/pdf" data=""><span align="center">Dokumen Elektronik Tidak Tersedia</span></object>';
		}

		echo json_encode(array(
			'st' => 1,
			'register_id' => base64_encode($this->encrypt->encode($register_id)),
			'tanggal_register' => $tanggal_register,
			'judul' => $judul,
			'nomor_surat' => $nomor_surat,
			'jabatan_struktural' => $jabatan_struktural,
			'tujuan' => $tujuan,
			'tombol_edit_surat_keluar' => $TombolEditSuratKeluar,
			'tombol_kirim_surat_keluar' => $TombolPengiriman,
			'tombol_hapus_surat_keluar' => $TombolHapus,
			'jenis_tujuan_surat' => $jenis_tujuan_surat,
			'perihal' => $perihal,
			'waktu' => $waktu,
			'keterangan' => $keterangan,
			'tanggal_kirim' => $tanggal_kirim,
			'status_pelaksanaan' => $status_pelaksanaan,
			'dokumen_elektronik' => $TampilDokumenElektronik,
			'jenis_ekspedisi' => $jenis_ekspedisi
		));
		return;
	}


	public function suratkeluar_pengiriman()
	{
		$this->form_validation->set_rules('register_id', 'ID Register', 'trim|required');
		if ($this->form_validation->run() == FALSE) {
			echo json_encode(array('st' => 0, 'msg' => 'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$register_id = $this->encrypt->decode(base64_decode($this->input->post('register_id')));

		$queryRegister = $this->model->get_seleksi('v_suratkeluar', 'register_id', $register_id);
		$tanggal_kirim = (!empty($queryRegister->row()->tanggal_kirim) ? $this->tanggalhelper->convertToInputDate($queryRegister->row()->tanggal_kirim) : '');
		$judul = "Tanggal Pengiriman Surat";

		echo json_encode(array(
			'st' => 1,
			'register_id' => base64_encode($this->encrypt->encode($register_id)),
			'judul' => $judul,
			'tanggal_kirim' => $tanggal_kirim
		));
		return;
	}


	public function suratkeluar_pengiriman_simpan()
	{
		$this->form_validation->set_rules('register_id', 'Tanggal Register', 'trim|required');
		$this->form_validation->set_rules('tanggal_kirim', 'Jenis Surat', 'trim|required');
		if ($this->form_validation->run() == FALSE) {
			echo json_encode(array('st' => 0, 'msg' => 'Tidak Berhasil:<br/>' . validation_errors()));
			return;
		}

		$register_id = $this->encrypt->decode(base64_decode($this->input->post('register_id')));
		$tanggal_kirim = $this->tanggalhelper->convertToMysqlDate($this->input->post('tanggal_kirim'));

		$data = array(
			'tanggal_kirim' => $tanggal_kirim,
			'status_pelaksanaan_id' => '2',
			'status_pelaksanaan' => 'Pengiriman',
			'diperbaharui_oleh' => $this->session->userdata('username'),
			'diperbaharui_tanggal' => date("Y-m-d h:i:s", time())
		);

		$querySimpan = $this->model->pembaharuan_data('register_surat', $data, 'register_id', $register_id);
		if ($querySimpan == 1) {
			echo json_encode(array('st' => 1, 'register_id' => base64_encode($this->encrypt->encode($register_id)), 'msg' => 'Simpan Data Pengiriman Surat Berhasil'));
		} else {
			echo json_encode(array('st' => 0, 'msg' => 'Simpan Data Pengiriman Surat Gagal'));
		}
		return;
	}


	public function suratkeluar_hapus()
	{
		$this->form_validation->set_rules('register_id', 'ID Register', 'trim|required');
		if ($this->form_validation->run() == FALSE) {
			echo json_encode(array('st' => 0, 'msg' => 'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$register_id = $this->encrypt->decode(base64_decode($this->input->post('register_id')));

		$queryRegister = $this->model->get_seleksi('v_suratkeluar', 'register_id', $register_id);
		$nomor_surat = $queryRegister->row()->nomor_surat;
		$dokumen = $queryRegister->row()->dokumen_elektronik;
		$tanggal_register = $this->tanggalhelper->convertDayDate($queryRegister->row()->tanggal_register);

		$queryHapus = $this->model->hapus_data('register_surat', 'register_id', $register_id);
		if ($queryHapus == 1) {
			if (!empty($dokumen)) {
				unlink('./dokumen/' . $dokumen);
			}
			echo json_encode(array('st' => 1, 'msg' => 'Data Surat Keluar Nomor ' . $nomor_surat . ', Tanggal Register ' . $tanggal_register . ' <b>BERHASIL DIHAPUS</b>'));
		} else {
			echo json_encode(array('st' => 0, 'msg' => 'Data Surat keluar Nomor ' . $nomor_surat . ', Tanggal Register ' . $tanggal_register . ' <b>GAGAL DIHAPUS</b>'));
		}
		return;
	}
}
