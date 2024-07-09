<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use App\Models\ProjectMember;
class ProjectMemberController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $index = ProjectMember::all();
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
        $member = new ProjectMember;
        $member->project = $request->project;
        $member->member_name = $request->member_name;
        $member->phone_no = $request->phone_no;
        $member->deposit_amount = $request->deposit_amount;
        $member->paid_amount = $request->paid_amount;
        $member->due_amount = $request->due_amount;
        $member->extra_amount = $request->extra_amount;
        $member->share_number = $request->share_number;
        $member->save();
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
        $index = ProjectMember::find($id);
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
        $member =  ProjectMember::find($id);
        $member->project = $request->project;
        $member->member_name = $request->member_name;
        $member->phone_no = $request->phone_no;
        $member->deposit_amount = $request->deposit_amount;
        $member->paid_amount = $request->paid_amount;
        $member->due_amount = $request->due_amount;
        $member->extra_amount = $request->extra_amount;
        $member->share_number = $request->share_number;
        $member->save();
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
        DB::table('project_members')->where('id',$id)->delete();
    }
}
