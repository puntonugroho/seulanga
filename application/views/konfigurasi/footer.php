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

	function SelectPN() {
		var pengadilan_tinggi = $('#pengadilan_tinggi').val();
		$.post('<?php echo base_url() ?>konfigurasi_satker', {
			pengadilan_tinggi: pengadilan_tinggi
		}, function(response) {
			var json = jQuery.parseJSON(response);
			if (json.st == 1) {
				$('#input_pn').hide();
				$("#pengadilan_negeri_").html('');
				$("#pengadilan_negeri_").append(json.pengadilan_negeri);
			} else if (json.st == 0) {
				table.ajax.reload(null, false);
			}
		});
	}

	document.getElementById('dokumen').addEventListener('change', checkFile, false);
	approveletter.addEventListener('change', checkFile, false);

	function checkFile(e) {
		var file_list = e.target.files;
		for (var i = 0, file; file = file_list[i]; i++) {
			var sFileName = file.name;
			var sFileExtension = sFileName.split('.')[sFileName.split('.').length - 1].toLowerCase();
			var iFileSize = file.size;
			var iConvert = (file.size / 10485760).toFixed(2);

			if (!(sFileExtension === "jpg" || sFileExtension === "jpeg" || sFileExtension === "png") || iFileSize > 10485760) {
				txt = "Jenis File : " + sFileExtension + "\n\n";
				txt += "Ukuran: " + iConvert + " MB \n\n";
				txt += "Pastikan Format Dokumen JPG, JPEG, PNG dengan ukuran maksimal 10MB.\n\n";
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