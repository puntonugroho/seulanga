<?php defined('BASEPATH') OR exit('No direct script access allowed'); ?>

ERROR - 2018-03-29 15:14:27 --> Query error: Table 'peradilan.perkara_pihak2' doesn't exist - Invalid query: SELECT
				A.nama AS nama,
				A.alamat AS alamat,
				B.nomor_perkara AS nomor_perkara
				FROM perkara_pihak2 AS A
				LEFT JOIN perkara AS B ON B.perkara_id=A.perkara_id
				LEFT JOIN pihak AS C ON C.id=A.pihak_id
				WHERE B.alur_perkara_id>'100'
				AND B.alur_perkara_id<>'114'
				AND A.nama LIKE '%Asral%'
ERROR - 2018-03-29 15:14:27 --> Severity: Error --> Call to a member function result() on a non-object /var/www/html/peradilan/application/controllers/HalamanSuratKeterangan.php 496
ERROR - 2018-03-29 15:14:29 --> Query error: Table 'peradilan.perkara_pihak2' doesn't exist - Invalid query: SELECT
				A.nama AS nama,
				A.alamat AS alamat,
				B.nomor_perkara AS nomor_perkara
				FROM perkara_pihak2 AS A
				LEFT JOIN perkara AS B ON B.perkara_id=A.perkara_id
				LEFT JOIN pihak AS C ON C.id=A.pihak_id
				WHERE B.alur_perkara_id>'100'
				AND B.alur_perkara_id<>'114'
				AND A.nama LIKE '%Asral%'
ERROR - 2018-03-29 15:14:29 --> Severity: Error --> Call to a member function result() on a non-object /var/www/html/peradilan/application/controllers/HalamanSuratKeterangan.php 496
ERROR - 2018-03-29 16:09:17 --> Severity: Warning --> Illegal string offset 'file_name' /var/www/html/peradilan/application/controllers/HalamanSuratKeluar.php 398
