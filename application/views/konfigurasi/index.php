<div class="container-fluid page-body-wrapper">
  <div class="main-panel">
    <div class="content-wrapper">
      <div class="row">
        <div class="col-md-8">
          <div class="card">
            <div class="card-body">
              <div class="row">
                <div class="col-md-12">
                  <h4 class="card-title">KONFIGURASI APLIKASI</h4>
                </div>
              </div>
              <div class="row" id="row">
                <div class="col-md-12">
                  <div class="panel panel-inverse" data-sortable-id="form-stuff-1">
                    <div class="panel-heading">
                      <div class="panel-heading-btn"></div>
                    </div>
                    <div class="panel-body">
                      <form class="form-horizontal" method="POST" action="<?php echo base_url(); ?>konfigurasi_simpan" enctype="multipart/form-data">
                        <div class="row">
                          <div class="col-md-6">
                            <div class="form-group">
                              <label class="col-md-6 control-label">Tingkat Banding</label>
                              <div class="col-md-12"><?php echo form_dropdown('pengadilan_tinggi', $dataPT, $IDPT, 'class="form-control" required id="pengadilan_tinggi" onChange="SelectPN()"'); ?></div>
                            </div>
                            <div class="form-group">
                              <label class="col-md-6 control-label">Tingkat Pertama</label>
                              <div class="col-md-12" id="pengadilan_negeri_"><input type="text" id="input_pn" value="<?php echo $NamaPN; ?>" class="form-control" disabled /></div>
                            </div>
                            <div class="form-group">
                              <label class="col-md-6 control-label">Alamat</label>
                              <div class="col-md-12"><textarea class="form-control" required name="alamat" id="alamat" rows="6"><?php echo $AlamatPN; ?></textarea></div>
                            </div>
                          </div>
                          <div class="col-md-6">
                            <div class="form-group">
                              <label class="col-md-6 control-label">Kode Surat</label>
                              <div class="col-md-12"><input class="form-control" name="kode_surat" value="<?php echo $KodeSurat; ?>" required /></div>
                            </div>
                            <div class="form-group">
                              <label class="col-md-6 control-label">Kode Perkara</label>
                              <div class="col-md-12"><input class="form-control" name="kode_perkara" value="<?php echo $KodePerkara; ?>" required /></div>
                            </div>
                            <div class="form-group">
                              <label class="col-md-6 control-label">Logo Mahkamah</label>
                              <div class="col-md-12"><input type="file" class="form-control" id="dokumen" name="dokumen" /></div>
                            </div>
                            <div class="form-group">
                              <div class="col-md-12">
                                <button type="submit" class="btn btn-sm btn-success btn-block">Simpan</button>
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
          </div>
        </div>
        <div class="col-md-4">
          <div class="card">
            <div class="card-body">
              <div class="row">
                <div class="col-md-12">
                  <h4 class="card-title">LOGO MAHKAMAH</h4>
                </div>
              </div>
              <div class="row">
                <div class="col-md-12">
                  <div class="panel panel-inverse" data-sortable-id="form-stuff-1">
                    <!-- <div class="panel-heading">LOGO PENGADILAN</div> -->
                    <div class="panel-body" align='center'>
                      <img src="<?php echo $LogoPN; ?>" width="120px" height="150px" />
                    </div>
                  </div>
                </div>
              </div>
            </div>
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