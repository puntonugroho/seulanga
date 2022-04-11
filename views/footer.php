	</div>
	
	<div id="footer" class="footer">&copy; 2017 Direktorat Jenderal Badan Peradilan Umum - Versi 1.1</div>
	
	<script src="<?php echo base_url();?>assets/plugins/jquery/jquery-migrate-1.1.0.min.js"></script>
	<script src="<?php echo base_url();?>assets/plugins/jquery-ui/ui/minified/jquery-ui.min.js"></script>
	<script src="<?php echo base_url();?>assets/plugins/bootstrap/js/bootstrap.min.js"></script>
	<script src="<?php echo base_url();?>assets/plugins/slimscroll/jquery.slimscroll.min.js"></script>
	<script src="<?php echo base_url();?>assets/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
	
	<script src="<?php echo base_url();?>assets/js/form-plugins.demo.js"></script>
	<script src="<?php echo base_url();?>assets/js/dashboard.js"></script>
	<script src="<?php echo base_url();?>assets/js/apps.js"></script>

	<script src="<?php echo base_url();?>assets/plugins/DataTables/media/js/jquery.dataTables.js"></script>
    <script src="<?php echo base_url();?>assets/plugins/DataTables/media/js/dataTables.bootstrap.min.js"></script>
    <script src="<?php echo base_url();?>assets/plugins/DataTables/extensions/Responsive/js/dataTables.responsive.min.js"></script>
    <script src="<?php echo base_url();?>assets/js/table-manage-default.demo.min.js"></script>

    <script src="<?php echo base_url();?>assets/plugins/gritter/js/jquery.gritter.js"></script>
	<script src="<?php echo base_url();?>assets/plugins/bootstrap-sweetalert/sweetalert.js"></script>
	<script src="<?php echo base_url();?>assets/js/ui-modal-notification.demo.js"></script>
	<script src="<?php echo base_url();?>assets/js/jquery.PrintArea.js"></script>
	
	
	<script type="text/javascript">
		
	$(document).ready(function() {
		$(document).on('show.bs.modal', '.modal', function (event) {
    		var zIndex = 1040 + (10 * $('.modal:visible').length);
        	$(this).css('z-index', zIndex);
        	setTimeout(function() { $('.modal-backdrop').not('.modal-stack').css('z-index', zIndex - 1).addClass('modal-stack'); }, 0);
		});
	});

	function pesan($judul,$pesan,$gambar){
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

	<script>
		$(document).ready(function() {
			App.init();
            TableManageDefault.init();
            FormPlugins.init();
		});
	</script>
</body>
</html>
