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
			"respinsive": true,
			"serverSide": true,
			"bSort": false,
			"bInfo": false,
			"ajax": {
				"url": "<?php echo base_url() ?>suratmasuk_data",
				"type": "POST",
				"data": function(data) {
					data.tahun_register = $('#tahun_register_cari').val();
					data.tujuan_jabatan = $('#jabatan_cari').val();
				}
			},

		});

		$("#printButton").click(function() {
			var mode = 'iframe';
			var close = mode == "popup";
			var options = {
				mode: mode,
				popClose: close
			};
			$("div.printableArea").printArea(options);
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

	function ModalPencarian(register_id) {
		$.post('<?php echo base_url() ?>suratmasuk_pencarian', {
			register_id: register_id,
		}, function(response) {
			var json = jQuery.parseJSON(response);
			if (json.st == 1) {
				$("#tujuan_jabatan_").html("");
				$("#tahun_register_").html("");
				$("#tujuan_jabatan_").append(json.jabatan);
				$("#tahun_register_").append(json.tahun_register);
				$('#modal_pencarian').modal({
					show: true,
					backdrop: 'static'
				});
			} else if (json.st == 0) {
				pesan('PERINGATAN', json.msg, '');
				$('#table_pegawai').DataTable().ajax.reload();
			}
		});
	}

	function ModalPeriodeCetakRegister(register_id) {
		$.post('<?php echo base_url() ?>suratmasuk_periode_cetak', {
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
				$('#table_pegawai').DataTable().ajax.reload();
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
		$.post('<?php echo base_url() ?>suratmasuk_register_cetak', {
			bulan_register_periode: bulan_register_periode,
			tahun_register_periode: tahun_register_periode
		}, function(response) {
			var json = jQuery.parseJSON(response);
			if (json.st == 1) {
				$('#modal_periode_cetak_register').modal('toggle');
				$("#data_register_surat_masuk").html("");
				$("#data_register_surat_masuk").append(json.register);
				$('#modal_cetak_register').modal({
					show: true,
					backdrop: 'static'
				});
			} else if (json.st == 0) {
				pesan('PERINGATAN', json.msg, '');
				$('#table_pegawai').DataTable().ajax.reload();
			}
		});
	}


	function CariDetil() {
		$('#modal_pencarian').modal('toggle');
		table.ajax.reload();
	}

	function TampilRiwayatPelaksana() {
		table = $('#table_riwayat_pelaksana').DataTable({
			"destroy": true,
			"processing": true,
			"serverSide": true,
			"bPaginate": false,
			"bFilter": false,
			"bSort": false,
			"bInfo": false,

			"ajax": {
				"url": "<?php echo base_url() ?>suratmasuk_data_pelaksana",
				"data": {
					"register_id": $("#register_id_detil").val()
				},
				"type": "POST"
			},
		});
	}

	function HapusSuratMasuk() {
		var register_id = $('#register_id_detil').val();
		$.post('<?php echo base_url() ?>suratmasuk_hapus', {
			register_id: register_id,
		}, function(response) {
			var json = jQuery.parseJSON(response);
			if (json.st == 1) {
				pesan('INFORMASI', json.msg, '');
				TutupModal();
				$('#table_pegawai').DataTable().ajax.reload();
			} else if (json.st == 0) {
				pesan('PERINGATAN', json.msg, '');
				$('#table_pegawai').DataTable().ajax.reload();
			}
		});
	}


	function CetakDisposisi(register_id) {
		if (register_id==0) {
			register_id = $("#register_id_detil").val();
		}
		//console.log(register_id);
		$.post('<?php echo base_url() ?>suratmasuk_disposisi', {
			register_id: register_id
		}, function(response) {
			var json = jQuery.parseJSON(response);
			if (json.st == 1) {
				$("#tanggal_register_cetak").html("");
				$("#tanggal_surat_cetak").html("");
				$("#jenis_surat_cetak").html("");
				$("#pengirim_cetak").html("");
				$("#tujuan_cetak").html("");
				$("#nomor_surat_cetak").html("");
				$("#nomor_agenda_cetak").html("");
				$("#perihal_cetak").html("");
				$("#alamat_pengadilan_cetak").html("");
				$("#logo_pengadilan_cetak").html("");
				$("#nama_pengadilan_cetak").html("");
				$("#tampil_pelaksanaan_disposisi").html("");
				$("#tanggal_register_cetak").append(json.tanggal_register);
				$("#tanggal_surat_cetak").append(json.tanggal_surat);
				$("#jenis_surat_cetak").append(json.jenis_surat);
				$("#pengirim_cetak").append(json.pengirim);
				$("#tujuan_cetak").append(json.tujuan);
				$("#nomor_surat_cetak").append(json.nomor_surat);
				$("#nomor_agenda_cetak").append(json.nomor_agenda);
				$("#perihal_cetak").append(json.perihal);
				$("#alamat_pengadilan_cetak").append(json.alamat_pengadilan);
				$("#logo_pengadilan_cetak").append(json.logo_pengadilan);
				$("#nama_pengadilan_cetak").append(json.nama_pengadilan);
				$("#tampil_pelaksanaan_disposisi").append(json.tampil_pelaksanaan);
				$('#modal-disposisi').modal({
					show: true,
					backdrop: 'static'
				});
			} else if (json.st == 0) {
				pesan('PERINGATAN', json.msg, '');
				$('#table_pegawai').DataTable().ajax.reload();
			}
		});
	}

	function TutupModal() {
		$('#table_pegawai').DataTable().ajax.reload();
	}

	function HapusPelaksanaan(pelaksanaan_id) {
		$.post('<?php echo base_url() ?>suratmasuk_pelaksana_hapus', {
			pelaksanaan_id: pelaksanaan_id
		}, function(response) {
			var json = jQuery.parseJSON(response);
			if (json.st == 1) {
				pesan('INFORMASI', json.msg, '');
				table.ajax.reload(null, false);
			} else if (json.st == 0) {
				pesan('PERINGATAN', json.msg, '');
				$('#table_pegawai').DataTable().ajax.reload();
			}
		});
	}



	function SimpanPelaksanaan() {
		var register_id = $('#register_id_detil').val();
		var pelaksanaan_id = $('#pelaksanaan_id').val();
		var tanggal_pelaksanaan = $('#datepicker-default3').val();
		var jenis_pelaksanaan = $('#jenis_pelaksanaan').val();
		var jenis_jabatan = $('#jenis_jabatan').val();
		var pegawai = $('#pegawai').val();
		var keterangan = $('#keterangan_pelaksanaan').val();
		if (jenis_pelaksanaan == 10) {
			if (jenis_jabatan == '') {
				pesan('PERINGATAN', 'Kolom Jenis Jabatan Wajib Diisi', '');
				return;
			}
		}
		if (jenis_pelaksanaan == 10) {
			if (pegawai == '') {
				pesan('PERINGATAN', 'Kolom Pelaksana Wajib Diisi', '');
				return;
			}
		}
		$.post('<?php echo base_url() ?>suratmasuk_simpan_pelaksanaan', {
			pelaksanaan_id: pelaksanaan_id,
			tanggal_pelaksanaan: tanggal_pelaksanaan,
			jenis_pelaksanaan: jenis_pelaksanaan,
			jenis_jabatan: jenis_jabatan,
			pegawai: pegawai,
			keterangan: keterangan,
			register_id: register_id
		}, function(response) {
			var json = jQuery.parseJSON(response);
			if (json.st == 1) {
				$('#tambah_pelaksanaan').hide();

				pesan('PERINGATAN', json.msg, '');
				location.reload();
				$('#table_pegawai').DataTable().ajax.reload();
			} else if (json.st == 0) {
				$('#tambah_pelaksanaan').hide();
				pesan('PERINGATAN', json.msg, '');
				location.reload();
				$('#table_pegawai').DataTable().ajax.reload();
			}
		});
	}

	function TampilPegawai() {
		var jenis_jabatan = $('#jenis_jabatan').val();
		$.post('<?php echo base_url() ?>suratmasuk_pelaksana_pegawai', {
			jenis_jabatan: jenis_jabatan
		}, function(response) {
			var json = jQuery.parseJSON(response);
			if (json.st == 1) {
				$("#disposisi_pegawai_").html('');
				$("#disposisi_pegawai_").append(json.pegawai);
			} else if (json.st == 0) {
				$('#table_pegawai').DataTable().ajax.reload();
			}
		});
	}


	function EditPelaksanaan(pelaksanaan_id) {
		$.post('<?php echo base_url() ?>suratmasuk_pelaksana_edit', {
			pelaksanaan_id: pelaksanaan_id
		}, function(response) {
			var json = jQuery.parseJSON(response);
			if (json.st == 1) {
				$("#keterangan_pelaksanaan").val("");
				$("#datepicker-default3").val('');
				$("#pelaksanaan_").html('');
				$("#disposisi_").html('');
				$("#pelaksanaan_id").val('');
				$("#disposisi_pegawai_").html('');
				if (json.jenis_pelaksanaan_id == 10) {
					$('.status_disposisi').show();
					$("#disposisi_").append(json.jenis_jabatan);
					$("#disposisi_pegawai_").append(json.pegawai);
				} else {
					$('.status_disposisi').hide();
				}
				$("#pelaksanaan_id").val(json.pelaksanaan_id);
				$("#datepicker-default3").val(json.tanggal_pelaksanaan);
				$("#pelaksanaan_").append(json.jenis_pelaksanaan);
				$("#keterangan_pelaksanaan").val(json.keterangan);
				$('#tambah_pelaksanaan').show();

			} else if (json.st == 0) {
				$('#table_pegawai').DataTable().ajax.reload();
			}
		});
	}

	function TampilPelaksanaan() {
		var register_id = $('#register_id_detil').val();
		$.post('<?php echo base_url() ?>suratmasuk_pelaksana_tambah', {
			register_id: register_id
		}, function(response) {
			var json = jQuery.parseJSON(response);
			if (json.st == 1) {
				$("#keterangan").val("");
				$("#datepicker-default3").val('');
				$("#pelaksanaan_").html('');
				$("#disposisi_").html('');
				$("#pelaksanaan_id").val('');
				$("#disposisi_pegawai_").html('');
				$("#datepicker-default3").val(json.tanggal_sekarang);
				$("#pelaksanaan_").append(json.jenis_pelaksanaan);
				$("#disposisi_").append(json.jenis_jabatan);
				$("#pelaksanaan_id").val(json.pelaksanaan_id);
				$('#tambah_pelaksanaan').show();
				$('.status_disposisi').hide();
			} else if (json.st == 0) {
				$('#table_pegawai').DataTable().ajax.reload();
			}
		});
	}

	function TutupPelaksanaan() {
		$("#keterangan").val("");
		$('#tambah_pelaksanaan').hide();
	}

	function JenisPelaksanaan() {
		var jenis_pelaksanaan = $('#jenis_pelaksanaan').val();
		if ((jenis_pelaksanaan == 10) || (jenis_pelaksanaan == 30)) {
			$.post('<?php echo base_url() ?>suratmasuk_tampil_pelaksana', {
				jenis_pelaksanaan: jenis_pelaksanaan
			}, function(response) {
				var json = jQuery.parseJSON(response);
				if (json.st == 1) {
					$("#disposisi_").html('');
					$("#disposisi_").append(json.jenis_jabatan);
					$('.status_disposisi').show();
				} else if (json.st == 0) {
					pesan('PERINGATAN', json.msg, '');
					$('.status_disposisi').hide();
				}
			});
		} else {
			$('.status_disposisi').hide();
		}
	}


	function BukaModalDetil(register_id) {
		$.post('<?php echo base_url() ?>suratmasuk_detil', {
			register_id: register_id
		}, function(response) {
			var json = jQuery.parseJSON(response);
			if (json.st == 1) {
				$("#judul_detil").html("");
				$("#tanggal_register_detil").html("");
				$("#jenis_surat_detil").html("");
				$("#tanggal_surat_detil").html("");
				$("#nomor_surat_detil").html("");
				$("#pengirim_detil").html("");
				$("#tujuan_detil").html("");
				$("#perihal_detil").html("");
				$("#register_id_detil").val("");
				$("#dokumen_elektronik").html("");
				$("#TombolEditSuratMasuk").html("");
				$("#nomor_agenda_detil").html("");
				$("#nomor_agenda_detil").append(json.nomor_agenda);
				$("#tanggal_register_detil").append(json.tanggal_register);
				$("#jenis_surat_detil").append(json.jenis_surat);
				$("#tanggal_surat_detil").append(json.tanggal_surat);
				$("#nomor_surat_detil").append(json.nomor_surat);
				$("#pengirim_detil").append(json.pengirim);
				$("#tujuan_detil").append(json.tujuan);
				$("#perihal_detil").append(json.perihal);
				$("#judul_detil").append(json.judul);
				$("#dokumen_elektronik").append(json.dokumen_elektronik);
				$("#TombolEditSuratMasuk").append(json.tombol_edit_surat_masuk);
				$("#register_id_detil").val(json.register_id);
				TampilRiwayatPelaksana();
				$('#tambah_pelaksanaan').hide();
				$('#modal-suratmasuk-detil').modal({
					show: true,
					backdrop: 'static'
				});
			} else if (json.st == 0) {
				$('#table_pegawai').DataTable().ajax.reload();
			}
		});
	}


	function BukaModal(register_id) {
		$.post('<?php echo base_url() ?>suratmasuk_add', {
			register_id: register_id
		}, function(response) {
			var json = jQuery.parseJSON(response);
			if (json.st == 1) {
				$("#jenis_surat_").html("");
				$("#register_id").val("");
				$("#jabatan_").html("");
				$("#judul").html("");
				$("#datepicker-default").val('');
				$("#datepicker-default2").val("");
				$("#nomor_surat").val("");
				$("#pengirim").val("");
				$("#perihal").val("");
				$("#keterangan").val("");
				$("#nomor_index").val("");
				$("#nomor_agenda").val("");
				$("#nomor_agenda_show").val("");
				$("#generate_nomor_").html('');
				$("#nomor_index").val(json.nomor_index);
				$("#nomor_agenda").val(json.nomor_agenda);
				$("#nomor_agenda_show").val(json.nomor_agenda);
				$("#keterangan").val(json.keterangan);
				$("#perihal").val(json.perihal);
				$("#pengirim").val(json.pengirim);
				$("#nomor_surat").val(json.nomor_surat);
				$("#datepicker-default2").val(json.tanggal_surat);
				$("#datepicker-default").val(json.tanggal_register);
				$("#register_id").val(json.register_id);
				$("#jenis_surat_").append(json.jenis_surat);
				$("#jabatan_").append(json.jabatan);
				$("#generate_nomor_").append(json.generate_nomor);
				$("#judul").append(json.judul);
				$("#nomor_index_manual").val(json.nomor_index);
				$("#kode_nomor_manual").val(json.tahun_register);
				$("#register_id").val(json.register_id);
				$('#KolomNomorManual').hide();
				document.getElementById('nomor_agenda_show').disabled = true;
				if (json.judul == 'EDIT SURAT MASUK') {
					document.getElementById('datepicker-default').disabled = true;
					document.getElementById('generate_nomor').disabled = true;
					document.getElementById('JenisSurat').disabled = true;
					document.getElementById('jabatan').disabled = true;
					document.getElementById('datepicker-default2').disabled = true;
				}


				$('#modal-suratmasuk').modal({
					show: true,
					backdrop: 'static'
				});
			} else if (json.st == 0) {
				$('#table_pegawai').DataTable().ajax.reload();
			}
		});
	}

	function GantiGenerateNomor() {
		var generate_nomor = $('#generate_nomor').val();
		if (generate_nomor == 1) {
			$('#KolomNomorManual').hide();
			$('#KolomNomorOtomatis').show();
		} else {
			$('#KolomNomorManual').show();
			$('#KolomNomorOtomatis').hide();
		}
	}


	function GetNomorAgendaBaru() {
		var tanggal_register = $('#datepicker-default').val();
		// var tanggal_register = moment(tgl_dummy).format("dd/mm/yyyy");
		$.post('<?php echo base_url() ?>suratmasuk_nomoragenda', {
			tanggal_register: tanggal_register
		}, function(response) {
			var json = jQuery.parseJSON(response);
			if (json.st == 1) {
				$("#nomor_index").val("");
				$("#nomor_agenda").val("");
				$("#kode_nomor_manual").val("");
				$("#nomor_agenda_show").val("");
				$("#nomor_index").val(json.nomor_index);
				$("#nomor_agenda").val(json.nomor_agenda);
				$("#nomor_agenda_show").val(json.nomor_agenda);
				$("#kode_nomor_manual").val(json.tahun_register);
			} else if (json.st == 0) {
				$('#table_pegawai').DataTable().ajax.reload();
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
			var iConvert = (file.size / 100485760).toFixed(2);

			if (!(sFileExtension === "pdf") || iFileSize > 100485760) {
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