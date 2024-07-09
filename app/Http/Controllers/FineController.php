<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Models\LateFine;
use App\Models\LateFineProject;
use App\Models\LateFineBuilding;
use App\Policies\LateFinePolicy;
use Illuminate\Support\Facades\DB;
class FineController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $data = LateFine::with('project','building')->get();
        return response()->json($data);
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
        $data = $request->all();
        $fine = new LateFine();
        $fine->amount = $request->amount;
        $fine->save();
       
        foreach($request->project_items as $project){            
            $fine->project()->create(['project_name'=>$project['project_name']]);
        }
        foreach($request->building_items as $building){            
            $fine->building()->create(['building_name'=>$building['building_name']]);
        }
        return response()->json($data);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
        $data = LateFine::with('project','building')->find($id);
        return response()->json($data);
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
        $lateFine = LateFine::find($id);
        $lateFine->amount = $request->amount;
         $lateFine->save();
        //project
        $lateFineProjects = DB::table('late_fine_projects')->where('late_fines_id', $id)->pluck('project_name')->toArray();

        // Extract project names from $request->project
        $requestProjectNames = collect($request->project_items)->pluck('project_name')->toArray();
        
        //  Find project names in $lateFineProjects that are not in $requestProjectNames
        $unmatchedNamesDB = array_diff($lateFineProjects, $requestProjectNames);//will delete
        $unmatchedNamesRequest = array_diff($requestProjectNames, $lateFineProjects);//will create
         DB::table('late_fine_projects')->whereIn('project_name',$unmatchedNamesDB)->delete();
        foreach($unmatchedNamesRequest as $project){
           
            $lateFine->project()->create(['project_name'=>$project]);
        }
        //building
        
        $lateFineBuildings = DB::table('late_fine_buildings')->where('late_fines_id', $id)->pluck('building_name')->toArray();

        // Extract project names from $request->project
        $requestBuildingNames = collect($request->building_items)->pluck('building_name')->toArray();
        
        //  Find project names in $lateFineBuildings that are not in $requestBuildingNames
        $unmatchedNamesDBBuilding = array_diff($lateFineBuildings, $requestBuildingNames);//will delete
        $unmatchedNamesRequestBuilding = array_diff($requestBuildingNames, $lateFineBuildings);//will create
         DB::table('late_fine_buildings')->whereIn('building_name',$unmatchedNamesDBBuilding)->delete();
        foreach($unmatchedNamesRequestBuilding as $building){
            $lateFine->building()->create(['building_name'=>$building]);
        }
        return response()->json($unmatchedNamesRequest);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
        Db::table('late_fines')->where('id',$id)->delete();
        Db::table('late_fine_projects')->where('late_fines_id',$id)->delete();
        Db::table('late_fine_buildings')->where('late_fines_id',$id)->delete();

    }
}
