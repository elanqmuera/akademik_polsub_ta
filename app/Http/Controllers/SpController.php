<?php

namespace App\Http\Controllers;

use App\Models\Kelas;
use App\Models\KelasEnroll;
use App\Models\Kehadiran;
use App\Models\Sp;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Session;

class SpController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        if (Auth::guard('orang_tua')->user()) {
            $sp = Sp::where('id_user_penerima',Auth::guard('orang_tua')->user()->id_mahasiswa)
            ->get();
        } else {
            if (auth()->user()->id_role == '2') {
                $rekomen = Kehadiran::all();
                $groupedData = $rekomen->groupBy('id_mahasiswa');

                $rekomendasi = [];
                foreach ($groupedData as $id_mahasiswa => $attendanceRecords) {
                    $sumTerlambat = $attendanceRecords->sum('terlambat');
                    $mahasiswaName = $attendanceRecords->first()->mahasiswa->name;
                
                    $rekomendasi[] = [
                        'mahasiswa' => $mahasiswaName,
                        'sum_terlambat' => $sumTerlambat,
                    ];
                }
                $sp = Sp::all();
                return view('sp.index', compact('sp','rekomendasi'));
            } else if (auth()->user()->id_role == '3') {
                $sp = Sp::join('kelas','sp.id_kelas','=','kelas.id')
                ->where('kelas.id_dosen_wali', auth()->user()->id)
                ->get();
            } else {
                $sp = Sp::where('id_user_penerima', auth()->user()->id)
                ->get();
            }
        }

        return view('sp.index', compact('sp'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $kelas = Kelas::where('id_prodi', auth()->user()->id_prodi)
        ->get();


        $data = array(
            'kelas' => $kelas
        );

        return view('sp.manage', $data);
    }

    public function getMahasiswa($id_kelas)
    {
        $mahasiswa = KelasEnroll::where('id_kelas', $id_kelas)
        ->join('users','kelas_enrolls.id_mahasiswa','=', 'users.id')
        ->get();

        return response()->json(['data' => $mahasiswa]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        try {
            
            $this->validate($request,[
                'id_user_penerima' => ['required'],
                'deskripsi' => ['required'],
                'id_kelas' => ['required'],
                'file' => ['required','file'],
            ]);
    
            $data = $request->except('_token');
            $file = $request->file('file');
    
            $file_name = time(). "_" . $file->getClientOriginalName();
            $file->storeAs('public/sp', $file_name);
    
            $data['file'] = $file_name;
            $data['user_id'] = Auth::user()->id;
            Sp::create($data);
            
            Session::flash('swal', [
                'title' => 'Add Data',
                'text' => 'success',
                'icon' => 'success',
                'timer' => 1500,
                'showConfirmButton' => false,
            ]);
            // For send to dosen wali and orang tua
    
            return redirect('/sp');
        } catch (\Throwable $th) {
            //throw $th;
            Session::flash('swal', [
                'title' => 'Add Data',
                'text' => 'Harap Lengkapi Form',
                'icon' => 'error',
                'timer' => 1500,
                'showConfirmButton' => false,
            ]);

            return redirect()->back();
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Sp  $sp
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Sp  $sp
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $sp = Sp::findorFail($id);
        $kelas = Kelas::where('id_prodi', auth()->user()->id_prodi)
        ->get();

        $data = array(
            'data' => $sp,
            'kelas' => $kelas,
        );

        return view('sp.manage', $data);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Sp  $sp
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        try {
            $this->validate($request,[
                'id_user_penerima' => ['required'],
                'deskripsi' => ['required'],
                'id_kelas' => ['required'],
                // 'file' => ['required','file'],
            ]);
    
            $data = $request->except('_token');
            $file = $request->file('file');
            $sp = Sp::findorFail($id);
    
            if (!empty($file)) {
                $old_path = 'public/sp/'.$sp->file;
                Storage::delete($old_path);
                $file_name = time(). "_" . $file->getClientOriginalName();
                $file->storeAs('public/sp', $file_name);
                $data['file'] = $file_name;
            }
            $data['user_id'] = Auth::user()->id;
    
            $sp->update($data);
    
            Session::flash('swal', [
                'title' => 'Update Data',
                'text' => 'success',
                'icon' => 'success',
                'timer' => 1500,
                'showConfirmButton' => false,
            ]);

            return redirect('/sp');
        } catch (\Throwable $th) {
            //throw $th;
            Session::flash('swal', [
                'title' => 'Update Data',
                'text' => 'Harap Lengkapi Form',
                'icon' => 'error',
                'timer' => 1500,
                'showConfirmButton' => false,
            ]);
            return redirect()->back();
        }

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Sp  $sp
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $sp = Sp::findorFail($id);

        try {
            Session::flash('swal', [
                'title' => 'Delete Data',
                'text' => 'Success',
                'icon' => 'success',
                'timer' => 1500,
                'showConfirmButton' => false,
            ]);
            $sp->delete();
            $path = 'public/sp/'.$sp->file;
            Storage::delete($path);
    
            return redirect('/sp');
        } catch (\Throwable $th) {
            Session::flash('swal', [
                'title' => 'Add Data',
                'text' => 'Pertemuan Sudah Dibuat',
                'icon' => 'error',
                'timer' => 1500,
                'showConfirmButton' => false,
            ]);
            return redirect()->back();
        }

    }
}
