<div class="container-fluid page-body-wrapper">
	<div class="main-panel">
		<div class="content-wrapper">
			<div class="card">
				<div class="card-body">
					<div class="row">
						<div class="col-md-8">
							<h4 class="card-title">REGISTER SURAT KELUAR</h4>
						</div>
						<div class="col-md-4" style="display: flex; flex-direction: row;justify-content: center;align-items:center;margin-top:-3px;margin-bottom:5px">
							<?php if (in_array($this->session->userdata('group_id'), $this->session->userdata('kewenangan_persuratan'))) { ?>
								<button onclick="BukaModal('<?php echo $register_id; ?>')" class="btn btn-primary btn-sm mr-2 btn-block">Tambah Baru</button>
							<?php } ?>
							<button onclick="ModalPencarian('<?php echo $register_id; ?>')" class="btn btn-primary btn-sm mr-2 btn-block ">Pencarian Detil</button>
							<button onclick="ModalPeriodeCetakRegister('<?php echo $register_id; ?>')" class="btn btn-primary btn-sm btn-block">Cetak Register</button>
						</div>
					</div>
					<div class="row">
						<div class="col-12">
							<div class="table-responsive">
								<table id="table_suratkeluar" class="table">
									<thead>
										<tr>
											<th>NO</th>
											<th>TANGGAL REGISTER</th>
											<th>NOMOR SURAT</th>
											<th>JENIS SURAT</th>
											<th>TUJUAN KIRIM</th>
											<th>STATUS </th>
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
					<span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright © <a href="https://www.ms-aceh.go.id/" target="_blank">MS Lhoksukon </a>2022</span>
					<span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center">MAHKAMAH SYAR'IYAH ACEH </span>
				</div>
			</div>
		</footer>
		<!-- partial -->
	</div>
</div>

<div class="modal fade" id="modal_pencarian">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">PENCARIAN DETIL</h4>
			</div>
			<div class="modal-body">
				<div class="panel-body">
					<form class="form-horizontal">
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label class="col-md-6 control-label">Tahun Register</label>
									<div class="col-md-12" id="tahun_register_cari_"></div>
								</div>
								<div class="form-group">
									<label class="col-md-6 control-label">Surat Dari</label>
									<div class="col-md-12" id="jabatan_struktural_cari_"></div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label class="col-md-6 control-label">Bulan Register</label>
									<div class="col-md-12" id="bulan_register_cari_"></div>
								</div>

								<div class="form-group">
									<label class="col-md-6 control-label">Jenis Pengiriman</label>
									<div class="col-md-12" id="jenis_pengiriman_cari_"></div>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
			<div class="modal-footer">
				<button onclick="TutupModal()" data-dismiss="modal" class="btn btn-sm btn-white">Kembali</button>
				<button onclick="CariDetil()" type="submit" class="btn btn-sm btn-success">Cari Detil</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="modal_periode_cetak_register">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">PERIODE CETAK REGISTER</h4>
			</div>
			<div class="modal-body">
				<div class="panel-body">
					<form class="form-horizontal">
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label class="col-md-3 control-label">Bulan <font color='red'>*</font></label>
									<div class="col-md-9" id="bulan_register_periode_cetak_"></div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label class="col-md-3 control-label">Tahun <font color='red'>*</font></label>
									<div class="col-md-9" id="tahun_register_periode_cetak_"></div>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
			<div class="modal-footer">
				<button onclick="TutupModal()" data-dismiss="modal" class="btn btn-sm btn-white">Kembali</button>
				<button onclick="CetakRegister()" type="submit" class="btn btn-sm btn-success">Cetak</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="modal_cetak_register">
	<div class="modal-dialog" style="width: 95%;">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">REGISTER SURAT KELUAR</h4><br />
				<div>
					<button onclick="TutupModal()" data-dismiss="modal" class="btn btn-sm btn-white">Kembali</button>
					<a href="javascript:void(0);"><button id="printRegisterButton" class="btn btn-sm btn-success">Cetak Register</button></a>
				</div>
			</div>
			<div class="modal-body printableAreaRegister">
				<table id="data_table_fixed_header" class="table table-striped table-bordered">
					<thead>
						<tr>
							<td width="5%">
								<div align='center'>NO</div>
							</td>
							<td width="10%">
								<div align='center'>NOMOR SURAT</div>
							</td>
							<td width="10%">
								<div align='center'>TANGGAL REGISTER</div>
							</td>
							<td width="25%">
								<div align='center'>DARI BAGIAN</div>
							</td>
							<td width="15%">
								<div align='center'>JENIS SURAT</div>
							</td>
							<td width="15%">
								<div align='center'>JENIS PENGIRIMAN</div>
							</td>
							<td width="10%">
								<div align='center'>TANGGAL KIRIM</div>
							</td>
						</tr>
					</thead>
					<tbody id="data_register_surat_keluar"></tbody>
				</table>
			</div>
		</div>
	</div>
</div>

<!-- #modal-dialog -->
<div class="modal fade" id="modal_suratkeluar">
	<div class="modal-dialog" style="width: 85%;">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="judul"></h4>
			</div>
			<div class="modal-body" style="padding:12px">
				<div class="panel-body">
					<form class="form-horizontal" method="POST" action="<?php echo base_url(); ?>suratkeluar_simpan" enctype="multipart/form-data">
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<input type="hidden" name="register_id" id="register_id" />
									<input type="hidden" name="nomor_index" id="nomor_index" />
									<label class="col-md-6 control-label">Tanggal Register</label>
									<!-- <div class="col-md-12"><input type="text" name="tanggal_register" class="form-control" required id="datepicker-default" /></div> -->
									<div class="col-md-12">
										<div id="datepicker-popup" class="input-group date datepicker">
											<input type="text" name="tanggal_register" class="form-control" required id="datepicker-default" />
											<span class="input-group-addon input-group-append border-left">
												<span class="mdi mdi-calendar input-group-text"></span>
											</span>
										</div>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-6 control-label">Dari Bagian</label>
									<div class="col-md-12" id="sumber_surat_"></div>
								</div>
								<div class="form-group">
									<label class="col-md-6 control-label">Jenis Surat</label>
									<div class="col-md-12" id="jenis_surat_"></div>
								</div>
								<div class="form-group">
									<label class="col-md-6 control-label">Keterangan Jenis Surat</label>
									<div class="col-md-12"><textarea class="form-control" id="keterangan_jenis_surat" rows="4" disabled></textarea></div>
								</div>
								<div class="form-group">
									<label class="col-md-6 control-label">Nomor Surat</label>
									<div class="col-md-12"><input type="text" class="form-control" required name="nomor_surat" id="nomor_surat" /></div>
								</div>
								<div class="form-group">
									<label class="col-md-6 control-label">Jenis Tujuan Surat</label>
									<div class="col-md-12" id="jenis_tujuan_surat_"></div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label class="col-md-6 control-label">Tujuan Surat</label>
									<div class="col-md-12"><input type="text" class="form-control" required name="tujuan" id="tujuan" /></div>
								</div>
								<div class="form-group">
									<label class="col-md-6 control-label">Perihal</label>
									<div class="col-md-12" id="pegawai_"><textarea class="form-control" name="perihal" id="perihal" rows="6"></textarea></div>
								</div>
								<div class="form-group">
									<label class="col-md-6 control-label">Keterangan</label>
									<div class="col-md-12"><textarea class="form-control" id="keterangan" name="keterangan" rows="4"></textarea></div>
								</div>
								<div class="form-group">
									<label class="col-md-6 control-label">Jenis Pengiriman</label>
									<div class="col-md-12" id="jenis_pengiriman_"></div>
								</div>
								<div class="form-group">
									<label class="col-md-6 control-label">Dokumen Elektronik</label>
									<div class="col-md-12">
										<input type="file" class="form-control" name="dokumen" id="dokumen" />
									</div>
								</div>
							</div>
						</div>
				</div>
				<div class="modal-footer">
					<button onclick="TutupModal()" data-dismiss="modal" class="btn btn-sm btn-white">Kembali</button>
					<span id="hapus"></span>
					<button type="submit" class="btn btn-sm btn-success">Simpan</button>
				</div>
				</form>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="modal_suratkeluar_detil">
	<div class="modal-dialog" style="width: 95%;">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="judul_detil"></h4>
			</div>
			<div class="modal-body">
				<div class="panel-body">
					<div class="col-md-12" style="width:100%;">
						<div class="row">
							<div class="col-md-9">
								<button onclick="TutupModal()" data-dismiss="modal" class="btn btn-sm btn-white btn-block text-left">Kembali</button>
							</div>
							<div class="col-md-3" style="display: flex; flex-direction: row;justify-content: center;align-items:center;margin-top:-3px;margin-bottom:5px">
								<span id="tombol_edit_surat_keluar" class="mr-2"></span>
								<span id="tombol_kirim_surat_keluar" class="mr-2"></span>
								<span id="tombol_hapus_surat_keluar"></span>
							</div>
						</div>
						<br />
						<div id=#status style="display:none"></div>
						<ul class="nav nav-tabs" role="tablist">
							<li class="nav-item">
								<a class="nav-link active" data-toggle="tab" href="#default-tab-1" role="tab" aria-controls="home-1" aria-selected="true">Data Surat</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" data-toggle="tab" href="#default-tab-2" role="tab" aria-controls="profile-1" aria-selected="false">Dokumen Elektronik</a>
							</li>
						</ul>
						<div class="tab-content">
							<div class="tab-pane fade show active" id="default-tab-1">
								<div class="table-responsive">
									<table class="table table-bordered">
										<thead>
											<tr>
												<th width="25%">
													<div align='center'>TANGGAL REGISTER</div>
												</th>
												<th width="25%">
													<div align='center'>TANGGAL PENGIRIMAN</div>
												</th>
												<th width="25%">
													<div align='center'>STATUS SURAT</div>
												</th>
												<th width="25%">
													<div align='center'>WAKTU PENGIRIMAN</div>
												</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>
													<div align='center'><span id=tanggal_register_detil></span></div>
												</td>
												<td>
													<div align='center'><span id=tanggal_kirim_detil></span></div>
												</td>
												<td>
													<div align='center'><span id=status_pelaksanaan_detil></span></div>
												</td>
												<td>
													<div align='center'><span id=waktu_pelaksanaan_detil></span> Hari</div>
												</td>
											</tr>
										</tbody>
									</table>
									<table class="table table-hover">
										<tbody>
											<tr>
												<td class="col-md-2">Nomor Surat</td>
												<td class="col-md-1"><b>:</b></td>
												<td class="col-md-9"><span id=nomor_surat_detil></span></td>
											</tr>
											<tr>
												<td class="col-md-2">Dari Bagian</td>
												<td class="col-md-1"><b>:</b></td>
												<td class="col-md-9"><span id=dari_bagian_detil></span></td>
											</tr>
											<tr>
												<td class="col-md-2">Jenis Tujuan</td>
												<td class="col-md-1"><b>:</b></td>
												<td class="col-md-9"><span id=jenis_tujuan_surat_detil></span></td>
											</tr>
											<tr>
												<td class="col-md-2">Tujuan</td>
												<td class="col-md-1"><b>:</b></td>
												<td class="col-md-9"><span id=tujuan_detil></span></td>
											</tr>
											<tr>
												<td class="col-md-2">Perihal</td>
												<td class="col-md-1"><b>:</b></td>
												<td class="col-md-9"><span id=perihal_detil></span></td>
											</tr>
											<tr>
												<td class="col-md-2">Jenis Pengiriman</td>
												<td class="col-md-1"><b>:</b></td>
												<td class="col-md-9"><span id=jenis_ekspedisi_detil></span></td>
											</tr>
											<tr>
												<td class="col-md-2">Keterangan</td>
												<td class="col-md-1"><b>:</b></td>
												<td class="col-md-9"><span id=keterangan_detil></span></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<div class="tab-pane fade" id="default-tab-2">
								<span id="dokumen_elektronik_detil"></span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="modal_suratkeluar_kirim">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="judul_kirim"></h4>
			</div>
			<div class="modal-body">
				<div class="panel-body">
					<div class="form-group">
						<input type="hidden" id="register_id_pengiriman">
						<!-- <label class="col-md-4 control-label">Tanggal Pengiriman</label>
						<div class="col-md-8"><input type="text" class="form-control" required name="tanggal_pengiriman" id="datepicker-default2" /></div> -->

						<label class="col-md-6 control-label">Tanggal Pengiriman</label>
						<div class="col-md-10">
							<div id="datepickers-popup2" class="input-group date datepicker">
								<input type="text" name="tanggal_pengiriman" class="form-control" id="datepicker-default2" required/>
								<span class="input-group-addon input-group-append border-left">
									<span class="mdi mdi-calendar input-group-text"></span>
								</span>
							</div>
						</div>

					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button onclick="TutupModal()" data-dismiss="modal" class="btn btn-sm btn-white">Batal</button>
				<button onclick="SimpanModalPengiriman()" type="submit" class="btn btn-sm btn-success">Simpan</button>
			</div>
		</div>
	</div>
</div>