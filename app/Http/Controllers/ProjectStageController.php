<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use App\Models\ProjectStage;
class ProjectStageController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
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
        $ProjectStage  = new ProjectStage;
        $ProjectStage->project_id = $request->project_id;
        $ProjectStage->stage = $request->stage;
        $ProjectStage->stage_date = $request->stage_date;
         $ProjectStage->save();
        return response()->json($request);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
        $index = DB::table('project_stages')->where('project_id',$id)->get();
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
        $ProjectStage  = DB::table('project_stages')->where('id',$id)->update(['stage'=>$request->stage,'stage_date'=>$request->stage_date]);
        return response()->json($ProjectStage);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
