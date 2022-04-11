<div class="container-fluid page-body-wrapper">
	<div class="main-panel">
		<div class="content-wrapper">
			<div class="card">
				<div class="card-body">
					<div class="row">
						<div class="col-md-10">
							<h4 class="card-title">FORMAT PENOMORAN SURAT</h4>
						</div>
					</div>
					<div class="row">
						<div class="col-12">
							<div class="table-responsive">
								<table id="table_penomoran" class="table">
									<thead>
										<tr>
											<th>NO</th>
											<th>KODE PENOMORAN</th>
											<th style="width: 35%;">NAMA</th>
											<th style="width: 15%;">AKTIF</th>
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
<div class="modal fade" id="modal_penomoran">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="judul">DETIL NOMOR SURAT</h4>
			</div>
			<div class="modal-body">
				<div class="panel-body">
					<form class="form-horizontal">
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<input type="hidden" id="penomoran_id" />
									<label class="col-md-6 control-label">Kode Nomor Surat</label>
									<div class="col-md-12"><input type="text" id="kode" class="form-control" required disabled /></div>
								</div>
								<div class="form-group">
									<label class="col-md-6 control-label">Keterangan</label>
									<div class="col-md-12"><textarea class="form-control" id="keterangan" rows="5"></textarea></div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label class="col-md-6 control-label">Nama Kode</label>
									<div class="col-md-12"><input type="text" id="nama" class="form-control" required /></div>
								</div>
								<div class="form-group">
									<label class="col-md-6 control-label">Aktif</label>
									<div class="col-md-12" id="status_"></div>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
			<div class="modal-footer">
				<button onclick="TutupModal()" data-dismiss="modal" class="btn btn-sm btn-white">Kembali</button>
				<span id="hapus"></span>
				<button onclick="SimpanModal()" type="submit" class="btn btn-sm btn-success">Simpan</button>
			</div>
		</div>
	</div>
</div>
</div>