<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<title>AMSAL</title>
	<!-- <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" /> -->
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta content="" name="description" />
	<meta content="I.A.HARAHAP" name="author" />
	
	<link href="<?php echo base_url();?>assets/css/materialdesignicons.css" rel="stylesheet">
	<link href="<?php echo base_url();?>assets/css/vendor.bundle.base.css" rel="stylesheet">
	<link href="<?php echo base_url();?>assets/css/style.css" rel="stylesheet" />
	<link href="<?php echo base_url();?>assets/css/bootstrap-datepicker.min.css" rel="stylesheet" />
	<!-- <script src="<?php echo base_url();?>assets/js/jquery/jquery-1.9.1.min.js"></script> -->
	<script src="<?php echo base_url();?>assets/js/jquery/jquery-3.6.0.js"></script>	
</head>


<body>
  <div class="container-scroller">
    <div class="container-fluid page-body-wrapper full-page-wrapper">
      <div class="content-wrapper d-flex align-items-stretch auth auth-img-bg">
        <div class="row flex-grow">
          <div class="col-lg-6 d-flex align-items-center justify-content-center">
            <div class="auth-form-transparent text-left p-3">
              <div class="brand-logo">
                <img src="<?php echo base_url(); ?>images/logo_new.png" alt="logo">
              </div>
              <h4>Silahkan Login untuk masuk ke Aplikasi</h4>
              <form action="<?php echo base_url(); ?>login_validasi" method="POST" class="pt-3" >
                <div class="form-group">
                  <label for="nama">Username</label>
                  <div class="input-group">
                    <div class="input-group-prepend bg-transparent">
                      <span class="input-group-text bg-transparent border-right-0">
                        <i class="mdi mdi-account-outline text-primary"></i>
                      </span>
                    </div>
                    <input type="text" class="form-control form-control-lg border-left-0" name = "nama"  placeholder="Nama" required>
                  </div>
                </div>
                <div class="form-group">
                  <label for="password">Password</label>
                  <div class="input-group">
                    <div class="input-group-prepend bg-transparent">
                      <span class="input-group-text bg-transparent border-right-0">
                        <i class="mdi mdi-lock-outline text-primary"></i>
                      </span>
                    </div>
                    <input type="password" class="form-control form-control-lg border-left-0" name="password" placeholder="Password">                        
                  </div>
                </div>
                <div class="my-3">
                  <button class="btn btn-block btn-primary btn-outline btn-lg font-weight-medium auth-form-btn" type="submit">LOGIN</button>
                </div>
                <div class="text-center mt-4 font-weight-light">
                  Belum punya akun? <a href="#" class="text-primary">Daftar</a>
                </div>
              </form>
            </div>
          </div>
          <div class="col-lg-6 login-half-bg d-flex flex-row">
            <p class="text-white font-weight-medium text-center flex-grow align-self-end">Copyright &copy; 2022  All rights reserved.</p>
          </div>
        </div>
      </div>
      <!-- content-wrapper ends -->
    </div>
    <!-- page-body-wrapper ends -->
  </div>
<script src="<?php echo base_url(); ?>assets/js/base.js"></script>
<script src="<?php echo base_url(); ?>assets/js/hoverable-collapse.js"></script>
<script src="<?php echo base_url(); ?>assets/js/off-canvas.js"></script>
<script src="<?php echo base_url(); ?>assets/js/template.js"></script>
<script src="<?php echo base_url(); ?>assets/js/settings.js"></script>
<script src="<?php echo base_url(); ?>assets/js/todolist.js"></script>
<script src="<?php echo base_url(); ?>assets/js/jquery.cookie.js"></script>
<script src="<?php echo base_url(); ?>assets/js/profile-settings.js"></script>
<script src="<?php echo base_url(); ?>assets/js/bootstrap-datepicker.min.js"></script>
<script src="<?php echo base_url(); ?>assets/js/moment.min.js"></script>
<script src="<?php echo base_url(); ?>assets/js/formpickers.js"></script>
</body>

</html>