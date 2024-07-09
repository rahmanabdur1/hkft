<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Models\AccountHead;
use Illuminate\Support\Facades\DB;
class AccountHeadController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $head = AccountHead::all();
        return response()->json($head);
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
        $account_head  = new AccountHead;
        $account_head->account_head = $request->account_head;
        $account_head->account_code = $request->account_code;
        $account_head->opening_balance = $request->opening_balance;
        $account_head->type_name= $request->type_name;
        $account_head->save();

    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
        $account_head = AccountHead::find($id);
        return response()->json($account_head);
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
        $account_head = array();
        $account_head['account_code'] = $request->account_code;
        $account_head['account_head'] = $request->account_head;
        $account_head['opening_balance'] = $request->opening_balance;
        $account_head['type_name'] = $request->type_name;
        DB::table('account_heads')->where('id',$id)->update($account_head);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
