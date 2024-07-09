<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use App\Models\Reference;
class ReferenceController extends Controller
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
        $reference = new Reference;
        $reference->reference_name = $request->reference_name;
        $reference->reference_id = $request->reference_id;
        $reference->product_name = $request->product_name;
        $reference->date = $request->date;
        $reference->reference_amount = $request->reference_amount;
        $reference->client_name = $request->client_name;
        $reference->voucher_no = $request->voucher_no;
        $reference->save();
        return response()->json($reference);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
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
        $check = DB::table('references')->where('voucher_no',$request->voucher_no)->first();
        if($check){
            $reference = array();
            $reference['reference_name'] = $request->reference_name;
            $reference['reference_id'] = $request->reference_id;
            $reference['product_name'] = $request->product_name;
            $reference['date'] = $request->date;
            $reference['reference_amount'] = $request->reference_amount;
            $reference['client_name'] = $request->client_name;
            DB::table('references')->where('voucher_no',$request->voucher_no)->update($reference);
        }else{
            $reference = new Reference;
            $reference->reference_name = $request->reference_name;
            $reference->reference_id = $request->reference_id;
            $reference->product_name = $request->product_name;
            $reference->date = $request->date;
            $reference->reference_amount = $request->reference_amount;
            $reference->client_name = $request->client_name;
            $reference->voucher_no = $request->voucher_no;
            $reference->save();
        }


    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
        DB::table('references')->where('id',$id)->delete();
    }
}
