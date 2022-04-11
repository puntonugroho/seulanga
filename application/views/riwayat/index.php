<div id="content" class="content">
	<h1 class="page-header">Riwayat Pengguna</h1>
    	<div class="row" id="row">
        		<div class="col-md-12">
            		<div class="panel panel-inverse">
                			<div class="panel-body">
                			<table id="table_riwayat" class="table table-striped table-bordered">
                    			<thead>
                        				<tr>
                        					<th width="5%" nowrap><div align="center">No</div></th>
                            				<th width="15%" nowrap><div align="center">Waktu</div></th>
                            				<th width="15%" nowrap><div align="center">Alamat IP</div></th>
                            				<th width="10%" nowrap><div align="center">Username</div></th>
                            				<th width="10%" nowrap><div align="center">Aksi</div></th>
                                            <th width="40%" nowrap><div align="center">Judul</div></th>
                            				<th width="5%"></th>
                        				</tr>
                    			</thead>
                			</table>
                			</div>
            		</div>
        		</div>
    	</div>
</div>

<!-- #modal-dialog -->
<div class="modal fade" id="modal_riwayat">
<div class="modal-dialog">
	<div class="modal-content">
           	<div class="modal-header"><h4 class="modal-title" id="judul"></h4></div>
           	<div class="modal-body">
           		<div class="panel-body">
           		<form class="form-horizontal" id="form-pengguna">
	                    	<div class="form-group">
	                        		<label class="col-md-3 control-label">Waktu</label>
	                        		<div class="col-md-9" id="_datetime"></div>
	                    	</div>
                    		<div class="form-group">
                        			<label class="col-md-3 control-label">Alamat IP</label>
                        			<div class="col-md-9" id="_ipaddress"></div>
                    		</div>
                    		<div class="form-group">
                        			<label class="col-md-3 control-label">Username</label>
                        			<div class="col-md-9" id="_username"></div>
                    		</div>
                    		<div class="form-group">
                        			<label class="col-md-3 control-label">Nama Tabel</label>
                        			<div class="col-md-9" id="_tablename"></div>
                    		</div>
                    		<div class="form-group">
                        			<label class="col-md-3 control-label">Aksi</label>
                        			<div class="col-md-9" id="_action"></div>
                    		</div>
                    		<div class="form-group">
                        			<label class="col-md-3 control-label">Detil</label>
                        			<div class="col-md-9" id="_description"></div>
                    		</div>
                	</div>
            	<div class="modal-footer">
                	<button onclick="TutupModal()" data-dismiss="modal" class="btn btn-sm btn-white">Kembali</button>		
            	</div>
        	</div>
    	</div>
</div>

<script type="text/javascript">
var table;
$(document).ready(function() {
	table = $('#table_riwayat').DataTable({ 
		"processing": true,
        "serverSide": true,
        "iDisplayLength" : 10,
        "bSort": false,
        "bInfo" : false,
        "order": [],
    	"ajax": {
    	   "url": "<?php echo base_url()?>riwayat_data",
        	"type": "POST"
  		},
	});
});

function TutupModal(){
    table.ajax.reload(null,false);
}


function BukaModal(id){
	$.post('<?php echo base_url()?>riwayat_detil', { 
        		id:id
    	}, function(response){
        		var json = jQuery.parseJSON(response);
        		if(json.st==1){
			$('#_datetime').html('');
                                       $('#_ipaddress').html('');
                    		$('#_username').html('');
                    		$('#_tablename').html('');
                    		    		$('#_action').html('');
                    		$('#_description').html('');
        			
                    		$('#_datetime').append(json.datetime);
                    		$('#_ipaddress').append(json.ipaddress);
                    		$('#_username').append(json.username);
                    		$('#_tablename').append(json.tablename);
                    		
                    		$('#_action').append(json.action);
                    		$('#_description').append(json.description);
                    		$('#judul').append(json.judul);
                    		$('#modal_riwayat').modal({ show: true });        
        		}else if(json.st==0){
            			table.ajax.reload(null,false);
        		}
    	});
}


</script>







