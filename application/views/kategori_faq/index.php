<div id="content" class="content">
	<h1 class="page-header">Kategori Frequently Asked Questions (FAQ)</h1>
		<div class="row" id="row">
			<div class="col-md-12">
				<div class="panel panel-inverse">
					<div class="panel-heading">
					<button onclick="BukaModal('<?php echo $kategori_id; ?>')" class="btn btn-success btn-sm m-r-5">Tambah</button>
					</div>
					<div class="panel-body">
						<table id="table_faq" class="table table-striped table-bordered">
						<thead>
							<tr>
								<th width="5%" nowrap><div align="center">No</div></th>
								<th width="65%" nowrap><div align="center">Kategori FAQ</div></th>
								<th width="15%" nowrap><div align="center">Aktif</div></th>
								<th width="10%"></th>
							</tr>
						</thead>
						</table>
					</div>
				</div>
			</div>
		</div>
</div>

<!-- #modal-dialog -->
<div class="modal fade" id="modal_kategori">
<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header"><h4 class="modal-title" id="judul"></h4></div>
			<div class="modal-body">
				<div class="panel-body">
				<form class="form-horizontal" id="form-pengguna">
					<div class="form-group">
						<input type="hidden" id="kategori_id"/>
						<label class="col-md-3 control-label">Kategori FAQ *</label>
						<div class="col-md-9"><input type="text" class="form-control" required id="kategori"/></div>
					</div>
					<div class="form-group">
						<label class="col-md-3 control-label">Status *</label>
						<div class="col-md-9" id="_status"></div>
					</div>
				</form>
				</div>
				<div class="modal-footer">
					<button onclick="TutupModal()" data-dismiss="modal" class="btn btn-sm btn-white">Kembali</button>
					<span id="tombol_hapus"></span>
					<button onclick="SimpanModal()" type="submit" data-dismiss="modal" class="btn btn-sm btn-success">Simpan</button>
				</div>
			</div>
		</div>
</div>
</div>


<script type="text/javascript">
var table;
$(document).ready(function() {
	table = $('#table_faq').DataTable({ 
		"processing": true,
		"serverSide": true,
		"bFilter": false,
		"bSort": false,
		"bInfo" : false,
		"ajax": {
			"url": "<?php echo base_url()?>kategori_faq_data",
			"type": "POST"
		},
	});
});

function TutupModal(){
	table.ajax.reload(null,false);
}


function BukaModal(id){
	$.post('<?php echo base_url()?>kategori_faq_add', { 
		id:id
	}, function(response){
		var json = jQuery.parseJSON(response);
		if(json.st==1){
			$('#kategori').val("");
		   	$('#_status').html("");
			$('#judul').html("");
			$('#kategori_id').val("");
			$('#tombol_hapus').html("");
			$('#tombol_hapus').append(json.tombol_hapus);
			$('#kategori_id').val(json.kategori_id);
			$('#kategori').val(json.nama);
			$('#_status').append(json.status);
			$('#judul').append(json.judul);
			$('#modal_kategori').modal({ show: true });        
		}else if(json.st==0){
			alert(json.msg);
			table.ajax.reload(null,false);
		}
	});
}

function HapusModal(){
	var kategori_id=$('#kategori_id').val();
	$.post('<?php echo base_url()?>kategori_faq_hapus', { 
		kategori_id:kategori_id
	}, function(response){
		var json = jQuery.parseJSON(response);
		if(json.st==1){
			table.ajax.reload(null,false); 
			return;
		}else if(json.st==0){
			alert(json.msg);
			table.ajax.reload(null,false);
			return;
		}
	});
}

function SimpanModal(){
	var kategori_id=$('#kategori_id').val();
	var kategori=$('#kategori').val();
	var status=$('#status').val();
	$.post('<?php echo base_url()?>kategori_faq_simpan', { 
		kategori_id:kategori_id,
		kategori:kategori,
		status:status
	}, function(response){
		var json = jQuery.parseJSON(response);
		if(json.st==1){
			table.ajax.reload(null,false); 
		}else if(json.st==0){
			alert(json.msg);
			table.ajax.reload(null,false);
			return;
		}
	});
}
</script>







