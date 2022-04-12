<?php
defined('BASEPATH') or exit('No direct script access allowed');

class HalamanUtama extends CI_Controller
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
		$this->load->model('ModelUtama', 'model');
		$this->load->helper('telebot_helper');
		$queryCek = $this->model->get_seleksi('sys_user_online', 'id', $this->session->userdata('login_id'));
		if (($queryCek->row()->host_address != $this->input->ip_address()) && ($queryCek->row()->userid != $this->session->userdata('userid')) && ($queryCek->row()->user_agent != $this->input->user_agent())) {
			redirect('keluar');
		}
	}


	public function index()
	{
		$tahun_register = date("Y");
		$query1 = $this->model->get_seleksi('v_suratmasuk', 'tahun_register', $tahun_register);
		$query2 = $this->model->get_seleksi('v_suratkeluar', 'tahun_register', $tahun_register);
		$query3 = $this->model->get_seleksi('register_surat_keterangan', 'tahun_register', $tahun_register);

		$data['jumlahSuratMasuk'] = $query1->num_rows();
		$data['jumlahSuratKeluar'] = $query2->num_rows();
		$data['jumlahSuratKeterangan'] = $query3->num_rows();
		$data['tahun'] = $tahun_register;

		$data['tanggal_pelaksanaan'] = date("d/m/Y");

		$userid = $this->session->userdata('userid');
		$queryPegawai = $this->model->get_seleksi('v_users', 'userid', $userid);
		$pegawai_id = $queryPegawai->row()->pegawai_id;

		$group_id = $this->session->userdata('group_id');
		$data['group_id'] = $this->session->userdata('group_id');

		if ($group_id == '2' || $group_id == '3' || $group_id == '4' || $group_id == '5' || $group_id == '6' || $group_id == '7' || $group_id == '8' || $group_id == '16' || $group_id == '17' || $group_id == '18' || $group_id == '19' || $group_id == '31' || $group_id == '32') {
			$data['queryRegister'] = $this->model->get_seleksi_pertama($group_id);
		} else {
			$data['queryRegister'] = $this->model->get_seleksi2('v_suratmasuk', 'tujuan_disposisi_id', $pegawai_id, 'status_pelaksanaan_id<>', '20');
		}

		$data['queryPelaksanaanSK'] = $this->model->get_data('v_pelaksanaan_suratmasuk');
		$data['queryPelaksanaanSM'] = $this->model->get_data('v_pelaksanaan_suratkeluar');

		$this->load->view('header');
		$this->load->view('halamanutama/index', $data);
		$this->load->view('halamanutama/footer');
	}

	public function dashboard_modal_disposisi()
	{
		$this->form_validation->set_rules('register_id', 'ID Register', 'trim|required');
		if ($this->form_validation->run() == FALSE) {
			echo json_encode(array('st' => 0, 'msg' => 'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		if ($this->encrypt->decode(base64_decode($this->input->post('register_id'))) == '-1') {
			echo json_encode(array('st' => 0, 'msg' => 'Anda Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$register_id = $this->encrypt->decode(base64_decode($this->input->post('register_id')));


		$queryRegister = $this->model->get_seleksi('v_suratmasuk', 'register_id', $register_id);
		$tanggal_register = $this->tanggalhelper->convertDayDate($queryRegister->row()->tanggal_register);
		$tanggal_surat = $this->tanggalhelper->convertDayDate($queryRegister->row()->tanggal_surat);
		$nomor_surat = $queryRegister->row()->nomor_surat;
		$pengirim = $queryRegister->row()->pengirim;
		$tujuan = $queryRegister->row()->tujuan;
		$perihal = $queryRegister->row()->perihal;
		$dokumen_elektronik = $queryRegister->row()->dokumen_elektronik;

		$group_id = $this->session->userdata('group_id');

		// if ($group_id == '2' || $group_id == '3') {
		// 	$queryJabatan = $this->model->get_data('v_groups_struktural');

		// } else {
		// 	$queryJabatan = $this->model->get_data('v_groups');
		// }
		$queryJabatan = $this->model->get_data('v_groups_with_name');

		$arrayJabatan = array();
		$arrayJabatan[''] = "Pilih";
		foreach ($queryJabatan->result() as $row) {
			// if ($group_id == '2' || $group_id == '3') {
			// 	$arrayJabatan[$row->groupid] = (!empty($row->nama) ? $row->group_name . ' -  [ ' . $row->nama . ' ]' : "<strike>" . $row->group_name . '</strike> -  [ Pegawai Belum Didaftarkan ke Sistem ]');
			// } else {
			// $arrayJabatan[$row->group_id] = $row->group_name;
			// }
			if ((!empty($row->nama))) {
				$arrayJabatan[$row->group_id] = $row->group_name;
			}
		}

		if ($group_id == '2' || $group_id == '3') {
			$array_pelaksanaan = array('' => 'Pilih', '10' => 'Disposisi', '20' => 'Dilaksanakan');
			$jabatan = form_dropdown('jabatan', $arrayJabatan, '', 'class="form-control" id="jabatan"');
		} else {
			$array_pelaksanaan = array('' => 'Pilih', '10' => 'Disposisi', '20' => 'Dilaksanakan', '30' => 'Diteruskan');
			$jabatan = form_dropdown('jabatan', $arrayJabatan, '', 'class="form-control" onChange="TampilPegawai()" id="jabatan"');
		}
		$jenis_pelaksanaan = form_dropdown('jenis_pelaksanaan', $array_pelaksanaan, '', 'class="form-control" required id="jenis_pelaksanaan" onChange="JenisPelaksanaan()"');


		if ($group_id == '2' || $group_id == '3') {
			$judul_tanggal = "TANGGAL DISPOSISI";
			$judul_pelimpahan = "DISPOSISI KEPADA";
			$judul_modal = "DISPOSISI";
		} else {
			$judul_tanggal = "TANGGAL PELAKSANAAN";
			$judul_pelimpahan = "JABATAN";
			$judul_modal = "DISPOSISI / PELAKSANAAN";
		}


		if (!empty($dokumen_elektronik)) {
			//$TampilDokumenElektronik = '<object id="pdf" height="640px" width="100%" type="application/pdf" data="'.base_url().'dokumen/'.$dokumen_elektronik.'"><span align="center"></span></object>';
			$TampilDokumenElektronik = '<iframe src = "' . base_url() . '/ViewerJS/#../dokumen/' . $dokumen_elektronik . '" width="100%" height="640" allowfullscreen webkitallowfullscreen></iframe>';
		} else {
			$TampilDokumenElektronik = '<object id="pdf" height="640px" width="100%" type="application/pdf" data=""><span align="center">Dokumen Elektronik Tidak Tersedia</span></object>';
		}

		$tanggal_pelaksanaan = date("d/m/Y");

		echo json_encode(array(
			'st' => 1,
			'register_id' => base64_encode($this->encrypt->encode($register_id)),
			'tanggal_register' => $tanggal_register,
			'tanggal_surat' => $tanggal_surat,
			'nomor_surat' => $nomor_surat,
			'pengirim' => $pengirim,
			'group_id' => $group_id,
			'judul_tanggal' => $judul_tanggal,
			'judul_pelimpahan' => $judul_pelimpahan,
			'jenis_pelaksanaan' => $jenis_pelaksanaan,
			'tujuan' => $tujuan,
			'judul_modal' => $judul_modal,
			'perihal' => $perihal,
			'jabatan' => $jabatan,
			'tanggal_pelaksanaan' => $tanggal_pelaksanaan,
			'TampilDokumenElektronik' => $TampilDokumenElektronik
		));
		return;
	}


	public function dashboard_modal_pegawai()
	{
		$this->form_validation->set_rules('jabatan', 'Data Jabatan', 'trim|required');
		if ($this->form_validation->run() == FALSE) {
			echo json_encode(array('st' => 0, 'msg' => 'Tidak Berhasil:<br/>' . validation_errors()));
			return;
		}

		$jabatan_id = $this->input->post('jabatan');

		$queryPegawai = $this->model->get_seleksi2('pegawai', 'aktif', 'Y', 'jabatan_id', $jabatan_id);
		$arrayPegawai = array();
		$arrayPegawai[''] = "Pilih";
		foreach ($queryPegawai->result() as $row) {
			$arrayPegawai[$row->id] = $row->nama_gelar;
		}

		$pegawai = form_dropdown('pegawai', $arrayPegawai, '', 'class="form-control" required id="pegawai"');
		echo json_encode(array('st' => 1, 'pegawai' => $pegawai));
		return;
	}

	private function sendTeleMessage($telegram_id, $message_text, $secret_token)
	{
		$url = "https://api.telegram.org/bot" . $secret_token . "/sendMessage?parse_mode=markdown&chat_id=" . $telegram_id;
		$url = $url . "&text=" . urlencode($message_text);
		$ch = curl_init();
		$optArray = array(
			CURLOPT_URL => $url,
			CURLOPT_RETURNTRANSFER => true
		);
		curl_setopt_array($ch, $optArray);
		$result = curl_exec($ch);
		$err = curl_error($ch);
		curl_close($ch);

		if ($err) {
			return $err;
		} else {
			return 'sukses';
		}
	}

	public function dashboard_simpan_disposisi()
	{
		$this->form_validation->set_rules('register_id', 'Data Surat Masuk', 'trim|required');
		$this->form_validation->set_rules('group_id', 'Data Pengguna', 'trim|required');
		$this->form_validation->set_rules('tanggal_pelaksanaan', 'Tanggal Pelaksanaan', 'trim|required');
		$this->form_validation->set_rules('jenis_pelaksanaan', 'Jenis Pelaksanaan', 'trim|required');
		$this->form_validation->set_rules('keterangan_pelaksanaan', 'Keterangan Pelaksanaan', 'trim');
		if ($this->form_validation->run() == FALSE) {
			echo json_encode(array('st' => 0, 'msg' => 'Tidak Berhasil:<br/>' . validation_errors()));
			return;
		}

		// $telebot_secret_token = '5064305861:AAFMuCLDvU49EBvSoFsNMJQKzsmYer0OMPI';
		$register_id = $this->encrypt->decode(base64_decode($this->input->post('register_id')));
		$group_id = $this->input->post('group_id');
		$tanggal_pelaksanaan = $this->tanggalhelper->convertToMysqlDate($this->input->post('tanggal_pelaksanaan'));
		$jenis_pelaksanaan_id = $this->input->post('jenis_pelaksanaan');
		$keterangan = $this->input->post('keterangan_pelaksanaan');

		if ($jenis_pelaksanaan_id == '10') {
			$jenis_pelaksanaan = "Disposisi";
		} else if ($jenis_pelaksanaan_id == '20') {
			$jenis_pelaksanaan = "Dilaksanakan";
		} else {
			$jenis_pelaksanaan = "Diteruskan";
		}


		$kepada_jabatan_id = "";
		$kepada_userid = "";
		$kepada_jabatan = "";
		$kepada_fullname = "";
		if ($jenis_pelaksanaan_id == '10' || $jenis_pelaksanaan_id == '30') {

			if ($group_id == '2' || $group_id == '3') {
				$this->form_validation->set_rules('jabatan', 'Jabatan Tujuan Disposisi', 'trim|required');
				if ($this->form_validation->run() == FALSE) {
					echo json_encode(array('st' => 0, 'msg' => 'Tidak Berhasil:<br/>' . validation_errors()));
					return;
				}

				$kepada_jabatan_id = $this->input->post('jabatan');

				$queryJabatanTujuan = $this->model->get_seleksi('sys_groups', 'groupid', $kepada_jabatan_id);
				$kepada_jabatan = $queryJabatanTujuan->row()->name;

				$queryPegawaiTujuan = $this->model->get_seleksi2('pegawai', 'aktif', 'Y', 'jabatan_id', $kepada_jabatan_id);
				$kepada_fullname = $queryPegawaiTujuan->row()->nama_gelar;
				$kepada_userid = $queryPegawaiTujuan->row()->id;
			} else {
				$this->form_validation->set_rules('jabatan', 'Jabatan Tujuan Disposisi', 'trim|required');
				$this->form_validation->set_rules('pegawai', 'Pegawai Tujuan Disposisi', 'trim|required');
				if ($this->form_validation->run() == FALSE) {
					echo json_encode(array('st' => 0, 'msg' => 'Tidak Berhasil:<br/>' . validation_errors()));
					return;
				}

				$kepada_jabatan_id = $this->input->post('jabatan');
				$kepada_userid = $this->input->post('pegawai');

				$queryJabatanTujuan = $this->model->get_seleksi('sys_groups', 'groupid', $kepada_jabatan_id);
				$kepada_jabatan = $queryJabatanTujuan->row()->name;

				$queryPegawaiTujuan = $this->model->get_seleksi('pegawai', 'id', $kepada_userid);
				$kepada_fullname = $queryPegawaiTujuan->row()->nama_gelar;
			}
		}

		$userid = $this->session->userdata('userid');
		$queryPengguna = $this->model->get_seleksi('v_users', 'userid', $userid);
		$dari_userid = $queryPengguna->row()->pegawai_id;
		$dari_fullname = $queryPengguna->row()->fullname;
		$dari_jabatan_id = $queryPengguna->row()->group_id;
		$dari_jabatan = $queryPengguna->row()->group_name;
		$queryRegister = $this->model->get_seleksi('v_suratmasuk', 'register_id', $register_id);
		$tanggal_surat = $this->tanggalhelper->convertDayDate($queryRegister->row()->tanggal_surat);
		$nomor_surat = $queryRegister->row()->nomor_surat;

		$data = array(
			'register_id' => $register_id,
			'jenis_pelaksanaan_id' => $jenis_pelaksanaan_id,
			'jenis_pelaksanaan' => $jenis_pelaksanaan,
			'tanggal_pelaksanaan' => $tanggal_pelaksanaan,
			'dari_userid' => $dari_userid,
			'dari_fullname' => $dari_fullname,
			'dari_jabatan_id' => $dari_jabatan_id,
			'dari_jabatan' => $dari_jabatan,
			'kepada_userid' => $kepada_userid,
			'kepada_fullname' => $kepada_fullname,
			'kepada_jabatan_id' => $kepada_jabatan_id,
			'kepada_jabatan' => $kepada_jabatan,
			'keterangan' => $keterangan,
			'diinput_oleh' => $this->session->userdata('username'),
			'diinput_tanggal' => date("Y-m-d h:i:s", time())
		);

		$querySimpan = $this->model->simpan_data('register_pelaksanaan', $data);
		if ($jenis_pelaksanaan_id == '10') {
			$message_text = "Sdr. " . $kepada_fullname . " Anda Menerima Disposisi Surat Nomor : "
				. $nomor_surat . " tanggal " . $tanggal_surat . " dari " . $dari_jabatan . " " . $dari_fullname .
				". Mohon agar segera ditindaklanjuti, Terima Kasih.";
		} else if ($jenis_pelaksanaan_id == '30') {
			$message_text = "Sdr. " . $kepada_fullname . " Anda Menerima Terusan Surat Nomor : "
				. $nomor_surat . " tanggal " . $tanggal_surat . " dari " . $dari_jabatan . " " . $dari_fullname .
				". Mohon agar segera ditindaklanjuti, Terima Kasih.";
		}
		if ($jenis_pelaksanaan_id == '20') {
			if ($querySimpan == 1) {
				$data_status = array('status_pelaksanaan_id' => $jenis_pelaksanaan_id, 'status_pelaksanaan' => $jenis_pelaksanaan);
				$queryUpdate = $this->model->pembaharuan_data('register_surat', $data_status, 'register_id', $register_id);
				echo json_encode(array('st' => 1, 'msg' => 'Disposisi Berhasil dikirim'));
			} else {
				echo json_encode(array('st' => 1, 'msg' => 'Simpan Data Disposisi Gagal'));
			}
		} else {
			$telegram_id = (is_null($queryPegawaiTujuan->row()->chatid) ? '' : $queryPegawaiTujuan->row()->chatid);
			if ($querySimpan == 1) {
				$data_status = array('status_pelaksanaan_id' => $jenis_pelaksanaan_id, 'status_pelaksanaan' => $jenis_pelaksanaan);
				$queryUpdate = $this->model->pembaharuan_data('register_surat', $data_status, 'register_id', $register_id);
				if($telegram_id != ''){
					kirimNotifikasiTelegram($telegram_id, $message_text);
				}
				echo json_encode(array('st' => 1, 'msg' => 'Disposisi Berhasil dikirim'));
			} else {
				echo json_encode(array('st' => 1, 'msg' => 'Simpan Data Disposisi Gagal'));
			}
		}
		return;
	}
}
