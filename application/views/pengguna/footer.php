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
		table = $('#table_pengguna').DataTable({
			"processing": true,
			"serverSide": true,
			"bSort": false,
			"bInfo": false,
			"ajax": {
				"url": "<?php echo base_url() ?>pengguna_data",
				"type": "POST"
			},
		});
	});

	function TutupModal() {
		$('#modal-pengguna').modal('toggle');
		$('#table_pengguna').DataTable().ajax.reload();
	}


	function BukaModal(userid) {
		$.post('<?php echo base_url() ?>pengguna_add', {
			userid: userid
		}, function(response) {
			var json = jQuery.parseJSON(response);
			if (json.st == 1) {
				$("#fullname").val("");
				$("#username").val("");
				$("#password").val("");
				$("#ulang_password").val("");
				$("#email").val("");
				$('#kewenangan').html('');
				$('#judul').html('');
				$('#status').html('');
				$('#userid').val('');
				$('#pegawai_').html('');
				$("#pegawai_").append(json.pegawai);
				$("#fullname").val(json.fullname);
				$("#username").val(json.username);
				$("#email").val(json.email);
				$("#userid").val(json.userid);
				$("#kewenangan").append(json.kewenangan);
				$("#status").append(json.status);
				$("#judul").append(json.judul);
				$('#modal-pengguna').modal({
					show: true,
					backdrop: 'static'
				});
			} else if (json.st == 0) {
				pesan('PERINGATAN', json.msg, '');
				$('#table_pengguna').DataTable().ajax.reload();
			}
		});
	}

	function SimpanModal() {
		var userid = $('#userid').val();
		var pegawai = $('#pegawai').val();
		var username = $('#username').val();
		var password = $('#password').val();
		var ulang_password = $('#ulang_password').val();
		var email = $('#email').val();
		var blok = $('#blok').val();
		if (userid == '') {
			pesan('PERINGATAN', 'Kesalahan Dalam Akses Aplikasi, Refresh Browser CTRL+F5', '');
			return;
		}
		if (pegawai == '') {
			pesan('PERINGATAN', 'Data Pegawai Wajib Dipilih', '');
			return;
		}
		if (username == '') {
			pesan('PERINGATAN', 'Kolom Nama Wajib Diisi', '');
			return;
		}
		if (password == '') {
			pesan('PERINGATAN', 'Kolom Password Wajib Diisi', '');
			return;
		}
		if (ulang_password == '') {
			pesan('PERINGATAN', 'Kolom Varifikasi Password Wajib Diisi', '');
			return;
		}
		if (email == '') {
			pesan('PERINGATAN', 'Kolom Email Wajib Diisi', '');
			return;
		}
		if (blok == '') {
			pesan('PERINGATAN', 'Status Blokir Pengguna Wajib Dipilih', '');
			return;
		}
		$.post('<?php echo base_url() ?>pengguna_simpan', {
			userid: userid,
			pegawai: pegawai,
			username: username,
			password: password,
			ulang_password: ulang_password,
			email: email,
			blok: blok
		}, function(response) {
			var json = jQuery.parseJSON(response);
			if (json.st == 1) {
				pesan('INFORMASI', json.msg, '');
				$('#table_pengguna').DataTable().ajax.reload();
			} else if (json.st == 0) {
				pesan('PERINGATAN', json.msg, '');
				$('#table_pengguna').DataTable().ajax.reload();
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