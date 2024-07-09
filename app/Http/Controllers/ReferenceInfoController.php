<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use App\Models\ReferenceBasicInfo;
class ReferenceInfoController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $index = ReferenceBasicInfo::all();
        return response()->json($index);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
        $reference = new ReferenceBasicInfo;
        $reference->reference_name = $request->reference_name;
        $reference->reference_id = $request->reference_id;
        $reference->phone = $request->phone;

        $reference->save();
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
        $index = ReferenceBasicInfo::find($id);
        return response()->json($index);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
        $info = ReferenceBasicInfo::find($id);
        $info->reference_name = $request->reference_name;
        $info->phone = $request->phone;

         $info->save();
        $index =DB::table('references')->where('reference_id',$request->reference_id)->get();
        if($index){
            foreach($index as $ind){
                DB::table('references')->where('reference_id',$request->reference_id)->update(['reference_name'=>$request->reference_name]);
            }
        }
        return response()->json($request);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
