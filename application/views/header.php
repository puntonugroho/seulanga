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
	<link href="<?php echo base_url();?>assets/css/dataTables.bootstrap4.css" rel="stylesheet">
	<link href="<?php echo base_url();?>assets/css/style.css" rel="stylesheet" />
	<link href="<?php echo base_url();?>assets/css/bootstrap-datepicker.min.css" rel="stylesheet" />
	<link href="<?php echo base_url();?>assets/js//gritter/css/jquery.gritter.css" rel="stylesheet" />
	<!-- <script src="<?php echo base_url();?>assets/js/jquery/jquery-1.9.1.min.js"></script> -->
	<script src="<?php echo base_url();?>assets/js/jquery/jquery-3.6.0.js"></script>
	
</head>
<body>
	<div class="container-scroller">
		<div id="page-loader" class="fade in"><span class="spinner"></span></div>
			<!-- partial:partials/_horizontal-navbar.html -->
		<div class="horizontal-menu">
			<nav class="navbar top-navbar col-lg-12 col-12 p-0" style="background:#4b56c0">
				<div class="container-fluid">
					<div class="navbar-menu-wrapper d-flex align-items-center justify-content-between">
					<ul class="navbar-nav navbar-brand-wrapper navbar-nav-left">
						<a class="navbar-brand brand-logo" href="<?php echo base_url();?>">
							<img style="height:50px;" src="images/logodalam.png" alt="logo"/></a>
						<a class="navbar-brand brand-logo-mini" style="margin-left:-10px; width:80px;" href="<?php echo base_url();?>">
							<img style="height:40px"; src="images/logo_new_mini.png" alt="logo"/></a>
					</ul>
					<!-- <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
							<p class="navbar-brand" style="font-size:18px; color:#ffff; margin-top:10px">
							  
							</p>
					</div> -->
					<ul class="navbar-nav navbar-nav-right">
						<li class="nav-item nav-profile dropdown">
						<a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" id="profileDropdown1">
							<span class="nav-profile-name" style="color:#ffffff; font-weight:600; margin-right: .5rem">
								<?php echo $this->session->userdata('fullname'); ?>
							</span> 
							<span class="online-status"></span>
							<img src="<?php echo $this->session->userdata('logo_pengadilan'); ?>" alt="profile"/>
						</a>
						<div class="dropdown-menu dropdown-menu-right navbar-dropdown" aria-labelledby="profileDropdown1">
							<!-- <a class="dropdown-item">
								<i class="mdi mdi-settings text-primary"></i>
								Settings
							</a> -->
							<a class="dropdown-item" href="<?php echo base_url();?>keluar">
								<i class="mdi mdi-logout text-primary"></i>
								Logout
							</a>
						</div>
						</li>
					</ul>
					<button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="horizontal-menu-toggle">
					<span class="mdi mdi-menu"></span>
					</button>
				</div>
				</div>
			</nav>
			<nav class="bottom-navbar">
				<div class="container">
					<ul class="nav page-navigation">
					<?php if(in_array($this->session->userdata('group_id'), $this->session->userdata('kewenangan_dashboard'))) {?>
					<li class="nav-item <?php if($this->uri->segment(1)=="" || $this->uri->segment(1)=="dashboard"){echo 'active';}?>">
						<a class="nav-link" href="<?php echo base_url();?>">
							<i class="mdi mdi-codepen  menu-icon"></i>
							<span class="menu-title">Dashboard</span>
						</a>
					</li>
					<?php } ?>
					<?php if((in_array($this->session->userdata('group_id'), $this->session->userdata('kewenangan_persuratan')))||(in_array($this->session->userdata('group_id'), $this->session->userdata('kewenangan_dashboard')))) {?>
					<li class="nav-item  <?php if($this->uri->segment(1)=="suratmasuk"){echo 'active';}?>">
						<a class="nav-link" href="<?php echo base_url();?>suratmasuk">
							<i class="mdi mdi-email-outline  menu-icon"></i>
							<span class="menu-title">Surat Masuk</span>
						</a>
					</li>
					<li class="nav-item <?php if($this->uri->segment(1)=="suratkeluar"){echo 'active';}?>">
						<a href="<?php echo base_url();?>suratkeluar" class="nav-link">
							<i class="mdi mdi-send menu-icon"></i>
							<span class="menu-title">Surat Keluar</span>
						</a>
					</li>
					<?php } ?>
					<!-- <?php if(in_array($this->session->userdata('group_id'), $this->session->userdata('kewenangan_disposisi'))) {?>
					<li class="nav-item <?php if($this->uri->segment(1)=="disposisi"){echo 'active';}?>">
						<a href="<?php echo base_url();?>disposisi" class="nav-link">
							<i class="mdi mdi-content-paste  menu-icon"></i>
							<span class="menu-title">Disposisi</span>
						</a>
					</li>
					<?php } ?> -->
					<?php if(in_array($this->session->userdata('group_id'), $this->session->userdata('kewenangan_referensi'))) {?>
					<li class="nav-item <?php if($this->uri->segment(1)=="pegawai" || $this->uri->segment(1)=="penomoran"){echo 'active';}?>">
						<a href="#" class="nav-link">
							<i class="mdi mdi-bulletin-board menu-icon"></i>
							<span class="menu-title">Referensi</span>
							<i class="menu-arrow"></i>
						</a>
						<div class="submenu">
							<ul class="submenu-item">
								<li class="nav-item"><a class="nav-link" href="<?php echo base_url();?>pegawai">Tambah Pegawai</a></li>
								<li class="nav-item"><a class="nav-link" href="<?php echo base_url();?>penomoran">Format Nomor Surat</a></li>
							</ul>
						</div>
					</li>
					<?php } ?>
					<?php if(in_array($this->session->userdata('group_id'), $this->session->userdata('kewenangan_konfigurasi'))) {?>
					<li class="nav-item <?php if($this->uri->segment(1)=="pengguna" || $this->uri->segment(1)=="konfigurasi"){echo 'active';}?>">
						<a href="#" class="nav-link">
							<i class="mdi mdi-brightness-5 menu-icon"></i>
							<span class="menu-title">Pengaturan</span>
							<i class="menu-arrow"></i>
						</a>
						<div class="submenu">
							<ul class="submenu-item">
								<li class="nav-item"><a class="nav-link" href="<?php echo base_url();?>pengguna">Manajemen User</a></li>
								<li class="nav-item"><a class="nav-link" href="<?php echo base_url();?>konfigurasi">Pengaturan Satker</a></li>
							</ul>
						</div>
					</li>
					<?php } ?>
					</ul>
				</div>
			</nav>
		</div>
