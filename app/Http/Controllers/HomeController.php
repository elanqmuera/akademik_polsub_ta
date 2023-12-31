<?php

namespace App\Http\Controllers;

use Auth;
use App\Models\SP;
use App\Models\User;
use App\Models\Jurusan;
use App\Models\Kehadiran;
use App\Models\Perwalian;
use App\Models\DaftarNilai;
use App\Models\ProgramStudi;
use App\Models\MataKuliahEnroll;
use App\Models\MahasiswaMataKuliahEnroll;
use Illuminate\Http\Request;

class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        // $this->middleware('auth');
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    public function index()
    {
        $data = [];
        if(!Auth::guard('orang_tua')->user()){
            if(Auth::user()->role->role_name == 'admin polsub'){
                $jurusan = Jurusan::count();
                $prodi = ProgramStudi::count();
        
                $data = array(
                    'jurusan' => $jurusan,
                    'prodi' => $prodi,
                );
            }elseif (Auth::user()->role->role_name == 'mahasiswa') {
                $sp = Sp::where('id_user_penerima',Auth::user()->id)->count();
                $sakit = Kehadiran::where('status','sakit')->where('id_mahasiswa',Auth::user()->id)->count();
                $izin = Kehadiran::where('status','ijin')->where('id_mahasiswa',Auth::user()->id)->count();
                $tidak_hadir = Kehadiran::where('status','tanpa keterangan')->where('id_mahasiswa',Auth::user()->id)->count();
                $terlambat = Kehadiran::where('id_mahasiswa',Auth::user()->id)->pluck('terlambat')->sum();
                $perwalian = Perwalian::where('id_mahasiswa',Auth::user()->id)->latest()->first();
                if($perwalian != []){
                    $perwalian = $perwalian['created_at']->format('Y-m-d');
                }else{
                    $perwalian = '-';
                }
    
                // GET IPK
                $daftarNilai = DaftarNilai::with('mataKuliah','kelas','nilai','tahunAjaran')
                    ->whereHas('nilai',function($query){
                        $query->where('id_mahasiswa',Auth::user()->id);
                    })
                    ->latest()
                    ->get()
                    ->groupBy(['mataKuliah.nama_mata_kuliah', 'kategori_tugas']);
                
                $data = [];
                foreach ($daftarNilai as $num => $nilai) {
                    $totalSKS = 0;
                    $nilaiuts = 0;
                    $nilaitugas = 0;
                    $nilaiuas = 0;
                    $sigmaNilai = 0;
                    $ungroupedData = $nilai->flatten();
                    $firstData = $ungroupedData->first();
                    $kodeMatkul = $firstData->mataKuliah->kode_mata_kuliah;
                    $namaMatkul = $firstData->mataKuliah->nama_mata_kuliah;
                    $allData = $ungroupedData->where('id_mata_kuliah',$firstData->mataKuliah->id)->where('id_kelas',$firstData->kelas->id);
                    $semester = $firstData->tahunAjaran->semester;
                    $totalSKS = $firstData->mataKuliah->sks;
    
                    if(!empty($nilai['UTS'])){
                        foreach ($allData->where('kategori_tugas','UTS') as $index => $uts) {
                            if(count($uts->nilai) > 0){
                                $nilaiuts += $uts->nilai[0]->nilai;
                            }else{
                                $nilaiuts += 0;
                            }
                        }
                    }
                    if(!empty($nilai['UAS'])){
                        foreach ($allData->where('kategori_tugas','UAS') as $index => $uas) {
                            if(count($uas->nilai) > 0){
                                $nilaiuas += $uas->nilai[0]->nilai;
                            }else{
                                $nilaiuas += 0;
                            }
                        }
                    }
                    if(!empty($nilai['nilai lain lain'])){
                        foreach ($allData->where('kategori_tugas','nilai lain lain') as $index => $tugas) {
                            if(count($tugas->nilai) > 0){
                                $nilaitugas += $tugas->nilai[0]->nilai;
                            }else{
                                $nilaitugas += 0;
                            }
                        }
                        // $nilaitugas = $nilaitugas / count($nilai['tugas/kuis']);
                    }
                    $nilaiTotal = $nilaitugas*0.3 + $nilaiuts*0.3 + $nilaiuas*0.4;
                    $resultAngkaNilaiTotal = $nilaiTotal;
                    if($nilaiTotal >= 85){
                        $nilaiTotal = 4;
                    }elseif($nilaiTotal >= 78){
                        $nilaiTotal = 3.5;
                    }elseif($nilaiTotal >= 70){
                        $nilaiTotal = 3;
                    }elseif($nilaiTotal >= 63){
                        $nilaiTotal = 2.5;
                    }elseif($nilaiTotal >= 55){
                        $nilaiTotal = 2;
                    }elseif($nilaiTotal >= 40){
                        $nilaiTotal = 1;
                    }elseif($nilaiTotal < 40){
                        $nilaiTotal = 0;
                    }
                    
                    $sigmaNilai += $totalSKS * $nilaiTotal;
                    $rataRata = $sigmaNilai / $totalSKS;
                    $resultAngkaRataRata = $rataRata;
                    if($rataRata == 4){
                        $rataRata = 'A';
                    }elseif($rataRata >= 3.5){
                        $rataRata = 'AB';
                    }elseif($rataRata >= 3){
                        $rataRata = 'B';
                    }elseif($rataRata >= 2.5){
                        $rataRata = 'C+';
                    }elseif($rataRata >= 2){
                        $rataRata = 'C';
                    }elseif($rataRata >= 1){
                        $rataRata = 'D';
                    }elseif($rataRata < 1){
                        $rataRata = 'E';
                    }
                    $resultRataRata =  $rataRata;
                    $nilaiAngka = $sigmaNilai / $totalSKS;
    
                    // IPS
                    // dd($resultAngkaNilaiTotal);
                    $data[] = array(
                        'kodeMataKuliah' => $kodeMatkul,
                        'namaMataKuliah' => $namaMatkul,
                        'semester' => $semester,
                        'totalSKS' => $totalSKS,
                        'nilaiAngka' => $nilaiAngka,
                        'nilaiRataRata' => $resultRataRata,
                        'nilaiAngkaNilaiTotal' => $resultAngkaNilaiTotal,
                        'sigmaNilai' => $sigmaNilai,
                        'totalSKS' => $totalSKS,
                    );
                }
    
                $allSKS = 0;
                $poin = 0;
                $ipk = 0;
                foreach ($data as $key => $value) {
                    $allSKS += $value['totalSKS'];
                    $poin += $value['sigmaNilai'];
                }
                
                if($poin != 0 && $allSKS != 0){
                    $ipk = number_format($poin / $allSKS, 2, '.', '');
                }
    
                // GET SEMESTER
    
                $getSemester = MahasiswaMatakuliahEnroll::with('mataKuliahEnroll.mataKuliah')->where('id_mahasiswa',Auth::user()->id)
                ->whereHas('matakuliahEnroll.mataKuliah',function($query){
                    $query->orderBy('semester','desc');
                })
                ->latest()
                ->first();
    
                $daftarNilais = DaftarNilai::with('mataKuliah','kelas','nilai','tahunAjaran')
                ->whereHas('nilai',function($query){
                    $query->where('id_mahasiswa',Auth::user()->id);
                })
                ->whereHas('tahunAjaran',function($query) use ($getSemester){
                    $query->where('semester',$getSemester->mataKuliahEnroll->mataKuliah->semester);
                })
                ->latest()
                ->get()
                ->groupBy(['mataKuliah.nama_mata_kuliah', 'kategori_tugas']);
                $datas = [];
                foreach ($daftarNilais as $num => $nilai) {
                    $totalSKS = 0;
                    $nilaiuts = 0;
                    $nilaitugas = 0;
                    $nilaiuas = 0;
                    $sigmaNilai = 0;
                    $ungroupedData = $nilai->flatten();
                    $firstData = $ungroupedData->first();
                    $kodeMatkul = $firstData->mataKuliah->kode_mata_kuliah;
                    $namaMatkul = $firstData->mataKuliah->nama_mata_kuliah;
                    $allData = $ungroupedData->where('id_mata_kuliah',$firstData->mataKuliah->id)->where('id_kelas',$firstData->kelas->id);
                    $semester = $firstData->tahunAjaran->semester;
                    $totalSKS = $firstData->mataKuliah->sks;
    
                    if(!empty($nilai['UTS'])){
                        foreach ($allData->where('kategori_tugas','UTS') as $index => $uts) {
                            if(count($uts->nilai) > 0){
                                $nilaiuts += $uts->nilai[0]->nilai;
                            }else{
                                $nilaiuts += 0;
                            }
                        }
                    }
                    if(!empty($nilai['UAS'])){
                        foreach ($allData->where('kategori_tugas','UAS') as $index => $uas) {
                            if(count($uas->nilai) > 0){
                                $nilaiuas += $uas->nilai[0]->nilai;
                            }else{
                                $nilaiuas += 0;
                            }
                        }
                    }
                    if(!empty($nilai['nilai lain lain'])){
                        foreach ($allData->where('kategori_tugas','nilai lain lain') as $index => $tugas) {
                            if(count($tugas->nilai) > 0){
                                $nilaitugas += $tugas->nilai[0]->nilai;
                            }else{
                                $nilaitugas += 0;
                            }
                        }
                        // $nilaitugas = $nilaitugas / count($nilai['tugas/kuis']);
                    }
                    $nilaiTotal = $nilaitugas*0.3 + $nilaiuts*0.3 + $nilaiuas*0.4;
                    $resultAngkaNilaiTotal = $nilaiTotal;
                    if($nilaiTotal >= 85){
                        $nilaiTotal = 4;
                    }elseif($nilaiTotal >= 78){
                        $nilaiTotal = 3.5;
                    }elseif($nilaiTotal >= 70){
                        $nilaiTotal = 3;
                    }elseif($nilaiTotal >= 63){
                        $nilaiTotal = 2.5;
                    }elseif($nilaiTotal >= 55){
                        $nilaiTotal = 2;
                    }elseif($nilaiTotal >= 40){
                        $nilaiTotal = 1;
                    }elseif($nilaiTotal < 40){
                        $nilaiTotal = 0;
                    }
                    
                    $sigmaNilai += $totalSKS * $nilaiTotal;
                    $rataRata = $sigmaNilai / $totalSKS;
                    $resultAngkaRataRata = $rataRata;
                    if($rataRata == 4){
                        $rataRata = 'A';
                    }elseif($rataRata >= 3.5){
                        $rataRata = 'AB';
                    }elseif($rataRata >= 3){
                        $rataRata = 'B';
                    }elseif($rataRata >= 2.5){
                        $rataRata = 'C+';
                    }elseif($rataRata >= 2){
                        $rataRata = 'C';
                    }elseif($rataRata >= 1){
                        $rataRata = 'D';
                    }elseif($rataRata < 1){
                        $rataRata = 'E';
                    }
                    $resultRataRata =  $rataRata;
                    $nilaiAngka = $sigmaNilai / $totalSKS;
    
                    // IPS
                    // dd($resultAngkaNilaiTotal);
                    $datas[] = array(
                        'kodeMataKuliah' => $kodeMatkul,
                        'namaMataKuliah' => $namaMatkul,
                        'semester' => $semester,
                        'totalSKS' => $totalSKS,
                        'nilaiAngka' => $nilaiAngka,
                        'nilaiRataRata' => $resultRataRata,
                        'nilaiAngkaNilaiTotal' => $resultAngkaNilaiTotal,
                        'sigmaNilai' => $sigmaNilai,
                        'totalSKS' => $totalSKS,
                    );
                }
    
                $allSKSIPS = 0;
                $poins = 0;
                $ips = 0;
                foreach ($datas as $key => $value) {
                    $allSKSIPS += $value['totalSKS'];
                    $poins += $value['sigmaNilai'];
                }
                
                if($poins != 0 && $allSKSIPS != 0){
                    $ips = number_format($poins / $allSKSIPS, 2, '.', '');
                }
                
                $data = array(
                    'sp' => $sp,
                    'sakit' => $sakit,
                    'izin' => $izin,
                    'tidak_hadir' => $tidak_hadir,
                    'terlambat' => $terlambat,
                    'perwalian' => $perwalian,
                    'ipk' => $ipk,
                    'ips' => $ips,
                    'semester' => $getSemester
                );
            }elseif (Auth::user()->role->role_name == 'dosen') {
                $matkul = MataKuliahEnroll::where('id_dosen',Auth::user()->id)->count();
                $sp = SP::whereHas('kelas',function($query){
                    $query->where('id_dosen_wali',Auth::user()->id);
                })
                ->count();
                $unactive = User::where('id_role',4)
                ->where('status','tidak aktif')
                ->where('id_prodi',Auth::user()->id_prodi)
                ->count();
                $active = User::whereHas('role',function($query){
                    $query->where('role_name','mahasiswa'); 
                 })
                ->where('status','aktif')
                ->where('id_prodi',Auth::user()->id_prodi)
                ->count();
                
                $data = array(
                    'matkul' => $matkul,
                    'sp' => $sp,
                    'active' => $active,
                    'unactive' => $unactive
                );
            }else if(Auth::user()->role->role_name == 'admin jurusan'){
                $sp = Sp::where('user_id',Auth::user()->id)->count();
                $unactive = User::whereHas('role',function($query){
                   $query->where('role_name','mahasiswa'); 
                })
                ->where('status','tidak aktif')
                ->where('id_prodi',Auth::user()->id_prodi)
                ->count();
                $data = array(
                    'sp' => $sp,
                    'unactive' => $unactive
                );
            }
        }else{
            
        }

        return view('home',$data);
    }
}
