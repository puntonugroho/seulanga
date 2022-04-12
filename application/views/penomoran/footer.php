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
			sticky: false,
			time: '',
			class_name: 'my-sticky-class'
		});
		return false;
	}

	var table;
	$(document).ready(function() {
		$('#TombolHapus').hide();
		table = $('#table_penomoran').DataTable({
			"processing": true,
			"serverSide": true,
			"bSort": false,
			"bInfo": false,
			"ajax": {
				"url": "<?php echo base_url() ?>penomoran_data",
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


	function BukaModal(penomoran_id) {
		$.post('<?php echo base_url() ?>penomoran_add', {
			penomoran_id: penomoran_id
		}, function(response) {
			var json = jQuery.parseJSON(response);
			if (json.st == 1) {
				$("#judul").html('');
				$("#nama").val('');
				$("#keterangan").val('');
				$("#status_").html('');
				$("#hapus").html('');
				$("#kode").val('');
				$("#penomoran_id").val('');
				$("#judul").append(json.judul);
				$("#nama").val(json.jenis);
				$("#kode").val(json.kode);
				$("#penomoran_id").val(json.penomoran_id);
				$("#keterangan").val(json.keterangan);
				$("#status_").append(json.status);
				$("#hapus").append(json.tombol_hapus);
				$('#modal_penomoran').modal({
					show: true,
					backdrop: 'static'
				});
			} else if (json.st == 0) {
				$('#table_penomoran').DataTable().ajax.reload();
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