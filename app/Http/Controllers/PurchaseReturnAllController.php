<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Models\PurchaseReturn;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;

class PurchaseReturnAllController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $type =  PurchaseReturn::all();
        return response()->json($type);
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
        $validator = Validator::make($request->all(), [
            'type_name'=>'required|string|min:4|unique:account_types,type_name',
            'type_status' => 'required',
        ]);
        if($validator->fails()){
            return response()->json($validator->errors()->toJson(),400);
        }
        $type = new AccountType;
        $type->type_name = $request->type_name;
        $type->type_status = $request->type_status;
        $type->save();
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
        $type = AccountType::find($id);
        return response()->json($type);
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
        $type = array();
        $type['type_name'] = $request->type_name;
        $type['type_status'] = $request->type_status;
        $data = DB::table('account_types')->where('id',$id)->update($type);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
