<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Models\purchased_journal;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class PurchasedJournalController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $index = purchased_journal::all();
        return response()->json($index);
    }
    public function perDatePurchasedVoucher( Request $request){
        $startDate = Carbon::createFromFormat('Y-m-d',$request->startDate);
        $endDate = Carbon::createFromFormat('Y-m-d',$request->endDate);

        $fetchJournal = DB::table('purchased_journals')->select('purchased_journals.*')->whereBetween('payable_date',[$startDate,$endDate])->get();
        if(count($fetchJournal) != 0){
            return response()->json($fetchJournal);
        }else{
            return response()->json(["Empty"=>"There is no purchased journal in this date"]);
        }

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
    }

    /**
     * Display the specified resource.
     */
    public function getByPaymentId($payment_id){
        $index = DB::table('purchased_journals')->select('purchased_journals.*')->where('payment_id',$payment_id)->get();
        return response()->json($index);
    }
    public function getID($payment_id){
        $index = DB::table('payment_vouchers')->select('payment_vouchers.id')->where('payment_id',$payment_id)->first();
        return response()->json($index);
    }
    public function getJournal($id){
        $id_payment_vouchers = DB::table('payment_vouchers')->select('payment_vouchers.*')->where('id',$id)->first();
        $index = DB::table('purchased_journals')->select('purchased_journals.*')->where('payment_id',$id_payment_vouchers->payment_id)->latest('created_at')->first();
        return response()->json($index);
    }

    public function getjournalEdit($id){
        $id_payment_vouchers = DB::table('payment_vouchers')->select('payment_vouchers.*')->where('id',$id)->first();
        $index = DB::table('purchased_journals')->select('purchased_journals.*')->where('payment_id',$id_payment_vouchers->payment_id)->latest('created_at')->first();
        return response()->json($index);

    }
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
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
