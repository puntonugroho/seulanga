<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <title>Surat Digital</title>
  <!-- <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" /> -->
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta content="" name="description" />
  <meta content="I.A.HARAHAP" name="author" />

  <!-- link rel="stylesheet" href="assets/css/animate.css"> -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i&display=swap" rel="stylesheet">
  <link href="<?php echo base_url(); ?>assets/css/bootstrap.min.css" rel="stylesheet">
  <!-- <link rel="shortcut icon" href="<?php echo base_url(); ?>assets/images/fav.jpg"> -->
  <link rel="stylesheet" href="<?php echo base_url(); ?>assets/css/all.min.css">
  <link href="<?php echo base_url(); ?>assets/css/materialdesignicons.css" rel="stylesheet">
  <link href="<?php echo base_url(); ?>assets/css/bootstrap.min.css" rel="stylesheet">
  <!-- <link href="<?php echo base_url(); ?>assets/css/animate.css" rel="stylesheet"> -->
  <link href="<?php echo base_url(); ?>assets/css/style_login.css" rel="stylesheet" />
  <link href="<?php echo base_url(); ?>assets/css/bootstrap-datepicker.min.css" rel="stylesheet" />
  <script src="<?php echo base_url(); ?>assets/js/jquery/jquery-3.6.0.js"></script>
</head>


<body class="form-login-body" style="background-image: url(<?php echo base_url(); ?>/images/bg.jpg);background-size:cover;">
  <div class="container">
    <div class="row">
      <div class="col-lg-10 mx-auto login-desk">
        <div class="row">
          <div class="col-md-7 detail-box">
            <img class="logo" src="<?php echo base_url(); ?>images/logo.png" alt="">
            <div class="detailsh">
              <img class="help" src="<?php echo base_url(); ?>images/help.png" alt="">
              <h3 style="color: #0a0a0a;">Mahkamah Syar'iyah Aceh</h3>
              <p>Sistem Persuratan Digital</p>
            </div>
          </div>
          <div class="col-md-5 loginform">
            <h3 style="color: #fff;">Selamat Datang</h3>
            <p>Masuk dengan Akun Anda</p>
            <div class="login-det">
            <form action="<?php echo base_url(); ?>login_validasi" method="POST">
              <div class="form-row">
                <label for="">Username</label>
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                      <span class="input-group-text" id="basic-addon1">
                        <i class="far fa-user"></i>
                      </span>
                    </div>
                    <input type="text" class="form-control" placeholder="Masukkan Username" name="nama" aria-label="Username" aria-describedby="basic-addon1">
                </div>
              </div>
              <div class="form-row">
                <label for="">Password</label>
                <div class="input-group mb-3">
                  <div class="input-group-prepend">
                    <span class="input-group-text" id="basic-addon1">
                      <i class="fas fa-lock"></i>
                    </span>
                  </div>
                  <input type="password" class="form-control" placeholder="Masukkan Password" name="password" aria-label="Username" aria-describedby="basic-addon1">
                </div>
              </div>

              <p class="forget"><a href=""></a></p>
              <div>
              <button class="btn btn-sm btn-danger">Login</button>
              </div>

              <div class="social-link">
                <ul class="socil-icon">
                  <li>
                    <a href="https://www.facebook.com/msaceh.id" target="_blank"><i class="fab fa-facebook-f"></i></a>
                  </li>
                  <li>
                    <a href="https://twitter.com/info_msaceh" target="_blank"><i class="fab fa-twitter"></i></a>
                  </li>
                  <li>
                    <a href="https://www.instagram.com/ms_aceh/" target="_blank"><i class="fab fa-instagram"></i></a>
                  </li>
                  <!-- <li>
                                                <a href="#"><i class="fab fa-pinterest-p"></i></a>
                                            </li>
                                            <li>
                                                <a href="#"><i class="fab fa-dribbble"></i></a>
                                            </li>
                                            <li>
                                                <a href="#"><i class="fab fa-behance"></i></a>
                                            </li> -->
                </ul>
              </div>

            </div>
          </div>
        </div>

      </div>
    </div>
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