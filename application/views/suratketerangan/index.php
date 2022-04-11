<div id="content" class="content">
	<h1 class="page-header">REGISTER SURAT KETERANGAN</h1>
		<div class="row" id="row">
			<div class="col-md-12">
				<div class="panel panel-inverse">
					<div class="panel-heading">
						<?php
						if(in_array($this->session->userdata('group_id'), $this->session->userdata('kewenangan_suratketerangan'))){ ?>
						<button onclick="BukaModal('<?php echo $register_id; ?>')" class="btn btn-success btn-sm m-r-5">Tambah</button>
						<?php } ?>
						<button onclick="ModalPencarian('<?php echo $register_id; ?>')" class="btn btn-success btn-sm m-r-5">Pencarian Detil</button>
						<button onclick="ModalPeriodeCetakRegister('<?php echo $register_id; ?>')" class="btn btn-success btn-sm m-r-5">Cetak Register</button>
					</div>
					<div class="panel-body">
					<table id="table_suratketerangan" class="table table-striped table-bordered">
						<thead>
							<tr>
								<th width="5%"><div align="center">NO</div></th>
								<th width="20%"><div align="center">JENIS SK</div></th>
								<th width="15%"><div align="center">TANGGAL REGISTER</div></th>
								<th width="15%"><div align="center">NOMOR REGISTER</div></th>
								<th width="25%"><div align="center">PEMOHON</div></th>
								<th width="5%"></th>
							</tr>
						</thead>
					</table>
					</div>
				</div>
			</div>
		</div>
</div>


<div class="modal fade" id="modal_register_surat_keluar">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header"><h4 class="modal-title">PENCATATAN NOMOR REGISTER SURAT KELUAR</h4></div>
			<div class="modal-body">
				<div class="panel-body">
				<form class="form-horizontal">
					<div class="row">
					<div class="form-group">
						<input type="hidden" id="register_id_pencatatan_nomor">
						<label class="col-md-3 control-label">Tanggal Register</label>
						<div class="col-md-9"><input type="text" class="form-control" id="datepicker-default4" style="width: 40%;" /></div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Nomor Register</label>
						<div class="col-md-9"><input type="text" class="form-control" id="nomor_register_surat_keluar" /></div>
					</div>
					<div class="form-group">
						<label class="col-md-12 control-label">
						<font color="red"><b>CATATAN:</b> 
							<br/>Pencatatan Tanggal dan Nomor Register Surat Keluar dilakukan jika Surat Keterangan menggunakan Nomor Register Surat Keluar
						</font>
						</label>
					</div>
					</div>
				</form>
				</div>
			</div>
			<div class="modal-footer">
				<button onclick="TutupModal()" data-dismiss="modal" class="btn btn-sm btn-white">Kembali</button>
				<span id="TombolHapusNomorUmum"></span>
				<button onclick="SimpanModalRegister()" data-dismiss="modal" class="btn btn-sm btn-success">Simpan</button>
			</div>
		</div>
	</div>
</div>


<div class="modal fade" id="modal_pencarian">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header"><h4 class="modal-title">PENCARIAN DETIL</h4></div>
			<div class="modal-body">
				<div class="panel-body">
				<form class="form-horizontal">
					<div class="row">
					<div class="form-group">
						<label class="col-md-3 control-label">Tahun Register</label>
						<div class="col-md-9" id="tahun_register_cari_"></div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Bulan Register</label>
						<div class="col-md-9" id="bulan_register_cari_"></div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Jenis Surat Keterangan</label>
						<div class="col-md-9" id="jenis_suratketerangan_cari_"></div>
					</div>
					</div>
				</form>
				</div>
			</div>
			<div class="modal-footer">
				<button onclick="TutupModal()" data-dismiss="modal" class="btn btn-sm btn-white">Kembali</button>
				<button onclick="CariDetil()" type="submit" class="btn btn-sm btn-success">Cari Detil</button>
			</div>
		</div>
	</div>
</div>


<div class="modal fade" id="modal_periode_cetak_register">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header"><h4 class="modal-title">PERIODE CETAK REGISTER</h4></div>
			<div class="modal-body">
				<div class="panel-body">
				<form class="form-horizontal">
					<div class="row">
					<div class="form-group">
						<label class="col-md-3 control-label">Bulan <font color='red'>*</font></label>
						<div class="col-md-9" id="bulan_register_periode_cetak_"></div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Tahun <font color='red'>*</font></label>
						<div class="col-md-9" id="tahun_register_periode_cetak_"></div>
					</div>
					</div>
				</form>
				</div>
			</div>
			<div class="modal-footer">
					<button onclick="TutupModal()" data-dismiss="modal" class="btn btn-sm btn-white">Kembali</button>
					<button onclick="CetakRegister()" type="submit" class="btn btn-sm btn-success">Cetak</button>
				</div>
		</div>
	</div>
</div>

<div class="modal fade" id="modal_cetak_register">
	<div class="modal-dialog" style="width: 95%;">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">REGISTER SURAT KELUAR</h4><br/>
				<button onclick="TutupModal()" data-dismiss="modal" class="btn btn-sm btn-white">Kembali</button>
				<a href="javascript:void(0);"><button id="printRegisterButton" class="btn btn-sm btn-success">Cetak Register</button></a>
			</div>
			<div class="modal-body printableAreaRegister">
				<table id="data_table_fixed_header" class="table table-striped table-bordered">
					<thead>
					<tr>
						<td width="5%"><div align='center'>NO</div></td>
						<td width="15%"><div align='center'>NOMOR REGISTER</div></td>
						<td width="10%"><div align='center'>TANGGAL REGISTER</div></td>
						<td width="25%"><div align='center'>JENIS SURAT KETERANGAN</div></td>
						<td width="25%"><div align='center'>NAMA PEMOHON</div></td>
						<td width="15%"><div align='center'>ALASAN PERMOHONAN</div></td>
					</tr>
					</thead>
					<tbody id="data_register_suratketerangan"></tbody>
				</table>
			</div>
		</div>
	</div>
</div>



<div class="modal fade" id="modal_dokumenelektronik">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header"><h4 class="modal-title">DOKUMEN ELEKTRONIK</h4></div>
			<div class="modal-body">
				<div class="panel-body">
				<form class="form-horizontal" method="POST" action="<?php echo base_url();?>suratketerangan_dokumen_simpan" enctype="multipart/form-data">
					<div class="row">
					<div class="form-group">
						<input type="hidden" name="register_id" id="register_id_dokumenelektronik">
						<label class="col-md-3 control-label">Dokumen Elektronik</label>
						<div class="col-md-9">
							<input type="file" class="form-control" name="dokumen" id="dokumen"/>
						</div>
					</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button onclick="TutupModal()" data-dismiss="modal" class="btn btn-sm btn-white">Kembali</button>
				<button onclick="SimpanModalRegister()" type="submit" class="btn btn-sm btn-success">Simpan</button>
			</div>
			</form>
		</div>
	</div>
</div>

<div class="modal fade" id="modal_suratketerangan">
<div class="modal-dialog" style="width: 95%;">
	<div class="modal-content">
		<div class="modal-header"><h4 class="modal-title" id="judul"></h4></div>
		<div class="modal-body">
			<div class="panel-body form-horizontal">
			
				<div class="row">
				<div class="col-md-6">
					<div class="form-group">
						<input type="hidden" id="register_id"/>
						<input type="hidden" id="nomor_index"/>
						<label class="col-md-3 control-label">Tanggal Register <font color="red">*</font></label>
						<div class="col-md-9"><input style="width:30%;" type="text" name="tanggal_register" class="form-control" onchange="GenerateNomorRegister()" required id="datepicker-default"/></div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Nomor Register <font color="red">*</font></label>
						<div class="col-md-9"><input type="text" class="form-control" required name="nomor_register" id="nomor_register" style="width: 60%;"/></div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Tanggal Permohonan <font color="red">*</font></label>
						<div class="col-md-9"><input style="width:30%;" type="text" name="tanggal_permohonan" class="form-control" required id="datepicker-default3"/></div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Jenis Surat Keterangan <font color="red">*</font></label>
						<div class="col-md-9" id="jenis_surat_"></div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Jenis Identitas <font color="red">*</font></label>
						<div class="col-md-9" id="jenis_identitas_"></div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Nomor Identitas <font color="red">*</font></label>
						<div class="col-md-9"><input type="text" class="form-control" required name="nomor_identitas" id="nomor_identitas" style="width: 60%;" /></div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Nomor Surat Keterangan Catatan Kepolisian <font color="red">*</font></label>
						<div class="col-md-9"><input type="text" class="form-control" required name="nomor_skck" id="nomor_skck" style="width: 60%;" /></div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Nama Pemohon <font color="red">*</font></label>
						<div class="col-md-9">
							<div class="input-group">
								<input type="text" class="form-control" required name="pemohon_nama" id="pemohon_nama"/>
								<span class="input-group-btn">
								<button type="button" onclick="CekDataPerkara()" class="btn btn-success">Periksa</button>
								</span>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Jenis Kelamin <font color="red">*</font></label>
						<div class="col-md-9" id="jenis_kelamin_"></div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Tempat Lahir <font color="red">*</font></label>
						<div class="col-md-9"><input type="text" class="form-control" required name="pemohon_tempat_lahir" id="pemohon_tempat_lahir"/></div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Tanggal Lahir <font color="red">*</font></label>
						<div class="col-md-9"><input type="text" style="width:30%;" class="form-control" required name="pemohon_tanggal_lahir" id="datepicker-default2"/></div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Alamat <font color="red">*</font></label>
						<div class="col-md-9"><input type="text" class="form-control" required name="pemohon_alamat" id="pemohon_alamat"/></div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Pekerjaan <font color="red">*</font></label>
						<div class="col-md-9"><input type="text" class="form-control" required name="pemohon_pekerjaan" id="pemohon_pekerjaan"/></div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Jabatan Pekerjaan</label>
						<div class="col-md-9"><input type="text" class="form-control" required name="pemohon_jabatan" id="pemohon_jabatan"/></div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Pendidikan <font color="red">*</font></label>
						<div class="col-md-9"><input type="text" class="form-control" required name="pemohon_pendidikan" id="pemohon_pendidikan"/></div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Alasan Permohonan <font color="red">*</font></label>
						<div class="col-md-9"><input type="text" class="form-control" required name="pemohon_alasan" id="pemohon_alasan"/></div>
					</div>
				</div>
				<div class="col-md-6">
					<table id="data_table_fixed_header" class="table table-striped table-bordered">
						<thead>
							<tr>
								<th colspan="2"><div align="center">DATA PIHAK BERPERKARA</div></th>
							</tr>
							<tr>
								<th width="45%"><div align="center">NAMA</div></th>
								<th width="55%"><div align="center">ALAMAT</div></th>
							</tr>
							<tbody id="pihak"></tbody>
						</thead>
					</table>
				</div>
				</div>
				<div class="modal-footer">
					<button onclick="TutupModal()" data-dismiss="modal" class="btn btn-sm btn-white">Kembali</button>
					<button onclick="SimpanModal()" data-dismiss="modal" class="btn btn-sm btn-success">Simpan</button>
				</div>
			</div>
		</div>
</div>
</div>
</div>





<div class="modal fade" id="modal_suratketerangan_detil">
<div class="modal-dialog" style="width: 95%;">
	<div class="modal-content">
		<div class="modal-header"><h4 class="modal-title" id="judul_detil"></h4></div>
		<div class="modal-body">
			<div class="panel-body">
				<div class="col-md-12" style="width:100%;">
					<div class="col-md-11">
						<button onclick="TutupModal()" data-dismiss="modal" class="btn btn-sm btn-white">Kembali</button>
						<span id="tombol_edit_suratketerangan"></span>
						<span id="tombol_umum_suratketerangan"></span>
						<span id="tombol_unggah_suratketerangan"></span>
					</div>
					<div class="col-md-1"><div align='right'><span id="tombol_hapus_suratketerangan"></span></div></div>
					<br/><br/><br/>
					<ul class="nav nav-tabs">
						<li class="active">
							<a href="#default-tab-1" data-toggle="tab">
								<span class="visible-xs">Tab 1</span>
								<span class="hidden-xs">Data Surat Keterangan</span>
							</a>
						</li>
						<li class="">
							<a href="#default-tab-2" data-toggle="tab">
								<span class="visible-xs">Tab 2</span>
								<span class="hidden-xs">Dokumen Elektronik</span>
							</a>
						</li>
					</ul>
			
					<div class="tab-content">
						<div class="tab-pane fade active in" id="default-tab-1">
								<div class="table-responsive">
								<table class="table table-bordered">
									<thead>
										<tr>
											<th width="25%"><div align='center'>TANGGAL REGISTER</div></th>
											<th width="40%"><div align='center'>NOMOR REGISTER </div></th>
											<th width="40%"><div align='center'>NOMOR REGISTER SURAT KELUAR <font color="red">(Jika Tersedia)</font></div></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td><div align='center'><span id=tanggal_register_detil></span></div></td>
											<td><div align='center'><span id=nomor_register_detil></span></div></td>
											<td><div align='center'><span id=nomor_agenda_surat_keluar_detil></span></div></td>
										</tr>
									</tbody>
								</table>
								<table class="table table-hover">
									<tbody>
										<tr>
											<td class="col-md-2">Tanggal Permohonan</td>
											<td class="col-md-1"><b>:</b></td>
											<td class="col-md-9"><span id=tanggal_permohonan_detil></span></td>
										</tr>
										<tr>
											<td class="col-md-2">Jenis Surat Keterangan</td>
											<td class="col-md-1"><b>:</b></td>
											<td class="col-md-9"><span id=jenis_keterangan_detil></span></td>
										</tr>
										<tr>
											<td class="col-md-2">Nomor Identitas</td>
											<td class="col-md-1"><b>:</b></td>
											<td class="col-md-9"><span id=pemohon_identitas_detil></span> - <span id=pemohon_nomor_identitas_detil></span></td>
										</tr>
										<tr>
											<td class="col-md-2">Nomor SKCK</td>
											<td class="col-md-1"><b>:</b></td>
											<td class="col-md-9"><span id=nomor_skck_detil></span></td>
										</tr>
										<tr>
											<td class="col-md-2">Nama</td>
											<td class="col-md-1"><b>:</b></td>
											<td class="col-md-9"><span id=pemohon_nama_detil></span></td>
										</tr>
										<tr>
											<td class="col-md-2">Jenis Kelamin</td>
											<td class="col-md-1"><b>:</b></td>
											<td class="col-md-9"><span id=pemohon_kelamin_detil></span></td>
										</tr>
										<tr>
											<td class="col-md-2">Tempat, Tanggal Lahir</td>
											<td class="col-md-1"><b>:</b></td>
											<td class="col-md-9"><span id=pemohon_tempat_lahir_detil></span>, <span id=pemohon_tanggal_lahir_detil></span></td>
										</tr>
										<tr>
											<td class="col-md-2">Alamat</td>
											<td class="col-md-1"><b>:</b></td>
											<td class="col-md-9"><span id=pemohon_alamat_detil></span></td>
										</tr>
										<tr>
											<td class="col-md-2">Pekerjaan</td>
											<td class="col-md-1"><b>:</b></td>
											<td class="col-md-9"><span id=pemohon_pekerjaan_detil></span></td>
										</tr>
										<tr>
											<td class="col-md-2">Jabatan</td>
											<td class="col-md-1"><b>:</b></td>
											<td class="col-md-9"><span id=pemohon_jabatan_detil></span></td>
										</tr>
										<tr>
											<td class="col-md-2">Pendidikan</td>
											<td class="col-md-1"><b>:</b></td>
											<td class="col-md-9"><span id=pemohon_pendidikan_detil></span></td>
										</tr>
										<tr>
											<td class="col-md-2">Alasan Permohonan SK</td>
											<td class="col-md-1"><b>:</b></td>
											<td class="col-md-9"><span id=pemohon_alasan_detil></span></td>
										</tr>
									</tbody>
								</table>
                            </div>
						</div>
						<div class="tab-pane fade" id="default-tab-2">
							<span id="dokumen_elektronik_detil"></span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</div>


<div class="modal fade" id="modal_penetapan">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header"><h4 class="modal-title">CETAK DOKUMEN SURAT KETERANGAN</h4></div>
			<div class="modal-body">
				<div class="panel-body">
				<table class="table table-hover">
					<tbody>
						<tr>
							<input type="hidden" id="register_id_penetapan">
							<input type="hidden" id="nip_penetapan">
							<td class="col-md-3">Penetapan Oleh</td>
							<td class="col-md-9"><span id="penetapan_"></span></td>
						</tr>
						<tr>
							<td class="col-md-3">Nama</td>
							<td class="col-md-9"><span id="nama_penetap"></span></td>
						</tr>
					</tbody>
				</table>
				</div>
			</div>
			<div class="modal-footer">
				<button onclick="TutupModal()" data-dismiss="modal" class="btn btn-sm btn-white">Kembali</button>
				<span id="tombol_cetak_penetapan"></span>
			</div>
			</form>
		</div>
	</div>
</div>




<script type="text/javascript">
$(document).ready(function() {
	table = $('#table_suratketerangan').DataTable({ 
		"processing": true,
		"serverSide": true,
		"bSort": false,
		"bInfo": false,
		"ajax": {
			"url": "<?php echo base_url()?>suratketerangan_data",
			"type": "POST",
			"data": function ( data ) {
                data.bulan_register_cari = $('#bulan_register_cari').val();
                data.tahun_register_cari = $('#tahun_register_cari').val();
                data.jenis_suratketerangan = $('#jenis_suratketerangan_cari').val();
            }
		},
	});

	$("#printRegisterButton").click(function(){
        var mode = 'iframe';
        var close = mode == "popup";
        var options = { mode : mode, popClose : close};
        $("div.printableAreaRegister").printArea( options );
    });

});



function BukaModalCetak(register_id){
	$.post('<?php echo base_url()?>suratketerangan_penetapan', { 
		register_id:register_id,
	}, function(response){
		var json = jQuery.parseJSON(response);
		if(json.st==1){
			$("#nama_penetap").html("");
			$("#penetapan_").html("");
			$("#tombol_cetak_penetapan").html("");
			$("#register_id_penetapan").val("");
			$("#penetapan_").append(json.penetapan);
			$("#register_id_penetapan").val(json.register_id);
			$("#tombol_cetak_penetapan").append(json.tombol_cetak_penetapan);
			$('#modal_penetapan').modal({ show: true, backdrop: 'static' });
		}else if(json.st==0){
			pesan('PERINGATAN',json.msg,'');
			$('#table_suratketerangan').DataTable().ajax.reload();
		}
	});
}

function CariPenetapanPegawai(){
	var penetapan=$('#penetapan').val();
	var register_id=$('#register_id_penetapan').val();
	if(penetapan==''){ pesan('PERINGATAN','Pilih Penetapan',''); return; }
	if(register_id==''){ pesan('PERINGATAN','Pilih Penetapan #1',''); return; }
	$.post('<?php echo base_url()?>suratketerangan_penetapan_pegawai', { 
		penetapan:penetapan,
		register_id:register_id
	}, function(response){
		var json = jQuery.parseJSON(response);
		if(json.st==1){
			$("#nama_penetap").html("");
			$("#nip_penetapan").val("");
			$("#tombol_cetak_penetapan").html("");
			$("#nip_penetapan").val(json.nip);
			$("#nama_penetap").append(json.nama);
			$("#tombol_cetak_penetapan").append(json.tombol_cetak_penetapan);
		}else if(json.st==0){
			pesan('PERINGATAN',json.msg,'');
			$('#table_suratketerangan').DataTable().ajax.reload();
		}
	});
}


function ModalPeriodeCetakRegister(register_id){
	$.post('<?php echo base_url()?>suratketerangan_periode_cetak', { 
		register_id:register_id,
	}, function(response){
		var json = jQuery.parseJSON(response);
		if(json.st==1){
			$("#bulan_register_periode_cetak_").html("");
			$("#tahun_register_periode_cetak_").html("");
			$("#bulan_register_periode_cetak_").append(json.bulan_register);
			$("#tahun_register_periode_cetak_").append(json.tahun_register);
			$('#modal_periode_cetak_register').modal({ show: true });
		}else if(json.st==0){
			pesan('PERINGATAN',json.msg,'');
			$('#table_suratketerangan').DataTable().ajax.reload();
		}
	});
}

function CetakRegister(){
	var bulan_register_periode=$('#bulan_register_periode').val();
	var tahun_register_periode=$('#tahun_register_periode').val();
	if(bulan_register_periode==''){ pesan('PERINGATAN','Periode Bulan Register Wajib Dipilih',''); return; }
	if(tahun_register_periode==''){ pesan('PERINGATAN','Periode Tahun Register Wajib Dipilih',''); return; }
	$.post('<?php echo base_url()?>suratketerangan_register_cetak', { 
		bulan_register_periode:bulan_register_periode,
		tahun_register_periode:tahun_register_periode
	}, function(response){
		var json = jQuery.parseJSON(response);
		if(json.st==1){
			$('#modal_periode_cetak_register').modal('toggle');
			$("#data_register_suratketerangan").html("");
			$("#data_register_suratketerangan").append(json.register);
			$('#modal_cetak_register').modal({ show: true, backdrop: 'static' });
		}else if(json.st==0){
			pesan('PERINGATAN',json.msg,'');
			$('#table_suratketerangan').DataTable().ajax.reload();
		}
	});
}




function BukaModalPenomoran(register_id){
	$.post('<?php echo base_url()?>suratketerangan_register_umum', { 
		register_id:register_id
	}, function(response){
		var json = jQuery.parseJSON(response);
		if(json.st==1){
			$("#datepicker-default4").val('');
			$("#register_id_pencatatan_nomor").val('');
			$("#nomor_register_surat_keluar").val('');
			$("#TombolHapusNomorUmum").html("");
			$("#datepicker-default4").val(json.tanggal_register);
			$("#register_id_pencatatan_nomor").val(json.register_id);
			$("#nomor_register_surat_keluar").val(json.nomor_register);
			if(json.nomor_register!=''){
				$("#TombolHapusNomorUmum").append(json.tombol_hapus_nomor_umum);
			}
			$('#modal_register_surat_keluar').modal({ show: true, backdrop: 'static' });
		}else if(json.st==0){
			pesan('PERINGATAN',json.msg,'');
			$('#table_suratketerangan').DataTable().ajax.reload();
		}
	});
}

function ModalPencarian(register_id){
	$.post('<?php echo base_url()?>suratketerangan_pencarian', { 
		register_id:register_id,
	}, function(response){
		var json = jQuery.parseJSON(response);
		if(json.st==1){
			$("#tahun_register_cari_").html("");
			$("#jenis_suratketerangan_cari_").html("");
			$("#bulan_register_cari_").html("");
			$("#bulan_register_cari_").append(json.bulan_register);
			$("#tahun_register_cari_").append(json.tahun_register);
			$("#jenis_suratketerangan_cari_").append(json.jenis_surat_keterangan);
			$('#modal_pencarian').modal({ show: true, backdrop: 'static' });
		}else if(json.st==0){
			pesan('PERINGATAN',json.msg,'');
			$('#table_suratkeluar').DataTable().ajax.reload();
		}
	});
}

function CariDetil(){
	$('#modal_pencarian').modal('toggle');
	table.ajax.reload();
}


function BukaModal(register_id){
	$.post('<?php echo base_url()?>suratketerangan_add', { 
		register_id:register_id
	}, function(response){
		var json = jQuery.parseJSON(response);
		if(json.st==1){
			$("#pihak").html('');
			$("#judul").html('');
			$("#register_id").val('');
			$("#datepicker-default").html('');
			$("#datepicker-default3").html('');
			$("#nomor_register").val('');
			$("#jenis_kelamin_").html('');
			$("#jenis_identitas_").html('');
			$("#jenis_surat_").html('');
			$("#nomor_index").val('');
			$("#nomor_index").val(json.nomor_index);
			$("#register_id").val(json.register_id);
			$("#datepicker-default").val(json.tanggal_register);
			$("#datepicker-default3").val(json.tanggal_register);
			$("#nomor_register").val(json.nomor_register);
			$("#nomor_identitas").val(json.pemohon_nomor_identitas);
			$("#pemohon_nama").val(json.pemohon_nama);
			$("#pemohon_tempat_lahir").val(json.pemohon_tempat_lahir);
			$("#datepicker-default2").val(json.pemohon_tanggal_lahir);
			$("#pemohon_pekerjaan").val(json.pemohon_pekerjaan);
			$("#pemohon_jabatan").val(json.pemohon_jabatan);
			$("#pemohon_alamat").val(json.pemohon_alamat);
			$("#pemohon_alasan").val(json.pemohon_alasan);
			$("#nomor_skck").val(json.nomor_skck);
			$("#pemohon_pendidikan").val(json.pemohon_pendidikan);
			$("#judul").append(json.judul);
			$("#jenis_kelamin_").append(json.jenis_kelamin);
			$("#jenis_identitas_").append(json.jenis_identitas);
			$("#jenis_surat_").append(json.jenis_surat_keterangan);
			if(json.judul=='EDIT DATA SURAT KETERANGAN'){
				document.getElementById('datepicker-default').disabled = true;
				document.getElementById('nomor_register').disabled = true;
				document.getElementById('datepicker-default3').disabled = true;
				document.getElementById('jenis_surat_keterangan').disabled = true;
				document.getElementById('jenis_identitas').disabled = true;
				document.getElementById('nomor_identitas').disabled = true;
				document.getElementById('pemohon_nama').disabled = true;
				document.getElementById('nomor_skck').disabled = true;
			} else {
				document.getElementById('datepicker-default').disabled = false;
				document.getElementById('nomor_register').disabled = true;
				document.getElementById('datepicker-default3').disabled = false;
				document.getElementById('jenis_surat_keterangan').disabled = false;
				document.getElementById('jenis_identitas').disabled = false;
				document.getElementById('nomor_identitas').disabled = false;
				document.getElementById('pemohon_nama').disabled = false;
				document.getElementById('nomor_skck').disabled = false;
			}
			$('#modal_suratketerangan').modal({ show: true, backdrop: 'static' });
		}else if(json.st==0){
			pesan('PERINGATAN',json.msg,'');
			$('#table_suratketerangan').DataTable().ajax.reload();
		}
	});	
}


function BukaModalDetil(register_id){
	$.post('<?php echo base_url()?>suratketerangan_detil', { 
		register_id:register_id
	}, function(response){
		var json = jQuery.parseJSON(response);
		if(json.st==1){
			$("#jenis_keterangan_detil").html('');
			$("#tanggal_permohonan_detil").html('');
			$("#tanggal_register_detil").html('');
			$("#nomor_register_detil").html('');
			$("#pemohon_identitas_detil").html('');
			$("#pemohon_nomor_identitas_detil").html('');
			$("#pemohon_nama_detil").html('');
			$("#pemohon_kelamin_detil").html('');
			$("#pemohon_tempat_lahir_detil").html('');
			$("#pemohon_tanggal_lahir_detil").html('');
			$("#pemohon_pekerjaan_detil").html('');
			$("#pemohon_jabatan_detil").html('');
			$("#pemohon_alamat_detil").html('');
			$("#pemohon_alasan_detil").html('');
			$("#nomor_skck_detil").html('');
			$("#pemohon_pendidikan_detil").html('');
			$("#tombol_edit_suratketerangan").html('');
			$("#nomor_agenda_surat_keluar_detil").html('');
			$("#tombol_unggah_suratketerangan").html('');
			$("#tombol_umum_suratketerangan").html('');
			$("#dokumen_elektronik_detil").html('');
			$("#judul_detil").html('');
			$("#tombol_hapus_suratketerangan").html('');
			$("#tombol_hapus_suratketerangan").append(json.TombolHapus);
			$("#judul_detil").append(json.judul);
			$("#dokumen_elektronik_detil").append(json.dokumen_suratketerangan);
			$("#tombol_umum_suratketerangan").append(json.tombol_umum_suratketerangan);
			$("#tombol_unggah_suratketerangan").append(json.tombol_unggah_suratketerangan);
			$("#nomor_agenda_surat_keluar_detil").append(json.nomor_agenda_surat_keluar);
			$("#tombol_edit_suratketerangan").append(json.tombol_edit_suratketerangan);
			$("#jenis_keterangan_detil").append(json.jenis_keterangan);
			$("#tanggal_permohonan_detil").append(json.tanggal_permohonan);
			$("#tanggal_register_detil").append(json.tanggal_register);
			$("#nomor_register_detil").append(json.nomor_register);
			$("#pemohon_identitas_detil").append(json.pemohon_identitas);
			$("#pemohon_nomor_identitas_detil").append(json.pemohon_nomor_identitas);
			$("#pemohon_nama_detil").append(json.pemohon_nama);
			$("#pemohon_kelamin_detil").append(json.pemohon_kelamin);
			$("#pemohon_tempat_lahir_detil").append(json.pemohon_tempat_lahir);
			$("#pemohon_tanggal_lahir_detil").append(json.pemohon_tanggal_lahir);
			$("#pemohon_pekerjaan_detil").append(json.pemohon_pekerjaan);
			$("#pemohon_jabatan_detil").append(json.pemohon_jabatan);
			$("#pemohon_alamat_detil").append(json.pemohon_alamat);
			$("#pemohon_alasan_detil").append(json.pemohon_alasan);
			$("#nomor_skck_detil").append(json.nomor_skck);
			$("#pemohon_pendidikan_detil").append(json.pemohon_pendidikan);
			$('#modal_suratketerangan_detil').modal({ show: true, backdrop: 'static' });
		}else if(json.st==0){
			pesan('PERINGATAN',json.msg,'');
			$('#table_suratketerangan').DataTable().ajax.reload();
		}
	});	
}

function CekDataPerkara(){
	var pemohon_nama=$('#pemohon_nama').val();
	var jenis_surat_keterangan=$('#jenis_surat_keterangan').val();

	if(pemohon_nama==''){ pesan('PERINGATAN','Nama Pemohon Belum Diisi',''); return; }
	if(jenis_surat_keterangan==''){ pesan('PERINGATAN','Jenis Surat Keterangan Belum Dipilih',''); return; }

	$.post('<?php echo base_url()?>suratketerangan_data_perkara', { 
		pemohon_nama:pemohon_nama,
		jenis_surat_keterangan:jenis_surat_keterangan
	}, function(response){
		var json = jQuery.parseJSON(response);
		if(json.st==1){
			$("#pihak").html('');
			$("#pihak").append(json.pihak);
		}else if(json.st==0){
			pesan('PERINGATAN',json.msg,'');
			$('#table_suratketerangan').DataTable().ajax.reload();
		}
	});	
}

function GenerateNomorRegister(){
	var tanggal_register=$('#datepicker-default').val();
	if(tanggal_register!=''){
		$.post('<?php echo base_url()?>suratketerangan_generate_nomor', { 
			tanggal_register:tanggal_register
		}, function(response){
			var json = jQuery.parseJSON(response);
			if(json.st==1){
				$("#nomor_register").val('');
				$("#nomor_register").val(json.nomor_register);
			}else if(json.st==0){
				pesan('PERINGATAN',json.msg,'');
				$('#table_suratketerangan').DataTable().ajax.reload();
			}
		});	
	}
}


function SimpanModal(){
	var register_id=$('#register_id').val();
	var nomor_index=$('#nomor_index').val();
	var tanggal_register=$('#datepicker-default').val();
	var tanggal_permohonan=$('#datepicker-default3').val();
	var nomor_register=$('#nomor_register').val();
	var jenis_surat_keterangan=$('#jenis_surat_keterangan').val();
	var jenis_identitas=$('#jenis_identitas').val();
	var nomor_identitas=$('#nomor_identitas').val();
	var pemohon_nama=$('#pemohon_nama').val();
	var jenis_kelamin=$('#jenis_kelamin').val();
	var pemohon_tempat_lahir=$('#pemohon_tempat_lahir').val();
	var pemohon_tanggal_lahir=$('#datepicker-default2').val();
	var pemohon_alamat=$('#pemohon_alamat').val();
	var pemohon_pekerjaan=$('#pemohon_pekerjaan').val();
	var pemohon_jabatan=$('#pemohon_jabatan').val();
	var nomor_skck=$('#nomor_skck').val();
	var pemohon_pendidikan=$('#pemohon_pendidikan').val();
	var pemohon_alasan=$('#pemohon_alasan').val();
	
	if(nomor_register==''){ pesan('PERINGATAN','Nomor Register Wajib Diisi',''); return; }
	if(tanggal_register==''){ pesan('PERINGATAN','Periode Tanggal Register Wajib Diisi',''); return; }
	if(tanggal_permohonan==''){ pesan('PERINGATAN','Periode Tanggal Permohonan Wajib Diisi',''); return; }
	if(jenis_surat_keterangan==''){ pesan('PERINGATAN','Jenis Surat Keterangan Wajib Dipilih',''); return; }
	if(jenis_identitas==''){ pesan('PERINGATAN','Jenis Identitas Pemohon Wajib Dipilih',''); return; }
	if(nomor_identitas==''){ pesan('PERINGATAN','Nomor Identitas Wajib Diisi',''); return; }
	if(pemohon_nama==''){ pesan('PERINGATAN','Nama Pemohon Wajib Diisi',''); return; }
	if(jenis_kelamin==''){ pesan('PERINGATAN','Jenis Kelamin Pemohon Wajib Dipilih',''); return; }
	if(pemohon_tempat_lahir==''){ pesan('PERINGATAN','Tempat Lahir Pemohon Wajib Diisi',''); return; }
	if(pemohon_tanggal_lahir==''){ pesan('PERINGATAN','Tanggal Lahir Pemohon Wajib Diisi',''); return; }
	if(pemohon_alamat==''){ pesan('PERINGATAN','Alamat Pemohon Wajib Diisi',''); return; }
	if(pemohon_pekerjaan==''){ pesan('PERINGATAN','Pekerjaan Pemohon Wajib Diisi',''); return; }
	if(nomor_skck==''){ pesan('PERINGATAN','Nomor Surat Keterangan Catatan Kepolisian (SKCK) Wajib Diisi',''); return; }
	if(pemohon_pendidikan==''){ pesan('PERINGATAN','Pendidikan Pemohon Wajib Diisi',''); return; }
	if(pemohon_alasan==''){ pesan('PERINGATAN','Alasan Permohonan Surat Keterangan Wajib Diisi',''); return; }

	$.post('<?php echo base_url()?>suratketerangan_simpan', { 
		register_id:register_id,
		nomor_index:nomor_index,
		nomor_register:nomor_register,
		tanggal_register:tanggal_register,
		tanggal_permohonan:tanggal_permohonan,
		jenis_surat_keterangan:jenis_surat_keterangan,
		jenis_identitas:jenis_identitas,
		nomor_identitas:nomor_identitas,
		pemohon_nama:pemohon_nama,
		jenis_kelamin:jenis_kelamin,
		pemohon_tempat_lahir:pemohon_tempat_lahir,
		pemohon_tanggal_lahir:pemohon_tanggal_lahir,
		pemohon_alamat:pemohon_alamat,
		pemohon_pekerjaan:pemohon_pekerjaan,
		pemohon_jabatan:pemohon_jabatan,
		pemohon_pendidikan:pemohon_pendidikan,
		nomor_skck:nomor_skck,
		pemohon_alasan:pemohon_alasan

	}, function(response){
		var json = jQuery.parseJSON(response);
		if(json.st==1){
			$('#table_suratketerangan').DataTable().ajax.reload();
			if(json.register_id!=""){
				BukaModalDetil(json.register_id);
			}
			pesan('INFORMASI',json.msg,'');
		}else if(json.st==0){

			pesan('PERINGATAN',json.msg,'');
			$('#table_suratketerangan').DataTable().ajax.reload();
		}
	});	
}

function SimpanModalRegister(){
	var register_id=$('#register_id_pencatatan_nomor').val();
	var tanggal_register=$('#datepicker-default4').val();
	var nomor_register=$('#nomor_register_surat_keluar').val();
	if(nomor_register==''){ pesan('PERINGATAN','Nomor Register Wajib Diisi',''); return; }
	if(tanggal_register==''){ pesan('PERINGATAN','Periode Tanggal Register Wajib Diisi',''); return; }
	$.post('<?php echo base_url()?>suratketerangan_register_umum_simpan', { 
		register_id:register_id,
		tanggal_register:tanggal_register,
		nomor_register:nomor_register
	}, function(response){
		var json = jQuery.parseJSON(response);
		if(json.st==1){
			$('#modal_register_surat_keluar').modal('toggle');
			$('#table_suratketerangan').DataTable().ajax.reload();
			pesan('INFORMASI',json.msg,'');
			BukaModalDetil(json.register_id);
		}else if(json.st==0){
			pesan('PERINGATAN',json.msg,'');
			$('#table_suratketerangan').DataTable().ajax.reload();
		}
	});	
}

function TutupModal(){
	$('#table_suratketerangan').DataTable().ajax.reload();
}


function BukaModalUpload(register_id){
	$("#register_id_dokumenelektronik").val('');
	$("#register_id_dokumenelektronik").val(register_id);
	$('#modal_dokumenelektronik').modal({ show: true, backdrop: 'static' });
}

function CetakDokumen(register_id){
	var penetapan=$('#penetapan').val();
	window.open('<?php echo base_url();?>suratketerangan_cetak/'+register_id+'/'+penetapan+'','_self')
}


function HapusRegisterUmum(register_id){
	$.post('<?php echo base_url()?>suratketerangan_register_umum_hapus', { 
		register_id:register_id
	}, function(response){
		var json = jQuery.parseJSON(response);
		if(json.st==1){
			$('#table_suratketerangan').DataTable().ajax.reload();
			if(json.register_id!=''){
				BukaModalDetil(json.register_id);
			}
			pesan('INFORMASI',json.msg,'');
		}else if(json.st==0){
			$('#table_suratketerangan').DataTable().ajax.reload();
			pesan('PERINGATAN',json.msg,'');
		}
	});
}


function HapusSuratKeterangan(register_id){
	$.post('<?php echo base_url()?>suratketerangan_hapus', { 
		register_id:register_id
	}, function(response){
		var json = jQuery.parseJSON(response);
		if(json.st==1){
			$('#table_suratketerangan').DataTable().ajax.reload();
			pesan('INFORMASI',json.msg,'');
		}else if(json.st==0){
			$('#table_suratketerangan').DataTable().ajax.reload();
			pesan('PERINGATAN',json.msg,'');
		}
	});
}


document.getElementById('dokumen').addEventListener('change', checkFile, false);
dokumen.addEventListener('change', checkFile, false);
function checkFile(e) {
    var file_list = e.target.files;
    for (var i = 0, file; file = file_list[i]; i++) {
        var sFileName = file.name;
        var sFileExtension = sFileName.split('.')[sFileName.split('.').length - 1].toLowerCase();
        var iFileSize = file.size;
        var iConvert = (file.size / 10485760).toFixed(2);

        if (!(sFileExtension === "pdf") || iFileSize > 10485760) {
            txt = "Jenis File : " + sFileExtension + "<br/><br/>";
            txt += "Ukuran: " + iConvert + " MB <br/><br/>";
            txt += "Pastikan Format Dokumen pdf dengan ukuran maksimal 10MB.\n\n";
            pesan('PERINGATAN',txt,'');
            $("#dokumen").val("");
        }
    }
}
</script>
