<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Models\Building;
use Illuminate\Support\Facades\DB;
class BuildingController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $data = Building::all();
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
        $request->validate([
            'project_name'=>'required',
        ],[
            'project_name.required'=>'Please Select Project',
        ]);
        
        $project = explode(' ',$request->project_name);
        $length =count($project);
        $str = "";
        $building_name = "";
        for($i = 0;$i<$length;$i++){
            $str.=ucfirst($project[$i][0]);
        }
        if($request->building_name){
            $building_name = $str."".$request->building_name;
        }else{
            $building_name = $str;
        }
        $project_id = DB::table('projects')->select('id')->where('project_name',$request->project_name)->first();
        $building = new Building;
        $building->building_name = $building_name;
        $building->average_flat_size = $request->average_flat_size;
        $building->building_height = $request->building_height;
        $building->floor_area_size = $request->floor_area_size;
        $building->projects_id = $project_id->id;
        if ($request->hasFile("architact_drawing")) {
            $file = $request->file('architact_drawing');
            $filename = uniqid().$file->getClientOriginalName();
            $file->move(public_path('documents'), $filename); // Move the file to the public/uploads directory

            $building->architact_drawing = 'documents/'.$filename;
        } 
        $building->save();
        return response()->json($building);

    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
        $data = DB::table('buildings')->where('id',$id)->first();
        $project_name = DB::table('projects')->where('id',$data->projects_id)->select('project_name')->first();
        $data->project_name = $project_name->project_name;
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
       
    }

    /**
     * Remove the specified resource from storage.
     */
   
    public function destroy(string $id){
        //
        $data = DB::table('buildings')->where('id',$id)->delete();
        return response()->json($data);
    }
    public function postBuilding(Request $request){
        $request->validate([
            'project_name'=>'required',
        ],[
            'project_name.required'=>'Please Select Project',
        ]);
    
    
        $building = Building::find($request->id);
        $request->validate([
            'project_name'=>'required',
        ],[
            'project_name.required'=>'Please Select Project',
        ]);
        $project = explode(' ',$request->project_name);
        $length =count($project);
        $str = "";
        $building_name = "";
        for($i = 0;$i<$length;$i++){
            $str.=ucfirst($project[$i][0]);
        }
         if(intval($request->building_name)){
            $building_name= $str."".$request->building_name;
        }else{
            $building_name = $str;
        }
        $project_id = DB::table('projects')->select('id')->where('project_name',$request->project_name)->first();        $building->building_name = $building_name;
        $building->average_flat_size = $request->average_flat_size;
        $building->building_height = $request->building_height;
        $building->floor_area_size = $request->floor_area_size;
        $building->projects_id = $project_id->id;
        if ($request->hasFile("architact_drawing")) {
            $file = $request->file('architact_drawing');
            $filename = uniqid().$file->getClientOriginalName();
            $file->move(public_path('documents'), $filename); // Move the file to the public/uploads directory
    
            $building->architact_drawing = 'documents/'.$filename;
        } 
        $building->save();
        return response()->json($request);
    }
}
