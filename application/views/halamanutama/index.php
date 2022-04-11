		<div class="container-fluid page-body-wrapper">
			<div class="main-panel">
				<div class="content-wrapper">
					<div class="row">
						<div class="col-sm-12 flex-column d-flex stretch-card">
							<div class="row">
								<div class="col-lg-3 d-flex grid-margin stretch-card">
									<div class="card sale-diffrence-border">
										<div class="card-body">
											<i class="mdi mdi-download icon-lg text-warning" style="float:right"></i>
											<h2 class="text-dark mb-2 font-weight-bold"><?php echo $jumlahSuratMasuk; ?></h2>
											<h4 class="card-title mb-2">SURAT MASUK</h4>
											<small class="text-muted">Tahun <?php echo $tahun; ?></small>
										</div>
									</div>
								</div>
								<div class="col-lg-3 d-flex grid-margin stretch-card">
									<div class="card sale-visit-statistics-border">
										<div class="card-body">
											<i class=" mdi mdi-upload icon-lg text-warning" style="float:right"></i>
											<h2 class="text-dark mb-2 font-weight-bold"><?php echo $jumlahSuratKeluar; ?></h2>
											<h4 class="card-title mb-2">SURAT KELUAR</h4>
											<small class="text-muted">Tahun <?php echo $tahun; ?></small>
										</div>
									</div>
								</div>
								<div class="col-lg-3 d-flex grid-margin stretch-card">
									<div class="card bg-primary">
										<div class="card-body text-white">
											<h3 class="font-weight-bold mb-3">75 %</h3>
											<div class="progress mb-3">
												<div class="progress-bar  bg-warning" role="progressbar" style="width: 40%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
											</div>
											<p class="pb-0 mb-0" style="font-weight:600">TINDAK LANJUT DISPOSISI</p>
										</div>
									</div>
								</div>
								<div class="col-lg-3 d-flex grid-margin stretch-card">
									<div class="card bg-danger">
										<div class="card-body text-white">
											<h3 class="font-weight-bold mb-3">80 %</h3>
											<div class="progress mb-3">
												<div class="progress-bar  bg-warning" role="progressbar" style="width: 40%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
											</div>
											<p class="pb-0 mb-0" style="font-weight:600">PROGRES PENGIRIMAN SURAT</p>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-lg-12 grid-margin stretch-card">
							<div class="card">
								<div class="card-body">
									<h4 class="card-title">DISPOSISI UNTUK SAYA</h4>
									<div class="table-responsive">
										<table class="table table-hover">
											<thead>
												<?php if ($group_id == '2' || $group_id == '3' || $group_id == '4' || $group_id == '5' || $group_id == '6' || $group_id == '7' || $group_id == '10' || $group_id == '16' || $group_id == '17' || $group_id == '18' || $group_id == '19' || $group_id == '20' || $group_id == '21' || $group_id == '22' || $group_id == '24' || $group_id == '25' || $group_id == '26' || $group_id == '27' || $group_id == '28' || $group_id == '29' || $group_id == '30') { ?>
													<tr>
														<th style="font-weight: 600; font-size:0.9rem">No</th>
														<th style="font-weight: 600; font-size:0.9rem">Tgl. Register</th>
														<th style="font-weight: 600; font-size:0.9rem">Jenis</th>
														<th style="font-weight: 600; font-size:0.9rem">Nomor</th>
														<th style="font-weight: 600; font-size:0.9rem">Pengirim</th>
														<th style="font-weight: 600; font-size:0.9rem">Disposisi dari</th>
														<th style="font-weight: 600; font-size:0.9rem">Aksi</th>
													</tr>
												<?php } else { ?>
													<tr>
														<th style="font-weight: 600; font-size:0.9rem">No</th>
														<th style="font-weight: 600; font-size:0.9rem">Tgl. Disposisi</th>
														<th style="font-weight: 600; font-size:0.9rem">Jenis</th>
														<th style="font-weight: 600; font-size:0.9rem">Nomor</th>
														<th style="font-weight: 600; font-size:0.9rem">Disposisi dari</th>
														<th style="font-weight: 600; font-size:0.9rem">Keterangan</th>
														<th style="font-weight: 600; font-size:0.9rem">Aksi</th>
													</tr>
												<?php } ?>
											</thead>
											<tbody>
												<?php $a = 0;
												foreach ($queryRegister->result() as $row) {
													$a++;
													echo "<tr>";
													echo "<td>" . $a . "</td>";
													if ($group_id == '2' || $group_id == '3' | $group_id == '4' || $group_id == '5' || $group_id == '6' || $group_id == '7' || $group_id == '10' || $group_id == '16' || $group_id == '17' || $group_id == '18' || $group_id == '19' || $group_id == '20' || $group_id == '21' || $group_id == '22' || $group_id == '24' || $group_id == '25' || $group_id == '26' || $group_id == '27' || $group_id == '28' || $group_id == '29' || $group_id == '30') {
														echo "<td>" . $this->tanggalhelper->convertDayDate($row->tanggal_register) . "</td>";
														echo "<td>" . $row->jenis_surat . "</td>";
														echo "<td>" . $row->nomor_surat . "</td>";
														echo "<td>" . $row->pengirim . "</td>";
														if ($row->tujuan_disposisi_dari_jabatan == null) {
															echo "<td> Langsung </td>";
														} else {
															echo "<td>" . $row->tujuan_disposisi_dari_jabatan . "</td>";
														}
													} else {
														echo "<td>" . $this->tanggalhelper->convertDayDate($row->tujuan_disposisi_tanggal) . "</td>";
														echo "<td>" . $row->jenis_surat . "</td>";
														echo "<td>" . $row->nomor_surat . "</td>";
														echo "<td>" . $row->tujuan_disposisi_dari_jabatan . "</td>";
														echo "<td>" . $row->tujuan_disposisi_keterangan . "</td>";
													}
													// '<button type="button" onclick="Buka ModalDisposisi(\'' . base64_encode($this->encrypt->encode($row->register_id)) . '\')" class="btn btn-dark btn-rounded btn-icon"><i class="mdi mdi-internet-explorer"></i></button>'
													echo '<td><button type="button" onclick="BukaModalDisposisi(\'' . base64_encode($this->encrypt->encode($row->register_id)) . '\')" class="btn btn-warning btn-icon"><i class="mdi mdi-grease-pencil"></i></button></td>';
													echo "</tr>";
												}
												?>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-lg-6 grid-margin stretch-card">
							<div class="card">
								<div class="card-body">
									<h4 class="card-title">SURAT MASUK BELUM PELAKSANAAN</h4>
									<div class="table-responsive">
										<table class="table table-hover">
											<thead>
												<tr>
													<th style="font-weight: 600; font-size:0.9rem">No</th>
													<th style="font-weight: 600; font-size:0.9rem">Tgl. Register</th>
													<th style="font-weight: 600; font-size:0.9rem">Nomor</th>
													<th style="font-weight: 600; font-size:0.9rem">Pengirim</th>
													<th style="font-weight: 600; font-size:0.9rem">Pelaksana Terakhir</th>
												</tr>
											</thead>
											<tbody>
												<?php $a = 0;
												foreach ($queryPelaksanaanSK->result() as $row) {
													$a++;
													echo "<tr>";
													echo "<td>" . $a . "</td>";
													echo "<td>" . $this->tanggalhelper->convertToInputDate($row->tanggal_register) . "</td>";
													echo "<td>" . $row->nomor_surat . "</td>";
													echo "<td>" . $row->pengirim . "</td>";
													echo "<td>" .$row->tujuan_disposisi_nama. "</td>";
													echo "</tr>";
												} ?>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-6 grid-margin stretch-card">
							<div class="card">
								<div class="card-body">
									<h4 class="card-title">SURAT KELUAR BELUM PENGIRIMAN</h4>
									<div class="table-responsive">
										<table class="table table-hover">
											<thead>
												<tr>
													<th style="font-weight: 600; font-size:0.9rem">No</th>
													<th style="font-weight: 600; font-size:0.9rem">Tgl. Register</th>
													<th style="font-weight: 600; font-size:0.9rem">Nomor</th>
													<th style="font-weight: 600; font-size:0.9rem">Tujuan</th>
													<th style="font-weight: 600; font-size:0.9rem">Aksi</th>
												</tr>
											</thead>
											<tbody>
												<?php $a = 0;
												foreach ($queryPelaksanaanSM->result() as $row) {
													$a++;
													echo "<tr>";
													echo "<td>" . $a . "</td>";
													echo "<td>" . $this->tanggalhelper->convertToInputDate($row->tanggal_register) . "</td>";
													echo "<td>" . $row->nomor_surat . "</td>";
													echo "<td>" . $row->tujuan . "</td>";
													echo "<td><div align='center'>" . $row->waktu . "</div></td>";
													echo "</tr>";
												} ?>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- content-wrapper ends -->
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
		<div class="modal fade" id="modal_disposisi">
			<div class="modal-dialog" style="width: 100%;">
				<div class="modal-content">
					<div class="modal-header" style="text-align: center;display: block;">
						<h3 class="modal-title" style="font-weight:600"><span id="judul_modal"></span></h3>
					</div>
					<div class="modal-body">
						<div class="panel-body">
							<div class="table-responsive">
								<table class="table">
									<tbody>
										<tr>
											<input type="hidden" id="register_id">
											<input type="hidden" id="group_id">
											<td style="width: 25%;">TANGGAL REGISTER</td>
											<td style="width: 75%;"><span id="tanggal_register"></span></td>
										</tr>
										<tr>
											<td>PENGIRIM</td>
											<td><span id="pengirim"></span></td>
										</tr>
										<tr>
											<td>PERIHAL</td>
											<td><span id="perihal"></span></td>
										</tr>
										<tr style="background: #a6e3dd;">
											<td colspan="2">
												<div class="panel-group" id="accordion">
													<div class="panel overflow-hidden">
														<div class="panel-heading">
															<h4 class="panel-title">
																<a class="accordion-toggle accordion-toggle-styled collapsed" style="font-weight:600;color:#020202" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">DOKUMEN ELEKTRONIK <i class="mdi mdi-file-pdf" style="float:right"></i></a>
															</h4>
														</div>
														<div id="collapseTwo" class="panel-collapse collapse">
															<div class="panel-body"><span id="dokumen_elektronik"></span></div>
														</div>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<td><span id="judul_tanggal"></span></td>
											<td>
												<div id="datepicker-popup" class="input-group date datepicker" style="width:60%">
													<input type="text" id="datepicker-default" class="form-control">
													<span class="input-group-addon input-group-append border-left">
														<span class="mdi mdi-calendar input-group-text"></span>
													</span>
												</div>
											</td>
											<!-- <td><input style="width:50%;" type="text" class="form-control" required id="datepicker-default" /></td> -->
										</tr>
										<tr id="tampil_pelaksanaan">
											<td>JENIS PELAKSANAAN</td>
											<td><span id="jenis_pelaksanaan_"></span></td>
										</tr>
										<tr id="tampil_pelaksanaan_jabatan">
											<td><span id="judul_pelimpahan"></span></td>
											<td><span id="jabatan_"></span></td>
										</tr>
										<tr id="tampil_pelaksanaan_pegawai">
											<td>PEGAWAI</td>
											<td><span id="pegawai_"></span></td>
										</tr>
										<tr id="tampil_pelaksanaan_keterangan">
											<td>KETERANGAN</td>
											<td><textarea class="form-control" id="keterangan_pelaksanaan" rows="3"></textarea></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button onclick="TutupModal()" data-dismiss="modal" class="btn btn-sm btn-secondary">Kembali</button>
						<button onclick="SimpanModal()" type="submit" class="btn btn-sm btn-success">Simpan</button>
					</div>
				</div>
			</div>
		</div>