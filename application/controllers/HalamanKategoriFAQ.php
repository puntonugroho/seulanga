<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class HalamanKategoriFAQ extends CI_Controller {
	function __construct() {
        		parent::__construct();
        		$this->load->model('ModelKategoriFAQ','model');
    	}

	public function index(){
		$data['kategori_id'] = base64_encode($this->encrypt->encode('-1'));
		$this->load->view('header');
		$this->load->view('kategori_faq/index',$data);
		$this->load->view('footer');	
	}


	public function kategori_data(){
		$query = $this->model->get_data_kategori_faq();
		$jumlah = $query->num_rows();
		$data = array();
		$no = $_POST['start'];
		foreach ($query->result() as $row) {
			$no++;
			$UserData = array();
			$UserData[] = "<div align='center'>".$no."</div>";
			$UserData[] = $row->nama;
			$UserData[] = "<div align='center'>".($row->aktif==1 ? 'Ya' : 'Tidak')."</div>";
			$UserData[] = '<div align="center"><button type="button" onclick="BukaModal(\''.base64_encode($this->encrypt->encode($row->id)).'\')" class="btn btn-success btn-sm m-r-5">Detil</button></div>';

			$data[] = $UserData;
		}

		$json_data = array(
				"draw" => $_POST['draw'],
				"recordsTotal" => $jumlah,
				"recordsFiltered" => $jumlah,
				"data" => $data,
				);
		echo json_encode($json_data);

	}



	public function kategori_add(){
		$this->form_validation->set_rules('id', 'Data Kategori FAQ', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$id = $this->encrypt->decode(base64_decode($this->input->post('id')));
		
		$aktif = array(''=>"Pilih",'1'=>'Aktif','2'=>'Tidak');
		$nama = "";
	 	if ($id=='-1'){
	 		$tombol_hapus = "";
			$judul = "Tambah Kategori Frequently Asked Questions (FAQ)";
		    $status= form_dropdown('status', $aktif, '', 'class="form-control" style="width:30%;" required id="status"');
		} else {
			$tombol_hapus = '<button onclick="HapusModal()" data-dismiss="modal" class="btn btn-sm btn-danger">Hapus</button>';
			$judul = "Edit Kategori Frequently Asked Questions (FAQ)";
			$query = $this->model->get_data_kategori_faq_id($id);
			$nama = $query->row()->nama;
			$aktif_id = $query->row()->aktif;
			
			$status= form_dropdown('status', $aktif,$aktif_id, 'class="form-control" style="width:30%;" required id="status"');
		}
		echo json_encode(array('st'=>1,
					'tombol_hapus'=>$tombol_hapus,
					'kategori_id'=>base64_encode($this->encrypt->encode($id)),
					'nama'=>$nama, 
					'judul'=>$judul,
					'status'=>$status));
		return;
	}


	public function kategori_simpan(){
		$this->form_validation->set_rules('kategori_id', 'ID Kategori', 'trim|required');
		$this->form_validation->set_rules('kategori', 'Nama Kategori', 'trim|required|min_length[3]|max_length[100]');
		$this->form_validation->set_rules('status', 'Status Kategori', 'trim|required|exact_length[1]|in_list[1,2]');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Tidak Berhasil:<br/>'.validation_errors()));
			return;
		}

		$kategori_id = $this->encrypt->decode(base64_decode($this->input->post('kategori_id')));
		$kategori= $this->input->post('kategori');
		$status= $this->input->post('status');

		if($kategori_id=='-1'){

			$data_faq = array(
				'nama' => $kategori,
				'aktif' => $status
			);

			$query = $this->model->simpan_data_kategori($data_faq);
		} else {
			$data_faq = array(
				'nama' => $kategori,
				'aktif' => $status
			);

			$query = $this->model->update_data_kategori($kategori_id,$data_faq);
		}

		if($query==1){
			echo json_encode(array('st'=>1,'msg'=>'Data Berhasil Disimpan'));
		} else {
			echo json_encode(array('st'=>0,'msg'=>'Data Gagal Disimpan'));
		}
		return;
	}


	public function kategori_hapus(){
		$this->form_validation->set_rules('kategori_id', 'Data Kategori FAQ', 'trim|required');
		if ($this->form_validation->run() == FALSE){
			echo json_encode(array('st'=>0,'msg'=>'Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		}

		$kategori_id = $this->encrypt->decode(base64_decode($this->input->post('kategori_id')));
		
	 	if ($kategori_id=='-1'){
	 		echo json_encode(array('st'=>0,'msg'=>'Dilarang Melakukan Akses Langsung Ke Aplikasi'));
			return;
		} else {
			$cek_query = $this->model->cek_data_faq($kategori_id);
			$jumlah = $cek_query->num_rows();
			if($jumlah==0){
				$query1 = $this->model->get_data_kategori_faq_id($kategori_id);
				$data_faq = array(
					'nama' => $query1->row()->nama,
					'aktif' => $query1->row()->aktif
					);

				$query2 = $this->model->hapus_data_kategori_faq($kategori_id,$data_faq);
				if($query2==TRUE){
					echo json_encode(array('st'=>1,'msg'=>'Data Berhasil Dihapus'));
					return;
				} else {
					echo json_encode(array('st'=>0,'msg'=>'Data Gagal Dihapus'));
					return;
				}
			} else {
				echo json_encode(array('st'=>0,'msg'=>'Tidak Dapat Dihapus, Kategori Digunakan Dalam FAQ'));
				return;
			}
		}
	}




}
