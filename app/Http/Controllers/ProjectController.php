<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Models\Project;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;
use Image;


class ProjectController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $project = Project::all();
        return response()->json($project);
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

        $validator = Validator::make($request->all(), [
            'project_name'=>'required|string|min:4|unique:projects,project_name',
            'project_address' => 'required|string|min:4|max:255',
        ]);
        if($validator->fails()){
            return response()->json($validator->errors()->toJson(),400);
        }
        $project = new Project;
        $project->project_name = $request->project_name;
        $project->project_address= $request->project_address;
        $project->project_status = $request->project_status;

        $project->contact_number = $request->contact_number;
        $project->land_amount= $request->land_amount;
        $project->project_code = $request->project_code;
        if ($request->hasFile("logo")) {
            $file = $request->file('logo');
            $filename = uniqid().$file->getClientOriginalName();
            $file->move(public_path('logo'), $filename); // Move the file to the public/uploads directory

            $project->logo = 'logo/'.$filename;
        } else {
            $project->logo = '';
        }

        if ($request->hasFile("architact_drawing")) {
            $file = $request->file('architact_drawing');
            $filename = uniqid().$file->getClientOriginalName();
            $file->move(public_path('documents'), $filename); // Move the file to the public/uploads directory

            $project->architact_drawing = 'documents/'.$filename;
        } else {
            $project->architact_drawing = '';
        }

        $project->save();
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
        $project = Project::find($id);
        return response()->json($project);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }
    public function updateProject(Request $request){

        $project = Project::find($request->id);
        $project->project_name = $request->project_name;
        $project->project_address= $request->project_address;
        $project->project_status = $request->project_status;

        $project->contact_number = $request->contact_number;
        $project->land_amount= $request->land_amount;
        $project->project_code = $request->project_code;


        if ($request->hasFile("logo")) {
            $file = $request->file('logo');
            $filename = uniqid() . $file->getClientOriginalName();



            $file->move(public_path('logo'), $filename); // Move the file to the public/uploads directory


            //
            $database_doc = DB::table('projects')->where('id', $request->id)->first();
            if ($database_doc->logo != "") {
                $old_doc = public_path($project->logo);

                unlink($old_doc);
                $project->logo = 'logo/' . $filename;
            } else if ($database_doc->logo === "") {

                $project->logo = 'logo/' . $filename;
            }

        } else {
            $database_doc = DB::table('projects')->where('id', $request->id)->first();
            $project->logo = $database_doc->logo;
        }




        if ($request->hasFile("architact_drawing")) {
            $file = $request->file('architact_drawing');
            $filename = uniqid() . $file->getClientOriginalName();
            // $path = $file->storeAs('AdminPanel/Documents/',$filename);
            //test


            $file->move(public_path('documents'), $filename); // Move the file to the public/uploads directory


            //
            $database_doc = DB::table('projects')->where('id', $request->id)->first();
            if ($database_doc->architact_drawing != "") {
                $old_doc = public_path($project->architact_drawing);

                unlink($old_doc);
                $project->architact_drawing = 'documents/' . $filename;
            } else if ($database_doc->architact_drawing === "") {

                $project->architact_drawing = 'documents/' . $filename;
            }

        } else {
            $database_doc = DB::table('projects')->where('id', $request->id)->first();
            $project->architact_drawing = $database_doc->architact_drawing;
        }

        $inventories = DB::table('inventories')->where('property_project',$request->old_project)->get();
        if($inventories){
            foreach($inventories as $inv){
                DB::table('inventories')->where('property_project',$request->old_project)->update(['property_project'=>$request->project_name]);
            }
        }
        $receipt_vouchers = DB::table('receipt_vouchers')->where('selectedProject',$request->old_project)->get();
        if($receipt_vouchers){
            foreach($receipt_vouchers as $inv){
                DB::table('receipt_vouchers')->where('selectedProject',$request->old_project)->update(['selectedProject'=>$request->project_name]);
            }
        }
        $receipt_journals = DB::table('receipt_payable_journals')->where('project',$request->old_project)->get();
        if($receipt_journals){
            foreach($receipt_journals as $inv){
                DB::table('receipt_payable_journals')->where('project',$request->old_project)->update(['project'=>$request->project_name]);
            }
        }
        //member
        $project_members = DB::table('project_members')->where('project',$request->old_project)->get();
        if($project_members){
            foreach($project_members as $inv){
                DB::table('project_members')->where('project',$request->old_project)->update(['project'=>$request->project_name]);
            }
        }

        //manager approve
         //member
         $project_members = DB::table('manager_approves')->where('project',$request->old_project)->get();
         if($project_members){
             foreach($project_members as $inv){
                 DB::table('manager_approves')->where('project',$request->old_project)->update(['project'=>$request->project_name]);
             }
         }
         $project->save();
         DB::table('clients')->where('clientUnderProject',$request->old_project)->update(['clientUnderProject'=>$request->project_name]);
        return response()->json($request);
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
    public function destroy(string $id)
    {
        //
    }
}
