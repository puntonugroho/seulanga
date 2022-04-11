<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class TanggalHelper{
	
	function monthName($str){
		if(preg_match('((?:Jan(?:uary)?|Feb(?:ruary)?|Mar(?:ch)?|Apr(?:il)?|May|Jun(?:e)?|Jul(?:y)?|Aug(?:ust)?|Sep(?:tember)?|Sept|Oct(?:ober)?|Nov(?:ember)?|Dec(?:ember)?))', $str)){
			$month = strtoupper($str);
				if(preg_match('((JAN(?:UARY)?))',$month)){
					$month = 'Januari';
				}elseif(preg_match('((FEB(?:RUARY)))',$month) or $month == 'FEB'){
					$month = 'Februari';
				}elseif(preg_match('((MAR(?:CH)?))',$month)){
					$month = 'Maret';
				}elseif(preg_match('((APR(?:IL)?))',$month)){
					$month = 'April';
				}elseif(preg_match('((MAY?))',$month)){
					$month = 'Mei';
				}elseif(preg_match('((JUN(?:E)?))',$month)){
					$month = 'Juni';
				}elseif(preg_match('((JUL(?:Y)?))',$month)){
					$month = 'Juli';
				}elseif(preg_match('((AUG(?:UST)?))',$month)){
					$month = 'Agustus';
				}elseif(preg_match('((SEP(?:TEMBER)?))',$month)){
					$month = 'September';
				}elseif(preg_match('((OCT(?:OBER)?))',$month)){
					$month = 'Oktober';
				}elseif(preg_match('((NOV(?:EMBER)?))',$month)){
					$month = 'November';
				}elseif(preg_match('((DEC(?:EMBER)?))',$month)){
					$month = 'Desember';
				}
			return $month;
		}
	}


	function monthNameFull($str){
		if($str=='01'){
			$month = 'Januari';
		}elseif($str=='02'){
			$month = 'Februari';
		}elseif($str=='03'){
			$month = 'Maret';
		}elseif($str=='04'){
			$month = 'April';
		}elseif($str=='05'){
			$month = 'Mei';
		}elseif($str=='06'){
			$month = 'Juni';
		}elseif($str=='07'){
			$month = 'Juli';
		}elseif($str=='08'){
			$month = 'Agustus';
		}elseif($str=='09'){
			$month = 'September';
		}elseif($str=='10'){
			$month = 'Oktober';
		}elseif($str=='11'){
			$month = 'November';
		}elseif($str=='12'){
			$month = 'Desember';
		}
		return $month;
	}







	function dayName($str){
		if(preg_match('((?:Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday|Tues|Thur|Thurs|Sun|Mon|Tue|Wed|Thu|Fri|Sat))', $str)){
			
			$day = strtoupper($str);
			if(preg_match('|MONDAY|',$day)){
				$day = 'Senin';
			}elseif(preg_match('|TUESDAY|',$day)){
				$day = 'Selasa';
			}elseif(preg_match('|WEDNESDAY|',$day)){
				$day = 'Rabu';
			}elseif(preg_match('|THURSDAY|',$day)){
				$day = 'Kamis';
			}elseif(preg_match('|FRIDAY|',$day)){
				$day = 'Jumat';
			}elseif(preg_match('|SATURDAY|',$day)){
				$day = 'Sabtu';
			}elseif(preg_match('|SUNDAY|',$day)){
				$day = 'Minggu';
			}
			return $day;
		}
	}

	public function convertDayDate($str){
		if(preg_match("/^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/", $str)){
			$date = (date_format(date_create($str),'Y/M/d'));
			$dates = explode("/", $date);
			$hari = $this->dayName(date('l', strtotime($str)));
			return $hari.", ".$dates[2]." ".$this->monthName($dates[1])." ".$dates[0];
		}else{
			return " - ";
		}	

	}
	public function convertDate($str){
		if(preg_match("/^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/", $str)){
			$date = (date_format(date_create($str),'Y/M/d'));
			$dates = explode("/", $date);
			return $dates[2]." ".$this->monthName($dates[1])." ".$dates[0];
		}else{
			return " - ";
		}
	}

	public function convertToInputDate($str){
		if(preg_match("/^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/", $str)){
			$date = (date_format(date_create($str),'d/m/Y'));
			$dates = explode("/", $date);
			return $date;
		}else{
			return "";
		}
	}

	public function getSelisihHari($date1,$date2){
	 	$date1 = strtotime($date1);
	 	$date2 = strtotime($date2);
	 	$datediff = $date2 - $date1;
	 	return floor($datediff/(60*60*24));
	}

	public function getSelisihTahun($date1,$date2){
		$diff = abs(strtotime($date2) - strtotime($date1));
		return floor($diff / (365*60*60*24));
	}

	public function convertToMysqlDate($date){
		$re1='((?:(?:[0-2]?\\d{1})|(?:[3][01]{1}))[-:\\/.](?:[0]?[1-9]|[1][012])[-:\\/.](?:(?:[1]{1}\\d{1}\\d{1}\\d{1})|(?:[2]{1}\\d{3})))(?![\\d])';	# DDMMYYYY 1
		if ($c=preg_match_all ("/".$re1."/is", $date, $matches)){
			$myDateTime = DateTime::createFromFormat('d/m/Y', $date);
			return $myDateTime->format('Y-m-d');
		}else{
			return false;
		}
	}
	public function getDayName($date){
		$status = True;
		$re1='((?:(?:[0-2]?\\d{1})|(?:[3][01]{1}))[-:\\/.](?:[0]?[1-9]|[1][012])[-:\\/.](?:(?:[1]{1}\\d{1}\\d{1}\\d{1})|(?:[2]{1}\\d{3})))(?![\\d])';	# DDMMYYYY 1
		if ($c=preg_match_all ("/".$re1."/is", $date, $matches)){
			$myDateTime = DateTime::createFromFormat('d/m/Y', $date);
			$date = $myDateTime->format('Y-m-d');
			$status = True;
			return date('l', strtotime($date));
		}else{
			$status = False;
		}
		$re2='((?:(?:[1]{1}\\d{1}\\d{1}\\d{1})|(?:[2]{1}\\d{3}))[-:\\/.](?:[0]?[1-9]|[1][012])[-:\\/.](?:(?:[0-2]?\\d{1})|(?:[3][01]{1})))(?![\\d])';	# YYYYMMDD 1
		if ($c=preg_match_all ("/".$re2."/is", $date, $matches)){
			$myDateTime = DateTime::createFromFormat('Y-m-d', $date);
			$date = $myDateTime->format('Y-m-d');
			return date('l', strtotime($date));
		}else{
			$status = false;
		}
		if($status == false){
			return 'Error, Date Invalid Format';
		}
		return date('l', strtotime($date));
	}



	function ucname($string) {
    	if (strpos($string, 'I-')!==false) {
    		$explode=explode(' ', $string);
    		foreach ($explode as $key => $value) {
    			if (strpos($value, 'I-')==false) {
    				$explode[$key] =ucwords(strtolower($value));	
    			}
    		}
    		$string=implode(" ",$explode);
    	}else{
    		$string =ucwords(strtolower($string));	
    	}
        

        foreach (array(',','.','-', '\'') as $delimiter) {
          if (strpos($string, $delimiter)!==false) {
          	$string =implode($delimiter, array_map('ucfirst', explode($delimiter, $string)));
          }
        }
        return $string;
    }


    public function namaKota($kota){
		$kotaucfirst = ucfirst($kota);
		$replace = array("PENGADILAN","NEGERI","AGAMA","agama","Agama","Pengadilan","Negeri","Kelas","MILITER","I", "Ia", "Ib","KHUSUS","TATA", "USAHA" ,"NEGARA","1","2","3","4","5","6","7","8","9","0","-");
		$namaKotax = ucfirst(str_replace($replace,"",$kotaucfirst));
		return ltrim($namaKotax);
	}


	

	
}