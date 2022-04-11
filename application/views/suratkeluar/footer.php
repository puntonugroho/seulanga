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
		table = $('#table_suratkeluar').DataTable({
			"processing": true,
			"serverSide": true,
			"bSort": false,
			"bInfo": false,
			"ajax": {
				"url": "<?php echo base_url() ?>suratkeluar_data",
				"type": "POST",
				"data": function(data) {
					data.bulan_register_cari = $('#bulan_register_cari').val();
					data.tahun_register_cari = $('#tahun_register_cari').val();
					data.pengiriman_cari = $('#pengiriman_cari').val();
					data.jabatan_struktural_cari = $('#jabatan_struktural_cari').val();
				}
			},

		});
		$("#printRegisterButton").click(function() {
			var mode = 'iframe';
			var close = mode == "popup";
			var options = {
				mode: mode,
				popClose: close
			};
			$("div.printableAreaRegister").printArea(options);
		});
	});


	function ModalPeriodeCetakRegister(register_id) {
		$.post('<?php echo base_url() ?>suratkeluar_periode_cetak', {
			register_id: register_id,
		}, function(response) {
			var json = jQuery.parseJSON(response);
			if (json.st == 1) {
				$("#bulan_register_periode_cetak_").html("");
				$("#tahun_register_periode_cetak_").html("");
				$("#bulan_register_periode_cetak_").append(json.bulan_register);
				$("#tahun_register_periode_cetak_").append(json.tahun_register);
				$('#modal_periode_cetak_register').modal({
					show: true
				});
			} else if (json.st == 0) {
				pesan('PERINGATAN', json.msg, '');
				$('#table_suratkeluar').DataTable().ajax.reload();
			}
		});
	}

	function CetakRegister() {
		var bulan_register_periode = $('#bulan_register_periode').val();
		var tahun_register_periode = $('#tahun_register_periode').val();
		if (bulan_register_periode == '') {
			pesan('PERINGATAN', 'Periode Bulan Register Wajib Dipilih', '');
			return;
		}
		if (tahun_register_periode == '') {
			pesan('PERINGATAN', 'Periode Tahun Register Wajib Dipilih', '');
			return;
		}
		$.post('<?php echo base_url() ?>suratkeluar_register_cetak', {
			bulan_register_periode: bulan_register_periode,
			tahun_register_periode: tahun_register_periode
		}, function(response) {
			var json = jQuery.parseJSON(response);
			if (json.st == 1) {
				$('#modal_periode_cetak_register').modal('toggle');
				$("#data_register_surat_keluar").html("");
				$("#data_register_surat_keluar").append(json.register);
				$('#modal_cetak_register').modal({
					show: true,
					backdrop: 'static'
				});
			} else if (json.st == 0) {
				pesan('PERINGATAN', json.msg, '');
				$('#table_suratkeluar').DataTable().ajax.reload();
			}
		});
	}


	function ModalPencarian(register_id) {
		$.post('<?php echo base_url() ?>suratkeluar_pencarian', {
			register_id: register_id,
		}, function(response) {
			var json = jQuery.parseJSON(response);
			if (json.st == 1) {
				$("#tahun_register_cari_").html("");
				$("#jabatan_struktural_cari_").html("");
				$("#jenis_pengiriman_cari_").html("");
				$("#bulan_register_cari_").html("");
				$("#bulan_register_cari_").append(json.bulan_register);
				$("#tahun_register_cari_").append(json.tahun_register);
				$("#jabatan_struktural_cari_").append(json.jabatan_struktural);
				$("#jenis_pengiriman_cari_").append(json.pengiriman);
				$('#modal_pencarian').modal({
					show: true,
					backdrop: 'static'
				});
			} else if (json.st == 0) {
				pesan('PERINGATAN', json.msg, '');
				$('#table_suratkeluar').DataTable().ajax.reload();
			}
		});
	}

	function CariDetil() {
		$('#modal_pencarian').modal('toggle');
		table.ajax.reload();
	}

	function BukaModal(register_id) {
		$.post('<?php echo base_url() ?>suratkeluar_add', {
			register_id: register_id,
		}, function(response) {
			var json = jQuery.parseJSON(response);
			if (json.st == 1) {
				$("#judul").html('');
				$("#jenis_surat_").html('');
				$("#jenis_tujuan_surat_").html('');
				$("#datepicker-default").val('');
				$("#jenis_pengiriman_").html('');
				$("#nomor_surat").val('');
				$("#perihal").val('');
				$("#keterangan").val('');
				$("#nomor_index").val('');
				$("#register_id").val('');
				$("#sumber_surat_").html('');
				$("#sumber_surat_").append(json.jabatan_struktural);
				$("#nomor_surat").val(json.nomor_surat);
				$("#perihal").val(json.perihal);
				$("#keterangan").val(json.keterangan);
				$("#tujuan").val(json.tujuan);
				$("#keterangan_jenis_surat").val(json.keterangan_jenis_surat);
				$("#register_id").val(json.register_id);
				$("#nomor_index").val(json.nomor_index);
				$("#datepicker-default").val(json.tanggal_register);
				$("#jenis_surat_").append(json.jenis_surat);
				$("#jenis_tujuan_surat_").append(json.jenis_tujuan_surat);
				$("#jenis_pengiriman_").append(json.jenis_pengiriman);
				$("#judul").append(json.judul);
				if (json.nomor_surat != '') {
					document.getElementById('datepicker-default').disabled = true;
					document.getElementById('nomor_surat').disabled = true;
					document.getElementById('jenis_surat').disabled = true;
					document.getElementById('jabatan_struktural').disabled = true;
				} else {
					document.getElementById('datepicker-default').disabled = false;
					document.getElementById('nomor_surat').disabled = false;
					document.getElementById('jenis_surat').disabled = false;
					document.getElementById('jabatan_struktural').disabled = false;
				}
				$('#modal_suratkeluar').modal({
					show: true,
					backdrop: 'static'
				});
			} else if (json.st == 0) {
				pesan('PERINGATAN', json.msg, '');
				table.ajax.reload(null, false);
			}
		});
	}

	function BukaModalEdit(register_id) {
		$.post('<?php echo base_url() ?>suratkeluar_add', {
			register_id: register_id,
		}, function(response) {
			var json = jQuery.parseJSON(response);
			if (json.st == 1) {
				$("#judul").html('');
				$("#jenis_surat_").html('');
				$("#jenis_tujuan_surat_").html('');
				$("#datepicker-default").val('');
				$("#jenis_pengiriman_").html('');
				$("#nomor_surat").val('');
				$("#perihal").val('');
				$("#keterangan").val('');
				$("#nomor_index").val('');
				$("#register_id").val('');
				$("#sumber_surat_").html('');
				$("#sumber_surat_").append(json.jabatan_struktural);
				$("#nomor_surat").val(json.nomor_surat);
				$("#perihal").val(json.perihal);
				$("#keterangan").val(json.keterangan);
				$("#tujuan").val(json.tujuan);
				$("#keterangan_jenis_surat").val(json.keterangan_jenis_surat);
				$("#register_id").val(json.register_id);
				$("#nomor_index").val(json.nomor_index);
				$("#datepicker-default").val(json.tanggal_register);
				$("#jenis_surat_").append(json.jenis_surat);
				$("#jenis_tujuan_surat_").append(json.jenis_tujuan_surat);
				$("#jenis_pengiriman_").append(json.jenis_pengiriman);
				$("#judul").append(json.judul);
				if (json.nomor_surat != '') {
					document.getElementById('datepicker-default').disabled = true;
					document.getElementById('nomor_surat').disabled = true;
					document.getElementById('jenis_surat').disabled = true;
					document.getElementById('jabatan_struktural').disabled = true;
				} else {
					document.getElementById('datepicker-default').disabled = false;
					document.getElementById('nomor_surat').disabled = false;
					document.getElementById('jenis_surat').disabled = false;
					document.getElementById('jabatan_struktural').disabled = false;
				}
				$('#modal_suratkeluar_detil').modal('hide');
				$('#modal_suratkeluar').modal({
					show: true,
					backdrop: 'static'
				});
			} else if (json.st == 0) {
				pesan('PERINGATAN', json.msg, '');
				table.ajax.reload(null, false);
			}
		});
	}


	function BukaModalDetil(register_id) {
		$.post('<?php echo base_url() ?>suratkeluar_detil', {
			register_id: register_id,
		}, function(response) {
			var json = jQuery.parseJSON(response);
			if (json.st == 1) {
				$("#judul_detil").html("");
				$("#register_id_detil").html("");
				$("#tanggal_register_detil").html("");
				$("#nomor_surat_detil").html("");
				$("#tujuan_detil").html("");
				$("#jenis_tujuan_surat_detil").html("");
				$("#perihal_detil").html("");
				$("#keterangan_detil").html("");
				$("#dokumen_elektronik_detil").html("");
				$("#jenis_ekspedisi_detil").html("");
				$("#tanggal_kirim_detil").html("");
				$("#status_pelaksanaan_detil").html("");
				$("#waktu_pelaksanaan_detil").html("");
				$("#tombol_edit_surat_keluar").html("");
				$("#tombol_kirim_surat_keluar").html("");
				$("#tombol_hapus_surat_keluar").html("");
				$("#dari_bagian_detil").html("");
				$("#dari_bagian_detil").append(json.jabatan_struktural);
				$("#tombol_hapus_surat_keluar").append(json.tombol_hapus_surat_keluar);
				$("#tombol_kirim_surat_keluar").append(json.tombol_kirim_surat_keluar);
				$("#tombol_edit_surat_keluar").append(json.tombol_edit_surat_keluar);
				$("#waktu_pelaksanaan_detil").append(json.waktu);
				$("#status_pelaksanaan_detil").append(json.status_pelaksanaan);
				$("#tanggal_kirim_detil").append(json.tanggal_kirim);
				$("#judul_detil").append(json.judul);
				$("#register_id_detil").append(json.register_id);
				$("#tanggal_register_detil").append(json.tanggal_register);
				$("#nomor_surat_detil").append(json.nomor_surat);
				$("#tujuan_detil").append(json.tujuan);
				$("#jenis_tujuan_surat_detil").append(json.jenis_tujuan_surat);
				$("#perihal_detil").append(json.perihal);
				$("#keterangan_detil").append(json.keterangan);
				$("#dokumen_elektronik_detil").append(json.dokumen_elektronik);
				$("#jenis_ekspedisi_detil").append(json.jenis_ekspedisi);
				$('#modal_suratkeluar_detil').modal({
					show: true,
					backdrop: 'static'
				});
			} else if (json.st == 0) {
				pesan('PERINGATAN', json.msg, '');
				table.ajax.reload(null, false);
			}
		});
	}

	function TampilJenisSurat() {
		var jenis_surat = $('#jenis_surat').val();
		var tanggal_register = $('#datepicker-default').val();
		$.post('<?php echo base_url() ?>suratkeluar_jenissurat', {
			jenis_surat: jenis_surat,
			tanggal_register: tanggal_register
		}, function(response) {
			var json = jQuery.parseJSON(response);
			if (json.st == 1) {
				$("#nomor_surat").val('');
				$("#keterangan_jenis_surat").val('');
				$("#nomor_surat").val(json.nomor_surat);
				$("#keterangan_jenis_surat").val(json.keterangan_jenis_surat);
			} else if (json.st == 0) {
				pesan('PERINGATAN', json.msg, '');
				$('#table_suratkeluar').DataTable().ajax.reload();
			}
		});
	}

	function TutupModal() {
		$('#table_suratkeluar').DataTable().ajax.reload();
		// $('#modal_suratkeluar_detil').modal('hide');
	}
	

	function BukaModalPengiriman(register_id) {
		$.post('<?php echo base_url() ?>suratkeluar_pengiriman', {
			register_id: register_id
		}, function(response) {
			var json = jQuery.parseJSON(response);
			if (json.st == 1) {
				$("#datepicker-default2").val('');
				$("#datepicker-default2").val(json.tanggal_kirim);
				$("#register_id_pengiriman").val('');
				$("#register_id_pengiriman").val(json.register_id);
				$("#judul_kirim").html('');
				$("#judul_kirim").append(json.judul);
				$('#modal_suratkeluar_detil').modal('hide');
				$('#modal_suratkeluar_kirim').modal({
					show: true,
					backdrop: 'static'
				});
			} else if (json.st == 0) {
				pesan('PERINGATAN', json.msg, '');
				$('#table_suratkeluar').DataTable().ajax.reload();
			}
		});
	}

	function SimpanModalPengiriman() {
		var register_id = $('#register_id_pengiriman').val();
		var tanggal_kirim = $('#datepicker-default2').val();
		if (register_id == '') {
			pesan('PERINGATAN', 'Kesalahan Dalam Akses Aplikasi, Refresh Browser', '');
			return;
		}
		if (tanggal_kirim == '') {
			pesan('PERINGATAN', 'Tanggal Pengiriman Surat Wajib Diisi', '');
			return;
		}
		$.post('<?php echo base_url() ?>suratkeluar_pengiriman_simpan', {
			register_id: register_id,
			tanggal_kirim: tanggal_kirim
		}, function(response) {
			var json = jQuery.parseJSON(response);
			if (json.st == 1) {
				$('#modal_suratkeluar_kirim').modal('toggle');
				pesan('INFORMASI', json.msg, '');
				BukaModalDetil(json.register_id);
			} else if (json.st == 0) {
				pesan('PERINGATAN', json.msg, '');
				$('#table_suratkeluar').DataTable().ajax.reload();
			}
		});
	}

	function HapusSuratKeluar(register_id) {
		if (register_id == '') {
			pesan('PERINGATAN', 'Kesalahan Dalam Akses Aplikasi, Refresh Browser', '');
			return;
		}
		$.post('<?php echo base_url() ?>suratkeluar_hapus', {
			register_id: register_id
		}, function(response) {
			var json = jQuery.parseJSON(response);
			if (json.st == 1) {
				pesan('INFORMASI', json.msg, '');
				TutupModal();
				$('#table_suratkeluar').DataTable().ajax.reload();
			} else if (json.st == 0) {
				pesan('PERINGATAN', json.msg, '');
				$('#table_suratkeluar').DataTable().ajax.reload();
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
				pesan('PERINGATAN', txt, '');
				$("#dokumen").val("");
			}
		}
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