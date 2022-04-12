<div class="container-fluid page-body-wrapper">
	<div class="main-panel">
		<div class="content-wrapper">
			<div class="card">
				<div class="card-body">
					<div class="row">
						<div class="col-md-8">
							<h4 class="card-title">JENIS SURAT KETERANGAN</h4>
						</div>
						<div class="col-md-2" style="display: flex; flex-direction: row;justify-content: center;align-items:center;margin-top:-3px;margin-bottom:5px;margin-left:211px">
								<?php if (in_array($this->session->userdata('group_id'), $this->session->userdata('kewenangan_persuratan'))) { ?>
									<button onclick="BukaModal('<?php echo $register_id; ?>')" class="btn btn-primary btn-sm mr-2 btn-block">Tambah Baru</button>
								<?php } ?>
						</div>
					</div>
					<div class="row">
						<div class="col-12">
							<div class="table-responsive">
								<table id="table_suratketerangan" class="table">
									<thead>
										<tr>
											<th>NO</th>
											<th>KODE</th>
											<th>NAMA</th>
											<th>AKTIF</th>
											<th>AKSI</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- partial:partials/_footer.html -->
		<footer class="footer">
			<div class="footer-wrap">
				<div class="d-sm-flex justify-content-center justify-content-sm-between">
					<span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright © <a href="https://www.ms-aceh.go.id/" target="_blank">MS Aceh </a>2022</span>
					<span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center">MAHKAMAH SYAR'IYAH ACEH </span>
				</div>
			</div>
		</footer>
		<!-- partial -->
	</div>
</div>

<!-- #modal-dialog -->
<div class="modal fade" id="modal_jenissuratketerangan">
<div class="modal-dialog">
	<div class="modal-content">
			<div class="modal-header"><h4 class="modal-title" id="judul"></h4></div>
			<div class="modal-body">
				<div class="panel-body">
				<form class="form-horizontal" method="POST" action="<?php echo base_url();?>jenissuratketerangan_simpan" enctype="multipart/form-data">
					<div class="form-group">
						<input type="hidden" name="id" id="id"/>
						<label class="col-md-3 control-label">Kode <font color="red">*</font></label>
						<div class="col-md-9"><input type="text" style="width:30%;" name="kode" class="form-control" required id="kode"/></div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Jenis Surat Keterangan <font color="red">*</font></label>
						<div class="col-md-9"><input type="text" name="nama" class="form-control" required id="nama"/></div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Pemeriksaan Pada Register <font color="red">*</font></label>
						<div class="col-md-9" style="width: 30%;"><span id="register_"></span></div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Aktif <font color="red">*</font></label>
						<div class="col-md-9" style="width: 30%;"><span id="aktif_"></span></div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Dokumen Elektronik</label>
						<div class="col-md-9">
							<b><span id="dokumen_"></span></b>
							<input type="file" class="form-control" name="dokumen" id="dokumen"/>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button onclick="TutupModal()" data-dismiss="modal" class="btn btn-sm btn-white">Kembali</button>
					<button type="submit" class="btn btn-sm btn-success">Simpan</button>
				</div>
				</form>
			</div>
		</div>
</div>
</div>
</div>

<!-- main-panel ends -->
</div>
</div>
<script src="<?php echo base_url(); ?>assets/js/base.js"></script>
<script src="<?php echo base_url(); ?>assets/js/hoverable-collapse.js"></script>
<script src="<?php echo base_url(); ?>assets/js/off-canvas.js"></script>
<script src="<?php echo base_url(); ?>assets/js/template.js"></script>
<script src="<?php echo base_url(); ?>assets/js/settings.js"></script>
<script src="<?php echo base_url(); ?>assets/js/todolist.js"></script>
<script src="<?php echo base_url(); ?>assets/js/jquery.cookie.js"></script>
<script src="<?php echo base_url(); ?>assets/js/profile-settings.js"></script>
<script src="<?php echo base_url(); ?>assets/js/bootstrap-datepicker.min.js"></script>
<script src="<?php echo base_url(); ?>assets/js/moment.min.js"></script>
<script src="<?php echo base_url(); ?>assets/js/formpickers.js"></script>
<script src="<?php echo base_url(); ?>assets/js/jquery.dataTables.js"></script>
<script src="<?php echo base_url(); ?>assets/js/dataTables.bootstrap4.js"></script>
<script src="<?php echo base_url(); ?>assets/js/data-table.js"></script>
<script src="<?php echo base_url(); ?>assets/js/gritter/js/jquery.gritter.js"></script>
<script src="<?php echo base_url(); ?>assets/js/sweetalert.js"></script>
<!-- <script src="<?php echo base_url(); ?>assets/js/ui-modal-notification.demo.js"></script> -->
<script src="<?php echo base_url(); ?>assets/js/jquery.PrintArea.js"></script>

<script type="text/javascript">
	function pesan($judul, $pesan, $gambar) {
		$.gritter.add({
			title: $judul,
			text: $pesan,
			image: $gambar,
			sticky: true,
			time: '',
			class_name: 'my-sticky-class'
		});
		return false;
	}

	var table;
	$(document).ready(function() {
		$('#TombolHapus').hide();
		table = $('#table_suratketerangan').DataTable({
			"processing": true,
			"serverSide": true,
			"bSort": false,
			"bInfo": false,
			"ajax": {
				"url": "<?php echo base_url() ?>jenissuratketerangan_data",
				"type": "POST"
			},

		});
	});

	function TutupModal() {
		$('#modal_penomoran').modal('toggle');
		$('#table_penomoran').DataTable().ajax.reload();
	}

	function HapusModal(penomoran_id) {
		$.post('<?php echo base_url() ?>penomoran_hapus', {
			penomoran_id: penomoran_id
		}, function(response) {
			var json = jQuery.parseJSON(response);
			if (json.st == 1) {
				$('#modal_penomoran').modal('toggle');
				$('#table_penomoran').DataTable().ajax.reload();
				pesan('INFORMASI', json.msg, '');
			} else if (json.st == 0) {
				pesan('PERINGATAN', json.msg, '');
				$('#table_penomoran').DataTable().ajax.reload();
			}
		});
	}


	function SimpanModal() {
		var penomoran_id = $('#penomoran_id').val();
		var nama = $('#nama').val();
		var keterangan = $('#keterangan').val();
		var status = $('#status').val();
		if (kode == '') {
			pesan('PERINGATAN', 'Kolom Kode Nomor Surat Wajib Diisi', '');
			return;
		}
		if (status == '') {
			pesan('PERINGATAN', 'Kolom Status Kode Surat Wajib Diisi', '');
			return;
		}
		$.post('<?php echo base_url() ?>penomoran_simpan', {
			penomoran_id: penomoran_id,
			nama: nama,
			keterangan: keterangan,
			status: status
		}, function(response) {
			var json = jQuery.parseJSON(response);
			if (json.st == 1) {
				$('#modal_penomoran').modal('toggle');
				$('#table_penomoran').DataTable().ajax.reload();
				pesan('INFORMASI', json.msg, '');
			} else if (json.st == 0) {
				pesan('PERINGATAN', json.msg, '');
				$('#table_penomoran').DataTable().ajax.reload();
			}
		});
	}


		function BukaModal(id){
		$.post('<?php echo base_url()?>jenissuratketerangan_add', { 
			id:id
		}, function(response){
			var json = jQuery.parseJSON(response);
			if(json.st==1){
				$("#judul").html("");
				$("#aktif_").html("");
				$("#register_").html("");
				$("#id").val("");
				$("#kode").val("");
				$("#nama").val("");
				$("#dokumen_").html("");
				$("#kode").val(json.kode);
				$("#nama").val(json.nama);
				$("#dokumen_").append(json.dokumen);
				$("#id").val(json.id);
				$("#judul").append(json.judul);
				$("#aktif_").append(json.aktif);
				$("#register_").append(json.register);
				$('#modal_jenissuratketerangan').modal({ show: true,backdrop: 'static' });        
			}else if(json.st==0){
				$('#table_jenissuratketerangan').DataTable().ajax.reload();
			}
		});
	}
</script>
<!-- <script>
		$(document).ready(function() {
			App.init();
            TableManageDefault.init();
            FormPlugins.init();
		});
	</script> -->
</body>

</html>