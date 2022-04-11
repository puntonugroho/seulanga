<div class="container-fluid page-body-wrapper">
	<div class="main-panel">
		<div class="content-wrapper">
			<div class="card">
				<div class="card-body">
					<div class="row">
						<div class="col-md-10">
							<h4 class="card-title">DATA PENGGUNA</h4>
						</div>
						<div class="col-md-2" style="display: flex; flex-direction: row;justify-content: center;align-items:center;margin-top:-3px;margin-bottom:5px">
							<button onclick="BukaModal('<?php echo $userid; ?>')" class="btn btn-primary btn-sm btn-block">Tambah</button>
						</div>
					</div>
					<div class="row">
						<div class="col-12">
							<div class="table-responsive">
								<table id="table_pengguna" class="table">
									<thead>
										<tr>
											<th>NO</th>
											<th>NAMA</th>
											<th>USERNAME</th>
											<th>EMAIL</th>
											<th>HAK AKSES</th>
											<th>BLOKIR</th>
											<th>AKSI</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- partial:partials/_footer.html -->
		<footer class="footer">
			<div class="footer-wrap">
				<div class="d-sm-flex justify-content-center justify-content-sm-between">
					<span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright © <a href="https://www.ms-aceh.go.id/" target="_blank">MS Aceh </a>2022</span>
					<span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center">MAHKAMAH SYAR'IYAH ACEH </span>
				</div>
			</div>
		</footer>
		<!-- partial -->
	</div>
</div>

<!-- #modal-dialog -->
<div class="modal fade" id="modal-pengguna">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="judul"></h4>
			</div>
			<div class="modal-body">
				<div class="panel-body">
					<form class="form-horizontal" id="form-pengguna">
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<input type="hidden" id="userid" />
									<label class="col-md-6 control-label">Pegawai</label>
									<div class="col-md-12" id="pegawai_"></div>
								</div>
								<div class="form-group">
									<label class="col-md-6 control-label">Username *</label>
									<div class="col-md-12"><input type="text" class="form-control" required id="username" /></div>
								</div>
								<div class="form-group">
									<label class="col-md-6 control-label">Password *</label>
									<div class="col-md-12"><input id="password" data-toggle="password" required data-placement="after" class="form-control" type="password" /></div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label class="col-md-6 control-label">Ulang Password *</label>
									<div class="col-md-12"><input id="ulang_password" data-toggle="password" required data-placement="after" class="form-control" type="password" /></div>
								</div>
								<div class="form-group">
									<label class="col-md-6 control-label">E-Mail *</label>
									<div class="col-md-12"><input type="text" class="form-control" id="email" required data-parsley-required="true" /></div>
								</div>
								<div class="form-group">
									<label class="col-md-6 control-label">Blokir Pengguna *</label>
									<div class="col-md-12" id="status"></div>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button onclick="TutupModal()" data-dismiss="modal" class="btn btn-sm btn-white">Kembali</button>
					<button onclick="SimpanModal()" type="submit" data-dismiss="modal" class="btn btn-sm btn-success">Simpan</button>
				</div>
			</div>
		</div>
	</div>
</div>