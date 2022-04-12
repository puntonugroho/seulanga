<div class="container-fluid page-body-wrapper">
	<div class="main-panel">
		<div class="content-wrapper">
			<div class="card">
				<div class="card-body">
					<div class="row">
						<div class="col-md-10">
							<h4 class="card-title">DATA PEGAWAI</h4>
						</div>
						<div class="col-md-2" style="display: flex; flex-direction: row;justify-content: center;align-items:center;margin-top:-3px;margin-bottom:5px">
							<button onclick="BukaModal('<?php echo $id; ?>')" class="btn btn-primary btn-sm btn-block">Tambah</button>
						</div>
					</div>
					<div class="row">
						<div class="col-12">
							<div class="table-responsive">
								<table id="table_pegawai" class="table">
									<thead>
										<tr>
											<th>NO</th>
											<th>NIP</th>
											<th>NAMA</th>
											<th>GOLONGAN/PANGKAT</th>
											<th>JABATAN</th>
											<th>AKTIF</th>
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
					<span class="text text-center text-sm-left d-block d-sm-inline-block" style="color: #fff;">Copyright © <a href="https://www.ms-aceh.go.id/" target="_blank" style="color: #f0c26a;">MS Aceh </a>2022</span>
					<span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center" style="color: #fff;">MAHKAMAH SYAR'IYAH ACEH </span>
				</div>
			</div>
		</footer>
		<!-- partial -->
	</div>
</div>


<!-- #modal-dialog -->
<div class="modal fade" id="modal-pegawai">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="judul">DATA PEGAWAI</h4>
			</div>
			<div class="modal-body">
				<div class="panel-body">
					<form class="form-horizontal" id="form-pegawai">
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<input type="hidden" id="id" />
									<label class="col-md-6 control-label">NIP</label>
									<div class="col-md-12"><input type="text" class="form-control" required id="nip" /></div>
								</div>
								<div class="form-group">
									<label class="col-md-6 control-label">Nama Gelar <font color="red">*</font></label>
									<div class="col-md-12"><input type="text" class="form-control" required id="nama_gelar" /></div>
								</div>
								<div class="form-group">
									<label class="col-md-6 control-label">Golongan <font color="red">*</font></label>
									<div class="col-md-12" id="golongan_"></div>
								</div>
								<div class="form-group">
									<label class="col-md-6 control-label">Pangkat <font color="red">*</font></label>
									<div class="col-md-12"><input type="text" class="form-control" required id="pangkat" disabled /></div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label class="col-md-6 control-label">Jabatan <font color="red">*</font></label>
									<div class="col-md-12" id="jabatan_"></div>
								</div>
								<div class="form-group">
									<label class="col-md-6 control-label">Alamat</label>
									<div class="col-md-12"><input type="text" class="form-control" required id="alamat" /></div>
								</div>
								<div class="form-group">
									<label class="col-md-6 control-label">Aktif <font color="red">*</font></label>
									<div class="col-md-12" id="aktif_"></div>
								</div>
							</div>
						</div>
					</form>
					<div class="modal-footer">
						<button onclick="TutupModal()" data-dismiss="modal" class="btn btn-sm btn-white">Kembali</button>
						<?php if(in_array($this->session->userdata('group_id'), $this->session->userdata('kewenangan_hapus'))) {?>
							<button onclick="HapusModal(1)" data-dismiss="modal" class="btn btn-sm btn-danger">Hapus</button>
								<?php } ?>
						<button onclick="SimpanModal()" type="submit" data-dismiss="modal" class="btn btn-sm btn-success">Simpan</button>

					</div>
				</div>
			</div>
		</div>