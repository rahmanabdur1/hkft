<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use App\Models\ReceiptPayableJournal;
use Carbon\Carbon;

class ReceiptPayableJournalController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $index =  ReceiptPayableJournal::all();
        return response()->json($index);

    }

    public function fetchAccountsReceivableByDate(Request $request){
        $startDate = Carbon::createFromFormat('Y-m-d',$request->startDate);
        $endDate = Carbon::createFromFormat('Y-m-d',$request->endDate);
        $index = DB::table('receipt_payable_journals')->select('receipt_payable_journals.*')->whereBetween('receipt_date',[$startDate,$endDate])->get();

        if(count($index) != 0){
            return response()->json($index);
        }else{
            return response()->json(["Empty"=>"There is no purchased journal in this date"]);
        }
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
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
