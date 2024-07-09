<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Models\ReceiptJournal;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class ReceiptJournalController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $index = ReceiptJournal::all();
        return response()->json($index);
    }
    public function perDateReceiptVoucher( Request $request){
        $startDate = Carbon::createFromFormat('Y-m-d',$request->startDate);
        $endDate = Carbon::createFromFormat('Y-m-d',$request->endDate);
        $fetchJournal = DB::table('receipt_journals')->select('receipt_journals.*')->whereBetween('receipt_date',[$startDate,$endDate])->get();
        if(count($fetchJournal) != 0){
            return response()->json($fetchJournal);
        }else{
            return response()->json(["Empty"=>"There is no receipt journal in this date"]);
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
    public function getByReceiptId($receipt_id){
        $index = DB::table('receipt_journals')->select('receipt_journals.*')->where('receipt_id',$receipt_id)->get();
        return response()->json($index);
    }
    public function getID($receipt_id){
        $index = DB::table('receipt_vouchers')->select('receipt_vouchers.id')->where('receipt_id',$receipt_id)->first();
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
