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
		table = $('#table_pegawai').DataTable({
			"processing": true,
			"serverSide": true,
			"bSort": false,
			"bInfo": false,
			"ajax": {
				"url": "<?php echo base_url() ?>pegawai_data",
				"type": "POST"
			},
		});
	});

	function TutupModal() {
		table.ajax.reload(null, false);
	}

	function CariPangkat() {
		var golongan = $('#golongan').val();
		if (golongan == '') {
			$("#pangkat").val('');
		}
		$.post('<?php echo base_url() ?>pegawai_pangkat', {
			golongan_id: golongan
		}, function(response) {
			var json = jQuery.parseJSON(response);
			if (json.st == 1) {
				$("#pangkat").val(json.pangkat);
			} else if (json.st == 0) {
				$('#table_pegawai').DataTable().ajax.reload();
			}
		});
	}


	function HapusModal(id) {
		if (id==1) {
			id=$('#id').val();
		}
		$.post('<?php echo base_url() ?>pegawai_hapus', {
			id: id
		}, function(response) {
			var json = jQuery.parseJSON(response);
			if (json.st == 1) {
				pesan('INFORMASI', json.msg, '');
				$('#table_pegawai').DataTable().ajax.reload();
			} else if (json.st == 0) {
				pesan('PERINGATAN', json.msg, '');
				$('#table_pegawai').DataTable().ajax.reload();
				return;
			}
		});
	}


	function BukaModal(id) {
		$.post('<?php echo base_url() ?>pegawai_add', {
			id: id
		}, function(response) {
			var json = jQuery.parseJSON(response);
			if (json.st == 1) {
				$("#judul").html("");
				$("#nip").val('');
				$("#nama_gelar").val('');
				$("#alamat").val('');
				$("#pangkat").val('');
				$("#id").val('');
				$("#aktif_").html("");
				$("#jabatan_").html("");
				$("#golongan_").html("");
				$("#hapus").html("");
				$("#hapus").append(json.hapus);
				$("#judul").append(json.judul);
				$("#nip").val(json.nip);
				$("#nama_gelar").val(json.nama_gelar);
				$("#alamat").val(json.alamat);
				$("#pangkat").val(json.pangkat);
				$("#id").val(json.id);
				$("#aktif_").append(json.aktif);
				$("#jabatan_").append(json.jabatan);
				$("#golongan_").append(json.golongan);
				$('#modal-pegawai').modal({
					show: true,
					backdrop: 'static'
				});
			} else if (json.st == 0) {
				pesan('PERINGATAN', json.msg, '');
				$('#table_pegawai').DataTable().ajax.reload();
			}
		});
	}

	function SimpanModal() {
		var id = $('#id').val();
		var nip = $('#nip').val();
		var nama_gelar = $('#nama_gelar').val();
		var golongan = $('#golongan').val();
		var pangkat = $('#pangkat').val();
		var jabatan = $('#group').val();
		var alamat = $('#alamat').val();
		var aktif = $('#aktif').val();
		if (id == '') {
			pesan('PERINGATAN', 'Kesalahan Dalam Akses Aplikasi, Refresh Browser', '');
			return;
		}
		if (nama_gelar == '') {
			pesan('PERINGATAN', 'Kolom Nama Wajib Diisi', '');
			return;
		}
		if (golongan == '') {
			pesan('PERINGATAN', 'Kolom Golongan Wajib Dipilih', '');
			return;
		}
		if (pangkat == '') {
			pesan('PERINGATAN', 'Kolom Pangkat Wajib Dipilih', '');
			return;
		}
		if (jabatan == '') {
			pesan('PERINGATAN', 'Kolom Jabatan Wajib Dipilih', '');
			return;
		}
		if (aktif == '') {
			pesan('PERINGATAN', 'Kolom Aktif Wajib Dipilih', '');
			return;
		}
		$.post('<?php echo base_url() ?>pegawai_simpan', {
			id: id,
			nip: nip,
			nama_gelar: nama_gelar,
			golongan: golongan,
			pangkat: pangkat,
			jabatan: jabatan,
			alamat: alamat,
			aktif: aktif
		}, function(response) {
			var json = jQuery.parseJSON(response);
			if (json.st == 1) {
				pesan('INFORMASI', json.msg, '');
				$('#table_pegawai').DataTable().ajax.reload();
				return;
			} else if (json.st == 0) {
				$('#table_pegawai').DataTable().ajax.reload();
				pesan('PERINGATAN', json.msg, '');
				return;
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