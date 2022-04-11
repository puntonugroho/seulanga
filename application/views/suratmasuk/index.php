<div class="container-fluid page-body-wrapper">
	<div class="main-panel">
		<div class="content-wrapper">
			<div class="card">
				<div class="card-body">
					<!-- <div style="float:right;text-align:center;margin-bottom:3px;"> -->
					<div class="row">
						<div class="col-md-8">
							<h4 class="card-title">REGISTER SURAT MASUK</h4>
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
								<table id="table_pegawai" class="table">
									<thead>
										<tr>
											<th>NO</th>
											<th>TANGGAL REGISTER</th>
											<th>NOMOR SURAT</th>
											<th>NOMOR AGENDA</th>
											<th>SIFAT SURAT</th>
											<th>PENGIRIM</th>
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
						<div class="form-group">
							<label class="col-md-6 control-label">Tahun Register</label>
							<div class="col-md-12" id="tahun_register_"></div>
						</div>
						<div class="form-group">
							<label class="col-md-6 control-label">Tujuan Jabatan</label>
							<div class="col-md-12" id="tujuan_jabatan_"></div>
						</div>
					</form>

					<!-- <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Tahun Register</label>
                          <div class="col-sm-9">
                            <input type="text" class="form-control">
                          </div>
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Tujuan Jabatan</label>
                          <div class="col-sm-9">
                            <input type="text" class="form-control">
                          </div>
                        </div>
                      </div> -->



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
						<div class="form-group">
							<label class="col-md-6 control-label">Bulan <font color='red'>*</font></label>
							<div class="col-md-12" id="bulan_register_periode_cetak_"></div>
						</div>
						<div class="form-group">
							<label class="col-md-6 control-label">Tahun <font color='red'>*</font></label>
							<div class="col-md-12" id="tahun_register_periode_cetak_"></div>
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
				<h4 class="modal-title">REGISTER SURAT MASUK</h4><br />
				<div><button onclick="TutupModal()" data-dismiss="modal" class="btn btn-sm btn-white">Kembali</button>
					<?php if (in_array($this->session->userdata('group_id'), $this->session->userdata('kewenangan_persuratan'))) { ?>
						<a href="javascript:void(0);"><button id="printRegisterButton" class="btn btn-sm btn-success">Cetak Register</button></a>
					<?php } ?>
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
								<div align='center'>NOMOR AGENDA</div>
							</td>
							<td width="10%">
								<div align='center'>TANGGAL REGISTER</div>
							</td>
							<td width="10%">
								<div align='center'>TANGGAL SURAT</div>
							</td>
							<td width="25%">
								<div align='center'>PENGIRIM</div>
							</td>
							<td width="25%">
								<div align='center'>PERIHAL</div>
							</td>
							<td width="10%">
								<div align='center'>STATUS</div>
							</td>
						</tr>
					</thead>
					<tbody id="data_register_surat_masuk"></tbody>
				</table>
			</div>
		</div>
	</div>
</div>


<div class="modal fade" id="modal-suratmasuk">
	<div class="modal-dialog" style="width: 85%;">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="judul"></h4>
			</div>
			<div class="modal-body" style="padding:12px">
				<div class="panel-body">
					<form class="form-horizontal" method="POST" action="<?php echo base_url(); ?>suratmasuk_simpan" enctype="multipart/form-data">
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<input type="hidden" name="register_id" id="register_id" />
									<input type="hidden" name="nomor_index" id="nomor_index" />
									<label class="col-md-6 control-label">Tanggal Diterima</label>
									<div class="col-md-12">
										<div id="datepicker-popup" class="input-group date datepicker">
											<input type="text" name="tanggal_register" onChange="GetNomorAgendaBaru()" class="form-control" required id="datepicker-default" />
											<span class="input-group-addon input-group-append border-left">
												<span class="mdi mdi-calendar input-group-text"></span>
											</span>
										</div>
									</div>
								</div>
								<div class="form-group" id="KolomGenerateNomor">
									<label class="col-md-6 control-label">Generate Nomor <font color="red">*</font></label>
									<div class="col-md-12"><span id="generate_nomor_"></span></div>
								</div>
								<div class="form-group" id="KolomNomorManual">
									<label class="col-md-6 control-label">Nomor Agenda <font color="red">*</font></label>
									<div class="col-md-12">
										<div class="input-group">
											<input type="text" class="form-control" required name="nomor_index_manual" id="nomor_index_manual" />
											<span class="input-group-addon">/</span>
											<input type="text" class="form-control" required name="kode_nomor_manual" id="kode_nomor_manual" />
										</div>
									</div>
								</div>
								<div class="form-group" id="KolomNomorOtomatis">
									<label class="col-md-6 control-label">Nomor Agenda <font color="red">*</font></label>
									<div class="col-md-12">
										<input type="text" class="form-control" required id="nomor_agenda_show" disabled />
										<input type="hidden" name="nomor_agenda" class="form-control" id="nomor_agenda" />
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-6 control-label">Sifat Surat <font color="red">*</font></label>
									<div class="col-md-12" id="jenis_surat_"></div>
								</div>
								<div class="form-group">
									<label class="col-md-6 control-label">Tanggal Surat <font color="red">*</font></label>
									<div class="col-md-12">
										<div id="datepickers-popup2" class="input-group date datepicker">
											<input type="text" name="tanggal_surat" class="form-control" required id="datepicker-default2" />
											<span class="input-group-addon input-group-append border-left">
												<span class="mdi mdi-calendar input-group-text"></span>
											</span>
										</div>
									</div>
								</div>
								<!-- <div class="col-md-12">
										<div id="datepicker-popup" class="input-group date datepicker">
											<input type="text" name="tanggal_register" onChange="GetNomorAgendaBaru()" class="form-control" required id="datepicker-default" />
											<span class="input-group-addon input-group-append border-left">
											<span class="mdi mdi-calendar input-group-text"></span>
										</span>
										</div>
									</div> -->

								<div class="form-group">
									<label class="col-md-6 control-label">Distribusi Kepada <font color="red">*</font></label>
									<div class="col-md-12" id="jabatan_"></div>

								</div>
								<div class="form-group">
									<label class="col-md-6 control-label">Nomor Surat <font color="red">*</font></label>
									<div class="col-md-12"><input type="text" class="form-control" required name="nomor_surat" id="nomor_surat" /></div>
								</div>
								<div class="form-group">
									<label class="col-md-6 control-label">Pengirim <font color="red">*</font></label>
									<div class="col-md-12"><input type="text" class="form-control" required name="pengirim" id="pengirim" /></div>
								</div>

							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label class="col-md-6 control-label">Perihal <font color="red">*</font></label>
									<div class="col-md-12" id="pegawai_"><textarea class="form-control" name="perihal" id="perihal" rows="6"></textarea></div>
								</div>
								<div class="form-group">
									<label class="col-md-6 control-label">Keterangan</label>
									<div class="col-md-12"><textarea class="form-control" id="keterangan" name="keterangan" rows="6"></textarea></div>
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
</div>

<!-- #modal-dialog -->
<div class="modal fade" id="modal-suratmasuk-detil">
	<div class="modal-dialog" style="width: 95%;">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="judul_detil"></h4>
			</div>
			<div class="modal-body">
				<div class="panel-body">
					<div class="col-md-12" style="width:100%;">
						<div class="row">
						<div class="col-md-10">
							<button onclick="TutupModal()" data-dismiss="modal" class="btn btn-sm btn-white btn-block text-left">Kembali</button>
						</div>
						<div class="col-md-2" style="display: flex; flex-direction: row;justify-content: center;align-items:center;margin-top:-3px;margin-bottom:5px">
							<?php if (in_array($this->session->userdata('group_id'), $this->session->userdata('kewenangan_persuratan'))) { ?>
								<button onclick="HapusSuratMasuk()" data-dismiss="modal" class="btn btn-sm btn-danger btn-block">Hapus</button>
							<?php } ?>
						</div>
				     	</div>
						 <br />

						<ul class="nav nav-tabs" role="tablist">
							<li class="nav-item">
								<a class="nav-link active" data-toggle="tab" href="#default-tab-1" role="tab" aria-controls="home-1" aria-selected="true">Data Surat</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" data-toggle="tab" href="#default-tab-2" role="tab" aria-controls="profile-1" aria-selected="false">Dokumen Elektronik</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" data-toggle="tab" href="#default-tab-3" onclick="TampilRiwayatPelaksana()" role="tab" aria-controls="contact-1" aria-selected="false">Riwayat Pelaksanaan</a>
							</li>
						</ul>

						<div class="tab-content">
							<div class="tab-pane fade show active" id="default-tab-1" style="margin-top:-30px">
								<?php if (in_array($this->session->userdata('group_id'), $this->session->userdata('kewenangan_persuratan'))) { ?>
									<span id="TombolEditSuratMasuk"></span><br /><br />
								<?php } ?>
								<div class="table-responsive">
									<table class="table table-hover">
										<tbody>
											<tr>
												<input type="hidden" name="register_id_detil" id="register_id_detil">
												<td class="col-md-2">Tanggal Register</td>
												<td class="col-md-1"><b>:</b></td>
												<td class="col-md-9"><span id=tanggal_register_detil></span></td>
											</tr>
											<tr>
												<td class="col-md-2">Nomor Agenda</td>
												<td class="col-md-1"><b>:</b></td>
												<td class="col-md-9"><span id=nomor_agenda_detil></span></td>
											</tr>
											<tr>
												<td class="col-md-2">Sifat Surat</td>
												<td class="col-md-1"><b>:</b></td>
												<td class="col-md-9"><span id=jenis_surat_detil></span></td>
											</tr>
											<tr>
												<td class="col-md-2">Tanggal Surat</td>
												<td class="col-md-1"><b>:</b></td>
												<td class="col-md-9"><span id=tanggal_surat_detil></span></td>
											</tr>
											<tr>
												<td class="col-md-2">Nomor Surat</td>
												<td class="col-md-1"><b>:</b></td>
												<td class="col-md-9"><span id=nomor_surat_detil></span></td>
											</tr>
											<tr>
												<td class="col-md-2">Pengirim</td>
												<td class="col-md-1"><b>:</b></td>
												<td class="col-md-9"><span id=pengirim_detil></span></td>
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
										</tbody>
									</table>
								</div>
							</div>
							<div class="tab-pane fade" id="default-tab-2">
								<span id="dokumen_elektronik"></span>
							</div>
							<div class="tab-pane fade" id="default-tab-3" style="margin-top:-20px">
								<div class="row">
									<div class="col-md-12" style="margin-bottom:10px;">
										<button onclick="TampilPelaksanaan()" id="TombolTambahPelaksanaan" class="btn btn-sm btn-success">Tambah</button>
										<?php if (in_array($this->session->userdata('group_id'), $this->session->userdata('kewenangan_persuratan'))) { ?>
											<button onclick="CetakDisposisi(1)" id="TombolCetakDisposisi" class="btn btn-sm btn-warning">Cetak Disposisi</button>
										<?php } ?>
									</div>
									<br /><br />
									<div class="table-responsive" style="width: 100%;">
										<table class="table table-hover" id="tambah_pelaksanaan">
											<tbody>
												<tr>
													<input type="hidden" id="pelaksanaan_id">
													<td style="width: 30%;" class="control-label"><label>Tanggal Pelaksanaan</label>
														<font color='red'>*</font>
													</td>
													<td style="width: 1%;"><b>:</b></td>
													<td style="width: 70%;"><input type="text" style="width:35%;" class="form-control" required id="datepicker-default3" /></td>
												</tr>
												<tr>
													<td style="width: 30%;" class="control-label"><label>Jenis Pelaksanaan <font color='red'>*</font></label></td>
													<td style="width: 1%;"><b>:</b></td>
													<td style="width: 70%;"><span id="pelaksanaan_"></span></td>
												</tr>
												<tr class="status_disposisi">
													<td style="width: 30%;" class="control-label"><label>Disposisi Jabatan <font color='red'>*</font></label></td>
													<td style="width: 1%;"><b>:</b></td>
													<td style="width: 70%;"><span id="disposisi_"></span></td>
												</tr>
												<tr class="status_disposisi">
													<td style="width: 30%;" class="control-label"><label>Disposisi Pegawai <font color='red'>*</font></label></td>
													<td style="width: 1%;"><b>:</b></td>
													<td style="width: 70%;"><span id="disposisi_pegawai_"></span></td>
												</tr>
												<tr>
													<td style="width: 30%;" class="control-label"><label>Keterangan</label></td>
													<td style="width: 1%;"><b>:</b></td>
													<td style="width: 70%;"><input type="text" class="form-control" required id="keterangan_pelaksanaan" /></td>
												</tr>
												<tr>
													<td colspan="3">
														<div align="right">
															<button onclick="TutupPelaksanaan()" class="btn btn-sm btn-white">Kembali</button>
															<button onclick="SimpanPelaksanaan()" class="btn btn-sm btn-success">Simpan</button>
														</div>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
									<table id="table_riwayat_pelaksana" style="width: 100%;" class="table table-striped table-bordered">
										<thead>
											<tr>
												<th nowrap>
													<div>No</div>
												</th>
												<th nowrap>
													<div>Tanggal</div>
												</th>
												<th nowrap>
													<div>Jenis Pelaksanaan</div>
												</th>
												<th nowrap>
													<div>Pelaksanaan Dari</div>
												</th>
												<th nowrap>
													<div>Disposisi Kepada</div>
												</th>
												<th nowrap>
													<div>Keterangan</div>
												</th>
												<th>Aksi</th>
												<!-- <th style="width:5%;" nowrap>
													<div align="center">No</div>
												</th>
												<th style="width:20%;" nowrap>
													<div align="center">Tanggal</div>
												</th>
												<th style="width:15%;" nowrap>
													<div align="center">Jenis Pelaksanaan</div>
												</th>
												<th style="width:30%;" nowrap>
													<div align="center">Pelaksanaan Dari</div>
												</th>
												<th style="width:30%;" nowrap>
													<div align="center">Disposisi Kepada</div>
												</th>
												<th style="width:40%;" nowrap>
													<div align="center">Keterangan</div>
												</th>
												<th style="width:5%;">Aksi</th> -->
											</tr>
										</thead>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
				</form>
			</div>
		</div>
	</div>
</div>
</div>


<div class="modal fade" id="modal-disposisi">
	<div class="modal-dialog" style="width: 100%;">
		<div class="modal-content">
			<div class="modal-header">
				<button onclick="TutupModal()" data-dismiss="modal" class="btn btn-sm btn-white">Kembali</button>
				<?php if (in_array($this->session->userdata('group_id'), $this->session->userdata('kewenangan_persuratan'))) { ?>
					<a href="javascript:void(0);"><button id="printButton" class="btn btn-sm btn-success">Cetak</button></a>
				<?php } ?>
			</div>
			<div class="modal-body printableArea">
				<table border="2" style="width: 100%;">
					<tr>
						<td colspan="4" align='center'><b><span id="nama_pengadilan_cetak"></span></b><br /><span id="alamat_pengadilan_cetak"></span></td>
					</tr>
					<tr>
						<td colspan="4" align='center'><b>LEMBAR DISPOSISI</b></td>
					</tr>
					<tr>
						<td colspan="4" align='center'>&nbsp;</td>
					</tr>
					<tr>
						<td width="20%">Tanggal Register</td>
						<td width="30%"><span id="tanggal_register_cetak"></span></td>
						<td width="20%">Tingkat Keamanan</td>
						<td width="30%"><span id="jenis_surat_cetak"></span></td>
					</tr>
					<tr>
						<td>Nomor Agenda</td>
						<td><span id="nomor_agenda_cetak"></span></td>
						<td>Tanggal Penyelesaian</td>
						<td><span id="tanggal_penyelesaian_cetak"></span></td>
					</tr>
					<tr>
						<td colspan="4" align='center'>&nbsp;</td>
					</tr>
					<tr>
						<td>Tanggal/Nomor Surat</td>
						<td colspan="3"><span id="tanggal_surat_cetak"></span> / <span id="nomor_surat_cetak"></span></td>
					</tr>
					<tr>
						<td>Pengirim</td>
						<td colspan="3"><span id="pengirim_cetak"></span></td>
					</tr>
					<tr>
						<td>Kepada</td>
						<td colspan="3"><span id="tujuan_cetak"></span></td>
					</tr>
					<tr>
						<td>Ringkasan</td>
						<td colspan="3"><span id="perihal_cetak"></span></td>
					</tr>
					<tr>
						<td colspan="4" align='center'>&nbsp;</td>
					</tr>
					<tr>
						<td colspan="2" width="40%" align='center'><b>DISPOSISI</b></td>
						<td width="30%" align='center'><b>DITERUSKAN KEPADA</b></td>
						<td width="30%" align='center'><b>KET</b></td>
					</tr>
					<tbody id="tampil_pelaksanaan_disposisi"></tbody>
				</table>
			</div>
		</div>
	</div>
</div>