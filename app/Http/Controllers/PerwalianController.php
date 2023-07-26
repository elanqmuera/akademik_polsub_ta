<?php

namespace App\Http\Controllers;

use App\Models\Kelas;
use App\Models\KelasEnroll;
use App\Models\Perwalian;
use App\Models\User;
use Illuminate\Http\Request;

class PerwalianController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        if (auth()->user()->role->role_name == 'dosen') {
            $perwalian = KelasEnroll::whereHas('kelas',function($query){
                $query->where('id_dosen_wali', auth()->user()->id);
            })
            ->get()
            ->groupBy('mahasiswa.name');
            // dd($perwalian);
            return view('perwalian.index', compact('perwalian'));
        } elseif (auth()->user()->role->role_name == 'mahasiswa') {
            $perwalian = KelasEnroll::where('id_mahasiswa', auth()->user()->id)
            ->get();
            return view('perwalian.index2', compact('perwalian'));
        }

    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create($id)
    {
        $id_kelas = $id;
        return view('perwalian.manage', compact('id_kelas'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request, $id)
    {
        if (auth()->user()->role->role_name == 'dosen') {
            $this->validate($request, [
                'keluhan' => ['required']
            ]);
        }

        $data = $request->except('_token');
        $data['id_mahasiswa'] = auth()->user()->id;
        $data['id_kelas'] = $id;

        Perwalian::create($data);

        return redirect()->route('perwalian.show', $id);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $mahasiswa = KelasEnroll::where('id_kelas', $id)
        ->get();

        $perwalian = Perwalian::where('id_kelas', $id)
        ->get();

        $data = array(
            'mahasiswa' => $mahasiswa,
            'perwalian' => $perwalian,
            'id_kelas' => $id,
        );

        return view('perwalian.show', $data);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id_kelas , $id)
    {
        $perwalian = Perwalian::findorFail($id);

        $data = array(
            'data' => $perwalian,
            'id_kelas' => $id_kelas,
        );

        return view('perwalian.manage', $data);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request,$id_kelas ,$id)
    {
        // $this->validate($request, [
        //     'balasan' => ['required']
        // ]);
        $data = $request->except('_token');

        $perwalian = Perwalian::findOrfail($id);

        $perwalian->update($data);

        return redirect()->route('perwalian.show', $id_kelas);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
    
    public function showNew($id_kelas,$id_mahasiswa){
        $perwalian = Perwalian::where('id_kelas',$id_kelas)
        ->where('id_mahasiswa',$id_mahasiswa)
        ->get();

        $id_kelas = $id_kelas;

        return view('perwalian.show',compact('perwalian','id_kelas'));
    }
}
