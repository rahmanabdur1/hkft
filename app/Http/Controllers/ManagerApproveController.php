<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use App\Models\ManagerApprove;
class ManagerApproveController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $index = ManagerApprove::all();
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
        $check= DB::table('manager_approves')->where('manager_name',$request->manager_name)->where('project',$request->project)->first();
        if(!$check){
            $manager_approve = new ManagerApprove;
            $manager_approve->manager_name = $request->manager_name;
            $manager_approve->project = $request->project;
            $manager_approve->save();
        }


    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
        $manager_approve =  ManagerApprove::find($id);
       return response()->json($manager_approve);

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
        $manager_approve =  ManagerApprove::find($id);
        $manager_approve->manager_name = $request->manager_name;
        $manager_approve->project = $request->project;
        $manager_approve->save();
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
        DB::table('manager_approves')->where('id',$id)->delete();
    }
}
