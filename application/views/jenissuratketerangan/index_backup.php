<div id="content" class="content">
	<h1 class="page-header">JENIS SURAT KETERANGAN</h1>
	<div class="row" id="row">
		<div class="col-md-12">
		<div class="panel panel-inverse">
			<div class="panel-heading">
				<button onclick="BukaModal('<?php echo $register_id; ?>')" class="btn btn-success btn-sm m-r-5">Tambah</button>
			</div>
			<div class="panel-body">
				<table id="table_jenissuratketerangan" class="table table-striped table-bordered">
				<thead>
					<tr>
						<th width="5%"><div align="center">NO</div></th>
						<th width="10%"><div align="center">KODE</div></th>
						<th width="65%"><div align="center">NAMA</div></th>
						<th width="10%"><div align="center">AKTIF</div></th>
						<th width="10%"></th>
					</tr>
				</thead>
				</table>
			</div>
		</div>
		</div>
	</div>
</div>


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


<script type="text/javascript">
$(document).ready(function() {
	table = $('#table_jenissuratketerangan').DataTable({ 
		"processing": true,
		"serverSide": true,
		"bSort": false,
		"bInfo": false,
		"ajax": {
			"url": "<?php echo base_url()?>jenissuratketerangan_data",
			"type": "POST"
		},
	});
});


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

document.getElementById('dokumen').addEventListener('change', checkFile, false);
dokumen.addEventListener('change', checkFile, false);
function checkFile(e) {
    var file_list = e.target.files;
    for (var i = 0, file; file = file_list[i]; i++) {
        var sFileName = file.name;
        var sFileExtension = sFileName.split('.')[sFileName.split('.').length - 1].toLowerCase();
        var iFileSize = file.size;
        var iConvert = (file.size / 10485760).toFixed(2);

        if (!(sFileExtension === "rtf") || iFileSize > 10485760) {
            txt = "Jenis File : " + sFileExtension + "<br/><br/>";
            txt += "Ukuran: " + iConvert + " MB <br/><br/>";
            txt += "Pastikan Format Dokumen rtf dengan ukuran maksimal 10MB.\n\n";
            pesan('PERINGATAN',txt,'');
            $("#dokumen").val("");
        }
    }
}
</script>
