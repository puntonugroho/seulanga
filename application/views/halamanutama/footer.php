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
<script src="<?php echo base_url(); ?>assets/js/gritter/js/jquery.gritter.js"></script>
<script src="<?php echo base_url(); ?>assets/js/sweetalert.js"></script>
<script src="<?php echo base_url(); ?>assets/js/jquery.dataTables.js"></script>
<script src="<?php echo base_url(); ?>assets/js/dataTables.bootstrap4.js"></script>
<script src="<?php echo base_url(); ?>assets/js/data-table.js"></script>

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

	$(document).ready(function() {
		$('#tampil_pelaksanaan_jabatan').hide();
		$('#tampil_pelaksanaan_pegawai').hide();
	});

	function JenisPelaksanaan() {
		var jenis_pelaksanaan = $('#jenis_pelaksanaan').val();
		if (jenis_pelaksanaan == '10' || jenis_pelaksanaan == '30') {
			$('#tampil_pelaksanaan_jabatan').show();
		} else {
			$('#tampil_pelaksanaan_jabatan').hide();
			$('#tampil_pelaksanaan_pegawai').hide();
		}
	}

	function TampilPegawai() {
		var jabatan = $('#jabatan').val();
		var group_id = $('#group_id').val();
		if (group_id == '2' || group_id == '3') {

		} else {
			$.post('<?php echo base_url() ?>dashboard_modal_pegawai', {
				jabatan: jabatan
			}, function(response) {
				var json = jQuery.parseJSON(response);
				if (json.st == 1) {
					$('#tampil_pelaksanaan_pegawai').show();
					$("#pegawai_").html("");
					$("#pegawai_").append(json.pegawai);
				} else if (json.st == 0) {
					pesan('PERINGATAN', json.msg, '');
					TutupModal();
				}
			});
		}
	}

	function TampilPegawaiStruktural() {
		var jabatan = $('#jabatan').val();
		var cek_pegawai = jabatan.split(" - ");
		alert(cek_pegawai[0]);
	}



	function BukaModalDisposisi(register_id) {
		$.post('<?php echo base_url() ?>dashboard_modal_disposisi', {
			register_id: register_id,
		}, function(response) {
			var json = jQuery.parseJSON(response);
			if (json.st == 1) {
				$("#tanggal_register").html("");
				$("#pengirim").html("");
				$("#perihal").html("");
				$("#keterangan_disposisi").html("");
				$("#dokumen_elektronik").html("");
				$("#jabatan_").html("");
				$("#register_id").val("");
				$("#datepicker-default").val("");
				$("#judul_tanggal").html("");
				$("#judul_pelimpahan").html("");
				$("#judul_modal").html("");
				$("#group_id").val("");
				$("#group_id").val(json.group_id);
				$("#judul_modal").append(json.judul_modal);
				$("#judul_pelimpahan").append(json.judul_pelimpahan);
				$("#judul_tanggal").append(json.judul_tanggal);
				$("#datepicker-default").val(json.tanggal_pelaksanaan);
				$("#register_id").val(json.register_id);
				$("#jabatan_").append(json.jabatan);
				$("#dokumen_elektronik").append(json.TampilDokumenElektronik);
				$("#tanggal_register").append(json.tanggal_register);
				$("#pengirim").append(json.pengirim);
				$("#perihal").append(json.perihal);
				$("#keterangan_disposisi").append(json.keterangan_disposisi);
				$("#jenis_pelaksanaan_").html("");
				$("#jenis_pelaksanaan_").append(json.jenis_pelaksanaan);
				if (json.group_id == '2' || json.group_id == '3') {
					$('#tampil_pelaksanaan').show();
				} else {
					$('#tampil_pelaksanaan').show();
					$('#tampil_pelaksanaan_jabatan').hide();
					$('#tampil_pelaksanaan_pegawai').hide();
				}
				$('#modal_disposisi').modal({
					show: true,
					backdrop: 'static'
				});
			} else if (json.st == 0) {
				pesan('PERINGATAN', json.msg, '');
				TutupModal();
			}
		});
	}

	function SimpanModal() {
		var register_id = $('#register_id').val();
		var group_id = $('#group_id').val();
		var jabatan = $('#jabatan').val();
		var tanggal_pelaksanaan = $('#datepicker-default').val();
		var jenis_pelaksanaan = $('#jenis_pelaksanaan').val();
		var pegawai = $('#pegawai').val();
		var keterangan_pelaksanaan = $('#keterangan_pelaksanaan').val();

		if (register_id == '') {
			pesan('PERINGATAN', 'Kesalahan Dalam Akses Aplikasi, Refresh Browser (CTRL + F5)', '');
			return;
		}
		if (group_id == '') {
			pesan('PERINGATAN', 'Kesalahan Dalam Akses Aplikasi, Refresh Browser (CTRL + F5)', '');
			return;
		}
		if (tanggal_pelaksanaan == '') {
			pesan('PERINGATAN', 'Tanggal Pelaksanaan Wajib Diisi', '');
			return;
		}
		if (jenis_pelaksanaan == '') {
			pesan('PERINGATAN', 'Kolom Jenis Pelaksanaan Wajib Dipilih', '');
			return;
		}

		// if (group_id == '2' || group_id == '3') {
		// 	// jabatan = '';
		// 	if (jabatan == '') {
		// 		pesan('PERINGATAN', 'Kolom Jabatan Tujuan Disposisi Wajib Dipilih', '');
		// 		return;
		// 	}
		// } else {
		// 	if (jenis_pelaksanaan == '10' || jenis_pelaksanaan == '30') {
		// 		if (jabatan == '') {
		// 			pesan('PERINGATAN', 'Kolom Jabatan Tujuan Disposisi Wajib Dipilih', '');
		// 			return;
		// 		}
		// 		if (pegawai == '') {
		// 			pesan('PERINGATAN', 'Kolom Pegawai Tujuan Disposisi Wajib Dipilih', '');
		// 			return;
		// 		}
		// 	}
		// }

		if (jenis_pelaksanaan == '10' || jenis_pelaksanaan == '30') {
			if (group_id == '2' || group_id == '3') {
				if (jabatan == '') {
					pesan('PERINGATAN', 'Kolom Jabatan Tujuan Disposisi Wajib Dipilih', '');
					return;
				}
			} else {
				if (jabatan == '') {
					pesan('PERINGATAN', 'Kolom Jabatan Tujuan Disposisi Wajib Dipilih', '');
					return;
				}
				if (pegawai == '') {
					pesan('PERINGATAN', 'Kolom Pegawai Tujuan Disposisi Wajib Dipilih', '');
					return;
				}
			}
		}

		$('#tombol_simpan_dashboard_disposisi').attr("disabled",true);
		$.post('<?php echo base_url() ?>dashboard_simpan_disposisi', {
			register_id: register_id,
			group_id: group_id,
			tanggal_pelaksanaan: tanggal_pelaksanaan,
			jenis_pelaksanaan: jenis_pelaksanaan,
			jabatan: jabatan,
			pegawai: pegawai,
			keterangan_pelaksanaan: keterangan_pelaksanaan
		}, function(response) {
			var json = jQuery.parseJSON(response);
			if (json.st == 1) {
				$('#modal_disposisi').modal('toggle');
				$('#tombol_simpan_dashboard_disposisi').attr("enabled",true);
				TutupModal();
				pesan('INFORMASI', json.msg, '');
			} else if (json.st == 0) {
				$('#tombol_simpan_dashboard_disposisi').attr("enabled",true);
				TutupModal();
				pesan('PERINGATAN', json.msg, '');
			}
		});
	}

	function TutupModal() {
		location.reload();
	}
</script>

<script type="text/javascript">
	$(document).ready(function() {
		$(document).on('show.bs.modal', '.modal', function(event) {
			var zIndex = 1040 + (10 * $('.modal:visible').length);
			$(this).css('z-index', zIndex);
			setTimeout(function() {
				$('.modal-backdrop').not('.modal-stack').css('z-index', zIndex - 1).addClass('modal-stack');
			}, 0);
		});
	});

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