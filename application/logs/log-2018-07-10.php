<?php defined('BASEPATH') OR exit('No direct script access allowed'); ?>

ERROR - 2018-07-10 12:02:15 --> Query error: Table 'peradilan.perkara_pihak2' doesn't exist - Invalid query: SELECT
				A.nama AS nama,
				A.alamat AS alamat,
				B.nomor_perkara AS nomor_perkara
				FROM perkara_pihak2 AS A
				LEFT JOIN perkara AS B ON B.perkara_id=A.perkara_id
				LEFT JOIN pihak AS C ON C.id=A.pihak_id
				WHERE B.alur_perkara_id>'100'
				AND B.alur_perkara_id<>'114'
				AND A.nama LIKE '%-%'
ERROR - 2018-07-10 12:02:15 --> Severity: Error --> Call to a member function result() on a non-object /var/www/html/peradilan/application/controllers/HalamanSuratKeterangan.php 496
ERROR - 2018-07-10 12:02:33 --> Query error: Table 'peradilan.perkara_pihak2' doesn't exist - Invalid query: SELECT
				A.nama AS nama,
				A.alamat AS alamat,
				B.nomor_perkara AS nomor_perkara
				FROM perkara_pihak2 AS A
				LEFT JOIN perkara AS B ON B.perkara_id=A.perkara_id
				LEFT JOIN pihak AS C ON C.id=A.pihak_id
				WHERE B.alur_perkara_id>'100'
				AND B.alur_perkara_id<>'114'
				AND A.nama LIKE '%-%'
ERROR - 2018-07-10 12:02:33 --> Severity: Error --> Call to a member function result() on a non-object /var/www/html/peradilan/application/controllers/HalamanSuratKeterangan.php 496
ERROR - 2018-07-10 12:02:34 --> Query error: Table 'peradilan.perkara_pihak2' doesn't exist - Invalid query: SELECT
				A.nama AS nama,
				A.alamat AS alamat,
				B.nomor_perkara AS nomor_perkara
				FROM perkara_pihak2 AS A
				LEFT JOIN perkara AS B ON B.perkara_id=A.perkara_id
				LEFT JOIN pihak AS C ON C.id=A.pihak_id
				WHERE B.alur_perkara_id>'100'
				AND B.alur_perkara_id<>'114'
				AND A.nama LIKE '%-%'
ERROR - 2018-07-10 12:02:34 --> Severity: Error --> Call to a member function result() on a non-object /var/www/html/peradilan/application/controllers/HalamanSuratKeterangan.php 496
ERROR - 2018-07-10 12:02:34 --> Query error: Table 'peradilan.perkara_pihak2' doesn't exist - Invalid query: SELECT
				A.nama AS nama,
				A.alamat AS alamat,
				B.nomor_perkara AS nomor_perkara
				FROM perkara_pihak2 AS A
				LEFT JOIN perkara AS B ON B.perkara_id=A.perkara_id
				LEFT JOIN pihak AS C ON C.id=A.pihak_id
				WHERE B.alur_perkara_id>'100'
				AND B.alur_perkara_id<>'114'
				AND A.nama LIKE '%-%'
ERROR - 2018-07-10 12:02:34 --> Severity: Error --> Call to a member function result() on a non-object /var/www/html/peradilan/application/controllers/HalamanSuratKeterangan.php 496
ERROR - 2018-07-10 16:32:59 --> Query error: Server shutdown in progress - Invalid query: SELECT *
FROM `v_suratmasuk`
ERROR - 2018-07-10 16:32:59 --> Severity: Error --> Call to a member function num_rows() on a non-object /var/www/html/peradilan/application/models/ModelSuratMasuk.php 43
